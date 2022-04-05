Content-Type: multipart/mixed; boundary="===============3476597401271374139=="
MIME-Version: 1.0
From: Leonard Lausen <leonard at lausen.nl>
To: iwd at lists.01.org
Subject: Re: segfault in parse_neighbor_report at src/station.c:1747
Date: Tue, 05 Apr 2022 09:40:00 +0000
Message-ID: <1077324508f3b40f15026b53b08e46f2@lausen.nl>
In-Reply-To: 0a766997-050b-d871-6e07-1c8349140968@gmail.com

--===============3476597401271374139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

(resending as prior message to the iwd mailing-list was rejected as I was n=
ot a list member)

thank you for forwarding this report to the right mailing list. I'm
adding the debug log below. The router triggering the issue is
ec:a8:1f:99:cf:f0. I noticed that the issue will not occur when
disabling Band Steering on the router and splitting the 2.4G and 5G
networks into two separate SSIDs.

Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_start()
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/wiphy.c:wiphy_select_akm() N=
etwork is
WPA3-Personal...
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
Trying SSID: Vodafone-CFE4
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
'ec:a8:1f:99:cf:f0' freq: 5200, rank: 6553, strength: -6900
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
network_autoconnect: No such file or directory (-2)
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
Trying SSID: BrokoLi-Li
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
'38:10:d5:08:20:f1' freq: 2437, rank: 4045, strength: -6200
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
network_autoconnect: No such file or directory (-2)
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
Trying SSID: WLAN-124378
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
'e4:75:dc:98:9c:44' freq: 2462, rank: 2427, strength: -6900
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
network_autoconnect: No such file or directory (-2)
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
Trying SSID: FRITZ!Box 7530 ZB
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
'dc:39:6f:34:9d:41' freq: 2437, rank: 1941, strength: -7100
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
network_autoconnect: No such file or directory (-2)
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
Trying SSID: WLAN-396508
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
'4c:1b:86:1e:0e:2a' freq: 5500, rank: 1820, strength: -7600
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
network_autoconnect: No such file or directory (-2)
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
Trying SSID: WLAN-573272
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
'e4:3e:d7:ae:90:2a' freq: 2462, rank: 202, strength: -8000
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/station.c:station_autoconnec=
t_next() autoconnect:
network_autoconnect: No such file or directory (-2)
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/wiphy.c:wiphy_radio_work_don=
e() Work item 4 done
Apr 05 09:02:00 leonard-xps13 iwd[200772]: src/scan.c:scan_notify() Scan no=
tification Trigger
Scan(33)
Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/netdev.c:netdev_unicast_noti=
fy() Unicast
notification Frame(59)
Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/station.c:station_ap_directe=
d_roam() ifindex: 23
Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/station.c:station_ap_directe=
d_roam() roam: BSS
transition received from AP: Disassociation Time: 0, Validity interval: 100
Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/station.c:station_ap_directe=
d_roam() roam: AP sent a
preferred candidate list
Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/station.c:station_neighbor_r=
eport_cb() ifindex: 23,
error: 0()
Apr 05 09:02:01 leonard-xps13 iwd[200772]: src/station.c:parse_neighbor_rep=
ort() Neighbor report
received for ec:a8:1f:99:cf:e8: ch 6 (oper class 4), MD not set
Apr 05 09:02:01 leonard-xps13 systemd[1]: iwd.service: Main process exited,=
 code=3Ddumped,
status=3D11/SEGV
Apr 05 09:02:01 leonard-xps13 systemd[1]: iwd.service: Failed with result '=
core-dump'.

After enabling (to collect the debug logs) and disabling again Band
Steering on the router, AX210 would no longer authenticate with the
router "denied authentication (status 33)" and finally cause kernel
crash, followed by a kernel hang that could only be resolved by
restarting the WiFi network (by logging into the router admin interface
from my phone and changing WLAN Mode setting "Mixed 802.11 a/n/ac/ax" to
"Mixed 802.11 n/ac" which triggers the router to shutdown and start
again the WiFi network) followed by another crash. These are probably
unrelated to this issue, but you may know if and where I could report
them so I'm including them here. This was with AX210 firmware version
68.01d30b0c.0 ty-a0-gf-a0-68.ucode and Linux 5.17.0-rc8.

[176258.192776] wlan0: authenticate with ec:a8:1f:99:cf:f0
[176258.201868] wlan0: send auth to ec:a8:1f:99:cf:f0 (try 1/3)
[176258.233544] wlan0: ec:a8:1f:99:cf:f0 denied authentication (status 33)
[176274.389373] wlan0: authenticate with ec:a8:1f:99:cf:f0
[176274.400387] wlan0: send auth to ec:a8:1f:99:cf:f0 (try 1/3)
[176274.432542] wlan0: ec:a8:1f:99:cf:f0 denied authentication (status 33)
[176274.859586] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for al=
loc id 1, ret=3D-1
[176274.859594] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for al=
loc id 2, ret=3D-1
[176274.859598] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for al=
loc id 3, ret=3D-1
[176351.048358] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for al=
loc id 1, ret=3D-1
[176351.048376] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for al=
loc id 2, ret=3D-1
[176351.048378] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for al=
loc id 3, ret=3D-1
[176359.678548] wlan0: authenticate with ec:a8:1f:99:cf:f0
[176359.686995] wlan0: send auth to ec:a8:1f:99:cf:f0 (try 1/3)
[176359.747884] wlan0: authenticate with ec:a8:1f:99:cf:f0
[176359.747892] wlan0: send auth to ec:a8:1f:99:cf:f0 (try 1/3)
[176359.764000] wlan0: authenticated
[176359.770000] wlan0: associate with ec:a8:1f:99:cf:f0 (try 1/3)
[176359.771364] wlan0: RX AssocResp from ec:a8:1f:99:cf:f0 (capab=3D0x1011 =
status=3D0 aid=3D30)
[176359.777439] wlan0: associated
[176359.818315] warn_alloc: 2 callbacks suppressed
[176359.818324] kworker/0:2: page allocation failure: order:6, mode:0xcc0(G=
FP_KERNEL),
nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
[176359.818346] CPU: 0 PID: 201507 Comm: kworker/0:2 Tainted: G W 5.17.0-rc=
8 #4
[176359.818351] Hardware name: Dell Inc. XPS 13 9360/06CC14, BIOS 2.19.0 12=
/09/2021
[176359.818355] Workqueue: events iwl_mvm_add_new_dqa_stream_wk [iwlmvm]
[176359.818386] Call Trace:
[176359.818393] <TASK>
[176359.818396] dump_stack_lvl+0x48/0x5e
[176359.818411] warn_alloc+0xf4/0x172
[176359.818418] __alloc_pages_slowpath.constprop.0+0x674/0x6a4
[176359.818423] __alloc_pages+0x109/0x163
[176359.818425] __dma_direct_alloc_pages+0xac/0x143
[176359.818433] dma_direct_alloc+0x69/0xc1
[176359.818440] iwl_txq_alloc+0xda/0x1cc [iwlwifi]
[176359.818469] ? _raw_spin_unlock_irqrestore+0x1c/0x2d
[176359.818476] ? dma_pool_alloc+0x154/0x17e
[176359.818481] iwl_txq_dyn_alloc+0x10b/0x2cc [iwlwifi]
[176359.818499] iwl_mvm_tvqm_enable_txq+0xde/0xf3 [iwlmvm]
[176359.818523] iwl_mvm_sta_alloc_queue_tvqm.constprop.0+0x4b/0xa5 [iwlmvm]
[176359.818535] iwl_mvm_add_new_dqa_stream_wk+0x122/0x64f [iwlmvm]
[176359.818550] ? _raw_spin_unlock+0xf/0x20
[176359.818555] process_one_work+0x150/0x1f0
[176359.818560] worker_thread+0x190/0x231
[176359.818563] ? rescuer_thread+0x271/0x271
[176359.818566] kthread+0xde/0xe6
[176359.818572] ? kthread_complete_and_exit+0x16/0x16
[176359.818576] ret_from_fork+0x22/0x30
[176359.818585] </TASK>
[176359.818587] Mem-Info:
[176359.818591] active_anon:1260718 inactive_anon:2407881 isolated_anon:0
active_file:49690 inactive_file:37153 isolated_file:5
unevictable:36880 dirty:515 writeback:0
slab_reclaimable:73843 slab_unreclaimable:59723
mapped:252859 shmem:1518916 pagetables:23859 bounce:0
kernel_misc_reclaimable:0
free:47369 free_pcp:717 free_cma:0
[176359.818598] Node 0 active_anon:5042872kB inactive_anon:9631524kB active=
_file:198760kB
inactive_file:148612kB unevictable:147520kB isolated(anon):0kB isolated(fil=
e):20kB mapped:1011436kB
dirty:2060kB writeback:0kB shmem:6075664kB writeback_tmp:0kB kernel_stack:2=
9408kB
pagetables:95436kB all_unreclaimable? no
[176359.818606] DMA free:15360kB boost:0kB min:12kB low:24kB high:36kB rese=
rved_highatomic:0KB
active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevict=
able:0kB
writepending:0kB present:15984kB managed:15360kB mlocked:0kB bounce:0kB fre=
e_pcp:0kB local_pcp:0kB
free_cma:0kB
[176359.818614] lowmem_reserve[]: 0 1715 15408 15408
[176359.818620] DMA32 free:74376kB boost:0kB min:1768kB low:3524kB high:528=
0kB
reserved_highatomic:0KB active_anon:662092kB inactive_anon:966688kB active_=
file:8208kB
inactive_file:14564kB unevictable:4400kB writepending:0kB present:1822700kB=
 managed:1757064kB
mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[176359.818628] lowmem_reserve[]: 0 0 13692 13692
[176359.818631] Normal free:99740kB boost:0kB min:14112kB low:28132kB high:=
42152kB
reserved_highatomic:0KB active_anon:4380696kB inactive_anon:8665260kB activ=
e_file:189900kB
inactive_file:133760kB unevictable:142704kB writepending:1668kB present:146=
55484kB
managed:14346628kB mlocked:344kB bounce:0kB free_pcp:2868kB local_pcp:2236k=
B free_cma:0kB
[176359.818638] lowmem_reserve[]: 0 0 0 0
[176359.818641] DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512=
kB 1*1024kB (U) 1*2048kB
(U) 3*4096kB (M) =3D 15360kB
[176359.818655] DMA32: 374*4kB (UME) 1544*8kB (UME) 1573*16kB (UE) 913*32kB=
 (UME) 114*64kB (UE)
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 75528kB
[176359.818668] Normal: 3658*4kB (UME) 1496*8kB (UME) 528*16kB (UME) 1566*3=
2kB (UME) 232*64kB (UME)
1*128kB (M) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 100136kB
[176359.818682] 1667169 total pagecache pages
[176359.818684] 61336 pages in swap cache
[176359.818686] Swap cache stats: add 1099384, delete 1038007, find 179344/=
202866
[176359.818689] Free swap =3D 19063036kB
[176359.818690] Total swap =3D 20971516kB
[176359.818692] 4123542 pages RAM
[176359.818693] 0 pages HighMem/MovableOnly
[176359.818694] 93779 pages reserved
[176359.818701] iwlwifi 0000:3a:00.0: Tx queue alloc failed
[176359.866704] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[176359.936465] iwlwifi 0000:3a:00.0: Tx queue alloc failed
[176359.946571] iwlwifi 0000:3a:00.0: Tx queue alloc failed
[176359.950733] iwlwifi 0000:3a:00.0: Tx queue alloc failed
[176359.955170] iwlwifi 0000:3a:00.0: Tx queue alloc failed
[176402.909370] warn_alloc: 4 callbacks suppressed
[176402.909374] kworker/2:3: page allocation failure: order:6, mode:0xcc0(G=
FP_KERNEL),
nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
[176402.909388] CPU: 2 PID: 201624 Comm: kworker/2:3 Tainted: G W 5.17.0-rc=
8 #4
[176402.909392] Hardware name: Dell Inc. XPS 13 9360/06CC14, BIOS 2.19.0 12=
/09/2021
[176402.909395] Workqueue: events iwl_mvm_add_new_dqa_stream_wk [iwlmvm]
[176402.909415] Call Trace:
[176402.909418] <TASK>
[176402.909420] dump_stack_lvl+0x48/0x5e
[176402.909427] warn_alloc+0xf4/0x172
[176402.909432] __alloc_pages_slowpath.constprop.0+0x674/0x6a4
[176402.909436] __alloc_pages+0x109/0x163
[176402.909439] __dma_direct_alloc_pages+0xac/0x143
[176402.909444] dma_direct_alloc+0x69/0xc1
[176402.909448] iwl_txq_alloc+0xda/0x1cc [iwlwifi]
[176402.909464] ? _raw_spin_unlock_irqrestore+0x1c/0x2d
[176402.909468] ? dma_pool_alloc+0x154/0x17e
[176402.909472] iwl_txq_dyn_alloc+0x10b/0x2cc [iwlwifi]
[176402.909485] iwl_mvm_tvqm_enable_txq+0xde/0xf3 [iwlmvm]
[176402.909499] iwl_mvm_sta_alloc_queue_tvqm.constprop.0+0x4b/0xa5 [iwlmvm]
[176402.909510] iwl_mvm_add_new_dqa_stream_wk+0x122/0x64f [iwlmvm]
[176402.909521] ? _raw_spin_unlock+0xf/0x20
[176402.909524] process_one_work+0x150/0x1f0
[176402.909528] worker_thread+0x190/0x231
[176402.909531] ? rescuer_thread+0x271/0x271
[176402.909533] kthread+0xde/0xe6
[176402.909538] ? kthread_complete_and_exit+0x16/0x16
[176402.909541] ret_from_fork+0x22/0x30
[176402.909546] </TASK>
[176402.909547] Mem-Info:
[176402.909549] active_anon:1255524 inactive_anon:2464869 isolated_anon:0
active_file:49839 inactive_file:25419 isolated_file:0
unevictable:5877 dirty:137 writeback:0
slab_reclaimable:65583 slab_unreclaimable:58155
mapped:233552 shmem:1423234 pagetables:24962 bounce:0
kernel_misc_reclaimable:0
free:47909 free_pcp:138 free_cma:0
[176402.909555] Node 0 active_anon:5022096kB inactive_anon:9859476kB active=
_file:199356kB
inactive_file:101676kB unevictable:23508kB isolated(anon):0kB isolated(file=
):0kB mapped:934208kB
dirty:548kB writeback:0kB shmem:5692936kB writeback_tmp:0kB kernel_stack:30=
112kB pagetables:99848kB
all_unreclaimable? no
[176402.909560] DMA free:15360kB boost:0kB min:12kB low:24kB high:36kB rese=
rved_highatomic:0KB
active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevict=
able:0kB
writepending:0kB present:15984kB managed:15360kB mlocked:0kB bounce:0kB fre=
e_pcp:0kB local_pcp:0kB
free_cma:0kB
[176402.909565] lowmem_reserve[]: 0 1715 15408 15408
[176402.909568] DMA32 free:66008kB boost:0kB min:1768kB low:3524kB high:528=
0kB
reserved_highatomic:0KB active_anon:669020kB inactive_anon:983544kB active_=
file:8208kB
inactive_file:5508kB unevictable:0kB writepending:0kB present:1822700kB man=
aged:1757064kB
mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[176402.909574] lowmem_reserve[]: 0 0 13692 13692
[176402.909577] Normal free:110268kB boost:0kB min:14112kB low:28132kB high=
:42152kB
reserved_highatomic:0KB active_anon:4353076kB inactive_anon:8875876kB activ=
e_file:190868kB
inactive_file:96168kB unevictable:23508kB writepending:548kB present:146554=
84kB managed:14346628kB
mlocked:344kB bounce:0kB free_pcp:552kB local_pcp:28kB free_cma:0kB
[176402.909582] lowmem_reserve[]: 0 0 0 0
[176402.909586] DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512=
kB 1*1024kB (U) 1*2048kB
(U) 3*4096kB (M) =3D 15360kB
[176402.909600] DMA32: 74*4kB (ME) 73*8kB (UME) 466*16kB (UME) 984*32kB (UE=
) 422*64kB (UE) 0*128kB
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 66832kB
[176402.909614] Normal: 7259*4kB (UME) 453*8kB (UME) 268*16kB (UME) 1771*32=
kB (UME) 267*64kB (UME)
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 110708kB
[176402.909628] 1572653 total pagecache pages
[176402.909630] 74076 pages in swap cache
[176402.909631] Swap cache stats: add 1512864, delete 1438940, find 189045/=
217538
[176402.909634] Free swap =3D 17492476kB
[176402.909635] Total swap =3D 20971516kB
[176402.909637] 4123542 pages RAM
[176402.909638] 0 pages HighMem/MovableOnly
[176402.909639] 93779 pages reserved
[176402.909642] iwlwifi 0000:3a:00.0: Tx queue alloc failed
[176402.910362] iwlwifi 0000:3a:00.0: Tx queue alloc failed
[176468.720326] wlan0: AP ec:a8:1f:99:cf:f0 changed bandwidth, new config i=
s 5200.000 MHz, width 3
(5210.000/0 MHz)
[176508.877550] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for al=
loc id 1, ret=3D-1
[176508.877565] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for al=
loc id 2, ret=3D-1
[176508.877570] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for al=
loc id 3, ret=3D-1
[176561.647870] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for al=
loc id 1, ret=3D-1
[176561.647877] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for al=
loc id 2, ret=3D-1
[176561.647879] iwlwifi 0000:3a:00.0: WRT: Failed to set DRAM buffer for al=
loc id 3, ret=3D-1
[176566.341409] wlan0: authenticate with 2a:bd:da:43:fc:82
[176566.341472] wlan0: 80 MHz not supported, disabling VHT
[176566.346289] wlan0: send auth to 2a:bd:da:43:fc:82 (try 1/3)
[176566.383631] wlan0: authenticated
[176566.384733] wlan0: associate with 2a:bd:da:43:fc:82 (try 1/3)
[176566.395587] wlan0: RX AssocResp from 2a:bd:da:43:fc:82 (capab=3D0x1431 =
status=3D0 aid=3D1)
[176566.417951] wlan0: associated

Thank you
Leonard

April 4, 2022 6:38 PM, "Denis Kenzior" <denkenz(a)gmail.com> wrote:

> Hi Leonard,
> =

> On 4/3/22 12:27, Leonard Lausen wrote:
> =

>> Hi all,
>> connecting a laptop with Intel=C2=AE Wi-Fi 6E AX210 to a Vodafone Wi-Fi 6
>> Station sometimes triggers a segfault with ell 0.49 and iwd 1.26 in
>> parse_neighbor_report at src/station.c:1747. Earlier versions of ell and
>> iwd also segfault. Please see below excerpts from gdb. I can share the
>> full coredump if helpful. In case you require any further information or
>> would like me to test a fix, please note I will only have access to this
>> Station until Thursday April 7th.
> =

> Thanks for the report. This should have gone to the iwd mailing list whic=
h I CC-ed.
> =

> Can you provide iwd debug logs prior to the crash? See:
> https://iwd.wiki.kernel.org/debugging#enabling_iwd_debug_output
> =

>> Program terminated with signal SIGSEGV, Segmentation fault.
>> #0 0x000055f07250580e in parse_neighbor_report (station=3Dstation(a)entr=
y=3D0x55f0725c8e50,
>> reports=3Dreports(a)entry=3D0x55f0725cc35b "4\025\354\250\037\231\317", =
<incomplete sequence \350>,
>> reports_len=3Dreports_len(a)entry=3D23,
>> set=3Dset(a)entry=3D0x7ffca3384ee0) at src/station.c:1747
>> 1747 cc =3D station->connected_bss->cc;
> =

> Just thinking out loud, feel free to ignore below:
> =

> This would seem to imply that connected_bss is somehow not valid (we're n=
ot connected.) 'hs' being
> NULL also suggests this. But it isn't clear how we would end up in this f=
unction since
> 'preparing_roam' should also be false in this case.
> =

>> (gdb) bt
>> #0 0x000055f07250580e in parse_neighbor_report (station=3Dstation(a)entr=
y=3D0x55f0725c8e50,
>> reports=3Dreports(a)entry=3D0x55f0725cc35b "4\025\354\250\037\231\317", =
<incomplete sequence \350>,
>> reports_len=3Dreports_len(a)entry=3D23,
>> set=3Dset(a)entry=3D0x7ffca3384ee0) at src/station.c:1747
>> #1 0x000055f07250928b in station_neighbor_report_cb (netdev=3D<optimized=
 out>, err=3D0,
>> reports=3D0x55f0725cc35b "4\025\354\250\037\231\317", <incomplete sequen=
ce \350>, reports_len=3D23,
>> user_data=3D0x55f0725c8e50) at src/station.c:2481
>> #2 0x000055f07254f282 in frame_watch_unicast_notify (msg=3D<optimized ou=
t>, user_data=3D0x55f0725c8580)
>> at src/frame-xchg.c:234
>> #3 0x00007f8a4b3cca19 in dispatch_unicast_watches () from /usr/lib64/lib=
ell.so.0
>> #4 0x00007f8a4b3ccad1 in process_unicast () from /usr/lib64/libell.so.0
>> #5 0x00007f8a4b3ccf0b in received_data () from /usr/lib64/libell.so.0
>> #6 0x00007f8a4b3c7692 in io_callback () from /usr/lib64/libell.so.0
>> #7 0x00007f8a4b3c5fe7 in l_main_iterate () from /usr/lib64/libell.so.0
>> #8 0x00007f8a4b3c612e in l_main_run () from /usr/lib64/libell.so.0
>> #9 0x00007f8a4b3c6461 in l_main_run_with_signal () from /usr/lib64/libel=
l.so.0
>> #10 0x000055f0724f453b in main (argc=3D<optimized out>, argv=3D<optimize=
d out>) at src/main.c:600
>> (gdb) l
>> 1742 util_address_to_string(info.addr),
>> 1743 (int) info.channel_num, (int) info.oper_class,
>> 1744 info.md ? "MD set" : "MD not set");
>> 1745
>> 1746 if (station->connected_bss->cc_present)
>> 1747 cc =3D station->connected_bss->cc;
>> 1748
>> 1749 freq =3D station_freq_from_neighbor_report(cc, &info, &band);
>> 1750 if (!freq)
>> 1751 continue;
>> (gdb) info locals
>> info =3D {addr =3D "\354\250\037\231\317", <incomplete sequence \350>, r=
eachable =3D 0 '\000',
>> spectrum_mgmt =3D false, qos =3D false, apsd =3D false, rm =3D false,
>> delayed_block_ack =3D false, immediate_block_ack =3D false, security =3D=
 false, key_scope =3D false, md =3D
>> false, ht =3D false, oper_class =3D 4 '\004',
>> channel_num =3D 11 '\v', phy_type =3D 0 '\000', bss_transition_pref =3D =
255 '\377',
>> bss_transition_pref_present =3D true}
>> freq =3D <optimized out>
>> band =3D <optimized out>
>> cc =3D 0x0
>> iter =3D {max =3D 23, pos =3D 23, tlv =3D 0x55f0725cc35b "4\025\354\250\=
037\231\317", <incomplete sequence
>> \350>, tag =3D 52, len =3D 21,
>> data =3D 0x55f0725cc35d "\354\250\037\231\317", <incomplete sequence \35=
0>}
>> count_md =3D 0
>> count_no_md =3D 0
>> freq_set_md =3D 0x55f0725d33f0
>> freq_set_no_md =3D 0x55f0725d5420
>> current_freq =3D 0
>> hs =3D 0x0
>> supported =3D 0x55f0725c4cc0
>> __func__ =3D "parse_neighbor_report"
>> (gdb) info args
>> station =3D 0x55f0725c8e50
>> reports =3D 0x55f0725cc35b "4\025\354\250\037\231\317", <incomplete sequ=
ence \350>
>> reports_len =3D 23
>> set =3D 0x7ffca3384ee0
>> Thank you
>> Leonard
> =

> Regards,
> -Denis
--===============3476597401271374139==--

