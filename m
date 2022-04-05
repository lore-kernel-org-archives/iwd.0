Content-Type: multipart/mixed; boundary="===============7206262279732541555=="
MIME-Version: 1.0
From: Leonard Lausen <leonard at lausen.nl>
To: iwd at lists.01.org
Subject: Re: segfault in parse_neighbor_report at src/station.c:1747
Date: Tue, 05 Apr 2022 17:35:54 +0000
Message-ID: <2f87d1e1f09d2d07cf1c23fb62b75b8d@lausen.nl>
In-Reply-To: adfc7d6f-ccb9-4f10-1667-1c716ad7cac0@gmail.com

--===============7206262279732541555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> Thank you! Your patch prevents the crash. Whenever I walk towards or awa=
y from
>> the router and the router tries to switch me between 2.4G and 5G, I see a
>> `iwd[29343]: src/station.c:station_ap_directed_roam() roam: unexpected AP
>> directed roam -- ignore` logline. However, my laptop remains on the 2.4G=
 / 5G
>> band respectively and does not switch.
> =

> I'm not sure what is going on, but according to iwd, you're not even conn=
ected!? What does 'iwctl
> station wlan0 show' say?

% iwctl station wlan0 show
Station: wlan0
---------------------------------------------------------------------------=
-----
Settable Property Value
---------------------------------------------------------------------------=
-----
Scanning no
State disconnected

> I'm confused why the AP is even sending this. Maybe the kernel crash you =
reported is confusing
> everything.

The kernel crash should be unrelated. I rebooted and verified the iwctl sta=
tion
wlan0 show output remains the same. I'm using NetworkManager with iwd backe=
nd
and NetworkManager does show me as connected. Maybe that is related?

% sudo cat /etc/NetworkManager/conf.d/backend.conf
[device]
match-device=3Dwlp58s0
wifi.backend=3Diwd

I do see a number of `Unexpected connection related event -- is another sup=
plicant running?`
in the iwd.service log.

Besides, upon reboot I have observed another iwd segfault. Unfortunately I
wasn't running iwd in debug mode upon reboot. I've changed that now, but up=
on
the second reboot I didn't get a segfault..

[   83.057911] iwlwifi 0000:3a:00.0: api flags index 2 larger than supporte=
d by driver
[   83.057954] iwlwifi 0000:3a:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0=
.2.36
[   83.058559] iwlwifi 0000:3a:00.0: loaded firmware version 68.01d30b0c.0 =
ty-a0-gf-a0-68.ucode op_mode iwlmvm
[  144.563596] iwlwifi 0000:3a:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz=
, REV=3D0x420
[  144.563674] thermal thermal_zone9: failed to read out thermal zone (-61)
[  144.570002] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 1, ret=3D-1
[  144.570009] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 2, ret=3D-1
[  144.570011] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 3, ret=3D-1
[  144.729755] iwlwifi 0000:3a:00.0: loaded PNVM version 05a8dfca
[  144.741901] iwlwifi 0000:3a:00.0: Detected RF GF, rfid=3D0x10d000
[  144.815572] iwlwifi 0000:3a:00.0: base HW address: f4:46:37:83:01:3a
[  144.843080] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 1, ret=3D-1
[  144.843093] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 2, ret=3D-1
[  144.843098] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 3, ret=3D-1
[  145.155156] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 1, ret=3D-1
[  145.155162] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 2, ret=3D-1
[  145.155164] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 3, ret=3D-1
[  149.896019] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 1, ret=3D-1
[  149.896026] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 2, ret=3D-1
[  149.896027] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 3, ret=3D-1
[  154.600300] wlan0: authenticate with ec:a8:1f:99:cf:f0
[  154.615369] wlan0: send auth to ec:a8:1f:99:cf:f0 (try 1/3)
[  154.657479] wlan0: authenticate with ec:a8:1f:99:cf:f0
[  154.657484] wlan0: send auth to ec:a8:1f:99:cf:f0 (try 1/3)
[  154.667002] wlan0: authenticated
[  154.667416] wlan0: associate with ec:a8:1f:99:cf:f0 (try 1/3)
[  154.774512] wlan0: associate with ec:a8:1f:99:cf:f0 (try 2/3)
[  154.910496] wlan0: associate with ec:a8:1f:99:cf:f0 (try 3/3)
[  154.976403] iwd[2046]: segfault at 249 ip 00005594b4940413 sp 00007ffc04=
ab60b0 error 4 in iwd[5594b493b000+84000]
[  154.976423] Code: 1f 84 00 00 00 00 00 41 57 41 56 41 55 41 54 55 53 48 =
83 ec 48 64 48 8b 04 25 28 00 00 00 48 89 44 24 38 49 8b 80 88 00 00 00 <0f=
> b6 88 49 02 00 00 48 83 fa 03 76 48 4d 89 c4 41 f6 80 d8 01 00
[  155.014435] wlan0: association with ec:a8:1f:99:cf:f0 timed out
[  155.339893] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 1, ret=3D-1
[  155.339899] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 2, ret=3D-1
[  155.339900] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 3, ret=3D-1
[  155.665896] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 1, ret=3D-1
[  155.665906] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 2, ret=3D-1
[  155.665910] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 3, ret=3D-1
[  168.340721] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 1, ret=3D-1
[  168.340737] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 2, ret=3D-1
[  168.340744] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for all=
oc id 3, ret=3D-1
[  173.065385] wlan0: authenticate with ec:a8:1f:99:cf:f0
[  173.079648] wlan0: send auth to ec:a8:1f:99:cf:f0 (try 1/3)
[  173.978932] iwlwifi 0000:3a:00.0: Not associated and the session protect=
ion is over already...
[  173.979032] wlan0: Connection to AP ec:a8:1f:99:cf:f0 lost
[  175.143691] wlan0: send auth to ec:a8:1f:99:cf:f0 (try 2/3)
[  175.152056] wlan0: authenticate with ec:a8:1f:99:cf:f0
[  175.152081] wlan0: send auth to ec:a8:1f:99:cf:f0 (try 1/3)
[  175.163706] wlan0: authenticated
[  175.165434] wlan0: associate with ec:a8:1f:99:cf:f0 (try 1/3)
[  175.167738] wlan0: RX AssocResp from ec:a8:1f:99:cf:f0 (capab=3D0x1011 s=
tatus=3D0 aid=3D8)
[  175.169844] iwlwifi 0000:3a:00.0: Got NSS =3D 4 - trimming to 2
[  175.173841] wlan0: associated
[  175.275907] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready



(gdb) bt
#0  0x00005594b4940413 in netdev_sa_query_req_frame_event (hdr=3D0x5594b4a0=
79ec, body=3D0x5594b4a07a04, body_len=3D4, rssi=3D-75, user_data=3D0x5594b4=
a12c70)
    at src/netdev.c:4990
#1  0x00005594b49982b2 in frame_watch_unicast_notify (msg=3D<optimized out>=
, user_data=3D0x5594b4a11580) at src/frame-xchg.c:234
#2  0x00007fc8fe941a19 in dispatch_unicast_watches () from /usr/lib64/libel=
l.so.0
#3  0x00007fc8fe941ad1 in process_unicast () from /usr/lib64/libell.so.0
#4  0x00007fc8fe941f0b in received_data () from /usr/lib64/libell.so.0
#5  0x00007fc8fe93c692 in io_callback () from /usr/lib64/libell.so.0
#6  0x00007fc8fe93afe7 in l_main_iterate () from /usr/lib64/libell.so.0
#7  0x00007fc8fe93b12e in l_main_run () from /usr/lib64/libell.so.0
#8  0x00007fc8fe93b461 in l_main_run_with_signal () from /usr/lib64/libell.=
so.0
#9  0x00005594b493d53b in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>) at src/main.c:600
(gdb) info locals
sa_resp =3D "\000\000(a\253\004\374\177\000"
ptr =3D <optimized out>
transaction =3D <optimized out>
oci =3D 0x7fc8fe931bf7 <l_free+24> "\220\311\303UH\211\345H\203\354 H\211}\=
350H\203", <incomplete sequence \350>
netdev =3D <optimized out>
ocvc =3D <optimized out>
__func__ =3D "netdev_sa_query_req_frame_event"
(gdb) info args
hdr =3D 0x5594b4a079ec
body =3D 0x5594b4a07a04
body_len =3D 4
rssi =3D -75
user_data =3D 0x5594b4a12c70
--===============7206262279732541555==--

