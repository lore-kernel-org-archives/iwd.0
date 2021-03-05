Content-Type: multipart/mixed; boundary="===============7451128377652229607=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/10] ap: Set up the DHCP server
Date: Fri, 05 Mar 2021 16:09:32 +0100
Message-ID: <20210305150936.868546-6-andrew.zaborowski@intel.com>
In-Reply-To: <20210305150936.868546-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7451128377652229607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create the DHCP server instance, set the settings from ap->config using
l_dhcp_server_* setters.
---
 src/ap.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 7 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index df3715a2..1b856c23 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -78,7 +78,7 @@ struct ap_state {
 	uint16_t last_aid;
 	struct l_queue *sta_states;
 =

-	struct l_dhcp_server *server;
+	struct l_dhcp_server *dhcp;
 	uint32_t addr4;
 	uint32_t rtnl_add_cmd;
 	uint32_t rtnl_dump_cmd;
@@ -394,8 +394,8 @@ static void ap_reset(struct ap_state *ap)
 	ap_config_free(ap->config);
 	ap->config =3D NULL;
 =

-	if (ap->server)
-		l_dhcp_server_stop(ap->server);
+	if (ap->dhcp)
+		l_dhcp_server_stop(ap->dhcp);
 =

 	l_queue_destroy(ap->rtnl_addr4_dump, l_free);
 	ap->rtnl_addr4_dump =3D NULL;
@@ -2142,7 +2142,7 @@ static void ap_start_cb(struct l_genl_msg *msg, void =
*user_data)
 		goto failed;
 	}
 =

-	if (ap->server && !l_dhcp_server_start(ap->server)) {
+	if (ap->dhcp && !l_dhcp_server_start(ap->dhcp)) {
 		l_error("DHCP server failed to start");
 		goto failed;
 	}
@@ -2464,6 +2464,77 @@ static void ap_mlme_notify(struct l_genl_msg *msg, v=
oid *user_data)
 	}
 }
 =

+static bool ap_setup_dhcp(struct ap_state *ap)
+{
+	struct in_addr ia;
+	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
+
+	ap->dhcp =3D l_dhcp_server_new(ifindex);
+	if (!ap->dhcp) {
+		l_error("Failed to create DHCP server on %u", ifindex);
+		return false;
+	}
+
+	if (getenv("IWD_DHCP_DEBUG"))
+		l_dhcp_server_set_debug(ap->dhcp, do_debug,
+					"[DHCPv4 SERV] ", NULL);
+
+	ia.s_addr =3D htonl(ap->addr4);
+
+	if (!l_dhcp_server_set_ip_address(ap->dhcp, inet_ntoa(ia))) {
+		l_error("l_dhcp_server_set_ip_address failed");
+		return false;
+	}
+
+	ia.s_addr =3D htonl(util_netmask_from_prefix(ap->config->prefix_len4));
+
+	if (!l_dhcp_server_set_netmask(ap->dhcp, inet_ntoa(ia))) {
+		l_error("l_dhcp_server_set_netmask failed");
+		return false;
+	}
+
+	if (ap->config->dhcp_gateway_addr4) {
+		ia.s_addr =3D htonl(util_netmask_from_prefix(
+					ap->config->dhcp_gateway_addr4));
+
+		if (!l_dhcp_server_set_gateway(ap->dhcp, inet_ntoa(ia))) {
+			l_error("l_dhcp_server_set_gateway failed");
+			return false;
+		}
+	}
+
+	if (ap->config->dns_addr4_str_list &&
+			!l_dhcp_server_set_dns(ap->dhcp,
+					ap->config->dns_addr4_str_list)) {
+		l_error("l_dhcp_server_set_dns failed");
+		return false;
+	}
+
+	if (ap->config->dhcp_start_addr4) {
+		char start_str[16];
+		char end_str[16];
+
+		ia.s_addr =3D htonl(ap->config->dhcp_start_addr4);
+		strcpy(start_str, inet_ntoa(ia));
+		ia.s_addr =3D htonl(ap->config->dhcp_end_addr4);
+		strcpy(end_str, inet_ntoa(ia));
+
+		if (!l_dhcp_server_set_ip_range(ap->dhcp, start_str, end_str)) {
+			l_error("l_dhcp_server_set_ip_range failed");
+			return false;
+		}
+	}
+
+	if (ap->config->dhcp_lease_time &&
+			!l_dhcp_server_set_lease_time(ap->dhcp,
+						ap->config->dhcp_lease_time)) {
+		l_error("l_dhcp_server_set_lease_time failed");
+		return false;
+	}
+
+	return true;
+}
+
 static bool ap_addr4_match_ifindex(const void *a, const void *b)
 {
 	const struct ap_rtnl_addr4_record *rec =3D a;
@@ -2525,7 +2596,8 @@ static void ap_netconfig_start(struct ap_state *ap)
 		goto error;
 =

 set_up_dhcp:
-	/* TODO */
+	if (!ap_setup_dhcp(ap))
+		goto error;
 =

 	/* See if the selected subnet is already set on the interface */
 	if (l_queue_find(ap->rtnl_addr4_dump, ap_addr4_match_subnet, ap)) {
@@ -2852,8 +2924,8 @@ void ap_free(struct ap_state *ap)
 {
 	ap_reset(ap);
 	l_genl_family_free(ap->nl80211);
-	if (ap->server)
-		l_dhcp_server_destroy(ap->server);
+	if (ap->dhcp)
+		l_dhcp_server_destroy(ap->dhcp);
 	l_free(ap);
 }
 =

-- =

2.27.0

--===============7451128377652229607==--

