Content-Type: multipart/mixed; boundary="===============0180905166611292185=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/11] netdev: Add a wdev_id based frame watch API
Date: Wed, 23 Oct 2019 01:56:53 +0200
Message-ID: <CAOq732KNTME=saetsGbhU6mdx7cjUd_PJdGbGwBmZdDOO4=q9w@mail.gmail.com>
In-Reply-To: <80e427d5-7b3a-41c4-bb37-8d40fef3fd6e@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0180905166611292185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Oct 2019 at 16:53, Denis Kenzior <denkenz@gmail.com> wrote:
> On 10/21/19 8:55 AM, Andrew Zaborowski wrote:
> > diff --git a/src/netdev.h b/src/netdev.h
> > index 114a6035..624811b2 100644
> > --- a/src/netdev.h
> > +++ b/src/netdev.h
> > @@ -197,6 +197,12 @@ uint32_t netdev_frame_watch_add(struct netdev *net=
dev, uint16_t frame_type,
> >                               void *user_data);
> >   bool netdev_frame_watch_remove(struct netdev *netdev, uint32_t id);
> >
> > +uint32_t netdev_wdev_frame_watch_add(uint64_t wdev_id, uint16_t frame_=
type,
> > +                             const uint8_t *prefix, size_t prefix_len,
> > +                             netdev_frame_watch_func_t handler,
> > +                             void *user_data);
> > +bool netdev_wdev_frame_watch_remove(uint32_t id);
> > +
>
> So this really seems like it is jammed in there and it doesn't fit well.
>
> I think that we should make frame watches into a separate module now
> that they no longer are only associated with a netdev.

Ok, I only put it inside netdev as an extension of the current api.

> This would allow
> us to also track iftype changes and wipe out those frame watches that
> are no longer registered with the kernel.  And also allow us not to try
> and register frame watches that are already live (and bounce with an
> -EAGAIN from the kernel).

The problem is how we will know what logic is implemented in the
running kernel version.  We also watch iftype changes inside netdev so
we can more comfortably do it here but I'm not sure it helps us.  In
P2P I'm registering and unregistering the watches for specific
operations and we never switch iftypes.  I think we should either have
the kernel have a simple frame unregister command or keep all of the
watches for simplicity.

>
> We could also implement 'transient' frame watch sets by using a genl
> socket dedicated to each set.  At least until the kernel people fix
> their subsystem.

This sounds like it's much more costly in terms of syscalls and kernel
work (and code) than occasionally getting the EAGAIN for a register
command.

Best regards
--===============0180905166611292185==--

