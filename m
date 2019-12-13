Content-Type: multipart/mixed; boundary="===============8952749571808990973=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] rrm: fix bad sign for calculating RCPI
Date: Thu, 12 Dec 2019 16:04:07 -0800
Message-ID: <20191213000407.22427-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8952749571808990973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The first if case should be -10950, not 10950. Without the negative
this first case would get hit every time since signal strength values
are always negative.
---
 src/rrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rrm.c b/src/rrm.c
index a8b265d6..a117dce3 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -243,7 +243,7 @@ static void rrm_build_measurement_report(struct rrm_req=
uest_info *info,
 /* 802.11 Table 9-154 */
 static uint8_t mdb_to_rcpi(int32_t mdb)
 {
-	if (mdb <=3D 10950)
+	if (mdb <=3D -10950)
 		return 0;
 	else if (mdb >=3D -10950 && mdb < 0)
 		return (2 * (mdb + 11000)) / 100;
-- =

2.17.1

--===============8952749571808990973==--

