Content-Type: multipart/mixed; boundary="===============7686638255343664301=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 5/7] network: add 6GHz restrictions to
 network_can_connect_bss
Date: Fri, 25 Feb 2022 15:32:49 -0800
Message-ID: <20220225233251.2958102-5-prestwoj@gmail.com>
In-Reply-To: 20220225233251.2958102-1-prestwoj@gmail.com

--===============7686638255343664301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 802.11ax standards adds some restrictions for the 6GHz band. In short
stations must use SAE, OWE, or 8021x on this band and frame protection is
required.
---
 src/network.c | 58 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 13 deletions(-)

v3:
 * Combined some of the WPA3 checks with 6GHz that duplicated
 * Used macros rather than checking all valid AKMs

diff --git a/src/network.c b/src/network.c
index 4e7af27c..4a4a64ee 100644
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

@@ -814,26 +826,21 @@ int network_can_connect_bss(struct network *network, =
const struct scan_bss *bss)
 		return ret;
 	}
 =

-	if (!config || !config->have_transition_disable)
+	if (!config || !config->have_transition_disable) {
+		if (band =3D=3D BAND_FREQ_6_GHZ)
+			goto check_6ghz;
+
 		goto no_transition_disable;
+	}
 =

 	if (!can_transition_disable) {
+		if (band =3D=3D BAND_FREQ_6_GHZ)
+			return -EPERM;
+
 		l_debug("HW not capable of Transition Disable, skip");
 		goto no_transition_disable;
 	}
 =

-	/*
-	 * WPA3 Specification, v3, Section 8:
-	 * - Disable use of WEP and TKIP
-	 * - Disallow association without negotiation of PMF
-	 */
-	rsn.pairwise_ciphers &=3D ~IE_RSN_CIPHER_SUITE_TKIP;
-
-	if (!rsn.group_management_cipher)
-		return -EPERM;
-
-	rsn.mfpr =3D true;
-
 	/* WPA3-Personal */
 	if (test_bit(&config->transition_disable, 0)) {
 		rsn.akm_suites &=3D ~IE_RSN_AKM_SUITE_PSK;
@@ -851,6 +858,31 @@ int network_can_connect_bss(struct network *network, c=
onst struct scan_bss *bss)
 			return -EPERM;
 	}
 =

+check_6ghz:
+	/*
+	 * WPA3 Specification, v3, Section 8:
+	 * - Disable use of WEP and TKIP
+	 * - Disallow association without negotiation of PMF
+	 */
+	rsn.pairwise_ciphers &=3D ~IE_RSN_CIPHER_SUITE_TKIP;
+
+	if (!rsn.group_management_cipher)
+		return -EPERM;
+
+	rsn.mfpr =3D true;
+
+	/* 802.11ax Section 12.12.2 */
+	if (band =3D=3D BAND_FREQ_6_GHZ) {
+		/* STA shall not use the following cipher suite selectors */
+		rsn.pairwise_ciphers &=3D ~IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER;
+
+		/* Basically the STA must use OWE, SAE, or 8021x */
+		if (!IE_AKM_IS_SAE(rsn.akm_suites &&
+				!IE_AKM_IS_8021X(rsn.akm_suites) &&
+				(!(rsn.akm_suites | IE_RSN_AKM_SUITE_OWE))))
+			return -EPERM;
+	}
+
 no_transition_disable:
 	if (!wiphy_select_cipher(wiphy, rsn.pairwise_ciphers))
 		return -ENOTSUP;
-- =

2.34.1

--===============7686638255343664301==--

