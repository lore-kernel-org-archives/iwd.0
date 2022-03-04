Content-Type: multipart/mixed; boundary="===============0859101193657021155=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Permanent disconnect when AP changes frequency
Date: Fri, 04 Mar 2022 15:44:34 +0000
Message-ID: <CACsRnHUCQkB5e3SG9kNCEWuggdfkKX1zLLayTFK3594ehduvZA@mail.gmail.com>

--===============0859101193657021155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I just hit a problem today where my iwd clients were getting
permanently disconnected from a network after the AP changed it's
frequency.
The first time the client tries to FT roam to the changed AP it gets a
result: 1 (authentication failed?). After that when it tries to
reconnect to another BSS in the same network but this time gets a
result: 2 (association failure?) and critically blacklists the BSS. It
tries to connect to all available BSS and gets the same error until
there are none left. This leaves the client permanently disconnected.
I'm guessing that changing the frequency wiped the auth from the AP
which explains why the initial FT roam fails but I'm not sure what
would be causing the subsequent failures.

Looking at `src/station.c:station_retry_with_status` would it make
sense to clean whatever auth data we have for FT if the status is an
AUTH failure?

```
Mar 04 13:35:14 p3-1147 iwd[443]:
src/station.c:station_transition_start() 5, target *:*:*:*:07:b1
Mar 04 13:35:14 p3-1147 iwd[443]: src/netdev.c:netdev_cqm_rssi_update()
Mar 04 13:35:14 p3-1147 iwd[443]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 6
Mar 04 13:35:14 p3-1147 iwd[443]: src/station.c:station_enter_state()
Old State: connected, new state: roaming
Mar 04 13:35:14 p3-1147 iwd[443]: src/wiphy.c:wiphy_radio_work_done()
Work item 5 done
Mar 04 13:35:14 p3-1147 iwd[443]: src/wiphy.c:wiphy_radio_work_next()
Starting work item 6
Mar 04 13:35:14 p3-1147 iwd[443]: src/wiphy.c:wiphy_radio_work_done()
Work item 6 done
Mar 04 13:35:14 p3-1147 iwd[443]:
src/station.c:station_fast_transition_cb() 5, result: 1
Mar 04 13:35:14 p3-1147 iwd[443]: src/station.c:station_roam_failed() 5
Mar 04 13:35:14 p3-1147 iwd[443]: src/station.c:station_disassociated() 5
Mar 04 13:35:14 p3-1147 iwd[443]:
src/resolve.c:resolve_systemd_revert() ifindex: 5
Mar 04 13:35:14 p3-1147 iwd[443]: src/station.c:station_enter_state()
Old State: roaming, new state: disconnected
Mar 04 13:35:14 p3-1147 iwd[443]: src/station.c:station_enter_state()
Old State: disconnected, new state: autoconnect_quick
...
Mar 04 13:36:16 p3-1147 iwd[443]:
src/station.c:__station_connect_network() connecting to BSS
*:*:*:*:08:71
Mar 04 13:36:16 p3-1147 iwd[443]: src/station.c:station_enter_state()
Old State: autoconnect_full, new state: connecting (auto)
Mar 04 13:36:16 p3-1147 iwd[443]: src/scan.c:scan_periodic_stop()
Stopping periodic scan for wdev 2
Mar 04 13:36:16 p3-1147 iwd[443]: src/scan.c:scan_cancel() Trying to
cancel scan id 13 for wdev 2
Mar 04 13:36:16 p3-1147 iwd[443]: src/wiphy.c:wiphy_radio_work_done()
Work item 13 done
Mar 04 13:36:16 p3-1147 iwd[443]: src/wiphy.c:wiphy_radio_work_next()
Starting work item 14
Mar 04 13:36:16 p3-1147 iwd[443]: src/wiphy.c:wiphy_radio_work_done()
Work item 14 done
Mar 04 13:36:16 p3-1147 iwd[443]: src/station.c:station_connect_cb()
5, result: 2
Mar 04 13:36:16 p3-1147 iwd[443]: src/station.c:station_enter_state()
Old State: connecting (auto), new state: disconnected
...
Mar 04 13:36:31 p3-1147 iwd[443]:
src/station.c:station_autoconnect_next() autoconnect: No suitable
BSSes found
```

Kind Regards,
Michael Johnson
--===============0859101193657021155==--

