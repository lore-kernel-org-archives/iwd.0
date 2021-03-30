Content-Type: multipart/mixed; boundary="===============4864815621369980701=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/7] wiphy: allow FT AKM to be used if Auth/Assoc is not
 supported
Date: Tue, 30 Mar 2021 14:09:17 -0700
Message-ID: <20210330210921.750967-3-prestwoj@gmail.com>
In-Reply-To: <20210330210921.750967-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4864815621369980701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Until now FT was only supported via Auth/Assoc commands which barred
any fullmac cards from using FT AKMs. With PSK offload support these
cards can do FT but only when offloading is used. This situation
is checked now by wiphy_select_akm and a boolean is returned as an
out parameter indicating if offloading is needed.

A new option [General].4WayOffload was added which is required to
enable this functionality. This was done mainly because it is
unknown how stable firmware offloading is from card to card.

Note: Enabling offload has one strange side effect which could
cause users problems when experimenting with this option. Once
offload is enabled the firmware no longer forwards eapol frames
for subsequent connections, even if offload is no longer being
used. Once enabled a user must restart the firmware (e.g. via
rebooting the machine) if they want to turn off the option.
---
 src/p2p.c     |  2 +-
 src/station.c |  2 +-
 src/wiphy.c   | 50 ++++++++++++++++++++++++++++++++++++++++++--------
 src/wiphy.h   |  3 ++-
 4 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index e3130e21..7ee753a2 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1475,7 +1475,7 @@ static void p2p_try_connect_group(struct p2p_device *=
dev)
 =

 	scan_bss_get_rsn_info(bss, &bss_info);
 =

-	rsn_info.akm_suites =3D wiphy_select_akm(dev->wiphy, bss, false);
+	rsn_info.akm_suites =3D wiphy_select_akm(dev->wiphy, bss, false, NULL);
 	if (!rsn_info.akm_suites)
 		goto not_supported;
 =

diff --git a/src/station.c b/src/station.c
index cf4dd2e7..0329d990 100644
--- a/src/station.c
+++ b/src/station.c
@@ -824,7 +824,7 @@ static int station_build_handshake_rsn(struct handshake=
_state *hs,
 	if (security =3D=3D SECURITY_8021X && hs->support_fils)
 		fils_hint =3D station_has_erp_identity(network);
 =

-	info.akm_suites =3D wiphy_select_akm(wiphy, bss, fils_hint);
+	info.akm_suites =3D wiphy_select_akm(wiphy, bss, fils_hint, NULL);
 =

 	/*
 	 * Special case for OWE. With OWE we still need to build up the
diff --git a/src/wiphy.c b/src/wiphy.c
index cf8c7c56..b6b82933 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -181,16 +181,24 @@ static bool wiphy_can_connect_sae(struct wiphy *wiphy=
, bool *offload)
 =

 enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wiphy,
 					struct scan_bss *bss,
-					bool fils_capable_hint)
+					bool fils_capable_hint,
+					bool *offload)
 {
 	struct ie_rsn_info info;
 	enum security security;
+	bool offload_on;
+	bool offload_needed;
+	const struct l_settings *settings =3D iwd_get_config();
 =

 	memset(&info, 0, sizeof(info));
 	scan_bss_get_rsn_info(bss, &info);
 =

 	security =3D security_determine(bss->capability, &info);
 =

+	if (!l_settings_get_bool(settings, "General", "4WayOffload",
+					&offload_on))
+		offload_on =3D false;
+
 	/*
 	 * If FT is available, use FT authentication to keep the door open
 	 * for fast transitions.  Otherwise use SHA256 version if present.
@@ -241,22 +249,48 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *=
wiphy,
 				goto wpa2_personal;
 			}
 =

-			if (!wiphy_can_connect_sae(wiphy, NULL))
+			if (!wiphy_can_connect_sae(wiphy, &offload_needed))
+				goto wpa2_personal;
+
+			if (offload_needed && !offload_on)
 				goto wpa2_personal;
 =

 			if (info.akm_suites &
-					IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256)
+					IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256) {
+				if (offload)
+					*offload =3D offload_needed;
+
 				return IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256;
+			}
+
+			if (info.akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256) {
+				if (offload)
+					*offload =3D offload_needed;
 =

-			if (info.akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256)
 				return IE_RSN_AKM_SUITE_SAE_SHA256;
+			}
 		}
 =

 wpa2_personal:
+		/*
+		 * Allow FT if either Auth/Assoc is supported OR if the card
+		 * supports PSK offload. Without Auth/Assoc, PSK offload is the
+		 * only mechanism to allow FT on these cards.
+		 */
 		if ((info.akm_suites & IE_RSN_AKM_SUITE_FT_USING_PSK) &&
-				bss->rsne && bss->mde_present &&
-				wiphy->support_cmds_auth_assoc)
-			return IE_RSN_AKM_SUITE_FT_USING_PSK;
+					bss->rsne && bss->mde_present) {
+			if (wiphy->support_cmds_auth_assoc)
+				return IE_RSN_AKM_SUITE_FT_USING_PSK;
+
+			if (wiphy_has_ext_feature(wiphy,
+				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK) &&
+					offload_on) {
+				if (offload)
+					*offload =3D true;
+
+				return IE_RSN_AKM_SUITE_FT_USING_PSK;
+			}
+		}
 =

 		if (info.akm_suites & IE_RSN_AKM_SUITE_PSK_SHA256)
 			return IE_RSN_AKM_SUITE_PSK_SHA256;
@@ -414,7 +448,7 @@ bool wiphy_can_connect(struct wiphy *wiphy, struct scan=
_bss *bss)
 					rsn_info.group_management_cipher))
 			return false;
 =

-		return wiphy_select_akm(wiphy, bss, false);
+		return wiphy_select_akm(wiphy, bss, false, NULL);
 	} else if (r !=3D -ENOENT)
 		return false;
 =

diff --git a/src/wiphy.h b/src/wiphy.h
index 6c91220c..7ac1df95 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -57,7 +57,8 @@ enum ie_rsn_cipher_suite wiphy_select_cipher(struct wiphy=
 *wiphy,
 							uint16_t mask);
 enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wiphy,
 					struct scan_bss *bss,
-					bool fils_capable_hint);
+					bool fils_capable_hint,
+					bool *offload);
 =

 struct wiphy *wiphy_find(int wiphy_id);
 #define wiphy_find_by_wdev(w) wiphy_find(w >> 32)
-- =

2.26.2

--===============4864815621369980701==--

