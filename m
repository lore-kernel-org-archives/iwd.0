Content-Type: multipart/mixed; boundary="===============6921509779981574706=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd configure location and files
Date: Wed, 01 Dec 2021 09:38:19 +1100
Message-ID: <CAA=hcWTdHD1ez3vVCpdn4ZQB3njpnQ7DG_sO8cB3oD3E8sYDEg@mail.gmail.com>
In-Reply-To: d899ecf8-deb2-f526-c20f-0fd80aba9841@gmail.com

--===============6921509779981574706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James and Denis,

> Alternatively you could put a file inside /var/lib/iwd which would let
> autoconnect work (though you'll hit the same issue you previously saw
> most likely):
>
> /var/lib/iwd/JupiterIoT.psk
>
> [Security]
> Passphrase=3D<your passphrase>

That is much handy, seems it could be connected now, here is log
copied from debug console:

# /usr/libexec/iwd -d 'station*'
................

        Ciphers: CCMP TKIP BIP
        Supported iftypes: station ap p2p-client p2p-go
../iwd-1.19/src/station.c:station_enter_state() Old State:
disconnected, new state: autoconnect_quick
../iwd-1.19/src/station.c:station_quick_scan_triggered() Quick scan
triggered for wlan0
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'34:08:04:12:b1:a2' with SSID: JupiterIoT, freq: 2437, rank: 2722,
strength: -6500, data_rate: 81.0
../iwd-1.19/src/station.c:station_add_seen_bss() Added new Network
"JupiterIoT" security psk
../iwd-1.19/src/station.c:station_autoconnect_start()
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: JupiterIoT
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'34:08:04:12:b1:a2' freq: [ 6810.737092] mwifiex_sdio mmc0:0001:1:
info: trying to associate to 'JupiterIoT' bssid 34:08:04:12:b2
2437, rank: 2722, strength: -6500
../iwd-1.19/src/station.c:station_enter_state() Old State:
autoconnect_quick, new state: connecting (auto)
[ 6810.842559] mwifiex_sdio mmc0:0001:1: info: associated to bssid
34:08:04:12:b1:a2 successfully
[ 6810.855015] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=
=3D0x2
../iwd-1.19/src/station.c:station_netdev_event() Associating
[ 6810.899100] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=
=3D0x2
[ 6810.937171] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=
=3D0x2
../iwd-1.19/src/station.c:station_handshake_event() Setting keys
hardware_rekey not supported
../iwd-1.19/src/station.c:station_connect_cb() 12, result: 0
../iwd-1.19/src/station.c:station_connect_ok()

But there is no IP address, I guess iwd manages DHCP, how can I debug iwd D=
HCP?

# ifconfig
wlan0     Link encap:Ethernet  HWaddr D4:CA:6E:A4:E8:B4
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:10 errors:0 dropped:0 overruns:0 frame:0
          TX packets:33 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1650 (1.6 KiB)  TX bytes:9106 (8.8 KiB)

> Are you running connman + iwd?  Are you sure ConnMan isn't aborting the
> connection?  Have you tried using connmanctl or using iwd + iwctl with
> connman
> not running?

Yes, I was running connman + iwd, but I did stop connman in iwd debugging.

> We do need iwd logs and preferably iwmon logs.  You may need to build nlm=
on
>
> support into your kernel if iwmon doesn't start.  e.g. CONFIG_NLMON=3Dm o=
r y

Ahh, that was missing in defconfig, I am rebuilding it now, will run
iwmon and post iwmon log.

Thank you very much.

Kind regards,

- jupiter
--===============6921509779981574706==--

