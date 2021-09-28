Content-Type: multipart/mixed; boundary="===============1978989594516247622=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 4/5] eapol: don't enforce PMKID on 1/4 if require_handshake
 is false
Date: Tue, 28 Sep 2021 15:25:52 -0700
Message-ID: <20210928222553.1096611-4-prestwoj@gmail.com>
In-Reply-To: 20210928222553.1096611-1-prestwoj@gmail.com

--===============1978989594516247622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FT/FILS handle their own PMK derivation but rekeys still require
using the 4-way handshake. There is some ambiguity in the spec whether
or not the PMKID needs to be included in message 1/4 and it appears
that when rekeying after FT/FILS hostapd does not include a PMKID.
---
 src/eapol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/eapol.c b/src/eapol.c
index 393b85a1..3c9581bc 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1147,7 +1147,8 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *=
sm,
 	 * send no PMKID KDE.
 	 */
 	if (!sm->eap_exchanged && !sm->handshake->wpa_ie &&
-			rsn_info.num_pmkids) {
+			rsn_info.num_pmkids &&
+			sm->require_handshake) {
 		bool found =3D false;
 		int i;
 =

-- =

2.31.1

--===============1978989594516247622==--

