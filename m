Content-Type: multipart/mixed; boundary="===============3945499915418501366=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5] nl80211util: Handle NL80211_ATTR_ACK flag in parser
Date: Fri, 07 Feb 2020 12:39:10 +0100
Message-ID: <20200207113914.3869-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3945499915418501366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If this attribute is included in the nl80211_parse_attrs parameters, set
the corresponding bool to true if flag was present and false if not.
---
 src/nl80211util.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index c4942809..fa9abc1e 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -96,6 +96,14 @@ static bool extract_uint32(const void *data, uint16_t le=
n, void *o)
 	return true;
 }
 =

+static bool extract_flag(const void *data, uint16_t len, void *o)
+{
+	if (len !=3D 0)
+		return false;
+
+	return true;
+}
+
 static attr_handler handler_for_type(enum nl80211_attrs type)
 {
 	switch (type) {
@@ -112,6 +120,8 @@ static attr_handler handler_for_type(enum nl80211_attrs=
 type)
 		return extract_name;
 	case NL80211_ATTR_MAC:
 		return extract_mac;
+	case NL80211_ATTR_ACK:
+		return extract_flag;
 	default:
 		break;
 	}
@@ -124,6 +134,7 @@ struct attr_entry {
 	void *data;
 	attr_handler handler;
 	bool present : 1;
+	bool flag : 1;
 };
 =

 int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...)
@@ -190,6 +201,11 @@ int nl80211_parse_attrs(struct l_genl_msg *msg, int ta=
g, ...)
 	for (e =3D l_queue_get_entries(entries); e; e =3D e->next) {
 		entry =3D e->data;
 =

+		if (entry->handler =3D=3D extract_flag) {
+			*(bool *) entry->data =3D entry->present;
+			continue;
+		}
+
 		if (entry->present)
 			continue;
 =

-- =

2.20.1

--===============3945499915418501366==--

