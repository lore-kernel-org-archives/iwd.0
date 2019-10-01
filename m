Content-Type: multipart/mixed; boundary="===============9207003686250961601=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] unit: update test-eapol to new ELL APIs
Date: Tue, 01 Oct 2019 14:32:51 -0700
Message-ID: <20191001213251.2536-2-prestwoj@gmail.com>
In-Reply-To: <20191001213251.2536-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9207003686250961601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-eapol.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index c43fe278..109c93bb 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -2906,6 +2906,9 @@ static void eapol_sm_test_tls(struct eapol_8021x_tls_=
test_state *s,
 	struct eapol_key *step1, *step2, *step3, *step4;
 	uint8_t ptk_buf[64];
 	uint8_t *ptk;
+	struct l_certchain *server_cert;
+	struct l_key *server_key;
+	struct l_queue *ca_cert;
 =

 	aa =3D ap_address;
 	spa =3D sta_address;
@@ -2955,9 +2958,13 @@ static void eapol_sm_test_tls(struct eapol_8021x_tls=
_test_state *s,
 	s->tx_buf_len =3D 0;
 	s->tx_buf_offset =3D 0;
 =

-	assert(l_tls_set_auth_data(s->tls, CERTDIR "cert-server.pem",
-				CERTDIR "cert-server-key-pkcs8.pem", NULL));
-	assert(l_tls_set_cacert(s->tls, CERTDIR "cert-ca.pem"));
+	server_cert =3D l_pem_load_certificate_chain(CERTDIR "cert-server.pem");
+	server_key =3D l_pem_load_private_key(CERTDIR "cert-server-key-pkcs8.pem",
+						NULL, NULL);
+	ca_cert =3D l_pem_load_certificate_list(CERTDIR "cert-ca.pem");
+
+	assert(l_tls_set_auth_data(s->tls, server_cert, server_key));
+	assert(l_tls_set_cacert(s->tls, ca_cert));
 	assert(l_tls_start(s->tls));
 =

 	ths->handshake_failed =3D false;
-- =

2.17.1

--===============9207003686250961601==--

