Content-Type: multipart/mixed; boundary="===============9110916960813244086=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd configure location and files
Date: Tue, 30 Nov 2021 14:46:50 -0800
Message-ID: <0e7ab80d46b3e138910af83e5ba138fcb3178a92.camel@gmail.com>
In-Reply-To: CAA=hcWTdHD1ez3vVCpdn4ZQB3njpnQ7DG_sO8cB3oD3E8sYDEg@mail.gmail.com

--===============9110916960813244086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-12-01 at 09:38 +1100, Jupiter wrote:
> Hi James and Denis,
> =

> > Alternatively you could put a file inside /var/lib/iwd which would
> > let
> > autoconnect work (though you'll hit the same issue you previously saw
> > most likely):
> > =

> > /var/lib/iwd/JupiterIoT.psk
> > =

> > [Security]
> > Passphrase=3D<your passphrase>
> =

> That is much handy, seems it could be connected now, here is log
> copied from debug console:

Glad that worked. Still strange you couldn't do this via iwctl though
if connman really wasn't running.

> =

> # /usr/libexec/iwd -d 'station*'
> ................
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ciphers: CCMP TKIP BIP
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Supported iftypes: station ap =
p2p-client p2p-go
> ../iwd-1.19/src/station.c:station_enter_state() Old State:
> disconnected, new state: autoconnect_quick
> ../iwd-1.19/src/station.c:station_quick_scan_triggered() Quick scan
> triggered for wlan0
> ../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
> '34:08:04:12:b1:a2' with SSID: JupiterIoT, freq: 2437, rank: 2722,
> strength: -6500, data_rate: 81.0
> ../iwd-1.19/src/station.c:station_add_seen_bss() Added new Network
> "JupiterIoT" security psk
> ../iwd-1.19/src/station.c:station_autoconnect_start()
> ../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
> Trying SSID: JupiterIoT
> ../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
> '34:08:04:12:b1:a2' freq: [ 6810.737092] mwifiex_sdio mmc0:0001:1:
> info: trying to associate to 'JupiterIoT' bssid 34:08:04:12:b2
> 2437, rank: 2722, strength: -6500
> ../iwd-1.19/src/station.c:station_enter_state() Old State:
> autoconnect_quick, new state: connecting (auto)
> [ 6810.842559] mwifiex_sdio mmc0:0001:1: info: associated to bssid
> 34:08:04:12:b1:a2 successfully
> [ 6810.855015] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error,
> result=3D0x2
> ../iwd-1.19/src/station.c:station_netdev_event() Associating
> [ 6810.899100] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error,
> result=3D0x2
> [ 6810.937171] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error,
> result=3D0x2
> ../iwd-1.19/src/station.c:station_handshake_event() Setting keys
> hardware_rekey not supported
> ../iwd-1.19/src/station.c:station_connect_cb() 12, result: 0
> ../iwd-1.19/src/station.c:station_connect_ok()
> =

> But there is no IP address, I guess iwd manages DHCP, how can I debug
> iwd DHCP?

IWD can manage DHCP, and this works nicely but it is not required (you
could use conventional daemons for this, systemd, dhclient etc). If you
want IWD to do DHCP you can enable this in /etc/iwd/main.conf:

[General]
EnableNetworkConfiguration=3DTrue

> =

> # ifconfig
> wlan0=C2=A0=C2=A0=C2=A0=C2=A0 Link encap:Ethernet=C2=A0 HWaddr D4:CA:6E:A=
4:E8:B4
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UP BROADCAST RUNNI=
NG MULTICAST=C2=A0 MTU:1500=C2=A0 Metric:1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX packets:10 erro=
rs:0 dropped:0 overruns:0 frame:0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TX packets:33 erro=
rs:0 dropped:0 overruns:0 carrier:0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 collisions:0 txque=
uelen:1000
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX bytes:1650 (1.6=
 KiB)=C2=A0 TX bytes:9106 (8.8 KiB)
> =

> > Are you running connman + iwd?=C2=A0 Are you sure ConnMan isn't aborting
> > the
> > connection?=C2=A0 Have you tried using connmanctl or using iwd + iwctl
> > with
> > connman
> > not running?
> =

> Yes, I was running connman + iwd, but I did stop connman in iwd
> debugging.
> =

> > We do need iwd logs and preferably iwmon logs.=C2=A0 You may need to bu=
ild
> > nlmon
> > =

> > support into your kernel if iwmon doesn't start.=C2=A0 e.g. CONFIG_NLMO=
N=3Dm
> > or y
> =

> Ahh, that was missing in defconfig, I am rebuilding it now, will run
> iwmon and post iwmon log.
> =

> Thank you very much.
> =

> Kind regards,
> =

> - jupiter
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============9110916960813244086==--

