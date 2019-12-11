Content-Type: multipart/mixed; boundary="===============0179448246683285252=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v3 2/2] resolve: Add systemd-resolved domain name installer
Date: Tue, 10 Dec 2019 16:34:54 -0800
Message-ID: <20191211003454.16767-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191211003454.16767-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0179448246683285252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The exposed DBus API is used to install doamin name into
sytemd-resolved.
---
 src/resolve.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/resolve.h |  1 +
 2 files changed, 66 insertions(+)

diff --git a/src/resolve.c b/src/resolve.c
index 387e0b3c..1d9bbe0a 100644
--- a/src/resolve.c
+++ b/src/resolve.c
@@ -42,6 +42,8 @@ struct resolve_method_ops {
 	void (*exit)(void *data);
 	void (*add_dns)(uint32_t ifindex, uint8_t type, char **dns_list,
 								void *data);
+	void (*add_domain_name)(uint32_t ifindex, const char *domain_name,
+								void *data);
 	void (*remove)(uint32_t ifindex, void *data);
 };
 =

@@ -177,6 +179,57 @@ static void resolve_systemd_add_dns(uint32_t ifindex, =
uint8_t type,
 								state, NULL);
 }
 =

+static void systemd_link_add_domains_reply(struct l_dbus_message *message,
+								void *user_data)
+{
+	const char *name;
+	const char *text;
+
+	if (!l_dbus_message_is_error(message))
+		return;
+
+	l_dbus_message_get_error(message, &name, &text);
+
+	l_error("resolve-systemd: Failed to modify the domain entries. %s: %s",
+								name, text);
+}
+
+static void resolve_systemd_add_domain_name(uint32_t ifindex,
+							const char *domain_name,
+							void *data)
+{
+	struct systemd_state *state =3D data;
+	struct l_dbus_message *message;
+	bool routing_domain;
+
+	l_debug("ifindex: %u", ifindex);
+
+	if (!state->is_ready) {
+		l_error("resolve-systemd: Failed to add domain name. "
+				"Is 'systemd-resolved' service running?");
+
+		return;
+	}
+
+	message =3D
+		l_dbus_message_new_method_call(dbus_get_bus(),
+					SYSTEMD_RESOLVED_SERVICE,
+					SYSTEMD_RESOLVED_MANAGER_PATH,
+					SYSTEMD_RESOLVED_MANAGER_INTERFACE,
+					"SetLinkDomains");
+
+	if (!message)
+		return;
+
+	routing_domain =3D true;
+
+	l_dbus_message_set_arguments(message, "ia(sb)", ifindex,
+						1, domain_name, routing_domain);
+
+	l_dbus_send_with_reply(dbus_get_bus(), message,
+				systemd_link_add_domains_reply, state, NULL);
+}
+
 static void resolve_systemd_remove(uint32_t ifindex, void *data)
 {
 	struct systemd_state *state =3D data;
@@ -249,6 +302,7 @@ static const struct resolve_method_ops resolve_method_s=
ystemd =3D {
 	.init =3D resolve_systemd_init,
 	.exit =3D resolve_systemd_exit,
 	.add_dns =3D resolve_systemd_add_dns,
+	.add_domain_name =3D resolve_systemd_add_domain_name,
 	.remove =3D resolve_systemd_remove,
 };
 =

@@ -376,6 +430,17 @@ void resolve_add_dns(uint32_t ifindex, uint8_t type, c=
har **dns_list)
 	method.ops->add_dns(ifindex, type, dns_list, method.data);
 }
 =

+void resolve_add_domain_name(uint32_t ifindex, const char *domain_name)
+{
+	if (!domain_name)
+		return;
+
+	if (!method.ops || !method.ops->add_dns)
+		return;
+
+	method.ops->add_domain_name(ifindex, domain_name, method.data);
+}
+
 void resolve_remove(uint32_t ifindex)
 {
 	if (!method.ops || !method.ops->remove)
diff --git a/src/resolve.h b/src/resolve.h
index b0335868..9cca81cc 100644
--- a/src/resolve.h
+++ b/src/resolve.h
@@ -21,4 +21,5 @@
  */
 =

 void resolve_add_dns(uint32_t ifindex, uint8_t type, char **dns_list);
+void resolve_add_domain_name(uint32_t ifindex, const char *domain_name);
 void resolve_remove(uint32_t ifindex);
-- =

2.13.6

--===============0179448246683285252==--

