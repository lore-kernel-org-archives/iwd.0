Content-Type: multipart/mixed; boundary="===============7409437010623200119=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/11] netdev: Add a wdev_id based frame watch API
Date: Wed, 23 Oct 2019 03:04:03 +0200
Message-ID: <CAOq732L3fbzYa+UUjpGgxUfBe20UxYnTSD6aawSeLH_VEOzCpA@mail.gmail.com>
In-Reply-To: <db67b31f-f79d-351a-eb23-d270597e686e@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7409437010623200119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Oct 2019 at 02:23, Denis Kenzior <denkenz@gmail.com> wrote:
> On 10/22/19 6:56 PM, Andrew Zaborowski wrote:
> > On Tue, 22 Oct 2019 at 16:53, Denis Kenzior <denkenz@gmail.com> wrote:
> >> This would allow
> >> us to also track iftype changes and wipe out those frame watches that
> >> are no longer registered with the kernel.  And also allow us not to try
> >> and register frame watches that are already live (and bounce with an
> >> -EAGAIN from the kernel).
> >
> > The problem is how we will know what logic is implemented in the
> > running kernel version.  We also watch iftype changes inside netdev so
>
> Well, the particular fix from me got backported into every single LTS
> kernel.  So we just assume the fix is included.  Unless you want to go
> full wpa_s and use a separate socket for each frame watch.

Ok, so we add a framewatch.c or similar, it'll keep a list of all
registered frame types+prefixes even after our local users have
unregistered from them.  It will listen for SET_INTERFACE events and
drop the watches matching the wdev_id from the list.

>
> > we can more comfortably do it here but I'm not sure it helps us.  In
> > P2P I'm registering and unregistering the watches for specific
> > operations and we never switch iftypes.  I think we should either have
>
> Yeah, I think you have to bite the bullet and implement a separate
> socket for these.

Ok, then we also open a new genl socket for some frame watches, should
we do this depending on the iftype?  I.e. for any iftype other than
managed, ad-hoc and AP?

>
> > watches for simplicity.
>
> I don't think this is a good idea.  It will cause unnecessary wakeups
> and round trips into the kernel.  And any one of these is one too many.

Right but opening and closing sockets also causes a lot of round trips
into the kernel so I'm not clear that we're making progress by doing
this.

>
> >
> >>
> >> We could also implement 'transient' frame watch sets by using a genl
> >> socket dedicated to each set.  At least until the kernel people fix
> >> their subsystem.
> >
> > This sounds like it's much more costly in terms of syscalls and kernel
> > work (and code) than occasionally getting the EAGAIN for a register
> > command.
>
> If you assume that frame watches are purged on iftype change, then most
> of the EAGAINs are only caused by netdev ifup/ifdown.  So those we can
> take care of easily.
>
> Unnecessary wakeups should be avoided completely.  So if you have p2p
> frame watches and you can group them into a set to enable / disable,
> then they should be registered for on a separate socket.

The kernel api under our framewatch API may change again (and
hopefully will) so I'm thinking it would be good to not clutter our
API very visibly with those details.  Maybe a simple group_id integer
parameter when registering a new frame watch would be enough to do the
grouping.  The users of the API can treat it as informational, or a
"suggestion" on how to group those frame watches (if needed at all).
Underneath the API would open one socket for each group and would
automatically close the socket only if all of the watches from that
group have been removed, so that even if the grouping is wrong or
unnecessary, the user sees exactly the same results.

For the managed, ad-hoc and AP interface types the user would still be
expected to unregister their watches when cleaning up, even though
they would be NOPs since those would be purged by the iftype change.

Since we know that we can't unregister from frames at the kernel, if
the user adds a new prefix that matches a shorter existing prefix we
can skip the registration, like we do in netdev.  If the user adds a
watch for a shorter prefix then we register that one with the kernel
and just let both live in the kernel until an iftype switch or until
the socket closes.  I guess it's not worth the effort to consider
matching prefixes in other "groups" on the same interface because we
won't have many groups.

Best regards
--===============7409437010623200119==--

