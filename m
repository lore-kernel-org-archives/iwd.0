Content-Type: multipart/mixed; boundary="===============3690781049588665326=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/9] ap: Make station removal safer
Date: Sat, 07 Aug 2021 04:10:42 +0200
Message-ID: <20210807021048.321664-3-andrew.zaborowski@intel.com>
In-Reply-To: <20210807021048.321664-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3690781049588665326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace instances of the ap_del_station() +
ap_sta_free()/ap_remove_sta() with calls to ap_station_disconnect to
make sure we consistently remove the station from the ap->sta_states
queue before using ap_del_station().  ap_del_station() may generate an
event to the ap.h API user (e.g. P2P) and this may end up tearing down
the AP completely.

For that scenario we also don't want ap_sta_free() to access sta->ap so
we make sure ap_del_station() performs these cleanup steps so that
ap_sta_free() has nothing to do that accesses sta->ap.
---
 src/ap.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index f78863ad..51cb5602 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -251,6 +251,11 @@ static void ap_del_station(struct sta_state *sta, uint=
16_t reason,
 		sta->rsna =3D false;
 	}
 =

+	if (sta->assoc_resp_cmd_id) {
+		l_genl_family_cancel(ap->nl80211, sta->assoc_resp_cmd_id);
+		sta->assoc_resp_cmd_id =3D 0;
+	}
+
 	if (sta->gtk_query_cmd_id) {
 		l_genl_family_cancel(ap->nl80211, sta->gtk_query_cmd_id);
 		sta->gtk_query_cmd_id =3D 0;
@@ -258,6 +263,10 @@ static void ap_del_station(struct sta_state *sta, uint=
16_t reason,
 =

 	ap_stop_handshake(sta);
 =

+	/*
+	 * If the event handler tears the AP down, we've made sure above that
+	 * a subsequent ap_sta_free(sta) has no need to access sta->ap.
+	 */
 	if (send_event)
 		ap->ops->handle_event(AP_EVENT_STATION_REMOVED, &event_data,
 					ap->user_data);
@@ -2003,7 +2012,6 @@ static void ap_deauth_cb(const struct mmpdu_header *h=
dr, const void *body,
 				size_t body_len, int rssi, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
-	struct sta_state *sta;
 	const struct mmpdu_deauthentication *deauth =3D body;
 	const uint8_t *bssid =3D netdev_get_address(ap->netdev);
 =

@@ -2015,14 +2023,8 @@ static void ap_deauth_cb(const struct mmpdu_header *=
hdr, const void *body,
 			memcmp(hdr->address_3, bssid, 6))
 		return;
 =

-	sta =3D l_queue_remove_if(ap->sta_states, ap_sta_match_addr,
-				hdr->address_2);
-	if (!sta)
-		return;
-
-	ap_del_station(sta, L_LE16_TO_CPU(deauth->reason_code), false);
-
-	ap_sta_free(sta);
+	ap_station_disconnect(ap, hdr->address_2,
+				L_LE16_TO_CPU(deauth->reason_code));
 }
 =

 static void do_debug(const char *str, void *user_data)
@@ -2338,7 +2340,6 @@ cleanup:
 =

 static void ap_handle_del_station(struct ap_state *ap, struct l_genl_msg *=
msg)
 {
-	struct sta_state *sta;
 	struct l_genl_attr attr;
 	uint16_t type;
 	uint16_t len;
@@ -2365,12 +2366,7 @@ static void ap_handle_del_station(struct ap_state *a=
p, struct l_genl_msg *msg)
 		}
 	}
 =

-	sta =3D l_queue_find(ap->sta_states, ap_sta_match_addr, mac);
-	if (!sta)
-		return;
-
-	ap_del_station(sta, reason, true);
-	ap_remove_sta(sta);
+	ap_station_disconnect(ap, mac, reason);
 }
 =

 static void ap_mlme_notify(struct l_genl_msg *msg, void *user_data)
-- =

2.30.2

--===============3690781049588665326==--

