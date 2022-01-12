Content-Type: multipart/mixed; boundary="===============7012225936476739019=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/7] nl80211util: support ATTR_FRAME in parse_attrs()
Date: Wed, 12 Jan 2022 10:08:39 -0800
Message-ID: <20220112180845.1240661-1-prestwoj@gmail.com>

--===============7012225936476739019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/nl80211util.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index d663c6dc..9cd538ec 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -118,6 +118,16 @@ static bool extract_flag(const void *data, uint16_t le=
n, void *o)
 	return true;
 }
 =

+static bool extract_iovec(const void *data, uint16_t len, void *o)
+{
+	struct iovec *iov =3D o;
+
+	iov->iov_base =3D (void *) data;
+	iov->iov_len =3D len;
+
+	return true;
+}
+
 static attr_handler handler_for_type(enum nl80211_attrs type)
 {
 	switch (type) {
@@ -145,6 +155,8 @@ static attr_handler handler_for_type(enum nl80211_attrs=
 type)
 	case NL80211_ATTR_CENTER_FREQ1:
 	case NL80211_ATTR_CENTER_FREQ2:
 		return extract_uint32;
+	case NL80211_ATTR_FRAME:
+		return extract_iovec;
 	default:
 		break;
 	}
-- =

2.31.1

--===============7012225936476739019==--

