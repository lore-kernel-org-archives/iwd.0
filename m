Content-Type: multipart/mixed; boundary="===============3324454807179892108=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 7/9] unit: update test-eapol with GTK API change
Date: Tue, 28 Sep 2021 14:27:42 -0700
Message-ID: <20210928212744.717276-7-prestwoj@gmail.com>
In-Reply-To: 20210928212744.717276-1-prestwoj@gmail.com

--===============3324454807179892108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-eapol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index 470e0e9f..e1b6c96e 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -1940,6 +1940,7 @@ static void eapol_wpa2_handshake_test(const void *dat=
a)
 	frame =3D eapol_create_gtk_2_of_2(EAPOL_PROTOCOL_VERSION_2004,
 				EAPOL_KEY_DESCRIPTOR_VERSION_HMAC_SHA1_AES,
 				eapol_key_test_12.key_replay_counter,
+				0, NULL,
 				false, 0, 16);
 	assert(frame);
 	assert(eapol_calculate_mic(IE_RSN_AKM_SUITE_PSK, ptk, frame,
@@ -2061,8 +2062,8 @@ static void eapol_wpa_handshake_test(const void *data)
 =

 	frame =3D eapol_create_gtk_2_of_2(EAPOL_PROTOCOL_VERSION_2004,
 				EAPOL_KEY_DESCRIPTOR_VERSION_HMAC_MD5_ARC4,
-				eapol_key_test_18.key_replay_counter, true,
-				gtk_step1->wpa_key_id, 16);
+				eapol_key_test_18.key_replay_counter, 0, NULL,
+				true, gtk_step1->wpa_key_id, 16);
 	assert(frame);
 	assert(eapol_calculate_mic(IE_RSN_AKM_SUITE_PSK, ptk, frame,
 					mic, 16));
-- =

2.31.1

--===============3324454807179892108==--

