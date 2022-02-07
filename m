Content-Type: multipart/mixed; boundary="===============6832999775632889741=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2] netdev: fail connection if the link goes down
Date: Mon, 07 Feb 2022 14:57:50 -0800
Message-ID: <20220207225750.458709-1-prestwoj@gmail.com>

--===============6832999775632889741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In certain rare cases IWD gets a link down event before nl80211 ever sends
a disconnect event. Netdev notifies station of the link down which causes
station to be freed, but netdev remains in the same state. Then later the
disconnect event arrives and netdev still thinks its connected, calls into
(the now freed) station object and causes a crash.

To fix this netdev_connect_free() is now called on any link down events
which will reset the netdev object to a proper state.

src/netdev.c:netdev_link_notify() event 16 on ifindex 16
src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
src/netdev.c:netdev_link_notify() event 16 on ifindex 16
src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
src/netdev.c:netdev_deauthenticate_event()
src/netdev.c:netdev_link_notify() event 16 on ifindex 16
src/station.c:station_free()
src/netconfig.c:netconfig_destroy()
src/resolve.c:resolve_systemd_revert() ifindex: 16
src/station.c:station_roam_state_clear() 16
src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
src/netdev.c:netdev_disconnect_event()
Received Deauthentication event, reason: 3, from_ap: false

0 0x472fa4 in station_disconnect_event src/station.c:2916
1 0x472fa4 in station_netdev_event src/station.c:2954
2 0x43a262 in netdev_disconnect_event src/netdev.c:1213
3 0x43a262 in netdev_mlme_notify src/netdev.c:5471
4 0x6706eb in process_multicast ell/genl.c:1029
5 0x6706eb in received_data ell/genl.c:1096
6 0x65e630 in io_callback ell/io.c:120
7 0x65a94e in l_main_iterate ell/main.c:478
8 0x65b0b3 in l_main_run ell/main.c:525
9 0x65b0b3 in l_main_run ell/main.c:507
10 0x65b5cc in l_main_run_with_signal ell/main.c:647
11 0x4124d7 in main src/main.c:532
---
 src/netdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index bac6860c..36d183e7 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -6199,6 +6199,9 @@ static void netdev_newlink_notify(const struct ifinfo=
msg *ifi, int bytes)
 =

 	new_up =3D netdev_get_is_up(netdev);
 =

+	if (!new_up)
+		netdev_connect_free(netdev);
+
 	/*
 	 * If mac_change_cmd_id is set we are in the process of changing the
 	 * MAC address and this event is a result of powering down/up. In this
-- =

2.31.1

--===============6832999775632889741==--

