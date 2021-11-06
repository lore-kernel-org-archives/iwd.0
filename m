Content-Type: multipart/mixed; boundary="===============0616154899837865398=="
MIME-Version: 1.0
From: Marc-Antoine Perennou <Marc-Antoine at Perennou.com>
To: iwd at lists.01.org
Subject: [PATCH] eap: Remove nested function use
Date: Sat, 06 Nov 2021 20:34:32 +0100
Message-ID: <20211106193432.4018165-1-Marc-Antoine@Perennou.com>

--===============0616154899837865398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows building iwd with clang

Signed-off-by: Marc-Antoine Perennou <Marc-Antoine(a)Perennou.com>
---
 src/eap.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/src/eap.c b/src/eap.c
index 0645be47..10381af7 100644
--- a/src/eap.c
+++ b/src/eap.c
@@ -416,6 +416,9 @@ static const char *eap_type_to_str(enum eap_type type, =
uint32_t vendor_id,
 #define IS_EXPANDED_RESPONSE(id, t) \
 	(type =3D=3D EAP_TYPE_EXPANDED && vendor_id =3D=3D (id) && vendor_type =
=3D=3D (t))
 =

+#define RESPONSE_IS(t) \
+	(type =3D=3D (t) || IS_EXPANDED_RESPONSE(0, (t)))
+
 static void eap_handle_response(struct eap_state *eap, const uint8_t *pkt,
 				size_t len)
 {
@@ -428,14 +431,6 @@ static void eap_handle_response(struct eap_state *eap,=
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
@@ -461,7 +456,7 @@ static void eap_handle_response(struct eap_state *eap, =
const uint8_t *pkt,
 			return;
 	}
 =

-	if (response_is(EAP_TYPE_NAK)) {
+	if (RESPONSE_IS(EAP_TYPE_NAK)) {
 		l_debug("EAP peer not configured for method: %s",
 			eap_type_to_str(our_type, our_vendor_id,
 							our_vendor_type));
@@ -500,7 +495,7 @@ static void eap_handle_response(struct eap_state *eap, =
const uint8_t *pkt,
 	 */
 =

 	if (!eap->identity) {
-		if (!response_is(EAP_TYPE_IDENTITY))
+		if (!RESPONSE_IS(EAP_TYPE_IDENTITY))
 			goto unsupported_method;
 =

 		/*
@@ -528,7 +523,7 @@ static void eap_handle_response(struct eap_state *eap, =
const uint8_t *pkt,
 	 * (with the exception of the Nak)
 	 */
 	if (our_type !=3D EAP_TYPE_EXPANDED) {
-		if (response_is(our_type))
+		if (RESPONSE_IS(our_type))
 			goto handle_response;
 	} else if (IS_EXPANDED_RESPONSE(our_vendor_id, our_vendor_type))
 		goto handle_response;
-- =

2.33.0

--===============0616154899837865398==--

