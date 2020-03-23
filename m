Content-Type: multipart/mixed; boundary="===============1701772815794689481=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] wiphy: add check for CMD_AUTH/CMD_ASSOC support
Date: Mon, 23 Mar 2020 09:18:21 -0700
Message-ID: <20200323161821.12366-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1701772815794689481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the AP only supports an AKM which requires an auth protocol
CMD_AUTHENTICATE/CMD_ASSOCIATE must be supported or else the
auth protocol cannot be run. All the auth protocols are started
assuming that the card supports these commands, but the support
was never checked when parsing supported commands.

This patch will prevent any fullMAC cards from using
SAE/FILS/OWE. This was the same behavior as before, just an
earlier failure path.
---
 src/wiphy.c | 48 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index b8e80b00..8abf1b0f 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -86,6 +86,7 @@ struct wiphy {
 	bool support_rekey_offload:1;
 	bool support_adhoc_rsn:1;
 	bool support_qos_set_map:1;
+	bool support_cmds_auth_assoc:1;
 	bool soft_rfkill : 1;
 	bool hard_rfkill : 1;
 	bool offchannel_tx_ok : 1;
@@ -328,16 +329,32 @@ bool wiphy_can_connect(struct wiphy *wiphy, struct sc=
an_bss *bss)
 					rsn_info.group_management_cipher))
 			return false;
 =

-		/*
-		 * if the AP ONLY supports SAE/WPA3, then we can only connect
-		 * if the wiphy feature is supported. Otherwise the AP may list
-		 * SAE as one of the AKM's but also support PSK (hybrid). In
-		 * this case we still want to allow a connection even if SAE
-		 * is not supported.
-		 */
-		if (IE_AKM_IS_SAE(rsn_info.akm_suites) &&
-				!wiphy_has_feature(wiphy, NL80211_FEATURE_SAE))
-			return false;
+
+		switch (rsn_info.akm_suites) {
+		case IE_RSN_AKM_SUITE_SAE_SHA256:
+		case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
+			/*
+			 * if the AP ONLY supports SAE/WPA3, then we can only
+			 * connect if the wiphy feature is supported. Otherwise
+			 * the AP may list SAE as one of the AKM's but also
+			 * support PSK (hybrid). In this case we still want to
+			 * allow a connection even if SAE is not supported.
+			 */
+			if (!wiphy_has_feature(wiphy, NL80211_FEATURE_SAE) ||
+						!wiphy->support_cmds_auth_assoc)
+				return false;
+
+			break;
+		case IE_RSN_AKM_SUITE_OWE:
+		case IE_RSN_AKM_SUITE_FILS_SHA256:
+		case IE_RSN_AKM_SUITE_FILS_SHA384:
+		case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
+		case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
+			if (!wiphy->support_cmds_auth_assoc)
+				return false;
+
+			break;
+		}
 	} else if (r !=3D -ENOENT)
 		return false;
 =

@@ -614,6 +631,8 @@ static void parse_supported_commands(struct wiphy *wiph=
y,
 {
 	uint16_t type, len;
 	const void *data;
+	bool auth =3D false;
+	bool assoc =3D false;
 =

 	while (l_genl_attr_next(attr, &type, &len, &data)) {
 		uint32_t cmd =3D *(uint32_t *)data;
@@ -628,8 +647,17 @@ static void parse_supported_commands(struct wiphy *wip=
hy,
 		case NL80211_CMD_SET_QOS_MAP:
 			wiphy->support_qos_set_map =3D true;
 			break;
+		case NL80211_CMD_AUTHENTICATE:
+			auth =3D true;
+			break;
+		case NL80211_CMD_ASSOCIATE:
+			assoc =3D true;
+			break;
 		}
 	}
+
+	if (auth && assoc)
+		wiphy->support_cmds_auth_assoc =3D true;
 }
 =

 static void parse_supported_ciphers(struct wiphy *wiphy, const void *data,
-- =

2.21.1

--===============1701772815794689481==--

