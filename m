Content-Type: multipart/mixed; boundary="===============1720411401056465438=="
MIME-Version: 1.0
From: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
Subject: [PATCH 1/2] eap: avoid nested functions
Date: Fri, 14 May 2021 18:34:13 +0200
Message-ID: <20210514163414.304860-1-Marc-Antoine@Perennou.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1720411401056465438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
---
 src/eap.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/src/eap.c b/src/eap.c
index 0645be47..53e35b5e 100644
--- a/src/eap.c
+++ b/src/eap.c
@@ -416,6 +416,8 @@ static const char *eap_type_to_str(enum eap_type type, =
uint32_t vendor_id,
 #define IS_EXPANDED_RESPONSE(id, t) \
 	(type =3D=3D EAP_TYPE_EXPANDED && vendor_id =3D=3D (id) && vendor_type =
=3D=3D (t))
 =

+#define response_is(wanted) ((type =3D=3D wanted) || IS_EXPANDED_RESPONSE(=
0, wanted))
+
 static void eap_handle_response(struct eap_state *eap, const uint8_t *pkt,
 				size_t len)
 {
@@ -428,14 +430,6 @@ static void eap_handle_response(struct eap_state *eap,=
 const uint8_t *pkt,
 				eap->method->vendor_id[2];
 	uint32_t our_vendor_type =3D eap->method->vendor_type;
 =

-	bool response_is(enum eap_type wanted)
-	{
-		if (type =3D=3D wanted)
-			return true;
-
-		return IS_EXPANDED_RESPONSE(0, wanted);
-	}
-
 	if (len < 1)
 		/* Invalid packets to be ignored */
 		return;
-- =

2.30.0

--===============1720411401056465438==--

