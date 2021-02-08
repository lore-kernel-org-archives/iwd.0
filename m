Content-Type: multipart/mixed; boundary="===============0663704044550155026=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Reconnect issues, still
Date: Sun, 07 Feb 2021 22:39:35 -0600
Message-ID: <CAG17S_MGPRQY9hP0m9OR-FBB2PT1yf=TO5MOaPaM=GeYkEDc4g@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0663704044550155026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The group at connman has re-written connman and it now leverages the
background scanning in iwd as it allows the setting of 'AutoConnect=3Dtrue'
now. That definitely helps, but I am still struggling to get the RPIs to
effortlessly reconnect. As it is, I have to manipulate the interface to
force a reconnect (if down/up) by running a script to check if the
interface is up or down.

For whatever reason, a reconnect is never tried unless we restart the iwd
or connman process or restart the interface. What I see is my android
devices reconnect in < 1 minute if I force a disconnect from the router or
restart the radio or reboot. I am running the latest git of iwd
(r5144.074bc52). I force disconnect from the router at 18:32. Then I wait.
spg3 is my SSID. It scans and 'sees' it but never initiates or tries a
re-connect. If I do this with my phone (Android 10), it is reconnected in
less than 2 minutes. If I let iwd control it, it reconnects in < 2 minutes
as well. Is there something that connman is waiting for to let connman know
it is ready?

disconnect at 18:43:38 and reconnect@18:45:06
Feb 07 18:43:27 rune64 iwd[2387]:
src/station.c:station_early_neighbor_report_cb() ifindex: 3, error:
-110(Connection timed out)
Feb 07 18:43:38 rune64 iwd[2387]: src/netdev.c:netdev_link_notify() event
16 on ifindex 3
Feb 07 18:43:38 rune64 iwd[2387]: src/netdev.c:netdev_link_notify() event
16 on ifindex 3
Feb 07 18:43:38 rune64 iwd[2387]: src/netdev.c:netdev_mlme_notify() MLME
notification Disconnect(48)
Feb 07 18:43:38 rune64 iwd[2387]: src/netdev.c:netdev_disconnect_event()
Feb 07 18:43:38 rune64 iwd[2387]: Received Deauthentication event, reason:
5, from_ap: false
Feb 07 18:43:38 rune64 iwd[2387]: src/station.c:station_disconnect_event() 3
Feb 07 18:43:38 rune64 iwd[2387]: src/station.c:station_disassociated() 3
Feb 07 18:43:38 rune64 iwd[2387]: src/resolve.c:resolve_systemd_revert()
ifindex: 3
Feb 07 18:43:38 rune64 iwd[2387]: WARNING:
src/resolve.c:resolve_systemd_revert() condition !systemd_state.is_ready
failed
Feb 07 18:43:38 rune64 iwd[2387]: src/station.c:station_enter_state() Old
State: connected, new state: disconnected
Feb 07 18:43:38 rune64 iwd[2387]: src/station.c:station_enter_state() Old
State: disconnected, new state: autoconnect_quick
Feb 07 18:43:38 rune64 iwd[2387]: src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 3
Feb 07 18:43:38 rune64 iwd[2387]: src/wiphy.c:wiphy_radio_work_next()
Starting work item 3
Feb 07 18:43:38 rune64 iwd[2387]:
src/netconfig.c:netconfig_ifaddr_deleted() ifaddr 192.168.2.41/24
Feb 07 18:43:38 rune64 iwd[2387]: src/wiphy.c:wiphy_reg_notify()
Notification of command Reg Change(36)
Feb 07 18:43:38 rune64 iwd[2387]: src/wiphy.c:wiphy_update_reg_domain() New
reg domain country code for (global) is XX
...
Feb 07 18:45:06 rune64 iwd[2387]: src/station.c:station_autoconnect_next()
Considering autoconnecting to BSS '08:02:8e:94:12:97' with SSID: spg3,
freq: 5180, rank: 13866, strength: -5000
Feb 07 18:45:06 rune64 iwd[2387]: src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 10
Feb 07 18:45:06 rune64 iwd[2387]: src/station.c:__station_connect_network()
connecting to BSS 08:02:8e:94:12:97
Feb 07 18:45:06 rune64 iwd[2387]: src/station.c:station_enter_state() Old
State: autoconnect_full, new state: connecting
Feb 07 18:45:06 rune64 iwd[2387]: src/scan.c:scan_periodic_stop() Stopping
periodic scan for wdev 1
Feb 07 18:45:06 rune64 iwd[2387]: src/scan.c:scan_cancel() Trying to cancel
scan id 9 for wdev 1
Feb 07 18:45:06 rune64 iwd[2387]: src/wiphy.c:wiphy_radio_work_done() Work
item 9 done
Feb 07 18:45:06 rune64 iwd[2387]: src/wiphy.c:wiphy_radio_work_next()
Starting work item 10
Feb 07 18:45:06 rune64 iwd[2387]: src/station.c:station_netdev_event()
Associating
Feb 07 18:45:06 rune64 iwd[2387]: src/netdev.c:netdev_mlme_notify() MLME
notification Connect(46)
Feb 07 18:45:06 rune64 iwd[2387]: src/netdev.c:netdev_connect_event()
Feb 07 18:45:06 rune64 iwd[2387]: src/eapol.c:eapol_handle_ptk_1_of_4()
ifindex=3D3
Feb 07 18:45:06 rune64 iwd[2387]: src/netdev.c:netdev_link_notify() event
16 on ifindex 3
Feb 07 18:45:06 rune64 iwd[2387]: src/netdev.c:netdev_link_notify() event
16 on ifindex 3
Feb 07 18:45:06 rune64 iwd[2387]: src/netdev.c:netdev_link_notify() event
16 on ifindex 3
Feb 07 18:45:06 rune64 iwd[2387]: src/netdev.c:netdev_link_notify() event
16 on ifindex 3
Feb 07 18:45:06 rune64 iwd[2387]: src/eapol.c:eapol_handle_ptk_3_of_4()
ifindex=3D3
Feb 07 18:45:06 rune64 iwd[2387]: src/netdev.c:netdev_set_gtk() 3
Feb 07 18:45:06 rune64 iwd[2387]: src/netdev.c:netdev_set_igtk() 3
Feb 07 18:45:06 rune64 iwd[2387]: src/station.c:station_handshake_event()
Setting keys
Feb 07 18:45:06 rune64 iwd[2387]: src/netdev.c:netdev_set_tk() 3
Feb 07 18:45:06 rune64 iwd[2387]: src/station.c:station_connect_cb() 3,
result: 0
Feb 07 18:45:06 rune64 iwd[2387]:
src/netconfig.c:netconfig_ipv6_select_and_install() IPV6 configuration
disabled
Feb 07 18:45:06 rune64 iwd[2387]: src/wiphy.c:wiphy_radio_work_done() Work
item 10 done
Feb 07 18:45:06 rune64 iwd[2387]: src/netdev.c:netdev_mlme_notify() MLME
notification Frame TX Status(60)
Feb 07 18:45:06 rune64 iwd[2387]: src/frame-xchg.c:frame_xchg_mlme_notify()
Received no ACK
Feb 07 18:45:06 rune64 iwd[2387]: src/netdev.c:netdev_link_notify() event
16 on ifindex 3
Feb 07 18:45:06 rune64 iwd[2387]:
src/netconfig.c:netconfig_ipv4_dhcp_event_handler() DHCPv4 event 0
Feb 07 18:45:06 rune64 iwd[2387]: src/netconfig.c:netconfig_ifaddr_added()
wlan0: ifaddr 192.168.2.41/24 broadcast 192.168.2.255

If I try the same thing with connman controlling it, it 'sees' the SSID,
but never triggers connman to reconnect. Should connman be looking for
something? If I restart iwd, it immediately connects. I get a ton of:
 src/station.c:station_add_seen_bss()
and it even reports my SSID, but it never connects until I reset the
interface or restart iwd.
Feb 07 18:54:17 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:17 rune64 iwd[265]: src/scan.c:get_scan_done() get_scan_done
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '08:02:8e:94:12:97' with SSID: spg3, freq: 5180, rank:
15209, strength: -5100
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '08:02:8e:94:12:98' with SSID: spg2, freq: 2462, rank: 5631,
strength: -4300
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '10:da:43:a0:f5:a4' with SSID: NETGEAR63, freq: 2462, rank:
3317, strength: -6500
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS 'ac:3a:7a:0c:83:0b' with SSID: , freq: 2462, rank: 3009,
strength: -6100
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss() BSS
has hidden SSID
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '24:4b:fe:24:a5:b8' with SSID: Virus, freq: 2412, rank:
2899, strength: -7100
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '6c:19:8f:ce:6f:a2' with SSID: Edventures3, freq: 5785,
rank: 2448, strength: -7300
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '6c:19:8f:ce:6f:a0' with SSID: Edventures, freq: 2412, rank:
2441, strength: -6800
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '40:2b:50:95:61:60' with SSID: ATTXIXISpi, freq: 2412, rank:
2322, strength: -7000
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '84:bb:69:71:19:30' with SSID: ElJefe, freq: 2437, rank:
2102, strength: -7200
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS 'a0:04:60:6c:4d:40' with SSID: HouseStark01, freq: 2442,
rank: 1571, strength: -8200
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '06:93:97:4e:01:43' with SSID: ATTxZIQ4wa, freq: 5805, rank:
936, strength: -8700
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '7e:ac:b9:55:92:a9' with SSID: , freq: 5745, rank: 792,
strength: -8900
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss() BSS
has hidden SSID
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '04:d9:f5:bb:b4:58' with SSID: HANNA, freq: 2427, rank:
1941, strength: -7800
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '06:93:97:09:ca:93' with SSID: ATTeHeTKI2, freq: 5765, rank:
1036, strength: -8800
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '74:ac:b9:55:92:a9' with SSID: Loading..., freq: 5745, rank:
936, strength: -8700
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '94:e3:6d:6a:96:aa' with SSID: Chime-6a96aa, freq: 2412,
rank: 270, strength: -8200
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '10:93:97:4e:01:40' with SSID: ATTxZIQ4wa, freq: 2412, rank:
1858, strength: -7500
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS '10:da:43:a0:f5:a5' with SSID: NETGEAR63-5G, freq: 5765,
rank: 1577, strength: -8200
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS 'f4:c1:14:b2:4d:8e' with SSID: BidenHarris, freq: 5240,
rank: 1296, strength: -8500
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS 'f6:c1:14:ba:4d:8b' with SSID: , freq: 5240, rank: 1296,
strength: -8500
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss() BSS
has hidden SSID
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss()
Processing BSS 'f6:c1:14:ba:4d:89' with SSID: , freq: 5240, rank: 1296,
strength: -8500
Feb 07 18:54:17 rune64 iwd[265]: src/station.c:station_add_seen_bss() BSS
has hidden SSID
Feb 07 18:54:17 rune64 iwd[265]: src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 19
Feb 07 18:54:17 rune64 iwd[265]: src/wiphy.c:wiphy_radio_work_done() Work
item 18 done
Feb 07 18:54:17 rune64 iwd[265]: src/wiphy.c:wiphy_radio_work_next()
Starting work item 19
Feb 07 18:54:17 rune64 iwd[265]: src/scan.c:scan_notify() Scan notification
Trigger Scan(33)
Feb 07 18:54:17 rune64 iwd[265]: src/scan.c:scan_request_triggered()
Passive scan triggered for wdev 1
Feb 07 18:54:17 rune64 iwd[265]:
src/station.c:station_dbus_scan_triggered() station_scan_triggered: 0
Feb 07 18:54:17 rune64 iwd[265]:
src/station.c:station_dbus_scan_triggered() Scan triggered for wlan0 subset
1
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:scan_notify() Scan notification
New Scan Results(34)
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 6/255
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 51/255
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 41/255
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 35/255
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 67/255
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 157/255
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 34/255
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 65/255
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 102/255
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 28/255
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 31/255
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 31/255
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 31/255
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_advertisement_protocol()
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 31/255
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 11/255
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_callback()
get_scan_callback
Feb 07 18:54:21 rune64 iwd[265]:
src/scan.c:scan_parse_bss_information_elements() Load: 11/255
Feb 07 18:54:21 rune64 iwd[265]: src/scan.c:get_scan_done() get_scan_done

It just repeats this over and over again until I either reset the interface
or restart either connman or iwd. How can I help to debug this? Is it a
kernel issue? What is the trigger that is supposed to get an external
process to negotiate the interface connection?

Keith

--===============0663704044550155026==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5UaGUgZ3JvdXAgYXQgY29ubm1hbiBoYXMgcmUtd3JpdHRlbiBj
b25ubWFuIGFuZCBpdCBub3cgbGV2ZXJhZ2VzIHRoZSBiYWNrZ3JvdW5kIHNjYW5uaW5nIGluIGl3
ZCBhcyBpdCBhbGxvd3MgdGhlIHNldHRpbmcgb2YgJiMzOTtBdXRvQ29ubmVjdD10cnVlJiMzOTsg
bm93LiBUaGF0IGRlZmluaXRlbHkgaGVscHMsIGJ1dCBJIGFtIHN0aWxsIHN0cnVnZ2xpbmcgdG8g
Z2V0IHRoZSBSUElzIHRvIGVmZm9ydGxlc3NseSByZWNvbm5lY3QuIEFzIGl0IGlzLCBJIGhhdmUg
dG8gbWFuaXB1bGF0ZSB0aGUgaW50ZXJmYWNlIHRvIGZvcmNlIGEgcmVjb25uZWN0IChpZiBkb3du
L3VwKSBieSBydW5uaW5nIGEgc2NyaXB0IHRvIGNoZWNrIGlmIHRoZSBpbnRlcmZhY2UgaXMgdXAg
b3IgZG93bi48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PgpGb3Igd2hhdGV2ZXIgcmVhc29uLCBh
IHJlY29ubmVjdCBpcyBuZXZlciB0cmllZCB1bmxlc3Mgd2UgcmVzdGFydCB0aGUgaXdkIG9yIGNv
bm5tYW4gcHJvY2VzcyBvciByZXN0YXJ0IHRoZSBpbnRlcmZhY2UuIFdoYXQgSSBzZWUgaXMgbXkg
YW5kcm9pZCBkZXZpY2VzIHJlY29ubmVjdCBpbiAmbHQ7IDEgbWludXRlIGlmIEkgZm9yY2UgYSBk
aXNjb25uZWN0IGZyb20gdGhlIHJvdXRlciBvciByZXN0YXJ0IHRoZSByYWRpbyBvciByZWJvb3Qu
IEkgYW0gcnVubmluZyB0aGUgbGF0ZXN0IGdpdCBvZiBpd2QgKHI1MTQ0LjA3NGJjNTIpLiBJIGZv
cmNlIGRpc2Nvbm5lY3QgZnJvbSB0aGUgcm91dGVyIGF0IDE4OjMyLiBUaGVuIEkgd2FpdC4gc3Bn
MyBpcyBteSBTU0lELiBJdCBzY2FucyBhbmQgJiMzOTtzZWVzJiMzOTsgaXQgYnV0IG5ldmVyIGlu
aXRpYXRlcyBvciB0cmllcyBhIHJlLWNvbm5lY3QuIElmIEkgZG8gdGhpcyB3aXRoIG15IHBob25l
IChBbmRyb2lkIDEwKSwgaXQgaXMgcmVjb25uZWN0ZWQgaW4gbGVzcyB0aGFuIDIgbWludXRlcy4g
SWYgSSBsZXQgaXdkIGNvbnRyb2wgaXQsIGl0IHJlY29ubmVjdHMgaW4gJmx0OyAyIG1pbnV0ZXMg
YXMgd2VsbC4gSXMgdGhlcmUgc29tZXRoaW5nIHRoYXQgY29ubm1hbiBpcyB3YWl0aW5nIGZvciB0
byBsZXQgY29ubm1hbiBrbm93IGl0IGlzIHJlYWR5PzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
ZGlzY29ubmVjdCBhdCAxODo0MzozOCBhbmQgcmVjb25uZWN0IGF0IDE4OjQ1OjA2PGJyPjwvZGl2
PjxkaXY+RmViIDA3IDE4OjQzOjI3IHJ1bmU2NCBpd2RbMjM4N106IHNyYy9zdGF0aW9uLmM6c3Rh
dGlvbl9lYXJseV9uZWlnaGJvcl9yZXBvcnRfY2IoKSBpZmluZGV4OiAzLCBlcnJvcjogLTExMChD
b25uZWN0aW9uIHRpbWVkIG91dCk8YnI+RmViIDA3IDE4OjQzOjM4IHJ1bmU2NCBpd2RbMjM4N106
IHNyYy9uZXRkZXYuYzpuZXRkZXZfbGlua19ub3RpZnkoKSBldmVudCAxNiBvbiBpZmluZGV4IDM8
YnI+RmViIDA3IDE4OjQzOjM4IHJ1bmU2NCBpd2RbMjM4N106IHNyYy9uZXRkZXYuYzpuZXRkZXZf
bGlua19ub3RpZnkoKSBldmVudCAxNiBvbiBpZmluZGV4IDM8YnI+RmViIDA3IDE4OjQzOjM4IHJ1
bmU2NCBpd2RbMjM4N106IHNyYy9uZXRkZXYuYzpuZXRkZXZfbWxtZV9ub3RpZnkoKSBNTE1FIG5v
dGlmaWNhdGlvbiBEaXNjb25uZWN0KDQ4KTxicj5GZWIgMDcgMTg6NDM6MzggcnVuZTY0IGl3ZFsy
Mzg3XTogc3JjL25ldGRldi5jOm5ldGRldl9kaXNjb25uZWN0X2V2ZW50KCk8YnI+RmViIDA3IDE4
OjQzOjM4IHJ1bmU2NCBpd2RbMjM4N106IFJlY2VpdmVkIERlYXV0aGVudGljYXRpb24gZXZlbnQs
IHJlYXNvbjogNSwgZnJvbV9hcDogZmFsc2U8YnI+RmViIDA3IDE4OjQzOjM4IHJ1bmU2NCBpd2Rb
MjM4N106IHNyYy9zdGF0aW9uLmM6c3RhdGlvbl9kaXNjb25uZWN0X2V2ZW50KCkgMzxicj5GZWIg
MDcgMTg6NDM6MzggcnVuZTY0IGl3ZFsyMzg3XTogc3JjL3N0YXRpb24uYzpzdGF0aW9uX2Rpc2Fz
c29jaWF0ZWQoKSAzPGJyPkZlYiAwNyAxODo0MzozOCBydW5lNjQgaXdkWzIzODddOiBzcmMvcmVz
b2x2ZS5jOnJlc29sdmVfc3lzdGVtZF9yZXZlcnQoKSBpZmluZGV4OiAzPGJyPkZlYiAwNyAxODo0
MzozOCBydW5lNjQgaXdkWzIzODddOiBXQVJOSU5HOiBzcmMvcmVzb2x2ZS5jOnJlc29sdmVfc3lz
dGVtZF9yZXZlcnQoKSBjb25kaXRpb24gIXN5c3RlbWRfc3RhdGUuaXNfcmVhZHkgZmFpbGVkPGJy
PkZlYiAwNyAxODo0MzozOCBydW5lNjQgaXdkWzIzODddOiBzcmMvc3RhdGlvbi5jOnN0YXRpb25f
ZW50ZXJfc3RhdGUoKSBPbGQgU3RhdGU6IGNvbm5lY3RlZCwgbmV3IHN0YXRlOiBkaXNjb25uZWN0
ZWQ8YnI+RmViIDA3IDE4OjQzOjM4IHJ1bmU2NCBpd2RbMjM4N106IHNyYy9zdGF0aW9uLmM6c3Rh
dGlvbl9lbnRlcl9zdGF0ZSgpIE9sZCBTdGF0ZTogZGlzY29ubmVjdGVkLCBuZXcgc3RhdGU6IGF1
dG9jb25uZWN0X3F1aWNrPGJyPkZlYiAwNyAxODo0MzozOCBydW5lNjQgaXdkWzIzODddOiBzcmMv
d2lwaHkuYzp3aXBoeV9yYWRpb193b3JrX2luc2VydCgpIEluc2VydGluZyB3b3JrIGl0ZW0gMzxi
cj5GZWIgMDcgMTg6NDM6MzggcnVuZTY0IGl3ZFsyMzg3XTogc3JjL3dpcGh5LmM6d2lwaHlfcmFk
aW9fd29ya19uZXh0KCkgU3RhcnRpbmcgd29yayBpdGVtIDM8YnI+RmViIDA3IDE4OjQzOjM4IHJ1
bmU2NCBpd2RbMjM4N106IHNyYy9uZXRjb25maWcuYzpuZXRjb25maWdfaWZhZGRyX2RlbGV0ZWQo
KSBpZmFkZHIgPGEgaHJlZj0iaHR0cDovLzE5Mi4xNjguMi40MS8yNCI+MTkyLjE2OC4yLjQxLzI0
PC9hPjxicj5GZWIgMDcgMTg6NDM6MzggcnVuZTY0IGl3ZFsyMzg3XTogc3JjL3dpcGh5LmM6d2lw
aHlfcmVnX25vdGlmeSgpIE5vdGlmaWNhdGlvbiBvZiBjb21tYW5kIFJlZyBDaGFuZ2UoMzYpPGJy
PkZlYiAwNyAxODo0MzozOCBydW5lNjQgaXdkWzIzODddOiBzcmMvd2lwaHkuYzp3aXBoeV91cGRh
dGVfcmVnX2RvbWFpbigpIE5ldyByZWcgZG9tYWluIGNvdW50cnkgY29kZSBmb3IgKGdsb2JhbCkg
aXMgWFg8L2Rpdj48ZGl2Pi4uLjxicj48L2Rpdj48ZGl2PkZlYiAwNyAxODo0NTowNiBydW5lNjQg
aXdkWzIzODddOiBzcmMvc3RhdGlvbi5jOnN0YXRpb25fYXV0b2Nvbm5lY3RfbmV4dCgpIENvbnNp
ZGVyaW5nIGF1dG9jb25uZWN0aW5nIHRvIEJTUyAmIzM5OzA4OjAyOjhlOjk0OjEyOjk3JiMzOTsg
d2l0aCBTU0lEOiBzcGczLCBmcmVxOiA1MTgwLCByYW5rOiAxMzg2Niwgc3RyZW5ndGg6IC01MDAw
PGJyPkZlYiAwNyAxODo0NTowNiBydW5lNjQgaXdkWzIzODddOiBzcmMvd2lwaHkuYzp3aXBoeV9y
YWRpb193b3JrX2luc2VydCgpIEluc2VydGluZyB3b3JrIGl0ZW0gMTA8YnI+RmViIDA3IDE4OjQ1
OjA2IHJ1bmU2NCBpd2RbMjM4N106IHNyYy9zdGF0aW9uLmM6X19zdGF0aW9uX2Nvbm5lY3RfbmV0
d29yaygpIGNvbm5lY3RpbmcgdG8gQlNTIDA4OjAyOjhlOjk0OjEyOjk3PGJyPkZlYiAwNyAxODo0
NTowNiBydW5lNjQgaXdkWzIzODddOiBzcmMvc3RhdGlvbi5jOnN0YXRpb25fZW50ZXJfc3RhdGUo
KSBPbGQgU3RhdGU6IGF1dG9jb25uZWN0X2Z1bGwsIG5ldyBzdGF0ZTogY29ubmVjdGluZzxicj5G
ZWIgMDcgMTg6NDU6MDYgcnVuZTY0IGl3ZFsyMzg3XTogc3JjL3NjYW4uYzpzY2FuX3BlcmlvZGlj
X3N0b3AoKSBTdG9wcGluZyBwZXJpb2RpYyBzY2FuIGZvciB3ZGV2IDE8YnI+RmViIDA3IDE4OjQ1
OjA2IHJ1bmU2NCBpd2RbMjM4N106IHNyYy9zY2FuLmM6c2Nhbl9jYW5jZWwoKSBUcnlpbmcgdG8g
Y2FuY2VsIHNjYW4gaWQgOSBmb3Igd2RldiAxPGJyPkZlYiAwNyAxODo0NTowNiBydW5lNjQgaXdk
WzIzODddOiBzcmMvd2lwaHkuYzp3aXBoeV9yYWRpb193b3JrX2RvbmUoKSBXb3JrIGl0ZW0gOSBk
b25lPGJyPkZlYiAwNyAxODo0NTowNiBydW5lNjQgaXdkWzIzODddOiBzcmMvd2lwaHkuYzp3aXBo
eV9yYWRpb193b3JrX25leHQoKSBTdGFydGluZyB3b3JrIGl0ZW0gMTA8YnI+RmViIDA3IDE4OjQ1
OjA2IHJ1bmU2NCBpd2RbMjM4N106IHNyYy9zdGF0aW9uLmM6c3RhdGlvbl9uZXRkZXZfZXZlbnQo
KSBBc3NvY2lhdGluZzxicj5GZWIgMDcgMTg6NDU6MDYgcnVuZTY0IGl3ZFsyMzg3XTogc3JjL25l
dGRldi5jOm5ldGRldl9tbG1lX25vdGlmeSgpIE1MTUUgbm90aWZpY2F0aW9uIENvbm5lY3QoNDYp
PGJyPkZlYiAwNyAxODo0NTowNiBydW5lNjQgaXdkWzIzODddOiBzcmMvbmV0ZGV2LmM6bmV0ZGV2
X2Nvbm5lY3RfZXZlbnQoKTxicj5GZWIgMDcgMTg6NDU6MDYgcnVuZTY0IGl3ZFsyMzg3XTogc3Jj
L2VhcG9sLmM6ZWFwb2xfaGFuZGxlX3B0a18xX29mXzQoKSBpZmluZGV4PTM8YnI+RmViIDA3IDE4
OjQ1OjA2IHJ1bmU2NCBpd2RbMjM4N106IHNyYy9uZXRkZXYuYzpuZXRkZXZfbGlua19ub3RpZnko
KSBldmVudCAxNiBvbiBpZmluZGV4IDM8YnI+RmViIDA3IDE4OjQ1OjA2IHJ1bmU2NCBpd2RbMjM4
N106IHNyYy9uZXRkZXYuYzpuZXRkZXZfbGlua19ub3RpZnkoKSBldmVudCAxNiBvbiBpZmluZGV4
IDM8YnI+RmViIDA3IDE4OjQ1OjA2IHJ1bmU2NCBpd2RbMjM4N106IHNyYy9uZXRkZXYuYzpuZXRk
ZXZfbGlua19ub3RpZnkoKSBldmVudCAxNiBvbiBpZmluZGV4IDM8YnI+RmViIDA3IDE4OjQ1OjA2
IHJ1bmU2NCBpd2RbMjM4N106IHNyYy9uZXRkZXYuYzpuZXRkZXZfbGlua19ub3RpZnkoKSBldmVu
dCAxNiBvbiBpZmluZGV4IDM8YnI+RmViIDA3IDE4OjQ1OjA2IHJ1bmU2NCBpd2RbMjM4N106IHNy
Yy9lYXBvbC5jOmVhcG9sX2hhbmRsZV9wdGtfM19vZl80KCkgaWZpbmRleD0zPGJyPkZlYiAwNyAx
ODo0NTowNiBydW5lNjQgaXdkWzIzODddOiBzcmMvbmV0ZGV2LmM6bmV0ZGV2X3NldF9ndGsoKSAz
PGJyPkZlYiAwNyAxODo0NTowNiBydW5lNjQgaXdkWzIzODddOiBzcmMvbmV0ZGV2LmM6bmV0ZGV2
X3NldF9pZ3RrKCkgMzxicj5GZWIgMDcgMTg6NDU6MDYgcnVuZTY0IGl3ZFsyMzg3XTogc3JjL3N0
YXRpb24uYzpzdGF0aW9uX2hhbmRzaGFrZV9ldmVudCgpIFNldHRpbmcga2V5czxicj5GZWIgMDcg
MTg6NDU6MDYgcnVuZTY0IGl3ZFsyMzg3XTogc3JjL25ldGRldi5jOm5ldGRldl9zZXRfdGsoKSAz
PGJyPkZlYiAwNyAxODo0NTowNiBydW5lNjQgaXdkWzIzODddOiBzcmMvc3RhdGlvbi5jOnN0YXRp
b25fY29ubmVjdF9jYigpIDMsIHJlc3VsdDogMDxicj5GZWIgMDcgMTg6NDU6MDYgcnVuZTY0IGl3
ZFsyMzg3XTogc3JjL25ldGNvbmZpZy5jOm5ldGNvbmZpZ19pcHY2X3NlbGVjdF9hbmRfaW5zdGFs
bCgpIElQVjYgY29uZmlndXJhdGlvbiBkaXNhYmxlZDxicj5GZWIgMDcgMTg6NDU6MDYgcnVuZTY0
IGl3ZFsyMzg3XTogc3JjL3dpcGh5LmM6d2lwaHlfcmFkaW9fd29ya19kb25lKCkgV29yayBpdGVt
IDEwIGRvbmU8YnI+RmViIDA3IDE4OjQ1OjA2IHJ1bmU2NCBpd2RbMjM4N106IHNyYy9uZXRkZXYu
YzpuZXRkZXZfbWxtZV9ub3RpZnkoKSBNTE1FIG5vdGlmaWNhdGlvbiBGcmFtZSBUWCBTdGF0dXMo
NjApPGJyPkZlYiAwNyAxODo0NTowNiBydW5lNjQgaXdkWzIzODddOiBzcmMvZnJhbWUteGNoZy5j
OmZyYW1lX3hjaGdfbWxtZV9ub3RpZnkoKSBSZWNlaXZlZCBubyBBQ0s8YnI+RmViIDA3IDE4OjQ1
OjA2IHJ1bmU2NCBpd2RbMjM4N106IHNyYy9uZXRkZXYuYzpuZXRkZXZfbGlua19ub3RpZnkoKSBl
dmVudCAxNiBvbiBpZmluZGV4IDM8YnI+PC9kaXY+PGRpdj5GZWIgMDcgMTg6NDU6MDYgcnVuZTY0
IGl3ZFsyMzg3XTogc3JjL25ldGNvbmZpZy5jOm5ldGNvbmZpZ19pcHY0X2RoY3BfZXZlbnRfaGFu
ZGxlcigpIERIQ1B2NCBldmVudCAwPGJyPkZlYiAwNyAxODo0NTowNiBydW5lNjQgaXdkWzIzODdd
OiBzcmMvbmV0Y29uZmlnLmM6bmV0Y29uZmlnX2lmYWRkcl9hZGRlZCgpIHdsYW4wOiBpZmFkZHIg
PGEgaHJlZj0iaHR0cDovLzE5Mi4xNjguMi40MS8yNCI+MTkyLjE2OC4yLjQxLzI0PC9hPiBicm9h
ZGNhc3QgMTkyLjE2OC4yLjI1NTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SWYgSSB0cnkgdGhl
IHNhbWUgdGhpbmcgd2l0aCBjb25ubWFuIGNvbnRyb2xsaW5nIGl0LCBpdCAmIzM5O3NlZXMmIzM5
OyB0aGUgU1NJRCwgYnV0IG5ldmVyIHRyaWdnZXJzIGNvbm5tYW4gdG8gcmVjb25uZWN0LiBTaG91
bGQgY29ubm1hbiBiZSBsb29raW5nIGZvciBzb21ldGhpbmc/IElmIEkgcmVzdGFydCBpd2QsIGl0
IGltbWVkaWF0ZWx5IGNvbm5lY3RzLiBJIGdldCBhIHRvbiBvZjo8L2Rpdj48ZGl2PsKgc3JjL3N0
YXRpb24uYzpzdGF0aW9uX2FkZF9zZWVuX2JzcygpPC9kaXY+PGRpdj5hbmQgaXQgZXZlbiByZXBv
cnRzIG15IFNTSUQsIGJ1dCBpdCBuZXZlciBjb25uZWN0cyB1bnRpbCBJIHJlc2V0IHRoZSBpbnRl
cmZhY2Ugb3IgcmVzdGFydCBpd2QuIDxicj48L2Rpdj48ZGl2PkZlYiAwNyAxODo1NDoxNyBydW5l
NjQgaXdkWzI2NV06IHNyYy9zY2FuLmM6Z2V0X3NjYW5fY2FsbGJhY2soKSBnZXRfc2Nhbl9jYWxs
YmFjazxicj5GZWIgMDcgMTg6NTQ6MTcgcnVuZTY0IGl3ZFsyNjVdOiBzcmMvc2Nhbi5jOmdldF9z
Y2FuX2RvbmUoKSBnZXRfc2Nhbl9kb25lPGJyPkZlYiAwNyAxODo1NDoxNyBydW5lNjQgaXdkWzI2
NV06IHNyYy9zdGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9ic3MoKSBQcm9jZXNzaW5nIEJTUyAm
IzM5OzA4OjAyOjhlOjk0OjEyOjk3JiMzOTsgd2l0aCBTU0lEOiBzcGczLCBmcmVxOiA1MTgwLCBy
YW5rOiAxNTIwOSwgc3RyZW5ndGg6IC01MTAwPGJyPkZlYiAwNyAxODo1NDoxNyBydW5lNjQgaXdk
WzI2NV06IHNyYy9zdGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9ic3MoKSBQcm9jZXNzaW5nIEJT
UyAmIzM5OzA4OjAyOjhlOjk0OjEyOjk4JiMzOTsgd2l0aCBTU0lEOiBzcGcyLCBmcmVxOiAyNDYy
LCByYW5rOiA1NjMxLCBzdHJlbmd0aDogLTQzMDA8YnI+RmViIDA3IDE4OjU0OjE3IHJ1bmU2NCBp
d2RbMjY1XTogc3JjL3N0YXRpb24uYzpzdGF0aW9uX2FkZF9zZWVuX2JzcygpIFByb2Nlc3Npbmcg
QlNTICYjMzk7MTA6ZGE6NDM6YTA6ZjU6YTQmIzM5OyB3aXRoIFNTSUQ6IE5FVEdFQVI2MywgZnJl
cTogMjQ2MiwgcmFuazogMzMxNywgc3RyZW5ndGg6IC02NTAwPGJyPkZlYiAwNyAxODo1NDoxNyBy
dW5lNjQgaXdkWzI2NV06IHNyYy9zdGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9ic3MoKSBQcm9j
ZXNzaW5nIEJTUyAmIzM5O2FjOjNhOjdhOjBjOjgzOjBiJiMzOTsgd2l0aCBTU0lEOiAsIGZyZXE6
IDI0NjIsIHJhbms6IDMwMDksIHN0cmVuZ3RoOiAtNjEwMDxicj5GZWIgMDcgMTg6NTQ6MTcgcnVu
ZTY0IGl3ZFsyNjVdOiBzcmMvc3RhdGlvbi5jOnN0YXRpb25fYWRkX3NlZW5fYnNzKCkgQlNTIGhh
cyBoaWRkZW4gU1NJRDxicj5GZWIgMDcgMTg6NTQ6MTcgcnVuZTY0IGl3ZFsyNjVdOiBzcmMvc3Rh
dGlvbi5jOnN0YXRpb25fYWRkX3NlZW5fYnNzKCkgUHJvY2Vzc2luZyBCU1MgJiMzOTsyNDo0Yjpm
ZToyNDphNTpiOCYjMzk7IHdpdGggU1NJRDogVmlydXMsIGZyZXE6IDI0MTIsIHJhbms6IDI4OTks
IHN0cmVuZ3RoOiAtNzEwMDxicj5GZWIgMDcgMTg6NTQ6MTcgcnVuZTY0IGl3ZFsyNjVdOiBzcmMv
c3RhdGlvbi5jOnN0YXRpb25fYWRkX3NlZW5fYnNzKCkgUHJvY2Vzc2luZyBCU1MgJiMzOTs2Yzox
OTo4ZjpjZTo2ZjphMiYjMzk7IHdpdGggU1NJRDogRWR2ZW50dXJlczMsIGZyZXE6IDU3ODUsIHJh
bms6IDI0NDgsIHN0cmVuZ3RoOiAtNzMwMDxicj5GZWIgMDcgMTg6NTQ6MTcgcnVuZTY0IGl3ZFsy
NjVdOiBzcmMvc3RhdGlvbi5jOnN0YXRpb25fYWRkX3NlZW5fYnNzKCkgUHJvY2Vzc2luZyBCU1Mg
JiMzOTs2YzoxOTo4ZjpjZTo2ZjphMCYjMzk7IHdpdGggU1NJRDogRWR2ZW50dXJlcywgZnJlcTog
MjQxMiwgcmFuazogMjQ0MSwgc3RyZW5ndGg6IC02ODAwPGJyPkZlYiAwNyAxODo1NDoxNyBydW5l
NjQgaXdkWzI2NV06IHNyYy9zdGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9ic3MoKSBQcm9jZXNz
aW5nIEJTUyAmIzM5OzQwOjJiOjUwOjk1OjYxOjYwJiMzOTsgd2l0aCBTU0lEOiBBVFRYSVhJU3Bp
LCBmcmVxOiAyNDEyLCByYW5rOiAyMzIyLCBzdHJlbmd0aDogLTcwMDA8YnI+RmViIDA3IDE4OjU0
OjE3IHJ1bmU2NCBpd2RbMjY1XTogc3JjL3N0YXRpb24uYzpzdGF0aW9uX2FkZF9zZWVuX2Jzcygp
IFByb2Nlc3NpbmcgQlNTICYjMzk7ODQ6YmI6Njk6NzE6MTk6MzAmIzM5OyB3aXRoIFNTSUQ6IEVs
SmVmZSwgZnJlcTogMjQzNywgcmFuazogMjEwMiwgc3RyZW5ndGg6IC03MjAwPGJyPkZlYiAwNyAx
ODo1NDoxNyBydW5lNjQgaXdkWzI2NV06IHNyYy9zdGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9i
c3MoKSBQcm9jZXNzaW5nIEJTUyAmIzM5O2EwOjA0OjYwOjZjOjRkOjQwJiMzOTsgd2l0aCBTU0lE
OiBIb3VzZVN0YXJrMDEsIGZyZXE6IDI0NDIsIHJhbms6IDE1NzEsIHN0cmVuZ3RoOiAtODIwMDxi
cj5GZWIgMDcgMTg6NTQ6MTcgcnVuZTY0IGl3ZFsyNjVdOiBzcmMvc3RhdGlvbi5jOnN0YXRpb25f
YWRkX3NlZW5fYnNzKCkgUHJvY2Vzc2luZyBCU1MgJiMzOTswNjo5Mzo5Nzo0ZTowMTo0MyYjMzk7
IHdpdGggU1NJRDogQVRUeFpJUTR3YSwgZnJlcTogNTgwNSwgcmFuazogOTM2LCBzdHJlbmd0aDog
LTg3MDA8YnI+RmViIDA3IDE4OjU0OjE3IHJ1bmU2NCBpd2RbMjY1XTogc3JjL3N0YXRpb24uYzpz
dGF0aW9uX2FkZF9zZWVuX2JzcygpIFByb2Nlc3NpbmcgQlNTICYjMzk7N2U6YWM6Yjk6NTU6OTI6
YTkmIzM5OyB3aXRoIFNTSUQ6ICwgZnJlcTogNTc0NSwgcmFuazogNzkyLCBzdHJlbmd0aDogLTg5
MDA8YnI+RmViIDA3IDE4OjU0OjE3IHJ1bmU2NCBpd2RbMjY1XTogc3JjL3N0YXRpb24uYzpzdGF0
aW9uX2FkZF9zZWVuX2JzcygpIEJTUyBoYXMgaGlkZGVuIFNTSUQ8YnI+RmViIDA3IDE4OjU0OjE3
IHJ1bmU2NCBpd2RbMjY1XTogc3JjL3N0YXRpb24uYzpzdGF0aW9uX2FkZF9zZWVuX2JzcygpIFBy
b2Nlc3NpbmcgQlNTICYjMzk7MDQ6ZDk6ZjU6YmI6YjQ6NTgmIzM5OyB3aXRoIFNTSUQ6IEhBTk5B
LCBmcmVxOiAyNDI3LCByYW5rOiAxOTQxLCBzdHJlbmd0aDogLTc4MDA8YnI+RmViIDA3IDE4OjU0
OjE3IHJ1bmU2NCBpd2RbMjY1XTogc3JjL3N0YXRpb24uYzpzdGF0aW9uX2FkZF9zZWVuX2Jzcygp
IFByb2Nlc3NpbmcgQlNTICYjMzk7MDY6OTM6OTc6MDk6Y2E6OTMmIzM5OyB3aXRoIFNTSUQ6IEFU
VGVIZVRLSTIsIGZyZXE6IDU3NjUsIHJhbms6IDEwMzYsIHN0cmVuZ3RoOiAtODgwMDxicj5GZWIg
MDcgMTg6NTQ6MTcgcnVuZTY0IGl3ZFsyNjVdOiBzcmMvc3RhdGlvbi5jOnN0YXRpb25fYWRkX3Nl
ZW5fYnNzKCkgUHJvY2Vzc2luZyBCU1MgJiMzOTs3NDphYzpiOTo1NTo5MjphOSYjMzk7IHdpdGgg
U1NJRDogTG9hZGluZy4uLiwgZnJlcTogNTc0NSwgcmFuazogOTM2LCBzdHJlbmd0aDogLTg3MDA8
YnI+RmViIDA3IDE4OjU0OjE3IHJ1bmU2NCBpd2RbMjY1XTogc3JjL3N0YXRpb24uYzpzdGF0aW9u
X2FkZF9zZWVuX2JzcygpIFByb2Nlc3NpbmcgQlNTICYjMzk7OTQ6ZTM6NmQ6NmE6OTY6YWEmIzM5
OyB3aXRoIFNTSUQ6IENoaW1lLTZhOTZhYSwgZnJlcTogMjQxMiwgcmFuazogMjcwLCBzdHJlbmd0
aDogLTgyMDA8YnI+RmViIDA3IDE4OjU0OjE3IHJ1bmU2NCBpd2RbMjY1XTogc3JjL3N0YXRpb24u
YzpzdGF0aW9uX2FkZF9zZWVuX2JzcygpIFByb2Nlc3NpbmcgQlNTICYjMzk7MTA6OTM6OTc6NGU6
MDE6NDAmIzM5OyB3aXRoIFNTSUQ6IEFUVHhaSVE0d2EsIGZyZXE6IDI0MTIsIHJhbms6IDE4NTgs
IHN0cmVuZ3RoOiAtNzUwMDxicj5GZWIgMDcgMTg6NTQ6MTcgcnVuZTY0IGl3ZFsyNjVdOiBzcmMv
c3RhdGlvbi5jOnN0YXRpb25fYWRkX3NlZW5fYnNzKCkgUHJvY2Vzc2luZyBCU1MgJiMzOTsxMDpk
YTo0MzphMDpmNTphNSYjMzk7IHdpdGggU1NJRDogTkVUR0VBUjYzLTVHLCBmcmVxOiA1NzY1LCBy
YW5rOiAxNTc3LCBzdHJlbmd0aDogLTgyMDA8YnI+RmViIDA3IDE4OjU0OjE3IHJ1bmU2NCBpd2Rb
MjY1XTogc3JjL3N0YXRpb24uYzpzdGF0aW9uX2FkZF9zZWVuX2JzcygpIFByb2Nlc3NpbmcgQlNT
ICYjMzk7ZjQ6YzE6MTQ6YjI6NGQ6OGUmIzM5OyB3aXRoIFNTSUQ6IEJpZGVuSGFycmlzLCBmcmVx
OiA1MjQwLCByYW5rOiAxMjk2LCBzdHJlbmd0aDogLTg1MDA8YnI+RmViIDA3IDE4OjU0OjE3IHJ1
bmU2NCBpd2RbMjY1XTogc3JjL3N0YXRpb24uYzpzdGF0aW9uX2FkZF9zZWVuX2JzcygpIFByb2Nl
c3NpbmcgQlNTICYjMzk7ZjY6YzE6MTQ6YmE6NGQ6OGImIzM5OyB3aXRoIFNTSUQ6ICwgZnJlcTog
NTI0MCwgcmFuazogMTI5Niwgc3RyZW5ndGg6IC04NTAwPGJyPkZlYiAwNyAxODo1NDoxNyBydW5l
NjQgaXdkWzI2NV06IHNyYy9zdGF0aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9ic3MoKSBCU1MgaGFz
IGhpZGRlbiBTU0lEPGJyPkZlYiAwNyAxODo1NDoxNyBydW5lNjQgaXdkWzI2NV06IHNyYy9zdGF0
aW9uLmM6c3RhdGlvbl9hZGRfc2Vlbl9ic3MoKSBQcm9jZXNzaW5nIEJTUyAmIzM5O2Y2OmMxOjE0
OmJhOjRkOjg5JiMzOTsgd2l0aCBTU0lEOiAsIGZyZXE6IDUyNDAsIHJhbms6IDEyOTYsIHN0cmVu
Z3RoOiAtODUwMDxicj5GZWIgMDcgMTg6NTQ6MTcgcnVuZTY0IGl3ZFsyNjVdOiBzcmMvc3RhdGlv
bi5jOnN0YXRpb25fYWRkX3NlZW5fYnNzKCkgQlNTIGhhcyBoaWRkZW4gU1NJRDxicj5GZWIgMDcg
MTg6NTQ6MTcgcnVuZTY0IGl3ZFsyNjVdOiBzcmMvd2lwaHkuYzp3aXBoeV9yYWRpb193b3JrX2lu
c2VydCgpIEluc2VydGluZyB3b3JrIGl0ZW0gMTk8YnI+RmViIDA3IDE4OjU0OjE3IHJ1bmU2NCBp
d2RbMjY1XTogc3JjL3dpcGh5LmM6d2lwaHlfcmFkaW9fd29ya19kb25lKCkgV29yayBpdGVtIDE4
IGRvbmU8YnI+RmViIDA3IDE4OjU0OjE3IHJ1bmU2NCBpd2RbMjY1XTogc3JjL3dpcGh5LmM6d2lw
aHlfcmFkaW9fd29ya19uZXh0KCkgU3RhcnRpbmcgd29yayBpdGVtIDE5PGJyPkZlYiAwNyAxODo1
NDoxNyBydW5lNjQgaXdkWzI2NV06IHNyYy9zY2FuLmM6c2Nhbl9ub3RpZnkoKSBTY2FuIG5vdGlm
aWNhdGlvbiBUcmlnZ2VyIFNjYW4oMzMpPGJyPkZlYiAwNyAxODo1NDoxNyBydW5lNjQgaXdkWzI2
NV06IHNyYy9zY2FuLmM6c2Nhbl9yZXF1ZXN0X3RyaWdnZXJlZCgpIFBhc3NpdmUgc2NhbiB0cmln
Z2VyZWQgZm9yIHdkZXYgMTxicj5GZWIgMDcgMTg6NTQ6MTcgcnVuZTY0IGl3ZFsyNjVdOiBzcmMv
c3RhdGlvbi5jOnN0YXRpb25fZGJ1c19zY2FuX3RyaWdnZXJlZCgpIHN0YXRpb25fc2Nhbl90cmln
Z2VyZWQ6IDA8YnI+RmViIDA3IDE4OjU0OjE3IHJ1bmU2NCBpd2RbMjY1XTogc3JjL3N0YXRpb24u
YzpzdGF0aW9uX2RidXNfc2Nhbl90cmlnZ2VyZWQoKSBTY2FuIHRyaWdnZXJlZCBmb3Igd2xhbjAg
c3Vic2V0IDE8YnI+RmViIDA3IDE4OjU0OjIxIHJ1bmU2NCBpd2RbMjY1XTogc3JjL3NjYW4uYzpz
Y2FuX25vdGlmeSgpIFNjYW4gbm90aWZpY2F0aW9uIE5ldyBTY2FuIFJlc3VsdHMoMzQpPGJyPkZl
YiAwNyAxODo1NDoyMSBydW5lNjQgaXdkWzI2NV06IHNyYy9zY2FuLmM6Z2V0X3NjYW5fY2FsbGJh
Y2soKSBnZXRfc2Nhbl9jYWxsYmFjazxicj5GZWIgMDcgMTg6NTQ6MjEgcnVuZTY0IGl3ZFsyNjVd
OiBzcmMvc2Nhbi5jOnNjYW5fcGFyc2VfYnNzX2luZm9ybWF0aW9uX2VsZW1lbnRzKCkgTG9hZDog
Ni8yNTU8YnI+RmViIDA3IDE4OjU0OjIxIHJ1bmU2NCBpd2RbMjY1XTogc3JjL3NjYW4uYzpnZXRf
c2Nhbl9jYWxsYmFjaygpIGdldF9zY2FuX2NhbGxiYWNrPGJyPkZlYiAwNyAxODo1NDoyMSBydW5l
NjQgaXdkWzI2NV06IHNyYy9zY2FuLmM6c2Nhbl9wYXJzZV9ic3NfaW5mb3JtYXRpb25fZWxlbWVu
dHMoKSBMb2FkOiA1MS8yNTU8YnI+RmViIDA3IDE4OjU0OjIxIHJ1bmU2NCBpd2RbMjY1XTogc3Jj
L3NjYW4uYzpnZXRfc2Nhbl9jYWxsYmFjaygpIGdldF9zY2FuX2NhbGxiYWNrPGJyPkZlYiAwNyAx
ODo1NDoyMSBydW5lNjQgaXdkWzI2NV06IHNyYy9zY2FuLmM6c2Nhbl9wYXJzZV9ic3NfaW5mb3Jt
YXRpb25fZWxlbWVudHMoKSBMb2FkOiA0MS8yNTU8YnI+RmViIDA3IDE4OjU0OjIxIHJ1bmU2NCBp
d2RbMjY1XTogc3JjL3NjYW4uYzpnZXRfc2Nhbl9jYWxsYmFjaygpIGdldF9zY2FuX2NhbGxiYWNr
PGJyPkZlYiAwNyAxODo1NDoyMSBydW5lNjQgaXdkWzI2NV06IHNyYy9zY2FuLmM6c2Nhbl9wYXJz
ZV9ic3NfaW5mb3JtYXRpb25fZWxlbWVudHMoKSBMb2FkOiAzNS8yNTU8YnI+RmViIDA3IDE4OjU0
OjIxIHJ1bmU2NCBpd2RbMjY1XTogc3JjL3NjYW4uYzpnZXRfc2Nhbl9jYWxsYmFjaygpIGdldF9z
Y2FuX2NhbGxiYWNrPGJyPkZlYiAwNyAxODo1NDoyMSBydW5lNjQgaXdkWzI2NV06IHNyYy9zY2Fu
LmM6Z2V0X3NjYW5fY2FsbGJhY2soKSBnZXRfc2Nhbl9jYWxsYmFjazxicj5GZWIgMDcgMTg6NTQ6
MjEgcnVuZTY0IGl3ZFsyNjVdOiBzcmMvc2Nhbi5jOmdldF9zY2FuX2NhbGxiYWNrKCkgZ2V0X3Nj
YW5fY2FsbGJhY2s8YnI+RmViIDA3IDE4OjU0OjIxIHJ1bmU2NCBpd2RbMjY1XTogc3JjL3NjYW4u
YzpzY2FuX3BhcnNlX2Jzc19pbmZvcm1hdGlvbl9lbGVtZW50cygpIExvYWQ6IDY3LzI1NTxicj5G
ZWIgMDcgMTg6NTQ6MjEgcnVuZTY0IGl3ZFsyNjVdOiBzcmMvc2Nhbi5jOmdldF9zY2FuX2NhbGxi
YWNrKCkgZ2V0X3NjYW5fY2FsbGJhY2s8YnI+RmViIDA3IDE4OjU0OjIxIHJ1bmU2NCBpd2RbMjY1
XTogc3JjL3NjYW4uYzpzY2FuX3BhcnNlX2Jzc19pbmZvcm1hdGlvbl9lbGVtZW50cygpIExvYWQ6
IDE1Ny8yNTU8YnI+RmViIDA3IDE4OjU0OjIxIHJ1bmU2NCBpd2RbMjY1XTogc3JjL3NjYW4uYzpn
ZXRfc2Nhbl9jYWxsYmFjaygpIGdldF9zY2FuX2NhbGxiYWNrPGJyPkZlYiAwNyAxODo1NDoyMSBy
dW5lNjQgaXdkWzI2NV06IHNyYy9zY2FuLmM6c2Nhbl9wYXJzZV9ic3NfaW5mb3JtYXRpb25fZWxl
bWVudHMoKSBMb2FkOiAzNC8yNTU8YnI+RmViIDA3IDE4OjU0OjIxIHJ1bmU2NCBpd2RbMjY1XTog
c3JjL3NjYW4uYzpnZXRfc2Nhbl9jYWxsYmFjaygpIGdldF9zY2FuX2NhbGxiYWNrPGJyPkZlYiAw
NyAxODo1NDoyMSBydW5lNjQgaXdkWzI2NV06IHNyYy9zY2FuLmM6Z2V0X3NjYW5fY2FsbGJhY2so
KSBnZXRfc2Nhbl9jYWxsYmFjazxicj5GZWIgMDcgMTg6NTQ6MjEgcnVuZTY0IGl3ZFsyNjVdOiBz
cmMvc2Nhbi5jOnNjYW5fcGFyc2VfYnNzX2luZm9ybWF0aW9uX2VsZW1lbnRzKCkgTG9hZDogNjUv
MjU1PGJyPkZlYiAwNyAxODo1NDoyMSBydW5lNjQgaXdkWzI2NV06IHNyYy9zY2FuLmM6Z2V0X3Nj
YW5fY2FsbGJhY2soKSBnZXRfc2Nhbl9jYWxsYmFjazxicj5GZWIgMDcgMTg6NTQ6MjEgcnVuZTY0
IGl3ZFsyNjVdOiBzcmMvc2Nhbi5jOmdldF9zY2FuX2NhbGxiYWNrKCkgZ2V0X3NjYW5fY2FsbGJh
Y2s8YnI+RmViIDA3IDE4OjU0OjIxIHJ1bmU2NCBpd2RbMjY1XTogc3JjL3NjYW4uYzpnZXRfc2Nh
bl9jYWxsYmFjaygpIGdldF9zY2FuX2NhbGxiYWNrPGJyPkZlYiAwNyAxODo1NDoyMSBydW5lNjQg
aXdkWzI2NV06IHNyYy9zY2FuLmM6c2Nhbl9wYXJzZV9ic3NfaW5mb3JtYXRpb25fZWxlbWVudHMo
KSBMb2FkOiAxMDIvMjU1PGJyPkZlYiAwNyAxODo1NDoyMSBydW5lNjQgaXdkWzI2NV06IHNyYy9z
Y2FuLmM6Z2V0X3NjYW5fY2FsbGJhY2soKSBnZXRfc2Nhbl9jYWxsYmFjazxicj5GZWIgMDcgMTg6
NTQ6MjEgcnVuZTY0IGl3ZFsyNjVdOiBzcmMvc2Nhbi5jOnNjYW5fcGFyc2VfYnNzX2luZm9ybWF0
aW9uX2VsZW1lbnRzKCkgTG9hZDogMjgvMjU1PGJyPkZlYiAwNyAxODo1NDoyMSBydW5lNjQgaXdk
WzI2NV06IHNyYy9zY2FuLmM6Z2V0X3NjYW5fY2FsbGJhY2soKSBnZXRfc2Nhbl9jYWxsYmFjazxi
cj5GZWIgMDcgMTg6NTQ6MjEgcnVuZTY0IGl3ZFsyNjVdOiBzcmMvc2Nhbi5jOnNjYW5fcGFyc2Vf
YnNzX2luZm9ybWF0aW9uX2VsZW1lbnRzKCkgTG9hZDogMzEvMjU1PGJyPkZlYiAwNyAxODo1NDoy
MSBydW5lNjQgaXdkWzI2NV06IHNyYy9zY2FuLmM6Z2V0X3NjYW5fY2FsbGJhY2soKSBnZXRfc2Nh
bl9jYWxsYmFjazxicj5GZWIgMDcgMTg6NTQ6MjEgcnVuZTY0IGl3ZFsyNjVdOiBzcmMvc2Nhbi5j
OnNjYW5fcGFyc2VfYnNzX2luZm9ybWF0aW9uX2VsZW1lbnRzKCkgTG9hZDogMzEvMjU1PGJyPkZl
YiAwNyAxODo1NDoyMSBydW5lNjQgaXdkWzI2NV06IHNyYy9zY2FuLmM6Z2V0X3NjYW5fY2FsbGJh
Y2soKSBnZXRfc2Nhbl9jYWxsYmFjazxicj5GZWIgMDcgMTg6NTQ6MjEgcnVuZTY0IGl3ZFsyNjVd
OiBzcmMvc2Nhbi5jOnNjYW5fcGFyc2VfYnNzX2luZm9ybWF0aW9uX2VsZW1lbnRzKCkgTG9hZDog
MzEvMjU1PGJyPkZlYiAwNyAxODo1NDoyMSBydW5lNjQgaXdkWzI2NV06IHNyYy9zY2FuLmM6c2Nh
bl9wYXJzZV9hZHZlcnRpc2VtZW50X3Byb3RvY29sKCk8YnI+RmViIDA3IDE4OjU0OjIxIHJ1bmU2
NCBpd2RbMjY1XTogc3JjL3NjYW4uYzpnZXRfc2Nhbl9jYWxsYmFjaygpIGdldF9zY2FuX2NhbGxi
YWNrPGJyPkZlYiAwNyAxODo1NDoyMSBydW5lNjQgaXdkWzI2NV06IHNyYy9zY2FuLmM6c2Nhbl9w
YXJzZV9ic3NfaW5mb3JtYXRpb25fZWxlbWVudHMoKSBMb2FkOiAzMS8yNTU8YnI+RmViIDA3IDE4
OjU0OjIxIHJ1bmU2NCBpd2RbMjY1XTogc3JjL3NjYW4uYzpnZXRfc2Nhbl9jYWxsYmFjaygpIGdl
dF9zY2FuX2NhbGxiYWNrPGJyPkZlYiAwNyAxODo1NDoyMSBydW5lNjQgaXdkWzI2NV06IHNyYy9z
Y2FuLmM6c2Nhbl9wYXJzZV9ic3NfaW5mb3JtYXRpb25fZWxlbWVudHMoKSBMb2FkOiAxMS8yNTU8
YnI+RmViIDA3IDE4OjU0OjIxIHJ1bmU2NCBpd2RbMjY1XTogc3JjL3NjYW4uYzpnZXRfc2Nhbl9j
YWxsYmFjaygpIGdldF9zY2FuX2NhbGxiYWNrPGJyPkZlYiAwNyAxODo1NDoyMSBydW5lNjQgaXdk
WzI2NV06IHNyYy9zY2FuLmM6c2Nhbl9wYXJzZV9ic3NfaW5mb3JtYXRpb25fZWxlbWVudHMoKSBM
b2FkOiAxMS8yNTU8YnI+RmViIDA3IDE4OjU0OjIxIHJ1bmU2NCBpd2RbMjY1XTogc3JjL3NjYW4u
YzpnZXRfc2Nhbl9kb25lKCkgZ2V0X3NjYW5fZG9uZTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
SXQganVzdCByZXBlYXRzIHRoaXMgb3ZlciBhbmQgb3ZlciBhZ2FpbiB1bnRpbCBJIGVpdGhlciBy
ZXNldCB0aGUgaW50ZXJmYWNlIG9yIHJlc3RhcnQgZWl0aGVyIGNvbm5tYW4gb3IgaXdkLiBIb3cg
Y2FuIEkgaGVscCB0byBkZWJ1ZyB0aGlzPyBJcyBpdCBhIGtlcm5lbCBpc3N1ZT8gV2hhdCBpcyB0
aGUgdHJpZ2dlciB0aGF0IGlzIHN1cHBvc2VkIHRvIGdldCBhbiBleHRlcm5hbCBwcm9jZXNzIHRv
IG5lZ290aWF0ZSB0aGUgaW50ZXJmYWNlIGNvbm5lY3Rpb24/PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5LZWl0aDxicj48L2Rpdj48L2Rpdj4K

--===============0663704044550155026==--

