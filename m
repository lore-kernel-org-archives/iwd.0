Content-Type: multipart/mixed; boundary="===============8295645198185619642=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 04/10] frame-xchg: allow multicast frame watches
Date: Mon, 14 Feb 2022 13:48:03 -0800
Message-ID: <20220214214809.1017870-4-prestwoj@gmail.com>
In-Reply-To: 20220214214809.1017870-1-prestwoj@gmail.com

--===============8295645198185619642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds a new boolean argument to frame_watch_add which
when true will set the frame watch to forward multicast
frames.
---
 src/ap.c         | 12 ++++++------
 src/dpp.c        | 10 +++++-----
 src/frame-xchg.c | 15 ++++++++++-----
 src/frame-xchg.h |  8 ++++----
 src/netdev.c     | 10 +++++-----
 src/p2p.c        |  4 ++--
 src/rrm.c        |  4 ++--
 src/station.c    |  2 +-
 8 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 6f3dfa60..b1b5a91f 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3228,32 +3228,32 @@ struct ap_state *ap_start(struct netdev *netdev, st=
ruct l_settings *config,
 		l_uintset_put(ap->rates, 22); /* 11 Mbps*/
 	}
 =

-	if (!frame_watch_add(wdev_id, 0, 0x0000 |
+	if (!frame_watch_add(wdev_id, 0, false, 0x0000 |
 			(MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_REQUEST << 4),
 			NULL, 0, ap_assoc_req_cb, ap, NULL))
 		goto error;
 =

-	if (!frame_watch_add(wdev_id, 0, 0x0000 |
+	if (!frame_watch_add(wdev_id, 0, false, 0x0000 |
 			(MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_REQUEST << 4),
 			NULL, 0, ap_reassoc_req_cb, ap, NULL))
 		goto error;
 =

-	if (!frame_watch_add(wdev_id, 0, 0x0000 |
+	if (!frame_watch_add(wdev_id, 0, false, 0x0000 |
 				(MPDU_MANAGEMENT_SUBTYPE_PROBE_REQUEST << 4),
 				NULL, 0, ap_probe_req_cb, ap, NULL))
 		goto error;
 =

-	if (!frame_watch_add(wdev_id, 0, 0x0000 |
+	if (!frame_watch_add(wdev_id, 0, false, 0x0000 |
 				(MPDU_MANAGEMENT_SUBTYPE_DISASSOCIATION << 4),
 				NULL, 0, ap_disassoc_cb, ap, NULL))
 		goto error;
 =

-	if (!frame_watch_add(wdev_id, 0, 0x0000 |
+	if (!frame_watch_add(wdev_id, 0, false, 0x0000 |
 				(MPDU_MANAGEMENT_SUBTYPE_AUTHENTICATION << 4),
 				NULL, 0, ap_auth_cb, ap, NULL))
 		goto error;
 =

-	if (!frame_watch_add(wdev_id, 0, 0x0000 |
+	if (!frame_watch_add(wdev_id, 0, false, 0x0000 |
 				(MPDU_MANAGEMENT_SUBTYPE_DEAUTHENTICATION << 4),
 				NULL, 0, ap_deauth_cb, ap, NULL))
 		goto error;
diff --git a/src/dpp.c b/src/dpp.c
index d95217c5..ede4e337 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1687,14 +1687,14 @@ static void dpp_create(struct netdev *netdev)
 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_DPP_INTERFACE, dpp);
 =

-	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0, dpp_prefix,
-				sizeof(dpp_prefix), dpp_handle_frame,
-				dpp, NULL);
-	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
+	frame_watch_add(netdev_get_wdev_id(netdev), 0, false, 0x00d0,
+				dpp_prefix, sizeof(dpp_prefix),
+				dpp_handle_frame, dpp, NULL);
+	frame_watch_add(netdev_get_wdev_id(netdev), 0, false, 0x00d0,
 				dpp_conf_response_prefix,
 				sizeof(dpp_conf_response_prefix),
 				dpp_handle_config_response_frame, dpp, NULL);
-	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
+	frame_watch_add(netdev_get_wdev_id(netdev), 0, false, 0x00d0,
 				dpp_conf_request_prefix,
 				sizeof(dpp_conf_request_prefix),
 				dpp_handle_config_request_frame, dpp, NULL);
diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 5ba36081..35c3724c 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -573,10 +573,10 @@ drop:
 	return true;
 }
 =

-bool frame_watch_add(uint64_t wdev_id, uint32_t group_id, uint16_t frame_t=
ype,
-			const uint8_t *prefix, size_t prefix_len,
-			frame_watch_cb_t handler, void *user_data,
-			frame_xchg_destroy_func_t destroy)
+bool frame_watch_add(uint64_t wdev_id, uint32_t group_id, bool mcast,
+			uint16_t frame_type, const uint8_t *prefix,
+			size_t prefix_len, frame_watch_cb_t handler,
+			void *user_data, frame_xchg_destroy_func_t destroy)
 {
 	struct watch_group *group =3D frame_watch_group_get(wdev_id, group_id);
 	struct frame_watch *watch;
@@ -611,6 +611,11 @@ bool frame_watch_add(uint64_t wdev_id, uint32_t group_=
id, uint16_t frame_type,
 =

 	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &wdev_id);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_TYPE, 2, &frame_type);
+
+	if (mcast)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_RECEIVE_MULTICAST,
+					0, NULL);
+
 	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_MATCH,
 				prefix_len, prefix);
 =

@@ -1193,7 +1198,7 @@ uint32_t frame_xchg_startv(uint64_t wdev_id, struct i=
ovec *frame, uint32_t freq,
 		watch =3D l_new(struct frame_xchg_watch_data, 1);
 		watch->prefix =3D prefix;
 		watch->cb =3D va_arg(resp_args, void *);
-		frame_watch_add(wdev_id, group_id, 0x00d0,
+		frame_watch_add(wdev_id, group_id, false, 0x00d0,
 				prefix->data, prefix->len,
 				frame_xchg_resp_cb, fx, NULL);
 =

diff --git a/src/frame-xchg.h b/src/frame-xchg.h
index e3748538..dfbc23fb 100644
--- a/src/frame-xchg.h
+++ b/src/frame-xchg.h
@@ -36,10 +36,10 @@ struct frame_xchg_prefix {
 	size_t len;
 };
 =

-bool frame_watch_add(uint64_t wdev_id, uint32_t group, uint16_t frame_type,
-			const uint8_t *prefix, size_t prefix_len,
-			frame_watch_cb_t handler, void *user_data,
-			frame_xchg_destroy_func_t destroy);
+bool frame_watch_add(uint64_t wdev_id, uint32_t group, bool mcast,
+			uint16_t frame_type, const uint8_t *prefix,
+			size_t prefix_len, frame_watch_cb_t handler,
+			void *user_data, frame_xchg_destroy_func_t destroy);
 bool frame_watch_group_remove(uint64_t wdev_id, uint32_t group);
 bool frame_watch_wdev_remove(uint64_t wdev_id);
 =

diff --git a/src/netdev.c b/src/netdev.c
index bac6860c..779c4aad 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -5783,24 +5783,24 @@ static void netdev_add_station_frame_watches(struct=
 netdev *netdev)
 	uint64_t wdev =3D netdev->wdev_id;
 =

 	/* Subscribe to Management -> Action -> RM -> Neighbor Report frames */
-	frame_watch_add(wdev, 0, 0x00d0, action_neighbor_report_prefix,
+	frame_watch_add(wdev, 0, 0x00d0, false, action_neighbor_report_prefix,
 			sizeof(action_neighbor_report_prefix),
 			netdev_neighbor_report_frame_event, netdev, NULL);
 =

-	frame_watch_add(wdev, 0, 0x00d0, action_sa_query_resp_prefix,
+	frame_watch_add(wdev, 0, 0x00d0, false, action_sa_query_resp_prefix,
 			sizeof(action_sa_query_resp_prefix),
 			netdev_sa_query_resp_frame_event, netdev, NULL);
 =

-	frame_watch_add(wdev, 0, 0x00d0, action_sa_query_req_prefix,
+	frame_watch_add(wdev, 0, 0x00d0, false, action_sa_query_req_prefix,
 			sizeof(action_sa_query_req_prefix),
 			netdev_sa_query_req_frame_event, netdev, NULL);
 =

-	frame_watch_add(wdev, 0, 0x00d0, action_ft_response_prefix,
+	frame_watch_add(wdev, 0, 0x00d0, false, action_ft_response_prefix,
 			sizeof(action_ft_response_prefix),
 			netdev_ft_response_frame_event, netdev, NULL);
 =

 	if (wiphy_supports_qos_set_map(netdev->wiphy))
-		frame_watch_add(wdev, 0, 0x00d0, action_qos_map_prefix,
+		frame_watch_add(wdev, 0, 0x00d0, false, action_qos_map_prefix,
 				sizeof(action_qos_map_prefix),
 				netdev_qos_map_frame_event, netdev, NULL);
 }
diff --git a/src/p2p.c b/src/p2p.c
index 4c90efb6..7ca804c0 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -4154,9 +4154,9 @@ static void p2p_device_discovery_start(struct p2p_dev=
ice *dev)
 		dev->listen_channel =3D channels_social[l_getrandom_uint32() %
 						L_ARRAY_SIZE(channels_social)];
 =

-	frame_watch_add(dev->wdev_id, FRAME_GROUP_LISTEN, 0x0040,
+	frame_watch_add(dev->wdev_id, FRAME_GROUP_LISTEN, false, 0x0040,
 			(uint8_t *) "", 0, p2p_device_probe_cb, dev, NULL);
-	frame_watch_add(dev->wdev_id, FRAME_GROUP_LISTEN, 0x00d0,
+	frame_watch_add(dev->wdev_id, FRAME_GROUP_LISTEN, false, 0x00d0,
 			p2p_frame_go_neg_req.data, p2p_frame_go_neg_req.len,
 			p2p_device_go_negotiation_req_cb, dev, NULL);
 =

diff --git a/src/rrm.c b/src/rrm.c
index d1c7029d..f2dd2ada 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -793,8 +793,8 @@ static void rrm_add_frame_watches(struct rrm_state *rrm)
 =

 	l_debug("");
 =

-	frame_watch_add(rrm->wdev_id, 0, frame_type, prefix, sizeof(prefix),
-					rrm_frame_watch_cb, rrm, NULL);
+	frame_watch_add(rrm->wdev_id, 0, false, frame_type, prefix,
+				sizeof(prefix), rrm_frame_watch_cb, rrm, NULL);
 }
 =

 static struct rrm_state *rrm_new_state(struct netdev *netdev)
diff --git a/src/station.c b/src/station.c
index cd119ff1..2fa0e818 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4462,7 +4462,7 @@ static void add_frame_watches(struct netdev *netdev)
 	/*
 	 * register for AP roam transition watch
 	 */
-	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
+	frame_watch_add(netdev_get_wdev_id(netdev), 0, false, 0x00d0,
 			action_ap_roam_prefix, sizeof(action_ap_roam_prefix),
 			ap_roam_frame_event,
 			L_UINT_TO_PTR(netdev_get_ifindex(netdev)), NULL);
-- =

2.34.1

--===============8295645198185619642==--

