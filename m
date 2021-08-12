Content-Type: multipart/mixed; boundary="===============6447575528315301502=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: set autoconnect via setter
Date: Thu, 12 Aug 2021 15:24:58 -0700
Message-ID: <20210812222458.744008-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6447575528315301502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This updates the autoconnect property for the debug interface
---
 src/station.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index b2e12e9a..a1885cfa 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2695,7 +2695,8 @@ void station_connect_network(struct station *station,=
 struct network *network,
 	station_enter_state(station, STATION_STATE_CONNECTING);
 =

 	station->connect_pending =3D l_dbus_message_ref(message);
-	station->autoconnect =3D true;
+
+	station_set_autoconnect(station, true);
 =

 	return;
 =

-- =

2.31.1

--===============6447575528315301502==--

