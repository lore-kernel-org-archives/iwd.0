Content-Type: multipart/mixed; boundary="===============5145413655832580134=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd configure location and files
Date: Wed, 01 Dec 2021 08:29:27 +1100
Message-ID: <CAA=hcWTJ7ro79eEUw+YP4AVi0cMViuVFc0Vj=KvjxQxEFiN3xg@mail.gmail.com>
In-Reply-To: b786e77e9828625bb92a63d88630e5904234b920.camel@gmail.com

--===============5145413655832580134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

Thanks for your kind response and debug instructions.

> Without any debug logs this gonna be difficult to see whats going on.
> If you could enable debug logging when starting IWD and capture some
> logs that would give us a better idea of whats going on.
>
> https://iwd.wiki.kernel.org/debugging

Here is debugging:

# /usr/libexec/iwd -d 'station*' > iwd.log

$ sed -E "s/([0-9a-fA-F]{2}:?){6}/11:22:33:44:55:66/" iwd.log | sed -e
"s/SSID:\ .*, f/SSID: xxx f/" | sed 's/Added new Network .*
security/Added new Network "xxx" security/'
# /usr/libexec/iwd -d 'station*'
Wireless daemon version 1.19
Loaded configuration from /etc/iwd/main.conf
Wiphy: 0, Name: phy0
        Permanent Address: 11:22:33:44:55:66
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
                        HT20
                        Short GI for 20Mhz
                HT RX MCS indexes:
                        0-7
                        32
        Ciphers: CCMP TKIP BIP
        Supported iftypes: station ap p2p-client p2p-go
../iwd-1.19/src/station.c:station_enter_state() Old State:
disconnected, new state: autoconnect_quick
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'11:22:33:44:55:66' with SSID: xxx freq: 2437, rank: 2722, strength:
-6600, data_rate: 81.0
../iwd-1.19/src/station.c:station_add_seen_bss() Added new Network
"xxx" security psk
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'11:22:33:44:55:66' with SSID: xxx freq: 2412, rank: 67, strength:
-8700, data_rate: 2.0
../iwd-1.19/src/station.c:station_add_seen_bss() Added new Network
"xxx" security psk
../iwd-1.19/src/station.c:station_autoconnect_start()
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: JupiterIoT
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'11:22:33:44:55:66' freq: 2437, rank: 2722, strength: -6600
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: WiFi-F263_Ext 2
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'11:22:33:44:55:66' freq: 2412, rank: 67, strength: -8700
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'11:22:33:44:55:66' with SSID: xxx freq: 2437, rank: 4537, strength:
-5800, data_rate: 135.0
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'11:22:33:44:55:66' with SSID: xxx freq: 2412, rank: 67, strength:
-9400, data_rate: 2.0
../iwd-1.19/src/station.c:station_add_seen_bss() Added new Network
"xxx" security psk
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'11:22:33:44:55:66' with SSID: xxx freq: 2412, rank: 33, strength:
-8900, data_rate: 1.0
../iwd-1.19/src/station.c:station_autoconnect_start()
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: JupiterIoT
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'11:22:33:44:55:66' freq: 2437, rank: 4537, strength: -5800
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: WiFi-F263
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'11:22:33:44:55:66' freq: 2412, rank: 67, strength: -9400
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: WiFi-F263_Ext 2
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'11:22:33:44:55:66' freq: 2412, rank: 33, strength: -8900
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'11:22:33:44:55:66' with SSID: xxx freq: 2437, rank: 4537, strength:
-6000, data_rate: 135.0
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'11:22:33:44:55:66' with SSID: xxx freq: 2412, rank: 184, strength:
-8600, data_rate: 5.5
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'11:22:33:44:55:66' with SSID: xxx freq: 2412, rank: 67, strength:
-9500, data_rate: 2.0
../iwd-1.19/src/station.c:station_autoconnect_start()
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: JupiterIoT
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'11:22:33:44:55:66' freq: 2437, rank: 4537, strength: -6000
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: WiFi-F263_Ext 2
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'11:22:33:44:55:66' freq: 2412, rank: 184, strength: -8600
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: WiFi-F263
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'11:22:33:44:55:66' freq: 2412, rank: 67, strength: -9500
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'11:22:33:44:55:66' freq: 2417, rank: 67, strength: -9800
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)

It looks like it is missing network_autoconnect? How to configure that file?

# export IWD_TLS_DEBUG=3D1

# /usr/libexec/iwd -d

Wireless daemon version 1.19
../iwd-1.19/src/main.c:main() Using configuration directory /etc/iwd
Loaded configuration from /etc/iwd/main.conf
../iwd-1.19/src/storage.c:storage_create_dirs() Using state directory
/var/lib/iwd
../iwd-1.19/src/main.c:nl80211_appeared() Found nl80211 interface
../iwd-1.19/src/module.c:iwd_modules_init()
../iwd-1.19/src/wsc.c:wsc_init()
../iwd-1.19/src/knownnetworks.c:known_network_frequencies_load() No
known frequency file found.
../iwd-1.19/src/eap.c:__eap_method_enable()
../iwd-1.19/src/eap-wsc.c:eap_wsc_init()
../iwd-1.19/src/eap-md5.c:eap_md5_init()
../iwd-1.19/src/eap-tls.c:eap_tls_init()
../iwd-1.19/src/eap-ttls.c:eap_ttls_init()
../iwd-1.19/src/eap-mschapv2.c:eap_mschapv2_init()
../iwd-1.19/src/eap-sim.c:eap_sim_init()
../iwd-1.19/src/eap-aka.c:eap_aka_prime_init()
../iwd-1.19/src/eap-aka.c:eap_aka_init()
../iwd-1.19/src/eap-peap.c:eap_peap_init()
../iwd-1.19/src/eap-gtc.c:eap_gtc_init()
../iwd-1.19/src/eap-pwd.c:eap_pwd_init()
../iwd-1.19/src/manager.c:manager_wiphy_dump_callback() New wiphy phy0 adde=
d (0)
Wiphy: 0, Name: phy0
        Permanent Address: d4:ca:6e:a4:e8:b4
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
                        HT20
                        Short GI for 20Mhz
                HT RX MCS indexes:
                        0-7
                        32
        Ciphers: CCMP TKIP BIP
        Supported iftypes: station ap p2p-client p2p-go
../iwd-1.19/src/manager.c:manager_create_interfaces() creating wlan0
../iwd-1.19/src/wiphy.c:wiphy_update_reg_domain() New reg domain
country code for (global) is 00
../iwd-1.19/src/manager.c:manager_config_notify() Notification of
command New Interface(7)
../iwd-1.19/src/netdev.c:netdev_link_notify() event 16 on ifindex 8
../iwd-1.19/src/manager.c:manager_new_station_interface_cb()
../iwd-1.19/src/netdev.c:netdev_create_from_genl() Created interface wlan0[=
8 1]
../iwd-1.19/src/netdev.c:netdev_link_notify() event 16 on ifindex 8
../iwd-1.19/src/netdev.c:netdev_link_notify() event 16 on ifindex 8
../iwd-1.19/src/netdev.c:netdev_set_4addr() netdev: 8 use_4addr: 0
../iwd-1.19/src/netdev.c:netdev_initial_up_cb() Interface 8 initialized
../iwd-1.19/src/netconfig.c:netconfig_new() Starting netconfig for interfac=
e: 8
../iwd-1.19/src/station.c:station_enter_state() Old State:
disconnected, new state: autoconnect_quick
../iwd-1.19/src/scan.c:scan_periodic_start() Starting periodic scan for wde=
v 1
../iwd-1.19/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 1
../iwd-1.19/src/wiphy.c:wiphy_radio_work_next() Starting work item 1
../iwd-1.19/src/rrm.c:rrm_add_frame_watches()
../iwd-1.19/src/netdev.c:netdev_link_notify() event 16 on ifindex 8
../iwd-1.19/src/manager.c:manager_config_notify() Notification of
command Set Interface(6)
../iwd-1.19/src/scan.c:scan_notify() Scan notification Trigger Scan(33)
../iwd-1.19/src/scan.c:scan_request_triggered() Passive scan triggered
for wdev 1
../iwd-1.19/src/scan.c:scan_periodic_triggered() Periodic scan
triggered for wdev 1
../iwd-1.19/src/scan.c:scan_notify() Scan notification New Scan Results(34)
../iwd-1.19/src/scan.c:get_scan_callback() get_scan_callback
../iwd-1.19/src/scan.c:scan_parse_bss_information_elements() Load: 12/255
../iwd-1.19/src/scan.c:get_scan_callback() get_scan_callback
../iwd-1.19/src/scan.c:scan_parse_bss_information_elements() Load: 6/255
../iwd-1.19/src/scan.c:get_scan_done() get_scan_done
../iwd-1.19/src/scan.c:scan_periodic_rearm() Arming periodic scan timer: 10
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'34:08:04:12:b1:a2' with SSID: JupiterIoT, freq: 2437, rank: 2722,
strength: -6500, data_rate: 81.0
../iwd-1.19/src/station.c:station_add_seen_bss() Added new Network
"JupiterIoT" security psk
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'00:e0:20:17:16:eb' with SSID: WiFi-F263_Ext 2, freq: 2412, rank: 67,
strength: -8800, data_rate: 2.0
../iwd-1.19/src/station.c:station_add_seen_bss() Added new Network
"WiFi-F263_Ext 2" security psk
../iwd-1.19/src/station.c:station_autoconnect_start()
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: JupiterIoT
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'34:08:04:12:b1:a2' freq: 2437, rank: 2722, strength: -6500
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: WiFi-F263_Ext 2
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'00:e0:20:17:16:eb' freq: 2412, rank: 67, strength: -8800
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/wiphy.c:wiphy_radio_work_done() Work item 1 done
../iwd-1.19/src/netdev.c:netdev_link_notify() event 16 on ifindex 8
../iwd-1.19/src/scan.c:scan_periodic_timeout() scan_periodic_timeout: 1
../iwd-1.19/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
../iwd-1.19/src/wiphy.c:wiphy_radio_work_next() Starting work item 2
../iwd-1.19/src/scan.c:scan_notify() Scan notification Trigger Scan(33)
../iwd-1.19/src/scan.c:scan_request_triggered() Passive scan triggered
for wdev 1
../iwd-1.19/src/scan.c:scan_periodic_triggered() Periodic scan
triggered for wdev 1
../iwd-1.19/src/scan.c:scan_notify() Scan notification New Scan Results(34)
../iwd-1.19/src/scan.c:get_scan_callback() get_scan_callback
../iwd-1.19/src/scan.c:scan_parse_bss_information_elements() Load: 10/255
../iwd-1.19/src/scan.c:get_scan_callback() get_scan_callback
../iwd-1.19/src/scan.c:scan_parse_bss_information_elements() Load: 6/255
../iwd-1.19/src/scan.c:get_scan_callback() get_scan_callback
../iwd-1.19/src/scan.c:scan_parse_bss_information_elements() Load: 20/255
../iwd-1.19/src/scan.c:get_scan_done() get_scan_done
../iwd-1.19/src/scan.c:scan_periodic_rearm() Arming periodic scan timer: 20
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'34:08:04:12:b1:a2' with SSID: JupiterIoT, freq: 2437, rank: 4537,
strength: -5600, data_rate: 135.0
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'b0:95:75:98:f2:63' with SSID: WiFi-F263, freq: 2412, rank: 67,
strength: -9400, data_rate: 2.0
../iwd-1.19/src/station.c:station_add_seen_bss() Added new Network
"WiFi-F263" security psk
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'00:e0:20:17:16:eb' with SSID: WiFi-F263_Ext 2, freq: 2412, rank: 67,
strength: -9100, data_rate: 2.0
../iwd-1.19/src/station.c:station_autoconnect_start()
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: JupiterIoT
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'34:08:04:12:b1:a2' freq: 2437, rank: 4537, strength: -5600
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: WiFi-F263
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'b0:95:75:98:f2:63' freq: 2412, rank: 67, strength: -9400
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: WiFi-F263_Ext 2
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'00:e0:20:17:16:eb' freq: 2412, rank: 67, strength: -9100
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/wiphy.c:wiphy_radio_work_done() Work item 2 done
../iwd-1.19/src/netdev.c:netdev_link_notify() event 16 on ifindex 8
../iwd-1.19/src/scan.c:scan_periodic_timeout() scan_periodic_timeout: 1
../iwd-1.19/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 3
../iwd-1.19/src/wiphy.c:wiphy_radio_work_next() Starting work item 3
../iwd-1.19/src/scan.c:scan_notify() Scan notification Trigger Scan(33)
../iwd-1.19/src/scan.c:scan_request_triggered() Passive scan triggered
for wdev 1
../iwd-1.19/src/scan.c:scan_periodic_triggered() Periodic scan
triggered for wdev 1
../iwd-1.19/src/scan.c:scan_notify() Scan notification New Scan Results(34)
../iwd-1.19/src/scan.c:get_scan_callback() get_scan_callback
../iwd-1.19/src/scan.c:scan_parse_bss_information_elements() Load: 10/255
../iwd-1.19/src/scan.c:get_scan_callback() get_scan_callback
../iwd-1.19/src/scan.c:scan_parse_bss_information_elements() Load: 7/255
../iwd-1.19/src/scan.c:get_scan_callback() get_scan_callback
../iwd-1.19/src/scan.c:scan_parse_bss_information_elements() Load: 18/255
../iwd-1.19/src/scan.c:get_scan_callback() get_scan_callback
../iwd-1.19/src/scan.c:scan_parse_bss_information_elements() Load: 0/255
../iwd-1.19/src/scan.c:get_scan_done() get_scan_done
../iwd-1.19/src/scan.c:scan_periodic_rearm() Arming periodic scan timer: 40
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'34:08:04:12:b1:a2' with SSID: JupiterIoT, freq: 2437, rank: 3629,
strength: -6300, data_rate: 108.0
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'b0:95:75:98:f2:63' with SSID: WiFi-F263, freq: 2412, rank: 67,
strength: -9300, data_rate: 2.0
../iwd-1.19/src/station.c:station_add_seen_bss() Processing BSS
'00:e0:20:17:16:eb' with SSID: WiFi-F263_Ext 2, freq: 2412, rank: 67,
strength: -8800, data_rate: 2.0
../iwd-1.19/src/station.c:station_autoconnect_start()
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: JupiterIoT
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'34:08:04:12:b1:a2' freq: 2437, rank: 3629, strength: -6300
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: WiFi-F263
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'b0:95:75:98:f2:63' freq: 2412, rank: 67, strength: -9300
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'60:32:b1:a9:e8:4c' freq: 2417, rank: 67, strength: -9500
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
Trying SSID: WiFi-F263_Ext 2
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'00:e0:20:17:16:eb' freq: 2412, rank: 67, strength: -8800
../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
../iwd-1.19/src/wiphy.c:wiphy_radio_work_done() Work item 3 done
../iwd-1.19/src/netdev.c:netdev_link_notify() event 16 on ifindex 8

# iwmon
Wireless monitor ver 1.19
Failed to create monitor interface nlmon: Unknown error -95

Thank you very much.

Kind regards,

- jupiter
--===============5145413655832580134==--

