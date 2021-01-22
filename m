Content-Type: multipart/mixed; boundary="===============1938462280527652310=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH 1/3] station: retry roaming unless notified of a high RSSI
Date: Fri, 22 Jan 2021 13:37:00 +0000
Message-ID: <20210122133659.577139-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1938462280527652310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Following a successful roaming sequence, schedule another attempt unless
the driver has sent a high RSSI notification. This makes the behaviour
analogous to a failed roaming attempt where we remained connected to the
same BSS.

This makes iwd compatible with wireless drivers which do not necessarily
send out a duplicate low RSSI notification upon reassociation. Without
this change, iwd risks getting indefinitely stuck to a BSS with low
signal strength, even though a better BSS might later become available.

In the case of a high RSSI notification, the minimum roam time will also
be reset to zero. This preserves the original behaviour in the case
where a high RSSI notification is processed after station_roamed().
Doing so also gives a chance for faster roaming action in the following
example scenario:

    1. RSSI LOW
    2. schedule roam in 5 seconds
        (5 seconds pass)
    3. try roaming
    4. roaming fails, same BSS
    5. schedule roam in 60 seconds
        (20 seconds pass)
    6. RSSI HIGH
    7. cancel scheduled roam
        (20 seconds pass)
    8. RSSI LOW
    9. schedule roam in 5 seconds or 20 seconds?

By resetting the minimum roam time, we can avoid waiting 20 seconds when
the station may have moved considerably. And since the high/low RSSI
notifications are configured with a hysteresis, we should still be
protected against too frequent spurious roaming attempts.
---
 src/station.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/station.c b/src/station.c
index c65fc0cc..2e886a73 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1362,13 +1362,14 @@ static int station_roam_scan(struct station *statio=
n,
 =

 static void station_roamed(struct station *station)
 {
+	station->roam_scan_full =3D false;
+
 	/*
-	 * New signal high/low notification should occur on the next
-	 * beacon from new AP.
+	 * Schedule another roaming attempt in case the signal continues to
+	 * remain low. A subsequent high signal notification will cancel it.
 	 */
-	station->signal_low =3D false;
-	station->roam_min_time.tv_sec =3D 0;
-	station->roam_scan_full =3D false;
+	if (station->signal_low)
+		station_roam_timeout_rearm(station, 60);
 =

 	if (station->netconfig)
 		netconfig_reconfigure(station->netconfig);
@@ -2227,6 +2228,7 @@ static void station_ok_rssi(struct station *station)
 	station->roam_trigger_timeout =3D NULL;
 =

 	station->signal_low =3D false;
+	station->roam_min_time.tv_sec =3D 0;
 }
 =

 static void station_rssi_level_changed(struct station *station,
-- =

2.29.2
--===============1938462280527652310==--

