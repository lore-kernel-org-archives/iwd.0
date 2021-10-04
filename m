Content-Type: multipart/mixed; boundary="===============1035723188073698217=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 09/12] nl80211util: set multicast on new group keys
Date: Mon, 04 Oct 2021 09:48:59 -0700
Message-ID: <20211004164902.2274318-9-prestwoj@gmail.com>
In-Reply-To: 20211004164902.2274318-1-prestwoj@gmail.com

--===============1035723188073698217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This may not be required, but when working with extended key IDs
setting the key mode makes each NEW_KEY explicit whether or not
its the GTK or PTK key.
---
 src/nl80211util.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index d9d4819d..d663c6dc 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -247,6 +247,7 @@ struct l_genl_msg *nl80211_build_new_key_group(uint32_t=
 ifindex, uint32_t cipher
 					size_t ctr_len, const uint8_t *addr)
 {
 	struct l_genl_msg *msg;
+	uint32_t type =3D NL80211_KEYTYPE_GROUP;
 =

 	msg =3D l_genl_msg_new_sized(NL80211_CMD_NEW_KEY, 512);
 =

@@ -263,16 +264,11 @@ struct l_genl_msg *nl80211_build_new_key_group(uint32=
_t ifindex, uint32_t cipher
 	if (ctr)
 		l_genl_msg_append_attr(msg, NL80211_KEY_SEQ, ctr_len, ctr);
 =

-	if (addr) {
-		uint32_t type =3D NL80211_KEYTYPE_GROUP;
-
-		l_genl_msg_append_attr(msg, NL80211_KEY_TYPE, 4, &type);
-		l_genl_msg_enter_nested(msg, NL80211_KEY_DEFAULT_TYPES);
-		l_genl_msg_append_attr(msg, NL80211_KEY_DEFAULT_TYPE_MULTICAST,
+	l_genl_msg_append_attr(msg, NL80211_KEY_TYPE, 4, &type);
+	l_genl_msg_enter_nested(msg, NL80211_KEY_DEFAULT_TYPES);
+	l_genl_msg_append_attr(msg, NL80211_KEY_DEFAULT_TYPE_MULTICAST,
 					0, NULL);
-		l_genl_msg_leave_nested(msg);
-	}
-
+	l_genl_msg_leave_nested(msg);
 	l_genl_msg_leave_nested(msg);
 =

 	return msg;
-- =

2.31.1

--===============1035723188073698217==--

