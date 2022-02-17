Content-Type: multipart/mixed; boundary="===============8349182021166316799=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 04/10] frame-xchg: allow multicast frame watches
Date: Thu, 17 Feb 2022 16:47:23 +0100
Message-ID: <CAOq732Jze4EpHz+hVs325D5u7ORp=Pno1hf0GDgzxxdP6iJTEA@mail.gmail.com>
In-Reply-To: c53f2941ef60b35232352b24d3ffde2d01ab10b1.camel@gmail.com

--===============8349182021166316799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On Wed, 16 Feb 2022 at 22:05, James Prestwood <prestwoj(a)gmail.com> wrote:
> On Tue, 2022-02-15 at 00:28 +0100, Andrew Zaborowski wrote:
> > It may be easier to always set the flag in the REGISTER_FRAMEs and
> > check whether the received frame was multicast before calling the
> > frame callback.  In that case the multicast flag can be set on a
> > watch
> > in a separate call, after frame_watch_add.
>
> So have frame_watch_set_multicast_allowed() act on entire groups rather
> than individual watches? I don't see any other way for it to work at
> least.

That's a good idea too.  I was thinking, since frame_watch_add()
returns no watch ID, that you'd either pass the same set of arguments
to frame_watch_set_multicast_allowed() that you passed to
frame_watch_add() to identify the watch, or do
frame_watch_set_multicast_by_handler (similar to
frame_watch_remove_by_handler).

> And I'm not sure we want to do this for group 0 since it could
> impact other modules.

Right.

>
> Maybe also we should start using non-zero groups, i.e. each module
> (DPP, P2P, ANQP etc.) use their own group number? Just an idea. Maybe
> this is what was intended all along but at least I haven't been doing
> that :)

So the idea was to create groups for watches that may need to be
removed before the interface is removed or has its iftype changed
(those events implicitly discard watches) but it might also be useful
to do for this multicast feature.

Best regards
--===============8349182021166316799==--

