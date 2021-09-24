Content-Type: multipart/mixed; boundary="===============3855146907022039575=="
MIME-Version: 1.0
From: 58e33db1-f428-4823-8cc3-d962d0fb8aa8 at slmail.me
To: iwd at lists.01.org
Subject: Re: iwd 1.18 doesn't connect to network on boot
Date: Fri, 24 Sep 2021 11:11:31 +0000
Message-ID: <163248189192.7.14395568023465014360.14116838@slmail.me>
In-Reply-To: 163240946492.7.17887603663275992858.14059359@simplelogin.co

--===============3855146907022039575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Hi Jason,
> =

> On 9/23/21 6:04 AM, 58e33db1-f428-4823-8cc3-d962d0fb8aa8(a)slmail.me wrot=
e:
> > Hi,
> > =

> > I'm on Arch Linux and after recent iwd upgrade to version 1.18 I'm no l=
onger connected to my home network when booting. Previous version works jus=
t fine. I've managed to workaround the issue simply by going to iwctl and m=
anually doing disconnect/connect every time I boot the computer.
> =

> Not much to go on.  Can you tell us what the previous version of iwd was?=
  How =

> is your AP configured? WPA2-Personal? WPA3-Personal?  At a minimum we als=
o need =

> logs from iwd and preferably iwmon.  See https://iwd.wiki.kernel.org/debu=
gging
> =

> Regards,
> -Denis

Hi Denis,

AP authentication is WPA2-Personal. I turned on logging and these are the r=
elevant lines:

iwd[4842]: src/station.c:station_autoconnect_next() autoconnect: Trying SSI=
D: xxxxxxxx
iwd[4842]: src/station.c:station_autoconnect_next() autoconnect: 'xx:xx:xx:=
xx:xx:xx' freq: 2447, rank: 2184, strength: -6500
iwd[4842]: src/netdev.c:netdev_cqm_rssi_update()
iwd[4842]: src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
iwd[4842]: src/station.c:__station_connect_network() connecting to BSS xx:x=
x:xx:xx:xx:xx
iwd[4842]: src/station.c:station_enter_state() Old State: autoconnect_quick=
, new state: connecting (auto)
iwd[4842]: src/scan.c:scan_cancel() Trying to cancel scan id 1 for wdev 8
iwd[4842]: src/wiphy.c:wiphy_radio_work_done() Work item 1 done
iwd[4842]: src/wiphy.c:wiphy_radio_work_next() Starting work item 2
iwd[4842]: src/netdev.c:netdev_link_notify() event 16 on ifindex 8
iwd[4842]: src/netdev.c:netdev_mac_power_down_cb() Setting generated addres=
s on ifindex: 8 to: 9a:a7:a9:ba:16:52
iwd[4842]: src/netdev.c:netdev_link_notify() event 16 on ifindex 8
iwd[4842]: src/wiphy.c:wiphy_reg_notify() Notification of command Wiphy Reg=
 Change(113)
iwd[4842]: src/wiphy.c:wiphy_update_reg_domain() New reg domain country cod=
e for phy0 is XX
iwd[4842]: src/netdev.c:netdev_link_notify() event 16 on ifindex 8
iwd[4842]: src/scan.c:scan_notify() Scan notification Trigger Scan(33)
iwd[4842]: src/station.c:station_netdev_event() Associating
iwd[4842]: src/scan.c:scan_notify() Scan notification New Scan Results(34)
iwd[4842]: src/netdev.c:netdev_link_notify() event 16 on ifindex 8
kernel: wlan0: authenticate with xx:xx:xx:xx:xx:xx
iwd[4842]: src/netdev.c:netdev_mlme_notify() MLME notification New Station(=
19)
kernel: wlan0: send auth to xx:xx:xx:xx:xx:xx (try 1/3)
kernel: wlan0: send auth to xx:xx:xx:xx:xx:xx (try 2/3)
iwd[4842]: src/netdev.c:netdev_mlme_notify() MLME notification Authenticate=
(37)
iwd[4842]: src/netdev.c:netdev_authenticate_event()
kernel: wlan0: authenticated
kernel: wlan0: associate with xx:xx:xx:xx:xx:xx (try 1/3)
kernel: wlan0: RX AssocResp from xx:xx:xx:xx:xx:xx (capab=3D0x1411 status=
=3D0 aid=3D1)
iwd[4842]: src/netdev.c:netdev_unicast_notify() Unicast notification 129
iwd[4842]: src/netdev.c:netdev_control_port_frame_event()
iwd[4842]: src/netdev.c:netdev_mlme_notify() MLME notification Associate(38)
iwd[4842]: src/netdev.c:netdev_associate_event()
iwd[4842]: src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
iwd[4842]: src/netdev.c:netdev_connect_event()
iwd[4842]: src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=3D8
kernel: wlan0: associated
iwd[4842]: src/netdev.c:netdev_link_notify() event 16 on ifindex 8
iwd[4842]: src/netdev.c:netdev_link_notify() event 16 on ifindex 8
iwd[4842]: src/netdev.c:netdev_link_notify() event 16 on ifindex 8
iwd[4842]: src/netdev.c:netdev_link_notify() event 16 on ifindex 8
iwd[4842]: src/netdev.c:netdev_mlme_notify() MLME notification Control Port=
 TX Status(139)
iwd[4842]: src/netdev.c:netdev_unicast_notify() Unicast notification 129
iwd[4842]: src/netdev.c:netdev_control_port_frame_event()
iwd[4842]: src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=3D8
iwd[4842]: src/netdev.c:netdev_set_gtk() 8
iwd[4842]: src/station.c:station_handshake_event() Setting keys
iwd[4842]: src/netdev.c:netdev_set_tk() 8
iwd[4842]: src/netdev.c:netdev_set_rekey_offload() 8
iwd[4842]: src/netdev.c:netdev_mlme_notify() MLME notification Control Port=
 TX Status(139)
iwd[4842]: src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(6=
4)
iwd[4842]: src/station.c:station_connect_cb() 8, result: 0
iwd[4842]: src/station.c:station_connect_ok()
iwd[4842]: src/netconfig.c:netconfig_ipv6_select_and_install() IPV6 configu=
ration disabled
iwd[4842]: src/wiphy.c:wiphy_radio_work_done() Work item 2 done
iwd[4842]: src/netdev.c:netdev_link_notify() event 16 on ifindex 8
iwd[4842]: src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Sta=
tus(60)
iwd[4842]: src/station.c:station_early_neighbor_report_cb() ifindex: 8, err=
or: -110(Connection timed out)

This is the point where connection is stuck and iwctl reports 'connecting' =
indefinitely despite being authenticated already.

Anything else just tell me.

Thanks.


--===============3855146907022039575==--

