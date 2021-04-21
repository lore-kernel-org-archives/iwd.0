Content-Type: multipart/mixed; boundary="===============5674098482085981059=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: ap mode problem
Date: Wed, 21 Apr 2021 11:51:18 -0500
Message-ID: <CAG17S_NmBoT=1JLFw4CHY5zbmHfvv6TfOwdKOTs-g2BcqWaYWw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5674098482085981059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Group,

Trying to use ap mode on a USB dongle and having difficulty making a connec=
tion.

Kernel 5.10.27, iwd 1.13

This is the dongle:
[   29.109521] usb 1-1.5: New USB device found, idVendor=3D7392,
idProduct=3D7811, bcdDevice=3D 2.00
[   29.109575] usb 1-1.5: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[   29.109594] usb 1-1.5: Product: 802.11n WLAN Adapter
[   29.109608] usb 1-1.5: Manufacturer: Realtek
[   29.109622] usb 1-1.5: SerialNumber: 00e04c000001
...
[   53.336830] rtl8192cu: Chip version 0x10
[   53.878190] rtl8192cu: Board Type 0
[   53.878822] rtl_usb: rx_max_size 15360, rx_urb_num 8, in_ep 1
[   53.879097] rtl8192cu: Loading firmware rtlwifi/rtl8192cufw_TMSC.bin
[   53.879320] ieee80211 phy0: Selected rate control algorithm 'rtl_rc'
[   54.017808] usbcore: registered new interface driver rtl8192cu

I enabled AP mode from iwctl:
first setting the mode to AP then
"ap wlan0 start SSID password"

This is what is in the journal:
Apr 21 11:47:28 deskrune systemd[1]: Started Wireless service.
Apr 21 11:47:28 deskrune iwd[2298]: Wiphy: 0, Name: phy0
Apr 21 11:47:28 deskrune iwd[2298]:         Permanent Address: 80:1f:02:a2:=
d4:4c
Apr 21 11:47:28 deskrune iwd[2298]:         Bands: 2.4 GHz
Apr 21 11:47:28 deskrune iwd[2298]:         Ciphers: CCMP TKIP BIP
Apr 21 11:47:28 deskrune iwd[2298]:         Supported iftypes: ad-hoc
station ap p2p-client p2p-go
...
Apr 21 11:47:28 deskrune iwd[2298]: Wiphy phy0 will only use the
default interface
Apr 21 11:47:51 deskrune iwd[2298]: AP Probe Request from ae:53:10:32:ee:8a
Apr 21 11:47:51 deskrune iwd[2298]: AP Probe Response delivered OK
Apr 21 11:47:51 deskrune iwd[2298]: AP Authentication from ae:53:10:32:ee:8a
Apr 21 11:47:51 deskrune iwd[2298]: AP Authentication frame 2 ACKed by STA
Apr 21 11:47:51 deskrune iwd[2298]: AP Association Request from
ae:53:10:32:ee:8a
Apr 21 11:47:51 deskrune iwd[2298]: AP (Re)Association Response ACK received
Apr 21 11:47:52 deskrune iwd[2298]: 4-Way handshake failed for
ifindex: 3, reason: 15
Apr 21 11:47:54 deskrune iwd[2298]: AP Probe Request from b0:02:47:cc:83:f9
Apr 21 11:47:54 deskrune iwd[2298]: AP Probe Response delivered OK
Apr 21 11:47:54 deskrune iwd[2298]: AP Probe Request from b0:02:47:cc:83:f9
Apr 21 11:47:57 deskrune iwd[2298]: AP Probe Request from ee:b9:80:a7:13:81
Apr 21 11:47:57 deskrune iwd[2298]: AP Probe Response delivered OK
Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Request from b8:27:eb:18:74:9c
Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Response delivered OK
Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Request from b8:27:eb:18:74:9c
Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Request from b8:27:eb:18:74:9c
Apr 21 11:48:01 deskrune iwd[2298]: AP Deauthentication from
ae:53:10:32:ee:8a, reason 3

Is this incompatible? It works with hostapd/dnsmasq.

Keith
--===============5674098482085981059==--

