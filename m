Content-Type: multipart/mixed; boundary="===============6790255284864011086=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Possible bug - DISASSOC_LOW_ACK
Date: Wed, 22 Sep 2021 09:59:20 +0100
Message-ID: <CACsRnHWN8VuaYqvSx_1t1Mx-Cd9A_oPqwyX66o18aHmeLmWiWA@mail.gmail.com>

--===============6790255284864011086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone,

In my use case that involves heavy roaming, I've been noticing that
occasionally `iwd` disconnects completely from the network before
rejoining which can cause a few seconds of downtime. In addition to
the downtime it seems to put the network in an odd state which is
hitting a bunch of corner cases in code that uses the network more
than just a normal disconnect. Looking at the logs, it seems like iwd
might be getting locked up somewhere as it also stops reacting to
threshold notifications?

I'm not sure how to reproduce this as it's relatively rare, happening
3 times in about a week. The logs below are from a machine running
version 1.17.
I'll see if I can start a rolling iwmon capture to get more info. Is
there anything else that would be useful?

```
Sep 21 15:40:22.138376 p3-683 iwd[425]:
src/netdev.c:netdev_mlme_notify() MLME notification Frame TX
Status(60)
Sep 21 15:40:22.140101 p3-683 iwd[425]:
src/netdev.c:netdev_unicast_notify() Unicast notification 59
Sep 21 15:40:22.140101 p3-683 iwd[425]:
src/station.c:station_early_neighbor_report_cb() ifindex: 5, error:
0()
Sep 21 15:40:22.140101 p3-683 iwd[425]:
src/station.c:parse_neighbor_report() Neighbor report received for
ea:9e:38:78:07:b1: ch 44 (oper class 0), MD not set
Sep 21 15:40:22.141734 p3-683 iwd[425]:
src/netdev.c:netdev_unicast_notify() Unicast notification 59
Sep 21 15:40:22.142298 p3-683 iwd[425]:
src/netdev.c:netdev_unicast_notify() Unicast notification 59
Sep 21 15:40:22.166050 p3-683 kernel: wlan0: Limiting TX power to 27
(30 - 3) dBm as advertised by ea:9e:38:78:08:71
Sep 21 15:40:22.473706 p3-683 iwd[425]:
src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
Sep 21 15:41:12.767433 p3-683 iwd[425]:
src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
Sep 21 15:46:41.998639 p3-683 kernel: wlan0: deauthenticated from
ea:9e:38:78:08:71 (Reason: 34=3DDISASSOC_LOW_ACK)
Sep 21 15:46:41.997194 p3-683 systemd-networkd[341]: wlan0: Lost carrier
Sep 21 15:46:41.999173 p3-683 iwd[425]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 5
Sep 21 15:46:42.107670 p3-683 iwd[425]:
src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
Sep 21 15:46:42.111369 p3-683 iwd[425]:
src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
Sep 21 15:46:42.111369 p3-683 iwd[425]:
src/netdev.c:netdev_deauthenticate_event()
Sep 21 15:46:42.111369 p3-683 iwd[425]:
src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
Sep 21 15:46:42.111369 p3-683 iwd[425]: src/netdev.c:netdev_disconnect_even=
t()
Sep 21 15:46:42.111369 p3-683 iwd[425]: Received Deauthentication
event, reason: 34, from_ap: true
Sep 21 15:46:42.111369 p3-683 iwd[425]:
src/station.c:station_disconnect_event() 5
Sep 21 15:46:42.111369 p3-683 iwd[425]: src/station.c:station_disassociated=
() 5
Sep 21 15:46:42.111369 p3-683 iwd[425]:
src/resolve.c:resolve_systemd_revert() ifindex: 5
Sep 21 15:46:42.136257 p3-683 iwd[425]:
src/station.c:station_enter_state() Old State: connected, new state:
disconnected
Sep 21 15:46:42.136257 p3-683 iwd[425]:
src/station.c:station_enter_state() Old State: disconnected, new
state: autoconnect_quick
```

Kind Regards,
Michael
--===============6790255284864011086==--

