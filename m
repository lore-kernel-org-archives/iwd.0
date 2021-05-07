Content-Type: multipart/mixed; boundary="===============2620060970766452970=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/7] scan: rework BSS ranking
Date: Fri, 07 May 2021 13:26:15 -0700
Message-ID: <20210507202620.93540-2-prestwoj@gmail.com>
In-Reply-To: <20210507202620.93540-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2620060970766452970==
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
into account with the data rate calculation. This also removes
the check for rate IEs. If no IEs are found the parser will
base the data rate soley on RSSI.

There were a few other factors removed which will be added back
when ranking *networks* rather than BSS's. WPA version (or open)
was removed as well as the privacy capability. These values really
should not differ between BSS's in the same SSID and as such
should be used for network ranking instead.
---
 src/scan.c | 63 ++++++++++++++----------------------------------------
 1 file changed, 16 insertions(+), 47 deletions(-)

v2:
 * Added support for BSS's that did not have any rate IEs by
   using the same ie_parse_data_rates

diff --git a/src/scan.c b/src/scan.c
index a37e1714..a6c7473e 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1326,39 +1326,31 @@ static struct scan_bss *scan_parse_result(struct l_=
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
-	static const double RANK_MIN_SUPPORTED_RATE_FACTOR =3D 0.6;
-	static const double RANK_MAX_SUPPORTED_RATE_FACTOR =3D 1.3;
-	double rank;
+	float rank;
 	uint32_t irank;
-
+	uint64_t data_rate;
 	/*
-	 * Signal strength is in mBm (100 * dBm) and is negative.
-	 * WiFi range is -0 to -100 dBm
+	 * Maximum rate is 2340Mbps (VHT)
 	 */
-
-	/* Heavily slanted towards signal strength */
-	rank =3D 10000 + bss->signal_strength;
+	uint64_t max_rate =3D 2340000000U;
 =

 	/*
-	 * Prefer RSNE first, WPA second.  Open networks are much less
-	 * desirable.
+	 * If parsing fails choose a very low data rate as its unknown what
+	 * this AP supports or why its IEs did not parse. Likely not an AP
+	 * we should prefer to connect to.
 	 */
-	if (bss->rsne)
-		rank *=3D RANK_RSNE_FACTOR;
-	else if (bss->wpa)
-		rank *=3D RANK_WPA_FACTOR;
-	else
-		rank *=3D RANK_OPEN_FACTOR;
+	if (ie_parse_data_rates(bss->has_sup_rates ?
+				bss->supp_rates_ie : NULL,
+				bss->ext_supp_rates_ie,
+				bss->ht_capable ? bss->ht_ie : NULL,
+				bss->vht_capable ? bss->vht_ie : NULL,
+				bss->signal_strength / 100,
+				&data_rate) !=3D 0)
+		data_rate =3D 2000000;
 =

-	/* We prefer networks with CAP PRIVACY */
-	if (!(bss->capability & IE_BSS_CAP_PRIVACY))
-		rank *=3D RANK_NO_PRIVACY_FACTOR;
+	rank =3D (float)data_rate / (float)max_rate * USHRT_MAX;
 =

 	/* Prefer 5G networks over 2.4G */
 	if (bss->frequency > 4000)
@@ -1370,29 +1362,6 @@ static void scan_bss_compute_rank(struct scan_bss *b=
ss)
 	else if (bss->utilization <=3D 63)
 		rank *=3D RANK_LOW_UTILIZATION_FACTOR;
 =

-	if (bss->has_sup_rates || bss->ext_supp_rates_ie) {
-		uint64_t data_rate;
-
-		if (ie_parse_data_rates(bss->has_sup_rates ?
-					bss->supp_rates_ie : NULL,
-					bss->ext_supp_rates_ie,
-					bss->ht_capable ? bss->ht_ie : NULL,
-					bss->vht_capable ? bss->vht_ie : NULL,
-					bss->signal_strength / 100,
-					&data_rate) =3D=3D 0) {
-			double factor =3D RANK_MAX_SUPPORTED_RATE_FACTOR -
-					RANK_MIN_SUPPORTED_RATE_FACTOR;
-
-			/*
-			 * Maximum rate is 2340Mbps (VHT)
-			 */
-			factor =3D factor * data_rate / 2340000000U +
-						RANK_MIN_SUPPORTED_RATE_FACTOR;
-			rank *=3D factor;
-		} else
-			rank *=3D RANK_MIN_SUPPORTED_RATE_FACTOR;
-	}
-
 	irank =3D rank;
 =

 	if (irank > USHRT_MAX)
-- =

2.31.1

--===============2620060970766452970==--

