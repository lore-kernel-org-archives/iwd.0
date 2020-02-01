Content-Type: multipart/mixed; boundary="===============6919571183881164429=="
MIME-Version: 1.0
From: Robert Joslyn <robert.joslyn@redrectangle.org>
Subject: [PATCH] wiphy: Relpace rawmemchr with memchr
Date: Fri, 31 Jan 2020 23:53:29 -0800
Message-ID: <20200201075329.731645-1-robert.joslyn@redrectangle.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6919571183881164429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The rawmemchr function is a GNU extension, and not available in other
libc implementations, such as musl.
---
 src/wiphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 1da479db..141b3cb9 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -500,7 +500,7 @@ const uint8_t *wiphy_get_supported_rates(struct wiphy *=
wiphy, unsigned int band,
 =

 	if (out_num)
 		*out_num =3D
-			(uint8_t *) rawmemchr(wiphy->supported_rates[band], 0) -
+			(uint8_t *) memchr(wiphy->supported_rates[band], 0, (size_t)-1) -
 			wiphy->supported_rates[band];
 =

 	return wiphy->supported_rates[band];
-- =

2.24.1

--===============6919571183881164429==--

