Content-Type: multipart/mixed; boundary="===============2449610788543682744=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 3/7] scan: don't print notification if sc is not found
Date: Wed, 12 Jan 2022 10:08:41 -0800
Message-ID: <20220112180845.1240661-3-prestwoj@gmail.com>
In-Reply-To: 20220112180845.1240661-1-prestwoj@gmail.com

--===============2449610788543682744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If this scan is not for any IWD wdev's don't print
---
 src/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 0767fa22..156d427f 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1811,8 +1811,6 @@ static void scan_notify(struct l_genl_msg *msg, void =
*user_data)
 =

 	cmd =3D l_genl_msg_get_command(msg);
 =

-	l_debug("Scan notification %s(%u)", nl80211cmd_to_string(cmd), cmd);
-
 	if (nl80211_parse_attrs(msg, NL80211_ATTR_WDEV, &wdev_id,
 					NL80211_ATTR_WIPHY, &wiphy_id,
 					NL80211_ATTR_UNSPEC) < 0)
@@ -1822,6 +1820,8 @@ static void scan_notify(struct l_genl_msg *msg, void =
*user_data)
 	if (!sc)
 		return;
 =

+	l_debug("Scan notification %s(%u)", nl80211cmd_to_string(cmd), cmd);
+
 	if (!l_genl_attr_init(&attr, msg))
 		return;
 =

-- =

2.31.1

--===============2449610788543682744==--

