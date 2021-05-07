Content-Type: multipart/mixed; boundary="===============6094990967043982208=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/7] ie: fix ie_parse_data_rates to handle NULL
Date: Fri, 07 May 2021 13:26:14 -0700
Message-ID: <20210507202620.93540-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6094990967043982208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The code was partially there to handle NULL IEs but not
quite. If NULL IEs are passed in base the data rate totally
on the basic rate RSSI table.
---
 src/ie.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/ie.c b/src/ie.c
index 0f430b98..0b471f1b 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -1688,14 +1688,16 @@ static int ie_parse_supported_rates(struct ie_tlv_i=
ter *supp_rates_iter,
 		max_rate =3D map->rate;
 	}
 =

-	/* Find highest rate in Supported Rates IE */
-	rates =3D ie_tlv_iter_get_data(supp_rates_iter);
+	if (supp_rates_iter) {
+		/* Find highest rate in Supported Rates IE */
+		rates =3D ie_tlv_iter_get_data(supp_rates_iter);
 =

-	for (i =3D 0; i < len; i++) {
-		uint8_t r =3D rates[i] & 0x7f;
+		for (i =3D 0; i < len; i++) {
+			uint8_t r =3D rates[i] & 0x7f;
 =

-		if (r <=3D max_rate && r > highest)
-			highest =3D r;
+			if (r <=3D max_rate && r > highest)
+				highest =3D r;
+		}
 	}
 =

 	/* Find highest rate in Extended Supported Rates IE */
@@ -1711,7 +1713,10 @@ static int ie_parse_supported_rates(struct ie_tlv_it=
er *supp_rates_iter,
 		}
 	}
 =

-	*data_rate =3D (highest / 2) * 1000000;
+	if (highest)
+		*data_rate =3D (highest / 2) * 1000000;
+	else
+		*data_rate =3D (max_rate / 2) * 1000000;
 =

 	return 0;
 }
-- =

2.31.1

--===============6094990967043982208==--

