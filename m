Content-Type: multipart/mixed; boundary="===============3008666351749054086=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 2/2] station: transition to disconnecting on station_free
Date: Wed, 28 Apr 2021 12:27:01 -0700
Message-ID: <20210428192701.149044-2-prestwoj@gmail.com>
In-Reply-To: <20210428192701.149044-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3008666351749054086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows station to gracefully clean up things like the diagnostic
interface which is directly tied to stations CONNECTED/DISCONNECTING
states.
---
 src/station.c | 2 ++
 1 file changed, 2 insertions(+)

v4:
 * Changed to DISCONNECTING due to new patch.

diff --git a/src/station.c b/src/station.c
index 0cee3525..c81c9a45 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3487,6 +3487,8 @@ static void station_free(struct station *station)
 	if (station->connected_bss)
 		netdev_disconnect(station->netdev, NULL, NULL);
 =

+	station_enter_state(station, STATION_STATE_DISCONNECTING);
+
 	if (station->netconfig) {
 		netconfig_destroy(station->netconfig);
 		station->netconfig =3D NULL;
-- =

2.26.2

--===============3008666351749054086==--

