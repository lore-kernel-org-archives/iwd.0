Content-Type: multipart/mixed; boundary="===============7051630801645675360=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/7] wiphy: allow FT AKM to be used if Auth/Assoc is not
 supported
Date: Tue, 30 Mar 2021 09:13:03 -0700
Message-ID: <20210330161307.732965-3-prestwoj@gmail.com>
In-Reply-To: <20210330161307.732965-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7051630801645675360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Until now FT was only supported via Auth/Assoc commands which barred
any fullmac cards from using FT AKMs. With PSK offload support these
cards can do FT but only when offloading is used. This situation
is checked now which allows the FT AKM to be selected.

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
 src/wiphy.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index d40c90ba..395bf74d 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -185,12 +185,19 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *=
wiphy,
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
@@ -241,7 +248,10 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *w=
iphy,
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
@@ -253,10 +263,21 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *=
wiphy,
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
+					offload_on)
+				return IE_RSN_AKM_SUITE_FT_USING_PSK;
+		}
 =

 		if (info.akm_suites & IE_RSN_AKM_SUITE_PSK_SHA256)
 			return IE_RSN_AKM_SUITE_PSK_SHA256;
-- =

2.26.2

--===============7051630801645675360==--

