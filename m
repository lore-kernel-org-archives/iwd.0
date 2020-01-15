Content-Type: multipart/mixed; boundary="===============5539337019499511348=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/3] wsc: Split out enrollee state machine to own object
Date: Wed, 15 Jan 2020 23:17:00 +0100
Message-ID: <CAOq732K20rB8KWZeKL8tUxi=wbumQmwHQVFfOYdcwN+jCwtehA@mail.gmail.com>
In-Reply-To: <d774c86a-3b5f-ff3f-981a-c0d7f30e7593@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5539337019499511348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 15 Jan 2020 at 04:01, Denis Kenzior <denkenz@gmail.com> wrote:
> On 1/14/20 8:41 PM, Andrew Zaborowski wrote:
> > On Wed, 15 Jan 2020 at 02:54, Denis Kenzior <denkenz@gmail.com> wrote:
> >> There are two cases, in both cases it is too late to send CMD_DISCONNE=
CT:
> >>
> >> 1. netdev_set_iftype path.  If the interface is up, we bring it down
> >> first.  This is what causes the NETDEV_WATCH_EVENT_DOWN.  Trying to se=
nd
> >> netdev_disconnect seems sort of pointless.
> >
> > Trying to send CMD_DISCONNECT is pointless there but netdev_disconnect
> > still achieves what we need which is cancel the connect callback.
>
> I think this is the wrong way to accomplish this.  It feels like a hack
> / shortcut.  We simply should not be trying to utilize API that is meant
> to schedule a clean tear down when we already know this is futile.
>
> >
> >>
> >> 2. netdev itself is removed.  At which point netdev_connect_free has
> >> been called or we cancel the netdev_disconnect command if it is pendin=
g.
> >>    netdev object is destroyed shortly thereafter.  So it is absolutely
> >> wrong to call netdev_connect in the watch callback here.
>
> I did mean netdev_disconnect here by the way :)
>
> >
> > Right, but the wsc_enrollee object will have been freed inside that
> > netdev_connect_free call and we wouldn't be calling
> > wsc_enrollee_cancel or netdev_disconnect anymore.  Conceptually
> > whenever we do have a netdev_connect running who's callback is still
>
> Are you sure? netdev_connect_free doesn't invoke callbacks.  It is
> netdev_connect_failed and netdev_connect_ok that do.

True, I misread something.

>
> > pending, I believe we should call netdev_disconnect, and whenever we
> > have a wsc_enrollee object we need to call wsc_enrollee_cancel.
>
> I think we should not try to lump together a 'clean-async-shutdown' and
> 'cleanup-right-away' concepts.

Ok, then we need two methods for wsc_enrollee.  I also think that
station and wsc_enrollee shouldn't assume whether the netdev is going
away or not, based on whether station and/or wsc_enrollee are going
away.  So rather than assume the connect callback is not getting
happening anymore, they also should call a cleanup-right-away function
for netdev.  Or ideally they'd just call a 'cleanup' function and it
would be netdev figuring out which cleanup it needs, but if you want
two separate methods I can add this.

>
> >> I disagree :)  I think likely what is saving station in this case is
> >> that the Disconnect event comes first (most of the time).  But
> >> inherently we might get this event via RTNL first and then we can go *=
boom*.
> >
> > Mostly what can happen is that the CMD_DISCONNECT command returns an
> > error so we've sent a useless command (if we'd cancelled a wrong
> > connection attempt that would be slightly worse).  On the other hand
> > if we free station without calling netdev_disconnect, then things can
> > actually go *boom* because we could get the connect callback with an
> > outdated user_data pointer.
>
> Aha!  And this is likely why this was added in the first place:
>         git show daf248e1b
>
> But it doesn't make it 'right' from an API perspective.  I suspect that
> netdev should be invoking connect_cb with ABORTED in this case instead.
> In fact I'm still a bit lost what this call is accomplishing at the
> moment.

In the current code it is preventing a crash in station_connect_cb though.

> The only thing station_connect_cb does when
> NETDEV_RESULT_ABORTED is set is to generate a dbus reply.  And then we
> do it unconditionally later in station_free.

Well it's conditional and I guess the condition is always false
because we always send the reply in station_connect_cb (but we don't
enter the CONNECTED stated until netconfig is successful? should we
also delay the dbus reply?)

So it looks like we should either not send the reply in
station_connect_cb if the result is aborted, or not send it in
station_free (that'd be my preference).  I think we should also be
able to cancel a netdev_disconnect() if one is running asynchronously.

Best regards
--===============5539337019499511348==--

