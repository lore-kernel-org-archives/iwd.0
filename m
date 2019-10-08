Content-Type: multipart/mixed; boundary="===============1616251463729823156=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 5/5] station: Match debug output to what is seen on dbus
Date: Tue, 08 Oct 2019 14:48:24 -0700
Message-ID: <20191008214824.19466-5-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191008214824.19466-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1616251463729823156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/station.c b/src/station.c
index 46f2a02e..dc9ec7a1 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1131,16 +1131,16 @@ static void station_enter_state(struct station *sta=
tion,
 	struct l_dbus *dbus =3D dbus_get_bus();
 	bool disconnected;
 =

-	l_debug("Old State: %s, new state: %s",
-			station_state_to_string(station->state),
-			station_state_to_string(state));
-
 	disconnected =3D !station_is_busy(station);
 =

 	if ((disconnected && state > STATION_STATE_AUTOCONNECT_FULL) ||
-			(!disconnected && state !=3D station->state))
+			(!disconnected && state !=3D station->state)) {
 		l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
 					IWD_STATION_INTERFACE, "State");
+		l_debug("Old State: %s, new state: %s",
+					station_state_to_string(station->state),
+					station_state_to_string(state));
+	}
 =

 	switch (state) {
 	case STATION_STATE_AUTOCONNECT_QUICK:
-- =

2.13.6

--===============1616251463729823156==--

