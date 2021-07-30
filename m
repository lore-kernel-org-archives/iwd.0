Content-Type: multipart/mixed; boundary="===============4557596218666104164=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] eap-aka: round to nearest word on message buffers
Date: Fri, 30 Jul 2021 08:07:26 -0700
Message-ID: <20210730150727.199809-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4557596218666104164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

One of these message buffers was overflowing due to padding not
being taken into account (caught by sanitizers). Wrapped the length
of all message buffers with EAP_SIM_ROUND as to account for any
padding that attributes may add.
---
 src/eap-aka.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/eap-aka.c b/src/eap-aka.c
index 3ac0b662..9b693875 100644
--- a/src/eap-aka.c
+++ b/src/eap-aka.c
@@ -189,7 +189,7 @@ static void check_milenage_cb(const uint8_t *res, const=
 uint8_t *ck,
 	struct eap_aka_handle *aka =3D eap_get_data(eap);
 =

 	size_t resp_len =3D aka->protected ? 44 : 40;
-	uint8_t response[resp_len + 4];
+	uint8_t response[EAP_SIM_ROUND(resp_len + 4)];
 	uint8_t *pos =3D response;
 =

 	if (auts) {
@@ -512,7 +512,7 @@ static void handle_notification(struct eap_state *eap, =
const uint8_t *pkt,
 	if (value =3D=3D EAP_SIM_SUCCESS && aka->protected &&
 			aka->state =3D=3D EAP_AKA_STATE_CHALLENGE) {
 		/* header + MAC + MAC header */
-		uint8_t response[8 + EAP_SIM_MAC_LEN + 4];
+		uint8_t response[EAP_SIM_ROUND(8 + EAP_SIM_MAC_LEN + 4)];
 		uint8_t *pos =3D response;
 =

 		/*
@@ -564,7 +564,7 @@ static void handle_identity(struct eap_state *eap, cons=
t uint8_t *pkt,
 		size_t len)
 {
 	struct eap_aka_handle *aka =3D eap_get_data(eap);
-	uint8_t response[8 + strlen(aka->identity) + 4];
+	uint8_t response[EAP_SIM_ROUND(8 + strlen(aka->identity) + 4)];
 	uint8_t *pos =3D response;
 =

 	if (aka->state !=3D EAP_AKA_STATE_UNCONNECTED) {
-- =

2.31.1

--===============4557596218666104164==--

