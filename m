Content-Type: multipart/mixed; boundary="===============6564373162774314600=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/7] wiphy: check offload in wiphy_can_connect
Date: Tue, 30 Mar 2021 09:13:04 -0700
Message-ID: <20210330161307.732965-4-prestwoj@gmail.com>
In-Reply-To: <20210330161307.732965-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6564373162774314600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will check if offload is supported and enabled by the user.
A new case was added for FT just in case the AP sets only an FT
AKM.
---
 src/wiphy.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 395bf74d..b64d2b74 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -420,6 +420,9 @@ bool wiphy_can_connect(struct wiphy *wiphy, struct scan=
_bss *bss)
 {
 	struct ie_rsn_info rsn_info;
 	int r;
+	bool offload_needed;
+	bool offload_on;
+	const struct l_settings *settings =3D iwd_get_config();
 =

 	memset(&rsn_info, 0, sizeof(rsn_info));
 	r =3D scan_bss_get_rsn_info(bss, &rsn_info);
@@ -435,11 +438,29 @@ bool wiphy_can_connect(struct wiphy *wiphy, struct sc=
an_bss *bss)
 					rsn_info.group_management_cipher))
 			return false;
 =

+		if (!l_settings_get_bool(settings, "General", "4WayOffload",
+						&offload_on))
+			offload_on =3D false;
 =

 		switch (rsn_info.akm_suites) {
 		case IE_RSN_AKM_SUITE_SAE_SHA256:
 		case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
-			if (!wiphy_can_connect_sae(wiphy, NULL))
+			if (!wiphy_can_connect_sae(wiphy, &offload_needed))
+				return false;
+
+			if (offload_needed && !offload_on)
+				return false;
+
+			break;
+		case IE_RSN_AKM_SUITE_FT_USING_PSK:
+			if (wiphy->support_cmds_auth_assoc)
+				return true;
+
+			if (!wiphy_has_ext_feature(wiphy,
+				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK))
+				return false;
+
+			if (!offload_on)
 				return false;
 =

 			break;
-- =

2.26.2

--===============6564373162774314600==--

