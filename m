Content-Type: multipart/mixed; boundary="===============5979773136578652712=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] scan: rework BSS ranking
Date: Fri, 07 May 2021 11:24:18 -0700
Message-ID: <20210507182423.81194-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5979773136578652712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It was observed that IWD's ranking for BSS's did not always
end up with the fastest being chosen. This was due to IWD's
heavy weight on signal strength. This is a decent way of ranking
but even better is calculating a theoretical data rate which
was also done and factored in. The problem is the data rate
factor was always outdone by the signal strength.

Intead remove signal strength entirely as this is already taken
into account with the data rate calculation.

There were a few other factors removed which will be added back
when ranking *networks* rather than BSS's. WPA version (or open)
was removed as well as the privacy capability. These values really
should not differ between BSS's in the same SSID and as such
should be used for network ranking instead.
---
 src/scan.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index a37e1714..afcd6c1d 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1326,40 +1326,13 @@ static struct scan_bss *scan_parse_result(struct l_=
genl_msg *msg,
 =

 static void scan_bss_compute_rank(struct scan_bss *bss)
 {
-	static const double RANK_RSNE_FACTOR =3D 1.2;
-	static const double RANK_WPA_FACTOR =3D 1.0;
-	static const double RANK_OPEN_FACTOR =3D 0.5;
-	static const double RANK_NO_PRIVACY_FACTOR =3D 0.5;
 	static const double RANK_HIGH_UTILIZATION_FACTOR =3D 0.8;
 	static const double RANK_LOW_UTILIZATION_FACTOR =3D 1.2;
 	static const double RANK_MIN_SUPPORTED_RATE_FACTOR =3D 0.6;
 	static const double RANK_MAX_SUPPORTED_RATE_FACTOR =3D 1.3;
-	double rank;
+	double rank =3D 10000;
 	uint32_t irank;
 =

-	/*
-	 * Signal strength is in mBm (100 * dBm) and is negative.
-	 * WiFi range is -0 to -100 dBm
-	 */
-
-	/* Heavily slanted towards signal strength */
-	rank =3D 10000 + bss->signal_strength;
-
-	/*
-	 * Prefer RSNE first, WPA second.  Open networks are much less
-	 * desirable.
-	 */
-	if (bss->rsne)
-		rank *=3D RANK_RSNE_FACTOR;
-	else if (bss->wpa)
-		rank *=3D RANK_WPA_FACTOR;
-	else
-		rank *=3D RANK_OPEN_FACTOR;
-
-	/* We prefer networks with CAP PRIVACY */
-	if (!(bss->capability & IE_BSS_CAP_PRIVACY))
-		rank *=3D RANK_NO_PRIVACY_FACTOR;
-
 	/* Prefer 5G networks over 2.4G */
 	if (bss->frequency > 4000)
 		rank *=3D RANK_5G_FACTOR;
@@ -1373,6 +1346,10 @@ static void scan_bss_compute_rank(struct scan_bss *b=
ss)
 	if (bss->has_sup_rates || bss->ext_supp_rates_ie) {
 		uint64_t data_rate;
 =

+		/*
+		 * Signal strength is in mBm (100 * dBm) and is negative.
+		 * WiFi range is -0 to -100 dBm
+		 */
 		if (ie_parse_data_rates(bss->has_sup_rates ?
 					bss->supp_rates_ie : NULL,
 					bss->ext_supp_rates_ie,
-- =

2.31.1

--===============5979773136578652712==--

