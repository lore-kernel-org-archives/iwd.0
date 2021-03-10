Content-Type: multipart/mixed; boundary="===============8308058446718031129=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/6] nl80211util: add WIPHY_FREQ to parse_attrs support
Date: Wed, 10 Mar 2021 12:27:43 -0800
Message-ID: <20210310202746.28475-3-prestwoj@gmail.com>
In-Reply-To: <20210310202746.28475-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8308058446718031129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/nl80211util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index f226f155..7a752a66 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -137,6 +137,8 @@ static attr_handler handler_for_type(enum nl80211_attrs=
 type)
 		return extract_mac;
 	case NL80211_ATTR_ACK:
 		return extract_flag;
+	case NL80211_ATTR_WIPHY_FREQ:
+		return extract_uint32;
 	default:
 		break;
 	}
-- =

2.26.2

--===============8308058446718031129==--

