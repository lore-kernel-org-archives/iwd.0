Content-Type: multipart/mixed; boundary="===============0303886028114562274=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH 1/4] scan: add MaximumPeriodicScanInterval setting
Date: Fri, 12 Feb 2021 15:41:13 +0000
Message-ID: <20210212154102.25255-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0303886028114562274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/scan.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 3c28eb7d..a4469f0e 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -50,9 +50,12 @@
 #include "src/mpdu.h"
 #include "src/scan.h"
 =

-#define SCAN_MAX_INTERVAL 320
 #define SCAN_INIT_INTERVAL 10
 =

+/* User configurable options */
+static double RANK_5G_FACTOR;
+static uint32_t SCAN_MAX_INTERVAL;
+
 static struct l_queue *scan_contexts;
 =

 static struct l_genl_family *nl80211;
@@ -1313,9 +1316,6 @@ static struct scan_bss *scan_parse_result(struct l_ge=
nl_msg *msg,
 	return bss;
 }
 =

-/* User configurable options */
-static double RANK_5G_FACTOR;
-
 static void scan_bss_compute_rank(struct scan_bss *bss)
 {
 	static const double RANK_RSNE_FACTOR =3D 1.2;
@@ -2215,6 +2215,13 @@ static int scan_init(void)
 					&RANK_5G_FACTOR))
 		RANK_5G_FACTOR =3D 1.0;
 =

+	if (!l_settings_get_uint(config, "Scan", "MaximumPeriodicScanInterval",
+					&SCAN_MAX_INTERVAL))
+		SCAN_MAX_INTERVAL =3D 300;
+
+	if (SCAN_MAX_INTERVAL > UINT16_MAX)
+		SCAN_MAX_INTERVAL =3D UINT16_MAX;
+
 	return 0;
 }
 =

-- =

2.30.0
--===============0303886028114562274==--

