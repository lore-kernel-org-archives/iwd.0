Content-Type: multipart/mixed; boundary="===============8499117997113785967=="
MIME-Version: 1.0
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH] eapol: prevent key reinstallation on retransmitted Msg4/4
Date: Wed, 12 Aug 2020 15:17:21 +0400
Message-ID: <20200812111721.302407-1-Mathy.Vanhoef@kuleuven.be>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8499117997113785967==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently an adversary can retransmit EAPOL Msg4/4 to make the AP
reinstall the PTK. Against older Linux kernels this can subsequently
be used to decrypt, replay, and possibly decrypt frames. See the
KRACK attacks research at krackattacks.com for attack scenarios.
In this case no machine-in-the-middle position is needed to trigger
the key reinstallation.

Fix this by using the ptk_complete boolean to track when the 4-way
handshake has completed (similar to its usage for clients). When
receiving a retransmitted Msg4/4 accept this frame but do not reinstall
the PTK.

Credits to Chris M. Stone, Sam Thomas, and Tom Chothia of Birmingham
University to help discover this issue.
---
 src/eapol.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index b0036c10..e3581cfe 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1462,7 +1462,6 @@ static void eapol_handle_ptk_2_of_4(struct eapol_sm *=
sm,
 	memcpy(sm->handshake->snonce, ek->key_nonce,
 			sizeof(sm->handshake->snonce));
 	sm->handshake->have_snonce =3D true;
-	sm->handshake->ptk_complete =3D true;
 =

 	sm->frame_retry =3D 0;
 =

@@ -1782,7 +1781,15 @@ static void eapol_handle_ptk_4_of_4(struct eapol_sm =
*sm,
 	l_timeout_remove(sm->timeout);
 	sm->timeout =3D NULL;
 =

-	handshake_state_install_ptk(sm->handshake);
+	/*
+	 * If ptk_complete is set, then we are receiving Message 4 again.
+	 * This might be a retransmission, so accept but don't install
+	 * the keys again.
+	 */
+	if (!sm->handshake->ptk_complete)
+		handshake_state_install_ptk(sm->handshake);
+
+	sm->handshake->ptk_complete =3D true;
 }
 =

 static void eapol_handle_gtk_1_of_2(struct eapol_sm *sm,
@@ -2185,6 +2192,7 @@ static void eapol_auth_key_handle(struct eapol_sm *sm,
 	size_t frame_len =3D 4 + L_BE16_TO_CPU(frame->header.packet_len);
 	const struct eapol_key *ek =3D eapol_key_validate((const void *) frame,
 							frame_len, sm->mic_len);
+	uint16_t key_data_len;
 =

 	if (!ek)
 		return;
@@ -2199,7 +2207,8 @@ static void eapol_auth_key_handle(struct eapol_sm *sm,
 	if (!sm->handshake->have_anonce)
 		return; /* Not expecting an EAPoL-Key yet */
 =

-	if (!sm->handshake->ptk_complete)
+	key_data_len =3D EAPOL_KEY_DATA_LEN(ek, sm->mic_len);
+	if (key_data_len !=3D 0)
 		eapol_handle_ptk_2_of_4(sm, ek);
 	else
 		eapol_handle_ptk_4_of_4(sm, ek);
-- =

2.27.0

--===============8499117997113785967==--

