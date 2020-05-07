Content-Type: multipart/mixed; boundary="===============5133544810108035312=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] netdev: unify ft/auth_proto authenticate builders
Date: Thu, 07 May 2020 14:50:58 -0700
Message-ID: <20200507215059.15987-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5133544810108035312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

build_cmd_ft_authenticate and build_cmd_authenticate were virtually
identical. These have been unified into a single builder.

We were also incorrectly including ATTR_IE to every authenticate
command, which violates the spec for certain protocols, This was
removed and any auth protocols will now add any IEs that they require.
---
 src/netdev.c | 46 ++++++++--------------------------------------
 1 file changed, 8 insertions(+), 38 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index b3c3bf73..e469fb1c 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2129,8 +2129,7 @@ static void netdev_cmd_connect_cb(struct l_genl_msg *=
msg, void *user_data)
 }
 =

 static struct l_genl_msg *netdev_build_cmd_authenticate(struct netdev *net=
dev,
-							uint32_t auth_type,
-							const uint8_t *addr)
+							uint32_t auth_type)
 {
 	struct handshake_state *hs =3D netdev->handshake;
 	struct l_genl_msg *msg;
@@ -2139,13 +2138,11 @@ static struct l_genl_msg *netdev_build_cmd_authenti=
cate(struct netdev *netdev,
 	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ,
 						4, &netdev->frequency);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, addr);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN,
+				netdev->handshake->aa);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->ssid);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_AUTH_TYPE, 4, &auth_type);
 =

-	l_genl_msg_append_attr(msg, NL80211_ATTR_IE, hs->supplicant_ie[1] + 2,
-					hs->supplicant_ie);
-
 	return msg;
 }
 =

@@ -2181,8 +2178,7 @@ static void netdev_sae_tx_authenticate(const uint8_t =
*body,
 	struct netdev *netdev =3D user_data;
 	struct l_genl_msg *msg;
 =

-	msg =3D netdev_build_cmd_authenticate(netdev, NL80211_AUTHTYPE_SAE,
-						netdev->handshake->aa);
+	msg =3D netdev_build_cmd_authenticate(netdev, NL80211_AUTHTYPE_SAE);
 =

 	l_genl_msg_append_attr(msg, NL80211_ATTR_AUTH_DATA, body_len, body);
 =

@@ -2228,8 +2224,7 @@ static void netdev_owe_tx_authenticate(void *user_dat=
a)
 	struct l_genl_msg *msg;
 =

 	msg =3D netdev_build_cmd_authenticate(netdev,
-						NL80211_AUTHTYPE_OPEN_SYSTEM,
-						netdev->handshake->aa);
+						NL80211_AUTHTYPE_OPEN_SYSTEM);
 =

 	if (!l_genl_family_send(nl80211, msg, netdev_auth_cb,
 							netdev, NULL)) {
@@ -2265,8 +2260,7 @@ static void netdev_fils_tx_authenticate(const uint8_t=
 *body,
 	struct netdev *netdev =3D user_data;
 	struct l_genl_msg *msg;
 =

-	msg =3D netdev_build_cmd_authenticate(netdev, NL80211_AUTHTYPE_FILS_SK,
-						netdev->handshake->aa);
+	msg =3D netdev_build_cmd_authenticate(netdev, NL80211_AUTHTYPE_FILS_SK);
 =

 	l_genl_msg_append_attr(msg, NL80211_ATTR_AUTH_DATA, body_len, body);
 =

@@ -2941,30 +2935,6 @@ static uint32_t netdev_send_action_frame(struct netd=
ev *netdev,
 	return netdev_send_action_framev(netdev, to, iov, 1, freq, callback);
 }
 =

-/*
- * Build an FT Authentication Request frame according to 12.5.2 / 12.5.4:
- * RSN or non-RSN Over-the-air FT Protocol, with the IE contents
- * according to 12.8.2: FT authentication sequence: contents of first mess=
age.
- */
-static struct l_genl_msg *netdev_build_cmd_ft_authenticate(
-					struct netdev *netdev,
-					const struct handshake_state *hs)
-{
-	uint32_t auth_type =3D NL80211_AUTHTYPE_FT;
-	struct l_genl_msg *msg;
-
-	msg =3D l_genl_msg_new_sized(NL80211_CMD_AUTHENTICATE, 512);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ,
-						4, &netdev->frequency);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, hs->aa);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->ssid);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_AUTH_TYPE, 4, &auth_type);
-
-	return msg;
-
-}
-
 static void netdev_cmd_authenticate_ft_cb(struct l_genl_msg *msg,
 						void *user_data)
 {
@@ -2984,8 +2954,8 @@ static void netdev_ft_tx_authenticate(struct iovec *i=
ov,
 	struct netdev *netdev =3D user_data;
 	struct l_genl_msg *cmd_authenticate;
 =

-	cmd_authenticate =3D netdev_build_cmd_ft_authenticate(netdev,
-							netdev->handshake);
+	cmd_authenticate =3D netdev_build_cmd_authenticate(netdev,
+							NL80211_AUTHTYPE_FT);
 	if (!cmd_authenticate)
 		goto restore_snonce;
 =

-- =

2.21.1

--===============5133544810108035312==--

