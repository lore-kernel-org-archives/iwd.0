Content-Type: multipart/mixed; boundary="===============4928227656160012439=="
MIME-Version: 1.0
From: Jonathan Liu <net147@gmail.com>
Subject: [PATCH] ap: Fix handshake state gtk not being set
Date: Sun, 15 Nov 2020 01:21:45 +1100
Message-ID: <20201114142145.661665-1-net147@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4928227656160012439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

handshake_state_set_authenticator_ie must be called to set group_cipher
in struct handshake_shake before handshake_set_gtk_state, otherwise
handshake_set_gtk_state is unable to determine the key length to set
handshake state gtk.

Fixes: 4bc20a097965 ("ap: Start EAP-WSC authentication with WSC enrollees")
---
 src/ap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 4d0d5686..d9e7e404 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -702,7 +702,8 @@ static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
 					callback, user_data, NULL, NULL);
 }
 =

-static void ap_start_handshake(struct sta_state *sta, bool use_eapol_start)
+static void ap_start_handshake(struct sta_state *sta, bool use_eapol_start,
+				const uint8_t *gtk_rsc)
 {
 	struct ap_state *ap =3D sta->ap;
 	const uint8_t *own_addr =3D netdev_get_address(ap->netdev);
@@ -722,6 +723,10 @@ static void ap_start_handshake(struct sta_state *sta, =
bool use_eapol_start)
 	ie_build_rsne(&rsn, bss_rsne);
 	handshake_state_set_authenticator_ie(sta->hs, bss_rsne);
 =

+	if (gtk_rsc)
+		handshake_state_set_gtk(sta->hs, sta->ap->gtk,
+					sta->ap->gtk_index, gtk_rsc);
+
 	sta->sm =3D eapol_sm_new(sta->hs);
 	if (!sta->sm) {
 		ap_stop_handshake(sta);
@@ -774,12 +779,7 @@ static void ap_start_rsna(struct sta_state *sta, const=
 uint8_t *gtk_rsc)
 	handshake_state_set_event_func(sta->hs, ap_handshake_event, sta);
 	handshake_state_set_supplicant_ie(sta->hs, sta->assoc_rsne);
 	handshake_state_set_pmk(sta->hs, sta->ap->config->psk, 32);
-
-	if (gtk_rsc)
-		handshake_state_set_gtk(sta->hs, sta->ap->gtk,
-					sta->ap->gtk_index, gtk_rsc);
-
-	ap_start_handshake(sta, false);
+	ap_start_handshake(sta, false, gtk_rsc);
 }
 =

 static void ap_gtk_query_cb(struct l_genl_msg *msg, void *user_data)
@@ -924,7 +924,7 @@ static void ap_start_eap_wsc(struct sta_state *sta)
 	handshake_state_set_event_func(sta->hs, ap_wsc_handshake_event, sta);
 	handshake_state_set_8021x_config(sta->hs, sta->wsc_settings);
 =

-	ap_start_handshake(sta, wait_for_eapol_start);
+	ap_start_handshake(sta, wait_for_eapol_start, NULL);
 }
 =

 static struct l_genl_msg *ap_build_cmd_del_key(struct ap_state *ap)
-- =

2.29.2

--===============4928227656160012439==--

