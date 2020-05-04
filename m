Content-Type: multipart/mixed; boundary="===============9207492356989248510=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: fix segfault due to roaming before connected
Date: Mon, 04 May 2020 13:15:53 -0700
Message-ID: <20200504201553.5246-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9207492356989248510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In this situation the kernel is sending a low RSSI event which netdev
picks up, but since we set netdev->connected so early the event is
forwarded to station before IWD has fully connected. Station then
tries to get a neighbor report, which may fail and cause a known
frequency scan. If this is a new network the frequency scan tries to
get any known frequencies in network_info which will be unset and
cause a segfault.

This can be avoided by ensuring that we are connected inside
station_cannot_roam() rather than checking that we aren't roaming.
This modification will ensure both connected and not roaming before
doing a roam.
---
 src/station.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index c532319a..5b0e7fd4 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2007,7 +2007,7 @@ static bool station_cannot_roam(struct station *stati=
on)
 		disabled =3D false;
 =

 	return disabled || station->preparing_roam ||
-					station->state =3D=3D STATION_STATE_ROAMING;
+				station->state !=3D STATION_STATE_CONNECTED;
 }
 =

 static void station_lost_beacon(struct station *station)
-- =

2.21.1

--===============9207492356989248510==--

