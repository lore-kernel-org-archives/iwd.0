Content-Type: multipart/mixed; boundary="===============2629024652559636380=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd configure location and files
Date: Mon, 13 Dec 2021 15:39:17 +1100
Message-ID: <CAA=hcWTGQ4+9Vm+Srog0KtQ85R2-o61WT0uPjw+GwB=G9mrXMg@mail.gmail.com>
In-Reply-To: 8aa819a1-4fd4-b989-713b-6480d0dfd236@monom.org

--===============2629024652559636380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks all for your advice.

Further debugging it, it seems failing DHCP was caused by an error of
Deauthentication even, not clear if the iwd error caused mwifiex
disconnected from WiFi modem or the mwifiex cause iwd fall:

# ifconfig
wlan0     Link encap:Ethernet  HWaddr D4:CA:6E:A4:E8:B4
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:226 errors:0 dropped:0 overruns:0 frame:0
          TX packets:224 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:25538 (24.9 KiB)  TX bytes:30240 (29.5 KiB)

# systemctl status iwd -l
* iwd.service - Wireless service
     Loaded: loaded
(8;;file://solar/lib/systemd/system/iwd.service/lib/systemd/system/iwd.serv=
ice8;;;
enabled; vendor preset: enabled)
     Active: active (running) since Wed 2021-08-04 15:25:58 UTC; 8s ago
   Main PID: 345 (iwd)
     CGroup: /system.slice/iwd.service
             `-345 /usr/libexec/iwd

Aug 04 15:25:58 solar iwd[345]:                         54.0 Mbps
Aug 04 15:25:58 solar iwd[345]:                 HT Capabilities:
Aug 04 15:25:58 solar iwd[345]:                         HT20
Aug 04 15:25:58 solar iwd[345]:                         Short GI for 20Mhz
Aug 04 15:25:58 solar iwd[345]:                 HT RX MCS indexes:
Aug 04 15:25:58 solar iwd[345]:                         0-7
Aug 04 15:25:58 solar iwd[345]:                         32
Aug 04 15:25:58 solar iwd[345]:         Ciphers: CCMP TKIP BIP
Aug 04 15:25:58 solar iwd[345]:         Supported iftypes: station ap
p2p-client p2p-go
Aug 04 15:26:03 solar iwd[345]: Received Deauthentication event,
reason: 2, from_ap: true

[  931.528058] mwifiex_sdio mmc0:0001:1: info: successfully
disconnected from 34:08:04:12:b1:a2: reason code 2
[  933.540667] mwifiex_sdio mmc0:0001:1: info: trying to associate to
'JupiterIoT' bssid 34:08:04:12:b1:a2
[  933.564524] mwifiex_sdio mmc0:0001:1: info: associated to bssid
34:08:04:12:b1:a2 successfully
[  933.580086] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=
=3D0x2
[  933.611695] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=
=3D0x2
[  936.585096] mwifiex_sdio mmc0:0001:1: info: successfully
disconnected from 34:08:04:12:b1:a2: reason code 2
[  938.575824] mwifiex_sdio mmc0:0001:1: info: trying to associate to
'JupiterIoT' bssid 34:08:04:12:b1:a2
[  938.603801] mwifiex_sdio mmc0:0001:1: info: associated to bssid
34:08:04:12:b1:a2 successfully
[  938.618333] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=
=3D0x2
[  938.655173] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=
=3D0x2
[  941.619354] mwifiex_sdio mmc0:0001:1: info: successfully
disconnected from 34:08:04:12:b1:a2: reason code 2

I followed the document to enable all CRYPTO setup so I don't think it
is a CRYPTO configured issue in the kernel.

CONFIG_CRYPTO_USER_API_SKCIPHER=3Dy
CONFIG_CRYPTO_USER_API_HASH=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_CMAC=3Dy
CONFIG_CRYPTO_MD4=3Dy
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_SHA256=3Dy
CONFIG_CRYPTO_SHA512=3Dy
CONFIG_CRYPTO_AES=3Dy
CONFIG_CRYPTO_ECB=3Dy
CONFIG_CRYPTO_ARC4=3Dy
CONFIG_CRYPTO_DES=3Dy
CONFIG_CRYPTO_CBC=3Dy
CONFIG_KEY_DH_OPERATIONS=3Dy

Also searching the Internet to find someone added
ControlPortOverNL80211=3DFalse to resolve that issue on kernel 5.9.2,
but it did not work on my kernel 5.10.59:

# cat /etc/iwd/main.conf
[General]
EnableNetworkConfiguration=3DTrue
ControlPortOverNL80211=3DFalse

The other issue is the error from_ap, but I am connecting to a home
WiFi modem, it should use a station, not ap, right? Or doesn't matter?

Thanks for your advice.

Kind regards,

Jupiter
--===============2629024652559636380==--

