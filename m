Content-Type: multipart/mixed; boundary="===============2181444233735000898=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/11] netdev: Add a wdev_id based frame watch API
Date: Fri, 25 Oct 2019 04:59:41 +0200
Message-ID: <CAOq732+8FSzpdOnGPtG_Fzaq8KHBD3b+7m_VeLdQ21P43YNqcw@mail.gmail.com>
In-Reply-To: <22f31cba-eab2-5045-00db-972c0313b5a8@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2181444233735000898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Oct 2019 at 03:27, Denis Kenzior <denkenz@gmail.com> wrote:
> > In any case the frame registration never happens in hot paths so the
> > overhead is going to be theoretical, but I think we should internally
>
> How do you figure? You're the one arguing that frame registrations
> should only be done when connected.  So when exactly do you want to
> register the frames then?  Just prior to connection? Just after
> connection? Still seems like a hot path to me.

By hot path I mean one that may be executed many times a second, or as
a dependency for every other operation (like malloc)... if something
is done once per AP connection then I wouldn't call that a hot path
and would try to optimize for nice code rather than shaving off a
single l_queue_find.

>
> > come up with an API where the users don't need to care what the
> > implementation looks like... by doing the sets/groups thing we're
> > already pushing some of the complication that the kernel is creating
> > for us, into the users of the api.
>
> iwd is close to the metal, so I don't really consider such a goal to be
> a primary one.
>
> >>
> >> No, more like a single watch id:
> >>          uint32_t frame_watch;
> >
> > Ok, can you give a more complete code example then?  Because I had
> > understood you wanted to avoid those lookups by group id by using
> > pointers, but now we're back to ints.
> >
>
> It depends on how we want to design the frame watch set.
>
> Case 1: It is a standalone class, sort of like genl, that just opens a
> socket on frame_watch_set_new() and closes it on
> frame_watch_set_destroy().  Then any frame_watch_set_add() would just
> register for a frame watch on a given wdev.  The caller is responsible
> for lifetime management.  Since you didn't think that paying attention
> to set_interface events was worthwhile, it doesn't need to know about
> any of those details.
>
> Case 2: the set is managed by framewatch module.  In which case the
> parameters are stored in the frame_watch_set, then passed to framewatch
> module which performs the necessary registrations.  uint32 is returned
> as a handle to destroy / cancel the set when the caller determines it
> should be.  Case 2 assumes that some frame watches can be handled as
> they are today, and we can take advantage of paying attention to
> set_interface events, etc.

Ok.  Well, you can always change the uint32 into an opaque pointer to
avoid some lookups, but I understand what you mean.

What I was really suggesting was for the groups to be managed by the
framewatch module but be short lived.

>
> >>
> >> We can't have them be global since they're per wdev/netdev.  I'm
> >> probably missing something?
> >
> > Well you could do:
> >
> > group =3D frame_watch_set_new();
> >
> > frame_watch_set_add(group, ...);
> > frame_watch_set_add(group, ...);
> >
>
> So if I understand correctly your groups are semi static.  And then you
> have netdevs register to a set of groups.  Where each group instance is
> per netdev.  But again, I think this runs into combinatorial problem I
> mentioned earlier where each optional IE results in a different group
> being required.
>
> > frame_watch_register_set(netdev, group, user_data);
>
> Well this is not what you suggested earlier with an enumeration.  So now

Right! I wasn't clear... here I was only replying to the "groups can't
be global" statement but not arguing for doing it this way.  I'd
rather have them only exist per wdev/netdev.

> you're trying to optimize away the l_queue/l_hashmap lookup by making
> the group global.  I doubt you get this to work without using an actual
> global variable, but okay, I'll admit this might negate my speed argument.
>
> However, each frame_watch_register_set results in a socket being
> created.  So for 3 groups you get 3 sockets.  I doubt this is what we wan=
t.
>
> >
> > or similar, in this case only the last of those calls would be done
> > per netdev... sort of similar to how you're creating dbus interfaces
> > and only use one call per actual dbus object to activate that
> > interface.
> >
>
> I rather just have one socket / wdev and the wdev decides at connection
> time or shortly after what it really cares about watching.  So yes, we
> need to minimize kernel wakeups as much as possible, but lets not go
> overboard creating a socket for each frame type & wdev pair here.  We
> need to find a balance that makes sense.

Right, so that's a question for each module to resolve
(netdev/station, ap, adhoc, p2p).  But for framewatch, each new group
is going to result in a new genl socket, right?  And the users just
need to be careful to use few groups.

Honestly I'd rather not have the modules bother considering how
expensive are those groups.  For example if we had a
NL80211_CMD_UNREGISTER_FRAME similar to REGISTER_FRAME, we would be
less worried about those details I imagine.  And this shouldn't leak
into modules outside the framewatch module.  For example currently we
never unregister frames and our netdev_frame_watch_remove is a no-op
at the syscall level so we can use it as often as we want.  Maybe we
should be doing something similar inside the framewatch module: keep
some registrations active in the kernel but ignore the frames if no
callback is currently registered for a given prefix... but if that
same prefix is registered for again, we won't need to send any more
commands to the kernel.  At the same time if the requested prefix is
for a frame that may generate a lot of wakeups we would then use
separate sockets for it but the user wouldn't need to care.

One reason for this is that in my p2p.c I currently have a small
framework for frame exchange sequences which is invoked by a single
function and pass a list of response frames you're interested in, and
corresponing callbacks:

p2p_peer_frame_xchg(...,
        tx_frame_iov,
        final_callback,
        &frame1_data, frame1_rx_callback,
        &frame2_data, frame2_rx_callback,
        NULL);

The prefixes will be passed to the framewatch api, and each callback
may result in a new call to p2p_peer_frame_xchg so we want to forget
these frame registrations quickly but not necessarily create genl
sockets for each frame exchange.

>
> >>
> >> Anyway, my point here is that submitting full sets by setting some
> >> attribute on the set object directly is still way less expensive
> >> compared to multiple l_queue_find / l_hashmap_find calls that you're
> >> proposing.
> >
> > I will need a more complete example of the api you're proposing
> > because I can't see how in my case I'd be adding more lookups... and
> > in any case having usually only about 2-3 groups of frames, that look
> > up boils down to two integer comparisons when registering a new frame
> > prefix.
> >
> > No lookup would be necessary when the frame is received.
> >
> >>
> >> You might want to create a concrete scenario with say 3 devices and
> >> explain how many sockets we get to open.  What I'm saying is that we
> >> should be doing 1 socket / wdev/netdev with an active connection.  May=
be
> >> more in special circumstances, but they should be pretty special.
> >
> > Right, we may just need 1 or 2 sockets in station mode, the three
> > groups was just an example.  But let's assume a scenario where we only
> > listen for one specific frame type.  It seems like a lot of code
> > overhead and poor design to require three method calls to register
> > that one frame prefix (set_new, set_add and add_set, vs. just
> > register_frame)
>
> No, I think you misunderstood.  It literally would be one set that holds
> all frames for the current connection.
>
> i.e.
>
> set =3D frame_set_new(..);
>
> if (rrm_enabled)
>         frame_set_watch(set, NeighborReport);
>
> if (mfp_enabled)
>         frame_set_watch(set, SA Query Request);
>         frame_set_watch(set, SA Query Response);
>
> if (using_ft)
>         frame_set_watch(set, FT Response);

Ok, so you don't care that we get woken up to receive some frames that
we have to ignore, except for beacons and probe requests/responses.

However I wasn't really asking about this, but rather what you meant
by a set, which specific calls would you include in the frame watch
api, and where do you see the wdev_id being passed.  In this last
example you don't have an framewatch_add_set call at all, so I
understand that the frames watches go live as soon as you call
frame_set_watch...

You still would use a new socket for each frame_set_new() call, right?
 I.e. if we had three groups per netdev for whatever reason, then we
would have 3 sockets per netdev.

So my proposal was to use an enum like

enum {
       FRAME_GROUP_XXX,
       FRAME_GROUP_YYY,
       FRAME_GROUP_ZZZ,
};

(obviously you might just need one single group, or two...)

and then skip the frame_set_new(...) call.  Then you'd call
frame_watch_register(wdev_id, FRAME_GROUP_XXX, prefix, prefix_len,
callback, user_data) inside netdev_connect_common or
netdev_create_from_genl or wherever you need to, and those
registrations would immediately become live.  However you could then
either destroy the whole group by using the same (wdev_id,
FRAME_GROUP_XXX) values -- note how you don't need to bother saving
any uint32 set ID or struct frame_watch_set pointer.  Or alternatively
you could unregister a specific prefix you're no longer interested in,
which would only close that socket if it happened to be the last
active prefix in that group/set.  Yes, those calls would need to use
an l_queue_find... but what you were proposing with uint32_t frame set
IDs has exactly the same downside and assuming we are conservative
with those groups, the overhead can be smaller than some random
compiler optimizations that we have no control over.

Best regards
--===============2181444233735000898==--

