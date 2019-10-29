Content-Type: multipart/mixed; boundary="===============5606525822613351568=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] station: add APIs to get connected BSS and BSS list
Date: Tue, 29 Oct 2019 10:50:41 -0700
Message-ID: <20191029175043.27745-3-prestwoj@gmail.com>
In-Reply-To: <20191029175043.27745-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5606525822613351568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For Radio Resource Management (RRM) we will need access to the currently
connected BSS as well as the last scan results in order to do certain
kinds of requested measurements.
---
 src/station.c | 10 ++++++++++
 src/station.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/src/station.c b/src/station.c
index 315b3dcd..3246e90c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3015,6 +3015,16 @@ void station_network_foreach(struct station *station,
 	l_hashmap_foreach(station->networks, network_foreach, &data);
 }
 =

+struct l_queue *station_get_bss_list(struct station *station)
+{
+	return station->bss_list;
+}
+
+struct scan_bss *station_get_connected_bss(struct station *station)
+{
+	return station->connected_bss;
+}
+
 static struct station *station_create(struct netdev *netdev)
 {
 	struct station *station;
diff --git a/src/station.h b/src/station.h
index 469b5400..4155081b 100644
--- a/src/station.h
+++ b/src/station.h
@@ -85,3 +85,5 @@ void station_foreach(station_foreach_func_t func, void *u=
ser_data);
 void station_network_foreach(struct station *station,
 				station_network_foreach_func_t func,
 				void *user_data);
+struct l_queue *station_get_bss_list(struct station *station);
+struct scan_bss *station_get_connected_bss(struct station *station);
-- =

2.17.1

--===============5606525822613351568==--

