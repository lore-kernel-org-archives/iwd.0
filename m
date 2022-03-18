Content-Type: multipart/mixed; boundary="===============5683252132987170442=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/6] wired: check eap_load_settings
Date: Fri, 18 Mar 2022 09:44:18 -0700
Message-ID: <20220318164420.739968-4-prestwoj@gmail.com>
In-Reply-To: 20220318164420.739968-1-prestwoj@gmail.com

--===============5683252132987170442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Caught by static analysis
---
 wired/ethdev.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/wired/ethdev.c b/wired/ethdev.c
index e000afae..db5a9ac9 100644
--- a/wired/ethdev.c
+++ b/wired/ethdev.c
@@ -238,10 +238,15 @@ static void rx_packet(struct ethdev *dev, const uint8=
_t *addr,
 =

 			l_debug("Created new EAPoL session");
 =

-			l_queue_push_tail(dev->eapol_sessions, eapol);
-
 			eapol->cred =3D network_lookup_security("default");
-			eap_load_settings(eapol->eap, eapol->cred, "EAP-");
+			if (!eapol->cred || !eap_load_settings(eapol->eap,
+						eapol->cred, "EAP-")) {
+				l_error("Failed to load EAP settings");
+				eapol_free(eapol);
+				return;
+			}
+
+			l_queue_push_tail(dev->eapol_sessions, eapol);
 =

 			eap_set_key_material_func(eapol->eap, eap_key_material);
 			eap_set_event_func(eapol->eap, eap_event);
-- =

2.34.1

--===============5683252132987170442==--

