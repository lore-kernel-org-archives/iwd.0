Content-Type: multipart/mixed; boundary="===============6286829812431055393=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/8] ap: Stop ongoing handshake on reassociation
Date: Fri, 28 Aug 2020 14:46:45 +0200
Message-ID: <20200828124649.78677-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200828124649.78677-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6286829812431055393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On a new association or re-association, in addition to forgetting a
complete RSN Association, also stop the EAPoL SM to stop any ongoing
handshake.

Do this in a new function ap_stop_handshake that is now used in a few
places that had copies of the same few lines.  I'll be adding some more
lines to this function for WSC support.
---
 src/ap.c | 51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index bc8b11e8..fa7d030a 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -106,6 +106,19 @@ void ap_config_free(struct ap_config *config)
 	l_free(config);
 }
 =

+static void ap_stop_handshake(struct sta_state *sta)
+{
+	if (sta->sm) {
+		eapol_sm_free(sta->sm);
+		sta->sm =3D NULL;
+	}
+
+	if (sta->hs) {
+		handshake_state_free(sta->hs);
+		sta->hs =3D NULL;
+	}
+}
+
 static void ap_sta_free(void *data)
 {
 	struct sta_state *sta =3D data;
@@ -120,11 +133,7 @@ static void ap_sta_free(void *data)
 	if (sta->gtk_query_cmd_id)
 		l_genl_family_cancel(ap->nl80211, sta->gtk_query_cmd_id);
 =

-	if (sta->sm)
-		eapol_sm_free(sta->sm);
-
-	if (sta->hs)
-		handshake_state_free(sta->hs);
+	ap_stop_handshake(sta);
 =

 	l_free(sta);
 }
@@ -180,14 +189,7 @@ static void ap_del_station(struct sta_state *sta, uint=
16_t reason,
 		sta->gtk_query_cmd_id =3D 0;
 	}
 =

-	if (sta->sm)
-		eapol_sm_free(sta->sm);
-
-	if (sta->hs)
-		handshake_state_free(sta->hs);
-
-	sta->hs =3D NULL;
-	sta->sm =3D NULL;
+	ap_stop_handshake(sta);
 =

 	if (send_event)
 		ap->event_func(AP_EVENT_STATION_REMOVED, &event_data,
@@ -268,14 +270,7 @@ static void ap_drop_rsna(struct sta_state *sta)
 		l_error("Issuing DEL_KEY failed");
 	}
 =

-	if (sta->sm)
-		eapol_sm_free(sta->sm);
-
-	if (sta->hs)
-		handshake_state_free(sta->hs);
-
-	sta->hs =3D NULL;
-	sta->sm =3D NULL;
+	ap_stop_handshake(sta);
 =

 	if (ap->event_func) {
 		struct ap_event_station_removed_data event_data =3D {};
@@ -938,6 +933,12 @@ static void ap_assoc_reassoc(struct sta_state *sta, bo=
ol reassoc,
 		goto unsupported;
 	}
 =

+	/* 802.11-2016 11.3.5.3 j) */
+	if (sta->rsna)
+		ap_drop_rsna(sta);
+	else if (sta->associated)
+		ap_stop_handshake(sta);
+
 	if (!sta->associated) {
 		/*
 		 * Everything fine so far, assign an AID, send response.
@@ -961,10 +962,6 @@ static void ap_assoc_reassoc(struct sta_state *sta, bo=
ol reassoc,
 =

 	sta->assoc_rsne =3D l_memdup(rsn, rsn[1] + 2);
 =

-	/* 802.11-2016 11.3.5.3 j) */
-	if (sta->rsna)
-		ap_drop_rsna(sta);
-
 	sta->assoc_resp_cmd_id =3D ap_assoc_resp(ap, sta, sta->addr, sta->aid, 0,
 						reassoc,
 						ap_success_assoc_resp_cb);
@@ -987,8 +984,10 @@ bad_frame:
 	 *
 	 * For now, we need to drop the RSNA.
 	 */
-	if (sta->associated && sta->rsna)
+	if (sta->rsna)
 		ap_drop_rsna(sta);
+	else if (sta->associated)
+		ap_stop_handshake(sta);
 =

 	if (rates)
 		l_uintset_free(rates);
-- =

2.25.1

--===============6286829812431055393==--

