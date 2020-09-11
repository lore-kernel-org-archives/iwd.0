Content-Type: multipart/mixed; boundary="===============1599712259551298452=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/8] ap: Fix NULL ap->rares
Date: Fri, 11 Sep 2020 21:50:56 +0200
Message-ID: <20200911195103.385070-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1599712259551298452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure ap->rates is non-NULL both with and without no_cck_rates.
---
 src/ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index c972cfcb..ae33b461 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2074,6 +2074,7 @@ struct ap_state *ap_start(struct netdev *netdev, stru=
ct ap_config *config,
 	ap->ciphers =3D wiphy_select_cipher(wiphy, 0xffff);
 	ap->group_cipher =3D wiphy_select_cipher(wiphy, 0xffff);
 	ap->beacon_interval =3D 100;
+	ap->rates =3D l_uintset_new(200);
 =

 	/* TODO: Pick from actual supported rates */
 	if (config->no_cck_rates) {
@@ -2086,7 +2087,6 @@ struct ap_state *ap_start(struct netdev *netdev, stru=
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

--===============1599712259551298452==--

