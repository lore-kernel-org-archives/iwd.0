Content-Type: multipart/mixed; boundary="===============7250186944219831258=="
MIME-Version: 1.0
From: hector@ikatu.com
Subject: Interface not detected sometimes
Date: Tue, 04 Feb 2020 14:54:17 +0000
Message-ID: <20200204145417.2820.29060@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7250186944219831258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm using iwd 1.4 with connman on my embedded system. I need to delay the i=
wd.service some seconds in order to make it work all the times. When it doe=
sn't work I don't see any interface listed using "iwctl device list".

The differences in the logs of an initialization that works and one that do=
esn't are:

In the case where it works this functions are being called:
../git/src/manager.c:manager_interface_dump_callback()
../git/src/manager.c:manager_get_interface_cb()
../git/src/manager.c:manager_interface_dump_callback()
../git/src/manager.c:manager_get_interface_cb()

In the case where it doesn't work this event is logged at the beginning:
 ../git/src/manager.c:manager_config_notify() Notification of command New W=
iphy(3)

Here are the full logs of both initializations with debug enabled:

####### Good initialization #######
/lib/systemd/network/80-iwd.link:5: Failed to parse interface name policy, =
ignoring: keep
Mounting Bind mount for /var/lib/iwd...
Mounted Bind mount for /var/lib/iwd.
Wireless daemon version 1.4
../git/src/main.c:main() Using configuration directory /etc/iwd
../git/src/storage.c:storage_create_dirs() Using state directory /var/lib/i=
wd
../git/src/main.c:nl80211_appeared() Found nl80211 interface
../git/src/module.c:iwd_modules_init()
../git/src/netdev.c:netdev_init() Opening route netlink socket
netconfig: Network configuration is disabled.
../git/src/wsc.c:wsc_init()
../git/src/knownnetworks.c:known_network_frequencies_load() No known freque=
ncy file found.
../git/src/eap.c:__eap_method_enable()
../git/src/eap-wsc.c:eap_wsc_init()
../git/src/eap-md5.c:eap_md5_init()
../git/src/eap-tls.c:eap_tls_init()
../git/src/eap-ttls.c:eap_ttls_init()
../git/src/eap-mschapv2.c:eap_mschapv2_init()
../git/src/eap-sim.c:eap_sim_init()
../git/src/eap-aka.c:eap_aka_prime_init()
../git/src/eap-aka.c:eap_aka_init()
../git/src/eap-peap.c:eap_peap_init()
../git/src/eap-gtc.c:eap_gtc_init()
../git/src/eap-pwd.c:eap_pwd_init()
../git/src/manager.c:manager_wiphy_dump_callback()
Wiphy phy0 will only use the default interface
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_interface_dump_callback()
../git/src/manager.c:manager_get_interface_cb()
../git/src/manager.c:manager_interface_dump_callback()
../git/src/manager.c:manager_get_interface_cb()
Wiphy: 0, Name: phy0
        Permanent Address: 10:98:c3:ff:f6:9d
        Bands: 2.4 GHz 5 GHz
        Ciphers: CCMP TKIP BIP
        Supported iftypes: ad-hoc station ap p2p-client p2p-go p2p-device
../git/src/manager.c:manager_use_default()
../git/src/netdev.c:netdev_create_from_genl() Created interface wlan0[3 1]
../git/src/netdev.c:netdev_cqm_rssi_update()
../git/src/netdev.c:netdev_link_notify() event 16 on ifindex 3
../git/src/netdev.c:netdev_set_4addr() netdev: 3 use_4addr: 0
../git/src/netdev.c:netdev_initial_up_cb() Interface 3 initialized
../git/src/station.c:station_enter_state() Old State: disconnected, new sta=
te: autoconnect_quick
../git/src/station.c:station_enter_state() Old State: disconnected, new sta=
te: autoconnect_full
../git/src/scan.c:scan_periodic_start() Starting periodic scan for wdev 1
../git/src/netdev.c:netdev_link_notify() event 16 on ifindex 3
../git/src/netdev.c:netdev_link_notify() event 16 on ifindex 3
../git/src/scan.c:scan_notify() Scan notification Trigger Scan(33)
../git/src/scan.c:scan_request_triggered()
../git/src/scan.c:scan_request_triggered() Passive scan triggered for wdev 1
../git/src/scan.c:scan_periodic_triggered() Periodic scan triggered for wde=
v 1
../git/src/netdev.c:netdev_link_notify() event 16 on ifindex 2
../git/src/agent.c:agent_register() agent register called
../git/src/agent.c:agent_register() agent :1.5 path /net/connman/iwd_agent
../git/src/scan.c:scan_notify() Scan notification New Scan Results(34)
../git/src/netdev.c:netdev_link_notify() event 16 on ifindex 3
../git/src/scan.c:get_scan_callback() get_scan_callback
../git/src/scan.c:scan_parse_bss_information_elements() Load: 14/255
../git/src/scan.c:get_scan_callback() get_scan_callback
../git/src/scan.c:scan_parse_bss_information_elements() Load: 31/255
../git/src/scan.c:get_scan_callback() get_scan_callback
../git/src/scan.c:scan_parse_bss_information_elements() Load: 4/255
../git/src/scan.c:get_scan_callback() get_scan_callback
../git/src/scan.c:scan_parse_bss_information_elements() Load: 4/255
../git/src/scan.c:get_scan_callback() get_scan_callback
(...)

###########################################################################=
######
####### Bad initialization #######
/lib/systemd/network/80-iwd.link:5: Failed to parse interface name policy, =
ignoring: keep
Mounting Bind mount for /var/lib/iwd...
Mounted Bind mount for /var/lib/iwd.
Wireless daemon version 1.4
../git/src/main.c:main() Using configuration directory /etc/iwd
../git/src/storage.c:storage_create_dirs() Using state directory /var/lib/i=
wd
../git/src/main.c:nl80211_appeared() Found nl80211 interface
../git/src/module.c:iwd_modules_init()
../git/src/netdev.c:netdev_init() Opening route netlink socket
netconfig: Network configuration is disabled.
../git/src/wsc.c:wsc_init()
../git/src/knownnetworks.c:known_network_frequencies_load() No known freque=
ncy file found.
../git/src/eap.c:__eap_method_enable()
../git/src/eap-wsc.c:eap_wsc_init()
../git/src/eap-md5.c:eap_md5_init()
../git/src/eap-tls.c:eap_tls_init()
../git/src/eap-ttls.c:eap_ttls_init()
../git/src/eap-mschapv2.c:eap_mschapv2_init()
../git/src/eap-sim.c:eap_sim_init()
../git/src/eap-aka.c:eap_aka_prime_init()
../git/src/eap-aka.c:eap_aka_init()
../git/src/eap-peap.c:eap_peap_init()
../git/src/eap-gtc.c:eap_gtc_init()
../git/src/eap-pwd.c:eap_pwd_init()
../git/src/manager.c:manager_config_notify() Notification of command New Wi=
phy(3)
../git/src/manager.c:manager_new_wiphy_event()
../git/src/manager.c:manager_wiphy_dump_callback()
Wiphy phy0 will only use the default interface
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/wiphy.c:parse_supported_frequencies()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/wiphy.c:parse_supported_bands()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
../git/src/manager.c:manager_wiphy_dump_callback()
../git/src/wiphy.c:wiphy_update_from_genl()
Wiphy: 0, Name: phy0
        Permanent Address: 10:98:c3:ff:f6:9d
        Bands: 2.4 GHz 5 GHz
        Ciphers: CCMP TKIP BIP
        Supported iftypes: ad-hoc station ap p2p-client p2p-go p2p-device
../git/src/manager.c:manager_use_default()
No default interface for wiphy 0
../git/src/manager.c:manager_config_notify() Notification of command New In=
terface(7)
../git/src/netdev.c:netdev_link_notify() event 16 on ifindex 3
../git/src/netdev.c:netdev_link_notify() event 16 on ifindex 3
../git/src/manager.c:manager_config_notify() Notification of command New In=
terface(7)
../git/src/netdev.c:netdev_link_notify() event 16 on ifindex 4
../git/src/netdev.c:netdev_link_notify() event 16 on ifindex 4
../git/src/netdev.c:netdev_link_notify() event 16 on ifindex 4
../git/src/netdev.c:netdev_link_notify() event 16 on ifindex 4
../git/src/netdev.c:netdev_link_notify() event 16 on ifindex 3
../git/src/netdev.c:netdev_link_notify() event 16 on ifindex 4
../git/src/netdev.c:netdev_link_notify() event 16 on ifindex 2
../git/src/agent.c:agent_register() agent register called
../git/src/agent.c:agent_register() agent :1.5 path /net/connman/iwd_agent
../git/src/netdev.c:netdev_link_notify() event 16 on ifindex 2
###########################################################################=
######

Any inputs on what might be going on? Any other information I can provide y=
ou?

Thanks in advance!

Best regards,
Hector
--===============7250186944219831258==--

