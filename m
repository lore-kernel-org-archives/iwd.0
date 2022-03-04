Content-Type: multipart/mixed; boundary="===============2829766527015109762=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: Permanent disconnect when AP changes frequency
Date: Fri, 04 Mar 2022 08:59:44 -0800
Message-ID: <87a2ab3d8a1f5a382df076319068c83e9f8ff051.camel@gmail.com>
In-Reply-To: CACsRnHUCQkB5e3SG9kNCEWuggdfkKX1zLLayTFK3594ehduvZA@mail.gmail.com

--===============2829766527015109762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, 2022-03-04 at 15:44 +0000, Michael Johnson wrote:
> Hi all,
> =

> I just hit a problem today where my iwd clients were getting
> permanently disconnected from a network after the AP changed it's
> frequency.

Was this the AP doing this on its own? Or did you manually change the
frequency. In theory a channel switch should come as an event and you
would see this in the logs:

netdev_channeL_switch_event() Channel switch event, frequenct: <freq>

> The first time the client tries to FT roam to the changed AP it gets
> a
> result: 1 (authentication failed?). After that when it tries to
> reconnect to another BSS in the same network but this time gets a
> result: 2 (association failure?) and critically blacklists the BSS.
> It
> tries to connect to all available BSS and gets the same error until
> there are none left. This leaves the client permanently disconnected.

This shouldn't be permanent, but the more times the connection fails
the longer the timer. In your case though the FT failure will not cause
a blacklist, only the association failure. The default is 60 seconds
though, so that is quite a while.

> I'm guessing that changing the frequency wiped the auth from the AP
> which explains why the initial FT roam fails but I'm not sure what
> would be causing the subsequent failures.

Could be. Looks like the failure after the failed roam never even got
to the AP. So the "association failure" is really just the kernel
failing (unless you're on brcmfmac?). Maybe something can be seen in
the kernel logs. I'm thinking the kernel got confused maybe with the
channel switch and probably needs to re-scan. Does a manual attempt to
connect afterwards work?

> =

> Looking at `src/station.c:station_retry_with_status` would it make
> sense to clean whatever auth data we have for FT if the status is an
> AUTH failure?

The retry logic really only matters for new connections. Once IWD goes
into a disconnected state (like after you're roam failure) any previous
connection data is cleared out.

> =

> ```
> Mar 04 13:35:14 p3-1147 iwd[443]:
> src/station.c:station_transition_start() 5, target *:*:*:*:07:b1
> Mar 04 13:35:14 p3-1147 iwd[443]:
> src/netdev.c:netdev_cqm_rssi_update()
> Mar 04 13:35:14 p3-1147 iwd[443]:
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 6
> Mar 04 13:35:14 p3-1147 iwd[443]: src/station.c:station_enter_state()
> Old State: connected, new state: roaming
> Mar 04 13:35:14 p3-1147 iwd[443]: src/wiphy.c:wiphy_radio_work_done()
> Work item 5 done
> Mar 04 13:35:14 p3-1147 iwd[443]: src/wiphy.c:wiphy_radio_work_next()
> Starting work item 6
> Mar 04 13:35:14 p3-1147 iwd[443]: src/wiphy.c:wiphy_radio_work_done()
> Work item 6 done
> Mar 04 13:35:14 p3-1147 iwd[443]:
> src/station.c:station_fast_transition_cb() 5, result: 1
> Mar 04 13:35:14 p3-1147 iwd[443]: src/station.c:station_roam_failed()
> 5
> Mar 04 13:35:14 p3-1147 iwd[443]:
> src/station.c:station_disassociated() 5
> Mar 04 13:35:14 p3-1147 iwd[443]:
> src/resolve.c:resolve_systemd_revert() ifindex: 5
> Mar 04 13:35:14 p3-1147 iwd[443]: src/station.c:station_enter_state()
> Old State: roaming, new state: disconnected
> Mar 04 13:35:14 p3-1147 iwd[443]: src/station.c:station_enter_state()
> Old State: disconnected, new state: autoconnect_quick
> ...
> Mar 04 13:36:16 p3-1147 iwd[443]:
> src/station.c:__station_connect_network() connecting to BSS
> *:*:*:*:08:71
> Mar 04 13:36:16 p3-1147 iwd[443]: src/station.c:station_enter_state()
> Old State: autoconnect_full, new state: connecting (auto)
> Mar 04 13:36:16 p3-1147 iwd[443]: src/scan.c:scan_periodic_stop()
> Stopping periodic scan for wdev 2
> Mar 04 13:36:16 p3-1147 iwd[443]: src/scan.c:scan_cancel() Trying to
> cancel scan id 13 for wdev 2
> Mar 04 13:36:16 p3-1147 iwd[443]: src/wiphy.c:wiphy_radio_work_done()
> Work item 13 done
> Mar 04 13:36:16 p3-1147 iwd[443]: src/wiphy.c:wiphy_radio_work_next()
> Starting work item 14
> Mar 04 13:36:16 p3-1147 iwd[443]: src/wiphy.c:wiphy_radio_work_done()
> Work item 14 done
> Mar 04 13:36:16 p3-1147 iwd[443]: src/station.c:station_connect_cb()
> 5, result: 2
> Mar 04 13:36:16 p3-1147 iwd[443]: src/station.c:station_enter_state()
> Old State: connecting (auto), new state: disconnected
> ...
> Mar 04 13:36:31 p3-1147 iwd[443]:
> src/station.c:station_autoconnect_next() autoconnect: No suitable
> BSSes found
> ```
> =

> Kind Regards,
> Michael Johnson
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============2829766527015109762==--

