Content-Type: multipart/mixed; boundary="===============5390702387812995222=="
MIME-Version: 1.0
From: Jesse Lentz <jesse at twosheds.org>
To: iwd at lists.01.org
Subject: [PATCH 2/2] station: Provide SignalLevelAgent update while connecting
Date: Mon, 23 May 2022 02:20:53 -0400
Message-ID: <20220523062053.16206-2-jesse@twosheds.org>
In-Reply-To: 20220523062053.16206-1-jesse@twosheds.org

--===============5390702387812995222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a station enters the "connecting" state, if a SignalLevelAgent is
registered, provide an initial signal level via a "Changed" method call.
---
 src/station.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/station.c b/src/station.c
index 6aad40cb..7c88f266 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1487,6 +1487,9 @@ static void station_enter_state(struct station *stati=
on,
 				network_get_path(station->connected_network),
 				IWD_NETWORK_INTERFACE, "Connected");
 =

+		if (station->signal_agent)
+			station_signal_agent_notify(station);
+
 		periodic_scan_stop(station);
 		break;
 	case STATION_STATE_CONNECTED:
-- =

2.36.0

--===============5390702387812995222==--

