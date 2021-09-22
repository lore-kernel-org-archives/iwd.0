Content-Type: multipart/mixed; boundary="===============7402669096064716355=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/4] ie: parse operating class/channel for
 ie_owe_transition_info
Date: Wed, 22 Sep 2021 12:34:15 -0700
Message-ID: <20210922193418.13072-1-prestwoj@gmail.com>

--===============7402669096064716355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This operating class/channel is also verified while parsing and
parsing will fail if band_oci_frequency fails.

This does put a requirement on anything that uses ie.c to also
include band.c. Makefile has been updated.
---
 src/ie.c | 28 +++++++++++++++++-----------
 src/ie.h |  2 ++
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/src/ie.c b/src/ie.c
index 0abc01cb..f0163ea2 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -33,6 +33,7 @@
 #include "src/util.h"
 #include "src/crypto.h"
 #include "src/ie.h"
+#include "src/band.h"
 =

 const unsigned char ieee_oui[3] =3D { 0x00, 0x0f, 0xac };
 const unsigned char microsoft_oui[3] =3D { 0x00, 0x50, 0xf2 };
@@ -2504,6 +2505,10 @@ int ie_parse_owe_transition(const void *data, size_t=
 len,
 				struct ie_owe_transition_info *info)
 {
 	const uint8_t *ie =3D data;
+	const uint8_t *bssid;
+	const uint8_t *ssid;
+	uint8_t oper_class =3D 0;
+	uint8_t channel =3D 0;
 	size_t slen;
 =

 	if (len < 14 || ie[0] !=3D IE_TYPE_VENDOR_SPECIFIC)
@@ -2521,22 +2526,23 @@ int ie_parse_owe_transition(const void *data, size_=
t len,
 	 *
 	 * "Band Info and Channel Info are optional fields. If configured,
 	 * both fields shall be included in an OWE Transition Mode element"
-	 *
-	 * TODO: Support Band/Channel bytes:
-	 * For the time being the OWE transition AP is assumed to be on the same
-	 * channel as the open AP. This means there should be no band/channel
-	 * bytes at the end of the IE. Currently hostapd has no support for this
-	 * so it can be skipped. In addition 802.11 Appendix E-1 needs to be
-	 * encoded as a table to map Country/operating class to channels to make
-	 * any sense of it.
 	 */
-	if (len !=3D slen + 13)
+	if (len !=3D slen + 13 && len !=3D slen + 15)
 		return -ENOMSG;
 =

-	memcpy(info->bssid, ie + 6, 6);
+	bssid =3D ie + 6;
+	ssid =3D ie + 13;
+
+	if (len =3D=3D slen + 15) {
+		oper_class =3D l_get_u8(ie + 13 + slen);
+		channel =3D l_get_u8(ie + 14 + slen);
+	}
 =

-	memcpy(info->ssid, ie + 13, slen);
+	memcpy(info->bssid, bssid, 6);
+	memcpy(info->ssid, ssid, slen);
 	info->ssid_len =3D slen;
+	info->oper_class =3D oper_class;
+	info->channel =3D channel;
 =

 	return 0;
 }
diff --git a/src/ie.h b/src/ie.h
index 81388496..c912d6c3 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -493,6 +493,8 @@ struct ie_owe_transition_info {
 	uint8_t bssid[6];
 	uint8_t ssid[32];
 	size_t ssid_len;
+	uint8_t oper_class;
+	uint8_t channel;
 };
 =

 extern const unsigned char ieee_oui[3];
-- =

2.31.1

--===============7402669096064716355==--

