Content-Type: multipart/mixed; boundary="===============4519338146318505507=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: AP mode crash
Date: Tue, 04 Feb 2020 09:09:34 +0100
Message-ID: <5898b6d9-9c2e-2a1d-51f6-f3adac6345cb@monom.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4519338146318505507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

While playing with the AP mode I triggered following crash:


AP Probe Request from 30:4b:07:ee:49:8d
AP Probe Response sent OK
src/netdev.c:netdev_unicast_notify() Unicast notification 59
AP Probe Request from 30:4b:07:ee:49:8d
src/netdev.c:netdev_unicast_notify() Unicast notification 59
AP Probe Request from 30:4b:07:ee:49:8d
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
src/agent.c:agent_unregister() agent unregister
src/agent.c:agent_free() agent free 0xde6820
src/netdev.c:netdev_mlme_notify() MLME notification Stop AP(16)
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
src/netdev.c:netdev_bridge_port_event() netdev: 8 added to bridge: 9
src/netdev.c:netdev_link_notify() event 16 on ifindex 2
src/netdev.c:netdev_link_notify() event 16 on ifindex 9
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
src/netdev.c:netdev_bridge_port_event() netdev: 8 added to bridge: 9
src/netdev.c:netdev_link_notify() event 17 on ifindex 8
src/netdev.c:netdev_bridge_port_event() netdev: 8 removed from bridge: 9
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
src/netdev.c:netdev_link_notify() event 17 on ifindex 9
src/netdev.c:netdev_link_notify() event 16 on ifindex 2
src/agent.c:agent_register() agent register called
src/agent.c:agent_register() agent :1.83 path /net/connman/iwd_agent
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
src/netdev.c:netdev_unicast_notify() Unicast notification 59
AP Probe Request from 30:4b:07:ee:49:8d
src/netdev.c:netdev_unicast_notify() Unicast notification 59
AP Probe Request from 30:4b:07:ee:49:8d
src/netdev.c:netdev_unicast_notify() Unicast notification 59
AP Probe Request from 30:4b:07:ee:49:8d
Aborting (signal 11) [/home/wagi/prj/connman/iwd/src/iwd]
++++++++ backtrace ++++++++
#0  0x7fc63e910030 in /lib64/libc.so.6
#1  0x7fc63ea35891 in /lib64/libc.so.6
#2  0x43ad5e in ap_probe_req_cb() at src/ap.c:1100 (discriminator 1)
#3  0x45435a in frame_watch_unicast_notify() at src/frame-xchg.c:184 =

(discriminator 6)
#4  0x4818c3 in dispatch_unicast_watches() at ell/genl.c:899
#5  0x48197b in process_unicast() at ell/genl.c:919
#6  0x481d21 in received_data() at ell/genl.c:1035
#7  0x47cfea in io_callback() at ell/io.c:126
#8  0x47baf8 in l_main_iterate() at ell/main.c:473
#9  0x47bbff in l_main_run() at ell/main.c:516
#10 0x47bf17 in l_main_run_with_signal() at ell/main.c:642
#11 0x404a36 in main() at src/main.c:497
#12 0x7fc63e8fae0b in /lib64/libc.so.6
+++++++++++++++++++++++++++

What I did was, enabling WiFi tethering in ConnMan, terminate ConnMan =

(this tells iwd to shutdown the connection) and restart ConnMan again. =

ConnMan then tries to restore the old setup, starting the AP mode.

Haven't really debugged it yet. Maybe someone spots the problem more =

easily than I do :)

Thanks,
Daniel
--===============4519338146318505507==--

