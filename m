Content-Type: multipart/mixed; boundary="===============3997563531063295766=="
MIME-Version: 1.0
From: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>
Subject: [PATCH 3/3] adhoc: segfault when exiting iwd after adhoc stop
Date: Tue, 07 Apr 2020 23:33:47 +0200
Message-ID: <20200407213347.32130-3-Diego.SantaCruz@spinetix.com>
In-Reply-To: <20200407213347.32130-1-Diego.SantaCruz@spinetix.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3997563531063295766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

adhoc_reset() destroys ssid and sta_states but leaves the pointers
around, athough the adhoc_state structure is not always freed.

This causes a segfault when exiting iwd after a client has done
adhoc start and adhoc stop on a device since adhoc_reset() is called
from adhoc_sta_free although it was previously called from
adhoc_leave_cb().
---
 src/adhoc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/adhoc.c b/src/adhoc.c
index 328433ca..8c61f81e 100644
--- a/src/adhoc.c
+++ b/src/adhoc.c
@@ -131,10 +131,12 @@ static void adhoc_reset(struct adhoc_state *adhoc)
 				dbus_error_aborted(adhoc->pending));
 =

 	l_free(adhoc->ssid);
+	adhoc->ssid =3D NULL;
 =

 	netdev_station_watch_remove(adhoc->netdev, adhoc->sta_watch_id);
 =

 	l_queue_destroy(adhoc->sta_states, adhoc_sta_free);
+	adhoc->sta_states =3D NULL;
 =

 	adhoc->started =3D false;
 =

-- =

2.18.1

--===============3997563531063295766==--

