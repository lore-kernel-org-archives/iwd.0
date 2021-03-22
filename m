Content-Type: multipart/mixed; boundary="===============0657372034627338055=="
MIME-Version: 1.0
From: Yuri D'Elia <wavexx@thregr.org>
Subject: Can't connect to 8021x network
Date: Mon, 22 Mar 2021 12:51:59 +0100
Message-ID: <875z1jwgjx.fsf@wavexx.thregr.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0657372034627338055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone.

Recently my organization upgraded our APs to some Cisco C9115AXI-E from
some older 3500I (also Cisco).

iwd used to be able to connect, but not anymore. I can still connect
through wpa_supplicant, so I suspect an issue with iwd.

Configuration for the 8021x network is unchanged and as follows:

[Security]
EAP-Method=3DPEAP
EAP-Identity=3Da(a)b.c
EAP-PEAP-Phase2-Method=3DMSCHAPV2
EAP-PEAP-Phase2-Identity=3Da(a)b.c
EAP-PEAP-Phase2-Password=3Dxyz

When connecting with IWD_TLS_DEBUG=3D1 iwd -d, I normally see this just
after association:

src/station.c:station_enter_state() Old State: autoconnect_quick, new state=
: connecting
src/scan.c:scan_cancel() Trying to cancel scan id 1 for wdev 1b
src/wiphy.c:wiphy_radio_work_done() Work item 1 done
src/wiphy.c:wiphy_radio_work_next() Starting work item 2
src/netdev.c:netdev_link_notify() event 16 on ifindex 17
src/netdev.c:netdev_mac_power_down_cb() Setting generated address on
ifindex: 17 to: 22:2b:50:4b:ad:a2
src/wiphy.c:wiphy_reg_notify() Notification of command Wiphy Reg Change(113)
src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for phy0 =
is IT
src/netdev.c:netdev_link_notify() event 16 on ifindex 17
src/wiphy.c:wiphy_reg_notify() Notification of command Wiphy Reg Change(113)
src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for phy0 =
is XX
src/netdev.c:netdev_link_notify() event 16 on ifindex 17
src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
src/station.c:station_netdev_event() Associating
src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
src/netdev.c:netdev_authenticate_event() =

src/netdev.c:netdev_unicast_notify() Unicast notification 129
src/netdev.c:netdev_control_port_frame_event() =

src/netdev.c:netdev_mlme_notify() MLME notification Associate(38)
src/netdev.c:netdev_associate_event() =

src/netdev.c:netdev_link_notify() event 16 on ifindex 17
src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
src/netdev.c:netdev_connect_event() =

src/netdev.c:netdev_link_notify() event 16 on ifindex 17
src/netdev.c:netdev_link_notify() event 16 on ifindex 17
src/netdev.c:netdev_link_notify() event 16 on ifindex 17
src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
src/station.c:station_handshake_event() Handshaking
src/netdev.c:netdev_mlme_notify() MLME notification Unknown(139)
src/netdev.c:netdev_unicast_notify() Unicast notification 129
src/netdev.c:netdev_control_port_frame_event() =

4-Way handshake failed for ifindex: 17, reason: 15

I tried on iwd 1.12 and on the current master branch with the same
results.

By comparison, this is what I get with wpasupplicant:

wpa_supplicant[2755]: wlan0: Associated with 4c:a6:4d:54:09:4c
wpa_supplicant[2755]: wlan0: CTRL-EVENT-EAP-STARTED EAP authentication star=
ted
wpa_supplicant[2755]: wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
wpa_supplicant[2755]: wlan0: CTRL-EVENT-EAP-PROPOSED-METHOD vendor=3D0 meth=
od=3D25
wpa_supplicant[2755]: wlan0: CTRL-EVENT-EAP-METHOD EAP vendor 0 method 25 (=
PEAP) selected
wpa_supplicant[2755]: wlan0: CTRL-EVENT-EAP-PEER-CERT depth=3D1
subject=3D'x'
hash=3Dbeb8efe9b1a73c841b375a90e5fff8048848e3a2af66f6c4dd7b938d6fe8c5d8
wpa_supplicant[2755]: wlan0: CTRL-EVENT-EAP-PEER-CERT depth=3D0
subject=3D'x'
hash=3Dd0950f9a0ce38786be39d826d2398c02a4d3302cb9bb21e755f6e15fbf7fd248
wpa_supplicant[2755]: wlan0: CTRL-EVENT-EAP-PEER-ALT depth=3D0 DNS:a
wpa_supplicant[2755]: wlan0: CTRL-EVENT-EAP-PEER-ALT depth=3D0 DNS:b
wpa_supplicant[2755]: wlan0: CTRL-EVENT-EAP-PEER-ALT depth=3D0 DNS:c
wpa_supplicant[2755]: EAP-MSCHAPV2: Authentication succeeded
wpa_supplicant[2755]: EAP-TLV: TLV Result - Success - EAP-TLV/Phase2 Comple=
ted
wpa_supplicant[2755]: wlan0: CTRL-EVENT-EAP-SUCCESS EAP authentication
completed successfully
wpa_supplicant[2755]: wlan0: PMKSA-CACHE-ADDED 4c:a6:4d:54:09:4c 0
wpa_supplicant[2755]: wlan0: WPA: Key negotiation completed with
4c:a6:4d:54:09:4c [PTK=3DCCMP GTK=3DCCMP]
wpa_supplicant[2755]: wlan0: CTRL-EVENT-CONNECTED - Connection to
4c:a6:4d:54:09:4c completed [id=3D0 id_str=3D]
--===============0657372034627338055==--

