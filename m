Content-Type: multipart/mixed; boundary="===============8482820509012333238=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/3] netdev: support per-network MAC addresses
Date: Wed, 18 Mar 2020 10:20:49 -0700
Message-ID: <20200318172050.8989-2-prestwoj@gmail.com>
In-Reply-To: <20200318172050.8989-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8482820509012333238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For privacy reasons its advantageous to randomize or mask
the MAC address when connecting to networks, especially public
networks.

This patch allows netdev to generate a new MAC address on a
per-network basis. The generated MAC will remain the same when
connecting to the same network. This allows reauthentications
or roaming to work, and not have to fully re-connect (which would
be required if the MAC changed on every connection).

Changing the MAC requires bringing the interface down. This does
lead to potential race conditions with respect to external
processes. There are two potential conditions which are explained
in a TODO comment in this patch.
---
 src/netdev.c | 247 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 233 insertions(+), 14 deletions(-)

v2:
 * Removed SET_MAC_FAILED. This was only useful for logging any MAC
   related error messages which were already logged in netdev. The
   actually handling of this was the same as other failures so there
   was no need for it.
 * Continue on with connection in event of strange failures. These
   type of failures are most likely never going to happen. There are
   plenty of log messages just in case.
 * Added a check in netdev_get_is_up. If we are in the middle of a
   MAC change we just return that the interface is up. This is to
   keep direct device queries consistent with the state of the rest
   of the system.
 * Removed the MAC change type enum. Netdev now reads settings fil
   itself. netdev_create_from_genl remains unchanged

diff --git a/src/netdev.c b/src/netdev.c
index c11a483f..8d499856 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -109,6 +109,7 @@ struct netdev {
 	uint32_t set_interface_cmd_id;
 	uint32_t rekey_offload_cmd_id;
 	uint32_t qos_map_cmd_id;
+	uint32_t mac_change_cmd_id;
 	enum netdev_result result;
 	uint16_t last_code; /* reason or status, depending on result */
 	struct l_timeout *neighbor_report_timeout;
@@ -165,6 +166,7 @@ static struct l_genl_family *nl80211;
 static struct l_queue *netdev_list;
 static struct watchlist netdev_watches;
 static bool pae_over_nl80211;
+static bool mac_per_ssid;
 =

 static void do_debug(const char *str, void *user_data)
 {
@@ -285,7 +287,19 @@ const char *netdev_get_name(struct netdev *netdev)
 =

 bool netdev_get_is_up(struct netdev *netdev)
 {
-	return (netdev->ifi_flags & IFF_UP) !=3D 0;
+	bool powered =3D (netdev->ifi_flags & IFF_UP) !=3D 0;
+
+	/*
+	 * If we are in the middle of changing the MAC we are in somewhat of a
+	 * no mans land. Technically the iface may be down, but since we are
+	 * not emitting any netdev DOWN events we want netdev_get_is_up to
+	 * reflect the same state. Once MAC changing finishes any pending
+	 * DOWN events will be emitted.
+	 */
+	if (netdev->mac_change_cmd_id && !powered)
+		return true;
+
+	return powered;
 }
 =

 struct handshake_state *netdev_get_handshake(struct netdev *netdev)
@@ -613,6 +627,11 @@ static void netdev_free(void *data)
 		netdev->qos_map_cmd_id =3D 0;
 	}
 =

+	if (netdev->mac_change_cmd_id) {
+		l_netlink_cancel(rtnl, netdev->mac_change_cmd_id);
+		netdev->mac_change_cmd_id =3D 0;
+	}
+
 	if (netdev->events_ready)
 		WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
 					netdev, NETDEV_WATCH_EVENT_DEL);
@@ -2377,13 +2396,15 @@ static struct l_genl_msg *netdev_build_cmd_connect(=
struct netdev *netdev,
 	return msg;
 }
 =

-static int netdev_connect_common(struct netdev *netdev,
-					struct l_genl_msg *cmd_connect,
-					struct scan_bss *bss,
-					struct handshake_state *hs,
-					struct eapol_sm *sm,
-					netdev_event_func_t event_filter,
-					netdev_connect_cb_t cb, void *user_data)
+struct rtnl_data {
+	struct netdev *netdev;
+	struct l_genl_msg *cmd_connect;
+	uint8_t addr[ETH_ALEN];
+	int ref;
+};
+
+static int netdev_begin_connection(struct netdev *netdev,
+					struct l_genl_msg *cmd_connect)
 {
 	if (cmd_connect) {
 		netdev->connect_cmd_id =3D l_genl_family_send(nl80211,
@@ -2396,6 +2417,187 @@ static int netdev_connect_common(struct netdev *net=
dev,
 		}
 	}
 =

+	handshake_state_set_supplicant_address(netdev->handshake, netdev->addr);
+
+	/* set connected since the auth protocols cannot do so internally */
+	if (netdev->ap && auth_proto_start(netdev->ap))
+		netdev->connected =3D true;
+
+	return 0;
+}
+
+static void netdev_mac_change_failed(struct netdev *netdev,
+					struct rtnl_data *req, int error)
+{
+	l_error("Error setting mac address on %d: %s", netdev->index,
+			strerror(-error));
+
+	netdev->mac_change_cmd_id =3D 0;
+
+	/*
+	 * If the interface is down and we failed to up it we need to notify
+	 * any watchers since we have been skipping the notification while
+	 * mac_change_cmd_id was set.
+	 */
+	if (!netdev_get_is_up(netdev)) {
+		l_genl_msg_unref(req->cmd_connect);
+
+		WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
+				netdev, NETDEV_WATCH_EVENT_DOWN);
+
+		goto failed;
+	} else {
+		/*
+		 * If the interface is up we can still try and connect. This
+		 * is a very rare case and most likely will never happen.
+		 */
+		l_info("Interface still up after failing to change the MAC, "
+			"continuing with connection");
+		if (netdev_begin_connection(netdev, req->cmd_connect) < 0)
+			goto failed;
+
+		return;
+	}
+
+failed:
+	netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+				MMPDU_STATUS_CODE_UNSPECIFIED);
+}
+
+static void netdev_mac_destroy(void *user_data)
+{
+	struct rtnl_data *req =3D user_data;
+
+	req->ref--;
+
+	/* still pending requests? */
+	if (req->ref)
+		return;
+
+	l_free(req);
+}
+
+static void netdev_mac_power_up_cb(int error, uint16_t type,
+					const void *data, uint32_t len,
+					void *user_data)
+{
+	struct rtnl_data *req =3D user_data;
+	struct netdev *netdev =3D req->netdev;
+
+	netdev->mac_change_cmd_id =3D 0;
+
+	if (error) {
+		l_error("Error taking interface %u up for per-network MAC "
+			"generation: %s", netdev->index, strerror(-error));
+		netdev_mac_change_failed(netdev, req, error);
+		return;
+	}
+
+	/*
+	 * Pick up where we left off in netdev_connect_commmon.
+	 */
+	if (netdev_begin_connection(netdev, req->cmd_connect) < 0) {
+		l_error("Failed to connect after changing MAC");
+		netdev_connect_failed(netdev, NETDEV_RESULT_ASSOCIATION_FAILED,
+				MMPDU_STATUS_CODE_UNSPECIFIED);
+	}
+}
+
+static void netdev_mac_power_down_cb(int error, uint16_t type,
+					const void *data, uint32_t len,
+					void *user_data)
+{
+	struct rtnl_data *req =3D user_data;
+	struct netdev *netdev =3D req->netdev;
+
+	if (error) {
+		l_error("Error taking interface %u down for per-network MAC "
+			"generation: %s", netdev->index, strerror(-error));
+		netdev_mac_change_failed(netdev, req, error);
+		return;
+	}
+
+	l_debug("Setting generated address on ifindex: %d to: "MAC,
+					netdev->index, MAC_STR(req->addr));
+	netdev->mac_change_cmd_id =3D l_rtnl_set_mac(rtnl, netdev->index,
+					req->addr, true,
+					netdev_mac_power_up_cb, req,
+					netdev_mac_destroy);
+	if (!netdev->mac_change_cmd_id) {
+		netdev_mac_change_failed(netdev, req, -EIO);
+		return;
+	}
+
+	req->ref++;
+}
+
+/*
+ * TODO: There are some potential race conditions that are being ignored. =
There
+ *       is nothing that IWD itself can do to solve these, they require ke=
rnel
+ *       changes:
+ *
+ * 1. A perfectly timed ifdown could be ignored. If an external process
+ *    brings down an interface just before calling this function we would =
only
+ *    get a single newlink event since there is no state change doing a se=
cond
+ *    ifdown (nor an error from the kernel). This newlink event would be i=
gnored
+ *    since IWD thinks its from our own doing. This would result in IWD ch=
anging
+ *    the MAC and bringing the interface back up which would look very str=
ange
+ *    and unexpected to someone who just tried to ifdown an interface.
+ *
+ * 2. A perfectly timed ifup could result in a failed connection. If an ex=
ternal
+ *    process ifup's just after IWD ifdown's but before changing the MAC t=
his
+ *    would cause the MAC change to fail. This failure would result in a f=
ailed
+ *    connection.
+ *
+ * Returns 0 if a MAC change procedure was started.
+ * Returns -EALREADY if the requested MAC matched our current MAC
+ * Returns -EIO if there was an IO error when powering down
+ */
+static int netdev_start_powered_mac_change(struct netdev *netdev,
+					struct scan_bss *bss,
+					struct l_genl_msg *cmd_connect)
+{
+	struct rtnl_data *req;
+	uint8_t new_addr[6];
+
+	wiphy_generate_address_from_ssid(netdev->wiphy, (const char *)bss->ssid,
+						new_addr);
+
+	/*
+	 * MAC has already been changed previously, no need to again
+	 */
+	if (!memcmp(new_addr, netdev->addr, sizeof(new_addr)))
+		return -EALREADY;
+
+	req =3D l_new(struct rtnl_data, 1);
+	req->netdev =3D netdev;
+	/* This message will need to be unreffed upon any error */
+	req->cmd_connect =3D cmd_connect;
+	req->ref++;
+	memcpy(req->addr, new_addr, sizeof(req->addr));
+
+	netdev->mac_change_cmd_id =3D l_rtnl_set_powered(rtnl, netdev->index,
+					false, netdev_mac_power_down_cb,
+					req, netdev_mac_destroy);
+
+	if (!netdev->mac_change_cmd_id) {
+		l_genl_msg_unref(req->cmd_connect);
+		l_free(req);
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int netdev_connect_common(struct netdev *netdev,
+					struct l_genl_msg *cmd_connect,
+					struct scan_bss *bss,
+					struct handshake_state *hs,
+					struct eapol_sm *sm,
+					netdev_event_func_t event_filter,
+					netdev_connect_cb_t cb, void *user_data)
+{
 	netdev->event_filter =3D event_filter;
 	netdev->connect_cb =3D cb;
 	netdev->user_data =3D user_data;
@@ -2407,17 +2609,21 @@ static int netdev_connect_common(struct netdev *net=
dev,
 	netdev_rssi_level_init(netdev);
 =

 	handshake_state_set_authenticator_address(hs, bss->addr);
-	handshake_state_set_supplicant_address(hs, netdev->addr);
 =

 	if (!wiphy_has_ext_feature(netdev->wiphy,
 					NL80211_EXT_FEATURE_CAN_REPLACE_PTK0))
 		handshake_state_set_no_rekey(hs, true);
 =

-	/* set connected since the auth protocols cannot do so internally */
-	if (netdev->ap && auth_proto_start(netdev->ap))
-		netdev->connected =3D true;
+	if (mac_per_ssid) {
+		int ret =3D netdev_start_powered_mac_change(netdev, bss,
+								cmd_connect);
+		if (ret =3D=3D 0)
+			return 0;
+		else if (ret !=3D -EALREADY)
+			return ret;
+	}
 =

-	return 0;
+	return netdev_begin_connection(netdev, cmd_connect);
 }
 =

 int netdev_connect(struct netdev *netdev, struct scan_bss *bss,
@@ -4071,7 +4277,14 @@ static void netdev_newlink_notify(const struct ifinf=
omsg *ifi, int bytes)
 =

 	new_up =3D netdev_get_is_up(netdev);
 =

-	if (old_up !=3D new_up)
+	/*
+	 * If mac_change_cmd_id is set we are in the process of changing the
+	 * MAC address and this event is a result of powering down/up. In this
+	 * case we do not want to emit a netdev DOWN/UP event as this would
+	 * cause other modules to behave as such. We do, however, want to emit
+	 * address changes so other modules get the new MAC address updated.
+	 */
+	if (old_up !=3D new_up && !netdev->mac_change_cmd_id)
 		WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
 				netdev, new_up ? NETDEV_WATCH_EVENT_UP :
 						NETDEV_WATCH_EVENT_DOWN);
@@ -4453,6 +4666,7 @@ static int netdev_init(void)
 {
 	struct l_genl *genl =3D iwd_get_genl();
 	const struct l_settings *settings =3D iwd_get_config();
+	const char *rand_addr_str;
 =

 	if (rtnl)
 		return -EALREADY;
@@ -4488,6 +4702,11 @@ static int netdev_init(void)
 					&pae_over_nl80211))
 		pae_over_nl80211 =3D true;
 =

+	rand_addr_str =3D l_settings_get_value(settings, "General",
+						"AddressRandomization");
+	if (rand_addr_str && !strcmp(rand_addr_str, "network"))
+		mac_per_ssid =3D true;
+
 	watchlist_init(&netdev_watches, NULL);
 	netdev_list =3D l_queue_new();
 =

-- =

2.21.1

--===============8482820509012333238==--

