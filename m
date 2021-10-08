Content-Type: multipart/mixed; boundary="===============6755640271911732713=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 5/5] unit: update tests with new TK install arguments
Date: Fri, 08 Oct 2021 11:07:26 -0700
Message-ID: <20211008180726.2599788-5-prestwoj@gmail.com>
In-Reply-To: 20211008180726.2599788-1-prestwoj@gmail.com

--===============6755640271911732713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-eapol.c | 4 ++--
 unit/test-wsc.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index e1b6c96e..86b154eb 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -2471,7 +2471,7 @@ static void eapol_sm_test_wpa_ptk_gtk_2(const void *d=
ata)
 	eapol_exit();
 }
 =

-static void verify_install_tk(struct handshake_state *hs,
+static void verify_install_tk(struct handshake_state *hs, uint8_t key_inde=
x,
 				const uint8_t *tk, uint32_t cipher)
 {
 	struct test_handshake_state *ths =3D
@@ -3626,7 +3626,7 @@ static void test_ap_sta_hs_event(struct handshake_sta=
te *hs,
 	assert(event !=3D HANDSHAKE_EVENT_FAILED);
 }
 =

-static void test_ap_sta_install_tk(struct handshake_state *hs,
+static void test_ap_sta_install_tk(struct handshake_state *hs, uint8_t key=
_idx,
 					const uint8_t *tk, uint32_t cipher)
 {
 	struct test_ap_sta_hs *ths =3D
diff --git a/unit/test-wsc.c b/unit/test-wsc.c
index 7b24e6c5..8b130f45 100644
--- a/unit/test-wsc.c
+++ b/unit/test-wsc.c
@@ -2345,7 +2345,7 @@ static bool random_nonce(uint8_t nonce[])
 	return l_getrandom(nonce, 32);
 }
 =

-static void test_ap_sta_install_tk(struct handshake_state *hs,
+static void test_ap_sta_install_tk(struct handshake_state *hs, uint8_t key=
_idx,
 					const uint8_t *tk, uint32_t cipher)
 {
 	assert(false);
-- =

2.31.1

--===============6755640271911732713==--

