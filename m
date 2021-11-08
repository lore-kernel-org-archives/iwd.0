Content-Type: multipart/mixed; boundary="===============6081113897078659962=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2] eap: fix uninitialized variable error
Date: Mon, 08 Nov 2021 12:55:04 -0800
Message-ID: <20211108205504.1023277-1-prestwoj@gmail.com>

--===============6081113897078659962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

src/eap.c: In function 'eap_rx_packet':
src/eap.c:417:57: error: 'vendor_type' may be used uninitialized in this
                          function [-Werror=3Dmaybe-uninitialized]
  417 |  (type =3D=3D EAP_TYPE_EXPANDED && vendor_id =3D=3D (id) && vendor_=
type =3D=3D (t))
---
 src/eap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/eap.c b/src/eap.c
index 10381af7..b67049fd 100644
--- a/src/eap.c
+++ b/src/eap.c
@@ -424,7 +424,7 @@ static void eap_handle_response(struct eap_state *eap, =
const uint8_t *pkt,
 {
 	enum eap_type type;
 	uint32_t vendor_id;
-	uint32_t vendor_type;
+	uint32_t vendor_type =3D 0;
 	enum eap_type our_type =3D eap->method->request_type;
 	uint32_t our_vendor_id =3D (eap->method->vendor_id[0] << 16) |
 				(eap->method->vendor_id[1] << 8) |
-- =

2.31.1

--===============6081113897078659962==--

