Content-Type: multipart/mixed; boundary="===============3565127441715106269=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/11] ap: Dump addreses in use and assign local IP
Date: Mon, 10 May 2021 10:58:00 +0200
Message-ID: <20210510085806.174213-5-andrew.zaborowski@intel.com>
In-Reply-To: <20210510085806.174213-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3565127441715106269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

During AP start dump addresses in use by all netdevs, then handle the
local and global subnet address settings to select the final subnet and
IP and set that on the interface if not already set.

Restore the IP cleanup after stopping AP, removed temporarily in an
earlier commit.
---
 src/ap.c | 182 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 178 insertions(+), 4 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 872c0a1f..37b71a6f 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -89,12 +89,16 @@ struct ap_state {
 	struct l_queue *sta_states;
 =

 	struct l_dhcp_server *netconfig_dhcp;
+	uint32_t netconfig_addr4;
 	uint8_t netconfig_prefix_len4;
 	char **netconfig_addr4_str_list;
+	struct l_queue *netconfig_addr4_dump;
 	uint32_t rtnl_add_cmd;
+	uint32_t rtnl_dump_cmd;
 =

 	bool started : 1;
 	bool gtk_set : 1;
+	bool cleanup_addr4 : 1;
 	bool enable_netconfig4 : 1;
 };
 =

@@ -205,6 +209,13 @@ static void ap_reset(struct ap_state *ap)
 	if (ap->rtnl_add_cmd)
 		l_netlink_cancel(rtnl, ap->rtnl_add_cmd);
 =

+	if (ap->rtnl_dump_cmd) {
+		uint32_t cmd =3D ap->rtnl_dump_cmd;
+
+		ap->rtnl_dump_cmd =3D 0;
+		l_netlink_cancel(rtnl, cmd);
+	}
+
 	l_queue_destroy(ap->sta_states, ap_sta_free);
 =

 	if (ap->rates)
@@ -215,10 +226,29 @@ static void ap_reset(struct ap_state *ap)
 	ap->started =3D false;
 =

 	/* Delete IP if one was set by IWD */
+	if (ap->cleanup_addr4) {
+		struct in_addr ia;
+		char ip_str[16];
+		uint32_t broadcast =3D ap->netconfig_addr4 |
+			~util_netmask_from_prefix(ap->netconfig_prefix_len4);
+		char broadcast_str[16];
+
+		ia.s_addr =3D htonl(ap->netconfig_addr4);
+		strcpy(ip_str, inet_ntoa(ia));
+		ia.s_addr =3D htonl(broadcast);
+		strcpy(broadcast_str, inet_ntoa(ia));
+
+		l_rtnl_ifaddr4_delete(rtnl, netdev_get_ifindex(netdev),
+					ap->netconfig_prefix_len4, ip_str,
+					broadcast_str, NULL, NULL, NULL);
+		ap->cleanup_addr4 =3D false;
+	}
 =

 	if (ap->netconfig_dhcp)
 		l_dhcp_server_stop(ap->netconfig_dhcp);
 =

+	l_queue_destroy(ap->netconfig_addr4_dump, l_free);
+	ap->netconfig_addr4_dump =3D NULL;
 	l_strv_free(ap->netconfig_addr4_str_list);
 	ap->netconfig_addr4_str_list =3D NULL;
 }
@@ -2047,9 +2077,20 @@ static void ap_start_cb(struct l_genl_msg *msg, void=
 *user_data)
 		goto failed;
 	}
 =

-	if (ap->netconfig_dhcp && !l_dhcp_server_start(ap->netconfig_dhcp)) {
-		l_error("DHCP server failed to start");
-		goto failed;
+	if (ap->netconfig_dhcp) {
+		/*
+		 * l_dhcp_server_start() would retrieve the current IPv4 from
+		 * the interface but set it anyway in case there are multiple
+		 * addresses, saves one ioctl too.
+		 */
+		struct in_addr ia =3D { .s_addr =3D htonl(ap->netconfig_addr4) };
+
+		if (!l_dhcp_server_set_ip_address(ap->netconfig_dhcp,
+							inet_ntoa(ia)) ||
+				!l_dhcp_server_start(ap->netconfig_dhcp)) {
+			l_error("DHCP server failed to start");
+			goto failed;
+		}
 	}
 =

 	ap->started =3D true;
@@ -2737,6 +2778,130 @@ static int ap_load_config(struct ap_state *ap, cons=
t struct l_settings *config,
 	return 0;
 }
 =

+static void ap_netconfig_start(struct ap_state *ap)
+{
+	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
+	int ret;
+	struct in_addr ia;
+	char addr4_str[16];
+	char broadcast4_str[16];
+	uint32_t new_addr4;
+
+	/*
+	 * The address pool specified for this AP (if any) has the priority,
+	 * next is the address currently set on the interface (if any) and
+	 * last is the global AP address pool (APAddressPool setting).
+	 */
+	if (ap->netconfig_addr4_str_list)
+		ret =3D ap_select_addr4((const char **)
+					ap->netconfig_addr4_str_list,
+					ap->netconfig_prefix_len4,
+					ap->netconfig_addr4_dump, &new_addr4);
+	else if (ap->netconfig_addr4)
+		goto already_set;
+	else
+		ret =3D ap_select_addr4((const char **) global_addr_strs,
+					ap->netconfig_prefix_len4,
+					ap->netconfig_addr4_dump, &new_addr4);
+
+	if (ret)
+		goto error;
+
+	/* See if the selected subnet is already set on the interface */
+	if (new_addr4 =3D=3D ap->netconfig_addr4) {
+already_set:
+		/* Selected address already set, continue normally */
+		ap->cleanup_addr4 =3D false;
+
+		if (!ap_start_send(ap))
+			goto error;
+
+		goto cleanup;
+	}
+
+	ap->netconfig_addr4 =3D new_addr4;
+	ia.s_addr =3D htonl(ap->netconfig_addr4);
+	strcpy(addr4_str, inet_ntoa(ia));
+	ia.s_addr =3D htonl(ap->netconfig_addr4 |
+			~util_netmask_from_prefix(ap->netconfig_prefix_len4));
+	strcpy(broadcast4_str, inet_ntoa(ia));
+
+	ap->rtnl_add_cmd =3D l_rtnl_ifaddr4_add(rtnl, ifindex,
+						ap->netconfig_prefix_len4,
+						addr4_str, broadcast4_str,
+						ap_ifaddr4_added_cb, ap, NULL);
+	if (!ap->rtnl_add_cmd) {
+		l_error("Failed to add the IPv4 address");
+		goto error;
+	}
+
+	ap->cleanup_addr4 =3D true;
+
+cleanup:
+	l_queue_destroy(ap->netconfig_addr4_dump, l_free);
+	ap->netconfig_addr4_dump =3D NULL;
+	l_strv_free(ap->netconfig_addr4_str_list);
+	ap->netconfig_addr4_str_list =3D NULL;
+	return;
+
+error:
+	ap_start_failed(ap);
+}
+
+static void ap_ifaddr4_dump_cb(int error,
+				uint16_t type, const void *data,
+				uint32_t len, void *user_data)
+{
+	struct ap_state *ap =3D user_data;
+	const struct ifaddrmsg *ifa =3D data;
+	char *ip_str;
+	struct in_addr ia;
+	struct ap_rtnl_addr4_record *addr;
+
+	if (error) {
+		l_error("Error getting existing IPv4 addresses on AP iface");
+		return;
+	}
+
+	if (type !=3D RTM_NEWADDR || ifa->ifa_prefixlen < 1)
+		return;
+
+	l_rtnl_ifaddr4_extract(ifa, len, NULL, &ip_str, NULL);
+	inet_aton(ip_str, &ia);
+	l_free(ip_str);
+
+	/*
+	 * Don't add current subnets from the target interface to the used
+	 * subnet address list because we'll be replacing them (or adding
+	 * another secondary address) so there won't be a routing conflict.
+	 */
+	if (ifa->ifa_index =3D=3D netdev_get_ifindex(ap->netdev)) {
+		ap->netconfig_prefix_len4 =3D ifa->ifa_prefixlen;
+		ap->netconfig_addr4 =3D ntohl(ia.s_addr);
+		return;
+	}
+
+	addr =3D l_new(struct ap_rtnl_addr4_record, 1);
+	addr->prefix_len =3D ifa->ifa_prefixlen;
+	addr->addr =3D ntohl(ia.s_addr);
+
+	if (!ap->netconfig_addr4_dump)
+		ap->netconfig_addr4_dump =3D l_queue_new();
+
+	l_queue_push_tail(ap->netconfig_addr4_dump, addr);
+}
+
+static void ap_ifaddr4_dump_destroy_cb(void *user_data)
+{
+	struct ap_state *ap =3D user_data;
+
+	if (!ap->rtnl_dump_cmd)
+		return;
+
+	ap->rtnl_dump_cmd =3D 0;
+	ap_netconfig_start(ap);
+}
+
 /*
  * Start a simple independent WPA2 AP on given netdev.
  *
@@ -2832,7 +2997,16 @@ struct ap_state *ap_start(struct netdev *netdev, str=
uct l_settings *config,
 		l_error("Registering for MLME notification failed");
 =

 	if (ap->enable_netconfig4) {
-		/* TODO: select an IP address, set it and call ap_start_send */
+		ap->rtnl_dump_cmd =3D l_rtnl_ifaddr4_dump(rtnl,
+						ap_ifaddr4_dump_cb, ap,
+						ap_ifaddr4_dump_destroy_cb);
+		if (!ap->rtnl_dump_cmd) {
+			if (err_out)
+				*err_out =3D -EIO;
+
+			l_error("Sending the IPv4 addr dump req failed");
+			goto error;
+		}
 =

 		return ap;
 	}
-- =

2.27.0

--===============3565127441715106269==--

