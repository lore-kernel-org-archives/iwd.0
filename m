Content-Type: multipart/mixed; boundary="===============1104188887961296012=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: don't include ATTR_IE for SAE
Date: Thu, 07 May 2020 12:34:46 -0700
Message-ID: <20200507193446.8975-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1104188887961296012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The spec outlines what fields/elements can be included with different
auth types. For SAE only a few fields are allowed. IE's are not allowed
but were being included with CMD_AUTHENTICATE.
---
 src/netdev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index b3c3bf73..bce6ada3 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2143,7 +2143,15 @@ static struct l_genl_msg *netdev_build_cmd_authentic=
ate(struct netdev *netdev,
 	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->ssid);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_AUTH_TYPE, 4, &auth_type);
 =

-	l_genl_msg_append_attr(msg, NL80211_ATTR_IE, hs->supplicant_ie[1] + 2,
+	/*
+	 * IEEE 802.11-2016 Table 9-36 Presents of fields in Auth frames
+	 *
+	 * For the SAE auth type no IEs are listed to be included in the
+	 * authenticate frame. Only SAE related fields should be included.
+	 */
+	if (auth_type !=3D NL80211_AUTHTYPE_SAE)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_IE,
+					hs->supplicant_ie[1] + 2,
 					hs->supplicant_ie);
 =

 	return msg;
-- =

2.21.1

--===============1104188887961296012==--

