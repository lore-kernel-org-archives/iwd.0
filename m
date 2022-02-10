Content-Type: multipart/mixed; boundary="===============8573980180842746406=="
MIME-Version: 1.0
From: David Bourgeois <david at jaguarondi.com>
To: iwd at lists.01.org
Subject: Dual phy device not always detected
Date: Thu, 10 Feb 2022 17:51:43 +0100
Message-ID: <CAMSdBrG=OGXZRMSjf-u41rAuTaxUdMw0sVMbNPX995B8sCiq_A@mail.gmail.com>

--===============8573980180842746406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

We plan to use iwd for an embedded device where we need both station and ap
at the same time. For this we have devices based on the rtl88x2bu driver
compiled to enable the dual phy. This works well, the dongle is detected as
2 different interfaces wlan0 and wlan1 and both work properly. IWD doesn't
always detect both interfaces though when the dongle is plugged. If IWD is
restarted, then most of the time both interfaces are detected. When the
dongle is plugged at boot it also works most of the time.

Here's what is shown through the interface as soon as I replug the dongle
and I added below the lines of the log that are around the unplug/replug
events. If there's any other kind of logs I could get to make things easier
to track, let me know. I can provide the full logs as well.

Thanks,
David

root(a)cy-rio-15-65:/etc/systemd/network# ip a
13: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
group default qlen 1000
    link/ether 60:a4:b7:83:26:b5 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::62a4:b7ff:fe83:26b5/64 scope link
       valid_lft forever preferred_lft forever
14: wlan1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN
group default qlen 1000
    link/ether 62:a4:b7:83:26:b5 brd ff:ff:ff:ff:ff:ff
root(a)cy-rio-15-65:/etc/systemd/network# iwctl device list
                                    Devices
---------------------------------------------------------------------------=
-----
  Name                Address             Powered   Adapter   Mode
---------------------------------------------------------------------------=
-----
  wlan0               60:a4:b7:83:26:b5   on        phy6      station

root(a)cy-rio-15-65:/etc/systemd/network# systemctl restart iwd
root(a)cy-rio-15-65:/etc/systemd/network# iwctl device list
                                    Devices
---------------------------------------------------------------------------=
-----
  Name                Address             Powered   Adapter   Mode
---------------------------------------------------------------------------=
-----
  wlan0               60:a4:b7:83:26:b5   on        phy6      station
  wlan1               62:a4:b7:83:26:b5   on        phy7      station

root(a)cy-rio-15-65:/etc/systemd/network# ip a
13: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
group default qlen 1000
    link/ether 60:a4:b7:83:26:b5 brd ff:ff:ff:ff:ff:ff
    inet 192.168.88.40/24 brd 192.168.88.255 scope global dynamic wlan0
       valid_lft 581sec preferred_lft 581sec
    inet6 fe80::62a4:b7ff:fe83:26b5/64 scope link
       valid_lft forever preferred_lft forever
14: wlan1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
group default qlen 1000
    link/ether 62:a4:b7:83:26:b5 brd ff:ff:ff:ff:ff:ff
    inet 192.168.88.55/24 brd 192.168.88.255 scope global dynamic wlan1
       valid_lft 595sec preferred_lft 595sec
    inet6 fe80::60a4:b7ff:fe83:26b5/64 scope link
       valid_lft forever preferred_lft forever

This is a log with the -d option, there's a line "10-02-22 12_48_02
NEW_INTERFACE failed: No such device" at the bottom but it's not always
there even when the interface is still not detected.

10-02-22 12_47_34 ../iwd-1.24/src/netdev.c:netdev_link_notify() event 16 on
ifindex 7
10-02-22 12_47_34 ../iwd-1.24/src/station.c:station_free()
10-02-22 12_47_34 ../iwd-1.24/src/scan.c:scan_periodic_stop() Stopping
periodic scan for wdev 200000001
10-02-22 12_47_34 ../iwd-1.24/src/station.c:station_roam_state_clear() 7
10-02-22 12_47_34 ../iwd-1.24/src/manager.c:manager_config_notify()
Notification of command Del Interface(8)
10-02-22 12_47_34 ../iwd-1.24/src/netdev.c:netdev_free() Freeing netdev
wlan0[7]
10-02-22 12_47_34 ../iwd-1.24/src/device.c:device_free()
10-02-22 12_47_34 Removing scan context for wdev 200000001
10-02-22 12_47_34 ../iwd-1.24/src/scan.c:scan_context_free() sc: 0x10b18b8
10-02-22 12_47_34 ../iwd-1.24/src/netdev.c:netdev_link_notify() event 17 on
ifindex 7
10-02-22 12_47_34 ../iwd-1.24/src/manager.c:manager_config_notify()
Notification of command Del Wiphy(4)
10-02-22 12_47_34 ../iwd-1.24/src/wiphy.c:wiphy_destroy()
10-02-22 12_47_34 ../iwd-1.24/src/wiphy.c:wiphy_free() Freeing wiphy phy2[2]
10-02-22 12_47_34 ../iwd-1.24/src/netdev.c:netdev_link_notify() event 16 on
ifindex 8
10-02-22 12_47_34 ../iwd-1.24/src/station.c:station_free()
10-02-22 12_47_34 ../iwd-1.24/src/scan.c:scan_periodic_stop() Stopping
periodic scan for wdev 300000001
10-02-22 12_47_34 ../iwd-1.24/src/station.c:station_roam_state_clear() 8
10-02-22 12_47_34 ../iwd-1.24/src/manager.c:manager_config_notify()
Notification of command Del Interface(8)
10-02-22 12_47_34 ../iwd-1.24/src/netdev.c:netdev_free() Freeing netdev
wlan1[8]
10-02-22 12_47_34 ../iwd-1.24/src/device.c:device_free()
10-02-22 12_47_34 Removing scan context for wdev 300000001
10-02-22 12_47_34 ../iwd-1.24/src/scan.c:scan_context_free() sc: 0x10b8060
10-02-22 12_47_34 ../iwd-1.24/src/netdev.c:netdev_link_notify() event 17 on
ifindex 8
10-02-22 12_47_34 ../iwd-1.24/src/manager.c:manager_config_notify()
Notification of command Del Wiphy(4)
10-02-22 12_47_34 ../iwd-1.24/src/wiphy.c:wiphy_destroy()
10-02-22 12_47_34 ../iwd-1.24/src/wiphy.c:wiphy_free() Freeing wiphy phy3[3]
10-02-22 12_48_01 ../iwd-1.24/src/manager.c:manager_config_notify()
Notification of command New Wiphy(3)
10-02-22 12_48_01 ../iwd-1.24/src/wiphy.c:wiphy_reg_notify() Notification
of command Reg Change(36)
10-02-22 12_48_01 ../iwd-1.24/src/wiphy.c:wiphy_update_reg_domain() New reg
domain country code for (global) is XX
10-02-22 12_48_01 ../iwd-1.24/src/manager.c:manager_config_notify()
Notification of command New Interface(7)
10-02-22 12_48_01 ../iwd-1.24/src/netdev.c:netdev_link_notify() event 16 on
ifindex 9
10-02-22 12_48_01 Wiphy: 4, Name: phy4
10-02-22 12_48_01 Permanent Address: 00:00:00:00:00:00
10-02-22 12_48_01 2.4Ghz Band:
10-02-22 12_48_01 Bitrates (non-HT):
10-02-22 12_48_01 1.0 Mbps
10-02-22 12_48_01 2.0 Mbps
10-02-22 12_48_01 5.5 Mbps
10-02-22 12_48_01 11.0 Mbps
10-02-22 12_48_01 6.0 Mbps
10-02-22 12_48_01 9.0 Mbps
10-02-22 12_48_01 12.0 Mbps
10-02-22 12_48_01 18.0 Mbps
10-02-22 12_48_01 24.0 Mbps
10-02-22 12_48_01 36.0 Mbps
10-02-22 12_48_01 48.0 Mbps
10-02-22 12_48_01 54.0 Mbps
10-02-22 12_48_01 5Ghz Band:
10-02-22 12_48_01 Bitrates (non-HT):
10-02-22 12_48_01 6.0 Mbps
10-02-22 12_48_01 9.0 Mbps
10-02-22 12_48_01 12.0 Mbps
10-02-22 12_48_01 18.0 Mbps
10-02-22 12_48_01 24.0 Mbps
10-02-22 12_48_01 36.0 Mbps
10-02-22 12_48_01 48.0 Mbps
10-02-22 12_48_01 54.0 Mbps
10-02-22 12_48_01 Ciphers: CCMP TKIP BIP
10-02-22 12_48_01 Supported iftypes: ad-hoc station ap
10-02-22 12_48_01 Wiphy phy4 will only use the default interface
10-02-22 12_48_01 ../iwd-1.24/src/manager.c:manager_config_notify()
Notification of command New Wiphy(3)
10-02-22 12_48_01 ../iwd-1.24/src/netdev.c:netdev_link_notify() event 16 on
ifindex 10
10-02-22 12_48_01 ../iwd-1.24/src/wiphy.c:wiphy_reg_notify() Notification
of command Reg Change(36)
10-02-22 12_48_01 ../iwd-1.24/src/wiphy.c:wiphy_update_reg_domain() New reg
domain country code for (global) is XX
10-02-22 12_48_01 ../iwd-1.24/src/manager.c:manager_config_notify()
Notification of command New Interface(7)
10-02-22 12_48_01
../iwd-1.24/src/manager.c:manager_interface_dump_callback()
10-02-22 12_48_01 ../iwd-1.24/src/manager.c:manager_get_interface_cb()
10-02-22 12_48_01 ../iwd-1.24/src/manager.c:manager_use_default()
10-02-22 12_48_01 ../iwd-1.24/src/netdev.c:netdev_create_from_genl()
Created interface wlan0[9 400000001]
10-02-22 12_48_01 ../iwd-1.24/src/manager.c:manager_create_interfaces()
creating wlan5
10-02-22 12_48_01 ../iwd-1.24/src/wiphy.c:wiphy_update_reg_domain() New reg
domain country code for (global) is 00
10-02-22 12_48_02 ../iwd-1.24/src/netdev.c:netdev_link_notify() event 16 on
ifindex 9
10-02-22 12_48_02 Wiphy: 5, Name: phy5
10-02-22 12_48_02 Permanent Address: d2:37:45:17:a0:5e
10-02-22 12_48_02 2.4Ghz Band:
10-02-22 12_48_02 Bitrates (non-HT):
10-02-22 12_48_02 1.0 Mbps
10-02-22 12_48_02 2.0 Mbps
10-02-22 12_48_02 5.5 Mbps
10-02-22 12_48_02 11.0 Mbps
10-02-22 12_48_02 6.0 Mbps
10-02-22 12_48_02 9.0 Mbps
10-02-22 12_48_02 12.0 Mbps
10-02-22 12_48_02 18.0 Mbps
10-02-22 12_48_02 24.0 Mbps
10-02-22 12_48_02 36.0 Mbps
10-02-22 12_48_02 48.0 Mbps
10-02-22 12_48_02 54.0 Mbps
10-02-22 12_48_02 5Ghz Band:
10-02-22 12_48_02 Bitrates (non-HT):
10-02-22 12_48_02 6.0 Mbps
10-02-22 12_48_02 9.0 Mbps
10-02-22 12_48_02 12.0 Mbps
10-02-22 12_48_02 18.0 Mbps
10-02-22 12_48_02 24.0 Mbps
10-02-22 12_48_02 36.0 Mbps
10-02-22 12_48_02 48.0 Mbps
10-02-22 12_48_02 54.0 Mbps
10-02-22 12_48_02 Ciphers: CCMP TKIP BIP
10-02-22 12_48_02 Supported iftypes: ad-hoc station ap p2p-client p2p-go
10-02-22 12_48_02 Wiphy phy5 will only use the default interface
10-02-22 12_48_02 ../iwd-1.24/src/netdev.c:netdev_set_4addr() netdev: 9
use_4addr: 0
10-02-22 12_48_02 ../iwd-1.24/src/netdev.c:netdev_initial_up_cb() Interface
9 initialized
10-02-22 12_48_02 ../iwd-1.24/src/station.c:station_enter_state() Old
State: disconnected, new state: autoconnect_quick
10-02-22 12_48_02 ../iwd-1.24/src/scan.c:scan_periodic_start() Starting
periodic scan for wdev 400000001
10-02-22 12_48_02 ../iwd-1.24/src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 9
10-02-22 12_48_02 ../iwd-1.24/src/wiphy.c:wiphy_radio_work_next() Starting
work item 9
10-02-22 12_48_02 ../iwd-1.24/src/rrm.c:rrm_add_frame_watches()
10-02-22 12_48_02 ../iwd-1.24/src/netdev.c:netdev_link_notify() event 16 on
ifindex 9
10-02-22 12_48_02
../iwd-1.24/src/manager.c:manager_interface_dump_callback()
10-02-22 12_48_02 ../iwd-1.24/src/manager.c:manager_get_interface_cb()
10-02-22 12_48_02 ../iwd-1.24/src/netdev.c:netdev_link_notify() event 16 on
ifindex 9
10-02-22 12_48_02
../iwd-1.24/src/manager.c:manager_new_station_interface_cb()
10-02-22 12_48_02 NEW_INTERFACE failed: No such device
10-02-22 12_48_02 ../iwd-1.24/src/wiphy.c:wiphy_update_reg_domain() New reg
domain country code for (global) is 00
10-02-22 12_48_02 ../iwd-1.24/src/manager.c:manager_config_notify()
Notification of command Set Interface(6)
10-02-22 12_48_02 ../iwd-1.24/src/scan.c:scan_notify() Scan notification
Trigger Scan(33)
10-02-22 12_48_02 ../iwd-1.24/src/scan.c:scan_request_triggered() Passive
scan triggered for wdev 400000001
10-02-22 12_48_02 ../iwd-1.24/src/scan.c:scan_periodic_triggered() Periodic
scan triggered for wdev 400000001
10-02-22 12_48_02 ../iwd-1.24/src/netdev.c:netdev_link_notify() event 16 on
ifindex 9
10-02-22 12_48_07 ../iwd-1.24/src/scan.c:scan_notify() Scan notification
New Scan Results(34)
10-02-22 12_48_07 ../iwd-1.24/src/netdev.c:netdev_link_notify() event 16 on
ifindex 9
10-02-22 12_48_07 ../iwd-1.24/src/scan.c:get_scan_callback()
get_scan_callback
10-02-22 12_48_07
../iwd-1.24/src/scan.c:scan_parse_bss_information_elements() Load: 174/255
10-02-22 12_48_07 ../iwd-1.24/src/scan.c:get_scan_callback()
get_scan_callback
10-02-22 12_48_07
../iwd-1.24/src/scan.c:scan_parse_bss_information_elements() Load: 174/255


Here's another capture where we enabled IWD_GENL_DEBUG=3Dy.

10-02-22 13_01_05 ../iwd-1.24/src/netdev.c:netdev_link_notify() event 16 on
ifindex 9
10-02-22 13_01_05 ../iwd-1.24/src/station.c:station_free()
10-02-22 13_01_05 ../iwd-1.24/src/scan.c:scan_periodic_stop() Stopping
periodic scan for wdev 400000001
10-02-22 13_01_05 ../iwd-1.24/src/station.c:station_roam_state_clear() 9
10-02-22 13_01_05 [GENL] < 68 00 00 00 1c 00 00 00 00 00 00 00 00 00 00 00
 h...............
10-02-22 13_01_05 [GENL]   08 01 00 00 08 00 03 00 09 00 00 00 0a 00 04 00
 ................
10-02-22 13_01_05 [GENL]   77 6c 61 6e 30 00 00 00 08 00 01 00 04 00 00 00
 wlan0...........
10-02-22 13_01_05 [GENL]   08 00 05 00 02 00 00 00 0c 00 99 00 01 00 00 00
 ................
10-02-22 13_01_05 [GENL]   04 00 00 00 0a 00 06 00 d0 37 45 17 a0 5e 00 00
 .........7E..^..
10-02-22 13_01_05 [GENL]   08 00 2e 00 29 00 00 00 05 00 53 00 00 00 00 00
 ....).....S.....
10-02-22 13_01_05 [GENL]   08 00 62 00 f0 d8 ff ff
 ..b.....
10-02-22 13_01_05 ../iwd-1.24/src/manager.c:manager_config_notify()
Notification of command Del Interface(8)
10-02-22 13_01_05 ../iwd-1.24/src/netdev.c:netdev_free() Freeing netdev
wlan0[9]
10-02-22 13_01_05 ../iwd-1.24/src/device.c:device_free()
10-02-22 13_01_05 Removing scan context for wdev 400000001
10-02-22 13_01_05 ../iwd-1.24/src/scan.c:scan_context_free() sc: 0x22c18b8
10-02-22 13_01_05 ../iwd-1.24/src/netdev.c:netdev_link_notify() event 17 on
ifindex 9
10-02-22 13_01_05 [GENL] < 30 00 00 00 1c 00 00 00 00 00 00 00 00 00 00 00
 0...............
10-02-22 13_01_05 [GENL]   04 01 00 00 08 00 01 00 04 00 00 00 09 00 02 00
 ................
10-02-22 13_01_05 [GENL]   70 68 79 34 00 00 00 00 08 00 2e 00 0a 00 00 00
 phy4............
10-02-22 13_01_05 ../iwd-1.24/src/manager.c:manager_config_notify()
Notification of command Del Wiphy(4)
10-02-22 13_01_05 ../iwd-1.24/src/wiphy.c:wiphy_destroy()
10-02-22 13_01_05 ../iwd-1.24/src/wiphy.c:wiphy_free() Freeing wiphy phy4[4]
10-02-22 13_01_05 ../iwd-1.24/src/netdev.c:netdev_link_notify() event 16 on
ifindex 10
10-02-22 13_01_05 ../iwd-1.24/src/station.c:station_free()
10-02-22 13_01_05 ../iwd-1.24/src/scan.c:scan_periodic_stop() Stopping
periodic scan for wdev 500000001
10-02-22 13_01_05 ../iwd-1.24/src/station.c:station_roam_state_clear() 10

--===============8573980180842746406==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+SGksPGRpdj48YnI+PC9kaXY+PGRpdj5XZSBwbGFuIHRvIHVzZSBpd2Qg
Zm9yIGFuIGVtYmVkZGVkIGRldmljZSB3aGVyZSB3ZSBuZWVkIGJvdGggc3RhdGlvbiBhbmQgYXAg
YXQgdGhlIHNhbWUgdGltZS4gRm9yIHRoaXMgd2UgaGF2ZSBkZXZpY2VzIGJhc2VkIG9uIHRoZSBy
dGw4OHgyYnUgZHJpdmVyIGNvbXBpbGVkIHRvIGVuYWJsZSB0aGUgZHVhbCBwaHkuIFRoaXMgd29y
a3Mgd2VsbCwgdGhlIGRvbmdsZSBpcyBkZXRlY3RlZCBhcyAyIGRpZmZlcmVudCBpbnRlcmZhY2Vz
IHdsYW4wIGFuZCB3bGFuMSBhbmQgYm90aCB3b3JrIHByb3Blcmx5LiBJV0QgZG9lc24mIzM5O3Qg
YWx3YXlzIGRldGVjdCBib3RoIGludGVyZmFjZXMgdGhvdWdoIHdoZW4gdGhlIGRvbmdsZSBpcyBw
bHVnZ2VkLiBJZiBJV0QgaXMgcmVzdGFydGVkLCB0aGVuIG1vc3Qgb2YgdGhlIHRpbWUgYm90aCBp
bnRlcmZhY2VzIGFyZSBkZXRlY3RlZC4gV2hlbiB0aGUgZG9uZ2xlIGlzIHBsdWdnZWQgYXQgYm9v
dCBpdCBhbHNvIHdvcmtzIG1vc3Qgb2YgdGhlIHRpbWUuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5IZXJlJiMzOTtzIHdoYXQgaXMgc2hvd24gdGhyb3VnaCB0aGUgaW50ZXJmYWNlIGFzIHNvb24g
YXMgSSByZXBsdWcgdGhlIGRvbmdsZSBhbmQgSSBhZGRlZCBiZWxvdyB0aGUgbGluZXMgb2YgdGhl
IGxvZyB0aGF0IGFyZSBhcm91bmQgdGhlIHVucGx1Zy9yZXBsdWcgZXZlbnRzLiBJZiB0aGVyZSYj
Mzk7cyBhbnkgb3RoZXIga2luZCBvZiBsb2dzIEkgY291bGQgZ2V0IHRvIG1ha2UgdGhpbmdzIGVh
c2llciB0byB0cmFjaywgbGV0IG1lIGtub3cuIEkgY2FuIHByb3ZpZGUgdGhlIGZ1bGwgbG9ncyBh
cyB3ZWxsLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+RGF2aWQ8
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PnJvb3RAY3ktcmlvLTE1LTY1Oi9ldGMvc3lzdGVtZC9u
ZXR3b3JrIyBpcCBhPGJyPjEzOiB3bGFuMDogJmx0O0JST0FEQ0FTVCxNVUxUSUNBU1QsVVAsTE9X
RVJfVVAmZ3Q7IG10dSAxNTAwIHFkaXNjIG1xIHN0YXRlIFVQIGdyb3VwIGRlZmF1bHQgcWxlbiAx
MDAwPGJyPsKgIMKgIGxpbmsvZXRoZXIgNjA6YTQ6Yjc6ODM6MjY6YjUgYnJkIGZmOmZmOmZmOmZm
OmZmOmZmPGJyPsKgIMKgIGluZXQ2IGZlODA6OjYyYTQ6YjdmZjpmZTgzOjI2YjUvNjQgc2NvcGUg
bGluazxicj7CoCDCoCDCoCDCoHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZl
cjxicj4xNDogd2xhbjE6ICZsdDtOTy1DQVJSSUVSLEJST0FEQ0FTVCxNVUxUSUNBU1QsVVAmZ3Q7
IG10dSAxNTAwIHFkaXNjIG1xIHN0YXRlIERPV04gZ3JvdXAgZGVmYXVsdCBxbGVuIDEwMDA8YnI+
wqAgwqAgbGluay9ldGhlciA2MjphNDpiNzo4MzoyNjpiNSBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmY8
YnI+cm9vdEBjeS1yaW8tMTUtNjU6L2V0Yy9zeXN0ZW1kL25ldHdvcmsjIGl3Y3RsIGRldmljZSBs
aXN0PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIERldmljZXM8YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+wqAgTmFtZSDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoEFkZHJlc3MgwqAgwqAgwqAgwqAgwqAgwqAgUG93ZXJlZCDCoCBBZGFw
dGVyIMKgIE1vZGU8YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+wqAgd2xhbjAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgNjA6YTQ6Yjc6ODM6MjY6YjUgwqAgb24gwqAgwqAgwqAgwqBwaHk2IMKg
IMKgIMKgc3RhdGlvbjxicj48YnI+cm9vdEBjeS1yaW8tMTUtNjU6L2V0Yy9zeXN0ZW1kL25ldHdv
cmsjIHN5c3RlbWN0bCByZXN0YXJ0IGl3ZDxicj5yb290QGN5LXJpby0xNS02NTovZXRjL3N5c3Rl
bWQvbmV0d29yayMgaXdjdGwgZGV2aWNlIGxpc3Q8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgRGV2aWNlczxicj4tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTxicj7CoCBOYW1lIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQWRkcmVzcyDCoCDCoCDC
oCDCoCDCoCDCoCBQb3dlcmVkIMKgIEFkYXB0ZXIgwqAgTW9kZTxicj4tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTxicj7CoCB3bGFuMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA2MDphNDpiNzo4MzoyNjpi
NSDCoCBvbiDCoCDCoCDCoCDCoHBoeTYgwqAgwqAgwqBzdGF0aW9uPGJyPsKgIHdsYW4xIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIDYyOmE0OmI3OjgzOjI2OmI1IMKgIG9uIMKgIMKgIMKgIMKgcGh5NyDC
oCDCoCDCoHN0YXRpb248YnI+PGJyPnJvb3RAY3ktcmlvLTE1LTY1Oi9ldGMvc3lzdGVtZC9uZXR3
b3JrIyBpcCBhPGJyPjEzOiB3bGFuMDogJmx0O0JST0FEQ0FTVCxNVUxUSUNBU1QsVVAsTE9XRVJf
VVAmZ3Q7IG10dSAxNTAwIHFkaXNjIG1xIHN0YXRlIFVQIGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAw
PGJyPsKgIMKgIGxpbmsvZXRoZXIgNjA6YTQ6Yjc6ODM6MjY6YjUgYnJkIGZmOmZmOmZmOmZmOmZm
OmZmPGJyPsKgIMKgIGluZXQgPGEgaHJlZj0iaHR0cDovLzE5Mi4xNjguODguNDAvMjQiPjE5Mi4x
NjguODguNDAvMjQ8L2E+IGJyZCAxOTIuMTY4Ljg4LjI1NSBzY29wZSBnbG9iYWwgZHluYW1pYyB3
bGFuMDxicj7CoCDCoCDCoCDCoHZhbGlkX2xmdCA1ODFzZWMgcHJlZmVycmVkX2xmdCA1ODFzZWM8
YnI+wqAgwqAgaW5ldDYgZmU4MDo6NjJhNDpiN2ZmOmZlODM6MjZiNS82NCBzY29wZSBsaW5rPGJy
PsKgIMKgIMKgIMKgdmFsaWRfbGZ0IGZvcmV2ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyPGJyPjE0
OiB3bGFuMTogJmx0O0JST0FEQ0FTVCxNVUxUSUNBU1QsVVAsTE9XRVJfVVAmZ3Q7IG10dSAxNTAw
IHFkaXNjIG1xIHN0YXRlIFVQIGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwPGJyPsKgIMKgIGxpbmsv
ZXRoZXIgNjI6YTQ6Yjc6ODM6MjY6YjUgYnJkIGZmOmZmOmZmOmZmOmZmOmZmPGJyPsKgIMKgIGlu
ZXQgPGEgaHJlZj0iaHR0cDovLzE5Mi4xNjguODguNTUvMjQiPjE5Mi4xNjguODguNTUvMjQ8L2E+
IGJyZCAxOTIuMTY4Ljg4LjI1NSBzY29wZSBnbG9iYWwgZHluYW1pYyB3bGFuMTxicj7CoCDCoCDC
oCDCoHZhbGlkX2xmdCA1OTVzZWMgcHJlZmVycmVkX2xmdCA1OTVzZWM8YnI+wqAgwqAgaW5ldDYg
ZmU4MDo6NjBhNDpiN2ZmOmZlODM6MjZiNS82NCBzY29wZSBsaW5rPGJyPsKgIMKgIMKgIMKgdmFs
aWRfbGZ0IGZvcmV2ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyPGJyPjxicj48L2Rpdj48ZGl2PlRo
aXMgaXMgYSBsb2cgd2l0aCB0aGUgLWQgb3B0aW9uLCB0aGVyZSYjMzk7cyBhIGxpbmUgJnF1b3Q7
MTAtMDItMjIgMTJfNDhfMDIgTkVXX0lOVEVSRkFDRSBmYWlsZWQ6IE5vIHN1Y2ggZGV2aWNlJnF1
b3Q7IGF0IHRoZSBib3R0b20gYnV0IGl0JiMzOTtzIG5vdCBhbHdheXMgdGhlcmUgZXZlbiB3aGVu
IHRoZSBpbnRlcmZhY2UgaXMgc3RpbGwgbm90IGRldGVjdGVkLjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+MTAtMDItMjIgMTJfNDdfMzQgLi4vaXdkLTEuMjQvc3JjL25ldGRldi5jOm5ldGRldl9s
aW5rX25vdGlmeSgpIGV2ZW50IDE2IG9uIGlmaW5kZXggNzxicj4xMC0wMi0yMiAxMl80N18zNCAu
Li9pd2QtMS4yNC9zcmMvc3RhdGlvbi5jOnN0YXRpb25fZnJlZSgpIDxicj4xMC0wMi0yMiAxMl80
N18zNCAuLi9pd2QtMS4yNC9zcmMvc2Nhbi5jOnNjYW5fcGVyaW9kaWNfc3RvcCgpIFN0b3BwaW5n
IHBlcmlvZGljIHNjYW4gZm9yIHdkZXYgMjAwMDAwMDAxPGJyPjEwLTAyLTIyIDEyXzQ3XzM0IC4u
L2l3ZC0xLjI0L3NyYy9zdGF0aW9uLmM6c3RhdGlvbl9yb2FtX3N0YXRlX2NsZWFyKCkgNzxicj4x
MC0wMi0yMiAxMl80N18zNCAuLi9pd2QtMS4yNC9zcmMvbWFuYWdlci5jOm1hbmFnZXJfY29uZmln
X25vdGlmeSgpIE5vdGlmaWNhdGlvbiBvZiBjb21tYW5kIERlbCBJbnRlcmZhY2UoOCk8YnI+MTAt
MDItMjIgMTJfNDdfMzQgLi4vaXdkLTEuMjQvc3JjL25ldGRldi5jOm5ldGRldl9mcmVlKCkgRnJl
ZWluZyBuZXRkZXYgd2xhbjBbN108YnI+MTAtMDItMjIgMTJfNDdfMzQgLi4vaXdkLTEuMjQvc3Jj
L2RldmljZS5jOmRldmljZV9mcmVlKCkgPGJyPjEwLTAyLTIyIDEyXzQ3XzM0IFJlbW92aW5nIHNj
YW4gY29udGV4dCBmb3Igd2RldiAyMDAwMDAwMDE8YnI+MTAtMDItMjIgMTJfNDdfMzQgLi4vaXdk
LTEuMjQvc3JjL3NjYW4uYzpzY2FuX2NvbnRleHRfZnJlZSgpIHNjOiAweDEwYjE4Yjg8YnI+MTAt
MDItMjIgMTJfNDdfMzQgLi4vaXdkLTEuMjQvc3JjL25ldGRldi5jOm5ldGRldl9saW5rX25vdGlm
eSgpIGV2ZW50IDE3IG9uIGlmaW5kZXggNzxicj4xMC0wMi0yMiAxMl80N18zNCAuLi9pd2QtMS4y
NC9zcmMvbWFuYWdlci5jOm1hbmFnZXJfY29uZmlnX25vdGlmeSgpIE5vdGlmaWNhdGlvbiBvZiBj
b21tYW5kIERlbCBXaXBoeSg0KTxicj4xMC0wMi0yMiAxMl80N18zNCAuLi9pd2QtMS4yNC9zcmMv
d2lwaHkuYzp3aXBoeV9kZXN0cm95KCkgPGJyPjEwLTAyLTIyIDEyXzQ3XzM0IC4uL2l3ZC0xLjI0
L3NyYy93aXBoeS5jOndpcGh5X2ZyZWUoKSBGcmVlaW5nIHdpcGh5IHBoeTJbMl08YnI+MTAtMDIt
MjIgMTJfNDdfMzQgLi4vaXdkLTEuMjQvc3JjL25ldGRldi5jOm5ldGRldl9saW5rX25vdGlmeSgp
IGV2ZW50IDE2IG9uIGlmaW5kZXggODxicj4xMC0wMi0yMiAxMl80N18zNCAuLi9pd2QtMS4yNC9z
cmMvc3RhdGlvbi5jOnN0YXRpb25fZnJlZSgpIDxicj4xMC0wMi0yMiAxMl80N18zNCAuLi9pd2Qt
MS4yNC9zcmMvc2Nhbi5jOnNjYW5fcGVyaW9kaWNfc3RvcCgpIFN0b3BwaW5nIHBlcmlvZGljIHNj
YW4gZm9yIHdkZXYgMzAwMDAwMDAxPGJyPjEwLTAyLTIyIDEyXzQ3XzM0IC4uL2l3ZC0xLjI0L3Ny
Yy9zdGF0aW9uLmM6c3RhdGlvbl9yb2FtX3N0YXRlX2NsZWFyKCkgODxicj4xMC0wMi0yMiAxMl80
N18zNCAuLi9pd2QtMS4yNC9zcmMvbWFuYWdlci5jOm1hbmFnZXJfY29uZmlnX25vdGlmeSgpIE5v
dGlmaWNhdGlvbiBvZiBjb21tYW5kIERlbCBJbnRlcmZhY2UoOCk8YnI+MTAtMDItMjIgMTJfNDdf
MzQgLi4vaXdkLTEuMjQvc3JjL25ldGRldi5jOm5ldGRldl9mcmVlKCkgRnJlZWluZyBuZXRkZXYg
d2xhbjFbOF08YnI+MTAtMDItMjIgMTJfNDdfMzQgLi4vaXdkLTEuMjQvc3JjL2RldmljZS5jOmRl
dmljZV9mcmVlKCkgPGJyPjEwLTAyLTIyIDEyXzQ3XzM0IFJlbW92aW5nIHNjYW4gY29udGV4dCBm
b3Igd2RldiAzMDAwMDAwMDE8YnI+MTAtMDItMjIgMTJfNDdfMzQgLi4vaXdkLTEuMjQvc3JjL3Nj
YW4uYzpzY2FuX2NvbnRleHRfZnJlZSgpIHNjOiAweDEwYjgwNjA8YnI+MTAtMDItMjIgMTJfNDdf
MzQgLi4vaXdkLTEuMjQvc3JjL25ldGRldi5jOm5ldGRldl9saW5rX25vdGlmeSgpIGV2ZW50IDE3
IG9uIGlmaW5kZXggODxicj4xMC0wMi0yMiAxMl80N18zNCAuLi9pd2QtMS4yNC9zcmMvbWFuYWdl
ci5jOm1hbmFnZXJfY29uZmlnX25vdGlmeSgpIE5vdGlmaWNhdGlvbiBvZiBjb21tYW5kIERlbCBX
aXBoeSg0KTxicj4xMC0wMi0yMiAxMl80N18zNCAuLi9pd2QtMS4yNC9zcmMvd2lwaHkuYzp3aXBo
eV9kZXN0cm95KCkgPGJyPjEwLTAyLTIyIDEyXzQ3XzM0IC4uL2l3ZC0xLjI0L3NyYy93aXBoeS5j
OndpcGh5X2ZyZWUoKSBGcmVlaW5nIHdpcGh5IHBoeTNbM108YnI+MTAtMDItMjIgMTJfNDhfMDEg
Li4vaXdkLTEuMjQvc3JjL21hbmFnZXIuYzptYW5hZ2VyX2NvbmZpZ19ub3RpZnkoKSBOb3RpZmlj
YXRpb24gb2YgY29tbWFuZCBOZXcgV2lwaHkoMyk8YnI+MTAtMDItMjIgMTJfNDhfMDEgLi4vaXdk
LTEuMjQvc3JjL3dpcGh5LmM6d2lwaHlfcmVnX25vdGlmeSgpIE5vdGlmaWNhdGlvbiBvZiBjb21t
YW5kIFJlZyBDaGFuZ2UoMzYpPGJyPjEwLTAyLTIyIDEyXzQ4XzAxIC4uL2l3ZC0xLjI0L3NyYy93
aXBoeS5jOndpcGh5X3VwZGF0ZV9yZWdfZG9tYWluKCkgTmV3IHJlZyBkb21haW4gY291bnRyeSBj
b2RlIGZvciAoZ2xvYmFsKSBpcyBYWDxicj4xMC0wMi0yMiAxMl80OF8wMSAuLi9pd2QtMS4yNC9z
cmMvbWFuYWdlci5jOm1hbmFnZXJfY29uZmlnX25vdGlmeSgpIE5vdGlmaWNhdGlvbiBvZiBjb21t
YW5kIE5ldyBJbnRlcmZhY2UoNyk8YnI+MTAtMDItMjIgMTJfNDhfMDEgLi4vaXdkLTEuMjQvc3Jj
L25ldGRldi5jOm5ldGRldl9saW5rX25vdGlmeSgpIGV2ZW50IDE2IG9uIGlmaW5kZXggOTxicj4x
MC0wMi0yMiAxMl80OF8wMSBXaXBoeTogNCwgTmFtZTogcGh5NDxicj4xMC0wMi0yMiAxMl80OF8w
MSAJUGVybWFuZW50IEFkZHJlc3M6IDAwOjAwOjAwOjAwOjAwOjAwPGJyPjEwLTAyLTIyIDEyXzQ4
XzAxIAkyLjRHaHogQmFuZDo8YnI+MTAtMDItMjIgMTJfNDhfMDEgCQlCaXRyYXRlcyAobm9uLUhU
KTo8YnI+MTAtMDItMjIgMTJfNDhfMDEgCQkJIDEuMCBNYnBzPGJyPjEwLTAyLTIyIDEyXzQ4XzAx
IAkJCSAyLjAgTWJwczxicj4xMC0wMi0yMiAxMl80OF8wMSAJCQkgNS41IE1icHM8YnI+MTAtMDIt
MjIgMTJfNDhfMDEgCQkJMTEuMCBNYnBzPGJyPjEwLTAyLTIyIDEyXzQ4XzAxIAkJCSA2LjAgTWJw
czxicj4xMC0wMi0yMiAxMl80OF8wMSAJCQkgOS4wIE1icHM8YnI+MTAtMDItMjIgMTJfNDhfMDEg
CQkJMTIuMCBNYnBzPGJyPjEwLTAyLTIyIDEyXzQ4XzAxIAkJCTE4LjAgTWJwczxicj4xMC0wMi0y
MiAxMl80OF8wMSAJCQkyNC4wIE1icHM8YnI+MTAtMDItMjIgMTJfNDhfMDEgCQkJMzYuMCBNYnBz
PGJyPjEwLTAyLTIyIDEyXzQ4XzAxIAkJCTQ4LjAgTWJwczxicj4xMC0wMi0yMiAxMl80OF8wMSAJ
CQk1NC4wIE1icHM8YnI+MTAtMDItMjIgMTJfNDhfMDEgCTVHaHogQmFuZDo8YnI+MTAtMDItMjIg
MTJfNDhfMDEgCQlCaXRyYXRlcyAobm9uLUhUKTo8YnI+MTAtMDItMjIgMTJfNDhfMDEgCQkJIDYu
MCBNYnBzPGJyPjEwLTAyLTIyIDEyXzQ4XzAxIAkJCSA5LjAgTWJwczxicj4xMC0wMi0yMiAxMl80
OF8wMSAJCQkxMi4wIE1icHM8YnI+MTAtMDItMjIgMTJfNDhfMDEgCQkJMTguMCBNYnBzPGJyPjEw
LTAyLTIyIDEyXzQ4XzAxIAkJCTI0LjAgTWJwczxicj4xMC0wMi0yMiAxMl80OF8wMSAJCQkzNi4w
IE1icHM8YnI+MTAtMDItMjIgMTJfNDhfMDEgCQkJNDguMCBNYnBzPGJyPjEwLTAyLTIyIDEyXzQ4
XzAxIAkJCTU0LjAgTWJwczxicj4xMC0wMi0yMiAxMl80OF8wMSAJQ2lwaGVyczogQ0NNUCBUS0lQ
IEJJUDxicj4xMC0wMi0yMiAxMl80OF8wMSAJU3VwcG9ydGVkIGlmdHlwZXM6IGFkLWhvYyBzdGF0
aW9uIGFwPGJyPjEwLTAyLTIyIDEyXzQ4XzAxIFdpcGh5IHBoeTQgd2lsbCBvbmx5IHVzZSB0aGUg
ZGVmYXVsdCBpbnRlcmZhY2U8YnI+MTAtMDItMjIgMTJfNDhfMDEgLi4vaXdkLTEuMjQvc3JjL21h
bmFnZXIuYzptYW5hZ2VyX2NvbmZpZ19ub3RpZnkoKSBOb3RpZmljYXRpb24gb2YgY29tbWFuZCBO
ZXcgV2lwaHkoMyk8YnI+MTAtMDItMjIgMTJfNDhfMDEgLi4vaXdkLTEuMjQvc3JjL25ldGRldi5j
Om5ldGRldl9saW5rX25vdGlmeSgpIGV2ZW50IDE2IG9uIGlmaW5kZXggMTA8YnI+MTAtMDItMjIg
MTJfNDhfMDEgLi4vaXdkLTEuMjQvc3JjL3dpcGh5LmM6d2lwaHlfcmVnX25vdGlmeSgpIE5vdGlm
aWNhdGlvbiBvZiBjb21tYW5kIFJlZyBDaGFuZ2UoMzYpPGJyPjEwLTAyLTIyIDEyXzQ4XzAxIC4u
L2l3ZC0xLjI0L3NyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9yZWdfZG9tYWluKCkgTmV3IHJlZyBk
b21haW4gY291bnRyeSBjb2RlIGZvciAoZ2xvYmFsKSBpcyBYWDxicj4xMC0wMi0yMiAxMl80OF8w
MSAuLi9pd2QtMS4yNC9zcmMvbWFuYWdlci5jOm1hbmFnZXJfY29uZmlnX25vdGlmeSgpIE5vdGlm
aWNhdGlvbiBvZiBjb21tYW5kIE5ldyBJbnRlcmZhY2UoNyk8YnI+MTAtMDItMjIgMTJfNDhfMDEg
Li4vaXdkLTEuMjQvc3JjL21hbmFnZXIuYzptYW5hZ2VyX2ludGVyZmFjZV9kdW1wX2NhbGxiYWNr
KCkgPGJyPjEwLTAyLTIyIDEyXzQ4XzAxIC4uL2l3ZC0xLjI0L3NyYy9tYW5hZ2VyLmM6bWFuYWdl
cl9nZXRfaW50ZXJmYWNlX2NiKCkgPGJyPjEwLTAyLTIyIDEyXzQ4XzAxIC4uL2l3ZC0xLjI0L3Ny
Yy9tYW5hZ2VyLmM6bWFuYWdlcl91c2VfZGVmYXVsdCgpIDxicj4xMC0wMi0yMiAxMl80OF8wMSAu
Li9pd2QtMS4yNC9zcmMvbmV0ZGV2LmM6bmV0ZGV2X2NyZWF0ZV9mcm9tX2dlbmwoKSBDcmVhdGVk
IGludGVyZmFjZSB3bGFuMFs5IDQwMDAwMDAwMV08YnI+MTAtMDItMjIgMTJfNDhfMDEgLi4vaXdk
LTEuMjQvc3JjL21hbmFnZXIuYzptYW5hZ2VyX2NyZWF0ZV9pbnRlcmZhY2VzKCkgY3JlYXRpbmcg
d2xhbjU8YnI+MTAtMDItMjIgMTJfNDhfMDEgLi4vaXdkLTEuMjQvc3JjL3dpcGh5LmM6d2lwaHlf
dXBkYXRlX3JlZ19kb21haW4oKSBOZXcgcmVnIGRvbWFpbiBjb3VudHJ5IGNvZGUgZm9yIChnbG9i
YWwpIGlzIDAwPGJyPjEwLTAyLTIyIDEyXzQ4XzAyIC4uL2l3ZC0xLjI0L3NyYy9uZXRkZXYuYzpu
ZXRkZXZfbGlua19ub3RpZnkoKSBldmVudCAxNiBvbiBpZmluZGV4IDk8YnI+MTAtMDItMjIgMTJf
NDhfMDIgV2lwaHk6IDUsIE5hbWU6IHBoeTU8YnI+MTAtMDItMjIgMTJfNDhfMDIgCVBlcm1hbmVu
dCBBZGRyZXNzOiBkMjozNzo0NToxNzphMDo1ZTxicj4xMC0wMi0yMiAxMl80OF8wMiAJMi40R2h6
IEJhbmQ6PGJyPjEwLTAyLTIyIDEyXzQ4XzAyIAkJQml0cmF0ZXMgKG5vbi1IVCk6PGJyPjEwLTAy
LTIyIDEyXzQ4XzAyIAkJCSAxLjAgTWJwczxicj4xMC0wMi0yMiAxMl80OF8wMiAJCQkgMi4wIE1i
cHM8YnI+MTAtMDItMjIgMTJfNDhfMDIgCQkJIDUuNSBNYnBzPGJyPjEwLTAyLTIyIDEyXzQ4XzAy
IAkJCTExLjAgTWJwczxicj4xMC0wMi0yMiAxMl80OF8wMiAJCQkgNi4wIE1icHM8YnI+MTAtMDIt
MjIgMTJfNDhfMDIgCQkJIDkuMCBNYnBzPGJyPjEwLTAyLTIyIDEyXzQ4XzAyIAkJCTEyLjAgTWJw
czxicj4xMC0wMi0yMiAxMl80OF8wMiAJCQkxOC4wIE1icHM8YnI+MTAtMDItMjIgMTJfNDhfMDIg
CQkJMjQuMCBNYnBzPGJyPjEwLTAyLTIyIDEyXzQ4XzAyIAkJCTM2LjAgTWJwczxicj4xMC0wMi0y
MiAxMl80OF8wMiAJCQk0OC4wIE1icHM8YnI+MTAtMDItMjIgMTJfNDhfMDIgCQkJNTQuMCBNYnBz
PGJyPjEwLTAyLTIyIDEyXzQ4XzAyIAk1R2h6IEJhbmQ6PGJyPjEwLTAyLTIyIDEyXzQ4XzAyIAkJ
Qml0cmF0ZXMgKG5vbi1IVCk6PGJyPjEwLTAyLTIyIDEyXzQ4XzAyIAkJCSA2LjAgTWJwczxicj4x
MC0wMi0yMiAxMl80OF8wMiAJCQkgOS4wIE1icHM8YnI+MTAtMDItMjIgMTJfNDhfMDIgCQkJMTIu
MCBNYnBzPGJyPjEwLTAyLTIyIDEyXzQ4XzAyIAkJCTE4LjAgTWJwczxicj4xMC0wMi0yMiAxMl80
OF8wMiAJCQkyNC4wIE1icHM8YnI+MTAtMDItMjIgMTJfNDhfMDIgCQkJMzYuMCBNYnBzPGJyPjEw
LTAyLTIyIDEyXzQ4XzAyIAkJCTQ4LjAgTWJwczxicj4xMC0wMi0yMiAxMl80OF8wMiAJCQk1NC4w
IE1icHM8YnI+MTAtMDItMjIgMTJfNDhfMDIgCUNpcGhlcnM6IENDTVAgVEtJUCBCSVA8YnI+MTAt
MDItMjIgMTJfNDhfMDIgCVN1cHBvcnRlZCBpZnR5cGVzOiBhZC1ob2Mgc3RhdGlvbiBhcCBwMnAt
Y2xpZW50IHAycC1nbzxicj4xMC0wMi0yMiAxMl80OF8wMiBXaXBoeSBwaHk1IHdpbGwgb25seSB1
c2UgdGhlIGRlZmF1bHQgaW50ZXJmYWNlPGJyPjEwLTAyLTIyIDEyXzQ4XzAyIC4uL2l3ZC0xLjI0
L3NyYy9uZXRkZXYuYzpuZXRkZXZfc2V0XzRhZGRyKCkgbmV0ZGV2OiA5IHVzZV80YWRkcjogMDxi
cj4xMC0wMi0yMiAxMl80OF8wMiAuLi9pd2QtMS4yNC9zcmMvbmV0ZGV2LmM6bmV0ZGV2X2luaXRp
YWxfdXBfY2IoKSBJbnRlcmZhY2UgOSBpbml0aWFsaXplZDxicj4xMC0wMi0yMiAxMl80OF8wMiAu
Li9pd2QtMS4yNC9zcmMvc3RhdGlvbi5jOnN0YXRpb25fZW50ZXJfc3RhdGUoKSBPbGQgU3RhdGU6
IGRpc2Nvbm5lY3RlZCwgbmV3IHN0YXRlOiBhdXRvY29ubmVjdF9xdWljazxicj4xMC0wMi0yMiAx
Ml80OF8wMiAuLi9pd2QtMS4yNC9zcmMvc2Nhbi5jOnNjYW5fcGVyaW9kaWNfc3RhcnQoKSBTdGFy
dGluZyBwZXJpb2RpYyBzY2FuIGZvciB3ZGV2IDQwMDAwMDAwMTxicj4xMC0wMi0yMiAxMl80OF8w
MiAuLi9pd2QtMS4yNC9zcmMvd2lwaHkuYzp3aXBoeV9yYWRpb193b3JrX2luc2VydCgpIEluc2Vy
dGluZyB3b3JrIGl0ZW0gOTxicj4xMC0wMi0yMiAxMl80OF8wMiAuLi9pd2QtMS4yNC9zcmMvd2lw
aHkuYzp3aXBoeV9yYWRpb193b3JrX25leHQoKSBTdGFydGluZyB3b3JrIGl0ZW0gOTxicj4xMC0w
Mi0yMiAxMl80OF8wMiAuLi9pd2QtMS4yNC9zcmMvcnJtLmM6cnJtX2FkZF9mcmFtZV93YXRjaGVz
KCkgPGJyPjEwLTAyLTIyIDEyXzQ4XzAyIC4uL2l3ZC0xLjI0L3NyYy9uZXRkZXYuYzpuZXRkZXZf
bGlua19ub3RpZnkoKSBldmVudCAxNiBvbiBpZmluZGV4IDk8YnI+MTAtMDItMjIgMTJfNDhfMDIg
Li4vaXdkLTEuMjQvc3JjL21hbmFnZXIuYzptYW5hZ2VyX2ludGVyZmFjZV9kdW1wX2NhbGxiYWNr
KCkgPGJyPjEwLTAyLTIyIDEyXzQ4XzAyIC4uL2l3ZC0xLjI0L3NyYy9tYW5hZ2VyLmM6bWFuYWdl
cl9nZXRfaW50ZXJmYWNlX2NiKCkgPGJyPjEwLTAyLTIyIDEyXzQ4XzAyIC4uL2l3ZC0xLjI0L3Ny
Yy9uZXRkZXYuYzpuZXRkZXZfbGlua19ub3RpZnkoKSBldmVudCAxNiBvbiBpZmluZGV4IDk8YnI+
MTAtMDItMjIgMTJfNDhfMDIgLi4vaXdkLTEuMjQvc3JjL21hbmFnZXIuYzptYW5hZ2VyX25ld19z
dGF0aW9uX2ludGVyZmFjZV9jYigpIDxicj4xMC0wMi0yMiAxMl80OF8wMiBORVdfSU5URVJGQUNF
IGZhaWxlZDogTm8gc3VjaCBkZXZpY2U8YnI+MTAtMDItMjIgMTJfNDhfMDIgLi4vaXdkLTEuMjQv
c3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX3JlZ19kb21haW4oKSBOZXcgcmVnIGRvbWFpbiBjb3Vu
dHJ5IGNvZGUgZm9yIChnbG9iYWwpIGlzIDAwPGJyPjEwLTAyLTIyIDEyXzQ4XzAyIC4uL2l3ZC0x
LjI0L3NyYy9tYW5hZ2VyLmM6bWFuYWdlcl9jb25maWdfbm90aWZ5KCkgTm90aWZpY2F0aW9uIG9m
IGNvbW1hbmQgU2V0IEludGVyZmFjZSg2KTxicj4xMC0wMi0yMiAxMl80OF8wMiAuLi9pd2QtMS4y
NC9zcmMvc2Nhbi5jOnNjYW5fbm90aWZ5KCkgU2NhbiBub3RpZmljYXRpb24gVHJpZ2dlciBTY2Fu
KDMzKTxicj4xMC0wMi0yMiAxMl80OF8wMiAuLi9pd2QtMS4yNC9zcmMvc2Nhbi5jOnNjYW5fcmVx
dWVzdF90cmlnZ2VyZWQoKSBQYXNzaXZlIHNjYW4gdHJpZ2dlcmVkIGZvciB3ZGV2IDQwMDAwMDAw
MTxicj4xMC0wMi0yMiAxMl80OF8wMiAuLi9pd2QtMS4yNC9zcmMvc2Nhbi5jOnNjYW5fcGVyaW9k
aWNfdHJpZ2dlcmVkKCkgUGVyaW9kaWMgc2NhbiB0cmlnZ2VyZWQgZm9yIHdkZXYgNDAwMDAwMDAx
PGJyPjEwLTAyLTIyIDEyXzQ4XzAyIC4uL2l3ZC0xLjI0L3NyYy9uZXRkZXYuYzpuZXRkZXZfbGlu
a19ub3RpZnkoKSBldmVudCAxNiBvbiBpZmluZGV4IDk8YnI+MTAtMDItMjIgMTJfNDhfMDcgLi4v
aXdkLTEuMjQvc3JjL3NjYW4uYzpzY2FuX25vdGlmeSgpIFNjYW4gbm90aWZpY2F0aW9uIE5ldyBT
Y2FuIFJlc3VsdHMoMzQpPGJyPjEwLTAyLTIyIDEyXzQ4XzA3IC4uL2l3ZC0xLjI0L3NyYy9uZXRk
ZXYuYzpuZXRkZXZfbGlua19ub3RpZnkoKSBldmVudCAxNiBvbiBpZmluZGV4IDk8YnI+MTAtMDIt
MjIgMTJfNDhfMDcgLi4vaXdkLTEuMjQvc3JjL3NjYW4uYzpnZXRfc2Nhbl9jYWxsYmFjaygpIGdl
dF9zY2FuX2NhbGxiYWNrPGJyPjEwLTAyLTIyIDEyXzQ4XzA3IC4uL2l3ZC0xLjI0L3NyYy9zY2Fu
LmM6c2Nhbl9wYXJzZV9ic3NfaW5mb3JtYXRpb25fZWxlbWVudHMoKSBMb2FkOiAxNzQvMjU1PGJy
PjEwLTAyLTIyIDEyXzQ4XzA3IC4uL2l3ZC0xLjI0L3NyYy9zY2FuLmM6Z2V0X3NjYW5fY2FsbGJh
Y2soKSBnZXRfc2Nhbl9jYWxsYmFjazxicj4xMC0wMi0yMiAxMl80OF8wNyAuLi9pd2QtMS4yNC9z
cmMvc2Nhbi5jOnNjYW5fcGFyc2VfYnNzX2luZm9ybWF0aW9uX2VsZW1lbnRzKCkgTG9hZDogMTc0
LzI1NTxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkhlcmUmIzM5
O3MgYW5vdGhlciBjYXB0dXJlIHdoZXJlIHdlIGVuYWJsZWTCoDxzcGFuIHN0eWxlPSJiYWNrZ3Jv
dW5kLWNvbG9yOnJnYmEoNjEsNjAsNjQsMC4wNCk7Y29sb3I6cmdiKDYxLDYwLDY0KTtmb250LWZh
bWlseTomcXVvdDtPcGVuIFNhbnMmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTMuNXB4O3do
aXRlLXNwYWNlOnByZS13cmFwIj5JV0RfR0VOTF9ERUJVRz15PC9zcGFuPi48YnI+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj4xMC0wMi0yMiAxM18wMV8wNSAuLi9pd2QtMS4yNC9zcmMvbmV0ZGV2
LmM6bmV0ZGV2X2xpbmtfbm90aWZ5KCkgZXZlbnQgMTYgb24gaWZpbmRleCA5PGJyPjEwLTAyLTIy
IDEzXzAxXzA1IC4uL2l3ZC0xLjI0L3NyYy9zdGF0aW9uLmM6c3RhdGlvbl9mcmVlKCkgPGJyPjEw
LTAyLTIyIDEzXzAxXzA1IC4uL2l3ZC0xLjI0L3NyYy9zY2FuLmM6c2Nhbl9wZXJpb2RpY19zdG9w
KCkgU3RvcHBpbmcgcGVyaW9kaWMgc2NhbiBmb3Igd2RldiA0MDAwMDAwMDE8YnI+MTAtMDItMjIg
MTNfMDFfMDUgLi4vaXdkLTEuMjQvc3JjL3N0YXRpb24uYzpzdGF0aW9uX3JvYW1fc3RhdGVfY2xl
YXIoKSA5PGJyPjEwLTAyLTIyIDEzXzAxXzA1IFtHRU5MXSAmbHQ7IDY4IDAwIDAwIDAwIDFjIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIMKgaC4uLi4uLi4uLi4uLi4uLjxicj4xMC0w
Mi0yMiAxM18wMV8wNSBbR0VOTF0gwqAgMDggMDEgMDAgMDAgMDggMDAgMDMgMDAgMDkgMDAgMDAg
MDAgMGEgMDAgMDQgMDAgwqAuLi4uLi4uLi4uLi4uLi4uPGJyPjEwLTAyLTIyIDEzXzAxXzA1IFtH
RU5MXSDCoCA3NyA2YyA2MSA2ZSAzMCAwMCAwMCAwMCAwOCAwMCAwMSAwMCAwNCAwMCAwMCAwMCDC
oHdsYW4wLi4uLi4uLi4uLi48YnI+MTAtMDItMjIgMTNfMDFfMDUgW0dFTkxdIMKgIDA4IDAwIDA1
IDAwIDAyIDAwIDAwIDAwIDBjIDAwIDk5IDAwIDAxIDAwIDAwIDAwIMKgLi4uLi4uLi4uLi4uLi4u
Ljxicj4xMC0wMi0yMiAxM18wMV8wNSBbR0VOTF0gwqAgMDQgMDAgMDAgMDAgMGEgMDAgMDYgMDAg
ZDAgMzcgNDUgMTcgYTAgNWUgMDAgMDAgwqAuLi4uLi4uLi43RS4uXi4uPGJyPjEwLTAyLTIyIDEz
XzAxXzA1IFtHRU5MXSDCoCAwOCAwMCAyZSAwMCAyOSAwMCAwMCAwMCAwNSAwMCA1MyAwMCAwMCAw
MCAwMCAwMCDCoC4uLi4pLi4uLi5TLi4uLi48YnI+MTAtMDItMjIgMTNfMDFfMDUgW0dFTkxdIMKg
IDA4IDAwIDYyIDAwIGYwIGQ4IGZmIGZmIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgLi5iLi4uLi4gwqAgwqAgwqAgwqA8YnI+MTAtMDItMjIgMTNfMDFfMDUgLi4vaXdkLTEu
MjQvc3JjL21hbmFnZXIuYzptYW5hZ2VyX2NvbmZpZ19ub3RpZnkoKSBOb3RpZmljYXRpb24gb2Yg
Y29tbWFuZCBEZWwgSW50ZXJmYWNlKDgpPGJyPjEwLTAyLTIyIDEzXzAxXzA1IC4uL2l3ZC0xLjI0
L3NyYy9uZXRkZXYuYzpuZXRkZXZfZnJlZSgpIEZyZWVpbmcgbmV0ZGV2IHdsYW4wWzldPGJyPjEw
LTAyLTIyIDEzXzAxXzA1IC4uL2l3ZC0xLjI0L3NyYy9kZXZpY2UuYzpkZXZpY2VfZnJlZSgpIDxi
cj4xMC0wMi0yMiAxM18wMV8wNSBSZW1vdmluZyBzY2FuIGNvbnRleHQgZm9yIHdkZXYgNDAwMDAw
MDAxPGJyPjEwLTAyLTIyIDEzXzAxXzA1IC4uL2l3ZC0xLjI0L3NyYy9zY2FuLmM6c2Nhbl9jb250
ZXh0X2ZyZWUoKSBzYzogMHgyMmMxOGI4PGJyPjEwLTAyLTIyIDEzXzAxXzA1IC4uL2l3ZC0xLjI0
L3NyYy9uZXRkZXYuYzpuZXRkZXZfbGlua19ub3RpZnkoKSBldmVudCAxNyBvbiBpZmluZGV4IDk8
YnI+MTAtMDItMjIgMTNfMDFfMDUgW0dFTkxdICZsdDsgMzAgMDAgMDAgMDAgMWMgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgwqAwLi4uLi4uLi4uLi4uLi4uPGJyPjEwLTAyLTIyIDEz
XzAxXzA1IFtHRU5MXSDCoCAwNCAwMSAwMCAwMCAwOCAwMCAwMSAwMCAwNCAwMCAwMCAwMCAwOSAw
MCAwMiAwMCDCoC4uLi4uLi4uLi4uLi4uLi48YnI+MTAtMDItMjIgMTNfMDFfMDUgW0dFTkxdIMKg
IDcwIDY4IDc5IDM0IDAwIDAwIDAwIDAwIDA4IDAwIDJlIDAwIDBhIDAwIDAwIDAwIMKgcGh5NC4u
Li4uLi4uLi4uLjxicj4xMC0wMi0yMiAxM18wMV8wNSAuLi9pd2QtMS4yNC9zcmMvbWFuYWdlci5j
Om1hbmFnZXJfY29uZmlnX25vdGlmeSgpIE5vdGlmaWNhdGlvbiBvZiBjb21tYW5kIERlbCBXaXBo
eSg0KTxicj4xMC0wMi0yMiAxM18wMV8wNSAuLi9pd2QtMS4yNC9zcmMvd2lwaHkuYzp3aXBoeV9k
ZXN0cm95KCkgPGJyPjEwLTAyLTIyIDEzXzAxXzA1IC4uL2l3ZC0xLjI0L3NyYy93aXBoeS5jOndp
cGh5X2ZyZWUoKSBGcmVlaW5nIHdpcGh5IHBoeTRbNF08YnI+MTAtMDItMjIgMTNfMDFfMDUgLi4v
aXdkLTEuMjQvc3JjL25ldGRldi5jOm5ldGRldl9saW5rX25vdGlmeSgpIGV2ZW50IDE2IG9uIGlm
aW5kZXggMTA8YnI+MTAtMDItMjIgMTNfMDFfMDUgLi4vaXdkLTEuMjQvc3JjL3N0YXRpb24uYzpz
dGF0aW9uX2ZyZWUoKSA8YnI+MTAtMDItMjIgMTNfMDFfMDUgLi4vaXdkLTEuMjQvc3JjL3NjYW4u
YzpzY2FuX3BlcmlvZGljX3N0b3AoKSBTdG9wcGluZyBwZXJpb2RpYyBzY2FuIGZvciB3ZGV2IDUw
MDAwMDAwMTxicj4xMC0wMi0yMiAxM18wMV8wNSAuLi9pd2QtMS4yNC9zcmMvc3RhdGlvbi5jOnN0
YXRpb25fcm9hbV9zdGF0ZV9jbGVhcigpIDEwPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PC9kaXY+Cg==

--===============8573980180842746406==--

