Content-Type: multipart/mixed; boundary="===============3136797034010463707=="
MIME-Version: 1.0
From: =?utf-8?q?Alvin_=C5=A0ipraga_=3Calvin_at_pqrs=2Edk=3E?=
To: iwd at lists.01.org
Subject: Re: iwd stuck 'connecting', out-of-order wiphy work queue?
Date: Thu, 28 Apr 2022 17:00:01 +0200
Message-ID: <20220428150001.ey2lj57pdiidjzlr@pqrs.dk>
In-Reply-To: 20220428144446.uaagkaurxypzjs5k@bang-olufsen.dk

--===============3136797034010463707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I noticed that my mail might be going into spam, so this is a small ping to=
 the
list from my other email. Let me know if I should re-send the whole thread.

On Thu, Apr 28, 2022 at 02:44:47PM +0000, Alvin =C5=A0ipraga wrote:
> On Wed, Apr 27, 2022 at 03:13:23PM +0000, Alvin =C5=A0ipraga wrote:
> > Hi,
> > =

> > While running some automated tests for our product, I managed to make i=
wd get
> > stuck in 'connecting' state. I haven't cracked open gdb just yet, but I=
 would
> > like to report my findings here in case somebody can give me some point=
ers as I
> > continue looking into it tomorrow.
> > =

> > The automated test essentially does some scans and requests iwd to conn=
ect to a
> > particular network. The network is not known, as iwd's saved data is er=
ased at
> > the start of the test sequence. I invoke instances of iwctl to run the =
scans and
> > request the connection.
> > =

> > The bug: sometimes the connect request will get stuck and iwd will stay=
 in
> > 'connecting' state until I issue a disconnect.
> > =

> > Looking closely at the logs, and also with iwmon, I noticed that no con=
nect
> > command is actually sent over netlink to the kernel. So iwd is getting =
stuck
> > before then.
> > =

> > Moreover, it seems like it might be getting stuck because the wiphy wor=
k queue
> > goes out-of-order somehow? Check this snippet from the logs:
> > =

> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 1
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 1 done
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 2
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 3
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 2 done
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 3
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 4
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 3 done
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_next() Starting work item 5 <-=
-- 5 is started...
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_done() Work item 4 done     <-=
-- 4 is done?!
> > ../iwd-1.26/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 6
> > =

> > A brief look at the code and I can't really understand how work item 4 =
could be
> > done when it was never started. Moreover, work item 5 gets started, but=
 is never
> > done. Meanwhile, work item 6 (which I suspect to be the connect command=
) never
> > starts.
> =

> OK, I couldn't make much sense of this because it appears to be a race in=
 the
> scan code between a user-initiated scan and periodic scan. Here's what I =
observed in gdb:
> =

> ----------->8----------------------------------------------------------
> =

> Breakpoint 4, wiphy_radio_work_insert (wiphy=3D0xaaaaaabe6370, item=3Dite=
m(a)entry=3D0xaaaaaabfb3b0, =

>     priority=3Dpriority(a)entry=3D3, ops=3Dops(a)entry=3D0xaaaaaabd23d0 <=
work_ops>)
>     at ../../../../../../workspace/sources/iwd/src/wiphy.c:1990
> 1990	in ../../../../../../workspace/sources/iwd/src/wiphy.c
> (gdb) bt
> #0  wiphy_radio_work_insert (wiphy=3D0xaaaaaabe6370, item=3Ditem(a)entry=
=3D0xaaaaaabfb3b0, =

>     priority=3Dpriority(a)entry=3D3, ops=3Dops(a)entry=3D0xaaaaaabd23d0 <=
work_ops>)
>     at ../../../../../../workspace/sources/iwd/src/wiphy.c:1990
> #1  0x0000aaaaaaad6b18 in scan_common (wdev_id=3D<optimized out>, passive=
=3Dpassive(a)entry=3Dtrue, =

>     params=3Dparams(a)entry=3D0xfffffffff8c0, priority=3Dpriority(a)entry=
=3D3, =

>     trigger=3Dtrigger(a)entry=3D0xaaaaaaad4820 <scan_periodic_triggered>, =

> c    notify=3Dnotify(a)entry=3D0xaaaaaaad47b0 <scan_periodic_notify>, use=
rdata=3Duserdata(a)entry=3D0xaaaaaabef130, =

>     destroy=3Ddestroy(a)entry=3D0xaaaaaaad4410 <scan_periodic_destroy>)
>     at ../../../../../../workspace/sources/iwd/src/scan.c:635
> #2  0x0000aaaaaaad6bf8 in scan_periodic_queue (sc=3D0xaaaaaabef130)
>     at ../../../../../../workspace/sources/iwd/src/scan.c:928
> #3  0x0000aaaaaab38650 in timeout_callback (fd=3D<optimized out>, events=
=3D<optimized out>, =

>     user_data=3D0xaaaaaabf5b50) at ../../../../../../workspace/sources/iw=
d/ell/timeout.c:83
> #4  timeout_callback (fd=3D<optimized out>, events=3D<optimized out>, use=
r_data=3D0xaaaaaabf5b50)
>     at ../../../../../../workspace/sources/iwd/ell/timeout.c:72
> =

> #5  0x0000aaaaaab37c38 in l_main_iterate (timeout=3D<optimized out>)
>     at ../../../../../../workspace/sources/iwd/ell/main.c:478
> #6  0x0000aaaaaab37d20 in l_main_run () at ../../../../../../workspace/so=
urces/iwd/ell/main.c:525
> #7  l_main_run () at ../../../../../../workspace/sources/iwd/ell/main.c:5=
07
> #8  0x0000aaaaaab37f44 in l_main_run_with_signal (
>     callback=3Dcallback(a)entry=3D0xaaaaaaaaf530 <signal_handler>, user_d=
ata=3Duser_data(a)entry=3D0x0)
>     at ../../../../../../workspace/sources/iwd/ell/main.c:647
> #9  0x0000aaaaaaaae834 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>)
>     at ../../../../../../workspace/sources/iwd/src/main.c:600
> (gdb) c
> Continuing.
> =

> Breakpoint 4, wiphy_radio_work_insert (wiphy=3D0xaaaaaabe6370, item=3Dite=
m(a)entry=3D0xaaaaaac01cf0, =

>     priority=3Dpriority(a)entry=3D2, ops=3Dops(a)entry=3D0xaaaaaabd23d0 <=
work_ops>)
>     at ../../../../../../workspace/sources/iwd/src/wiphy.c:1990
> 1990	in ../../../../../../workspace/sources/iwd/src/wiphy.c
> (gdb) bt
> #0  wiphy_radio_work_insert (wiphy=3D0xaaaaaabe6370, item=3Ditem(a)entry=
=3D0xaaaaaac01cf0, =

>     priority=3Dpriority(a)entry=3D2, ops=3Dops(a)entry=3D0xaaaaaabd23d0 <=
work_ops>)
>     at ../../../../../../workspace/sources/iwd/src/wiphy.c:1990
> #1  0x0000aaaaaaad6b18 in scan_common (wdev_id=3D<optimized out>, wdev_id=
(a)entry=3D1, =

> c    passive=3Dpassive(a)entry=3Dtrue, params=3Dparams(a)entry=3D0xffffff=
ffd710, priority=3Dpriority(a)entry=3D2, =

>     trigger=3Dtrigger(a)entry=3D0xaaaaaaac6400 <station_dbus_scan_trigger=
ed>, =

>     notify=3Dnotify(a)entry=3D0xaaaaaaac7070 <station_dbus_scan_results>, =

>     userdata=3Duserdata(a)entry=3D0xaaaaaabeefc0, destroy=3Ddestroy(a)ent=
ry=3D0x0)
>     at ../../../../../../workspace/sources/iwd/src/scan.c:635
> #2  0x0000aaaaaaad6f44 in scan_passive_full (wdev_id=3Dwdev_id(a)entry=3D=
1, =

>     params=3Dparams(a)entry=3D0xffffffffd710, =

>     trigger=3Dtrigger(a)entry=3D0xaaaaaaac6400 <station_dbus_scan_trigger=
ed>, =

>     notify=3Dnotify(a)entry=3D0xaaaaaaac7070 <station_dbus_scan_results>, =

>     userdata=3Duserdata(a)entry=3D0xaaaaaabeefc0, destroy=3Ddestroy(a)ent=
ry=3D0x0)
>     at ../../../../../../workspace/sources/iwd/src/scan.c:655
> =

> #3  0x0000aaaaaaac1d50 in station_scan_trigger (station=3Dstation(a)entry=
=3D0xaaaaaabeefc0, =

>     freqs=3D0xaaaaaabf11a0, triggered=3Dtriggered(a)entry=3D0xaaaaaaac640=
0 <station_dbus_scan_triggered>, =

>     notify=3Dnotify(a)entry=3D0xaaaaaaac7070 <station_dbus_scan_results>,=
 destroy=3Ddestroy(a)entry=3D0x0)
>     at ../../../../../../workspace/sources/iwd/src/station.c:1295
> #4  0x0000aaaaaaac71b0 in station_dbus_scan_subset (station=3D0xaaaaaabee=
fc0)
>     at ../../../../../../workspace/sources/iwd/src/station.c:3581
> #5  station_dbus_scan_results (err=3D<optimized out>, bss_list=3D<optimiz=
ed out>, freqs=3D<optimized out>, =

>     userdata=3D0xaaaaaabeefc0) at ../../../../../../workspace/sources/iwd=
/src/station.c:3571
> #6  0x0000aaaaaaad4be0 in scan_finished (sc=3Dsc(a)entry=3D0xaaaaaabef130=
, err=3Derr(a)entry=3D0, =

>     bss_list=3D0xaaaaaabfa7a0, freqs=3D0xaaaaaabfaa30, sr=3D0xaaaaaabfb74=
0)
>     at ../../../../../../workspace/sources/iwd/src/scan.c:1778
> #7  0x0000aaaaaaad4cd8 in get_scan_done (user=3D0xaaaaaabf9b70)
>     at ../../../../../../workspace/sources/iwd/src/scan.c:1808
> #8  0x0000aaaaaab3c1a8 in destroy_request (data=3D0xaaaaaabe51a0)
>     at ../../../../../../workspace/sources/iwd/ell/genl.c:674
> #9  process_unicast (nlmsg=3D0xffffffffd8e8, genl=3D0xaaaaaabdab10 <buf+1=
6>)
>     at ../../../../../../workspace/sources/iwd/ell/genl.c:995
> #10 received_data (io=3D<optimized out>, user_data=3D0xaaaaaabdab10 <buf+=
16>)
> --Type <RET> for more, q to quit, c to continue without paging--c
>     at ../../../../../../workspace/sources/iwd/ell/genl.c:1098
> #11 0x0000aaaaaab38b48 in io_callback (fd=3D<optimized out>, events=3D1, =
user_data=3D0xaaaaaabdabb0 <buf+32>) at ../../../../../../workspace/sources=
/iwd/ell/io.c:120
> #12 0x0000aaaaaab37c38 in l_main_iterate (timeout=3D<optimized out>) at .=
./../../../../../workspace/sources/iwd/ell/main.c:478
> #13 0x0000aaaaaab37d20 in l_main_run () at ../../../../../../workspace/so=
urces/iwd/ell/main.c:525
> #14 l_main_run () at ../../../../../../workspace/sources/iwd/ell/main.c:5=
07
> #15 0x0000aaaaaab37f44 in l_main_run_with_signal (callback=3Dcallback(a)e=
ntry=3D0xaaaaaaaaf530 <signal_handler>, user_data=3Duser_data(a)entry=3D0x0=
) at ../../../../../../workspace/sources/iwd/ell/main.c:647
> #16 0x0000aaaaaaaae834 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>) at ../../../../../../workspace/sources/iwd/src/main.c:600
> (gdb) c
> Continuing.
> =

> Breakpoint 5, wiphy_radio_work_done (wiphy=3D0xaaaaaabe6370, id=3D4)
>     at ../../../../../../workspace/sources/iwd/src/wiphy.c:2013
> 2013	in ../../../../../../workspace/sources/iwd/src/wiphy.c
> =

> -----------8<----------------------------------------------------------
> =

> However, the bottom line seems to be that the out-of-order work causes us=
 not to
> immediately queue the next work item in wiphy_radio_work_done():
> =

> void wiphy_radio_work_done(struct wiphy *wiphy, uint32_t id)
> {
> 	struct wiphy_radio_work_item *item;
> 	bool next =3D false;
> =

> 	item =3D l_queue_peek_head(wiphy->work);
> 	if (!item)
> 		return;
> =

> 	if (item->id =3D=3D id) {
> 		next =3D true;
> 		l_queue_pop_head(wiphy->work);
> 	} else
> 		item =3D l_queue_remove_if(wiphy->work, match_id,
> 						L_UINT_TO_PTR(id));
> =

> 	/* ... */
> =

> 	if (next)
> 		wiphy_radio_work_next(wiphy);
> }
> =

> Specifically, the id that wiphy_radio_work_done() gets called with (4) do=
esn't
> match the id of the work on top of the queue (5). So next stays false and=
 we
> don't call wiphy_radio_work_next().
> =

> Can anybody explain what the reason for this 'next' variable is? It seems=
 like
> we would always want to start the next work, no?
> =

> Not that this is a fix to the out-of-order work (start 4, done 5, see abo=
ve),
> but I could work around iwd getting stuck by refactoring the above functi=
on
> according to the attached patch. Basically I just removed the logic of th=
is
> 'next' variable and unconditionally call wiphy_radio_work_next().
> =

> The result is something like this:
> =

> ../iwd/src/wiphy.c:wiphy_radio_work_next() Starting work item 3
> ../iwd/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 4
> ../iwd/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5
> ../iwd/src/wiphy.c:wiphy_radio_work_done() Work item 3 done
> ../iwd/src/wiphy.c:wiphy_radio_work_next() Starting work item 5 <-- somet=
hing is
> ../iwd/src/wiphy.c:wiphy_radio_work_done() Work item 4 done     <-- still=
 wrong...
> ../iwd/src/wiphy.c:wiphy_radio_work_next() Starting work item 5
> ../iwd/src/wiphy.c:wiphy_radio_work_done() Work item 5 done
> ../iwd/src/wiphy.c:wiphy_radio_work_insert() Inserting work item 6
> ../iwd/src/wiphy.c:wiphy_radio_work_next() Starting work item 6
> ../iwd/src/wiphy.c:wiphy_radio_work_done() Work item 6 done
> =

> Hope that helps a bit...
> =

> Kind regards,
> Alvin
> =

> > =

> > I've attached the logs, so any hints are very welcome. This is with iwd=
 v1.26.
> > =

> > Kind regards,
> > Alvin
> =

> > Apr 27 16:34:28 iwd[5117]: Wireless daemon version 1.26
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/main.c:main() Using configur=
ation directory /etc/iwd
> > Apr 27 16:34:28 iwd[5117]: Loaded configuration from /etc/iwd/main.conf
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/storage.c:storage_create_dir=
s() Using state directory /var/lib/iwd
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/main.c:nl80211_appeared() Fo=
und nl80211 interface
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/module.c:iwd_modules_init()
> > Apr 27 16:34:28 iwd[5117]: station: Network configuration is disabled.
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/wsc.c:wsc_init()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/knownnetworks.c:known_networ=
k_frequencies_load() No known frequency file found.
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/eap.c:__eap_method_enable()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/eap-wsc.c:eap_wsc_init()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/eap-md5.c:eap_md5_init()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/eap-tls.c:eap_tls_init()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/eap-ttls.c:eap_ttls_init()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/eap-mschapv2.c:eap_mschapv2_=
init()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/eap-sim.c:eap_sim_init()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/eap-aka.c:eap_aka_prime_init=
()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/eap-aka.c:eap_aka_init()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/eap-peap.c:eap_peap_init()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/eap-gtc.c:eap_gtc_init()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/eap-pwd.c:eap_pwd_init()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/manager.c:manager_wiphy_dump=
_callback() New wiphy phy0 added (0)
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/manager.c:manager_wiphy_dump=
_done()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/manager.c:manager_filtered_w=
iphy_dump_done()
> > Apr 27 16:34:28 iwd[5117]: Wiphy: 0, Name: phy0
> > Apr 27 16:34:28 iwd[5117]:         Permanent Address: 10:98:c3:ff:29:38
> > Apr 27 16:34:28 iwd[5117]:         2.4Ghz Band:
> > Apr 27 16:34:28 iwd[5117]:                 Bitrates (non-HT):
> > Apr 27 16:34:28 iwd[5117]:                          1.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                          2.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                          5.5 Mbps
> > Apr 27 16:34:28 iwd[5117]:                         11.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                          6.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                          9.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                         12.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                         18.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                         24.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                         36.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                         48.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                         54.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                 HT Capabilities:
> > Apr 27 16:34:28 iwd[5117]:                         HT40
> > Apr 27 16:34:28 iwd[5117]:                         Short GI for 20Mhz
> > Apr 27 16:34:28 iwd[5117]:                         Short GI for 40Mhz
> > Apr 27 16:34:28 iwd[5117]:                 HT RX MCS indexes:
> > Apr 27 16:34:28 iwd[5117]:                         0-7
> > Apr 27 16:34:28 iwd[5117]:         5Ghz Band:
> > Apr 27 16:34:28 iwd[5117]:                 Bitrates (non-HT):
> > Apr 27 16:34:28 iwd[5117]:                          6.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                          9.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                         12.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                         18.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                         24.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                         36.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                         48.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                         54.0 Mbps
> > Apr 27 16:34:28 iwd[5117]:                 HT Capabilities:
> > Apr 27 16:34:28 iwd[5117]:                         HT40
> > Apr 27 16:34:28 iwd[5117]:                         Short GI for 20Mhz
> > Apr 27 16:34:28 iwd[5117]:                         Short GI for 40Mhz
> > Apr 27 16:34:28 iwd[5117]:                 HT RX MCS indexes:
> > Apr 27 16:34:28 iwd[5117]:                         0-7
> > Apr 27 16:34:28 iwd[5117]:                 VHT Capabilities:
> > Apr 27 16:34:28 iwd[5117]:                         Short GI for 80Mhz
> > Apr 27 16:34:28 iwd[5117]:                         Max RX MCS: 0-9 for =
NSS: 1
> > Apr 27 16:34:28 iwd[5117]:                         Max TX MCS: 0-9 for =
NSS: 1
> > Apr 27 16:34:28 iwd[5117]:         Ciphers: CCMP TKIP BIP
> > Apr 27 16:34:28 iwd[5117]:         Supported iftypes: ad-hoc station ap=
 p2p-client p2p-go p2p-device
> > Apr 27 16:34:28 iwd[5117]: Wiphy phy0 will only use the default interfa=
ce
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/manager.c:manager_interface_=
dump_callback()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/manager.c:manager_get_interf=
ace_cb()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/manager.c:manager_interface_=
dump_callback()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/manager.c:manager_get_interf=
ace_cb()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/manager.c:manager_interface_=
dump_callback()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/manager.c:manager_get_interf=
ace_cb()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/manager.c:manager_interface_=
dump_done()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/manager.c:manager_use_defaul=
t()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/netdev.c:netdev_create_from_=
genl() Created interface wlan0[8 1]
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_update_reg_dom=
ain() New reg domain country code for phy0 is 99
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/netdev.c:netdev_link_notify(=
) event 16 on ifindex 8
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/netdev.c:netdev_set_4addr() =
netdev: 8 use_4addr: 0
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/netdev.c:netdev_initial_up_c=
b() Interface 8 initialized
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/station.c:station_enter_stat=
e() Old State: disconnected, new state: autoconnect_quick
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/scan.c:scan_periodic_start()=
 Starting periodic scan for wdev 1
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_ins=
ert() Inserting work item 1
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_nex=
t() Starting work item 1
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/rrm.c:rrm_add_frame_watches()
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/manager.c:manager_config_not=
ify() Notification of command Set Interface(6)
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/scan.c:scan_notify() Scan no=
tification Trigger Scan(33)
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/scan.c:scan_request_triggere=
d() Passive scan triggered for wdev 1
> > Apr 27 16:34:28 iwd[5117]: ../iwd-1.26/src/scan.c:scan_periodic_trigger=
ed() Periodic scan triggered for wdev 1
> > Apr 27 16:34:29 iwd[5117]: ../iwd-1.26/src/netdev.c:netdev_link_notify(=
) event 16 on ifindex 9
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_notify() Scan no=
tification New Scan Results(34)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/netdev.c:netdev_link_notify(=
) event 16 on ifindex 8
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 184/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 181/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 168/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 95/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 95/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 84/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 84/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 89/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 89/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 131/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 131/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 108/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 108/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 91/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 102/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 111/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 39/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 12/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 12/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 12/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 12/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 25/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 25/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 25/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 25/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 30/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 10/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 10/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 10/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 30/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 140/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 127/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 143/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 121/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 121/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 2/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 43/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 43/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: wiphy_estimate_data_rate() failed
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_done() get_s=
can_done
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/scan.c:scan_periodic_rearm()=
 Arming periodic scan timer: 10
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:07:b6:81:7e:59' with SSID: =E2=98=A0=EF=B8=8Fautote=
st_dev=E2=98=A0=EF=B8=8F, freq: 5180, rank: 9102, strength: -5500, data_rat=
e: 325.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "=E2=98=A0=EF=B8=8Fautotest_dev=E2=98=A0=EF=B8=8F" s=
ecurity psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:07:b6:81:7e:59' with SSID: , freq: 5180, rank: 9102=
, strength: -5600, data_rate: 325.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '3c:84:6a:aa:29:d5' with SSID: beolink_5g, freq: 5180, =
rank: 7281, strength: -6000, data_rate: 260.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "beolink_5g" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '4e:84:6a:aa:29:d5' with SSID: , freq: 5180, rank: 7281=
, strength: -6000, data_rate: 260.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:f0:21:88:56:ef' with SSID: titan, freq: 5180, rank:=
 5601, strength: -3200, data_rate: 200.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "titan" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:e8:27' with SSID: , freq: 5220, rank: 5601=
, strength: -5100, data_rate: 200.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:e8:27' with SSID: hejlsberg_5G, freq: 5220=
, rank: 5601, strength: -5100, data_rate: 200.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "hejlsberg_5G" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '14:91:82:bd:d1:84' with SSID: Linksys05274_5GHz_dmt, f=
req: 5220, rank: 5461, strength: -6300, data_rate: 195.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "Linksys05274_5GHz_dmt" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:d4:c4:c4:24:f4' with SSID: esp32_network_5G, freq: =
5300, rank: 4368, strength: -6700, data_rate: 130.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "esp32_network_5G" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:47:32:3d:36:2d' with SSID: , freq: 5240, rank: 3640=
, strength: -6500, data_rate: 130.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '90:9a:4a:4d:f3:7a' with SSID: , freq: 5580, rank: 3640=
, strength: -6600, data_rate: 130.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:47:32:3d:36:2d' with SSID: speakerlink_5g, freq: 52=
40, rank: 3640, strength: -6600, data_rate: 130.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "speakerlink_5g" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'b4:75:0e:3f:98:c2' with SSID: Linksys00560_5GHz, freq:=
 5220, rank: 3640, strength: -6700, data_rate: 130.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "Linksys00560_5GHz" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ff:7b:ef:5a:a0' with SSID: , freq: 5180, rank: 3640=
, strength: -6800, data_rate: 130.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'c0:56:27:61:4b:a7' with SSID: TEJO, freq: 5180, rank: =
2696, strength: -4800, data_rate: 96.3
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "TEJO" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:ed:d1' with SSID: , freq: 5200, rank: 2520=
, strength: -6400, data_rate: 90.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:ea:99' with SSID: , freq: 5220, rank: 2520=
, strength: -6500, data_rate: 90.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:ea:99' with SSID: hejlsberg_5G, freq: 5220=
, rank: 2520, strength: -6500, data_rate: 90.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:ed:d1' with SSID: hejlsberg_5G, freq: 5200=
, rank: 2520, strength: -6500, data_rate: 90.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:f7:92' with SSID: , freq: 5200, rank: 2520=
, strength: -6500, data_rate: 90.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:f7:92' with SSID: hejlsberg_5G, freq: 5200=
, rank: 2520, strength: -6600, data_rate: 90.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:f8:1a' with SSID: , freq: 5200, rank: 2520=
, strength: -6700, data_rate: 90.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:f8:1a' with SSID: hejlsberg_5G, freq: 5200=
, rank: 2520, strength: -6700, data_rate: 90.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:af' with SSID: BEOLAN, freq: 5500, rank=
: 2427, strength: -6200, data_rate: 72.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "BEOLAN" security 8021x
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:ac' with SSID: BEOMTV, freq: 5500, rank=
: 2427, strength: -6300, data_rate: 72.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "BEOMTV" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:ad' with SSID: BEOGUEST, freq: 5500, ra=
nk: 2427, strength: -6300, data_rate: 72.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "BEOGUEST" security open
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:ae' with SSID: BeoAccess, freq: 5500, r=
ank: 2427, strength: -6300, data_rate: 72.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "BeoAccess" security 8021x
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:07:b6:81:7e:5a' with SSID: , freq: 2417, rank: 2022=
, strength: -5900, data_rate: 72.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'c4:93:00:19:d4:38' with SSID: EMAS_2g, freq: 2437, ran=
k: 2022, strength: -6400, data_rate: 72.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "EMAS_2g" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:9a:83:0e' with SSID: _beo_products, freq: 564=
0, rank: 1941, strength: -6600, data_rate: 57.8
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "_beo_products" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:9a:83:0f' with SSID: BeoBlue, freq: 5640, ran=
k: 1941, strength: -6600, data_rate: 57.8
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "BeoBlue" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:07:b6:81:7e:5a' with SSID: =E2=98=A0=EF=B8=8Fautote=
st_dev=E2=98=A0=EF=B8=8F, freq: 2417, rank: 1820, strength: -6500, data_rat=
e: 65.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:f0:21:88:54:78' with SSID: fts, freq: 2412, rank: 1=
512, strength: -4100, data_rate: 54.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "fts" security open
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'fa:8f:ca:7d:fb:c1' with SSID: Spisestue.m,, freq: 2437=
, rank: 1456, strength: -6600, data_rate: 52.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "Spisestue.m," security open
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a3' with SSID: BEOMTV, freq: 5320, rank=
: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a2' with SSID: BEOGUEST, freq: 5320, ra=
nk: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a1' with SSID: BeoAccess, freq: 5320, r=
ank: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a0' with SSID: BEOLAN, freq: 5320, rank=
: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ff:7b:ef:5a:a1' with SSID: , freq: 2432, rank: 1260=
, strength: -7200, data_rate: 45.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:cc' with SSID: BEOMTV, freq: 5600, rank=
: 970, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:cd' with SSID: BEOGUEST, freq: 5600, ra=
nk: 970, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:ce' with SSID: BeoAccess, freq: 5600, r=
ank: 970, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:cf' with SSID: BEOLAN, freq: 5600, rank=
: 970, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:e8:27' with SSID: , freq: 2462, rank: 809,=
 strength: -7100, data_rate: 28.9
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:e8:27' with SSID: hejlsberg_2G, freq: 2462=
, rank: 809, strength: -7100, data_rate: 28.9
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "hejlsberg_2G" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:3b:8c:62' with SSID: , freq: 2437, rank: 809,=
 strength: -7100, data_rate: 28.9
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:f8:1a' with SSID: hejlsberg_2G, freq: 2412=
, rank: 809, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '3c:84:6a:aa:29:d6' with SSID: beolink_2g, freq: 2417, =
rank: 809, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "beolink_2g" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '34:6f:24:09:75:ad' with SSID: , freq: 2412, rank: 728,=
 strength: -7100, data_rate: 26.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '14:91:82:bd:d1:83' with SSID: Soundwave24=E2=82=AC, fr=
eq: 2427, rank: 606, strength: -7600, data_rate: 21.7
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "Soundwave24=E2=82=AC" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '4e:84:6a:aa:29:d6' with SSID: , freq: 2417, rank: 606,=
 strength: -7600, data_rate: 21.7
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:38:67:a1' with SSID: , freq: 5805, rank: 606,=
 strength: -7700, data_rate: 21.7
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:ed:d1' with SSID: , freq: 2412, rank: 404,=
 strength: -7800, data_rate: 14.4
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:ed:d1' with SSID: hejlsberg_2G, freq: 2412=
, rank: 404, strength: -7800, data_rate: 14.4
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'b4:75:0e:3f:98:c1' with SSID: Linksys00560, freq: 2467=
, rank: 308, strength: -8400, data_rate: 11.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "Linksys00560" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2f' with SSID: BEOLAN, freq: 5580, rank=
: 242, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2c' with SSID: BEOMTV, freq: 5580, rank=
: 242, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2d' with SSID: BEOGUEST, freq: 5580, ra=
nk: 242, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:c1' with SSID: BeoAccess, freq: 5560, r=
ank: 242, strength: -8200, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c3' with SSID: BEOMTV, freq: 5300, rank=
: 242, strength: -8200, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c2' with SSID: BEOGUEST, freq: 5300, ra=
nk: 242, strength: -8200, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c0' with SSID: BEOLAN, freq: 5300, rank=
: 242, strength: -8200, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:38:64:98' with SSID: , freq: 2412, rank: 202,=
 strength: -8000, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:ea:99' with SSID: , freq: 2462, rank: 202,=
 strength: -8100, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:ea:99' with SSID: hejlsberg_2G, freq: 2462=
, rank: 202, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:d4:c4:c4:24:f0' with SSID: esp32_network, freq: 246=
2, rank: 202, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "esp32_network" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:f7:92' with SSID: hejlsberg_2G, freq: 2437=
, rank: 202, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:47:32:3d:36:2e' with SSID: speakerlink_2g, freq: 24=
57, rank: 202, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "speakerlink_2g" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:47:32:3d:36:2e' with SSID: , freq: 2457, rank: 202,=
 strength: -8100, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:f7:92' with SSID: , freq: 2437, rank: 202,=
 strength: -8200, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'c0:56:27:be:2f:96' with SSID: SuneTestNetwork, freq: 2=
422, rank: 202, strength: -8200, data_rate: 7.2
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "SuneTestNetwork" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2e' with SSID: BeoAccess, freq: 5580, r=
ank: 67, strength: -8300, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c1' with SSID: BeoAccess, freq: 5300, r=
ank: 67, strength: -8300, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ec' with SSID: BEOMTV, freq: 5680, rank=
: 67, strength: -8500, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ed' with SSID: BEOGUEST, freq: 5680, ra=
nk: 67, strength: -8500, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ee' with SSID: BeoAccess, freq: 5680, r=
ank: 67, strength: -8500, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ef' with SSID: BEOLAN, freq: 5680, rank=
: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:26:0f' with SSID: BeoBlue, freq: 5320, ran=
k: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:23' with SSID: BEOMTV, freq: 5300, rank=
: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:c0' with SSID: BEOLAN, freq: 5560, rank=
: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:26:0e' with SSID: _beo_products, freq: 532=
0, rank: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:22' with SSID: BEOGUEST, freq: 5300, ra=
nk: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:21' with SSID: BeoAccess, freq: 5300, r=
ank: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:20' with SSID: BEOLAN, freq: 5300, rank=
: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:ce' with SSID: BeoAccess, freq: 5700, r=
ank: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:cf' with SSID: BEOLAN, freq: 5700, rank=
: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:cd' with SSID: BEOGUEST, freq: 5700, ra=
nk: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e3' with SSID: BEOMTV, freq: 5300, rank=
: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e1' with SSID: BeoAccess, freq: 5300, r=
ank: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e0' with SSID: BEOLAN, freq: 5300, rank=
: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:cc' with SSID: BEOMTV, freq: 5700, rank=
: 67, strength: -8900, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ed' with SSID: BEOGUEST, freq: 5560, ra=
nk: 67, strength: -8900, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ee' with SSID: BeoAccess, freq: 5560, r=
ank: 67, strength: -8900, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ef' with SSID: BEOLAN, freq: 5560, rank=
: 67, strength: -8900, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e2' with SSID: BEOGUEST, freq: 5300, ra=
nk: 67, strength: -9000, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '34:fa:9f:3c:7e:3c' with SSID: Newsec Datea, freq: 5600=
, rank: 67, strength: -9100, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "Newsec Datea" security psk
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ec' with SSID: BEOMTV, freq: 5560, rank=
: 67, strength: -9100, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:e3' with SSID: BEOMTV, freq: 5320, rank=
: 67, strength: -9100, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:e2' with SSID: BEOGUEST, freq: 5320, ra=
nk: 67, strength: -9100, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:e0' with SSID: BEOLAN, freq: 5320, rank=
: 67, strength: -9100, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:35:22:35' with SSID: , freq: 2412, rank: 56, =
strength: -8700, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '62:45:b7:49:94:97' with SSID: , freq: 5825, rank: 56, =
strength: -9100, data_rate: 2.0
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_start()
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: =E2=98=A0=EF=B8=8Fautotest_dev=E2=98=A0=
=EF=B8=8F
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'd8:07:b6:81:7e:59' freq: 5180, rank: 9102, strength:=
 -5500
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: beolink_5g
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '3c:84:6a:aa:29:d5' freq: 5180, rank: 7281, strength:=
 -6000
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: titan
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '04:f0:21:88:56:ef' freq: 5180, rank: 5601, strength:=
 -3200
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: hejlsberg_5G
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '74:ac:b9:be:e8:27' freq: 5220, rank: 5601, strength:=
 -5100
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: Linksys05274_5GHz_dmt
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '14:91:82:bd:d1:84' freq: 5220, rank: 5461, strength:=
 -6300
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: esp32_network_5G
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '04:d4:c4:c4:24:f4' freq: 5300, rank: 4368, strength:=
 -6700
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: speakerlink_5g
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'd8:47:32:3d:36:2d' freq: 5240, rank: 3640, strength:=
 -6600
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: Linksys00560_5GHz
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'b4:75:0e:3f:98:c2' freq: 5220, rank: 3640, strength:=
 -6700
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: TEJO
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'c0:56:27:61:4b:a7' freq: 5180, rank: 2696, strength:=
 -4800
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: BEOMTV
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '00:2c:c8:88:21:ac' freq: 5500, rank: 2427, strength:=
 -6300
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: BEOGUEST
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '00:2c:c8:88:21:ad' freq: 5500, rank: 2427, strength:=
 -6300
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: BEOLAN
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '00:2c:c8:88:21:af' freq: 5500, rank: 2427, strength:=
 -6200
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: BeoAccess
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '00:2c:c8:88:21:ae' freq: 5500, rank: 2427, strength:=
 -6300
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_select_akm() N=
etwork is WPA3-Personal...
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: EMAS_2g
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'c4:93:00:19:d4:38' freq: 2437, rank: 2022, strength:=
 -6400
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: BeoBlue
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '00:2c:c8:9a:83:0f' freq: 5640, rank: 1941, strength:=
 -6600
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: _beo_products
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '00:2c:c8:9a:83:0e' freq: 5640, rank: 1941, strength:=
 -6600
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: fts
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '04:f0:21:88:54:78' freq: 2412, rank: 1512, strength:=
 -4100
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: Spisestue.m,
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'fa:8f:ca:7d:fb:c1' freq: 2437, rank: 1456, strength:=
 -6600
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: beolink_2g
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '3c:84:6a:aa:29:d6' freq: 2417, rank: 809, strength: =
-7400
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: hejlsberg_2G
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '74:ac:b9:bd:e8:27' freq: 2462, rank: 809, strength: =
-7100
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: Soundwave24=E2=82=AC
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '14:91:82:bd:d1:83' freq: 2427, rank: 606, strength: =
-7600
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: Linksys00560
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'b4:75:0e:3f:98:c1' freq: 2467, rank: 308, strength: =
-8400
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: speakerlink_2g
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'd8:47:32:3d:36:2e' freq: 2457, rank: 202, strength: =
-8100
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: SuneTestNetwork
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'c0:56:27:be:2f:96' freq: 2422, rank: 202, strength: =
-8200
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: esp32_network
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '04:d4:c4:c4:24:f0' freq: 2462, rank: 202, strength: =
-8100
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: Newsec Datea
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '34:fa:9f:3c:7e:3c' freq: 5600, rank: 67, strength: -=
9100
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:30 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_don=
e() Work item 1 done
> > Apr 27 16:34:38 iwd[5117]: ../iwd-1.26/src/netdev.c:netdev_mlme_notify(=
) MLME notification New Station(19)
> > Apr 27 16:34:39 iwd[5117]: ../iwd-1.26/src/agent.c:agent_register() age=
nt register called
> > Apr 27 16:34:39 iwd[5117]: ../iwd-1.26/src/agent.c:agent_register() age=
nt :1.245 path /agent/5170
> > Apr 27 16:34:39 iwd[5117]: ../iwd-1.26/src/station.c:station_dbus_scan(=
) Scan called from DBus
> > Apr 27 16:34:39 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_ins=
ert() Inserting work item 2
> > Apr 27 16:34:39 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_nex=
t() Starting work item 2
> > Apr 27 16:34:39 iwd[5117]: ../iwd-1.26/src/scan.c:scan_notify() Scan no=
tification Trigger Scan(33)
> > Apr 27 16:34:39 iwd[5117]: ../iwd-1.26/src/scan.c:scan_request_triggere=
d() Passive scan triggered for wdev 1
> > Apr 27 16:34:39 iwd[5117]: ../iwd-1.26/src/station.c:station_dbus_scan_=
triggered() station_scan_triggered: 0
> > Apr 27 16:34:39 iwd[5117]: ../iwd-1.26/src/station.c:station_dbus_scan_=
triggered() Scan triggered for wlan0 subset 0
> > Apr 27 16:34:39 iwd[5117]: ../iwd-1.26/src/agent.c:agent_disconnect() a=
gent :1.245 disconnected
> > Apr 27 16:34:39 iwd[5117]: ../iwd-1.26/src/agent.c:agent_free() agent f=
ree 0xaaaadfc2a360
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:scan_notify() Scan no=
tification New Scan Results(34)
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/netdev.c:netdev_link_notify(=
) event 16 on ifindex 8
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 174/255
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 166/255
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 90/255
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 141/255
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 154/255
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 166/255
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 156/255
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 156/255
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_done() get_s=
can_done
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'c4:93:00:19:d4:38' with SSID: EMAS_2g, freq: 2437, ran=
k: 2022, strength: -6300, data_rate: 72.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '34:6f:24:09:75:ad' with SSID: , freq: 2412, rank: 1638=
, strength: -6500, data_rate: 58.5
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:f0:21:88:54:78' with SSID: fts, freq: 2412, rank: 1=
512, strength: -4000, data_rate: 54.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:e8:27' with SSID: , freq: 2462, rank: 1213=
, strength: -7000, data_rate: 43.3
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:e8:27' with SSID: hejlsberg_2G, freq: 2462=
, rank: 1213, strength: -7000, data_rate: 43.3
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'fa:8f:ca:7d:fb:c1' with SSID: Spisestue.m,, freq: 2437=
, rank: 1092, strength: -7000, data_rate: 39.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:3b:8c:62' with SSID: , freq: 2437, rank: 809,=
 strength: -7100, data_rate: 28.9
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:43:4f:cc' with SSID: , freq: 2412, rank: 606,=
 strength: -7600, data_rate: 21.7
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:ed:d1' with SSID: , freq: 2412, rank: 404,=
 strength: -7800, data_rate: 14.4
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:ed:d1' with SSID: hejlsberg_2G, freq: 2412=
, rank: 404, strength: -7800, data_rate: 14.4
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:38:64:98' with SSID: , freq: 2412, rank: 202,=
 strength: -8000, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:ea:99' with SSID: , freq: 2462, rank: 202,=
 strength: -8100, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:ea:99' with SSID: hejlsberg_2G, freq: 2462=
, rank: 202, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:d4:c4:c4:24:f0' with SSID: esp32_network, freq: 246=
2, rank: 202, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:07:b6:81:7e:59' with SSID: =E2=98=A0=EF=B8=8Fautote=
st_dev=E2=98=A0=EF=B8=8F, freq: 5180, rank: 9102, strength: -5500, data_rat=
e: 325.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:07:b6:81:7e:59' with SSID: , freq: 5180, rank: 9102=
, strength: -5600, data_rate: 325.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '3c:84:6a:aa:29:d5' with SSID: beolink_5g, freq: 5180, =
rank: 7281, strength: -6000, data_rate: 260.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '4e:84:6a:aa:29:d5' with SSID: , freq: 5180, rank: 7281=
, strength: -6000, data_rate: 260.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:f0:21:88:56:ef' with SSID: titan, freq: 5180, rank:=
 5601, strength: -3200, data_rate: 200.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:e8:27' with SSID: , freq: 5220, rank: 5601=
, strength: -5100, data_rate: 200.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:e8:27' with SSID: hejlsberg_5G, freq: 5220=
, rank: 5601, strength: -5100, data_rate: 200.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '14:91:82:bd:d1:84' with SSID: Linksys05274_5GHz_dmt, f=
req: 5220, rank: 5461, strength: -6300, data_rate: 195.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:d4:c4:c4:24:f4' with SSID: esp32_network_5G, freq: =
5300, rank: 4368, strength: -6700, data_rate: 130.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:47:32:3d:36:2d' with SSID: , freq: 5240, rank: 3640=
, strength: -6500, data_rate: 130.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '90:9a:4a:4d:f3:7a' with SSID: , freq: 5580, rank: 3640=
, strength: -6600, data_rate: 130.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:47:32:3d:36:2d' with SSID: speakerlink_5g, freq: 52=
40, rank: 3640, strength: -6600, data_rate: 130.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'b4:75:0e:3f:98:c2' with SSID: Linksys00560_5GHz, freq:=
 5220, rank: 3640, strength: -6700, data_rate: 130.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ff:7b:ef:5a:a0' with SSID: , freq: 5180, rank: 3640=
, strength: -6800, data_rate: 130.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'c0:56:27:61:4b:a7' with SSID: TEJO, freq: 5180, rank: =
2696, strength: -4800, data_rate: 96.3
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:ed:d1' with SSID: , freq: 5200, rank: 2520=
, strength: -6400, data_rate: 90.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:ea:99' with SSID: , freq: 5220, rank: 2520=
, strength: -6500, data_rate: 90.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:ea:99' with SSID: hejlsberg_5G, freq: 5220=
, rank: 2520, strength: -6500, data_rate: 90.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:ed:d1' with SSID: hejlsberg_5G, freq: 5200=
, rank: 2520, strength: -6500, data_rate: 90.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:f7:92' with SSID: , freq: 5200, rank: 2520=
, strength: -6500, data_rate: 90.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:f7:92' with SSID: hejlsberg_5G, freq: 5200=
, rank: 2520, strength: -6600, data_rate: 90.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:f8:1a' with SSID: , freq: 5200, rank: 2520=
, strength: -6700, data_rate: 90.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:f8:1a' with SSID: hejlsberg_5G, freq: 5200=
, rank: 2520, strength: -6700, data_rate: 90.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:af' with SSID: BEOLAN, freq: 5500, rank=
: 2427, strength: -6200, data_rate: 72.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:ac' with SSID: BEOMTV, freq: 5500, rank=
: 2427, strength: -6300, data_rate: 72.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:ad' with SSID: BEOGUEST, freq: 5500, ra=
nk: 2427, strength: -6300, data_rate: 72.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:ae' with SSID: BeoAccess, freq: 5500, r=
ank: 2427, strength: -6300, data_rate: 72.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:07:b6:81:7e:5a' with SSID: , freq: 2417, rank: 2022=
, strength: -5900, data_rate: 72.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:9a:83:0e' with SSID: _beo_products, freq: 564=
0, rank: 1941, strength: -6600, data_rate: 57.8
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:9a:83:0f' with SSID: BeoBlue, freq: 5640, ran=
k: 1941, strength: -6600, data_rate: 57.8
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:07:b6:81:7e:5a' with SSID: =E2=98=A0=EF=B8=8Fautote=
st_dev=E2=98=A0=EF=B8=8F, freq: 2417, rank: 1820, strength: -6500, data_rat=
e: 65.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a3' with SSID: BEOMTV, freq: 5320, rank=
: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a2' with SSID: BEOGUEST, freq: 5320, ra=
nk: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a1' with SSID: BeoAccess, freq: 5320, r=
ank: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a0' with SSID: BEOLAN, freq: 5320, rank=
: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ff:7b:ef:5a:a1' with SSID: , freq: 2432, rank: 1260=
, strength: -7200, data_rate: 45.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:cc' with SSID: BEOMTV, freq: 5600, rank=
: 970, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:cd' with SSID: BEOGUEST, freq: 5600, ra=
nk: 970, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:ce' with SSID: BeoAccess, freq: 5600, r=
ank: 970, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:cf' with SSID: BEOLAN, freq: 5600, rank=
: 970, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:f8:1a' with SSID: hejlsberg_2G, freq: 2412=
, rank: 809, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '3c:84:6a:aa:29:d6' with SSID: beolink_2g, freq: 2417, =
rank: 809, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '14:91:82:bd:d1:83' with SSID: Soundwave24=E2=82=AC, fr=
eq: 2427, rank: 606, strength: -7600, data_rate: 21.7
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '4e:84:6a:aa:29:d6' with SSID: , freq: 2417, rank: 606,=
 strength: -7600, data_rate: 21.7
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:38:67:a1' with SSID: , freq: 5805, rank: 606,=
 strength: -7700, data_rate: 21.7
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'b4:75:0e:3f:98:c1' with SSID: Linksys00560, freq: 2467=
, rank: 308, strength: -8400, data_rate: 11.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2f' with SSID: BEOLAN, freq: 5580, rank=
: 242, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2c' with SSID: BEOMTV, freq: 5580, rank=
: 242, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2d' with SSID: BEOGUEST, freq: 5580, ra=
nk: 242, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:c1' with SSID: BeoAccess, freq: 5560, r=
ank: 242, strength: -8200, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c3' with SSID: BEOMTV, freq: 5300, rank=
: 242, strength: -8200, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c2' with SSID: BEOGUEST, freq: 5300, ra=
nk: 242, strength: -8200, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c0' with SSID: BEOLAN, freq: 5300, rank=
: 242, strength: -8200, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:f7:92' with SSID: hejlsberg_2G, freq: 2437=
, rank: 202, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:47:32:3d:36:2e' with SSID: speakerlink_2g, freq: 24=
57, rank: 202, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:47:32:3d:36:2e' with SSID: , freq: 2457, rank: 202,=
 strength: -8100, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:f7:92' with SSID: , freq: 2437, rank: 202,=
 strength: -8200, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'c0:56:27:be:2f:96' with SSID: SuneTestNetwork, freq: 2=
422, rank: 202, strength: -8200, data_rate: 7.2
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2e' with SSID: BeoAccess, freq: 5580, r=
ank: 67, strength: -8300, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c1' with SSID: BeoAccess, freq: 5300, r=
ank: 67, strength: -8300, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ec' with SSID: BEOMTV, freq: 5680, rank=
: 67, strength: -8500, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ed' with SSID: BEOGUEST, freq: 5680, ra=
nk: 67, strength: -8500, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ee' with SSID: BeoAccess, freq: 5680, r=
ank: 67, strength: -8500, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ef' with SSID: BEOLAN, freq: 5680, rank=
: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:26:0f' with SSID: BeoBlue, freq: 5320, ran=
k: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:23' with SSID: BEOMTV, freq: 5300, rank=
: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:c0' with SSID: BEOLAN, freq: 5560, rank=
: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:26:0e' with SSID: _beo_products, freq: 532=
0, rank: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:22' with SSID: BEOGUEST, freq: 5300, ra=
nk: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:21' with SSID: BeoAccess, freq: 5300, r=
ank: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:20' with SSID: BEOLAN, freq: 5300, rank=
: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:ce' with SSID: BeoAccess, freq: 5700, r=
ank: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:cf' with SSID: BEOLAN, freq: 5700, rank=
: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:cd' with SSID: BEOGUEST, freq: 5700, ra=
nk: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e3' with SSID: BEOMTV, freq: 5300, rank=
: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e1' with SSID: BeoAccess, freq: 5300, r=
ank: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e0' with SSID: BEOLAN, freq: 5300, rank=
: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:cc' with SSID: BEOMTV, freq: 5700, rank=
: 67, strength: -8900, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ed' with SSID: BEOGUEST, freq: 5560, ra=
nk: 67, strength: -8900, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ee' with SSID: BeoAccess, freq: 5560, r=
ank: 67, strength: -8900, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ef' with SSID: BEOLAN, freq: 5560, rank=
: 67, strength: -8900, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e2' with SSID: BEOGUEST, freq: 5300, ra=
nk: 67, strength: -9000, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '34:fa:9f:3c:7e:3c' with SSID: Newsec Datea, freq: 5600=
, rank: 67, strength: -9100, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ec' with SSID: BEOMTV, freq: 5560, rank=
: 67, strength: -9100, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:e3' with SSID: BEOMTV, freq: 5320, rank=
: 67, strength: -9100, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:e2' with SSID: BEOGUEST, freq: 5320, ra=
nk: 67, strength: -9100, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:e0' with SSID: BEOLAN, freq: 5320, rank=
: 67, strength: -9100, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:35:22:35' with SSID: , freq: 2412, rank: 56, =
strength: -8700, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '62:45:b7:49:94:97' with SSID: , freq: 5825, rank: 56, =
strength: -9100, data_rate: 2.0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_ins=
ert() Inserting work item 3
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_don=
e() Work item 2 done
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_nex=
t() Starting work item 3
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:scan_notify() Scan no=
tification Trigger Scan(33)
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:scan_request_triggere=
d() Passive scan triggered for wdev 1
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_dbus_scan_=
triggered() station_scan_triggered: 0
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/station.c:station_dbus_scan_=
triggered() Scan triggered for wlan0 subset 1
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/scan.c:scan_periodic_timeout=
() 1
> > Apr 27 16:34:40 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_ins=
ert() Inserting work item 4
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_notify() Scan no=
tification New Scan Results(34)
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/netdev.c:netdev_link_notify(=
) event 16 on ifindex 8
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 85/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 85/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 87/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 87/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 95/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 95/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 165/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 165/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 112/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 112/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 20/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 20/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 20/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 35/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 35/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 35/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 35/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 33/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 30/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 30/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 15/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 2/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 7/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 38/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 38/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 2/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 2/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 2/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 2/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_parse_bss_inform=
ation_elements() Load: 5/255
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: wiphy_estimate_data_rate() failed
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_done() get_s=
can_done
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:07:b6:81:7e:59' with SSID: , freq: 5180, rank: 9102=
, strength: -5400, data_rate: 325.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:07:b6:81:7e:59' with SSID: =E2=98=A0=EF=B8=8Fautote=
st_dev=E2=98=A0=EF=B8=8F, freq: 5180, rank: 9102, strength: -5400, data_rat=
e: 325.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'c0:56:27:be:2f:97' with SSID: SuneTestNetwork, freq: 5=
220, rank: 7281, strength: -6000, data_rate: 260.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '4e:84:6a:aa:29:d5' with SSID: , freq: 5180, rank: 7281=
, strength: -6000, data_rate: 260.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '3c:84:6a:aa:29:d5' with SSID: beolink_5g, freq: 5180, =
rank: 7281, strength: -6000, data_rate: 260.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:f0:21:88:56:ef' with SSID: titan, freq: 5180, rank:=
 5601, strength: -3300, data_rate: 200.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:e8:27' with SSID: , freq: 5220, rank: 5601=
, strength: -5100, data_rate: 200.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:e8:27' with SSID: hejlsberg_5G, freq: 5220=
, rank: 5601, strength: -5100, data_rate: 200.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '14:91:82:bd:d1:84' with SSID: Linksys05274_5GHz_dmt, f=
req: 5220, rank: 5461, strength: -6200, data_rate: 195.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:d4:c4:c4:24:f4' with SSID: esp32_network_5G, freq: =
5300, rank: 4368, strength: -6700, data_rate: 130.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:47:32:3d:36:2d' with SSID: , freq: 5240, rank: 3640=
, strength: -6500, data_rate: 130.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:47:32:3d:36:2d' with SSID: speakerlink_5g, freq: 52=
40, rank: 3640, strength: -6600, data_rate: 130.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'b4:75:0e:3f:98:c2' with SSID: Linksys00560_5GHz, freq:=
 5220, rank: 3640, strength: -6600, data_rate: 130.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '90:9a:4a:4d:f3:7a' with SSID: , freq: 5580, rank: 3640=
, strength: -6800, data_rate: 130.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'c0:56:27:61:4b:a7' with SSID: TEJO, freq: 5180, rank: =
2696, strength: -4800, data_rate: 96.3
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:38:67:a1' with SSID: , freq: 5805, rank: 2696=
, strength: -5100, data_rate: 96.3
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:ea:99' with SSID: , freq: 5220, rank: 2520=
, strength: -6400, data_rate: 90.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:ea:99' with SSID: hejlsberg_5G, freq: 5220=
, rank: 2520, strength: -6400, data_rate: 90.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:ed:d1' with SSID: , freq: 5200, rank: 2520=
, strength: -6400, data_rate: 90.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:ed:d1' with SSID: hejlsberg_5G, freq: 5200=
, rank: 2520, strength: -6400, data_rate: 90.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:f7:92' with SSID: , freq: 5200, rank: 2520=
, strength: -6600, data_rate: 90.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:f7:92' with SSID: hejlsberg_5G, freq: 5200=
, rank: 2520, strength: -6600, data_rate: 90.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:f8:1a' with SSID: , freq: 5200, rank: 2520=
, strength: -6700, data_rate: 90.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:f8:1a' with SSID: hejlsberg_5G, freq: 5200=
, rank: 2520, strength: -6700, data_rate: 90.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:ae' with SSID: BeoAccess, freq: 5500, r=
ank: 2427, strength: -6200, data_rate: 72.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:af' with SSID: BEOLAN, freq: 5500, rank=
: 2427, strength: -6200, data_rate: 72.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:ac' with SSID: BEOMTV, freq: 5500, rank=
: 2427, strength: -6200, data_rate: 72.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:ad' with SSID: BEOGUEST, freq: 5500, ra=
nk: 2427, strength: -6200, data_rate: 72.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:9a:83:0e' with SSID: _beo_products, freq: 564=
0, rank: 1941, strength: -6600, data_rate: 57.8
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:9a:83:0f' with SSID: BeoBlue, freq: 5640, ran=
k: 1941, strength: -6600, data_rate: 57.8
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '90:9a:4a:4d:f3:79' with SSID: , freq: 5240, rank: 1820=
, strength: -7200, data_rate: 65.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '96:9a:4a:4d:f3:79' with SSID: TPLinkDeco, freq: 5240, =
rank: 1820, strength: -7200, data_rate: 65.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Added new Network "TPLinkDeco" security psk
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a3' with SSID: BEOMTV, freq: 5320, rank=
: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a2' with SSID: BEOGUEST, freq: 5320, ra=
nk: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a1' with SSID: BeoAccess, freq: 5320, r=
ank: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a0' with SSID: BEOLAN, freq: 5320, rank=
: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:38:69:68' with SSID: , freq: 5785, rank: 1213=
, strength: -6900, data_rate: 43.3
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:cd' with SSID: BEOGUEST, freq: 5600, ra=
nk: 970, strength: -7300, data_rate: 28.9
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:cf' with SSID: BEOLAN, freq: 5600, rank=
: 970, strength: -7300, data_rate: 28.9
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:cc' with SSID: BEOMTV, freq: 5600, rank=
: 970, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:ce' with SSID: BeoAccess, freq: 5600, r=
ank: 970, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:3b:8c:23' with SSID: , freq: 5825, rank: 606,=
 strength: -7500, data_rate: 21.7
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:38:64:05' with SSID: , freq: 5805, rank: 606,=
 strength: -7600, data_rate: 21.7
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2e' with SSID: BeoAccess, freq: 5580, r=
ank: 242, strength: -8000, data_rate: 7.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2f' with SSID: BEOLAN, freq: 5580, rank=
: 242, strength: -8000, data_rate: 7.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2c' with SSID: BEOMTV, freq: 5580, rank=
: 242, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2d' with SSID: BEOGUEST, freq: 5580, ra=
nk: 242, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c3' with SSID: BEOMTV, freq: 5300, rank=
: 67, strength: -8300, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c2' with SSID: BEOGUEST, freq: 5300, ra=
nk: 67, strength: -8300, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c1' with SSID: BeoAccess, freq: 5300, r=
ank: 67, strength: -8300, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c0' with SSID: BEOLAN, freq: 5300, rank=
: 67, strength: -8300, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:ce' with SSID: BeoAccess, freq: 5700, r=
ank: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:cf' with SSID: BEOLAN, freq: 5700, rank=
: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ec' with SSID: BEOMTV, freq: 5680, rank=
: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ef' with SSID: BEOLAN, freq: 5680, rank=
: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ef' with SSID: BEOLAN, freq: 5560, rank=
: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:26:0e' with SSID: _beo_products, freq: 532=
0, rank: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:23' with SSID: BEOMTV, freq: 5300, rank=
: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:22' with SSID: BEOGUEST, freq: 5300, ra=
nk: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:cc' with SSID: BEOMTV, freq: 5700, rank=
: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:cd' with SSID: BEOGUEST, freq: 5700, ra=
nk: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ed' with SSID: BEOGUEST, freq: 5680, ra=
nk: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ee' with SSID: BeoAccess, freq: 5680, r=
ank: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:c3' with SSID: BEOMTV, freq: 5560, rank=
: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:c2' with SSID: BEOGUEST, freq: 5560, ra=
nk: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:c1' with SSID: BeoAccess, freq: 5560, r=
ank: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ed' with SSID: BEOGUEST, freq: 5560, ra=
nk: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ee' with SSID: BeoAccess, freq: 5560, r=
ank: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:26:0f' with SSID: BeoBlue, freq: 5320, ran=
k: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:21' with SSID: BeoAccess, freq: 5300, r=
ank: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:20' with SSID: BEOLAN, freq: 5300, rank=
: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '34:fa:9f:3c:7e:3c' with SSID: Newsec Datea, freq: 5600=
, rank: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:c0' with SSID: BEOLAN, freq: 5560, rank=
: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ec' with SSID: BEOMTV, freq: 5560, rank=
: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e3' with SSID: BEOMTV, freq: 5300, rank=
: 67, strength: -8900, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e0' with SSID: BEOLAN, freq: 5300, rank=
: 67, strength: -8900, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:e3' with SSID: BEOMTV, freq: 5320, rank=
: 67, strength: -9000, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:e1' with SSID: BeoAccess, freq: 5320, r=
ank: 67, strength: -9000, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e2' with SSID: BEOGUEST, freq: 5300, ra=
nk: 67, strength: -9000, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:e0' with SSID: BEOLAN, freq: 5320, rank=
: 67, strength: -9100, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:e2' with SSID: BEOGUEST, freq: 5320, ra=
nk: 67, strength: -9200, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '62:45:b7:49:94:97' with SSID: , freq: 5825, rank: 56, =
strength: -6400, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'c4:93:00:19:d4:38' with SSID: EMAS_2g, freq: 2437, ran=
k: 2022, strength: -6300, data_rate: 72.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '34:6f:24:09:75:ad' with SSID: , freq: 2412, rank: 1638=
, strength: -6500, data_rate: 58.5
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:f0:21:88:54:78' with SSID: fts, freq: 2412, rank: 1=
512, strength: -4000, data_rate: 54.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:e8:27' with SSID: , freq: 2462, rank: 1213=
, strength: -7000, data_rate: 43.3
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:e8:27' with SSID: hejlsberg_2G, freq: 2462=
, rank: 1213, strength: -7000, data_rate: 43.3
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'fa:8f:ca:7d:fb:c1' with SSID: Spisestue.m,, freq: 2437=
, rank: 1092, strength: -7000, data_rate: 39.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:3b:8c:62' with SSID: , freq: 2437, rank: 809,=
 strength: -7100, data_rate: 28.9
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:43:4f:cc' with SSID: , freq: 2412, rank: 606,=
 strength: -7600, data_rate: 21.7
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:ed:d1' with SSID: , freq: 2412, rank: 404,=
 strength: -7800, data_rate: 14.4
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:ed:d1' with SSID: hejlsberg_2G, freq: 2412=
, rank: 404, strength: -7800, data_rate: 14.4
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:38:64:98' with SSID: , freq: 2412, rank: 202,=
 strength: -8000, data_rate: 7.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:ea:99' with SSID: , freq: 2462, rank: 202,=
 strength: -8100, data_rate: 7.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:ea:99' with SSID: hejlsberg_2G, freq: 2462=
, rank: 202, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:d4:c4:c4:24:f0' with SSID: esp32_network, freq: 246=
2, rank: 202, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ff:7b:ef:5a:a0' with SSID: , freq: 5180, rank: 3640=
, strength: -6800, data_rate: 130.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:07:b6:81:7e:5a' with SSID: , freq: 2417, rank: 2022=
, strength: -5900, data_rate: 72.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:07:b6:81:7e:5a' with SSID: =E2=98=A0=EF=B8=8Fautote=
st_dev=E2=98=A0=EF=B8=8F, freq: 2417, rank: 1820, strength: -6500, data_rat=
e: 65.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ff:7b:ef:5a:a1' with SSID: , freq: 2432, rank: 1260=
, strength: -7200, data_rate: 45.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:f8:1a' with SSID: hejlsberg_2G, freq: 2412=
, rank: 809, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '3c:84:6a:aa:29:d6' with SSID: beolink_2g, freq: 2417, =
rank: 809, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '14:91:82:bd:d1:83' with SSID: Soundwave24=E2=82=AC, fr=
eq: 2427, rank: 606, strength: -7600, data_rate: 21.7
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '4e:84:6a:aa:29:d6' with SSID: , freq: 2417, rank: 606,=
 strength: -7600, data_rate: 21.7
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'b4:75:0e:3f:98:c1' with SSID: Linksys00560, freq: 2467=
, rank: 308, strength: -8400, data_rate: 11.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:f7:92' with SSID: hejlsberg_2G, freq: 2437=
, rank: 202, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:47:32:3d:36:2e' with SSID: speakerlink_2g, freq: 24=
57, rank: 202, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:47:32:3d:36:2e' with SSID: , freq: 2457, rank: 202,=
 strength: -8100, data_rate: 7.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:f7:92' with SSID: , freq: 2437, rank: 202,=
 strength: -8200, data_rate: 7.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'c0:56:27:be:2f:96' with SSID: SuneTestNetwork, freq: 2=
422, rank: 202, strength: -8200, data_rate: 7.2
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e1' with SSID: BeoAccess, freq: 5300, r=
ank: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:35:22:35' with SSID: , freq: 2412, rank: 56, =
strength: -8700, data_rate: 2.0
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_ins=
ert() Inserting work item 5
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_don=
e() Work item 3 done
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_nex=
t() Starting work item 5
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_notify() Scan no=
tification Trigger Scan(33)
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_request_triggere=
d() Passive scan triggered for wdev 1
> > Apr 27 16:34:43 iwd[5117]: ../iwd-1.26/src/scan.c:scan_periodic_trigger=
ed() Periodic scan triggered for wdev 1
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/scan.c:scan_notify() Scan no=
tification New Scan Results(34)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/netdev.c:netdev_link_notify(=
) event 16 on ifindex 8
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_callback() g=
et_scan_callback
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/scan.c:get_scan_done() get_s=
can_done
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/scan.c:scan_periodic_rearm()=
 Arming periodic scan timer: 20
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:07:b6:81:7e:5a' with SSID: =E2=98=A0=EF=B8=8Fautote=
st_dev=E2=98=A0=EF=B8=8F, freq: 2417, rank: 2022, strength: -6000, data_rat=
e: 72.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ff:7b:ef:5a:a1' with SSID: , freq: 2432, rank: 1680=
, strength: -7000, data_rate: 60.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:07:b6:81:7e:5a' with SSID: , freq: 2417, rank: 1213=
, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '4e:84:6a:aa:29:d6' with SSID: , freq: 2417, rank: 1213=
, strength: -6900, data_rate: 43.3
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '3c:84:6a:aa:29:d6' with SSID: beolink_2g, freq: 2417, =
rank: 809, strength: -7300, data_rate: 28.9
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '14:91:82:bd:d1:83' with SSID: Soundwave24=E2=82=AC, fr=
eq: 2427, rank: 606, strength: -7700, data_rate: 21.7
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'b4:75:0e:3f:98:c1' with SSID: Linksys00560, freq: 2467=
, rank: 404, strength: -7800, data_rate: 14.4
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:47:32:3d:36:2e' with SSID: speakerlink_2g, freq: 24=
57, rank: 154, strength: -8500, data_rate: 5.5
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:47:32:3d:36:2e' with SSID: , freq: 2457, rank: 154,=
 strength: -8600, data_rate: 5.5
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:07:b6:81:7e:59' with SSID: , freq: 5180, rank: 9102=
, strength: -5400, data_rate: 325.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:07:b6:81:7e:59' with SSID: =E2=98=A0=EF=B8=8Fautote=
st_dev=E2=98=A0=EF=B8=8F, freq: 5180, rank: 9102, strength: -5400, data_rat=
e: 325.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'c0:56:27:be:2f:97' with SSID: SuneTestNetwork, freq: 5=
220, rank: 7281, strength: -6000, data_rate: 260.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '4e:84:6a:aa:29:d5' with SSID: , freq: 5180, rank: 7281=
, strength: -6000, data_rate: 260.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '3c:84:6a:aa:29:d5' with SSID: beolink_5g, freq: 5180, =
rank: 7281, strength: -6000, data_rate: 260.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:f0:21:88:56:ef' with SSID: titan, freq: 5180, rank:=
 5601, strength: -3300, data_rate: 200.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:e8:27' with SSID: , freq: 5220, rank: 5601=
, strength: -5100, data_rate: 200.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:e8:27' with SSID: hejlsberg_5G, freq: 5220=
, rank: 5601, strength: -5100, data_rate: 200.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '14:91:82:bd:d1:84' with SSID: Linksys05274_5GHz_dmt, f=
req: 5220, rank: 5461, strength: -6200, data_rate: 195.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:d4:c4:c4:24:f4' with SSID: esp32_network_5G, freq: =
5300, rank: 4368, strength: -6700, data_rate: 130.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'ea:47:32:3d:36:2d' with SSID: , freq: 5240, rank: 3640=
, strength: -6500, data_rate: 130.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'd8:47:32:3d:36:2d' with SSID: speakerlink_5g, freq: 52=
40, rank: 3640, strength: -6600, data_rate: 130.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'b4:75:0e:3f:98:c2' with SSID: Linksys00560_5GHz, freq:=
 5220, rank: 3640, strength: -6600, data_rate: 130.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '90:9a:4a:4d:f3:7a' with SSID: , freq: 5580, rank: 3640=
, strength: -6800, data_rate: 130.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'c0:56:27:61:4b:a7' with SSID: TEJO, freq: 5180, rank: =
2696, strength: -4800, data_rate: 96.3
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:38:67:a1' with SSID: , freq: 5805, rank: 2696=
, strength: -5100, data_rate: 96.3
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:ea:99' with SSID: , freq: 5220, rank: 2520=
, strength: -6400, data_rate: 90.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:ea:99' with SSID: hejlsberg_5G, freq: 5220=
, rank: 2520, strength: -6400, data_rate: 90.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:ed:d1' with SSID: , freq: 5200, rank: 2520=
, strength: -6400, data_rate: 90.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:ed:d1' with SSID: hejlsberg_5G, freq: 5200=
, rank: 2520, strength: -6400, data_rate: 90.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:f7:92' with SSID: , freq: 5200, rank: 2520=
, strength: -6600, data_rate: 90.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:f7:92' with SSID: hejlsberg_5G, freq: 5200=
, rank: 2520, strength: -6600, data_rate: 90.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:be:f8:1a' with SSID: , freq: 5200, rank: 2520=
, strength: -6700, data_rate: 90.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:be:f8:1a' with SSID: hejlsberg_5G, freq: 5200=
, rank: 2520, strength: -6700, data_rate: 90.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:ae' with SSID: BeoAccess, freq: 5500, r=
ank: 2427, strength: -6200, data_rate: 72.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:af' with SSID: BEOLAN, freq: 5500, rank=
: 2427, strength: -6200, data_rate: 72.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:ac' with SSID: BEOMTV, freq: 5500, rank=
: 2427, strength: -6200, data_rate: 72.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:ad' with SSID: BEOGUEST, freq: 5500, ra=
nk: 2427, strength: -6200, data_rate: 72.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:9a:83:0e' with SSID: _beo_products, freq: 564=
0, rank: 1941, strength: -6600, data_rate: 57.8
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:9a:83:0f' with SSID: BeoBlue, freq: 5640, ran=
k: 1941, strength: -6600, data_rate: 57.8
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '90:9a:4a:4d:f3:79' with SSID: , freq: 5240, rank: 1820=
, strength: -7200, data_rate: 65.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '96:9a:4a:4d:f3:79' with SSID: TPLinkDeco, freq: 5240, =
rank: 1820, strength: -7200, data_rate: 65.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a3' with SSID: BEOMTV, freq: 5320, rank=
: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a2' with SSID: BEOGUEST, freq: 5320, ra=
nk: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a1' with SSID: BeoAccess, freq: 5320, r=
ank: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:21:a0' with SSID: BEOLAN, freq: 5320, rank=
: 1456, strength: -6700, data_rate: 43.3
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:38:69:68' with SSID: , freq: 5785, rank: 1213=
, strength: -6900, data_rate: 43.3
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:cd' with SSID: BEOGUEST, freq: 5600, ra=
nk: 970, strength: -7300, data_rate: 28.9
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:cf' with SSID: BEOLAN, freq: 5600, rank=
: 970, strength: -7300, data_rate: 28.9
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:cc' with SSID: BEOMTV, freq: 5600, rank=
: 970, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:ce' with SSID: BeoAccess, freq: 5600, r=
ank: 970, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:3b:8c:23' with SSID: , freq: 5825, rank: 606,=
 strength: -7500, data_rate: 21.7
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:38:64:05' with SSID: , freq: 5805, rank: 606,=
 strength: -7600, data_rate: 21.7
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2e' with SSID: BeoAccess, freq: 5580, r=
ank: 242, strength: -8000, data_rate: 7.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2f' with SSID: BEOLAN, freq: 5580, rank=
: 242, strength: -8000, data_rate: 7.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2c' with SSID: BEOMTV, freq: 5580, rank=
: 242, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:2d' with SSID: BEOGUEST, freq: 5580, ra=
nk: 242, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c3' with SSID: BEOMTV, freq: 5300, rank=
: 67, strength: -8300, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c2' with SSID: BEOGUEST, freq: 5300, ra=
nk: 67, strength: -8300, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c1' with SSID: BeoAccess, freq: 5300, r=
ank: 67, strength: -8300, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:1c:c0' with SSID: BEOLAN, freq: 5300, rank=
: 67, strength: -8300, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:ce' with SSID: BeoAccess, freq: 5700, r=
ank: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:cf' with SSID: BEOLAN, freq: 5700, rank=
: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ec' with SSID: BEOMTV, freq: 5680, rank=
: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ef' with SSID: BEOLAN, freq: 5680, rank=
: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ef' with SSID: BEOLAN, freq: 5560, rank=
: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:26:0e' with SSID: _beo_products, freq: 532=
0, rank: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:23' with SSID: BEOMTV, freq: 5300, rank=
: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:22' with SSID: BEOGUEST, freq: 5300, ra=
nk: 67, strength: -8600, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:cc' with SSID: BEOMTV, freq: 5700, rank=
: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:cd' with SSID: BEOGUEST, freq: 5700, ra=
nk: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ed' with SSID: BEOGUEST, freq: 5680, ra=
nk: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:ee' with SSID: BeoAccess, freq: 5680, r=
ank: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:c3' with SSID: BEOMTV, freq: 5560, rank=
: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:c2' with SSID: BEOGUEST, freq: 5560, ra=
nk: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:c1' with SSID: BeoAccess, freq: 5560, r=
ank: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ed' with SSID: BEOGUEST, freq: 5560, ra=
nk: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ee' with SSID: BeoAccess, freq: 5560, r=
ank: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:26:0f' with SSID: BeoBlue, freq: 5320, ran=
k: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:21' with SSID: BeoAccess, freq: 5300, r=
ank: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:94:20' with SSID: BEOLAN, freq: 5300, rank=
: 67, strength: -8700, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '34:fa:9f:3c:7e:3c' with SSID: Newsec Datea, freq: 5600=
, rank: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:28:c0' with SSID: BEOLAN, freq: 5560, rank=
: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:ec' with SSID: BEOMTV, freq: 5560, rank=
: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e3' with SSID: BEOMTV, freq: 5300, rank=
: 67, strength: -8900, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e0' with SSID: BEOLAN, freq: 5300, rank=
: 67, strength: -8900, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:e3' with SSID: BEOMTV, freq: 5320, rank=
: 67, strength: -9000, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:e1' with SSID: BeoAccess, freq: 5320, r=
ank: 67, strength: -9000, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e2' with SSID: BEOGUEST, freq: 5300, ra=
nk: 67, strength: -9000, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:e0' with SSID: BEOLAN, freq: 5320, rank=
: 67, strength: -9100, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:87:8f:e2' with SSID: BEOGUEST, freq: 5320, ra=
nk: 67, strength: -9200, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '62:45:b7:49:94:97' with SSID: , freq: 5825, rank: 56, =
strength: -6400, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'c4:93:00:19:d4:38' with SSID: EMAS_2g, freq: 2437, ran=
k: 2022, strength: -6300, data_rate: 72.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '34:6f:24:09:75:ad' with SSID: , freq: 2412, rank: 1638=
, strength: -6500, data_rate: 58.5
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:f0:21:88:54:78' with SSID: fts, freq: 2412, rank: 1=
512, strength: -4000, data_rate: 54.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:e8:27' with SSID: , freq: 2462, rank: 1213=
, strength: -7000, data_rate: 43.3
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:e8:27' with SSID: hejlsberg_2G, freq: 2462=
, rank: 1213, strength: -7000, data_rate: 43.3
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'fa:8f:ca:7d:fb:c1' with SSID: Spisestue.m,, freq: 2437=
, rank: 1092, strength: -7000, data_rate: 39.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:3b:8c:62' with SSID: , freq: 2437, rank: 809,=
 strength: -7100, data_rate: 28.9
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:43:4f:cc' with SSID: , freq: 2412, rank: 606,=
 strength: -7600, data_rate: 21.7
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:ed:d1' with SSID: , freq: 2412, rank: 404,=
 strength: -7800, data_rate: 14.4
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:ed:d1' with SSID: hejlsberg_2G, freq: 2412=
, rank: 404, strength: -7800, data_rate: 14.4
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:38:64:98' with SSID: , freq: 2412, rank: 202,=
 strength: -8000, data_rate: 7.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:ea:99' with SSID: , freq: 2462, rank: 202,=
 strength: -8100, data_rate: 7.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:ea:99' with SSID: hejlsberg_2G, freq: 2462=
, rank: 202, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '04:d4:c4:c4:24:f0' with SSID: esp32_network, freq: 246=
2, rank: 202, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ff:7b:ef:5a:a0' with SSID: , freq: 5180, rank: 3640=
, strength: -6800, data_rate: 130.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:f8:1a' with SSID: hejlsberg_2G, freq: 2412=
, rank: 809, strength: -7400, data_rate: 28.9
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '74:ac:b9:bd:f7:92' with SSID: hejlsberg_2G, freq: 2437=
, rank: 202, strength: -8100, data_rate: 7.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '7a:ac:b9:bd:f7:92' with SSID: , freq: 2437, rank: 202,=
 strength: -8200, data_rate: 7.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS 'c0:56:27:be:2f:96' with SSID: SuneTestNetwork, freq: 2=
422, rank: 202, strength: -8200, data_rate: 7.2
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:2c:c8:88:20:e1' with SSID: BeoAccess, freq: 5300, r=
ank: 67, strength: -8800, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() Processing BSS '00:09:a7:35:22:35' with SSID: , freq: 2412, rank: 56, =
strength: -8700, data_rate: 2.0
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_add_seen_b=
ss() BSS has hidden SSID
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_start()
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: =E2=98=A0=EF=B8=8Fautotest_dev=E2=98=A0=
=EF=B8=8F
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'd8:07:b6:81:7e:59' freq: 5180, rank: 9102, strength:=
 -5400
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: beolink_5g
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '3c:84:6a:aa:29:d5' freq: 5180, rank: 7281, strength:=
 -6000
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: SuneTestNetwork
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'c0:56:27:be:2f:97' freq: 5220, rank: 7281, strength:=
 -6000
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: titan
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '04:f0:21:88:56:ef' freq: 5180, rank: 5601, strength:=
 -3300
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: hejlsberg_5G
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '74:ac:b9:be:e8:27' freq: 5220, rank: 5601, strength:=
 -5100
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: Linksys05274_5GHz_dmt
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '14:91:82:bd:d1:84' freq: 5220, rank: 5461, strength:=
 -6200
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: esp32_network_5G
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '04:d4:c4:c4:24:f4' freq: 5300, rank: 4368, strength:=
 -6700
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: speakerlink_5g
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'd8:47:32:3d:36:2d' freq: 5240, rank: 3640, strength:=
 -6600
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: Linksys00560_5GHz
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'b4:75:0e:3f:98:c2' freq: 5220, rank: 3640, strength:=
 -6600
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: TEJO
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'c0:56:27:61:4b:a7' freq: 5180, rank: 2696, strength:=
 -4800
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: BEOMTV
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '00:2c:c8:88:21:ac' freq: 5500, rank: 2427, strength:=
 -6200
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: BEOGUEST
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '00:2c:c8:88:21:ad' freq: 5500, rank: 2427, strength:=
 -6200
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: BEOLAN
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '00:2c:c8:88:21:af' freq: 5500, rank: 2427, strength:=
 -6200
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: BeoAccess
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '00:2c:c8:88:21:ae' freq: 5500, rank: 2427, strength:=
 -6200
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_select_akm() N=
etwork is WPA3-Personal...
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: EMAS_2g
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'c4:93:00:19:d4:38' freq: 2437, rank: 2022, strength:=
 -6300
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: BeoBlue
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '00:2c:c8:9a:83:0f' freq: 5640, rank: 1941, strength:=
 -6600
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: _beo_products
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '00:2c:c8:9a:83:0e' freq: 5640, rank: 1941, strength:=
 -6600
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: TPLinkDeco
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '96:9a:4a:4d:f3:79' freq: 5240, rank: 1820, strength:=
 -7200
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: fts
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '04:f0:21:88:54:78' freq: 2412, rank: 1512, strength:=
 -4000
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: hejlsberg_2G
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '74:ac:b9:bd:e8:27' freq: 2462, rank: 1213, strength:=
 -7000
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: Spisestue.m,
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'fa:8f:ca:7d:fb:c1' freq: 2437, rank: 1092, strength:=
 -7000
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: beolink_2g
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '3c:84:6a:aa:29:d6' freq: 2417, rank: 809, strength: =
-7300
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: Soundwave24=E2=82=AC
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '14:91:82:bd:d1:83' freq: 2427, rank: 606, strength: =
-7700
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: Linksys00560
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'b4:75:0e:3f:98:c1' freq: 2467, rank: 404, strength: =
-7800
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: esp32_network
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '04:d4:c4:c4:24:f0' freq: 2462, rank: 202, strength: =
-8100
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: speakerlink_2g
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: 'd8:47:32:3d:36:2e' freq: 2457, rank: 154, strength: =
-8500
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: Trying SSID: Newsec Datea
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: '34:fa:9f:3c:7e:3c' freq: 5600, rank: 67, strength: -=
8800
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/station.c:station_autoconnec=
t_next() autoconnect: network_autoconnect: No such file or directory (-2)
> > Apr 27 16:34:44 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_don=
e() Work item 4 done
> > Apr 27 16:34:45 iwd[5117]: ../iwd-1.26/src/agent.c:agent_register() age=
nt register called
> > Apr 27 16:34:45 iwd[5117]: ../iwd-1.26/src/agent.c:agent_register() age=
nt :1.266 path /agent/5282
> > Apr 27 16:34:45 iwd[5117]: ../iwd-1.26/src/network.c:network_connect()
> > Apr 27 16:34:45 iwd[5117]: ../iwd-1.26/src/netdev.c:netdev_cqm_rssi_upd=
ate()
> > Apr 27 16:34:45 iwd[5117]: ../iwd-1.26/src/wiphy.c:wiphy_radio_work_ins=
ert() Inserting work item 6
> > Apr 27 16:34:45 iwd[5117]: ../iwd-1.26/src/station.c:__station_connect_=
network() connecting to BSS 04:f0:21:88:54:78
> > Apr 27 16:34:45 iwd[5117]: ../iwd-1.26/src/station.c:station_enter_stat=
e() Old State: autoconnect_full, new state: connecting
> > Apr 27 16:34:45 iwd[5117]: ../iwd-1.26/src/scan.c:scan_periodic_stop() =
Stopping periodic scan for wdev 1
> > Apr 27 16:54:32 iwd[5117]: ../iwd-1.26/src/netdev.c:netdev_mlme_notify(=
) MLME notification New Station(19)
> =

> > _______________________________________________
> > iwd mailing list -- iwd(a)lists.01.org
> > To unsubscribe send an email to iwd-leave(a)lists.01.org

> From 32dbb6973954e266847bfc49f0273470e2a57bb5 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Alvin=3D20=3DC5=3DA0ipraga?=3D <alsi(a)bang-olufsen.dk>
> Date: Thu, 28 Apr 2022 16:34:29 +0200
> Subject: [PATCH] wiphy: always start next radio work
> =

> ---
>  src/wiphy.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> =

> diff --git a/src/wiphy.c b/src/wiphy.c
> index a52d09419e19..2f086cbc7730 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c
> @@ -2007,19 +2007,8 @@ static bool match_id(const void *a, const void *b)
>  =

>  void wiphy_radio_work_done(struct wiphy *wiphy, uint32_t id)
>  {
> -	struct wiphy_radio_work_item *item;
> -	bool next =3D false;
> -
> -	item =3D l_queue_peek_head(wiphy->work);
> -	if (!item)
> -		return;
> -
> -	if (item->id =3D=3D id) {
> -		next =3D true;
> -		l_queue_pop_head(wiphy->work);
> -	} else
> -		item =3D l_queue_remove_if(wiphy->work, match_id,
> -						L_UINT_TO_PTR(id));
> +	struct wiphy_radio_work_item *item =3D l_queue_remove_if(wiphy->work, m=
atch_id,
> +							       L_UINT_TO_PTR(id));
>  	if (!item)
>  		return;
>  =

> @@ -2031,8 +2020,7 @@ void wiphy_radio_work_done(struct wiphy *wiphy, uin=
t32_t id)
>  	destroy_work(item);
>  	wiphy->work_in_callback =3D false;
>  =

> -	if (next)
> -		wiphy_radio_work_next(wiphy);
> +	wiphy_radio_work_next(wiphy);
>  }
>  =

>  int wiphy_radio_work_is_running(struct wiphy *wiphy, uint32_t id)
> -- =

> 2.35.1
> =


> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
--===============3136797034010463707==--

