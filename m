Content-Type: multipart/mixed; boundary="===============7836532209317577251=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] netdev: fix crash from carefully timed Connect()
Date: Mon, 05 Apr 2021 14:26:50 -0700
Message-ID: <20210405212650.1042486-2-prestwoj@gmail.com>
In-Reply-To: <20210405212650.1042486-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7836532209317577251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There were a few bugs that this patch addresses. First was
the disconnect callback being called immediately for a
rare case where disconnect was not not required. This should
have never been done, and instead an l_idle can be used so
the callback comes in asynchronously as expected.

The second bug was how the send_disconnect flag was being
set. In netdev_disconnect the check for connect_cmd_id was
not a great way of testing if disconnect should be sent. This
is because once CMD_CONNECT completes this command ID is set
to zero, meaning we end up setting send_disconnect =3D false.
In this case we actually do want to send the disconnect since
we are presumably in EAPoL.

The only situation where disconnect should not be sent is if
CMD_CONNECT has not yet been issued. This can only happen if
IWD is waiting to queue the connect work item and now this
is checked as such (wiphy_radio_work_is_running).

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
 src/netdev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index e7ffb635..2414c83e 100644
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
@@ -3214,7 +3221,8 @@ int netdev_disconnect(struct netdev *netdev,
 		if (netdev->connect_cmd_id) {
 			l_genl_family_cancel(nl80211, netdev->connect_cmd_id);
 			netdev->connect_cmd_id =3D 0;
-		} else
+		} else if (!wiphy_radio_work_is_running(netdev->wiphy,
+							netdev->work.id))
 			send_disconnect =3D false;
 =

 		netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
@@ -3239,7 +3247,7 @@ int netdev_disconnect(struct netdev *netdev,
 		netdev->user_data =3D user_data;
 		netdev->aborting =3D true;
 	} else if (cb)
-		cb(netdev, true, user_data);
+		l_idle_oneshot(disconnect_idle, netdev, NULL);
 =

 	return 0;
 }
-- =

2.26.2

--===============7836532209317577251==--

