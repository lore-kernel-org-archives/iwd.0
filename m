Content-Type: multipart/mixed; boundary="===============6217563320785082380=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Re: Permanent disconnect when AP changes frequency
Date: Fri, 04 Mar 2022 17:18:51 +0000
Message-ID: <CACsRnHXw1gyU2pRDsVc4hqMqPk7zBcKahXOjYUPgC3_=_5KktQ@mail.gmail.com>
In-Reply-To: 87a2ab3d8a1f5a382df076319068c83e9f8ff051.camel@gmail.com

--===============6217563320785082380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On Fri, 4 Mar 2022 at 16:59, James Prestwood <prestwoj(a)gmail.com> wrote:

> Was this the AP doing this on its own? Or did you manually change the
> frequency. In theory a channel switch should come as an event and you
> would see this in the logs:
>
> netdev_channeL_switch_event() Channel switch event, frequenct: <freq>

I manually changed it but I don't see any "Channel switch event" in
the logs. The client wasn't connected to the AP at the time of the
change and it only failed when it tried to roam normally.

> This shouldn't be permanent, but the more times the connection fails
> the longer the timer. In your case though the FT failure will not cause
> a blacklist, only the association failure. The default is 60 seconds
> though, so that is quite a while.

It looks like it came off the blacklist once but still failed and was
put back on it.

Mar 04 13:35:15 p3-1147 iwd[443]:
src/station.c:__station_connect_network() connecting to BSS *:08:71
Mar 04 13:35:15 p3-1147 iwd[443]: src/station.c:station_connect_cb()
5, result: 2
Mar 04 13:35:15 p3-1147 iwd[443]: src/station.c:station_connect_cb()
Nothing left on autoconnect list
Mar 04 13:35:23 p3-1147 iwd[443]:
src/station.c:__station_connect_network() connecting to BSS *:07:b1
Mar 04 13:35:23 p3-1147 iwd[443]: src/station.c:station_connect_cb()
5, result: 2
Mar 04 13:35:23 p3-1147 iwd[443]: src/station.c:station_connect_cb()
Nothing left on autoconnect list
Mar 04 13:36:16 p3-1147 iwd[443]:
src/station.c:__station_connect_network() connecting to BSS *:08:71
Mar 04 13:36:16 p3-1147 iwd[443]: src/station.c:station_connect_cb()
5, result: 2
Mar 04 13:36:16 p3-1147 iwd[443]: src/station.c:station_connect_cb()
Nothing left on autoconnect list
Mar 04 13:36:24 p3-1147 iwd[443]:
src/station.c:__station_connect_network() connecting to BSS *:07:b1
Mar 04 13:36:24 p3-1147 iwd[443]: src/station.c:station_connect_cb()
5, result: 2
Mar 04 13:36:24 p3-1147 iwd[443]: src/station.c:station_connect_cb()
Nothing left on autoconnect list

> > I'm guessing that changing the frequency wiped the auth from the AP
> > which explains why the initial FT roam fails but I'm not sure what
> > would be causing the subsequent failures.
>
> Could be. Looks like the failure after the failed roam never even got
> to the AP. So the "association failure" is really just the kernel
> failing (unless you're on brcmfmac?). Maybe something can be seen in
> the kernel logs. I'm thinking the kernel got confused maybe with the
> channel switch and probably needs to re-scan. Does a manual attempt to
> connect afterwards work?

The kernel didn't print anything to the logs but I can try and capture
extra details with iwmon. I couldn't test a manual connect as it's a
headless machine but it was fine after a reboot.
I can try to trigger it again with a hardwire so I can check the
manual connection.

> > Looking at `src/station.c:station_retry_with_status` would it make
> > sense to clean whatever auth data we have for FT if the status is an
> > AUTH failure?
>
> The retry logic really only matters for new connections. Once IWD goes
> into a disconnected state (like after you're roam failure) any previous
> connection data is cleared out.

Does that mean whatever is going wrong is at the kernel level? It
seems like some state is cached somewhere if all subsequent
connections fail.

Regards,
Michael
--===============6217563320785082380==--

