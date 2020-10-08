Content-Type: multipart/mixed; boundary="===============7035585577097599462=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/5] station: Add current hidden network to networks_sorted
Date: Thu, 08 Oct 2020 10:49:08 +0200
Message-ID: <20201008084911.1046485-2-andrew.zaborowski@intel.com>
In-Reply-To: <20201008084911.1046485-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7035585577097599462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Update station->networks_sorted with new networks added inside
station_hidden_network_scan_results() because we rely on
station->networks being in sync with station->networks_sorted.
Otherwise station_set_scan_results may crash.

Optimally a generic scan shouldn't happen while we're connecting to a
new hidden network because the generic scan doesn't know about the
hidden network's SSID and will not include the SSID in the probe request
so it can at most expire the BSS we're trying to connect to.  However we
can't easily tell whether we're in the middle of a Connect() or
ConnectHiddenNetwork() call as mentioned in the previous commit, so we
have to accept that we may trigger a new scan while waiting for secrets
from the agent.  Thus the BSS discovered in the active scan for the
hidden SSID may expire if the agent request takes too long but we this
change at least we don't crash.
---
 src/station.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/station.c b/src/station.c
index 6ac9e53b..b70d3416 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2572,11 +2572,16 @@ static bool station_hidden_network_scan_results(int=
 err,
 					memcmp(bss->ssid, ssid, ssid_len))
 			goto next;
 =

-		if (station_add_seen_bss(station, bss)) {
-			l_queue_push_tail(station->bss_list, bss);
+		network =3D station_add_seen_bss(station, bss);
+		if (!network)
+			goto next;
 =

-			continue;
-		}
+		l_queue_push_tail(station->bss_list, bss);
+		network_rank_update(network, false);
+		l_queue_remove(station->networks_sorted, network);
+		l_queue_insert(station->networks_sorted, network,
+				network_rank_compare, NULL);
+		continue;
 =

 next:
 		scan_bss_free(bss);
-- =

2.25.1

--===============7035585577097599462==--

