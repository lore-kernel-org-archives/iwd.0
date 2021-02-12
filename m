Content-Type: multipart/mixed; boundary="===============9059794862422639606=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH 3/4] scan: add InitialPeriodicScanInterval setting
Date: Fri, 12 Feb 2021 15:41:14 +0000
Message-ID: <20210212154102.25255-3-alsi@bang-olufsen.dk>
In-Reply-To: <20210212154102.25255-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9059794862422639606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/scan.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index a4469f0e..82e6a2ae 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -50,11 +50,10 @@
 #include "src/mpdu.h"
 #include "src/scan.h"
 =

-#define SCAN_INIT_INTERVAL 10
-
 /* User configurable options */
 static double RANK_5G_FACTOR;
 static uint32_t SCAN_MAX_INTERVAL;
+static uint32_t SCAN_INIT_INTERVAL;
 =

 static struct l_queue *scan_contexts;
 =

@@ -2215,6 +2214,13 @@ static int scan_init(void)
 					&RANK_5G_FACTOR))
 		RANK_5G_FACTOR =3D 1.0;
 =

+	if (!l_settings_get_uint(config, "Scan", "InitialPeriodicScanInterval",
+					&SCAN_INIT_INTERVAL))
+		SCAN_INIT_INTERVAL =3D 10;
+
+	if (SCAN_INIT_INTERVAL > UINT16_MAX)
+		SCAN_INIT_INTERVAL =3D UINT16_MAX;
+
 	if (!l_settings_get_uint(config, "Scan", "MaximumPeriodicScanInterval",
 					&SCAN_MAX_INTERVAL))
 		SCAN_MAX_INTERVAL =3D 300;
-- =

2.30.0
--===============9059794862422639606==--

