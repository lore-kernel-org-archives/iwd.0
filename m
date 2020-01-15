Content-Type: multipart/mixed; boundary="===============0243527550023849565=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/3] wsc: Split out enrollee state machine to own object
Date: Wed, 15 Jan 2020 03:41:45 +0100
Message-ID: <CAOq732+d7H4x_VOeP-SeGYxzBCqoziqvCQA+9LBfpb-6XqZSgQ@mail.gmail.com>
In-Reply-To: <f614a716-3f47-1b49-9bfc-b3b9500f4296@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0243527550023849565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 15 Jan 2020 at 02:54, Denis Kenzior <denkenz@gmail.com> wrote:
> On 1/14/20 7:23 PM, Andrew Zaborowski wrote:
> > On Mon, 13 Jan 2020 at 19:49, Denis Kenzior <denkenz@gmail.com> wrote:
> >> This happens only on wsc_free, and I think you should be bypassing
> >> calling wsc_enrollee_cancel in that case.  The netdev is likely already
> >> gone by then anyway.
> >
> > wsc_free may happen because the netdev is going away or because iwd is
> > shutting down, or we're switching modes.  In those cases if we have a
>
> There are two cases, in both cases it is too late to send CMD_DISCONNECT:
>
> 1. netdev_set_iftype path.  If the interface is up, we bring it down
> first.  This is what causes the NETDEV_WATCH_EVENT_DOWN.  Trying to send
> netdev_disconnect seems sort of pointless.

Trying to send CMD_DISCONNECT is pointless there but netdev_disconnect
still achieves what we need which is cancel the connect callback.

>
> 2. netdev itself is removed.  At which point netdev_connect_free has
> been called or we cancel the netdev_disconnect command if it is pending.
>   netdev object is destroyed shortly thereafter.  So it is absolutely
> wrong to call netdev_connect in the watch callback here.

Right, but the wsc_enrollee object will have been freed inside that
netdev_connect_free call and we wouldn't be calling
wsc_enrollee_cancel or netdev_disconnect anymore.  Conceptually
whenever we do have a netdev_connect running who's callback is still
pending, I believe we should call netdev_disconnect, and whenever we
have a wsc_enrollee object we need to call wsc_enrollee_cancel.

>
> > WSC negotiation running we should try to send the disconnect, although
> > I think this is automatically triggered at some lower layer too.  But
>
> It is.  And on an iface type switch in case you're not running mac80211
> and the driver supports 'live' iftype switching.
>
> > we also use netdev_disconnect to sort of make sure we never get
> > another connect callback from netdev and I don't think skipping it is
>
> See above.  We really shouldn't anyway.  station doing it is absolutely
> wrong in the NETDEV_WATCH_EVENT_DEL case for sure.  And even the
> EVENT_DOWN case is likely wrong as well.
>
> > a good idea (we'd need to analyse a few code paths and add comments
> > and we might end up getting it wrong anyway).  This is why I think
> > station_free does it and I don't think it's wrong.
> >
>
> I disagree :)  I think likely what is saving station in this case is
> that the Disconnect event comes first (most of the time).  But
> inherently we might get this event via RTNL first and then we can go *boo=
m*.

Mostly what can happen is that the CMD_DISCONNECT command returns an
error so we've sent a useless command (if we'd cancelled a wrong
connection attempt that would be slightly worse).  On the other hand
if we free station without calling netdev_disconnect, then things can
actually go *boom* because we could get the connect callback with an
outdated user_data pointer.

Best regards
--===============0243527550023849565==--

