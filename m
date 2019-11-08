Content-Type: multipart/mixed; boundary="===============1224829773120104538=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/4] scan: Improve comment
Date: Fri, 08 Nov 2019 17:03:59 -0500
Message-ID: <20191108220402.10282-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1224829773120104538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index f2332545..4bc95afe 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -297,8 +297,8 @@ static struct l_genl_msg *scan_build_cmd(struct scan_co=
ntext *sc,
 	ext_capa =3D wiphy_get_extended_capabilities(sc->wiphy,
 							NL80211_IFTYPE_STATION);
 	/*
-	 * XXX: If adding IE's here ensure that ordering is not broken for
-	 * probe requests (IEEE-2016 Table 9-33).
+	 * If adding IE's here ensure that ordering is not broken for
+	 * probe requests (IEEE Std 802.11-2016 Table 9-33).
 	 */
 	/* Order 9 - Extended Capabilities */
 	iov[iov_elems].iov_base =3D (void *) ext_capa;
-- =

2.21.0

--===============1224829773120104538==--

