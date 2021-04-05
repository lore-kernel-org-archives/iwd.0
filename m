Content-Type: multipart/mixed; boundary="===============5208881852518008700=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 2/2] netdev: fix crash from carefully timed Connect()
Date: Mon, 05 Apr 2021 15:18:36 -0700
Message-ID: <20210405221836.1049804-2-prestwoj@gmail.com>
In-Reply-To: <20210405221836.1049804-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5208881852518008700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This crash was caused from the disconnect_cb being called
immediately in cases where send_disconnect was false. The
previous patch actually addressed this separately as this
flag was being set improperly which will, indirectly, fix
one of the two code paths that could cause this crash.

Still, there is a situation where send_disconnect could
be false and in this case IWD would still crash. If IWD
is waiting to queue the connect item and netdev_disconnect
is called it would result in the callback being called
immediately. Instead we can add an l_idle as to allow the
callback to happen out of scope, which is what station
expects.

Prior to this patch, the crashing behavior can be tested using
the following script (or some variant of it, your system timing
may not be the same as mine).

iwctl station wlan0 disconnect
iwctl station wlan0 connect <network1> &
sleep 0.02
iwctl station wlan0 connect <network2>

++++++++ backtrace ++++++++
0  0x7f4e1504e530 in /lib64/libc.so.6
1  0x432b54 in network_get_security() at src/network.c:253
2  0x416e92 in station_handshake_setup() at src/station.c:937
3  0x41a505 in __station_connect_network() at src/station.c:2551
4  0x41a683 in station_disconnect_onconnect_cb() at src/station.c:2581
5  0x40b4ae in netdev_disconnect() at src/netdev.c:3142
6  0x41a719 in station_disconnect_onconnect() at src/station.c:2603
7  0x41a89d in station_connect_network() at src/station.c:2652
8  0x433f1d in network_connect_psk() at src/network.c:886
9  0x43483a in network_connect() at src/network.c:1183
10 0x4add11 in _dbus_object_tree_dispatch() at ell/dbus-service.c:1802
11 0x49ff54 in message_read_handler() at ell/dbus.c:285
12 0x496d2f in io_callback() at ell/io.c:120
13 0x495894 in l_main_iterate() at ell/main.c:478
14 0x49599b in l_main_run() at ell/main.c:521
15 0x495cb3 in l_main_run_with_signal() at ell/main.c:647
16 0x404add in main() at src/main.c:490
17 0x7f4e15038b25 in /lib64/libc.so.6
---
 src/netdev.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 0e517468..a4b2094d 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3182,6 +3182,13 @@ build_cmd_connect:
 						event_filter, cb, user_data);
 }
 =

+static void disconnect_idle(void *user_data)
+{
+	struct netdev *netdev =3D user_data;
+
+	netdev->disconnect_cb(netdev, true, netdev->user_data);
+}
+
 int netdev_disconnect(struct netdev *netdev,
 				netdev_disconnect_cb_t cb, void *user_data)
 {
@@ -3239,8 +3246,12 @@ int netdev_disconnect(struct netdev *netdev,
 		netdev->disconnect_cb =3D cb;
 		netdev->user_data =3D user_data;
 		netdev->aborting =3D true;
-	} else if (cb)
-		cb(netdev, true, user_data);
+	} else if (cb) {
+		netdev->disconnect_cb =3D cb;
+		netdev->user_data =3D user_data;
+
+		l_idle_oneshot(disconnect_idle, netdev, NULL);
+	}
 =

 	return 0;
 }
-- =

2.26.2

--===============5208881852518008700==--

