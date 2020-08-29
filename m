Content-Type: multipart/mixed; boundary="===============6982313830241120388=="
MIME-Version: 1.0
From: Patrick =?unknown-8bit?q?H=C3=A4cker?= <pat_h@web.de>
Subject: iwd not connecting on Raspberry Pi with Raspbian
Date: Sat, 29 Aug 2020 14:59:11 +0200
Message-ID: <3765450.Iyh0gPlrZJ@mmm>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6982313830241120388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I try to get iwd running on a Raspberry Pi using a Raspbian kernel (5.4.59)=
. =

The needed kernel options should be added (https://github.com/raspberrypi/
linux/issues/3547), wpa_supplicant works, I compiled a kernel adding =

CONFIG_KEY_DH_OPERATIONS (which was the only remaining complaint by iwd), =

upgraded to iwd 1.8 but had no success.

Now I am running out of ideas what else to try. The (hopefully) relevant pa=
rt =

of iwd running in debug mode for 2.4 GHz:
> src/station.c:station_autoconnect_next() Considering autoconnecting to BSS
>     '98:9b:cb:4b:b1:cc' with SSID: auenstein, freq: 2472, rank: 7090,
>     strength:=00 -5600
> src/station.c:station_enter_state() Old State: autoconnect_quick, new
>     state: connecting
> src/station.c:station_netdev_event() Associating
> src/netdev.c:netdev_unicast_notify() Unicast notification 59
> src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
> src/netdev.c:netdev_connect_event()
> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
> src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
>     (global) is DE
> 4-Way handshake failed for ifindex: 3, reason: 15
> src/station.c:station_connect_cb() 3, result: 3
> src/station.c:station_disassociated() 3
> src/station.c:station_enter_state() Old State: connecting, new state:
>     disconnected=00

And the same for 5.6 GHz with a different error:
> src/station.c:station_autoconnect_next() Considering autoconnecting to BSS
>     '98:9b:cb:4b:b1:cd' with SSID: auenstein5G, freq: 5600, rank: 4592,
>     strength: -6500
> src/station.c:station_enter_state() Old State:
>     autoconnect_quick, new state: connecting
> src/station.c:station_netdev_event() Associating
> src/netdev.c:netdev_unicast_notify() Unicast notification 59
> src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
> src/netdev.c:netdev_connect_event()
> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
> src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
>     (global) is DE
> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
> src/netdev.c:netdev_disconnect_event()
> Received Deauthentication event, reason: 2, from_ap: false
> src/station.c:station_disconnect_event() 3
> src/station.c:station_disassociated() 3
> src/station.c:station_enter_state() Old State: connecting, new state:
> disconnected=00

I could imagine, that there is still a kernel module missing, but this is j=
ust =

guessing. Any hints how to continue debugging?

I still think that iwd would be a good match for the Raspberry Pi and ideal=
ly =

after this issue is fixed most Raspberry Pi user can switch to iwd if they =

like.

Kind regards
Patrick

--===============6982313830241120388==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUFCQ2dBZEZpRUU4Sm9qVkkrY0ZY
MWsxRTdZSEdndTErVEpCZUFGQWw5S1VSOEFDZ2tRSEdndTErVEoKQmVBTVlSQUF4VWdMeklJY1B6
cEczNUtScE92ancyUCtxWHd6WmhGRzVzcmdmdmlZNis5bHRMVDV2cXE3WnFrawphZHRrR0Nid3dn
am54T0hNM0FuZ1RJaWJ6LzhEOW0xUHFseDMxMWVDQjZxMWRTdnNMQ0VXMkJDNXNaMkYxUUtpCnpB
c2RtaVdmUFdhOHVLQy84elk4Vk9paUUxT3dxZWdVQmpzcnU5a1hxWWJpYmdGZWJBelNyT2ZkcjVC
cU9TQmsKa1dSRitiSnR2TUd2N2llMWJJTk90ZUlsSWpFMXg5dDhwbGtCMXBUeTJ3VWJBemlPOEFX
ZWhyc0JObmE5N1JlTApCYTZYeGRhejI4S3prdzdWVTJLZ1N3UjgvclVyMmNVY3lXR3IrU1E1aUJm
NXZNZ3RraC8xOHp2Uk1ETVZUb0hqCnJsaE5qTXhZZHFrV21DaHVjRGFrV3JKVW9hK0U0MUhDdzM4
cnRmY01TKzFUTjJnOGh5WGNrQVQ2V1B5RkMvRm4KbGZOWkRDelI0dFJXVDFqM0dyN29lTk5IR3pD
aTBCZjJEbVptRWNTczUyZGEzeHBCaU9YSThyKzN5bTRrazdiOAp4bXd3WVhoUTZhYXdOeGtYc0xB
SkgyNmp5UTNFMkx0VTVxTkdKQUMvSEwyRWxuUDNQY1lmQmdpTlgzdzhwR2JLClhyOCtXQTdCMzJC
Sm40YmZvb2U4YkJaekZCWEhLWHA2MEhWMTRJdHlTYUZJdXRDdmt3cjh4eThhMm9oZzJQOWcKN3lJ
c1hXWnd4bDZwV1hPb1FQa3pQc1QxTE8vWGtCZmpldDczcUQ0S3NPTDZQOWsxNHdhM3hycnBOTWpa
UVI5cwpxcWkrSFZPTTBZS3dnTG9RVCtoWmQwNGlXOHFjNFY2Tk9BR2JJOHQ2ZENKQncyeHI1bWM9
Cj1vR0hTCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============6982313830241120388==--

