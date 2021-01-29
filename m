Content-Type: multipart/mixed; boundary="===============5468691507735203668=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] ap: fix off by one error
Date: Fri, 29 Jan 2021 12:59:50 -0800
Message-ID: <20210129205950.106936-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5468691507735203668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The RSN element was not being allocated properly which caused
an invalid read in some cases.
---
 src/ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index e695a67e..ce639907 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2212,7 +2212,7 @@ static bool ap_parse_new_station_ies(const void *data=
, uint16_t len,
 				goto parse_error;
 =

 			rsn =3D l_memdup(ie_tlv_iter_get_data(&iter) - 2,
-					ie_tlv_iter_get_length(&iter) + 1);
+					ie_tlv_iter_get_length(&iter) + 2);
 			break;
 		case IE_TYPE_EXTENDED_SUPPORTED_RATES:
 			if (ap_parse_supported_rates(&iter, &rates) < 0)
-- =

2.26.2

--===============5468691507735203668==--

