Content-Type: multipart/mixed; boundary="===============2801727758339574464=="
MIME-Version: 1.0
From: Andrew Zaborowski <balrogg@gmail.com>
Subject: [PATCH 01/11] netdev: Add a wdev_id based frame watch API
Date: Mon, 21 Oct 2019 15:55:00 +0200
Message-ID: <20191021135510.12657-1-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2801727758339574464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

Allow watching for frames on interfaces that have no netdev in the
kernel and can only be referenced through the wdev_id instead of the
ifindex.
---
 src/netdev.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++-----
 src/netdev.h |  6 ++++
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 350ade98..526480dd 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -167,6 +167,7 @@ struct netdev_frame_watch {
 	uint16_t frame_type;
 	uint8_t *prefix;
 	size_t prefix_len;
+	uint64_t wdev_id;
 	struct watchlist_item super;
 };
 =

@@ -174,6 +175,7 @@ static struct l_netlink *rtnl =3D NULL;
 static struct l_genl_family *nl80211;
 static struct l_queue *netdev_list;
 static struct watchlist netdev_watches;
+static struct watchlist wdev_frame_watches;
 =

 static void do_debug(const char *str, void *user_data)
 {
@@ -3482,6 +3484,7 @@ struct frame_prefix_info {
 	uint16_t frame_type;
 	const uint8_t *body;
 	size_t body_len;
+	uint64_t wdev_id;
 };
 =

 static bool netdev_frame_watch_match_prefix(const void *a, const void *b)
@@ -3494,11 +3497,13 @@ static bool netdev_frame_watch_match_prefix(const v=
oid *a, const void *b)
 	return fw->frame_type =3D=3D info->frame_type &&
 		fw->prefix_len <=3D info->body_len &&
 		(fw->prefix_len =3D=3D 0 ||
-		 !memcmp(fw->prefix, info->body, fw->prefix_len));
+		 !memcmp(fw->prefix, info->body, fw->prefix_len)) &&
+		(!info->wdev_id || info->wdev_id =3D=3D fw->wdev_id);
 }
 =

 static void netdev_mgmt_frame_event(struct l_genl_msg *msg,
-					struct netdev *netdev)
+					struct netdev *netdev,
+					uint64_t wdev_id)
 {
 	struct l_genl_attr attr;
 	uint16_t type, len, frame_len;
@@ -3530,7 +3535,7 @@ static void netdev_mgmt_frame_event(struct l_genl_msg=
 *msg,
 =

 	body =3D mmpdu_body(mpdu);
 =

-	if (memcmp(mpdu->address_1, netdev->addr, 6) &&
+	if (netdev && memcmp(mpdu->address_1, netdev->addr, 6) &&
 			!util_is_broadcast_address(mpdu->address_1))
 		return;
 =

@@ -3539,11 +3544,18 @@ static void netdev_mgmt_frame_event(struct l_genl_m=
sg *msg,
 	info.frame_type =3D l_get_le16(mpdu) & FC_FTYPE_STYPE_MASK;
 	info.body =3D (const uint8_t *) body;
 	info.body_len =3D (const uint8_t *) mpdu + frame_len - body;
+	info.wdev_id =3D netdev ? 0 : wdev_id;
 =

-	WATCHLIST_NOTIFY_MATCHES(&netdev->frame_watches,
+	if (netdev)
+		WATCHLIST_NOTIFY_MATCHES(&netdev->frame_watches,
 					netdev_frame_watch_match_prefix, &info,
 					netdev_frame_watch_func_t,
 					netdev, mpdu, body, info.body_len);
+	else
+		WATCHLIST_NOTIFY_MATCHES(&wdev_frame_watches,
+					netdev_frame_watch_match_prefix, &info,
+					netdev_frame_watch_func_t,
+					NULL, mpdu, body, info.body_len);
 }
 =

 static void netdev_pae_destroy(void *user_data)
@@ -3735,6 +3747,7 @@ static int netdev_control_port_frame(uint32_t ifindex,
 static void netdev_unicast_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev *netdev =3D NULL;
+	const uint64_t *wdev_id =3D NULL;
 	struct l_genl_attr attr;
 	uint16_t type, len;
 	const void *data;
@@ -3759,17 +3772,28 @@ static void netdev_unicast_notify(struct l_genl_msg=
 *msg, void *user_data)
 =

 			netdev =3D netdev_find(*((uint32_t *) data));
 			break;
+		case NL80211_ATTR_WDEV:
+			if (len !=3D sizeof(uint64_t)) {
+				l_warn("Invalid wdev attribute");
+				return;
+			}
+
+			wdev_id =3D data;
+			break;
 		}
 	}
 =

-	if (!netdev)
-		return;
-
 	switch (cmd) {
 	case NL80211_CMD_FRAME:
-		netdev_mgmt_frame_event(msg, netdev);
+		if (!wdev_id)
+			break;
+
+		netdev_mgmt_frame_event(msg, netdev, *wdev_id);
 		break;
 	case NL80211_CMD_CONTROL_PORT_FRAME:
+		if (!netdev)
+			break;
+
 		netdev_control_port_frame_event(msg, netdev);
 		break;
 	}
@@ -4456,6 +4480,50 @@ bool netdev_frame_watch_remove(struct netdev *netdev=
, uint32_t id)
 	return watchlist_remove(&netdev->frame_watches, id);
 }
 =

+uint32_t netdev_wdev_frame_watch_add(uint64_t wdev_id, uint16_t frame_type,
+				const uint8_t *prefix, size_t prefix_len,
+				netdev_frame_watch_func_t handler,
+				void *user_data)
+{
+	struct netdev_frame_watch *fw;
+	struct l_genl_msg *msg;
+	struct frame_prefix_info info =3D { frame_type, prefix, prefix_len, wdev_=
id };
+	bool registered;
+	uint32_t id;
+
+	registered =3D l_queue_find(wdev_frame_watches.items,
+					netdev_frame_watch_match_prefix,
+					&info);
+
+	fw =3D l_new(struct netdev_frame_watch, 1);
+	fw->frame_type =3D frame_type;
+	fw->prefix =3D prefix_len ? l_memdup(prefix, prefix_len) : NULL;
+	fw->prefix_len =3D prefix_len;
+	fw->wdev_id =3D wdev_id;
+	id =3D watchlist_link(&wdev_frame_watches, &fw->super,
+						handler, user_data, NULL);
+
+	if (registered)
+		return id;
+
+	msg =3D l_genl_msg_new_sized(NL80211_CMD_REGISTER_FRAME, 32 + prefix_len);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &wdev_id);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_TYPE, 2, &frame_type);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_MATCH,
+				prefix_len, prefix);
+
+	l_genl_family_send(nl80211, msg, netdev_frame_cb,
+			L_UINT_TO_PTR(frame_type), NULL);
+
+	return id;
+}
+
+bool netdev_wdev_frame_watch_remove(uint32_t id)
+{
+	return watchlist_remove(&wdev_frame_watches, id);
+}
+
 static struct l_io *pae_open(uint32_t ifindex)
 {
 	/*
@@ -4796,6 +4864,8 @@ static int netdev_init(void)
 	watchlist_init(&netdev_watches, NULL);
 	netdev_list =3D l_queue_new();
 =

+	watchlist_init(&wdev_frame_watches, &netdev_frame_watch_ops);
+
 	__handshake_set_install_tk_func(netdev_set_tk);
 	__handshake_set_install_gtk_func(netdev_set_gtk);
 	__handshake_set_install_igtk_func(netdev_set_igtk);
diff --git a/src/netdev.h b/src/netdev.h
index 114a6035..624811b2 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -197,6 +197,12 @@ uint32_t netdev_frame_watch_add(struct netdev *netdev,=
 uint16_t frame_type,
 				void *user_data);
 bool netdev_frame_watch_remove(struct netdev *netdev, uint32_t id);
 =

+uint32_t netdev_wdev_frame_watch_add(uint64_t wdev_id, uint16_t frame_type,
+				const uint8_t *prefix, size_t prefix_len,
+				netdev_frame_watch_func_t handler,
+				void *user_data);
+bool netdev_wdev_frame_watch_remove(uint32_t id);
+
 void netdev_handshake_failed(struct handshake_state *hs, uint16_t reason_c=
ode);
 =

 struct netdev *netdev_find(int ifindex);
-- =

2.20.1

--===============2801727758339574464==--

