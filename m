Content-Type: multipart/mixed; boundary="===============5873183740640224710=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5] station: Make Disconnect() cancel ConnectHiddenNetwork()
Date: Thu, 08 Oct 2020 10:49:07 +0200
Message-ID: <20201008084911.1046485-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5873183740640224710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ConnectHiddenNetwork can be seen a triggering this sequence:
1. the active scan,
2. the optional agent request,
3. the Authentication/Association/4-Way Handshake/netconfig,
4. connected state

Currently Disconnect() interrupts 3 and 4, allow it to also interrupt
state 1.  It's difficult to tell whether we're in state 2 from within
station.c.
---
 src/station.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/station.c b/src/station.c
index 7fb4ae77..6ac9e53b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2749,6 +2749,15 @@ static struct l_dbus_message *station_dbus_disconnec=
t(struct l_dbus *dbus,
 	 */
 	station_set_autoconnect(station, false);
 =

+	if (station->hidden_network_scan_id) {
+		scan_cancel(netdev_get_wdev_id(station->netdev),
+				station->hidden_network_scan_id);
+		dbus_pending_reply(&station->hidden_pending,
+				dbus_error_aborted(station->hidden_pending));
+
+		return l_dbus_message_new_method_return(message);
+	}
+
 	if (!station_is_busy(station))
 		return l_dbus_message_new_method_return(message);
 =

-- =

2.25.1

--===============5873183740640224710==--

