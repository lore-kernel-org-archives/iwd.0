Content-Type: multipart/mixed; boundary="===============7659777673641595977=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 04/10] frame-xchg: allow multicast frame watches
Date: Thu, 17 Feb 2022 08:37:50 -0800
Message-ID: <e1a16c74abefb772c7b7bd57cd3033cc543872ea.camel@gmail.com>
In-Reply-To: CAOq732Jze4EpHz+hVs325D5u7ORp=Pno1hf0GDgzxxdP6iJTEA@mail.gmail.com

--===============7659777673641595977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, 2022-02-17 at 16:47 +0100, Andrew Zaborowski wrote:
> Hi James,
> =

> On Wed, 16 Feb 2022 at 22:05, James Prestwood <prestwoj(a)gmail.com>
> wrote:
> > On Tue, 2022-02-15 at 00:28 +0100, Andrew Zaborowski wrote:
> > > It may be easier to always set the flag in the REGISTER_FRAMEs
> > > and
> > > check whether the received frame was multicast before calling the
> > > frame callback.=C2=A0 In that case the multicast flag can be set on a
> > > watch
> > > in a separate call, after frame_watch_add.
> > =

> > So have frame_watch_set_multicast_allowed() act on entire groups
> > rather
> > than individual watches? I don't see any other way for it to work
> > at
> > least.
> =

> That's a good idea too.=C2=A0 I was thinking, since frame_watch_add()
> returns no watch ID, that you'd either pass the same set of arguments
> to frame_watch_set_multicast_allowed() that you passed to
> frame_watch_add() to identify the watch, or do
> frame_watch_set_multicast_by_handler (similar to
> frame_watch_remove_by_handler).

Doing it by handler seems kinda weird for an exposed API, I would
rather do it by group for simplicity. And for any module that needs
multicast we just use a unique group.

Another option could be to return the watchlist ID from
frame_watch_add, and something like watchlist_item_find(). Besides the
few places that check the return I don't think this would be too
intrusive.

> =

> > And I'm not sure we want to do this for group 0 since it could
> > impact other modules.
> =

> Right.
> =

> > =

> > Maybe also we should start using non-zero groups, i.e. each module
> > (DPP, P2P, ANQP etc.) use their own group number? Just an idea.
> > Maybe
> > this is what was intended all along but at least I haven't been
> > doing
> > that :)
> =

> So the idea was to create groups for watches that may need to be
> removed before the interface is removed or has its iftype changed
> (those events implicitly discard watches) but it might also be useful
> to do for this multicast feature.
> =

> Best regards


--===============7659777673641595977==--

