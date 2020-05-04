Content-Type: multipart/mixed; boundary="===============0320993531338463348=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] wiphy: remove useless debug prints
Date: Mon, 04 May 2020 08:24:19 -0700
Message-ID: <20200504152420.27210-3-prestwoj@gmail.com>
In-Reply-To: <20200504152420.27210-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0320993531338463348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Several parsing functions printed the function name, which isn't
very useful to anyone.
---
 src/wiphy.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 139474d2..9821da0e 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -715,8 +715,6 @@ static void parse_supported_frequencies(struct wiphy *w=
iphy,
 	const void *data;
 	struct l_genl_attr attr;
 =

-	l_debug("");
-
 	while (l_genl_attr_next(freqs, NULL, NULL, NULL)) {
 		if (!l_genl_attr_recurse(freqs, &attr))
 			continue;
@@ -786,8 +784,6 @@ static void parse_supported_bands(struct wiphy *wiphy,
 	uint16_t type;
 	struct l_genl_attr attr;
 =

-	l_debug("");
-
 	while (l_genl_attr_next(bands, &type, NULL, NULL)) {
 		enum nl80211_band band =3D type;
 =

@@ -1081,8 +1077,6 @@ void wiphy_update_from_genl(struct wiphy *wiphy, stru=
ct l_genl_msg *msg)
 	if (wiphy->blacklisted)
 		return;
 =

-	l_debug("");
-
 	wiphy_parse_attributes(wiphy, msg);
 }
 =

-- =

2.21.1

--===============0320993531338463348==--

