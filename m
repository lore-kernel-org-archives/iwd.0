Content-Type: multipart/mixed; boundary="===============3203538660563885918=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 06/12] frame-xchg: set allow multicast flag
Date: Thu, 20 Jan 2022 15:14:52 -0800
Message-ID: <9ebbb00a664361e673146f60e0b936302ca6d66b.camel@gmail.com>
In-Reply-To: 0ad74b26-9ea4-d703-7026-fb4eb6ef9ecc@gmail.com

--===============3203538660563885918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-01-20 at 14:17 -0600, Denis Kenzior wrote:
> Hi James,
> =

> On 1/18/22 15:25, James Prestwood wrote:
> > Receiving multicast frames is required by DPP
> > ---
> > =C2=A0 src/frame-xchg.c | 1 +
> > =C2=A0 1 file changed, 1 insertion(+)
> > =

> > diff --git a/src/frame-xchg.c b/src/frame-xchg.c
> > index 5ba36081..95c030d8 100644
> > --- a/src/frame-xchg.c
> > +++ b/src/frame-xchg.c
> > @@ -611,6 +611,7 @@ bool frame_watch_add(uint64_t wdev_id, uint32_t
> > group_id, uint16_t frame_type,
> > =C2=A0 =

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l_genl_msg_append_attr(=
msg, NL80211_ATTR_WDEV, 8,
> > &wdev_id);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l_genl_msg_append_attr(=
msg, NL80211_ATTR_FRAME_TYPE, 2,
> > &frame_type);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l_genl_msg_append_attr(msg, =
NL80211_ATTR_RECEIVE_MULTICAST,
> > 0, NULL);
> =

> Should this be opt-in?=C2=A0 You may want to audit all uses of
> frame_watch_add to see =

> if they can deal with multicast frames.

I can make it dependent on a bool argument. Better than unnecissarily
passing on broadcasts to modules that don't care.

> =

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l_genl_msg_append_attr(=
msg, NL80211_ATTR_FRAME_MATCH,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prefix_len, prefix);
> > =C2=A0 =

> > =

> =

> Regards,
> -Denis


--===============3203538660563885918==--

