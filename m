Content-Type: multipart/mixed; boundary="===============7984182528835227896=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH] station: Add missing netconfig_reset()
Date: Thu, 30 Sep 2021 00:22:01 +0200
Message-ID: <20210929222201.124492-1-andrew.zaborowski@intel.com>

--===============7984182528835227896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On NETDEV_EVENT_DISCONNECT_BY_* events during netconfig, we'd forget to
call netconfig_reset() before trying a new netconfig_configure()
resulting in the "netconfig: Failed to start DHCPv4 client for interface
%u" warning and a L_WARN_ON.  Add the missing call.
---
 src/station.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/station.c b/src/station.c
index 934815f2..1c073fc1 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2810,6 +2810,9 @@ static void station_disconnect_event(struct station *=
station, void *event_data)
 	switch (station->state) {
 	case STATION_STATE_CONNECTING:
 	case STATION_STATE_CONNECTING_AUTO:
+		if (station->netconfig)
+			netconfig_reset(station->netconfig);
+
 		station_connect_cb(station->netdev,
 					NETDEV_RESULT_HANDSHAKE_FAILED,
 					event_data, station);
-- =

2.30.2

--===============7984182528835227896==--

