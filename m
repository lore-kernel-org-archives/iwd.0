Content-Type: multipart/mixed; boundary="===============7294530710350492653=="
MIME-Version: 1.0
From: Daniel Lin <ephemient@gmail.com>
Subject: [PATCH v2] src: configure systemd-resolved's MulticastDNS=
 setting
Date: Thu, 11 Feb 2021 13:11:41 -0500
Message-ID: <20210211181141.HsvTv%ephemient@gmail.com>
In-Reply-To: <20210210234359.11WKe%ephemient@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7294530710350492653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When using iwd.conf:[General].EnableNetworkConfiguration=3Dtrue, it is not
possible to configure systemd.network:[Network].MulticastDNS=3D as
systemd-networkd considers the link to be unmanaged. This patch allows
iwd to configure that setting on systemd-resolved directly.
---
 src/iwd.config.rst |  7 +++++
 src/netconfig.c    |  6 ++++
 src/resolve.c      | 70 ++++++++++++++++++++++++++++++----------------
 src/resolve.h      |  1 +
 4 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 0064dfd2..d430909a 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -212,6 +212,13 @@ The group ``[Network]`` contains network configuration=
 related settings.
 =

        If not specified, ``300`` is used as default.
 =

+   * - MulticastDNS
+     - Values: true, **false**, resolve
+
+       Configures multicast DNS. See ``man 5 systemd.network`` for details.
+
+       Only applies when ``NameResolvingService=3Dsystemd``.
+
 Blacklist
 ---------
 =

diff --git a/src/netconfig.c b/src/netconfig.c
index cf092b78..749ba0ad 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -963,6 +963,8 @@ bool netconfig_configure(struct netconfig *netconfig,
 				const uint8_t *mac_address,
 				netconfig_notify_func_t notify, void *user_data)
 {
+	char *mdns;
+
 	netconfig->dns4_overrides =3D l_settings_get_string_list(active_settings,
 							"IPv4", "DNS", ' ');
 =

@@ -1006,6 +1008,10 @@ bool netconfig_configure(struct netconfig *netconfig,
 =

 	netconfig_ipv6_select_and_install(netconfig);
 =

+	mdns =3D l_settings_get_string(active_settings, "Network", "MulticastDNS"=
);
+	resolve_set_mdns(netconfig->resolve, mdns);
+	l_free(mdns);
+
 	return true;
 }
 =

diff --git a/src/resolve.c b/src/resolve.c
index d3b483a8..5b20b8c9 100644
--- a/src/resolve.c
+++ b/src/resolve.c
@@ -40,6 +40,7 @@
 struct resolve_ops {
 	void (*set_dns)(struct resolve *resolve, char **dns_list);
 	void (*set_domains)(struct resolve *resolve, char **domain_list);
+	void (*set_mdns)(struct resolve *resolve, const char *mdns);
 	void (*revert)(struct resolve *resolve);
 	void (*destroy)(struct resolve *resolve);
 };
@@ -78,6 +79,17 @@ void resolve_set_domains(struct resolve *resolve, char *=
*domain_list)
 	resolve->ops->set_domains(resolve, domain_list);
 }
 =

+void resolve_set_mdns(struct resolve *resolve, const char *mdns)
+{
+	if (!mdns)
+		return;
+
+	if (!resolve->ops->set_mdns)
+		return;
+
+	resolve->ops->set_mdns(resolve, mdns);
+}
+
 void resolve_revert(struct resolve *resolve)
 {
 	if (!resolve->ops->revert)
@@ -112,9 +124,10 @@ struct systemd {
 	struct resolve super;
 };
 =

-static void systemd_link_dns_reply(struct l_dbus_message *message,
+static void systemd_link_generic_reply(struct l_dbus_message *message,
 								void *user_data)
 {
+	const char *type =3D user_data;
 	const char *name;
 	const char *text;
 =

@@ -123,8 +136,8 @@ static void systemd_link_dns_reply(struct l_dbus_messag=
e *message,
 =

 	l_dbus_message_get_error(message, &name, &text);
 =

-	l_error("resolve-systemd: Failed to modify the DNS entries. %s: %s",
-								name, text);
+	l_error("resolve-systemd: Failed to modify the %s entries. %s: %s",
+								type, name, text);
 }
 =

 static bool systemd_builder_add_dns(struct l_dbus_message_builder *builder,
@@ -205,23 +218,8 @@ static void resolve_systemd_set_dns(struct resolve *re=
solve, char **dns_list)
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
 =

-	l_dbus_send_with_reply(dbus_get_bus(), message, systemd_link_dns_reply,
-								NULL, NULL);
-}
-
-static void systemd_set_link_domains_reply(struct l_dbus_message *message,
-								void *user_data)
-{
-	const char *name;
-	const char *text;
-
-	if (!l_dbus_message_is_error(message))
-		return;
-
-	l_dbus_message_get_error(message, &name, &text);
-
-	l_error("resolve-systemd: Failed to modify the domain entries. %s: %s",
-								name, text);
+	l_dbus_send_with_reply(dbus_get_bus(), message, systemd_link_generic_repl=
y,
+								"DNS", NULL);
 }
 =

 static void resolve_systemd_set_domains(struct resolve *resolve,
@@ -266,8 +264,31 @@ static void resolve_systemd_set_domains(struct resolve=
 *resolve,
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
 =

-	l_dbus_send_with_reply(dbus_get_bus(), message,
-				systemd_set_link_domains_reply, NULL, NULL);
+	l_dbus_send_with_reply(dbus_get_bus(), message, systemd_link_generic_repl=
y,
+				"domains", NULL);
+}
+
+static void resolve_systemd_set_mdns(struct resolve *resolve, const char *=
mdns)
+{
+	struct l_dbus_message *message;
+
+	l_debug("ifindex: %u", resolve->ifindex);
+
+	if (L_WARN_ON(!systemd_state.is_ready))
+		return;
+
+	message =3D l_dbus_message_new_method_call(dbus_get_bus(),
+					SYSTEMD_RESOLVED_SERVICE,
+					SYSTEMD_RESOLVED_MANAGER_PATH,
+					SYSTEMD_RESOLVED_MANAGER_INTERFACE,
+					"SetLinkMulticastDNS");
+
+	if (!message)
+		return;
+
+	l_dbus_message_set_arguments(message, "is", resolve->ifindex, mdns);
+	l_dbus_send_with_reply(dbus_get_bus(), message, systemd_link_generic_repl=
y,
+								"MulticastDNS", NULL);
 }
 =

 static void resolve_systemd_revert(struct resolve *resolve)
@@ -288,8 +309,8 @@ static void resolve_systemd_revert(struct resolve *reso=
lve)
 		return;
 =

 	l_dbus_message_set_arguments(message, "i", resolve->ifindex);
-	l_dbus_send_with_reply(dbus_get_bus(), message, systemd_link_dns_reply,
-								NULL, NULL);
+	l_dbus_send_with_reply(dbus_get_bus(), message, systemd_link_generic_repl=
y,
+								"DNS", NULL);
 }
 =

 static void resolve_systemd_destroy(struct resolve *resolve)
@@ -302,6 +323,7 @@ static void resolve_systemd_destroy(struct resolve *res=
olve)
 static const struct resolve_ops systemd_ops =3D {
 	.set_dns =3D resolve_systemd_set_dns,
 	.set_domains =3D resolve_systemd_set_domains,
+	.set_mdns =3D resolve_systemd_set_mdns,
 	.revert =3D resolve_systemd_revert,
 	.destroy =3D resolve_systemd_destroy,
 };
diff --git a/src/resolve.h b/src/resolve.h
index 64ed15f3..2301a288 100644
--- a/src/resolve.h
+++ b/src/resolve.h
@@ -23,5 +23,6 @@
 struct resolve *resolve_new(uint32_t ifindex);
 void resolve_set_dns(struct resolve *resolve, char **dns_list);
 void resolve_set_domains(struct resolve *resolve, char **domain_list);
+void resolve_set_mdns(struct resolve *resolve, const char *mdns);
 void resolve_revert(struct resolve *resolve);
 void resolve_free(struct resolve *resolve);
-- =

2.30.1

--===============7294530710350492653==--

