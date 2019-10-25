Content-Type: multipart/mixed; boundary="===============1028208410925620506=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/11] netdev: Add a wdev_id based frame watch API
Date: Fri, 25 Oct 2019 06:42:48 +0200
Message-ID: <CAOq732+B08G1KX7CS_5GWthj45wv8vMWitjL8dNmOz4Of2Q45w@mail.gmail.com>
In-Reply-To: <eb4db2ce-74b8-6b42-db75-c0ca3acf1f47@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1028208410925620506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Oct 2019 at 05:56, Denis Kenzior <denkenz@gmail.com> wrote:
> > By hot path I mean one that may be executed many times a second, or as
> > a dependency for every other operation (like malloc)... if something
> > is done once per AP connection then I wouldn't call that a hot path
> > and would try to optimize for nice code rather than shaving off a
> > single l_queue_find.
>
> Sure, but really you need to consider anything that affects latency of
> connections to be a hot path as well.  So while what you say is all
> true, etc, shaving off one or several instances of l_queue_find if you
> can is still a goal.  Just keep that in mind.

Makes sense.  We can probably think about moving some things to after
signalling the connection is operative (I think we set up the GTK this
way in some scenarios)

Or instead of registering to some of those frames in station mode at
connection time like I was mentioning before we can keep them
registered the whole time like we're going now.  Since we're not on
any channel until we call CMD_CONNECT we wouldn't receiving frames
(not sure about during scanning...)

> >
> > Honestly I'd rather not have the modules bother considering how
> > expensive are those groups.  For example if we had a
> > NL80211_CMD_UNREGISTER_FRAME similar to REGISTER_FRAME, we would be
> > less worried about those details I imagine.  And this shouldn't leak
>
> Well, this is the problem here.  If we had CMD_UNREGISTER_FRAME, then
> none of this design would be necessary.  We wouldn't be talking about
> sets or opening sockets or any of this.  And by extension our APIs would
> look and act completely different.  So I would argue the opposite: we
> should not be hiding these details from the user.  In fact we want these
> details to be quite visible so that the costs are properly evaluated.
>
> And yes, I get that maybe in the future this command becomes available.
> But its too late at this point.  We go with the kernel we have, not the
> kernel we wish we would have ;)
>
> > into modules outside the framewatch module.  For example currently we
> > never unregister frames and our netdev_frame_watch_remove is a no-op
> > at the syscall level so we can use it as often as we want.  Maybe we
>
> And this created a false sense of security.  So unless you really know
> what is happening, the API makes you feel all warm and fuzzy.
>
> > should be doing something similar inside the framewatch module: keep
> > some registrations active in the kernel but ignore the frames if no
> > callback is currently registered for a given prefix... but if that
> > same prefix is registered for again, we won't need to send any more
> > commands to the kernel.  At the same time if the requested prefix is
> > for a frame that may generate a lot of wakeups we would then use
> > separate sockets for it but the user wouldn't need to care.
>
> But then you push this decision making onto framewatch which now has to
> be aware of all the details from other modules.  Not saying this can't
> be made to work, but I'm not sure that's the approach I'd start with.
>
> >
> > One reason for this is that in my p2p.c I currently have a small
> > framework for frame exchange sequences which is invoked by a single
> > function and pass a list of response frames you're interested in, and
> > corresponing callbacks:
> >
> > p2p_peer_frame_xchg(...,
> >          tx_frame_iov,
> >          final_callback,
> >          &frame1_data, frame1_rx_callback,
> >          &frame2_data, frame2_rx_callback,
> >          NULL);
> >
> > The prefixes will be passed to the framewatch api, and each callback
> > may result in a new call to p2p_peer_frame_xchg so we want to forget
> > these frame registrations quickly but not necessarily create genl
> > sockets for each frame exchange.
>
> I'd handle this by having a set of frames you register for when P2P
> discovery is started and then your frame exchange runs as is.  Then you
> can either close this set when you go into the connect phase or keep it
> for the next discovery procedure.

So that's kind of what I'd like to avoid because this makes for
readable code where in each step of a sequence (and there are a few
different sequences) you say what frames you watch for next.  So I
think p2p_peer_frame_xchg can register to those frames only when
called and unregister from them when one is actually received but
without tearing down that group and causing the netlink socket to be
closed.

>
> >>
> >> set =3D frame_set_new(..);
> >>
> >> if (rrm_enabled)
> >>          frame_set_watch(set, NeighborReport);
> >>
> >> if (mfp_enabled)
> >>          frame_set_watch(set, SA Query Request);
> >>          frame_set_watch(set, SA Query Response);
> >>
> >> if (using_ft)
> >>          frame_set_watch(set, FT Response);
> >
> > Ok, so you don't care that we get woken up to receive some frames that
> > we have to ignore, except for beacons and probe requests/responses.
> >
>
> With the exception of Neighbor Reports all these are encrypted.  So in
> the "AP is not going Rogue" case, none of these would result in
> unnecessary wakeups.  (Reminds me, should we be doing FT-over-DS only if
> MFP is enabled?)  Things get a little nasty once we get into ANQP and
> other Public Action frames, but there's little we can do about that.
> Creating a socket every time we send an ANQP request is just overkill
> for example.
>
> > However I wasn't really asking about this, but rather what you meant
> > by a set, which specific calls would you include in the frame watch
> > api, and where do you see the wdev_id being passed.  In this last
>
> the wdev would just go into the _new call.  And each frame_set_watch
> would have the prefix, callback, userdata, destroy, etc.  Or perhaps
> userdata and destroy can go into the _new call as well.  Implementation
> details.
>
> > example you don't have an framewatch_add_set call at all, so I
> > understand that the frames watches go live as soon as you call
> > frame_set_watch...
>
> Those are really implementation details.  If we use Case 1 from
> upthread, then what you say above is true.  If we use Case 2, then
> framewatch might get to massage the data first.
>
> >
> > You still would use a new socket for each frame_set_new() call, right?
>
> Right
>
> >   I.e. if we had three groups per netdev for whatever reason, then we
> > would have 3 sockets per netdev.
> >
> > So my proposal was to use an enum like
> >
> > enum {
> >         FRAME_GROUP_XXX,
> >         FRAME_GROUP_YYY,
> >         FRAME_GROUP_ZZZ,
> > };
> >
> > (obviously you might just need one single group, or two...)
> >
> > and then skip the frame_set_new(...) call.  Then you'd call
> > frame_watch_register(wdev_id, FRAME_GROUP_XXX, prefix, prefix_len,
> > callback, user_data) inside netdev_connect_common or
> > netdev_create_from_genl or wherever you need to, and those
> > registrations would immediately become live.  However you could then
>
> Okay, this is what I understood.
>
> > either destroy the whole group by using the same (wdev_id,
> > FRAME_GROUP_XXX) values -- note how you don't need to bother saving
> > any uint32 set ID or struct frame_watch_set pointer.  Or alternatively
>
> Right, but need to duplicate the logic used to register to the groups
> (e.g. if (using_ft) unregister FT).  Or always unregister from groups
> you might not be even registered to.

Right, I'd do that.  If we have a group id called
FRAME_GROUP_CONNECTION for all the watches we want during a connection
it's safe to unregister it on disconnect without checking if there
were any actual active watches in that group.

Do you still think it's better to have an explicit call to create the
group and receive a dynamic id or pointer that has to be saved?

Thinking about this, since those groups may end up having no frame
watches it will still be better to defer actually opening the socket
until the first frame prefix is registered by the user.

Best regards
--===============1028208410925620506==--

