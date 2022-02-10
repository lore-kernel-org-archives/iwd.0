Content-Type: multipart/mixed; boundary="===============7666197312306362364=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] station: only log station_autoconnect_start if autoconnecting
Date: Thu, 10 Feb 2022 12:54:00 -0800
Message-ID: <20220210205400.865795-1-prestwoj@gmail.com>

--===============7666197312306362364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This debug print was before any checks which could bail out prior to
autoconnect starting. This was confusing because debug logs would
contain multiple "station_autoconnect_start()" prints making you think
autoconnect was started several times.
---
 src/station.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 8e2cabd0..6dc0074c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -248,8 +248,6 @@ static int station_autoconnect_next(struct station *sta=
tion)
 =

 static void station_autoconnect_start(struct station *station)
 {
-	l_debug("");
-
 	if (!station->autoconnect_can_start)
 		return;
 =

@@ -265,6 +263,8 @@ static void station_autoconnect_start(struct station *s=
tation)
 	if (L_WARN_ON(station->autoconnect_list))
 		l_queue_destroy(station->autoconnect_list, NULL);
 =

+	l_debug("");
+
 	station->autoconnect_list =3D l_queue_new();
 	station_network_foreach(station, network_add_foreach, station);
 	station_autoconnect_next(station);
-- =

2.34.1

--===============7666197312306362364==--

