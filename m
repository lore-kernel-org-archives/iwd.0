Content-Type: multipart/mixed; boundary="===============0448477756872318520=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/3] wsc: Split out enrollee state machine to own object
Date: Thu, 16 Jan 2020 00:45:24 +0100
Message-ID: <CAOq732KZY9zWPJQ0NY5Q+2aZ32Tr2zaHejz362ra0e8zriqH6A@mail.gmail.com>
In-Reply-To: <c93a94b9-fd60-3896-307a-e3b74f3a7350@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0448477756872318520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jan 2020 at 00:09, Denis Kenzior <denkenz@gmail.com> wrote:
> >> Are you sure? netdev_connect_free doesn't invoke callbacks.  It is
> >> netdev_connect_failed and netdev_connect_ok that do.
> >
> > True, I misread something.
> >
>
> Also note that by extension, netdev_disconnect only calls the connect_cb
> with ABORTED.  It doesn't do anything if the connection is 'operational'.

It calls netdev_connect_free, and that wipes the callback so it does
exactly what we need.

>
> >>
> >>> pending, I believe we should call netdev_disconnect, and whenever we
> >>> have a wsc_enrollee object we need to call wsc_enrollee_cancel.
> >>
> >> I think we should not try to lump together a 'clean-async-shutdown' and
> >> 'cleanup-right-away' concepts.
> >
> > Ok, then we need two methods for wsc_enrollee.  I also think that
>
> Isn't this what I keep trying to tell you? :)

Oh, ok.  Then we agree on this since early in this thread :)

>
> > station and wsc_enrollee shouldn't assume whether the netdev is going
> > away or not, based on whether station and/or wsc_enrollee are going
>
> They should not.  But in effect they're being told that they're being
> removed and to clean up after themselves immediately.  No async cleanup
> is possible.

So here you're agreeing that station_free should not be assuming that
the netdev is going away --> station_free *should* call some sort of
netdev cleanup function (netdev_disconnect or a new function that
doesn't send a CMD_DISCONNECT, but does call netdev_connect_free)...

>
> > away.  So rather than assume the connect callback is not getting
> > happening anymore, they also should call a cleanup-right-away function
> > for netdev.  Or ideally they'd just call a 'cleanup' function and it
> > would be netdev figuring out which cleanup it needs, but if you want
> > two separate methods I can add this.
>
> They should not.  netdev already knows everything it needs to clean up
> after itself.

...But here you're saying they shouldn't call any netdev cleanup
function?  Perhaps I'm misunderstanding you.

>
> >
> >>
> >>>> I disagree :)  I think likely what is saving station in this case is
> >>>> that the Disconnect event comes first (most of the time).  But
> >>>> inherently we might get this event via RTNL first and then we can go=
 *boom*.
> >>>
> >>> Mostly what can happen is that the CMD_DISCONNECT command returns an
> >>> error so we've sent a useless command (if we'd cancelled a wrong
> >>> connection attempt that would be slightly worse).  On the other hand
> >>> if we free station without calling netdev_disconnect, then things can
> >>> actually go *boom* because we could get the connect callback with an
> >>> outdated user_data pointer.
> >>
> >> Aha!  And this is likely why this was added in the first place:
> >>          git show daf248e1b
> >>
> >> But it doesn't make it 'right' from an API perspective.  I suspect that
> >> netdev should be invoking connect_cb with ABORTED in this case instead.
> >> In fact I'm still a bit lost what this call is accomplishing at the
> >> moment.
> >
> > In the current code it is preventing a crash in station_connect_cb thou=
gh.
> >
>
> Hmm, I take it because we call connect_cb with an invalid station
> object?  In other words:
>
>         1. we get rtnl event that netdev is down.
>         2. This results in station being removed.
>         3. Then nl80211 sends us a Disconnect event.
>         4. netdev calls connect_cb with an invalid object
>
> But again, IMO the fix should be in netdev, not station.
>
> netdev should cleanup whatever stale state it has when it receives 1.
> It *knows* what just happened, it should not be depending on every
> client it has to do the right thing instead.

That will hardcode the assumption that the netdev is disappearing in
station.  If they have a "client" type relationship then station
should take care of cleaning up the processes it has initiated.
Otherwise it would need to be very well documented in the comments and
I bet we'll still occasionally get it wrong, the relationship just
becomes very complex.

>
> Maybe you want it to invoke connect_cb with ABORTED after step 1, but
> looking at station code it already takes care of this in station_free.
>
> >> The only thing station_connect_cb does when
> >> NETDEV_RESULT_ABORTED is set is to generate a dbus reply.  And then we
> >> do it unconditionally later in station_free.
> >
> > Well it's conditional and I guess the condition is always false
> > because we always send the reply in station_connect_cb (but we don't
> > enter the CONNECTED stated until netconfig is successful? should we
> > also delay the dbus reply?)
>
> Right.  Imprecise wording from me.  We do it if connect_pending is
> non-NULL, but we always check it.
>
> >
> > So it looks like we should either not send the reply in
> > station_connect_cb if the result is aborted, or not send it in
> > station_free (that'd be my preference).  I think we should also be
>
> I'd just have netdev invoke netdev_connect_free prior to
> NETDEV_WATCH_EVENT_DOWN.  And remove netdev_disconnect from station_free.
>
> > able to cancel a netdev_disconnect() if one is running asynchronously.
>
> Curious.  For what purpose?

Same as the netdev_disconnect call makes netdev forget station's
connect_cb, as far as I'm reading netdev.c there's currently no place
where disconnect_cb is forgotten when station gets freed so we likely
have the same crash there.

Best regards
--===============0448477756872318520==--

