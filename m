Content-Type: multipart/mixed; boundary="===============8400252872586111305=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/8] monitor: Fix the OUI check for P2P action frames
Date: Thu, 24 Oct 2019 06:29:58 +0200
Message-ID: <20191024043000.13687-6-andrew.zaborowski@intel.com>
In-Reply-To: <20191024043000.13687-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8400252872586111305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

wsc_wfa_oui is different from wifi_alliance_oui.  Also use wsc_wfa_oui
instead of a local copy in print_wsc_vendor_extension.
---
 monitor/nlmon.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 53e24d10..7ad1f5d6 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -2633,7 +2633,6 @@ static void print_wsc_wfa_ext_attributes(unsigned int=
 level, const char *label,
 =

 static void print_wsc_vendor_extension(unsigned int level, const char *lab=
el,
 						const void *data, uint16_t size){
-	static const unsigned char wfa_ext[3] =3D { 0x00, 0x37, 0x2a };
 	const uint8_t *bytes =3D data;
 =

 	if (size < 3) {
@@ -2641,7 +2640,7 @@ static void print_wsc_vendor_extension(unsigned int l=
evel, const char *label,
 		return;
 	}
 =

-	if (memcmp(data, wfa_ext, sizeof(wfa_ext))) {
+	if (memcmp(data, wsc_wfa_oui, sizeof(wsc_wfa_oui))) {
 		print_attr(level, "%s: OUI: 0x%02x 0x%02x 0x%02x: len %u",
 				label, bytes[0], bytes[1], bytes[2], size);
 		print_hexdump(level + 1, data + 3, size - 3);
@@ -3930,7 +3929,7 @@ static void print_public_action_frame(unsigned int le=
vel, const uint8_t *body,
 	if (body_len < 5)
 		return;
 =

-	if (!memcmp(oui, wsc_wfa_oui, 3) && oui[3] =3D=3D 0x09) {
+	if (!memcmp(oui, wifi_alliance_oui, 3) && oui[3] =3D=3D 0x09) {
 		if (body[0] !=3D 9)
 			return;
 =

@@ -4060,7 +4059,7 @@ static void print_action_mgmt_frame(unsigned int leve=
l,
 		if (!print_oui(level, oui))
 			return;
 =

-		if (!memcmp(oui, wsc_wfa_oui, 3) && oui[3] =3D=3D 0x09)
+		if (!memcmp(oui, wifi_alliance_oui, 3) && oui[3] =3D=3D 0x09)
 			print_p2p_action_frame(level + 1, body + 5,
 						body_len - 5);
 	}
-- =

2.20.1

--===============8400252872586111305==--

