Content-Type: multipart/mixed; boundary="===============0769796682118373111=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] unit: remove timeout tests from test-sae
Date: Tue, 06 Apr 2021 11:29:46 -0700
Message-ID: <20210406182946.1087095-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0769796682118373111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The timeout functionality was removed from the core SAE
implementation as it causes issues with kernel behavior.
Because of this the timeout tests are no longer valid,
nor is a few asserts in the end-to-end test.
---
 unit/test-sae.c | 66 +------------------------------------------------
 1 file changed, 1 insertion(+), 65 deletions(-)

diff --git a/unit/test-sae.c b/unit/test-sae.c
index 10367cf9..678c2526 100644
--- a/unit/test-sae.c
+++ b/unit/test-sae.c
@@ -236,59 +236,6 @@ static size_t setup_assoc_frame(struct associate_frame=
 *frame, uint16_t status)
 	return sizeof(frame->hdr) + sizeof(frame->assoc);
 }
 =

-static void test_confirm_timeout(const void *arg)
-{
-	struct test_data *td =3D l_new(struct test_data, 1);
-	struct auth_proto *ap =3D test_initialize(td);
-	struct authenticate_frame *frame =3D alloca(
-					sizeof(struct authenticate_frame) +
-					sizeof(aa_commit));
-	size_t len;
-	int i;
-
-	len =3D setup_auth_frame(frame, aa, 1, 0, aa_commit, sizeof(aa_commit));
-
-	assert(auth_proto_rx_authenticate(ap, (uint8_t *)frame, len) =3D=3D 0);
-
-	assert(td->confirm_success);
-
-	assert(l_get_le16(td->tx_packet + 4) =3D=3D 1);
-
-	for (i =3D 1; i < 5; i++) {
-		assert(auth_proto_auth_timeout(ap));
-		assert(l_get_le16(td->tx_packet + 4) =3D=3D i + 1);
-	}
-
-	assert(!auth_proto_auth_timeout(ap));
-
-	test_destruct(td);
-
-	auth_proto_free(ap);
-}
-
-static void test_commit_timeout(const void *arg)
-{
-	struct test_data *td =3D l_new(struct test_data, 1);
-	struct auth_proto *ap =3D test_initialize(td);
-	uint8_t last_packet[512];
-	int i;
-
-	memcpy(last_packet, td->tx_packet, td->tx_packet_len);
-
-	for (i =3D 0; i < 4; i++) {
-		assert(auth_proto_auth_timeout(ap));
-
-		assert(!memcmp(last_packet, td->tx_packet, td->tx_packet_len));
-
-		memcpy(last_packet, td->tx_packet, td->tx_packet_len);
-	}
-
-	assert(!auth_proto_auth_timeout(ap));
-
-	test_destruct(td);
-	auth_proto_free(ap);
-}
-
 static void test_clogging(const void *arg)
 {
 	struct test_data *td =3D l_new(struct test_data, 1);
@@ -575,16 +522,7 @@ static void test_confirm_after_accept(const void *arg)
 =

 	assert(td1->tx_assoc_called);
 =

-	/* simulate sm2 not receiving confirm and resending its confirm */
-	ap2->auth_timeout(ap2);
-	frame_len =3D setup_auth_frame(frame, aa, 2, 0, td2->tx_packet + 4,
-					td2->tx_packet_len - 4);
-	assert(auth_proto_rx_authenticate(ap1, (uint8_t *)frame,
-						frame_len) =3D=3D 0);
-
-	/* sc should be set to 0xffff */
-	assert(l_get_u16(td1->tx_packet + 4) =3D=3D 0xffff);
-	/* sm1 should respond with a new confirm, and accept */
+	/* sm1 should respond with a confirm, and accept */
 	frame_len =3D setup_auth_frame(frame, spa, 2, 0, td1->tx_packet + 4,
 					td1->tx_packet_len - 4);
 	assert(auth_proto_rx_authenticate(ap2, (uint8_t *)frame,
@@ -703,8 +641,6 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 =

-	l_test_add("SAE commit timeout", test_commit_timeout, NULL);
-	l_test_add("SAE confirm timeout", test_confirm_timeout, NULL);
 	l_test_add("SAE anti-clogging", test_clogging, NULL);
 	l_test_add("SAE early confirm", test_early_confirm, NULL);
 	l_test_add("SAE reflection", test_reflection, NULL);
-- =

2.26.2

--===============0769796682118373111==--

