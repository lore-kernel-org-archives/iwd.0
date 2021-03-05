Content-Type: multipart/mixed; boundary="===============2527234131897615579=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/10] ap: Dump addreses in use and assign IP/netmask
Date: Fri, 05 Mar 2021 16:09:31 +0100
Message-ID: <20210305150936.868546-5-andrew.zaborowski@intel.com>
In-Reply-To: <20210305150936.868546-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2527234131897615579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

During AP start dump addresses in use by all netdevs, handle the subnet
address and netmask settings ap->config to select the final IP/netmask
and set the on the interface if not already set.
---
 src/ap.c | 271 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 202 insertions(+), 69 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index fdb4b454..df3715a2 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -79,9 +79,10 @@ struct ap_state {
 	struct l_queue *sta_states;
 =

 	struct l_dhcp_server *server;
+	uint32_t addr4;
 	uint32_t rtnl_add_cmd;
-	char *own_ip;
-	unsigned int ip_prefix;
+	uint32_t rtnl_dump_cmd;
+	struct l_queue *rtnl_addr4_dump;
 =

 	bool started : 1;
 	bool gtk_set : 1;
@@ -119,23 +120,6 @@ static char **global_addr_strs;
 static uint32_t netdev_watch;
 struct l_netlink *rtnl;
 =

-static const char *broadcast_from_ip(const char *ip)
-{
-	struct in_addr ia;
-	uint32_t bcast;
-
-	if (inet_aton(ip, &ia) !=3D 1)
-		return NULL;
-
-	bcast =3D ntohl(ia.s_addr);
-	bcast &=3D 0xffffff00;
-	bcast |=3D 0x000000ff;
-
-	ia.s_addr =3D htonl(bcast);
-
-	return inet_ntoa(ia);
-}
-
 #define AP_DEFAULT_IPV4_PREFIX_LEN 28
 =

 struct ap_config *ap_config_load_profile(const char *ssid)
@@ -386,30 +370,35 @@ static void ap_reset(struct ap_state *ap)
 	if (ap->rates)
 		l_uintset_free(ap->rates);
 =

-	ap_config_free(ap->config);
-	ap->config =3D NULL;
-
 	l_queue_destroy(ap->wsc_pbc_probes, l_free);
 =

 	ap->started =3D false;
 =

 	/* Delete IP if one was set by IWD */
-	if (ap->cleanup_ip)
-		l_rtnl_ifaddr4_delete(rtnl, netdev_get_ifindex(netdev),
-					ap->ip_prefix, ap->own_ip,
-					broadcast_from_ip(ap->own_ip),
-					NULL, NULL, NULL);
+	if (ap->cleanup_ip) {
+		struct in_addr ia;
+		char ip_str[16];
+		char broadcast_str[16];
 =

-	if (ap->own_ip) {
-		/* Release IP from pool if used */
-		if (ap->use_ip_pool)
-			ip_pool_put(ap->own_ip);
+		ia.s_addr =3D htonl(ap->addr4);
+		strcpy(ip_str, inet_ntoa(ia));
+		ia.s_addr =3D htonl(ap->addr4 | ~util_netmask_from_prefix(
+						ap->config->prefix_len4));
+		strcpy(broadcast_str, inet_ntoa(ia));
 =

-		l_free(ap->own_ip);
+		l_rtnl_ifaddr4_delete(rtnl, netdev_get_ifindex(netdev),
+					ap->config->prefix_len4, ip_str,
+					broadcast_str, NULL, NULL, NULL);
 	}
 =

+	ap_config_free(ap->config);
+	ap->config =3D NULL;
+
 	if (ap->server)
 		l_dhcp_server_stop(ap->server);
+
+	l_queue_destroy(ap->rtnl_addr4_dump, l_free);
+	ap->rtnl_addr4_dump =3D NULL;
 }
 =

 static void ap_del_station(struct sta_state *sta, uint16_t reason,
@@ -2246,34 +2235,41 @@ static struct l_genl_msg *ap_build_cmd_start_ap(str=
uct ap_state *ap)
 	return cmd;
 }
 =

-static void ap_ifaddr4_added_cb(int error, uint16_t type, const void *data,
-				uint32_t len, void *user_data)
+static bool ap_start_send(struct ap_state *ap)
 {
-	struct ap_state *ap =3D user_data;
-	struct l_genl_msg *cmd;
-
-	ap->rtnl_add_cmd =3D 0;
+	struct l_genl_msg *cmd =3D ap_build_cmd_start_ap(ap);
 =

-	if (error) {
-		l_error("Failed to set IP address");
-		goto error;
+	if (!cmd) {
+		l_error("ap_build_cmd_start_ap failed");
+		return false;
 	}
 =

-	cmd =3D ap_build_cmd_start_ap(ap);
-	if (!cmd)
-		goto error;
-
 	ap->start_stop_cmd_id =3D l_genl_family_send(ap->nl80211, cmd,
 							ap_start_cb, ap, NULL);
 	if (!ap->start_stop_cmd_id) {
+		l_error("AP_START l_genl_family_send failed");
 		l_genl_msg_unref(cmd);
-		goto error;
+		return false;
 	}
 =

-	return;
+	return true;
+}
 =

-error:
-	ap_start_failed(ap);
+static void ap_ifaddr4_added_cb(int error, uint16_t type, const void *data,
+				uint32_t len, void *user_data)
+{
+	struct ap_state *ap =3D user_data;
+
+	ap->rtnl_add_cmd =3D 0;
+
+	if (error) {
+		l_error("Failed to set IP address");
+		ap_start_failed(ap);
+		return;
+	}
+
+	if (!ap_start_send(ap))
+		ap_start_failed(ap);
 }
 =

 static bool ap_parse_new_station_ies(const void *data, uint16_t len,
@@ -2468,6 +2464,146 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
void *user_data)
 	}
 }
 =

+static bool ap_addr4_match_ifindex(const void *a, const void *b)
+{
+	const struct ap_rtnl_addr4_record *rec =3D a;
+	const uint32_t *ifindex =3D b;
+
+	return rec->ifindex =3D=3D *ifindex && rec->addr && rec->prefix_len <=3D =
30;
+}
+
+static bool ap_addr4_match_subnet(const void *a, const void *b)
+{
+	const struct ap_rtnl_addr4_record *rec =3D a;
+	const struct ap_state *ap =3D b;
+	uint32_t netmask =3D util_netmask_from_prefix(rec->prefix_len);
+
+	return rec->prefix_len <=3D ap->config->prefix_len4 &&
+		((rec->addr ^ ap->addr4) & netmask) =3D=3D 0;
+}
+
+static void ap_netconfig_start(struct ap_state *ap)
+{
+	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
+	int ret;
+	struct in_addr ia;
+	char addr_str[16];
+	char broadcast_str[16];
+
+	if (!ap->config->prefix_len4)
+		ap->config->prefix_len4 =3D AP_DEFAULT_IPV4_PREFIX_LEN;
+
+	/*
+	 * The address pool specified for this AP has the priority (if any),
+	 * next is the address currently set on the interface (if any) and
+	 * last is the global AP address pool (APAddressPool setting).
+	 */
+	if (ap->config->addr4_str_list)
+		ret =3D ap_select_addr4((const char **)
+					ap->config->addr4_str_list,
+					ap->config->prefix_len4,
+					ap->rtnl_addr4_dump, ifindex,
+					&ap->addr4);
+	else {
+		const struct ap_rtnl_addr4_record *match =3D
+			l_queue_find(ap->rtnl_addr4_dump,
+					ap_addr4_match_ifindex,
+					&ifindex);
+		if (match) {
+			ap->addr4 =3D match->addr;
+			ap->config->prefix_len4 =3D match->prefix_len;
+			goto set_up_dhcp;
+		}
+
+		ret =3D ap_select_addr4((const char **) global_addr_strs,
+					ap->config->prefix_len4,
+					ap->rtnl_addr4_dump, ifindex,
+					&ap->addr4);
+	}
+
+	if (ret)
+		goto error;
+
+set_up_dhcp:
+	/* TODO */
+
+	/* See if the selected subnet is already set on the interface */
+	if (l_queue_find(ap->rtnl_addr4_dump, ap_addr4_match_subnet, ap)) {
+		/* Selected address already set, continue normally */
+		ap->cleanup_ip =3D false;
+
+		if (!ap_start_send(ap))
+			goto error;
+
+		return;
+	}
+
+	ia.s_addr =3D htonl(ap->addr4);
+	strcpy(addr_str, inet_ntoa(ia));
+	ia.s_addr =3D htonl(ap->addr4 |
+			~util_netmask_from_prefix(ap->config->prefix_len4));
+	strcpy(broadcast_str, inet_ntoa(ia));
+
+	ap->rtnl_add_cmd =3D l_rtnl_ifaddr4_add(rtnl, ifindex,
+					ap->config->prefix_len4,
+					addr_str, broadcast_str,
+					ap_ifaddr4_added_cb, ap, NULL);
+	if (!ap->rtnl_add_cmd) {
+		l_error("Failed to add the IPv4 address");
+		goto error;
+	}
+
+	ap->cleanup_ip =3D true;
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
+	addr =3D l_new(struct ap_rtnl_addr4_record, 1);
+	addr->ifindex =3D ifa->ifa_index;
+	addr->prefix_len =3D ifa->ifa_prefixlen;
+	addr->addr =3D ntohl(ia.s_addr);
+
+	if (!ap->rtnl_addr4_dump)
+		ap->rtnl_addr4_dump =3D l_queue_new();
+
+	l_queue_push_tail(ap->rtnl_addr4_dump, addr);
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
@@ -2486,12 +2622,10 @@ struct ap_state *ap_start(struct netdev *netdev, st=
ruct ap_config *config,
 {
 	struct ap_state *ap;
 	struct wiphy *wiphy =3D netdev_get_wiphy(netdev);
-	struct l_genl_msg *cmd;
 	uint64_t wdev_id =3D netdev_get_wdev_id(netdev);
-	int err =3D -EINVAL;
 =

 	if (err_out)
-		*err_out =3D err;
+		*err_out =3D -EINVAL;
 =

 	if (L_WARN_ON(!config->ssid))
 		return NULL;
@@ -2589,29 +2723,28 @@ struct ap_state *ap_start(struct netdev *netdev, st=
ruct ap_config *config,
 		l_error("Registering for MLME notification failed");
 =

 	if (netconfig_enabled && !ap->config->disable_netconfig4) {
-		/* TODO: Start netconfig */
-	}
-
-	cmd =3D ap_build_cmd_start_ap(ap);
-	if (!cmd)
-		goto error;
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

-	ap->start_stop_cmd_id =3D l_genl_family_send(ap->nl80211, cmd,
-							ap_start_cb, ap, NULL);
-	if (!ap->start_stop_cmd_id) {
-		l_genl_msg_unref(cmd);
-		goto error;
+		return ap;
 	}
 =

-	if (err_out)
-		*err_out =3D 0;
+	if (ap_start_send(ap)) {
+		if (err_out)
+			*err_out =3D 0;
 =

-	return ap;
+		return ap;
+	}
 =

 error:
-	if (err_out)
-		*err_out =3D err;
-
 	ap->config =3D NULL;
 	ap_reset(ap);
 	l_genl_family_free(ap->nl80211);
-- =

2.27.0

--===============2527234131897615579==--

