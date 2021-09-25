Content-Type: multipart/mixed; boundary="===============6046523236432258312=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 5/8] netconfig: Track DNS address string lists
Date: Sat, 25 Sep 2021 03:11:50 +0200
Message-ID: <20210925011153.25195-5-andrew.zaborowski@intel.com>
In-Reply-To: 20210925011153.25195-1-andrew.zaborowski@intel.com

--===============6046523236432258312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Cache the latest v4 and v6 DNS IP string lists in struct netconfig state
to be able to more easily detect changes in those values in future
commits.  For that split netconfig_set_dns's code into this function,
which now only commit the values in netconfig->dns{4,6}_list to the
resolver, and netconfig_dns_list_update() which figures out the active
DNS IP address list and saves it in netconfig->dns{4,6} list.  This
probably saves some cycles as the callers can now decide to only
recalculate the dns_list which may have changed.

While there simplify netconfig_set_dns return type to void as the result
was always 0 anyway and was never checked by callers.
---
 src/netconfig.c | 99 +++++++++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 41 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index e93e496c..ae8fefd8 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -61,6 +61,8 @@ struct netconfig {
 	struct l_rtnl_address *v6_address;
 	char **dns4_overrides;
 	char **dns6_overrides;
+	char **dns4_list;
+	char **dns6_list;
 	struct ie_fils_ip_addr_response_info *fils_override;
 	char *v4_gateway_str;
 	char *v6_gateway_str;
@@ -261,52 +263,59 @@ static void netconfig_set_neighbor_entry_cb(int error,
 			strerror(-error), error);
 }
 =

-static int netconfig_set_dns(struct netconfig *netconfig)
+static void netconfig_set_dns(struct netconfig *netconfig)
 {
-	const uint8_t *fils_dns4_mac =3D NULL;
-	const uint8_t *fils_dns6_mac =3D NULL;
-	char **dns4_list =3D netconfig_get_dns_list(netconfig, AF_INET,
-							&fils_dns4_mac);
-	char **dns6_list =3D netconfig_get_dns_list(netconfig, AF_INET6,
-							&fils_dns6_mac);
-	unsigned int n_entries4 =3D l_strv_length(dns4_list);
-	unsigned int n_entries6 =3D l_strv_length(dns6_list);
-	char **dns_list;
-	const struct ie_fils_ip_addr_response_info *fils =3D
-		netconfig->fils_override;
-
-	if (!dns4_list && !dns6_list)
-		return 0;
+	if (!netconfig->dns4_list && !netconfig->dns6_list)
+		return;
 =

-	dns_list =3D dns4_list;
+	if (netconfig->dns4_list && netconfig->dns6_list) {
+		unsigned int n_entries4 =3D l_strv_length(netconfig->dns4_list);
+		unsigned int n_entries6 =3D l_strv_length(netconfig->dns6_list);
+		char **dns_list =3D l_malloc(sizeof(char *) *
+					(n_entries4 + n_entries6 + 1));
 =

-	if (dns6_list) {
-		dns_list =3D l_realloc(dns_list,
-				sizeof(char *) * (n_entries4 + n_entries6 + 1));
-		memcpy(dns_list + n_entries4, dns6_list,
+		memcpy(dns_list, netconfig->dns4_list,
+			sizeof(char *) * n_entries4);
+		memcpy(dns_list + n_entries4, netconfig->dns6_list,
 			sizeof(char *) * (n_entries6 + 1));
-		/* Contents now belong to dns_list, so no l_strfreev */
-		l_free(dns6_list);
+		resolve_set_dns(netconfig->resolve, dns_list);
+		l_free(dns_list);
+		return;
 	}
 =

-	resolve_set_dns(netconfig->resolve, dns_list);
-	l_strv_free(dns_list);
+	resolve_set_dns(netconfig->resolve,
+			netconfig->dns4_list ?: netconfig->dns6_list);
+}
 =

-	if (fils_dns4_mac && !l_rtnl_neighbor_set_hwaddr(rtnl,
-					netconfig->ifindex, AF_INET,
-					&fils->ipv4_dns, fils_dns4_mac, 6,
-					netconfig_set_neighbor_entry_cb, NULL,
-					NULL))
-		l_debug("l_rtnl_neighbor_set_hwaddr failed");
+static void netconfig_dns_list_update(struct netconfig *netconfig, uint8_t=
 af)
+{
+	const uint8_t *fils_dns_mac =3D NULL;
+	char ***dns_list_ptr =3D af =3D=3D AF_INET ?
+		&netconfig->dns4_list : &netconfig->dns6_list;
+	char **new_dns_list =3D netconfig_get_dns_list(netconfig, af,
+							&fils_dns_mac);
+
+	if (l_strv_eq(*dns_list_ptr, new_dns_list)) {
+		l_strv_free(new_dns_list);
+		return;
+	}
 =

-	if (fils_dns6_mac && !l_rtnl_neighbor_set_hwaddr(rtnl,
-					netconfig->ifindex, AF_INET6,
-					fils->ipv6_dns, fils_dns6_mac, 6,
-					netconfig_set_neighbor_entry_cb, NULL,
-					NULL))
-		l_debug("l_rtnl_neighbor_set_hwaddr failed");
+	l_strv_free(*dns_list_ptr);
+	*dns_list_ptr =3D new_dns_list;
 =

-	return 0;
+	if (fils_dns_mac) {
+		const struct ie_fils_ip_addr_response_info *fils =3D
+			netconfig->fils_override;
+		const void *dns_ip =3D af =3D=3D AF_INET ?
+			(const void *) &fils->ipv4_dns :
+			(const void *) &fils->ipv6_dns;
+
+		if (!l_rtnl_neighbor_set_hwaddr(rtnl, netconfig->ifindex, af,
+						dns_ip, fils_dns_mac, 6,
+						netconfig_set_neighbor_entry_cb,
+						NULL, NULL))
+			l_debug("l_rtnl_neighbor_set_hwaddr failed");
+	}
 }
 =

 static void append_domain(char **domains, unsigned int *n_domains,
@@ -962,6 +971,8 @@ static void netconfig_ipv4_dhcp_event_handler(struct l_=
dhcp_client *client,
 			return;
 		}
 =

+		netconfig_dns_list_update(netconfig, AF_INET);
+
 		L_WARN_ON(!(netconfig->addr4_add_cmd_id =3D
 				l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
 					netconfig->v4_address,
@@ -1030,12 +1041,14 @@ static void netconfig_dhcp6_event_handler(struct l_=
dhcp6_client *client,
 		l_rtnl_address_free(netconfig->v6_address);
 		netconfig->v6_address =3D address;
 =

+		netconfig_dns_list_update(netconfig, AF_INET6);
 		netconfig_set_dns(netconfig);
 		netconfig_set_domains(netconfig);
 		break;
 	}
 	case L_DHCP6_CLIENT_EVENT_LEASE_EXPIRED:
 		l_debug("Lease for interface %u expired", netconfig->ifindex);
+		netconfig_dns_list_update(netconfig, AF_INET6);
 		netconfig_set_dns(netconfig);
 		netconfig_set_domains(netconfig);
 		l_rtnl_address_free(netconfig->v6_address);
@@ -1069,8 +1082,8 @@ static void netconfig_reset_v4(struct netconfig *netc=
onfig)
 	if (netconfig->rtm_protocol) {
 		netconfig_remove_v4_address(netconfig);
 =

-		l_strfreev(netconfig->dns4_overrides);
-		netconfig->dns4_overrides =3D NULL;
+		l_strv_free(l_steal_ptr(netconfig->dns4_overrides));
+		l_strv_free(l_steal_ptr(netconfig->dns4_list));
 =

 		l_dhcp_client_stop(netconfig->dhcp_client);
 		netconfig->rtm_protocol =3D 0;
@@ -1155,6 +1168,8 @@ static bool netconfig_ipv4_select_and_install(struct =
netconfig *netconfig)
 							ip)))
 			return false;
 =

+		netconfig_dns_list_update(netconfig, AF_INET);
+
 		netconfig->acd =3D l_acd_new(netconfig->ifindex);
 		l_acd_set_event_handler(netconfig->acd,
 					netconfig_ipv4_acd_event, netconfig,
@@ -1223,6 +1238,8 @@ static bool netconfig_ipv6_select_and_install(struct =
netconfig *netconfig)
 	}
 =

 	if (netconfig->v6_address) {
+		netconfig_dns_list_update(netconfig, AF_INET6);
+
 		L_WARN_ON(!(netconfig->addr6_add_cmd_id =3D
 			l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
 					netconfig->v6_address,
@@ -1455,8 +1472,8 @@ bool netconfig_reset(struct netconfig *netconfig)
 		l_rtnl_address_free(netconfig->v6_address);
 		netconfig->v6_address =3D NULL;
 =

-		l_strfreev(netconfig->dns6_overrides);
-		netconfig->dns6_overrides =3D NULL;
+		l_strv_free(l_steal_ptr(netconfig->dns6_overrides));
+		l_strv_free(l_steal_ptr(netconfig->dns6_list));
 =

 		l_dhcp6_client_stop(netconfig->dhcp6_client);
 		netconfig->rtm_v6_protocol =3D 0;
-- =

2.30.2

--===============6046523236432258312==--

