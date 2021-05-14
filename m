Content-Type: multipart/mixed; boundary="===============3685803364204226675=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] ie: fix static analysis warning
Date: Fri, 14 May 2021 08:36:38 -0700
Message-ID: <20210514153638.427088-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3685803364204226675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The supp_rates_iter was being used prior to the NULL check. This
was fixed as well as some reordering to make the function consistent
between supp_rates_iter and ext_supp_rates_iter.
---
 src/ie.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/ie.c b/src/ie.c
index 0b471f1b..352ce469 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -1673,11 +1673,6 @@ static int ie_parse_supported_rates(struct ie_tlv_it=
er *supp_rates_iter,
 	unsigned int len;
 	unsigned int i;
 =

-	len =3D ie_tlv_iter_get_length(supp_rates_iter);
-
-	if (len =3D=3D 0)
-		return -EINVAL;
-
 	/* Find highest rates possible with our RSSI */
 	for (i =3D 0; i < L_ARRAY_SIZE(rate_rssi_map); i++) {
 		const struct basic_rate_map *map =3D &rate_rssi_map[i];
@@ -1688,8 +1683,9 @@ static int ie_parse_supported_rates(struct ie_tlv_ite=
r *supp_rates_iter,
 		max_rate =3D map->rate;
 	}
 =

+	/* Find highest rate in Supported Rates IE */
 	if (supp_rates_iter) {
-		/* Find highest rate in Supported Rates IE */
+		len =3D ie_tlv_iter_get_length(supp_rates_iter);
 		rates =3D ie_tlv_iter_get_data(supp_rates_iter);
 =

 		for (i =3D 0; i < len; i++) {
-- =

2.31.1

--===============3685803364204226675==--

