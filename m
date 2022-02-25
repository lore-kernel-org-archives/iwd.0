Content-Type: multipart/mixed; boundary="===============6959627615932238460=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/3] network: add 6GHz restrictions to
 network_can_connect_bss
Date: Fri, 25 Feb 2022 14:03:36 -0800
Message-ID: <20220225220338.2942516-1-prestwoj@gmail.com>

--===============6959627615932238460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 802.11ax standards adds some restrictions for the 6GHz band. In short
stations must use SAE, OWE, or 8021x on this band and frame protection is
required.
---
 src/network.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

v2:
 * Removed mfpr setting since this is enforced in station.c

diff --git a/src/network.c b/src/network.c
index 4e7af27c..0aa2d3af 100644
--- a/src/network.c
+++ b/src/network.c
@@ -55,6 +55,7 @@
 #include "src/util.h"
 #include "src/erp.h"
 #include "src/handshake.h"
+#include "src/band.h"
 =

 #define SAE_PT_SETTING "SAE-PT-Group%u"
 =

@@ -774,6 +775,7 @@ int network_can_connect_bss(struct network *network, co=
nst struct scan_bss *bss)
 	struct network_config *config =3D info ? &info->config : NULL;
 	bool can_transition_disable =3D wiphy_can_transition_disable(wiphy);
 	struct ie_rsn_info rsn;
+	enum band_freq band;
 	int ret;
 =

 	switch (security) {
@@ -785,6 +787,9 @@ int network_can_connect_bss(struct network *network, co=
nst struct scan_bss *bss)
 		return -ENOSYS;
 	}
 =

+	if (!band_freq_to_channel(bss->frequency, &band))
+		return -ENOTSUP;
+
 	memset(&rsn, 0, sizeof(rsn));
 	ret =3D scan_bss_get_rsn_info(bss, &rsn);
 	if (ret < 0) {
@@ -797,6 +802,13 @@ int network_can_connect_bss(struct network *network, c=
onst struct scan_bss *bss)
 		 * We assume the spec means us to check bit 3 here
 		 */
 		if (ret =3D=3D -ENOENT && security =3D=3D SECURITY_NONE) {
+			/*
+			 * 802.11ax 12.12.2 - STA shall not use Open System
+			 * authentication without encryption
+			 */
+			if (band =3D=3D BAND_FREQ_6_GHZ)
+				return -EPERM;
+
 			if (!config)
 				return 0;
 =

@@ -852,6 +864,28 @@ int network_can_connect_bss(struct network *network, c=
onst struct scan_bss *bss)
 	}
 =

 no_transition_disable:
+	/* 802.11ax Section 12.12.2 */
+	if (band =3D=3D BAND_FREQ_6_GHZ) {
+		/* STA shall not use the following cipher suite selectors */
+		rsn.pairwise_ciphers &=3D ~IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER;
+		rsn.pairwise_ciphers &=3D ~IE_RSN_CIPHER_SUITE_TKIP;
+
+		/* STA shall not use the following AKM suite selectors */
+		rsn.akm_suites &=3D ~IE_RSN_AKM_SUITE_PSK;
+		rsn.akm_suites &=3D ~IE_RSN_AKM_SUITE_PSK_SHA256;
+		rsn.akm_suites &=3D ~IE_RSN_AKM_SUITE_FT_USING_PSK;
+
+		/* Basically the STA must use OWE, SAE, or 8021x */
+		if (!(rsn.akm_suites & (IE_RSN_AKM_SUITE_8021X |
+					IE_RSN_AKM_SUITE_FT_OVER_8021X |
+					IE_RSN_AKM_SUITE_8021X_SHA256 |
+					IE_RSN_AKM_SUITE_SAE_SHA256 |
+					IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256 |
+					IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384 |
+					IE_RSN_AKM_SUITE_OWE)))
+			return -EPERM;
+	}
+
 	if (!wiphy_select_cipher(wiphy, rsn.pairwise_ciphers))
 		return -ENOTSUP;
 =

-- =

2.34.1

--===============6959627615932238460==--

