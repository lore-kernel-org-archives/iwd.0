Content-Type: multipart/mixed; boundary="===============2580194700558876192=="
MIME-Version: 1.0
From: Tmore1 <tmore1 at gmx.com>
To: iwd at lists.01.org
Subject: Enabling IPv6 causes immediate segfault on connect
Date: Wed, 10 Nov 2021 08:16:38 -0500
Message-ID: <20211110081638.8a1b690f39566ffce5f8f765@gmx.com>

--===============2580194700558876192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

After many years of managing wireless with Debian's ifupdown +
wpa_supplicant, I tried iwd, and I love it so far: I really appreciate
its polish, cleanliness, and responsiveness. Thanks much for this
software!

There seems to be a problem with its IPv6 support: on my system
(Debian Sid, iwd 1.19 from distro repo), iwd works perfectly out of the
box, and continues to work with "EnableNetworkConfiguration=3DTrue", but
with "EnableIPv6=3Dtrue", it segfaults immediately upon connect. (This is
especially awkward when iwd is being managed by systemd, since I then
get an endless loop of the daemon crashing and immediately restarting,
with a steady stream of messages hitting syslog ;))

FWIW, some Arch users have reported similar issues:

https://bugs.archlinux.org/task/71718

Here's my debug output:

*****

root(a)lila:~# /usr/libexec/iwd -d
Wireless daemon version 1.19
src/main.c:main() Using configuration directory /etc/iwd
Loaded configuration from /etc/iwd/main.conf
src/storage.c:storage_create_dirs() Using state directory /var/lib/iwd
src/main.c:nl80211_appeared() Found nl80211 interface
src/module.c:iwd_modules_init()
src/wsc.c:wsc_init()
src/resolve.c:resolve_resolvconf_init() Trying to find resolvconf in $PATH
src/resolve.c:resolve_resolvconf_init() resolvconf found as: /sbin/resolvco=
nf
src/eap.c:__eap_method_enable()
src/eap-wsc.c:eap_wsc_init()
src/eap-md5.c:eap_md5_init()
src/eap-tls.c:eap_tls_init()
src/eap-ttls.c:eap_ttls_init()
src/eap-mschapv2.c:eap_mschapv2_init()
src/eap-sim.c:eap_sim_init()
src/eap-aka.c:eap_aka_prime_init()
src/eap-aka.c:eap_aka_init()
src/eap-peap.c:eap_peap_init()
src/eap-gtc.c:eap_gtc_init()
src/eap-pwd.c:eap_pwd_init()
src/manager.c:manager_wiphy_dump_callback() New wiphy phy0 added (0)
Wiphy: 0, Name: phy0
	Permanent Address: xx:xx:xx:xx:xx:xx
	2.4Ghz Band:
		Bitrates (non-HT):
			 1.0 Mbps
			 2.0 Mbps
			 5.5 Mbps
			11.0 Mbps
			 6.0 Mbps
			 9.0 Mbps
			12.0 Mbps
			18.0 Mbps
			24.0 Mbps
			36.0 Mbps
			48.0 Mbps
			54.0 Mbps
		HT Capabilities:
			HT40
			Short GI for 20Mhz
			Short GI for 40Mhz
		HT RX MCS indexes:
			0-15
	5Ghz Band:
		Bitrates (non-HT):
			 6.0 Mbps
			 9.0 Mbps
			12.0 Mbps
			18.0 Mbps
			24.0 Mbps
			36.0 Mbps
			48.0 Mbps
			54.0 Mbps
		HT Capabilities:
			HT40
			Short GI for 20Mhz
			Short GI for 40Mhz
		HT RX MCS indexes:
			0-15
		VHT Capabilities:
			Short GI for 80Mhz
			Max RX MCS: 0-9 for NSS: 2
			Max TX MCS: 0-9 for NSS: 2
	Ciphers: CCMP TKIP BIP
	Supported iftypes: ad-hoc station ap p2p-client p2p-go p2p-device
src/manager.c:manager_create_interfaces() creating wlan0
src/manager.c:manager_create_interfaces() creating wlan0-p2p
src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for phy0 =
is US
src/manager.c:manager_config_notify() Notification of command New Interface=
(7)
src/netdev.c:netdev_link_notify() event 16 on ifindex 13
src/manager.c:manager_new_station_interface_cb()
src/netdev.c:netdev_create_from_genl() Created interface wlan0[13 a]
src/manager.c:manager_config_notify() Notification of command New Interface=
(7)
src/manager.c:manager_new_p2p_interface_cb()
src/p2p.c:p2p_device_update_from_genl() Created P2P device b
src/netdev.c:netdev_link_notify() event 16 on ifindex 13
src/wiphy.c:wiphy_reg_notify() Notification of command Wiphy Reg Change(113)
src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for phy0 =
is XX
src/netdev.c:netdev_set_4addr() netdev: 13 use_4addr: 0
src/netdev.c:netdev_initial_up_cb() Interface 13 initialized
src/netconfig.c:netconfig_new() Starting netconfig for interface: 13
src/station.c:station_enter_state() Old State: disconnected, new state: aut=
oconnect_quick
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 1
src/wiphy.c:wiphy_radio_work_next() Starting work item 1
src/rrm.c:rrm_add_frame_watches()
src/netdev.c:netdev_link_notify() event 16 on ifindex 13
src/netdev.c:netdev_link_notify() event 16 on ifindex 13
src/manager.c:manager_config_notify() Notification of command Set Interface=
(6)
src/scan.c:scan_notify() Scan notification Trigger Scan(33)
src/scan.c:scan_request_triggered() Active scan triggered for wdev a
src/station.c:station_quick_scan_triggered() Quick scan triggered for wlan0
src/wiphy.c:wiphy_reg_notify() Notification of command Wiphy Reg Change(113)
src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for phy0 =
is US
src/scan.c:scan_notify() Scan notification New Scan Results(34)
src/netdev.c:netdev_link_notify() event 16 on ifindex 13
src/scan.c:get_scan_callback() get_scan_callback
src/scan.c:scan_parse_bss_information_elements() Load: 0/255
src/scan.c:get_scan_callback() get_scan_callback
src/scan.c:scan_parse_bss_information_elements() Load: 66/255
src/scan.c:get_scan_callback() get_scan_callback
src/scan.c:scan_parse_bss_information_elements() Load: 212/255
src/scan.c:get_scan_callback() get_scan_callback
src/scan.c:scan_parse_bss_information_elements() Load: 43/255
src/scan.c:scan_parse_advertisement_protocol()
src/scan.c:get_scan_callback() get_scan_callback
src/scan.c:scan_parse_bss_information_elements() Load: 206/255
src/scan.c:get_scan_callback() get_scan_callback
src/scan.c:scan_parse_bss_information_elements() Load: 205/255
src/scan.c:get_scan_callback() get_scan_callback
src/scan.c:get_scan_callback() get_scan_callback
src/scan.c:get_scan_callback() get_scan_callback
src/scan.c:get_scan_callback() get_scan_callback
src/scan.c:scan_parse_bss_information_elements() Load: 68/255
src/scan.c:get_scan_callback() get_scan_callback
src/scan.c:get_scan_callback() get_scan_callback
src/scan.c:get_scan_callback() get_scan_callback
src/scan.c:scan_parse_bss_information_elements() Load: 19/255
src/scan.c:get_scan_done() get_scan_done

...

src/station.c:station_autoconnect_start()
src/station.c:station_autoconnect_next() autoconnect: Trying SSID: nnnnnnnn
src/station.c:station_autoconnect_next() autoconnect: 'xx:xx:xx:xx:xx:xx' f=
req: 5180, rank: 13107, strength: -6300
src/netdev.c:netdev_cqm_rssi_update()
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
src/station.c:__station_connect_network() connecting to BSS xx:xx:xx:xx:xx:=
xx
src/station.c:station_enter_state() Old State: autoconnect_quick, new state=
: connecting (auto)
src/scan.c:scan_cancel() Trying to cancel scan id 1 for wdev a
src/wiphy.c:wiphy_radio_work_done() Work item 1 done
src/wiphy.c:wiphy_radio_work_next() Starting work item 2
src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
src/station.c:station_netdev_event() Associating
src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
src/netdev.c:netdev_authenticate_event()
src/netdev.c:netdev_mlme_notify() MLME notification Associate(38)
src/netdev.c:netdev_associate_event()
src/netdev.c:netdev_link_notify() event 16 on ifindex 13
src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
src/netdev.c:netdev_connect_event()
src/netdev.c:netdev_link_notify() event 16 on ifindex 13
src/netdev.c:netdev_link_notify() event 16 on ifindex 13
src/netdev.c:netdev_get_oci_cb() Obtained OCI: freq: 5180, width: 3, center=
1: 5210, center2: 0
src/netdev.c:netdev_link_notify() event 16 on ifindex 13
src/netdev.c:netdev_unicast_notify() Unicast notification Control Port Fram=
e(129)
src/netdev.c:netdev_control_port_frame_event()
src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=3D13
src/netdev.c:netdev_mlme_notify() MLME notification Control Port TX Status(=
139)
src/netdev.c:netdev_unicast_notify() Unicast notification Control Port Fram=
e(129)
src/netdev.c:netdev_control_port_frame_event()
src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=3D13
src/netdev.c:netdev_set_gtk() 13
src/station.c:station_handshake_event() Setting keys
src/netdev.c:netdev_set_tk() 13
src/netdev.c:netdev_set_rekey_offload() 13
src/netdev.c:netdev_mlme_notify() MLME notification Control Port TX Status(=
139)
src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
src/station.c:station_connect_cb() 13, result: 0
src/station.c:station_connect_ok()
src/wiphy.c:wiphy_radio_work_done() Work item 2 done
src/netdev.c:netdev_link_notify() event 16 on ifindex 13
src/netconfig.c:netconfig_ifaddr_ipv6_added() ifindex 13: ifaddr fe80::1a5e=
:fff:fe82:bdec/64
Segmentation fault

*****

And here's syslog:

Nov  9 19:55:07 lila kernel: [  952.596320] wlan0: authenticated
Nov  9 19:55:07 lila kernel: [  952.597667] wlan0: associate with xx:xx:xx:=
xx:xx:xx (try 1/3)
Nov  9 19:55:07 lila kernel: [  952.601524] wlan0: RX AssocResp from xx:xx:=
xx:xx:xx:xx (capab=3D0x11 status=3D0 aid=3D1)
Nov  9 19:55:07 lila kernel: [  952.603444] wlan0: associated
Nov  9 19:55:07 lila kernel: [  952.655558] IPv6: ADDRCONF(NETDEV_CHANGE): =
wlan0: link becomes ready
Nov  9 19:55:08 lila avahi-daemon[771]: Joining mDNS multicast group on int=
erface wlan0.IPv6 with address fe80::1a5e:fff:fe82:bdec.
Nov  9 19:55:08 lila avahi-daemon[771]: New relevant interface wlan0.IPv6 f=
or mDNS.
Nov  9 19:55:08 lila avahi-daemon[771]: Registering new address record for =
fe80::1a5e:fff:fe82:bdec on wlan0.*.
Nov  9 19:55:08 lila kernel: [  953.801798] iwd[3276]: segfault at 0 ip 000=
07f3da1e5a231 sp 00007ffdbcbf18c8 error 4 in libc-2.32.so[7f3da1d21000+1490=
00]
Nov  9 19:55:08 lila kernel: [  953.801833] Code: 84 00 00 00 00 00 0f 1f 0=
0 31 c0 c5 f8 77 c3 66 2e 0f 1f 84 00 00 00 00 00 89 f9 48 89 fa c5 f9 ef c=
0 83 e1 3f 83 f9 20 77 1f <c5> fd 74 0f c5 fd d7 c1 85 c0 0f 85 df 00 00 00=
 48 83 c7 20 83 e1
Nov  9 19:55:08 lila kernel: [  953.841933] wlan0: deauthenticating from xx=
:xx:xx:xx:xx:xx by local choice (Reason: 3=3DDEAUTH_LEAVING)
Nov  9 19:55:08 lila avahi-daemon[771]: Interface wlan0.IPv6 no longer rele=
vant for mDNS.
Nov  9 19:55:08 lila avahi-daemon[771]: Leaving mDNS multicast group on int=
erface wlan0.IPv6 with address fe80::1a5e:fff:fe82:bdec.
Nov  9 19:55:08 lila avahi-daemon[771]: Withdrawing address record for fe80=
::1a5e:fff:fe82:bdec on wlan0.

Tmore1 <tmore1(a)gmx.com>
--===============2580194700558876192==--

