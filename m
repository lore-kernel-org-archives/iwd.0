Content-Type: multipart/mixed; boundary="===============7434461573893920329=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/6] wiphy: check SAE offload in wiphy_select_akm
Date: Mon, 22 Mar 2021 09:01:52 -0700
Message-ID: <20210322160156.392256-2-prestwoj@gmail.com>
In-Reply-To: <20210322160156.392256-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7434461573893920329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows an SAE AKM to be selected if the hardware does not
support SAE in userspace, but does support SAE offload.
---
 src/wiphy.c | 59 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 12 deletions(-)

v2:
 * Added large comments explaing all the possible scenarios

diff --git a/src/wiphy.c b/src/wiphy.c
index e230b273..89186ce3 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -126,6 +126,52 @@ enum ie_rsn_cipher_suite wiphy_select_cipher(struct wi=
phy *wiphy, uint16_t mask)
 	return 0;
 }
 =

+static bool wiphy_can_connect_sae(struct wiphy *wiphy)
+{
+	/*
+	 * SAE support in the kernel is a complete mess in that there are 3
+	 * different ways the hardware can support SAE:
+	 *
+	 * 1. Cards which allow SAE in userspace, meaning they support both
+	 *    CMD_AUTHENTICATE and CMD_ASSOCIATE as well as advertise support
+	 *    for FEATURE_SAE (SoftMAC).
+	 *
+	 * 2. Cards which allow SAE to be offloaded to hardware. These cards
+	 *    do not support AUTH/ASSOC commands, do not advertise FEATURE_SAE,
+	 *    but advertise support for EXT_FEATURE_SAE_OFFLOAD. With these
+	 *    cards the entire SAE protocol as well as the subsequent 4-way
+	 *    handshake are all done in the driver/firmware (fullMAC).
+	 *
+	 * 3. TODO: Cards which allow SAE in userspace via CMD_EXTERNAL_AUTH.
+	 *    These cards do not support AUTH/ASSOC commands but do implement
+	 *    CMD_EXTERNAL_AUTH which is supposed to allow userspace to
+	 *    generate Authenticate frames as it would for case (1). As it
+	 *    stands today only one driver actually uses CMD_EXTERNAL_AUTH and
+	 *    for now IWD will not allow connections to SAE networks using this
+	 *    mechanism.
+	 */
+
+	if (wiphy_has_feature(wiphy, NL80211_FEATURE_SAE)) {
+		/* Case (1) */
+		if (wiphy->support_cmds_auth_assoc)
+			return true;
+
+		/*
+		 * Case (3)
+		 *
+		 * TODO: No support for CMD_EXTERNAL_AUTH yet.
+		 */
+		return false;
+	} else {
+		/* Case (2) */
+		if (wiphy_has_ext_feature(wiphy,
+					NL80211_EXT_FEATURE_SAE_OFFLOAD))
+			return true;
+
+		return false;
+	}
+}
+
 enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wiphy,
 					struct scan_bss *bss,
 					bool fils_capable_hint)
@@ -188,19 +234,8 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *w=
iphy,
 				goto wpa2_personal;
 			}
 =

-			/*
-			 * TODO: Only SoftMAC (mac80211) drivers are currently
-			 * capable of SAE since it requires ability to send
-			 * Authenticate and Associate frames (which is given by
-			 * support_cmds_auth_assoc).  FullMAC drivers require
-			 * SAE offload which we do not support nor supported
-			 * in any upstream driver as of this time.
-			 */
-			if (!wiphy_has_feature(wiphy, NL80211_FEATURE_SAE) ||
-					!wiphy->support_cmds_auth_assoc) {
-				l_debug("No HW WPA3 support, trying WPA2");
+			if (!wiphy_can_connect_sae(wiphy))
 				goto wpa2_personal;
-			}
 =

 			if (info.akm_suites &
 					IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256)
-- =

2.26.2

--===============7434461573893920329==--

