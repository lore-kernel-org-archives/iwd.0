Content-Type: multipart/mixed; boundary="===============3022307158812054372=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/19] nl80211util: Parse NL80211_ATTR_REG_ALPHA2 attrs
Date: Thu, 23 Apr 2020 18:24:34 +0200
Message-ID: <20200423162447.15750-6-andrew.zaborowski@intel.com>
In-Reply-To: <20200423162447.15750-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3022307158812054372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/nl80211util.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index bde58607..f226f155 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -63,6 +63,19 @@ static bool extract_name(const void *data, uint16_t len,=
 void *o)
 	return true;
 }
 =

+static bool extract_2_chars(const void *data, uint16_t len, void *o)
+{
+	char *out =3D o;
+	const char *in =3D data;
+
+	if (len !=3D 3 || in[2] !=3D 0)
+		return false;
+
+	out[0] =3D in[0];
+	out[1] =3D in[1];
+	return true;
+}
+
 static bool extract_mac(const void *data, uint16_t len, void *o)
 {
 	const uint8_t **out =3D o;
@@ -118,6 +131,8 @@ static attr_handler handler_for_type(enum nl80211_attrs=
 type)
 	case NL80211_ATTR_IFNAME:
 	case NL80211_ATTR_WIPHY_NAME:
 		return extract_name;
+	case NL80211_ATTR_REG_ALPHA2:
+		return extract_2_chars;
 	case NL80211_ATTR_MAC:
 		return extract_mac;
 	case NL80211_ATTR_ACK:
-- =

2.20.1

--===============3022307158812054372==--

