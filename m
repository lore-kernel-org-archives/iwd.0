Content-Type: multipart/mixed; boundary="===============1409902817510408959=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] station: Fix .Scanning being reset early
Date: Wed, 14 Oct 2020 14:35:19 +0200
Message-ID: <20201014123520.1245755-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1409902817510408959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

periodic_scan_stop is called whenever we exit the autoscan state but a
periodic scan may not be running at the time.  If we have a
user-triggered scan running, or the autoconnect_quick scan, and we reset
Scanning to false before that scan finished, a client could en up
calling GetOrderedNetwork too early and not receiving the scan results.
---
 src/station.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/station.c b/src/station.c
index ad2c83a6..eb254bf6 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1031,9 +1031,8 @@ static void periodic_scan_stop(struct station *statio=
n)
 {
 	uint64_t id =3D netdev_get_wdev_id(station->netdev);
 =

-	scan_periodic_stop(id);
-
-	station_property_set_scanning(station, false);
+	if (scan_periodic_stop(id))
+		station_property_set_scanning(station, false);
 }
 =

 static bool station_needs_hidden_network_scan(struct station *station)
-- =

2.25.1

--===============1409902817510408959==--

