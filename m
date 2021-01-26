Content-Type: multipart/mixed; boundary="===============1613615355005731640=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] station: cancel quick scans on Connect()
Date: Tue, 26 Jan 2021 11:57:35 -0800
Message-ID: <20210126195735.880657-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1613615355005731640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

At some point the non-interactive client tests began failing.
This was due to a bug in station where it would transition from
'connected' to 'autoconnect' due to a failed scan request. This
happened because a quick scan got scheduled during an ongoing
scan, then a Connect() gets issued. The work queue treats the
Connect as a priority so it delays the quick scan until after the
connection succeeds. This results in a failed quick scan which
IWD does not expect to happen when in a 'connected' state. This
failed scan actually triggers a state transition which then
gets IWD into a strange state where its connected from the
kernel point of view but does not think it is:

src/station.c:station_connect_cb() 13, result: 0
src/station.c:station_enter_state() Old State: connecting, new state: conne=
cted
src/wiphy.c:wiphy_radio_work_done() Work item 6 done
src/wiphy.c:wiphy_radio_work_next() Starting work item 5
src/station.c:station_quick_scan_triggered() Quick scan trigger failed: -95
src/station.c:station_enter_state() Old State: connected, new state: autoco=
nnect_full

To fix this IWD should simply cancel any pending quick scans
if/when a Connect() call comes in.
---
 src/station.c | 6 ++++++
 1 file changed, 6 insertions(+)

v2:
 * Rather than handle inside the triggered callback we can
   just cancel the scan when the connection is attempted.
   This prevents unneeded kernel round trips as well.

diff --git a/src/station.c b/src/station.c
index b600f37e..55368472 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2539,6 +2539,12 @@ void station_connect_network(struct station *station=
, struct network *network,
 				dbus_error_failed(station->hidden_pending));
 	}
 =

+	if (station->quick_scan_id) {
+		scan_cancel(netdev_get_wdev_id(station->netdev),
+				station->quick_scan_id);
+		station->quick_scan_id =3D 0;
+	}
+
 	if (station_is_busy(station)) {
 		station_disconnect_onconnect(station, network, bss, message);
 =

-- =

2.26.2

--===============1613615355005731640==--

