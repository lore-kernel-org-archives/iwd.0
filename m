Content-Type: multipart/mixed; boundary="===============8518855033274650338=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/5] station: Add current hidden network to networks_sorted
Date: Thu, 08 Oct 2020 22:56:31 +0200
Message-ID: <CAOq732L=YT8QiQ-6UTHjX2=Bv_Yb44AupVMV=Xbnquh0YLYZcA@mail.gmail.com>
In-Reply-To: <01f267af-3e6b-8ed3-347d-0dbd8663db77@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8518855033274650338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, 8 Oct 2020 at 17:19, Denis Kenzior <denkenz@gmail.com> wrote:
> On 10/8/20 3:49 AM, Andrew Zaborowski wrote:
> > Update station->networks_sorted with new networks added inside
> > station_hidden_network_scan_results() because we rely on
> > station->networks being in sync with station->networks_sorted.
> > Otherwise station_set_scan_results may crash.
>
> Have you encountered a crash?  Or just suspect one exists?  A crash log w=
ould be
> nice.

I was running under valgrind and it just reported invalid accesses but
didn't crash that time.

>
> >
> > Optimally a generic scan shouldn't happen while we're connecting to a
> > new hidden network because the generic scan doesn't know about the
> > hidden network's SSID and will not include the SSID in the probe request
> > so it can at most expire the BSS we're trying to connect to.  However we
> > can't easily tell whether we're in the middle of a Connect() or
> > ConnectHiddenNetwork() call as mentioned in the previous commit, so we
> > have to accept that we may trigger a new scan while waiting for secrets
>
> Right.
>
> > from the agent.  Thus the BSS discovered in the active scan for the
> > hidden SSID may expire if the agent request takes too long but we this
> > change at least we don't crash.
>
> So looks like you're concerned about network_bss_list_clear() not being c=
alled
> on the temporary network we're connecting to (because
> station_hidden_network_scan_results() never adds it to the networks_sorte=
d list)

Right, so we don't call network_bss_list_clear() on the hidden network
but we do free the old BSS because the new bss list has the same BSS
in it (in my case it did include the SSID, it was identical).  Next we
try to insert the new scan_bss into the network and
scan_bss_rank_compare() triggers an invalid access.

> and those bsses being expired by station_bss_list_remove_expired_bsses().=
..?
> But then the crash would likely happen in network_connect somewhere...
>
> But actually the nastier issue is if the new scan result list contains th=
e same
> BSSes but in hidden form...

True, in that case I guess the old BSS gets freed and the network gets
removed.  We probably need to treat it as a special case in
station_set_scan_results.

>
> > ---
> >   src/station.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/src/station.c b/src/station.c
> > index 6ac9e53b..b70d3416 100644
> > --- a/src/station.c
> > +++ b/src/station.c
> > @@ -2572,11 +2572,16 @@ static bool station_hidden_network_scan_results=
(int err,
> >                                       memcmp(bss->ssid, ssid, ssid_len))
> >                       goto next;
> >
> > -             if (station_add_seen_bss(station, bss)) {
> > -                     l_queue_push_tail(station->bss_list, bss);
> > +             network =3D station_add_seen_bss(station, bss);
> > +             if (!network)
> > +                     goto next;
> >
> > -                     continue;
> > -             }
> > +             l_queue_push_tail(station->bss_list, bss);
> > +             network_rank_update(network, false);
> > +             l_queue_remove(station->networks_sorted, network);
> > +             l_queue_insert(station->networks_sorted, network,
> > +                             network_rank_compare, NULL);
> > +             continue;
>
> This looks okay.  Not sure if we really care about showing this network a=
s part
> of the sorted list until we're attempting to connect, so maybe just using
> l_hashmap_foreach(station->networks, network_bss_list_clear()) would be b=
etter?

Inside station_set_scan_results?  That would work too, but I think it
may be better to be consistent and report this network like other
networks in case it confuses clients.

>
> But it seems to me this still doesn't solve the issue of the hidden netwo=
rk
> object being removed by process_network() if the scan is performed?

Right, I didn't realize the whole network would get removed.  If it
was just the BSSes then the next time network.c tries to select a BSS
it would just abort connection, but if the network goes away we crash.
So I didn't bother fixing every scenario in this patchset.

I was thinking ConnectHiddenNetwork should set connected_bss,
connected_network from the beginning, and station_is_busy() should
report true.  network.c and wsc.c should look at station_is_busy()
before accepting a connection, and should also notify station that
they have a pending Connect() / PushButton() / StartPIN().

Best regards
--===============8518855033274650338==--

