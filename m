Content-Type: multipart/mixed; boundary="===============4123199588746177830=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Re: Permanent disconnect when AP changes frequency
Date: Mon, 07 Mar 2022 17:43:09 +0000
Message-ID: <CACsRnHXQC+6DwWdmJvykErkVxL9CgoSoot8U_gWkd-U+hLppUA@mail.gmail.com>
In-Reply-To: CACsRnHX3EQyys=PSzD9Ng6psF4RPRhxmzh2crLru6f=+WO5YcQ@mail.gmail.com

--===============4123199588746177830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

I've tested the patch and it does seem to fix the initial disconnect, thank=
 you!
I'm still hoping to get the extra kernel message to debug the
subsequent failures but that might take some time.

Regards,
Michael

On Mon, 7 Mar 2022 at 11:14, Michael Johnson <mjohnson459(a)gmail.com> wrot=
e:
>
> Hi James,
>
> Thanks for the quick response. I'll test out the patch today and I'll
> also see if I can rebuild the kernel to get more information on what
> is happening.
>
> Regards,
> Michael
>
> On Fri, 4 Mar 2022 at 21:28, James Prestwood <prestwoj(a)gmail.com> wrote:
> >
> > Hi Michael,
> >
> > On Fri, 2022-03-04 at 17:18 +0000, Michael Johnson wrote:
> > > Hi James,
> > >
> > > On Fri, 4 Mar 2022 at 16:59, James Prestwood <prestwoj(a)gmail.com>
> > > wrote:
> > >
> > > > Was this the AP doing this on its own? Or did you manually change t=
he
> > > > frequency. In theory a channel switch should come as an event and y=
ou
> > > > would see this in the logs:
> > > >
> > > > netdev_channeL_switch_event() Channel switch event, frequenct: <fre=
q>
> > >
> > > I manually changed it but I don't see any "Channel switch event" in
> > > the logs. The client wasn't connected to the AP at the time of the
> > > change and it only failed when it tried to roam normally.
> > >
> > > > This shouldn't be permanent, but the more times the connection fails
> > > > the longer the timer. In your case though the FT failure will not
> > > > cause
> > > > a blacklist, only the association failure. The default is 60 seconds
> > > > though, so that is quite a while.
> > >
> > > It looks like it came off the blacklist once but still failed and was
> > > put back on it.
> > >
> > > Mar 04 13:35:15 p3-1147 iwd[443]:
> > > src/station.c:__station_connect_network() connecting to BSS *:08:71
> > > Mar 04 13:35:15 p3-1147 iwd[443]: src/station.c:station_connect_cb()
> > > 5, result: 2
> > > Mar 04 13:35:15 p3-1147 iwd[443]: src/station.c:station_connect_cb()
> > > Nothing left on autoconnect list
> > > Mar 04 13:35:23 p3-1147 iwd[443]:
> > > src/station.c:__station_connect_network() connecting to BSS *:07:b1
> > > Mar 04 13:35:23 p3-1147 iwd[443]: src/station.c:station_connect_cb()
> > > 5, result: 2
> > > Mar 04 13:35:23 p3-1147 iwd[443]: src/station.c:station_connect_cb()
> > > Nothing left on autoconnect list
> > > Mar 04 13:36:16 p3-1147 iwd[443]:
> > > src/station.c:__station_connect_network() connecting to BSS *:08:71
> > > Mar 04 13:36:16 p3-1147 iwd[443]: src/station.c:station_connect_cb()
> > > 5, result: 2
> > > Mar 04 13:36:16 p3-1147 iwd[443]: src/station.c:station_connect_cb()
> > > Nothing left on autoconnect list
> > > Mar 04 13:36:24 p3-1147 iwd[443]:
> > > src/station.c:__station_connect_network() connecting to BSS *:07:b1
> > > Mar 04 13:36:24 p3-1147 iwd[443]: src/station.c:station_connect_cb()
> > > 5, result: 2
> > > Mar 04 13:36:24 p3-1147 iwd[443]: src/station.c:station_connect_cb()
> > > Nothing left on autoconnect list
> > >
> > > > > I'm guessing that changing the frequency wiped the auth from the =
AP
> > > > > which explains why the initial FT roam fails but I'm not sure what
> > > > > would be causing the subsequent failures.
> > > >
> > > > Could be. Looks like the failure after the failed roam never even g=
ot
> > > > to the AP. So the "association failure" is really just the kernel
> > > > failing (unless you're on brcmfmac?). Maybe something can be seen in
> > > > the kernel logs. I'm thinking the kernel got confused maybe with the
> > > > channel switch and probably needs to re-scan. Does a manual attempt
> > > > to
> > > > connect afterwards work?
> > >
> > > The kernel didn't print anything to the logs but I can try and capture
> > > extra details with iwmon. I couldn't test a manual connect as it's a
> > > headless machine but it was fine after a reboot.
> > > I can try to trigger it again with a hardwire so I can check the
> > > manual connection.
> > >
> > > > > Looking at `src/station.c:station_retry_with_status` would it make
> > > > > sense to clean whatever auth data we have for FT if the status is
> > > > > an
> > > > > AUTH failure?
> > > >
> > > > The retry logic really only matters for new connections. Once IWD
> > > > goes
> > > > into a disconnected state (like after you're roam failure) any
> > > > previous
> > > > connection data is cleared out.
> > >
> > > Does that mean whatever is going wrong is at the kernel level? It
> > > seems like some state is cached somewhere if all subsequent
> > > connections fail.
> >
> > We've identified one issue [1] which should help here and actually fix
> > the initial roam, but even with this you should have been able to
> > connect again after IWD re-scans so we think something else may be
> > going on.
> >
> > Is it possible for you to rebuild the kernel and disable a NL80211
> > flag? We cant see some messages because the kernel is clearing out a
> > buffer which it does on certain message types. We can use a big hammer
> > here and just disable this on all messages:
> >
> > diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> > index 578bff9c378b..17df9be1d5a3 100644
> > --- a/net/wireless/nl80211.c
> > +++ b/net/wireless/nl80211.c
> > @@ -15177,7 +15177,7 @@ static int nl80211_set_fils_aad(struct sk_buff
> > *skb,
> >  /* If a netdev is associated, it must be UP, P2P must be started */
> >  #define NL80211_FLAG_NEED_WDEV_UP      (NL80211_FLAG_NEED_WDEV |\
> >                                          NL80211_FLAG_CHECK_NETDEV_UP)
> > -#define NL80211_FLAG_CLEAR_SKB         0x20
> > +#define NL80211_FLAG_CLEAR_SKB         0x00
> >  #define NL80211_FLAG_NO_WIPHY_MTX      0x40
> >
> >  static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff
> > *skb,
> >
> > And then run iwmon with this disabled. Hopefully we can get a bit more
> > from this.
> >
> > Thanks,
> > James
> >
> > [1]
> > https://lists.01.org/hyperkitty/list/iwd(a)lists.01.org/thread/ED5XTWW2=
HITGBDJJBDFOXMNZDIPHSSGE/
> >
> > >
> > > Regards,
> > > Michael
> >
> >
--===============4123199588746177830==--

