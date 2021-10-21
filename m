Content-Type: multipart/mixed; boundary="===============6130961107217665030=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 11/12] agent: Implement the NetworkConfigurationAgent dbus API
Date: Thu, 21 Oct 2021 10:50:40 +0200
Message-ID: <20211021085041.294524-11-andrew.zaborowski@intel.com>
In-Reply-To: 20211021085041.294524-1-andrew.zaborowski@intel.com

--===============6130961107217665030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/agent.c     | 337 ++++++++++++++++++++++++++++++++++++++++++++----
 src/agent.h     |  11 ++
 src/dbus.h      |   2 +
 src/netconfig.h |  15 +++
 4 files changed, 343 insertions(+), 22 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index 6fe4507d..eacecfd5 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -25,15 +25,22 @@
 #endif
 =

 #include <errno.h>
+#include <arpa/inet.h>
 =

 #include <ell/ell.h>
 #include "src/dbus.h"
 #include "src/agent.h"
 #include "src/iwd.h"
 #include "src/module.h"
+#include "src/netconfig.h"
 =

 static unsigned int next_request_id =3D 0;
 =

+enum agent_type {
+	AGENT_TYPE_SECRET,
+	AGENT_TYPE_NETCONFIG,
+};
+
 enum agent_request_type {
 	AGENT_REQUEST_TYPE_PASSPHRASE,
 	AGENT_REQUEST_TYPE_USER_NAME_PASSWD,
@@ -50,6 +57,18 @@ struct agent_request {
 	agent_request_destroy_func_t destroy;
 };
 =

+/* Netconfig requests are not queued and can run in parallel */
+struct netconfig_request {
+	unsigned int dbus_id;
+	unsigned int id;
+	char *path;
+	char *ifname;
+	struct l_timeout *timeout;
+	void *user_data;
+	void *user_callback;
+	agent_request_destroy_func_t destroy;
+};
+
 struct agent {
 	char *owner;
 	char *path;
@@ -58,9 +77,11 @@ struct agent {
 	struct l_timeout *timeout;
 	int timeout_secs;
 	struct l_queue *requests;
+	enum agent_type type;
 };
 =

-static struct l_queue *agents;
+static struct l_queue *secret_agents;
+static struct agent *netconfig_agent;
 =

 /*
  * How long we wait for user to input things.
@@ -74,7 +95,8 @@ static unsigned int agent_timeout_input_request(void)
 	return 120;
 }
 =

-static void send_cancel_request(void *user_data, int reason)
+static void send_cancel_request(void *user_data, int reason,
+				const char *path, const char *ifname)
 {
 	struct agent *agent =3D user_data;
 	struct l_dbus_message *message;
@@ -106,7 +128,12 @@ static void send_cancel_request(void *user_data, int r=
eason)
 							IWD_AGENT_INTERFACE,
 							"Cancel");
 =

-	l_dbus_message_set_arguments(message, "s", reasonstr);
+	if (path)
+		l_dbus_message_set_arguments(message, "oss", path, ifname,
+						reasonstr);
+	else
+		l_dbus_message_set_arguments(message, "s", reasonstr);
+
 	l_dbus_message_set_no_reply(message, true);
 =

 	l_dbus_send(dbus_get_bus(), message);
@@ -128,6 +155,20 @@ static void agent_request_free(void *user_data)
 	l_free(request);
 }
 =

+static void netconfig_request_free(void *user_data)
+{
+	struct netconfig_request *request =3D user_data;
+
+	if (request->destroy)
+		request->destroy(request->user_data);
+
+	l_timeout_remove(request->timeout);
+	l_dbus_cancel(dbus_get_bus(), request->dbus_id);
+	l_free(request->path);
+	l_free(request->ifname);
+	l_free(request);
+}
+
 static void passphrase_reply(struct l_dbus_message *reply,
 					struct agent_request *request)
 {
@@ -212,7 +253,10 @@ static void agent_free(void *data)
 	if (agent->pending_id)
 		l_dbus_cancel(dbus_get_bus(), agent->pending_id);
 =

-	l_queue_destroy(agent->requests, agent_request_free);
+	if (agent->type =3D=3D AGENT_TYPE_SECRET)
+		l_queue_destroy(agent->requests, agent_request_free);
+	else
+		l_queue_destroy(agent->requests, netconfig_request_free);
 =

 	if (agent->disconnect_watch)
 		l_dbus_remove_watch(dbus_get_bus(), agent->disconnect_watch);
@@ -230,7 +274,7 @@ static void request_timeout(struct l_timeout *timeout, =
void *user_data)
 =

 	l_dbus_cancel(dbus_get_bus(), agent->pending_id);
 =

-	send_cancel_request(agent, -ETIMEDOUT);
+	send_cancel_request(agent, -ETIMEDOUT, NULL, NULL);
 =

 	agent_finalize_pending(agent, NULL);
 =

@@ -313,7 +357,8 @@ static struct agent *agent_lookup(const char *owner)
 	if (!owner)
 		return NULL;
 =

-	for (entry =3D l_queue_get_entries(agents); entry; entry =3D entry->next)=
 {
+	for (entry =3D l_queue_get_entries(secret_agents); entry;
+			entry =3D entry->next) {
 		struct agent *agent =3D entry->data;
 =

 		if (strcmp(agent->owner, owner))
@@ -332,7 +377,7 @@ static struct agent *get_agent(const char *owner)
 	if (agent)
 		return agent;
 =

-	return l_queue_peek_head(agents);
+	return l_queue_peek_head(secret_agents);
 }
 =

 /**
@@ -347,7 +392,7 @@ static struct agent *get_agent(const char *owner)
  * id that can be used to cancel the request.
  *
  * If @trigger is not NULL, then a reference is taken automatically.  If
- * agent_cancel_request is called subsequently, a dbus_aborted error is
+ * agent_request_cancel is called subsequently, a dbus_aborted error is
  * automatically generated for @trigger.  Otherwise, after @callback is
  * called, the reference to @trigger is dropped.  It is assumed that the
  * caller will take ownership of @trigger in the callback if needed.
@@ -456,6 +501,156 @@ unsigned int agent_request_user_password(const char *=
path, const char *user,
 					callback, trigger, user_data, destroy);
 }
 =

+static void netconfig_data_to_dict(const struct netconfig_data *data,
+					struct l_dbus_message_builder *builder)
+{
+	const char *ip_method_str =3D data->method =3D=3D NETCONFIG_METHOD_STATIC=
 ?
+		"static" : "auto";
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	dbus_append_dict_basic(builder, "Method", 's', ip_method_str);
+	dbus_append_dict_basic(builder, "Address", 's', data->addr);
+	dbus_append_dict_basic(builder, "PrefixLength", 'y', &data->prefix_len);
+
+	if (data->gateway_addr)
+		dbus_append_dict_basic(builder, "Gateway", 's',
+					data->gateway_addr);
+
+	if (data->dns) {
+		char **str;
+
+		l_dbus_message_builder_enter_dict(builder, "sv");
+		l_dbus_message_builder_append_basic(builder, 's',
+							"DomainNameServers");
+		l_dbus_message_builder_enter_variant(builder, "as");
+		l_dbus_message_builder_enter_array(builder, "s");
+
+		for (str =3D data->dns; *str; str++)
+			l_dbus_message_builder_append_basic(builder, 's', str);
+
+		l_dbus_message_builder_leave_array(builder);
+		l_dbus_message_builder_leave_variant(builder);
+		l_dbus_message_builder_leave_dict(builder);
+	}
+
+	if (data->domain_names) {
+		char **str;
+
+		l_dbus_message_builder_enter_dict(builder, "sv");
+		l_dbus_message_builder_append_basic(builder, 's',
+							"DomainNames");
+		l_dbus_message_builder_enter_variant(builder, "as");
+		l_dbus_message_builder_enter_array(builder, "s");
+
+		for (str =3D data->domain_names; *str; str++)
+			l_dbus_message_builder_append_basic(builder, 's', str);
+
+		l_dbus_message_builder_leave_array(builder);
+		l_dbus_message_builder_leave_variant(builder);
+		l_dbus_message_builder_leave_dict(builder);
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+}
+
+static void netconfig_timeout_cb(struct l_timeout *timeout, void *user_dat=
a)
+{
+	struct netconfig_request *request =3D user_data;
+	agent_request_netconfig_func_t user_callback =3D request->user_callback;
+
+	l_debug("path %s ifname %s", request->path, request->ifname);
+
+	l_queue_remove(netconfig_agent->requests, request);
+
+	send_cancel_request(netconfig_agent, -ETIMEDOUT,
+				request->path, request->ifname);
+
+	user_callback(request->id, AGENT_RESULT_FAILED, request->user_data);
+	netconfig_request_free(request);
+}
+
+static void netconfig_reply_cb(struct l_dbus_message *message,
+				void *user_data)
+{
+	struct netconfig_request *request =3D user_data;
+	agent_request_netconfig_func_t user_callback =3D request->user_callback;
+	const char *error, *text;
+	enum agent_result result =3D AGENT_RESULT_OK;
+
+	l_debug("path %s ifname %s", request->path, request->ifname);
+
+	request->dbus_id =3D 0;
+	l_queue_remove(netconfig_agent->requests, request);
+
+	if (l_dbus_message_get_error(message, &error, &text)) {
+		if (!strcmp(error, "net.connman.iwd.Agent.Error.Canceled"))
+			result =3D AGENT_RESULT_CANCELLED;
+		else
+			result =3D AGENT_RESULT_FAILED;
+	} else if (!l_dbus_message_get_arguments(message, ""))
+		result =3D AGENT_RESULT_FAILED;
+
+	user_callback(request->id, result, request->user_data);
+	netconfig_request_free(request);
+}
+
+unsigned int agent_request_netconfig(const char *path, const char *ifname,
+				const struct netconfig_data *data,
+				agent_request_netconfig_func_t callback,
+				void *user_data,
+				agent_request_destroy_func_t destroy)
+{
+	struct l_dbus_message *message;
+	struct l_dbus_message_builder *builder;
+	struct netconfig_request *request;
+	unsigned int dbus_id;
+	const char *method_name;
+
+	l_debug("path %s ifname %s", path, ifname);
+
+	if (!netconfig_agent || !callback)
+		return 0;
+
+	method_name =3D data->family =3D=3D AF_INET ? "ConfigureIPv4" : "Configur=
eIPv6";
+	message =3D l_dbus_message_new_method_call(dbus_get_bus(),
+						netconfig_agent->owner,
+						netconfig_agent->path,
+						IWD_NETCONFIG_AGENT_INTERFACE,
+						method_name);
+
+	builder =3D l_dbus_message_builder_new(message);
+	l_dbus_message_builder_append_basic(builder, 'o', path);
+	l_dbus_message_builder_append_basic(builder, 's', ifname);
+	netconfig_data_to_dict(data, builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	request =3D l_new(struct netconfig_request, 1);
+
+	dbus_id =3D l_dbus_send_with_reply(dbus_get_bus(), message,
+						netconfig_reply_cb,
+						request, NULL);
+	if (!dbus_id) {
+		l_error("l_dbus_send_with_reply failed");
+		l_dbus_message_unref(message);
+		l_free(request);
+		return 0;
+	}
+
+	request->dbus_id =3D dbus_id;
+	request->id =3D ++next_request_id;
+	request->path =3D l_strdup(path);
+	request->ifname =3D l_strdup(ifname);
+	request->timeout =3D l_timeout_create(5, netconfig_timeout_cb,
+						request, NULL);
+	request->user_data =3D user_data;
+	request->user_callback =3D callback;
+	request->destroy =3D destroy;
+
+	l_queue_push_tail(netconfig_agent->requests, request);
+	return request->id;
+}
+
 static bool find_request(const void *a, const void *b)
 {
 	const struct agent_request *request =3D a;
@@ -464,13 +659,22 @@ static bool find_request(const void *a, const void *b)
 	return request->id =3D=3D id;
 }
 =

+static bool find_netconfig_request(const void *a, const void *b)
+{
+	const struct netconfig_request *request =3D a;
+	unsigned int id =3D L_PTR_TO_UINT(b);
+
+	return request->id =3D=3D id;
+}
+
 bool agent_request_cancel(unsigned int req_id, int reason)
 {
 	struct agent_request *request =3D NULL;
 	struct agent *agent;
 	const struct l_queue_entry *entry;
 =

-	for (entry =3D l_queue_get_entries(agents); entry; entry =3D entry->next)=
 {
+	for (entry =3D l_queue_get_entries(secret_agents); entry;
+			entry =3D entry->next) {
 		agent =3D entry->data;
 =

 		request =3D l_queue_remove_if(agent->requests, find_request,
@@ -479,11 +683,27 @@ bool agent_request_cancel(unsigned int req_id, int re=
ason)
 			break;
 	}
 =

-	if (!request)
-		return false;
+	if (!request) {
+		struct netconfig_request *nc_request;
+
+		if (!netconfig_agent)
+			return false;
+
+		nc_request =3D l_queue_remove_if(netconfig_agent->requests,
+						find_netconfig_request,
+						L_UINT_TO_PTR(req_id));
+		if (!nc_request)
+			return false;
+
+		send_cancel_request(netconfig_agent, reason,
+					nc_request->path, nc_request->ifname);
+
+		netconfig_request_free(nc_request);
+		return true;
+	}
 =

 	if (!request->message) {
-		send_cancel_request(agent, reason);
+		send_cancel_request(agent, reason, NULL, NULL);
 =

 		l_dbus_cancel(dbus_get_bus(), agent->pending_id);
 =

@@ -511,18 +731,19 @@ static void agent_disconnect(struct l_dbus *dbus, voi=
d *user_data)
 	if (agent->pending_id)
 		agent_finalize_pending(agent, NULL);
 =

-	l_queue_remove(agents, agent);
+	l_queue_remove(secret_agents, agent);
 =

 	l_idle_oneshot(agent_free, agent, NULL);
 }
 =

-static struct agent *agent_create(struct l_dbus *dbus, const char *name,
-							const char *path)
+static struct agent *agent_create(struct l_dbus *dbus, enum agent_type typ=
e,
+					const char *name, const char *path)
 {
 	struct agent *agent;
 =

 	agent =3D l_new(struct agent, 1);
 =

+	agent->type =3D type;
 	agent->owner =3D l_strdup(name);
 	agent->path =3D l_strdup(path);
 	agent->requests =3D l_queue_new();
@@ -548,11 +769,12 @@ static struct l_dbus_message *agent_register(struct l=
_dbus *dbus,
 	if (!l_dbus_message_get_arguments(message, "o", &path))
 		return dbus_error_invalid_args(message);
 =

-	agent =3D agent_create(dbus, l_dbus_message_get_sender(message), path);
+	agent =3D agent_create(dbus, AGENT_TYPE_SECRET,
+				l_dbus_message_get_sender(message), path);
 	if (!agent)
 		return dbus_error_failed(message);
 =

-	l_queue_push_tail(agents, agent);
+	l_queue_push_tail(secret_agents, agent);
 =

 	l_debug("agent %s path %s", agent->owner, agent->path);
 =

@@ -575,7 +797,7 @@ static struct l_dbus_message *agent_unregister(struct l=
_dbus *dbus,
 	if (!agent)
 		return dbus_error_not_found(message);
 =

-	l_queue_remove(agents, agent);
+	l_queue_remove(secret_agents, agent);
 =

 	agent_free(agent);
 =

@@ -586,6 +808,64 @@ static struct l_dbus_message *agent_unregister(struct =
l_dbus *dbus,
 	return reply;
 }
 =

+static struct l_dbus_message *netconfig_agent_register(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct l_dbus_message *reply;
+	const char *path;
+
+	l_debug("");
+
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return dbus_error_invalid_args(message);
+
+	if (!netconfig_get_enabled())
+		return dbus_error_not_supported(message);
+
+	if (netconfig_agent)
+		return dbus_error_already_exists(message);
+
+	netconfig_agent =3D agent_create(dbus, AGENT_TYPE_NETCONFIG,
+					l_dbus_message_get_sender(message),
+					path);
+	if (!netconfig_agent)
+		return dbus_error_failed(message);
+
+	l_debug("agent %s path %s",
+		netconfig_agent->owner, netconfig_agent->path);
+
+	reply =3D l_dbus_message_new_method_return(message);
+	l_dbus_message_set_arguments(reply, "");
+	return reply;
+}
+
+static struct l_dbus_message *netconfig_agent_unregister(struct l_dbus *db=
us,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct l_dbus_message *reply;
+	const char *path;
+
+	l_debug("");
+
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return dbus_error_invalid_args(message);
+
+	if (!netconfig_agent || strcmp(netconfig_agent->path, path))
+		return dbus_error_not_found(message);
+
+	if (strcmp(netconfig_agent->owner, l_dbus_message_get_sender(message)))
+		return dbus_error_not_available(message);
+
+	agent_free(netconfig_agent);
+	netconfig_agent =3D NULL;
+
+	reply =3D l_dbus_message_new_method_return(message);
+	l_dbus_message_set_arguments(reply, "");
+	return reply;
+}
+
 static void setup_agent_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "RegisterAgent", 0,
@@ -594,6 +874,13 @@ static void setup_agent_interface(struct l_dbus_interf=
ace *interface)
 	l_dbus_interface_method(interface, "UnregisterAgent", 0,
 				agent_unregister,
 				"", "o", "path");
+
+	l_dbus_interface_method(interface,
+				"RegisterNetworkConfigurationAgent", 0,
+				netconfig_agent_register, "", "o", "path");
+	l_dbus_interface_method(interface,
+				"UnregisterNetworkConfigurationAgent", 0,
+				netconfig_agent_unregister, "", "o", "path");
 }
 =

 static bool release_agent(void *data, void *user_data)
@@ -622,7 +909,7 @@ static int agent_init(void)
 {
 	struct l_dbus *dbus =3D dbus_get_bus();
 =

-	agents =3D l_queue_new();
+	secret_agents =3D l_queue_new();
 =

 	if (!l_dbus_register_interface(dbus, IWD_AGENT_MANAGER_INTERFACE,
 						setup_agent_interface,
@@ -650,13 +937,19 @@ static void agent_exit(void)
 =

 	l_dbus_unregister_interface(dbus, IWD_AGENT_MANAGER_INTERFACE);
 =

-	l_queue_destroy(agents, agent_free);
-	agents =3D NULL;
+	l_queue_destroy(secret_agents, agent_free);
+	secret_agents =3D NULL;
+
+	if (netconfig_agent)
+		agent_free(l_steal_ptr(netconfig_agent));
 }
 =

 void agent_shutdown(void)
 {
-	l_queue_foreach_remove(agents, release_agent, NULL);
+	l_queue_foreach_remove(secret_agents, release_agent, NULL);
+
+	if (netconfig_agent)
+		release_agent(l_steal_ptr(netconfig_agent), NULL);
 }
 =

 IWD_MODULE(agent, agent_init, agent_exit);
diff --git a/src/agent.h b/src/agent.h
index eb08c6b6..83625618 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -25,8 +25,11 @@
 enum agent_result {
 	AGENT_RESULT_OK,
 	AGENT_RESULT_FAILED,
+	AGENT_RESULT_CANCELLED,
 };
 =

+struct netconfig_data;
+
 typedef void (*agent_request_passphrase_func_t) (enum agent_result result,
 					const char *passphrase,
 					struct l_dbus_message *message,
@@ -35,6 +38,9 @@ typedef void (*agent_request_user_name_passwd_func_t) (en=
um agent_result result,
 					const char *user, const char *password,
 					struct l_dbus_message *message,
 					void *user_data);
+typedef void (*agent_request_netconfig_func_t) (unsigned int id,
+						enum agent_result result,
+						void *user_data);
 typedef void (*agent_request_destroy_func_t)(void *user_data);
 =

 void agent_shutdown(void);
@@ -58,4 +64,9 @@ unsigned int agent_request_user_password(const char *path=
, const char *user,
 				agent_request_passphrase_func_t callback,
 				struct l_dbus_message *trigger, void *user_data,
 				agent_request_destroy_func_t destroy);
+unsigned int agent_request_netconfig(const char *path, const char *ifname,
+				const struct netconfig_data *data,
+				agent_request_netconfig_func_t callback,
+				void *user_data,
+				agent_request_destroy_func_t destroy);
 bool agent_request_cancel(unsigned int req_id, int reason);
diff --git a/src/dbus.h b/src/dbus.h
index 7703b37f..814b006b 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -43,6 +43,8 @@
 #define IWD_STATION_DIAGNOSTIC_INTERFACE "net.connman.iwd.StationDiagnosti=
c"
 #define IWD_AP_DIAGNOSTIC_INTERFACE "net.connman.iwd.AccessPointDiagnostic"
 #define IWD_STATION_DEBUG_INTERFACE "net.connman.iwd.StationDebug"
+#define IWD_NETCONFIG_AGENT_INTERFACE \
+	"net.connman.iwd.NetworkConfigurationAgent"
 =

 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
diff --git a/src/netconfig.h b/src/netconfig.h
index 9d5887e9..2f152b45 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -28,6 +28,21 @@ enum netconfig_event {
 	NETCONFIG_EVENT_CONNECTED,
 };
 =

+enum netconfig_method {
+	NETCONFIG_METHOD_STATIC,
+	NETCONFIG_METHOD_AUTO,
+};
+
+struct netconfig_data {
+	uint8_t family;
+	enum netconfig_method method;
+	char *addr;
+	uint8_t prefix_len;
+	char *gateway_addr;
+	char **dns;
+	char **domain_names;
+};
+
 typedef void (*netconfig_notify_func_t)(enum netconfig_event event,
 							void *user_data);
 =

-- =

2.32.0

--===============6130961107217665030==--

