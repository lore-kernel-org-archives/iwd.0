Content-Type: multipart/mixed; boundary="===============0501289012618554950=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/17] ap: Fix iteration over ap->rates
Date: Wed, 09 Sep 2020 01:49:17 +0200
Message-ID: <20200908234933.301439-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0501289012618554950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the for loops use a condition that works even if the uint32_t values
overflow since l_uintset_find_min/max() return UINT_MAX for empty sets.
If the condition is r <=3D l_uintset_find_max() or similar, it's always
true.

Make sure ap->rates is non-NULL both with and without no_cck_rates.

Update "count" in the for loop in ap_build_beacon_pr_head()
---
 src/ap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 1cee185c..84d4539a 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -371,7 +371,7 @@ static size_t ap_build_beacon_pr_head(struct ap_state *=
ap,
 	minr =3D l_uintset_find_min(ap->rates);
 	maxr =3D l_uintset_find_max(ap->rates);
 	count =3D 0;
-	for (r =3D minr; r <=3D maxr && count < 8; r++)
+	for (r =3D minr; (int32_t) (maxr - r) >=3D 0 && count < 8; r++)
 		if (l_uintset_contains(ap->rates, r)) {
 			uint8_t flag =3D 0;
 =

@@ -380,10 +380,10 @@ static size_t ap_build_beacon_pr_head(struct ap_state=
 *ap,
 				flag =3D 0x80;
 =

 			*rates++ =3D r | flag;
+			count++;
 		}
 =

-	ie_tlv_builder_set_length(&builder, rates -
-					ie_tlv_builder_get_data(&builder));
+	ie_tlv_builder_set_length(&builder, count);
 =

 	/* DSSS Parameter Set IE for DSSS, HR, ERP and HT PHY rates */
 	ie_tlv_builder_next(&builder, IE_TYPE_DSSS_PARAMETER_SET);
@@ -983,7 +983,7 @@ static void ap_associate_sta(struct ap_state *ap, struc=
t sta_state *sta)
 	minr =3D l_uintset_find_min(sta->rates);
 	maxr =3D l_uintset_find_max(sta->rates);
 =

-	for (r =3D minr; r <=3D maxr; r++)
+	for (r =3D minr; (int32_t) (maxr - r) >=3D 0; r++)
 		if (l_uintset_contains(sta->rates, r))
 			rates[count++] =3D r;
 =

@@ -1089,7 +1089,7 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, st=
ruct sta_state *sta,
 	minr =3D l_uintset_find_min(ap->rates);
 	maxr =3D l_uintset_find_max(ap->rates);
 	count =3D 0;
-	for (r =3D minr; r <=3D maxr && count < 8; r++)
+	for (r =3D minr; (int32_t) (maxr - r) >=3D 0 && count < 8; r++)
 		if (l_uintset_contains(ap->rates, r)) {
 			uint8_t flag =3D 0;
 =

@@ -2071,6 +2071,7 @@ struct ap_state *ap_start(struct netdev *netdev, stru=
ct ap_config *config,
 	ap->ciphers =3D wiphy_select_cipher(wiphy, 0xffff);
 	ap->group_cipher =3D wiphy_select_cipher(wiphy, 0xffff);
 	ap->beacon_interval =3D 100;
+	ap->rates =3D l_uintset_new(200);
 =

 	/* TODO: Pick from actual supported rates */
 	if (config->no_cck_rates) {
@@ -2083,7 +2084,6 @@ struct ap_state *ap_start(struct netdev *netdev, stru=
ct ap_config *config,
 		l_uintset_put(ap->rates, 96); /* 48 Mbps*/
 		l_uintset_put(ap->rates, 108); /* 54 Mbps*/
 	} else {
-		ap->rates =3D l_uintset_new(200);
 		l_uintset_put(ap->rates, 2); /* 1 Mbps*/
 		l_uintset_put(ap->rates, 11); /* 5.5 Mbps*/
 		l_uintset_put(ap->rates, 22); /* 11 Mbps*/
-- =

2.25.1

--===============0501289012618554950==--

