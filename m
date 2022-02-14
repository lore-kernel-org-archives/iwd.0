Content-Type: multipart/mixed; boundary="===============8745712285436104014=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 04/10] frame-xchg: allow multicast frame watches
Date: Tue, 15 Feb 2022 00:28:02 +0100
Message-ID: <CAOq732JGcVesw0Styg4TpyjYBLXoFBepN99tukV-XcQVKE2ARA@mail.gmail.com>
In-Reply-To: d996ac97-38b6-0392-fc1f-fc78f167ffa1@gmail.com

--===============8745712285436104014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 15 Feb 2022 at 00:15, Denis Kenzior <denkenz(a)gmail.com> wrote:
> > -bool frame_watch_add(uint64_t wdev_id, uint32_t group, uint16_t frame_=
type,
> > -                     const uint8_t *prefix, size_t prefix_len,
> > -                     frame_watch_cb_t handler, void *user_data,
> > -                     frame_xchg_destroy_func_t destroy);
> > +bool frame_watch_add(uint64_t wdev_id, uint32_t group, bool mcast,
> > +                     uint16_t frame_type, const uint8_t *prefix,
> > +                     size_t prefix_len, frame_watch_cb_t handler,
> > +                     void *user_data, frame_xchg_destroy_func_t destro=
y);
>
> Can we just add frame_watch_add_multicast_allowed instead?  The number of
> arguments in frame_watch_add is already too much.

The NL80211_ATTR_RECEIVE_MULTICAST flag needs to be set when we send
the REGISTER_FRAME but since we have this logic to track duplicate
and/or more general prefix watches, in some situations the logic may
decide that there's no need to register a new longer prefix.  In other
situations it will register a new, shorter prefix and the MULTICAST
flag will affect existing watches set for more specific prefixes.

It may be easier to always set the flag in the REGISTER_FRAMEs and
check whether the received frame was multicast before calling the
frame callback.  In that case the multicast flag can be set on a watch
in a separate call, after frame_watch_add.

Best regards
--===============8745712285436104014==--

