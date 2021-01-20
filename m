Content-Type: multipart/mixed; boundary="===============2508302622255777972=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH] station: remove unused roam_no_orig_ap state variable
Date: Wed, 20 Jan 2021 16:06:59 +0000
Message-ID: <20210120160654.2998911-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2508302622255777972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since commit 836beb1276d1bc77889462ae514f0c5b708a38d7 removed beacon
loss handling, the roam_no_orig_ap variable has no use and is always set
to false. This commit removes it.
---
 src/station.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/station.c b/src/station.c
index 2b79aaa7..c65fc0cc 100644
--- a/src/station.c
+++ b/src/station.c
@@ -106,7 +106,6 @@ struct station {
 	bool preparing_roam : 1;
 	bool roam_scan_full : 1;
 	bool signal_low : 1;
-	bool roam_no_orig_ap : 1;
 	bool ap_directed_roaming : 1;
 	bool scanning : 1;
 	bool autoconnect : 1;
@@ -1369,7 +1368,6 @@ static void station_roamed(struct station *station)
 	 */
 	station->signal_low =3D false;
 	station->roam_min_time.tv_sec =3D 0;
-	station->roam_no_orig_ap =3D false;
 	station->roam_scan_full =3D false;
 =

 	if (station->netconfig)
@@ -1627,7 +1625,6 @@ static void station_transition_start(struct station *=
station,
 	 * the current association."
 	 */
 	if (security =3D=3D SECURITY_8021X &&
-			!station->roam_no_orig_ap &&
 			scan_bss_get_rsn_info(station->connected_bss,
 						&cur_rsne) >=3D 0 &&
 			scan_bss_get_rsn_info(bss, &target_rsne) >=3D 0 &&
@@ -2069,8 +2066,7 @@ static void station_roam_trigger_cb(struct l_timeout =
*timeout, void *user_data)
 			l_debug("Using cached neighbor report for roam");
 			return;
 		}
-	} else if (station->connected_bss->cap_rm_neighbor_report &&
-			!station->roam_no_orig_ap) {
+	} else if (station->connected_bss->cap_rm_neighbor_report) {
 		if (netdev_neighbor_report_req(station->netdev,
 					station_neighbor_report_cb) =3D=3D 0) {
 			l_debug("Requesting neighbor report for roam");
-- =

2.29.2
--===============2508302622255777972==--

