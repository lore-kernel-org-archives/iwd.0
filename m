Content-Type: multipart/mixed; boundary="===============3583814758628992312=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/11] netdev: Add a wdev_id based frame watch API
Date: Thu, 24 Oct 2019 02:59:31 +0200
Message-ID: <CAOq732+um_VY=6saqOLxFeTZSyKSBUFjsiqW=YzqSLDLBGBW_A@mail.gmail.com>
In-Reply-To: <aff27890-261b-748a-622a-73f053433295@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3583814758628992312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 23 Oct 2019 at 03:32, Denis Kenzior <denkenz@gmail.com> wrote:
> On 10/22/19 8:04 PM, Andrew Zaborowski wrote:
> > On Wed, 23 Oct 2019 at 02:23, Denis Kenzior <denkenz@gmail.com> wrote:
> >> On 10/22/19 6:56 PM, Andrew Zaborowski wrote:
> >>> On Tue, 22 Oct 2019 at 16:53, Denis Kenzior <denkenz@gmail.com> wro=
te:
> >>>> This would allow
> >>>> us to also track iftype changes and wipe out those frame watches that
> >>>> are no longer registered with the kernel.  And also allow us not to =
try
> >>>> and register frame watches that are already live (and bounce with an
> >>>> -EAGAIN from the kernel).
> >>>
> >>> The problem is how we will know what logic is implemented in the
> >>> running kernel version.  We also watch iftype changes inside netdev so
> >>
> >> Well, the particular fix from me got backported into every single LTS
> >> kernel.  So we just assume the fix is included.  Unless you want to go
> >> full wpa_s and use a separate socket for each frame watch.
> >
> > Ok, so we add a framewatch.c or similar, it'll keep a list of all
> > registered frame types+prefixes even after our local users have
> > unregistered from them.  It will listen for SET_INTERFACE events and
> > drop the watches matching the wdev_id from the list.
> >
>
> Yes, something like this.  One thing we might want to do is simply have
> station, adhoc, ap, etc modules simply tell framewatch which events they
> care about.  And framewatch will register to these whenever iftype change=
s.

I took a look at netdev and ap.c and we don't really have frames that
we need to be unconditionally listening to.  In ap.c we only register
the watches when starting the AP and in netdev some of the watches
should be registered for either when we connect, when we send a
Neighbor Report Request or SA Query Request.  So in the end it looks
like we'll be using the separate socket per set/group everywhere.

Even if we had frames that we cared about for the whole time a
specific iftype is active, we'd still need the netdev/adhoc/ap modules
to update the user_data for the callbacks everytime we switch to that
iftype so it doesn't seem useful to automatically register to any
frames.

>
> >>
> >>> we can more comfortably do it here but I'm not sure it helps us.  In
> >>> P2P I'm registering and unregistering the watches for specific
> >>> operations and we never switch iftypes.  I think we should either have
> >>
> >> Yeah, I think you have to bite the bullet and implement a separate
> >> socket for these.
> >
> > Ok, then we also open a new genl socket for some frame watches, should
> > we do this depending on the iftype?  I.e. for any iftype other than
> > managed, ad-hoc and AP?
> >
>
> No, I think it should be an explicit api.  E.g. frame_watch_set_new,
> frame_watch_set_add, frame_watch_add_set();
>
> >>
> >>> watches for simplicity.
> >>
> >> I don't think this is a good idea.  It will cause unnecessary wakeups
> >> and round trips into the kernel.  And any one of these is one too many.
> >
> > Right but opening and closing sockets also causes a lot of round trips
> > into the kernel so I'm not clear that we're making progress by doing
> > this.
> >
>
> Tell this to the kernel people ;)
>
> In the case of P2P these would only be relevant when you initiate P2P
> discovery.  And closing the socket when your discovery finishes.
> However, stray beacons, probe requests, responses, etc can wake us up
> for quite some time afterwards.  You're also wasting battery time having
> the hardware wakeup the kernel for these since frequently they're
> filtered at the hardware when no frame watch is registered.  So overall
> I'd say opening a socket is still much less expensive.

Ok, let's do that.

>
> >>
> >>>
> >>>>
> >>>> We could also implement 'transient' frame watch sets by using a genl
> >>>> socket dedicated to each set.  At least until the kernel people fix
> >>>> their subsystem.
> >>>
> >>> This sounds like it's much more costly in terms of syscalls and kernel
> >>> work (and code) than occasionally getting the EAGAIN for a register
> >>> command.
> >>
> >> If you assume that frame watches are purged on iftype change, then most
> >> of the EAGAINs are only caused by netdev ifup/ifdown.  So those we can
> >> take care of easily.
> >>
> >> Unnecessary wakeups should be avoided completely.  So if you have p2p
> >> frame watches and you can group them into a set to enable / disable,
> >> then they should be registered for on a separate socket.
> >
> > The kernel api under our framewatch API may change again (and
> > hopefully will) so I'm thinking it would be good to not clutter our
>
> I doubt it at this point, but if we can make our API be able to take
> advantage of future unregister functionality (if available), then that
> would be nice.  I wouldn't focus on that at this point though.
>
> > API very visibly with those details.  Maybe a simple group_id integer
> > parameter when registering a new frame watch would be enough to do the
> > grouping.  The users of the API can treat it as informational, or a
> > "suggestion" on how to group those frame watches (if needed at all).
> > Underneath the API would open one socket for each group and would
> > automatically close the socket only if all of the watches from that
> > group have been removed, so that even if the grouping is wrong or
> > unnecessary, the user sees exactly the same results.
>
> Sounds reasonable.

So I take it you're fine with the whole group/set concept being
limited to the group_id (or set_id) parameter, in the user's view,
instead of the user having to issue a separate call to create or
destroy a "set".  So I wouldn't add calls like frame_watch_set_new().

Best regards
--===============3583814758628992312==--

