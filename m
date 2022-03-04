Content-Type: multipart/mixed; boundary="===============8110945228469052585=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] station: replace old BSS with 'best_bss' on roam scan
Date: Fri, 04 Mar 2022 13:24:19 -0800
Message-ID: <20220304212419.3534676-1-prestwoj@gmail.com>

--===============8110945228469052585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The logic here assumed any BSS's in the roam scan were identical to ones
in station's bss_list with the same address. Usually this is true but,
for example, if the BSS changed frequency the one in station's list is
invalid.

Intead when a match is found remove the old BSS and re-insert the new one.
---
 src/station.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 92b2667b..f6f0adac 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2368,8 +2368,12 @@ next:
 =

 	bss =3D network_bss_find_by_addr(network, best_bss->addr);
 	if (bss) {
-		scan_bss_free(best_bss);
-		best_bss =3D bss;
+		network_bss_update(network, best_bss);
+		l_queue_remove(station->bss_list, bss);
+		scan_bss_free(bss);
+
+		l_queue_insert(station->bss_list, best_bss,
+				scan_bss_rank_compare, NULL);
 	} else {
 		network_bss_add(network, best_bss);
 		l_queue_push_tail(station->bss_list, best_bss);
-- =

2.34.1

--===============8110945228469052585==--

