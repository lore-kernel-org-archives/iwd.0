Content-Type: multipart/mixed; boundary="===============2526970814553434968=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] station: fix improper state transition
Date: Tue, 26 Jan 2021 09:46:57 -0800
Message-ID: <20210126174657.867692-4-prestwoj@gmail.com>
In-Reply-To: <20210126174657.867692-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2526970814553434968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

At some point the non-interactive client tests began failing.
This was due to a bug in station where it would transition from
'connected' to 'autoconnect' due to a failed scan request. The
scan request was started prior to the connection, but the work
queue delayed it and tries triggering it after we are connected.
The kernel gives back an error, which results in station
transitioning to autoconnect_full because the triggered callback
(station_quick_scan_triggered) assumed station was in a non
connected state. The sequence can be seen here:

src/station.c:station_connect_cb() 13, result: 0
src/station.c:station_enter_state() Old State: connecting, new state: conne=
cted
src/wiphy.c:wiphy_radio_work_done() Work item 6 done
src/wiphy.c:wiphy_radio_work_next() Starting work item 5
src/station.c:station_quick_scan_triggered() Quick scan trigger failed: -95
src/station.c:station_enter_state() Old State: connected, new state: autoco=
nnect_full
---
 src/station.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/station.c b/src/station.c
index b600f37e..e7f78f2b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1113,6 +1113,9 @@ static void station_quick_scan_triggered(int err, voi=
d *user_data)
 	if (err < 0) {
 		l_debug("Quick scan trigger failed: %i", err);
 =

+		if (station_is_busy(station))
+			return;
+
 		station_enter_state(station, STATION_STATE_AUTOCONNECT_FULL);
 =

 		return;
-- =

2.26.2

--===============2526970814553434968==--

