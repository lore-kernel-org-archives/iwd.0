Content-Type: multipart/mixed; boundary="===============6924334939343329629=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] netdev: add CONNECTION_TYPE_8021X_OFFLOAD
Date: Thu, 08 Apr 2021 08:46:45 -0700
Message-ID: <20210408154646.1182833-4-prestwoj@gmail.com>
In-Reply-To: <20210408154646.1182833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6924334939343329629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds a new type for 8021x offload as well as support in
building CMD_CONNECT.

As described in the comment, 8021x offloading is not particularly
similar to PSK as far as the code flow in IWD is concerned. There
still needs to be an eapol_sm due to EAP being done in userspace.
This throws somewhat of a wrench into our 'is_offload' cases. And
as such this connection type is handled specially.
---
 src/netdev.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index dc4aa5bc..07d5e6aa 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -72,6 +72,7 @@ enum connection_type {
 	CONNECTION_TYPE_FULLMAC,
 	CONNECTION_TYPE_SAE_OFFLOAD,
 	CONNECTION_TYPE_PSK_OFFLOAD,
+	CONNECTION_TYPE_8021X_OFFLOAD,
 };
 =

 static uint32_t unicast_watch;
@@ -204,6 +205,15 @@ static inline bool is_offload(struct handshake_state *=
hs)
 	switch (nhs->type) {
 	case CONNECTION_TYPE_SOFTMAC:
 	case CONNECTION_TYPE_FULLMAC:
+	/*
+	 * 8021x offload does not quite fit into the same category of PSK
+	 * offload. First the netdev_connect_event comes prior to EAP meaning
+	 * the handshake is not done at this point. In addition it still
+	 * requires EAP take place in userspace meaning IWD needs an eapol_sm.
+	 * Because of this, and our prior use of 'is_offload', it does not fit
+	 * into the same category and will need to be handled specially.
+	 */
+	case CONNECTION_TYPE_8021X_OFFLOAD:
 		return false;
 	case CONNECTION_TYPE_SAE_OFFLOAD:
 	case CONNECTION_TYPE_PSK_OFFLOAD:
@@ -2751,6 +2761,9 @@ static struct l_genl_msg *netdev_build_cmd_connect(st=
ruct netdev *netdev,
 	case CONNECTION_TYPE_PSK_OFFLOAD:
 		l_genl_msg_append_attr(msg, NL80211_ATTR_PMK, 32, hs->pmk);
 		break;
+	case CONNECTION_TYPE_8021X_OFFLOAD:
+		l_genl_msg_append_attr(msg, NL80211_ATTR_WANT_1X_4WAY_HS,
+					0, NULL);
 	}
 =

 	if (prev_bssid)
@@ -3130,13 +3143,21 @@ static int netdev_handshake_state_setup_connection_=
type(
 		if (wiphy_has_ext_feature(wiphy,
 				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK))
 			goto psk_offload;
-		/* fall through */
+
+		if (softmac)
+			goto softmac;
+
+		goto fullmac;
 	case IE_RSN_AKM_SUITE_8021X:
 	case IE_RSN_AKM_SUITE_FT_OVER_8021X:
 	case IE_RSN_AKM_SUITE_8021X_SHA256:
 	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA256:
 	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA384:
 	case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
+		if (wiphy_has_ext_feature(wiphy,
+				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_1X))
+			goto offload_1x;
+
 		if (softmac)
 			goto softmac;
 =

@@ -3181,6 +3202,9 @@ sae_offload:
 psk_offload:
 	nhs->type =3D CONNECTION_TYPE_PSK_OFFLOAD;
 	return 0;
+offload_1x:
+	nhs->type =3D CONNECTION_TYPE_8021X_OFFLOAD;
+	return 0;
 }
 =

 static int netdev_connect_common(struct netdev *netdev,
@@ -3266,8 +3290,12 @@ build_cmd_connect:
 		if (!cmd_connect)
 			return -EINVAL;
 =

-		if (!is_offload(hs) && (is_rsn || hs->settings_8021x))
+		if (!is_offload(hs) && (is_rsn || hs->settings_8021x)) {
 			sm =3D eapol_sm_new(hs);
+
+			if (nhs->type =3D=3D CONNECTION_TYPE_8021X_OFFLOAD)
+				eapol_sm_set_require_handshake(sm, false);
+		}
 	}
 =

 	return netdev_connect_common(netdev, cmd_connect, bss, hs, sm,
-- =

2.26.2

--===============6924334939343329629==--

