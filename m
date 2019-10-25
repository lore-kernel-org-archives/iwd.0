Content-Type: multipart/mixed; boundary="===============0207913940842537339=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/11] netdev: Add a wdev_id based frame watch API
Date: Thu, 24 Oct 2019 22:56:30 -0500
Message-ID: <eb4db2ce-74b8-6b42-db75-c0ca3acf1f47@gmail.com>
In-Reply-To: <CAOq732+8FSzpdOnGPtG_Fzaq8KHBD3b+7m_VeLdQ21P43YNqcw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0207913940842537339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> By hot path I mean one that may be executed many times a second, or as
> a dependency for every other operation (like malloc)... if something
> is done once per AP connection then I wouldn't call that a hot path
> and would try to optimize for nice code rather than shaving off a
> single l_queue_find.

Sure, but really you need to consider anything that affects latency of =

connections to be a hot path as well.  So while what you say is all =

true, etc, shaving off one or several instances of l_queue_find if you =

can is still a goal.  Just keep that in mind.

>>
>> I rather just have one socket / wdev and the wdev decides at connection
>> time or shortly after what it really cares about watching.  So yes, we
>> need to minimize kernel wakeups as much as possible, but lets not go
>> overboard creating a socket for each frame type & wdev pair here.  We
>> need to find a balance that makes sense.
> =

> Right, so that's a question for each module to resolve
> (netdev/station, ap, adhoc, p2p).  But for framewatch, each new group
> is going to result in a new genl socket, right?  And the users just
> need to be careful to use few groups.

Right

> =

> Honestly I'd rather not have the modules bother considering how
> expensive are those groups.  For example if we had a
> NL80211_CMD_UNREGISTER_FRAME similar to REGISTER_FRAME, we would be
> less worried about those details I imagine.  And this shouldn't leak

Well, this is the problem here.  If we had CMD_UNREGISTER_FRAME, then =

none of this design would be necessary.  We wouldn't be talking about =

sets or opening sockets or any of this.  And by extension our APIs would =

look and act completely different.  So I would argue the opposite: we =

should not be hiding these details from the user.  In fact we want these =

details to be quite visible so that the costs are properly evaluated.

And yes, I get that maybe in the future this command becomes available. =

But its too late at this point.  We go with the kernel we have, not the =

kernel we wish we would have ;)

> into modules outside the framewatch module.  For example currently we
> never unregister frames and our netdev_frame_watch_remove is a no-op
> at the syscall level so we can use it as often as we want.  Maybe we

And this created a false sense of security.  So unless you really know =

what is happening, the API makes you feel all warm and fuzzy.

> should be doing something similar inside the framewatch module: keep
> some registrations active in the kernel but ignore the frames if no
> callback is currently registered for a given prefix... but if that
> same prefix is registered for again, we won't need to send any more
> commands to the kernel.  At the same time if the requested prefix is
> for a frame that may generate a lot of wakeups we would then use
> separate sockets for it but the user wouldn't need to care.

But then you push this decision making onto framewatch which now has to =

be aware of all the details from other modules.  Not saying this can't =

be made to work, but I'm not sure that's the approach I'd start with.

> =

> One reason for this is that in my p2p.c I currently have a small
> framework for frame exchange sequences which is invoked by a single
> function and pass a list of response frames you're interested in, and
> corresponing callbacks:
> =

> p2p_peer_frame_xchg(...,
>          tx_frame_iov,
>          final_callback,
>          &frame1_data, frame1_rx_callback,
>          &frame2_data, frame2_rx_callback,
>          NULL);
> =

> The prefixes will be passed to the framewatch api, and each callback
> may result in a new call to p2p_peer_frame_xchg so we want to forget
> these frame registrations quickly but not necessarily create genl
> sockets for each frame exchange.

I'd handle this by having a set of frames you register for when P2P =

discovery is started and then your frame exchange runs as is.  Then you =

can either close this set when you go into the connect phase or keep it =

for the next discovery procedure.

>>
>> set =3D frame_set_new(..);
>>
>> if (rrm_enabled)
>>          frame_set_watch(set, NeighborReport);
>>
>> if (mfp_enabled)
>>          frame_set_watch(set, SA Query Request);
>>          frame_set_watch(set, SA Query Response);
>>
>> if (using_ft)
>>          frame_set_watch(set, FT Response);
> =

> Ok, so you don't care that we get woken up to receive some frames that
> we have to ignore, except for beacons and probe requests/responses.
> =


With the exception of Neighbor Reports all these are encrypted.  So in =

the "AP is not going Rogue" case, none of these would result in =

unnecessary wakeups.  (Reminds me, should we be doing FT-over-DS only if =

MFP is enabled?)  Things get a little nasty once we get into ANQP and =

other Public Action frames, but there's little we can do about that. =

Creating a socket every time we send an ANQP request is just overkill =

for example.

> However I wasn't really asking about this, but rather what you meant
> by a set, which specific calls would you include in the frame watch
> api, and where do you see the wdev_id being passed.  In this last

the wdev would just go into the _new call.  And each frame_set_watch =

would have the prefix, callback, userdata, destroy, etc.  Or perhaps =

userdata and destroy can go into the _new call as well.  Implementation =

details.

> example you don't have an framewatch_add_set call at all, so I
> understand that the frames watches go live as soon as you call
> frame_set_watch...

Those are really implementation details.  If we use Case 1 from =

upthread, then what you say above is true.  If we use Case 2, then =

framewatch might get to massage the data first.

> =

> You still would use a new socket for each frame_set_new() call, right?

Right

>   I.e. if we had three groups per netdev for whatever reason, then we
> would have 3 sockets per netdev.
> =

> So my proposal was to use an enum like
> =

> enum {
>         FRAME_GROUP_XXX,
>         FRAME_GROUP_YYY,
>         FRAME_GROUP_ZZZ,
> };
> =

> (obviously you might just need one single group, or two...)
> =

> and then skip the frame_set_new(...) call.  Then you'd call
> frame_watch_register(wdev_id, FRAME_GROUP_XXX, prefix, prefix_len,
> callback, user_data) inside netdev_connect_common or
> netdev_create_from_genl or wherever you need to, and those
> registrations would immediately become live.  However you could then

Okay, this is what I understood.

> either destroy the whole group by using the same (wdev_id,
> FRAME_GROUP_XXX) values -- note how you don't need to bother saving
> any uint32 set ID or struct frame_watch_set pointer.  Or alternatively

Right, but need to duplicate the logic used to register to the groups =

(e.g. if (using_ft) unregister FT).  Or always unregister from groups =

you might not be even registered to.

> you could unregister a specific prefix you're no longer interested in,
> which would only close that socket if it happened to be the last
> active prefix in that group/set.  Yes, those calls would need to use
> an l_queue_find... but what you were proposing with uint32_t frame set
> IDs has exactly the same downside and assuming we are conservative
> with those groups, the overhead can be smaller than some random
> compiler optimizations that we have no control over.
> =


Sure, and I'm less worried about the tear-down than I'm about the setup =

at connection time.

Regards,
-Denis
--===============0207913940842537339==--

