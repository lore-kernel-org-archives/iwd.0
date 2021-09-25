Content-Type: multipart/mixed; boundary="===============6633076472559603112=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 8/8] netconfig: Add IPv6 configuration properties on Station
Date: Sat, 25 Sep 2021 03:11:53 +0200
Message-ID: <20210925011153.25195-8-andrew.zaborowski@intel.com>
In-Reply-To: 20210925011153.25195-1-andrew.zaborowski@intel.com

--===============6633076472559603112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the net.connman.iwd.IPv6Configuration D-Bus interface on the station
objects to expose current netconfig values.
---
 src/dbus.h      |   1 +
 src/netconfig.c | 127 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 121 insertions(+), 7 deletions(-)

diff --git a/src/dbus.h b/src/dbus.h
index a7248554..a345f7ac 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -44,6 +44,7 @@
 #define IWD_AP_DIAGNOSTIC_INTERFACE "net.connman.iwd.AccessPointDiagnostic"
 #define IWD_STATION_DEBUG_INTERFACE "net.connman.iwd.StationDebug"
 #define IWD_IPV4_CONFIG_INTERFACE "net.connman.iwd.IPv4Configuration"
+#define IWD_IPV6_CONFIG_INTERFACE "net.connman.iwd.IPv6Configuration"
 =

 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
diff --git a/src/netconfig.c b/src/netconfig.c
index b7c0b432..223ebba7 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -75,6 +75,7 @@ struct netconfig {
 	netconfig_notify_func_t notify;
 	void *user_data;
 	bool v4_configured;
+	bool v6_configured;
 =

 	struct resolve *resolve;
 =

@@ -89,7 +90,7 @@ struct netconfig {
 	struct interface_data {
 		uint8_t af;
 		struct netconfig *netconfig;
-	} v4_data;
+	} v4_data, v6_data;
 };
 =

 static struct l_netlink *rtnl;
@@ -271,11 +272,13 @@ static void netconfig_property_changed(struct netconf=
ig *netconfig, uint8_t af,
 	if (!netconfig->dbus_path)
 		return;
 =

-	if (!netconfig->v4_configured)
+	if (!(af =3D=3D AF_INET ? netconfig->v4_configured :
+				netconfig->v6_configured))
 		return;
 =

 	l_dbus_property_changed(dbus_get_bus(), netconfig->dbus_path,
-				IWD_IPV4_CONFIG_INTERFACE, property_name);
+				(af =3D=3D AF_INET) ? IWD_IPV4_CONFIG_INTERFACE :
+				IWD_IPV6_CONFIG_INTERFACE, property_name);
 }
 =

 static void netconfig_set_neighbor_entry_cb(int error,
@@ -716,7 +719,8 @@ static void netconfig_connected_v4(struct netconfig *ne=
tconfig)
 		l_info("Unable to add %s at %s",
 			IWD_IPV4_CONFIG_INTERFACE, netconfig->dbus_path);
 =

-	if (!l_dbus_object_add_interface(dbus, netconfig->dbus_path,
+	if (!netconfig->v6_configured &&
+			!l_dbus_object_add_interface(dbus, netconfig->dbus_path,
 						L_DBUS_INTERFACE_PROPERTIES,
 						netconfig))
 		/* Properties may already exist on the object, not an error */
@@ -740,6 +744,47 @@ static void netconfig_disconnected_v4(struct netconfig=
 *netconfig)
 			IWD_IPV4_CONFIG_INTERFACE, netconfig->dbus_path);
 }
 =

+static void netconfig_connected_v6(struct netconfig *netconfig)
+{
+	struct l_dbus *dbus =3D dbus_get_bus();
+
+	netconfig->v6_configured =3D true;
+
+	if (!netconfig->dbus_path)
+		return;
+
+	if (unlikely(!l_dbus_object_add_interface(dbus,
+						netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE,
+						&netconfig->v6_data)))
+		l_info("Unable to add %s at %s",
+			IWD_IPV6_CONFIG_INTERFACE, netconfig->dbus_path);
+
+	if (!netconfig->v4_configured &&
+			!l_dbus_object_add_interface(dbus, netconfig->dbus_path,
+						L_DBUS_INTERFACE_PROPERTIES,
+						netconfig))
+		/* Properties may already exist on the object, not an error */
+		l_debug("Unable to add %s at %s",
+			L_DBUS_INTERFACE_PROPERTIES, netconfig->dbus_path);
+}
+
+static void netconfig_disconnected_v6(struct netconfig *netconfig)
+{
+	struct l_dbus *dbus =3D dbus_get_bus();
+
+	netconfig->v6_configured =3D false;
+
+	if (!netconfig->dbus_path)
+		return;
+
+	if (unlikely(!l_dbus_object_remove_interface(dbus,
+						netconfig->dbus_path,
+						IWD_IPV6_CONFIG_INTERFACE)))
+		l_info("l_dbus_object_remove_interface failed for %s at %s",
+			IWD_IPV6_CONFIG_INTERFACE, netconfig->dbus_path);
+}
+
 static void netconfig_ifaddr_ipv6_added(struct netconfig *netconfig,
 					const struct ifaddrmsg *ifa,
 					uint32_t len)
@@ -865,6 +910,8 @@ static void netconfig_route6_add_cb(int error, uint16_t=
 type,
 						error, strerror(-error));
 		return;
 	}
+
+	netconfig_connected_v6(netconfig);
 }
 =

 static bool netconfig_ipv4_routes_install(struct netconfig *netconfig)
@@ -1003,6 +1050,9 @@ static void netconfig_ipv6_ifaddr_add_cmd_cb(int erro=
r, uint16_t type,
 =

 	netconfig_set_dns(netconfig);
 	netconfig_set_domains(netconfig);
+
+	if (!netconfig->route6_add_cmd_id)
+		netconfig_connected_v6(netconfig);
 }
 =

 static void netconfig_ifaddr_del_cmd_cb(int error, uint16_t type,
@@ -1175,10 +1225,23 @@ static void netconfig_dhcp6_event_handler(struct l_=
dhcp6_client *client,
 		else {
 			l_free(netconfig->v6_gateway_str);
 			netconfig->v6_gateway_str =3D gateway_str;
+			netconfig_property_changed(netconfig, AF_INET6,
+							"Gateway");
 		}
 =

 		address =3D l_rtnl_address_new(addr_str,
 					l_dhcp6_lease_get_prefix_length(lease));
+
+		if (!netconfig_address_cmp_prefix_len(netconfig->v6_address,
+							address))
+			netconfig_property_changed(netconfig, AF_INET6,
+							"Netmask");
+
+		if (netconfig_address_cmp_address(netconfig->v6_address,
+							address))
+			netconfig_property_changed(netconfig, AF_INET6,
+							"Address");
+
 		l_rtnl_address_free(netconfig->v6_address);
 		netconfig->v6_address =3D address;
 =

@@ -1186,6 +1249,10 @@ static void netconfig_dhcp6_event_handler(struct l_d=
hcp6_client *client,
 		netconfig_domains_update(netconfig, AF_INET6);
 		netconfig_set_dns(netconfig);
 		netconfig_set_domains(netconfig);
+
+		if (!netconfig->v6_configured)
+			netconfig_connected_v6(netconfig);
+
 		break;
 	}
 	case L_DHCP6_CLIENT_EVENT_LEASE_EXPIRED:
@@ -1198,6 +1265,9 @@ static void netconfig_dhcp6_event_handler(struct l_dh=
cp6_client *client,
 		netconfig->v6_address =3D NULL;
 		l_free(l_steal_ptr(netconfig->v6_gateway_str));
 =

+		if (netconfig->v6_configured)
+			netconfig_disconnected_v6(netconfig);
+
 		/* Fall through */
 	case L_DHCP6_CLIENT_EVENT_NO_LEASE:
 		if (!l_dhcp6_client_start(netconfig->dhcp6_client))
@@ -1595,6 +1665,9 @@ bool netconfig_reset(struct netconfig *netconfig)
 	if (netconfig->v4_configured)
 		netconfig_disconnected_v4(netconfig);
 =

+	if (netconfig->v6_configured)
+		netconfig_disconnected_v6(netconfig);
+
 	if (netconfig->route4_add_gateway_cmd_id) {
 		l_netlink_cancel(rtnl, netconfig->route4_add_gateway_cmd_id);
 		netconfig->route4_add_gateway_cmd_id =3D 0;
@@ -1747,6 +1820,8 @@ struct netconfig *netconfig_new(uint32_t ifindex, con=
st char *dbus_path)
 	 */
 	netconfig->v4_data.af =3D AF_INET;
 	netconfig->v4_data.netconfig =3D netconfig;
+	netconfig->v6_data.af =3D AF_INET6;
+	netconfig->v6_data.netconfig =3D netconfig;
 =

 	return netconfig;
 }
@@ -1877,7 +1952,28 @@ static bool netconfig_property_get_v4_domains(struct=
 l_dbus *dbus,
 	return true;
 }
 =

-static void netconfig_setup_interface(struct l_dbus_interface *interface)
+static bool netconfig_property_get_v6_domains(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	const struct interface_data *data =3D user_data;
+	char **i;
+
+	if (!data->netconfig->v6_domains)
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "s");
+
+	for (i =3D data->netconfig->v6_domains; *i; i++)
+		l_dbus_message_builder_append_basic(builder, 's', *i);
+
+	l_dbus_message_builder_leave_array(builder);
+	return true;
+}
+
+static void netconfig_setup_interface(struct l_dbus_interface *interface,
+					uint8_t af)
 {
 	l_dbus_interface_property(interface, "Method", 0, "s",
 					netconfig_property_get_method, NULL);
@@ -1890,10 +1986,22 @@ static void netconfig_setup_interface(struct l_dbus=
_interface *interface)
 	l_dbus_interface_property(interface, "DomainNameServers", 0, "as",
 					netconfig_property_get_dnses, NULL);
 	l_dbus_interface_property(interface, "DomainNames", 0, "as",
-					netconfig_property_get_v4_domains,
+					af =3D=3D AF_INET ?
+					netconfig_property_get_v4_domains :
+					netconfig_property_get_v6_domains,
 					NULL);
 }
 =

+static void netconfig_setup_v4_interface(struct l_dbus_interface *interfac=
e)
+{
+	netconfig_setup_interface(interface, AF_INET);
+}
+
+static void netconfig_setup_v6_interface(struct l_dbus_interface *interfac=
e)
+{
+	netconfig_setup_interface(interface, AF_INET6);
+}
+
 static int netconfig_init(void)
 {
 	uint32_t r;
@@ -1947,7 +2055,11 @@ static int netconfig_init(void)
 =

 	L_WARN_ON(unlikely(!l_dbus_register_interface(dbus_get_bus(),
 						IWD_IPV4_CONFIG_INTERFACE,
-						netconfig_setup_interface,
+						netconfig_setup_v4_interface,
+						NULL, false)));
+	L_WARN_ON(unlikely(!l_dbus_register_interface(dbus_get_bus(),
+						IWD_IPV6_CONFIG_INTERFACE,
+						netconfig_setup_v6_interface,
 						NULL, false)));
 	return 0;
 =

@@ -1967,6 +2079,7 @@ static void netconfig_exit(void)
 	l_queue_destroy(netconfig_list, netconfig_free);
 =

 	l_dbus_unregister_interface(dbus_get_bus(), IWD_IPV4_CONFIG_INTERFACE);
+	l_dbus_unregister_interface(dbus_get_bus(), IWD_IPV6_CONFIG_INTERFACE);
 }
 =

 IWD_MODULE(netconfig, netconfig_init, netconfig_exit)
-- =

2.30.2

--===============6633076472559603112==--

