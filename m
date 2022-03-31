Content-Type: multipart/mixed; boundary="===============6869379363943760541=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 14/14] rrm: use ULL for static values
Date: Thu, 31 Mar 2022 16:16:41 -0700
Message-ID: <20220331231641.484200-14-prestwoj@gmail.com>
In-Reply-To: 20220331231641.484200-1-prestwoj@gmail.com

--===============6869379363943760541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/rrm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/rrm.c b/src/rrm.c
index d1c7029d..d32ffbff 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -46,9 +46,9 @@
 #include "linux/nl80211.h"
 =

 /* Limit requests per second */
-#define MAX_REQUESTS_PER_SEC		2
+#define MAX_REQUESTS_PER_SEC		2ULL
 /* Microseconds between requests */
-#define MIN_MICROS_BETWEEN_REQUESTS	(1000000 / MAX_REQUESTS_PER_SEC)
+#define MIN_MICROS_BETWEEN_REQUESTS	(1000000ULL / MAX_REQUESTS_PER_SEC)
 =

 /* 802.11-2016 Table 9-90 */
 #define REPORT_DETAIL_NO_FIELDS_OR_ELEMS		0
-- =

2.34.1

--===============6869379363943760541==--

