Content-Type: multipart/mixed; boundary="===============7938997276856918020=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] ap: Add MACs to FILS IP Assignment responses
Date: Sat, 28 Aug 2021 05:23:05 +0200
Message-ID: <20210828032305.29788-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7938997276856918020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Try to include the gateway and DNS MAC addresses in the corresponding
fields in the FILS IP Address Assignment IEs we send to the clients.
---
 src/ap.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 2 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 77de596a..d6802fda 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -92,6 +92,10 @@ struct ap_state {
 	struct l_dhcp_server *netconfig_dhcp;
 	struct l_rtnl_address *netconfig_addr4;
 	uint32_t rtnl_add_cmd;
+	uint32_t rtnl_get_gateway4_mac_cmd;
+	uint32_t rtnl_get_dns4_mac_cmd;
+	uint8_t netconfig_gateway4_mac[6];
+	uint8_t netconfig_dns4_mac[6];
 =

 	bool started : 1;
 	bool gtk_set : 1;
@@ -211,6 +215,16 @@ static void ap_reset(struct ap_state *ap)
 	if (ap->rtnl_add_cmd)
 		l_netlink_cancel(rtnl, ap->rtnl_add_cmd);
 =

+	if (ap->rtnl_get_gateway4_mac_cmd) {
+		l_netlink_cancel(rtnl, ap->rtnl_get_gateway4_mac_cmd);
+		ap->rtnl_get_gateway4_mac_cmd =3D 0;
+	}
+
+	if (ap->rtnl_get_dns4_mac_cmd) {
+		l_netlink_cancel(rtnl, ap->rtnl_get_dns4_mac_cmd);
+		ap->rtnl_get_dns4_mac_cmd =3D 0;
+	}
+
 	l_queue_destroy(ap->sta_states, ap_sta_free);
 =

 	if (ap->rates)
@@ -1470,13 +1484,19 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, =
struct sta_state *sta,
 			if (lease_lifetime !=3D 0xffffffff)
 				ip_resp_info.ipv4_lifetime =3D lease_lifetime;
 =

-			if (lease_gateway_str)
+			if (lease_gateway_str) {
 				ip_resp_info.ipv4_gateway =3D
 					IP4_FROM_STR(lease_gateway_str);
+				memcpy(ip_resp_info.ipv4_gateway_mac,
+					ap->netconfig_gateway4_mac, 6);
+			}
 =

-			if (lease_dns_str_list && lease_dns_str_list[0])
+			if (lease_dns_str_list && lease_dns_str_list[0]) {
 				ip_resp_info.ipv4_dns =3D
 					IP4_FROM_STR(lease_dns_str_list[0]);
+				memcpy(ip_resp_info.ipv4_dns_mac,
+					ap->netconfig_dns4_mac, 6);
+			}
 =

 			l_strv_free(lease_dns_str_list);
 			sta->ip_alloc_sent =3D true;
@@ -2561,6 +2581,104 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
void *user_data)
 	}
 }
 =

+static void ap_get_gateway4_mac_cb(int error, const uint8_t *hwaddr,
+					size_t hwaddr_len, void *user_data)
+{
+	struct ap_state *ap =3D user_data;
+
+	ap->rtnl_get_gateway4_mac_cmd =3D 0;
+
+	if (error) {
+		l_debug("Error: %s (%i)", strerror(-error), -error);
+		return;
+	}
+
+	if (L_WARN_ON(unlikely(hwaddr_len !=3D 6)))
+		return;
+
+	l_debug("Resolved mac to " MAC, MAC_STR(hwaddr));
+	memcpy(ap->netconfig_gateway4_mac, hwaddr, 6);
+}
+
+static void ap_get_dns4_mac_cb(int error, const uint8_t *hwaddr,
+					size_t hwaddr_len, void *user_data)
+{
+	struct ap_state *ap =3D user_data;
+
+	ap->rtnl_get_dns4_mac_cmd =3D 0;
+
+	if (error) {
+		l_debug("Error: %s (%i)", strerror(-error), -error);
+		return;
+	}
+
+	if (L_WARN_ON(unlikely(hwaddr_len !=3D 6)))
+		return;
+
+	l_debug("Resolved mac to " MAC, MAC_STR(hwaddr));
+	memcpy(ap->netconfig_dns4_mac, hwaddr, 6);
+}
+
+static void ap_query_macs(struct ap_state *ap, const char *addr_str,
+				uint8_t prefix_len, const char *gateway_str,
+				const char **dns_str_list)
+{
+	uint32_t local =3D IP4_FROM_STR(addr_str);
+	uint32_t gateway =3D 0;
+	uint32_t dns =3D 0;
+	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
+
+	/*
+	 * For simplicity only check the ARP/NDP tables to see if we already
+	 * have the MACs that we need.  There doesn't seem to be an API to
+	 * actually resolve addresses that are not in these tables other than
+	 * by triggering IP traffic to those hosts, such as a ping.  In a PC
+	 * or mobile device scenario we're likely to have these MACs already,
+	 * otherwise we give up as this is a pretty low-priority feature.
+	 */
+
+	if (gateway_str) {
+		gateway =3D IP4_FROM_STR(gateway_str);
+		if (L_WARN_ON(unlikely(!gateway)))
+			return;
+
+		if (gateway =3D=3D local)
+			memcpy(ap->netconfig_gateway4_mac,
+				netdev_get_address(ap->netdev), 6);
+		else {
+			ap->rtnl_get_gateway4_mac_cmd =3D
+				l_rtnl_neighbor_get_hwaddr(rtnl, ifindex,
+							AF_INET, &gateway,
+							ap_get_gateway4_mac_cb,
+							ap, NULL);
+			if (!ap->rtnl_get_gateway4_mac_cmd)
+				l_debug("l_rtnl_neighbor_get_hwaddr() failed "
+					"for the gateway IP");
+		}
+	}
+
+	if (dns_str_list) {
+		dns =3D IP4_FROM_STR(dns_str_list[0]);
+		if (L_WARN_ON(unlikely(!dns)))
+			return;
+
+		/* TODO: can also skip query if dns =3D=3D gateway */
+		if (dns =3D=3D local)
+			memcpy(ap->netconfig_dns4_mac,
+				netdev_get_address(ap->netdev), 6);
+		else if (util_ip_subnet_match(prefix_len, &dns, &local)) {
+			ap->rtnl_get_dns4_mac_cmd =3D
+				l_rtnl_neighbor_get_hwaddr(rtnl, ifindex,
+							AF_INET, &dns,
+							ap_get_dns4_mac_cb,
+							ap, NULL);
+			if (!ap->rtnl_get_dns4_mac_cmd)
+				l_debug("l_rtnl_neighbor_get_hwaddr() failed "
+					"for the DNS IP");
+		}
+	}
+}
+
 #define AP_DEFAULT_IPV4_PREFIX_LEN 28
 =

 static int ap_setup_netconfig4(struct ap_state *ap, const char **addr_str_=
list,
@@ -2689,6 +2807,8 @@ static int ap_setup_netconfig4(struct ap_state *ap, c=
onst char **addr_str_list,
 			ap->netconfig_set_addr4 =3D false;
 	}
 =

+	ap_query_macs(ap, addr_str_buf, prefix_len, gateway_str, dns_str_list);
+
 cleanup:
 	l_dhcp_server_destroy(dhcp);
 	l_rtnl_address_free(new_addr);
-- =

2.30.2

--===============7938997276856918020==--

