Content-Type: multipart/mixed; boundary="===============4667729186109041655=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/6] ap: Pass frame IEs from clients to the ap_state user
Date: Wed, 10 Mar 2021 23:06:31 +0100
Message-ID: <20210310220635.944104-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210310220635.944104-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4667729186109041655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass the string IEs from the incoming STA association frames to
the user in the AP event data.  I drop
ap_event_station_added_data.rsn_ie because that probably wasn't
going to ever be useful and the RSN IE is included in the .assoc_ies
array in any case.
---
 src/ap.c | 22 +++++++++++++++-------
 src/ap.h |  5 ++++-
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 6ab0c0fd..eeab3408 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -99,6 +99,8 @@ struct sta_state {
 	struct l_uintset *rates;
 	uint32_t assoc_resp_cmd_id;
 	struct ap_state *ap;
+	uint8_t *assoc_ies;
+	size_t assoc_ies_len;
 	uint8_t *assoc_rsne;
 	struct eapol_sm *sm;
 	struct handshake_state *hs;
@@ -279,7 +281,7 @@ static void ap_sta_free(void *data)
 	struct ap_state *ap =3D sta->ap;
 =

 	l_uintset_free(sta->rates);
-	l_free(sta->assoc_rsne);
+	l_free(sta->assoc_ies);
 =

 	if (sta->assoc_resp_cmd_id)
 		l_genl_family_cancel(ap->nl80211, sta->assoc_resp_cmd_id);
@@ -411,7 +413,8 @@ static void ap_new_rsna(struct sta_state *sta)
 	if (ap->ops->handle_event) {
 		struct ap_event_station_added_data event_data =3D {};
 		event_data.mac =3D sta->addr;
-		event_data.rsn_ie =3D sta->assoc_rsne;
+		event_data.assoc_ies =3D sta->assoc_ies;
+		event_data.assoc_ies_len =3D sta->assoc_ies_len;
 		ap->ops->handle_event(AP_EVENT_STATION_ADDED, &event_data,
 					ap->user_data);
 	}
@@ -1474,6 +1477,8 @@ static void ap_assoc_reassoc(struct sta_state *sta, b=
ool reassoc,
 		sta->wsc_v2 =3D wsc_req.version2;
 =

 		event_data.mac =3D sta->addr;
+		event_data.assoc_ies =3D ies;
+		event_data.assoc_ies_len =3D ies_len;
 		ap->ops->handle_event(AP_EVENT_REGISTRATION_START, &event_data,
 					ap->user_data);
 =

@@ -1524,13 +1529,16 @@ static void ap_assoc_reassoc(struct sta_state *sta,=
 bool reassoc,
 =

 	sta->rates =3D rates;
 =

-	if (sta->assoc_rsne)
-		l_free(sta->assoc_rsne);
+	l_free(sta->assoc_ies);
 =

-	if (rsn)
-		sta->assoc_rsne =3D l_memdup(rsn, rsn[1] + 2);
-	else
+	if (rsn) {
+		sta->assoc_ies =3D l_memdup(ies, ies_len);
+		sta->assoc_ies_len =3D ies_len;
+		sta->assoc_rsne =3D sta->assoc_ies + (rsn - ies);
+	} else {
+		sta->assoc_ies =3D NULL;
 		sta->assoc_rsne =3D NULL;
+	}
 =

 	sta->assoc_resp_cmd_id =3D ap_assoc_resp(ap, sta, sta->addr, 0, reassoc,
 						ap_success_assoc_resp_cb);
diff --git a/src/ap.h b/src/ap.h
index 6199bcbe..0bdbf0bb 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -36,7 +36,8 @@ enum ap_event_type {
 =

 struct ap_event_station_added_data {
 	const uint8_t *mac;
-	const uint8_t *rsn_ie;
+	const uint8_t *assoc_ies;
+	size_t assoc_ies_len;
 };
 =

 struct ap_event_station_removed_data {
@@ -46,6 +47,8 @@ struct ap_event_station_removed_data {
 =

 struct ap_event_registration_start_data {
 	const uint8_t *mac;
+	const uint8_t *assoc_ies;
+	size_t assoc_ies_len;
 };
 =

 struct ap_event_registration_success_data {
-- =

2.27.0

--===============4667729186109041655==--

