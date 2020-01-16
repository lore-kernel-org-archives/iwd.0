Content-Type: multipart/mixed; boundary="===============1401162447665807298=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/4] netdev: Drop the netdev_frame_watch API
Date: Thu, 16 Jan 2020 03:41:00 +0100
Message-ID: <20200116024100.18371-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200116024100.18371-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1401162447665807298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 150 ---------------------------------------------------
 src/netdev.h |  10 ----
 2 files changed, 160 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index ff56b78f..0a287a42 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -132,8 +132,6 @@ struct netdev {
 	void *set_powered_user_data;
 	netdev_destroy_func_t set_powered_destroy;
 =

-	struct watchlist frame_watches;
-
 	struct watchlist station_watches;
 =

 	struct l_io *pae_io;  /* for drivers without EAPoL over NL80211 */
@@ -163,13 +161,6 @@ struct netdev_watch {
 	void *user_data;
 };
 =

-struct netdev_frame_watch {
-	uint16_t frame_type;
-	uint8_t *prefix;
-	size_t prefix_len;
-	struct watchlist_item super;
-};
-
 static struct l_netlink *rtnl =3D NULL;
 static struct l_genl_family *nl80211;
 static struct l_queue *netdev_list;
@@ -629,7 +620,6 @@ static void netdev_free(void *data)
 =

 	scan_wdev_remove(netdev->wdev_id);
 =

-	watchlist_destroy(&netdev->frame_watches);
 	watchlist_destroy(&netdev->station_watches);
 =

 	l_io_destroy(netdev->pae_io);
@@ -3404,74 +3394,6 @@ static void netdev_mlme_notify(struct l_genl_msg *ms=
g, void *user_data)
 	}
 }
 =

-struct frame_prefix_info {
-	uint16_t frame_type;
-	const uint8_t *body;
-	size_t body_len;
-};
-
-static bool netdev_frame_watch_match_prefix(const void *a, const void *b)
-{
-	const struct watchlist_item *item =3D a;
-	const struct netdev_frame_watch *fw =3D
-		l_container_of(item, struct netdev_frame_watch, super);
-	const struct frame_prefix_info *info =3D b;
-
-	return fw->frame_type =3D=3D info->frame_type &&
-		fw->prefix_len <=3D info->body_len &&
-		(fw->prefix_len =3D=3D 0 ||
-		 !memcmp(fw->prefix, info->body, fw->prefix_len));
-}
-
-static void netdev_mgmt_frame_event(struct l_genl_msg *msg,
-					struct netdev *netdev)
-{
-	struct l_genl_attr attr;
-	uint16_t type, len, frame_len;
-	const void *data;
-	const struct mmpdu_header *mpdu =3D NULL;
-	const uint8_t *body;
-	struct frame_prefix_info info;
-
-	if (!l_genl_attr_init(&attr, msg))
-		return;
-
-	while (l_genl_attr_next(&attr, &type, &len, &data)) {
-		switch (type) {
-		case NL80211_ATTR_FRAME:
-			if (mpdu)
-				return;
-
-			mpdu =3D mpdu_validate(data, len);
-			if (!mpdu)
-				l_error("Frame didn't validate as MMPDU");
-
-			frame_len =3D len;
-			break;
-		}
-	}
-
-	if (!mpdu)
-		return;
-
-	body =3D mmpdu_body(mpdu);
-
-	if (memcmp(mpdu->address_1, netdev->addr, 6) &&
-			!util_is_broadcast_address(mpdu->address_1))
-		return;
-
-	/* Only match the frame type and subtype like the kernel does */
-#define FC_FTYPE_STYPE_MASK 0x00fc
-	info.frame_type =3D l_get_le16(mpdu) & FC_FTYPE_STYPE_MASK;
-	info.body =3D (const uint8_t *) body;
-	info.body_len =3D (const uint8_t *) mpdu + frame_len - body;
-
-	WATCHLIST_NOTIFY_MATCHES(&netdev->frame_watches,
-					netdev_frame_watch_match_prefix, &info,
-					netdev_frame_watch_func_t,
-					netdev, mpdu, body, info.body_len);
-}
-
 static void netdev_pae_destroy(void *user_data)
 {
 	struct netdev *netdev =3D user_data;
@@ -3692,9 +3614,6 @@ static void netdev_unicast_notify(struct l_genl_msg *=
msg, void *user_data)
 		return;
 =

 	switch (cmd) {
-	case NL80211_CMD_FRAME:
-		netdev_mgmt_frame_event(msg, netdev);
-		break;
 	case NL80211_CMD_CONTROL_PORT_FRAME:
 		netdev_control_port_frame_event(msg, netdev);
 		break;
@@ -4313,74 +4232,6 @@ static void netdev_getlink_cb(int error, uint16_t ty=
pe, const void *data,
 					NULL);
 }
 =

-static void netdev_frame_watch_free(struct watchlist_item *item)
-{
-	struct netdev_frame_watch *fw =3D
-		l_container_of(item, struct netdev_frame_watch, super);
-
-	l_free(fw->prefix);
-	l_free(fw);
-}
-
-static const struct watchlist_ops netdev_frame_watch_ops =3D {
-	.item_free =3D netdev_frame_watch_free,
-};
-
-static void netdev_frame_cb(struct l_genl_msg *msg, void *user_data)
-{
-	if (l_genl_msg_get_error(msg) < 0)
-		l_error("Could not register frame watch type %04x: %i",
-			L_PTR_TO_UINT(user_data), l_genl_msg_get_error(msg));
-}
-
-uint32_t netdev_frame_watch_add(struct netdev *netdev, uint16_t frame_type,
-				const uint8_t *prefix, size_t prefix_len,
-				netdev_frame_watch_func_t handler,
-				void *user_data)
-{
-	struct netdev_frame_watch *fw;
-	struct l_genl_msg *msg;
-	struct frame_prefix_info info =3D { frame_type, prefix, prefix_len };
-	bool registered;
-	uint32_t id;
-
-	registered =3D l_queue_find(netdev->frame_watches.items,
-					netdev_frame_watch_match_prefix,
-					&info);
-
-	fw =3D l_new(struct netdev_frame_watch, 1);
-	fw->frame_type =3D frame_type;
-	fw->prefix =3D prefix_len ? l_memdup(prefix, prefix_len) : NULL;
-	fw->prefix_len =3D prefix_len;
-	id =3D watchlist_link(&netdev->frame_watches, &fw->super,
-						handler, user_data, NULL);
-
-	if (registered)
-		return id;
-
-	msg =3D l_genl_msg_new_sized(NL80211_CMD_REGISTER_FRAME, 32 + prefix_len);
-
-	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_TYPE, 2, &frame_type);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_MATCH,
-				prefix_len, prefix);
-
-	l_genl_family_send(nl80211, msg, netdev_frame_cb,
-			L_UINT_TO_PTR(frame_type), NULL);
-
-	return id;
-}
-
-bool netdev_frame_watch_remove(struct netdev *netdev, uint32_t id)
-{
-	/*
-	 * There's no way to unregister from notifications but that's not a
-	 * problem, we leave them active in the kernel but
-	 * netdev_mgmt_frame_event will ignore these events.
-	 */
-	return watchlist_remove(&netdev->frame_watches, id);
-}
-
 static struct l_io *pae_open(uint32_t ifindex)
 {
 	/*
@@ -4506,7 +4357,6 @@ struct netdev *netdev_create_from_genl(struct l_genl_=
msg *msg,
 							netdev_pae_destroy);
 	}
 =

-	watchlist_init(&netdev->frame_watches, &netdev_frame_watch_ops);
 	watchlist_init(&netdev->station_watches, NULL);
 =

 	l_queue_push_tail(netdev_list, netdev);
diff --git a/src/netdev.h b/src/netdev.h
index 366dc1ab..f87e7e49 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -112,10 +112,6 @@ typedef void (*netdev_neighbor_report_cb_t)(struct net=
dev *netdev, int err,
 typedef void (*netdev_preauthenticate_cb_t)(struct netdev *netdev,
 					enum netdev_result result,
 					const uint8_t *pmk, void *user_data);
-typedef void (*netdev_frame_watch_func_t)(struct netdev *netdev,
-					const struct mmpdu_header *frame,
-					const void *body, size_t body_len,
-					void *user_data);
 typedef void (*netdev_station_watch_func_t)(struct netdev *netdev,
 					const uint8_t *mac, bool added,
 					void *user_data);
@@ -180,12 +176,6 @@ int netdev_neighbor_report_req(struct netdev *netdev,
 int netdev_set_rssi_report_levels(struct netdev *netdev, const int8_t *lev=
els,
 					size_t levels_num);
 =

-uint32_t netdev_frame_watch_add(struct netdev *netdev, uint16_t frame_type,
-				const uint8_t *prefix, size_t prefix_len,
-				netdev_frame_watch_func_t handler,
-				void *user_data);
-bool netdev_frame_watch_remove(struct netdev *netdev, uint32_t id);
-
 void netdev_handshake_failed(struct handshake_state *hs, uint16_t reason_c=
ode);
 =

 struct netdev *netdev_find(int ifindex);
-- =

2.20.1

--===============1401162447665807298==--

