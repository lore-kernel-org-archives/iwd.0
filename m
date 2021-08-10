Content-Type: multipart/mixed; boundary="===============0903062333496086012=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459@gmail.com>
Subject: Failing to resolve after roams
Date: Tue, 10 Aug 2021 11:58:27 +0100
Message-ID: <CACsRnHWusQ22=YJVn23OBAC2ssiBrr5EQ_9msjamU_1dPx-DbA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0903062333496086012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm having a problem with iwd when it comes to roaming. Most of the
time it is working perfectly but rarely I get into this situation
where I can't resolve any hostnames.
I'm using a default server setup on ubuntu which uses systemd-networkd
and systemd-resolved with iwd configured to use
`EnableNetworkConfiguration=3Dtrue`.

Here are the debug logs of a failure case:
```
Aug 10 09:48:04.120612 p3-631 systemd-networkd[341]: wlan0: Lost carrier
Aug 10 09:48:04.121287 p3-631 kernel: wlan0: send auth to <BSSID> (try 1/3)
Aug 10 09:48:04.123440 p3-631 iwd[413]:
src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
Aug 10 09:48:04.123440 p3-631 iwd[413]: src/netdev.c:netdev_authenticate_ev=
ent()
Aug 10 09:48:04.125236 p3-631 kernel: wlan0: authenticated
Aug 10 09:48:04.125339 p3-631 kernel: wlan0: associate with <BSSID> (try 1/=
3)
Aug 10 09:48:04.133316 p3-631 kernel: wlan0: RX ReassocResp from
<BSSID> (capab=3D0x1511 status=3D0 aid=3D8)
Aug 10 09:48:04.134574 p3-631 iwd[413]:
src/netdev.c:netdev_mlme_notify() MLME notification Associate(38)
Aug 10 09:48:04.134574 p3-631 iwd[413]: src/netdev.c:netdev_associate_event=
()
Aug 10 09:48:04.134574 p3-631 iwd[413]: src/netdev.c:netdev_set_gtk() 5
Aug 10 09:48:04.134574 p3-631 iwd[413]:
src/station.c:station_handshake_event() Setting keys
Aug 10 09:48:04.134574 p3-631 iwd[413]: src/netdev.c:netdev_set_tk() 5
Aug 10 09:48:04.134574 p3-631 iwd[413]:
src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
Aug 10 09:48:04.134574 p3-631 iwd[413]: src/netdev.c:netdev_connect_event()
Aug 10 09:48:04.135502 p3-631 iwd[413]:
src/station.c:station_fast_transition_cb() 5, result: 0
Aug 10 09:48:04.135502 p3-631 iwd[413]:
src/station.c:station_enter_state() Old State: roaming, new state:
connected
Aug 10 09:48:04.135502 p3-631 iwd[413]:
src/wiphy.c:wiphy_radio_work_done() Work item 315 done
Aug 10 09:48:04.135791 p3-631 iwd[413]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 5
Aug 10 09:48:04.135936 p3-631 iwd[413]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 5
Aug 10 09:48:04.136075 p3-631 iwd[413]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 5
Aug 10 09:48:04.136231 p3-631 iwd[413]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 5
Aug 10 09:48:04.136460 p3-631 iwd[413]: src/wiphy.c:wiphy_reg_notify()
Notification of command Reg Change(36)
Aug 10 09:48:04.136460 p3-631 iwd[413]:
src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
(global) is US
Aug 10 09:48:04.136741 p3-631 iwd[413]:
src/netdev.c:netdev_mlme_notify() MLME notification Frame TX
Status(60)
Aug 10 09:48:04.137287 p3-631 kernel: wlan0: associated
```
```
$ sudo resolvectl status
...
Link 5 (wlan0)
      Current Scopes: none
```

What I noticed is that when the roam works, there is a
`systemd-networkd[341]: wlan0: Gained carrier` line at the end which
is missing here.
Unfortunately it happens rarely enough that capturing the netlink
traffic is a pain so I can't see if the issue is on the iwd or systemd
side.

Has anyone else seen something like this?

Kind Regards,
Michael
--===============0903062333496086012==--

