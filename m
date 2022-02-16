Content-Type: multipart/mixed; boundary="===============0988929785989263698=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 04/10] frame-xchg: allow multicast frame watches
Date: Wed, 16 Feb 2022 13:05:53 -0800
Message-ID: <c53f2941ef60b35232352b24d3ffde2d01ab10b1.camel@gmail.com>
In-Reply-To: CAOq732JGcVesw0Styg4TpyjYBLXoFBepN99tukV-XcQVKE2ARA@mail.gmail.com

--===============0988929785989263698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2022-02-15 at 00:28 +0100, Andrew Zaborowski wrote:
> Hi,
> =

> On Tue, 15 Feb 2022 at 00:15, Denis Kenzior <denkenz(a)gmail.com>
> wrote:
> > > -bool frame_watch_add(uint64_t wdev_id, uint32_t group, uint16_t
> > > frame_type,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const uint8_t *prefi=
x, size_t prefix_len,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 frame_watch_cb_t han=
dler, void *user_data,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 frame_xchg_destroy_f=
unc_t destroy);
> > > +bool frame_watch_add(uint64_t wdev_id, uint32_t group, bool
> > > mcast,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t frame_type,=
 const uint8_t *prefix,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t prefix_len, f=
rame_watch_cb_t
> > > handler,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *user_data, fra=
me_xchg_destroy_func_t
> > > destroy);
> > =

> > Can we just add frame_watch_add_multicast_allowed instead?=C2=A0 The
> > number of
> > arguments in frame_watch_add is already too much.
> =

> The NL80211_ATTR_RECEIVE_MULTICAST flag needs to be set when we send
> the REGISTER_FRAME but since we have this logic to track duplicate
> and/or more general prefix watches, in some situations the logic may
> decide that there's no need to register a new longer prefix.=C2=A0 In
> other
> situations it will register a new, shorter prefix and the MULTICAST
> flag will affect existing watches set for more specific prefixes.
> =

> It may be easier to always set the flag in the REGISTER_FRAMEs and
> check whether the received frame was multicast before calling the
> frame callback.=C2=A0 In that case the multicast flag can be set on a
> watch
> in a separate call, after frame_watch_add.

So have frame_watch_set_multicast_allowed() act on entire groups rather
than individual watches? I don't see any other way for it to work at
least. And I'm not sure we want to do this for group 0 since it could
impact other modules.

Maybe also we should start using non-zero groups, i.e. each module
(DPP, P2P, ANQP etc.) use their own group number? Just an idea. Maybe
this is what was intended all along but at least I haven't been doing
that :)

> =

> Best regards


--===============0988929785989263698==--

