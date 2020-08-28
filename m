Content-Type: multipart/mixed; boundary="===============4598633347323397508=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/8] eapol: Handle the use_eapol_start flag on authenticator
Date: Fri, 28 Aug 2020 14:46:44 +0200
Message-ID: <20200828124649.78677-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200828124649.78677-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4598633347323397508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Reuse this flag on the authenticator side with a slightly different
meaning: when it's true we're forced to wait for the EAPoL-Start before
sending the first EAPoL-EAP frame to the supplicant, such as is required
in a WSC enrollee registration when the Association Request didn't have
a v2.0 WSC IE.
---
 src/eapol.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 2d339163..977f720b 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2417,7 +2417,7 @@ bool eapol_start(struct eapol_sm *sm)
 		sm->timeout =3D l_timeout_create(eapol_4way_handshake_time,
 				eapol_timeout, sm, NULL);
 =

-	if (sm->use_eapol_start) {
+	if (!sm->handshake->authenticator && sm->use_eapol_start) {
 		/*
 		 * We start a short timeout, if EAP packets are not received
 		 * from AP, then we send the EAPoL-Start
@@ -2442,9 +2442,14 @@ bool eapol_start(struct eapol_sm *sm)
 		if (!sm->protocol_version)
 			sm->protocol_version =3D EAPOL_PROTOCOL_VERSION_2004;
 =

-		if (sm->handshake->settings_8021x)
-			eap_start(sm->eap);
-		else {
+		if (sm->handshake->settings_8021x) {
+			/*
+			 * If we're allowed to, send EAP Identity request
+			 * immediately, otherwise wait for an EAPoL-Start.
+			 */
+			if (!sm->use_eapol_start)
+				eap_start(sm->eap);
+		} else {
 			if (L_WARN_ON(!sm->handshake->have_pmk))
 				return false;
 =

-- =

2.25.1

--===============4598633347323397508==--

