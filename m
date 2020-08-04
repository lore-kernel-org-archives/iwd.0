Content-Type: multipart/mixed; boundary="===============1182372567343163956=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/6] scan: Always allocate results->bss_list
Date: Tue, 04 Aug 2020 16:53:00 +0200
Message-ID: <20200804145303.151878-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200804145303.151878-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1182372567343163956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of creating the results->bss_list l_queue lazily, always create
one before sending the GET_SCAN command.  This is to make sure that an
empty list is passed to the scan callback (e.g. in station.c) instead of
a NULL.  Passing NULL has been causing difficult to debug crashes in
station.c, in fact I think I've been seeing them for over a year now
but can't be sure.  station_set_scan_results has been taking ownership
of the new BSS list and, if station->connected_bss was not on the list,
it would try to add it not realizing that l_queue_push_tail() was doing
nothing.  Always passing a valid list may help us prevent similar
problems in the future.

The crash might start with:
=3D=3D120489=3D=3D Invalid read of size 8
=3D=3D120489=3D=3D    at 0x425D38: network_bss_select (network.c:709)
=3D=3D120489=3D=3D    by 0x415BD1: station_try_next_bss (station.c:2263)
=3D=3D120489=3D=3D    by 0x415E31: station_retry_with_status (station.c:232=
3)
=3D=3D120489=3D=3D    by 0x415E31: station_connect_cb (station.c:2367)
=3D=3D120489=3D=3D    by 0x407E66: netdev_connect_failed (netdev.c:569)
=3D=3D120489=3D=3D    by 0x40B93D: netdev_connect_event (netdev.c:1801)
=3D=3D120489=3D=3D    by 0x40B93D: netdev_mlme_notify (netdev.c:3678)
---
 src/scan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index d131b1f4..c93beabd 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1448,9 +1448,6 @@ static void get_scan_callback(struct l_genl_msg *msg,=
 void *user_data)
 =

 	l_debug("get_scan_callback");
 =

-	if (!results->bss_list)
-		results->bss_list =3D l_queue_new();
-
 	bss =3D scan_parse_result(msg, &wdev_id);
 	if (!bss)
 		return;
@@ -1694,6 +1691,7 @@ static void scan_notify(struct l_genl_msg *msg, void =
*user_data)
 		results->sc =3D sc;
 		results->time_stamp =3D l_time_now();
 		results->sr =3D sr;
+		results->bss_list =3D l_queue_new();
 =

 		scan_parse_new_scan_results(msg, results);
 =

-- =

2.25.1

--===============1182372567343163956==--

