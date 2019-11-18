Content-Type: multipart/mixed; boundary="===============4598960597310626037=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] rrm: remove use of floating point math
Date: Mon, 18 Nov 2019 10:35:54 -0800
Message-ID: <20191118183554.25648-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4598960597310626037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The RCPI value was using floating point values as per the spec. But instead
we can just use the signal strength coming from the kernel in mili mdm and
scale the hard coded values by a factor of 100.
---
 src/rrm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/rrm.c b/src/rrm.c
index 4c736910..2b0a22fb 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -25,7 +25,6 @@
 #endif
 =

 #include <stdint.h>
-#include <math.h>
 #include <linux/if_ether.h>
 =

 #include <ell/ell.h>
@@ -247,7 +246,6 @@ static size_t build_report_for_bss(struct rrm_beacon_re=
q_info *beacon,
 					uint8_t *to)
 {
 	uint8_t *start =3D to;
-	double dbms =3D bss->signal_strength / 100;
 =

 	*to++ =3D beacon->oper_class;
 	*to++ =3D scan_freq_to_channel(bss->frequency, NULL);
@@ -259,10 +257,10 @@ static size_t build_report_for_bss(struct rrm_beacon_=
req_info *beacon,
 	*to++ =3D rrm_phy_type(bss);
 =

 	/* 802.11 Table 9-154 - RCPI values */
-	if (dbms < -109.5)
+	if (bss->signal_strength < -10950)
 		*to++ =3D 0;
-	else if (dbms >=3D -109.5 && dbms < 0)
-		*to++ =3D (uint8_t)floor(2 * (dbms + 110));
+	else if (bss->signal_strength >=3D -10950 && bss->signal_strength < 0)
+		*to++ =3D (uint8_t)((2 * (bss->signal_strength + 11000)) / 100);
 	else
 		*to++ =3D 220;
 =

-- =

2.17.1

--===============4598960597310626037==--

