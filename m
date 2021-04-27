Content-Type: multipart/mixed; boundary="===============7198797138252944838=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/3] station: transition to disconnected on station_free
Date: Tue, 27 Apr 2021 16:34:50 -0700
Message-ID: <20210427233452.97024-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7198797138252944838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows station to gracefully clean up things like the diagnostic
interface which is directly tied to stations CONNECTED/DISCONNECTED
states.
---
 src/station.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/station.c b/src/station.c
index 9c2b4e64..325175e9 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3486,6 +3486,8 @@ static void station_free(struct station *station)
 	if (station->connected_bss)
 		netdev_disconnect(station->netdev, NULL, NULL);
 =

+	station_enter_state(station, STATION_STATE_DISCONNECTED);
+
 	if (station->netconfig) {
 		netconfig_destroy(station->netconfig);
 		station->netconfig =3D NULL;
-- =

2.26.2

--===============7198797138252944838==--

