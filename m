Content-Type: multipart/mixed; boundary="===============4190615115709436120=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] station: handle EAP_COMPLETE event
Date: Thu, 08 Apr 2021 08:46:46 -0700
Message-ID: <20210408154646.1182833-5-prestwoj@gmail.com>
In-Reply-To: <20210408154646.1182833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4190615115709436120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Notify netdev via netdev_handshake_set_pmk that EAP has finished.
---
 src/station.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/station.c b/src/station.c
index 064872c6..8dda113d 100644
--- a/src/station.c
+++ b/src/station.c
@@ -740,6 +740,10 @@ static void station_handshake_event(struct handshake_s=
tate *hs,
 		l_warn("Unable to securely rekey on this hw/kernel...");
 		station_reconnect(station);
 		break;
+	case HANDSHAKE_EVENT_EAP_COMPLETE:
+		l_debug("EAP complete");
+		netdev_handshake_set_pmk(hs);
+		break;
 	case HANDSHAKE_EVENT_COMPLETE:
 	case HANDSHAKE_EVENT_SETTING_KEYS_FAILED:
 	case HANDSHAKE_EVENT_EAP_NOTIFY:
-- =

2.26.2

--===============4190615115709436120==--

