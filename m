Content-Type: multipart/mixed; boundary="===============4205852278809825562=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/6] ie: parse operating class/channel for
 ie_owe_transition_info
Date: Wed, 22 Sep 2021 11:26:53 -0700
Message-ID: <20210922182655.46220-4-prestwoj@gmail.com>
In-Reply-To: 20210922182655.46220-1-prestwoj@gmail.com

--===============4205852278809825562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This operating class/channel is also verified while parsing and
parsing will fail if band_oci_frequency fails.

This does put a requirement on anything that uses ie.c to also
include band.c. Makefile has been updated.
---
 Makefile.am | 16 ++++++++++------
 src/ie.c    | 31 ++++++++++++++++++++-----------
 src/ie.h    |  2 ++
 3 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index ab1682bd..3885c47a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -316,7 +316,8 @@ monitor_iwmon_SOURCES =3D monitor/main.c linux/nl80211.=
h \
 					src/eapolutil.h src/eapolutil.c \
 					src/nl80211cmd.h src/nl80211cmd.c \
 					src/p2putil.c src/p2putil.h \
-					src/anqputil.h src/anqputil.c
+					src/anqputil.h src/anqputil.c \
+					src/band.h src/band.c
 monitor_iwmon_LDADD =3D $(ell_ldadd)
 =

 if MANUAL_PAGES
@@ -357,7 +358,8 @@ tools_probe_req_SOURCES =3D tools/probe-req.c src/mpdu.=
h src/mpdu.c \
 					src/ie.h src/ie.c \
 					src/nl80211util.h src/nl80211util.c \
 					src/util.h src/util.c \
-					src/common.h src/common.c
+					src/common.h src/common.c \
+					src/band.h src/band.c
 tools_probe_req_LDADD =3D $(ell_ldadd)
 =

 if HWSIM
@@ -439,7 +441,7 @@ unit_test_kdf_sha256_SOURCES =3D unit/test-kdf-sha256.c=
 \
 					src/crypto.h src/crypto.c
 unit_test_kdf_sha256_LDADD =3D $(ell_ldadd)
 =

-unit_test_ie_SOURCES =3D unit/test-ie.c src/ie.h src/ie.c
+unit_test_ie_SOURCES =3D unit/test-ie.c src/ie.h src/ie.c src/band.h src/b=
and.c
 unit_test_ie_LDADD =3D $(ell_ldadd)
 =

 unit_test_band_SOURCES =3D unit/test-band.c src/band.h src/band.c
@@ -451,7 +453,8 @@ unit_test_crypto_LDADD =3D $(ell_ldadd)
 =

 unit_test_mpdu_SOURCES =3D unit/test-mpdu.c \
 				src/mpdu.h src/mpdu.c \
-				src/ie.h src/ie.c
+				src/ie.h src/ie.c \
+				src/band.h src/band.c
 unit_test_mpdu_LDADD =3D $(ell_ldadd)
 =

 unit_test_eapol_SOURCES =3D unit/test-eapol.c \
@@ -481,7 +484,7 @@ unit_test_util_SOURCES =3D src/util.h src/util.c \
 unit_test_util_LDADD =3D $(ell_ldadd)
 =

 unit_test_ssid_security_SOURCES =3D unit/test-ssid-security.c src/ie.h src=
/ie.c \
-				src/common.h src/common.c
+				src/common.h src/common.c src/band.h src/band.c
 unit_test_ssid_security_LDADD =3D $(ell_ldadd)
 =

 unit_test_wsc_SOURCES =3D unit/test-wsc.c src/wscutil.h src/wscutil.c \
@@ -533,7 +536,8 @@ unit_test_p2p_SOURCES =3D unit/test-p2p.c src/wscutil.h=
 src/wscutil.c \
 				src/crypto.h src/crypto.c \
 				src/ie.h src/ie.c \
 				src/util.h src/util.c \
-				src/p2putil.h src/p2putil.c
+				src/p2putil.h src/p2putil.c \
+				src/band.h src/band.c
 unit_test_p2p_LDADD =3D $(ell_ldadd)
 =

 TESTS =3D $(unit_tests)
diff --git a/src/ie.c b/src/ie.c
index 773c54e0..5a2ea356 100644
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
@@ -2503,6 +2504,10 @@ int ie_parse_owe_transition(const void *data, size_t=
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
@@ -2520,22 +2525,26 @@ int ie_parse_owe_transition(const void *data, size_=
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
+
+		if (oci_to_frequency(oper_class, channel) < 0)
+			return -ENOMSG;
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
index 5258c6f3..e20c0c87 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -492,6 +492,8 @@ struct ie_owe_transition_info {
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

--===============4205852278809825562==--

