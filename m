Content-Type: multipart/mixed; boundary="===============7050990607902051115=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <alvin@pqrs.dk>
Subject: [PATCH 3/3] station: update current BSS frequency on netdev channel
 switch event
Date: Thu, 27 May 2021 16:22:29 +0200
Message-ID: <20210527142229.1213074-3-alvin@pqrs.dk>
In-Reply-To: <20210527142229.1213074-1-alvin@pqrs.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7050990607902051115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>

If the connected BSS changes channel, netdev will emit an event with the
new channel's frequency. In response, have station change the frequency
of the connected scan_bss struct and inform network about the update.
---
 src/station.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/station.c b/src/station.c
index 553d4cae52c2..83c21b662e6f 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2316,6 +2316,16 @@ static void station_event_roamed(struct station *sta=
tion, struct scan_bss *new)
 	station_roamed(station);
 }
 =

+static void station_event_channel_switched(struct station *station,
+						const uint32_t freq)
+{
+	struct network *network =3D station->connected_network;
+
+	station->connected_bss->frequency =3D freq;
+
+	network_bss_update(network, station->connected_bss);
+}
+
 static void station_rssi_level_changed(struct station *station,
 					uint8_t level_idx);
 =

@@ -2594,6 +2604,9 @@ static void station_netdev_event(struct netdev *netde=
v, enum netdev_event event,
 	case NETDEV_EVENT_ROAMED:
 		station_event_roamed(station, (struct scan_bss *) event_data);
 		break;
+	case NETDEV_EVENT_CHANNEL_SWITCHED:
+		station_event_channel_switched(station, l_get_u32(event_data));
+		break;
 	}
 }
 =

-- =

2.31.1

--===============7050990607902051115==--

