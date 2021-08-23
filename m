Content-Type: multipart/mixed; boundary="===============2126634442305114370=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] unit: update test-sae with API change
Date: Mon, 23 Aug 2021 16:34:32 -0700
Message-ID: <20210823233432.604561-4-prestwoj@gmail.com>
In-Reply-To: <20210823233432.604561-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2126634442305114370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am     |  3 ++-
 unit/test-sae.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index e6d2fc91..8b0df2aa 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -521,7 +521,8 @@ unit_test_sae_SOURCES =3D unit/test-sae.c \
 				src/handshake.h src/handshake.c \
 				src/erp.h src/erp.c \
 				src/util.h src/util.c \
-				src/mpdu.h src/mpdu.c
+				src/mpdu.h src/mpdu.c \
+				src/scan.h
 unit_test_sae_LDADD =3D $(ell_ldadd)
 unit_test_sae_LDFLAGS =3D -Wl,-wrap,l_ecc_supported_ike_groups
 =

diff --git a/unit/test-sae.c b/unit/test-sae.c
index d9ec6b31..00819eb2 100644
--- a/unit/test-sae.c
+++ b/unit/test-sae.c
@@ -171,7 +171,7 @@ static struct auth_proto *test_initialize(struct test_d=
ata *td)
 =

 	memset(td->test_clogging_token, 0xde, 32);
 =

-	ap =3D sae_sm_new(hs, test_tx_auth_func, test_tx_assoc_func, td);
+	ap =3D sae_sm_new(hs, NULL, test_tx_auth_func, test_tx_assoc_func, td);
 =

 	td->commit_success =3D false;
 	auth_proto_start(ap);
@@ -423,8 +423,8 @@ static void test_bad_confirm(const void *arg)
 	handshake_state_set_passphrase(hs2, passphrase);
 	handshake_state_set_authenticator(hs2, true);
 =

-	ap1 =3D sae_sm_new(hs1, end_to_end_tx_func, test_tx_assoc_func, td1);
-	ap2 =3D sae_sm_new(hs2, end_to_end_tx_func, test_tx_assoc_func, td2);
+	ap1 =3D sae_sm_new(hs1, NULL, end_to_end_tx_func, test_tx_assoc_func, td1=
);
+	ap2 =3D sae_sm_new(hs2, NULL, end_to_end_tx_func, test_tx_assoc_func, td2=
);
 =

 	/* both peers send out commit */
 	ap1->start(ap1);
@@ -498,8 +498,8 @@ static void test_confirm_after_accept(const void *arg)
 	handshake_state_set_passphrase(hs2, passphrase);
 	handshake_state_set_authenticator(hs2, true);
 =

-	ap1 =3D sae_sm_new(hs1, end_to_end_tx_func, test_tx_assoc_func, td1);
-	ap2 =3D sae_sm_new(hs2, end_to_end_tx_func, test_tx_assoc_func, td2);
+	ap1 =3D sae_sm_new(hs1, NULL, end_to_end_tx_func, test_tx_assoc_func, td1=
);
+	ap2 =3D sae_sm_new(hs2, NULL, end_to_end_tx_func, test_tx_assoc_func, td2=
);
 =

 	/* both peers send out commit */
 	auth_proto_start(ap1);
@@ -583,8 +583,8 @@ static void test_end_to_end(const void *arg)
 	handshake_state_set_passphrase(hs2, passphrase);
 	handshake_state_set_authenticator(hs2, true);
 =

-	ap1 =3D sae_sm_new(hs1, end_to_end_tx_func, test_tx_assoc_func, td1);
-	ap2 =3D sae_sm_new(hs2, end_to_end_tx_func, test_tx_assoc_func, td2);
+	ap1 =3D sae_sm_new(hs1, NULL, end_to_end_tx_func, test_tx_assoc_func, td1=
);
+	ap2 =3D sae_sm_new(hs2, NULL, end_to_end_tx_func, test_tx_assoc_func, td2=
);
 =

 	/* both peers send out commit */
 	auth_proto_start(ap1);
-- =

2.31.1

--===============2126634442305114370==--

