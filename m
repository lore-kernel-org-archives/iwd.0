Content-Type: multipart/mixed; boundary="===============7149925921085100161=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/3] station: Stop periodic scan when netdev connected
Date: Fri, 18 Jun 2021 09:33:24 +0200
Message-ID: <20210618073324.67095-3-andrew.zaborowski@intel.com>
In-Reply-To: <20210618073324.67095-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7149925921085100161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For consistency call periodic_scan_stop() right after netdev signals
connected even if station stays in the CONNECTING state because it's
waiting for netconfig to finish.
---
 src/station.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/station.c b/src/station.c
index 0b0cc59c..66ddc76e 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2468,6 +2468,7 @@ static void station_connect_ok(struct station *statio=
n)
 	}
 =

 	network_connected(station->connected_network);
+	periodic_scan_stop(station);
 =

 	if (station->netconfig)
 		netconfig_configure(station->netconfig,
-- =

2.30.2

--===============7149925921085100161==--

