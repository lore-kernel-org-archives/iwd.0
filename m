Content-Type: multipart/mixed; boundary="===============8377937933218042054=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/11] netdev: Add a wdev_id based frame watch API
Date: Fri, 25 Oct 2019 00:45:42 +0200
Message-ID: <CAOq732L7v5_aG8pSw-16prC6DFWiz8MUXtosO6_b7DOU540fhw@mail.gmail.com>
In-Reply-To: <ab6e5c5c-ba29-8112-1dcd-2377ed2a499a@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8377937933218042054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

frame_watch_set_add(group, ...);
On Fri, 25 Oct 2019 at 00:16, Denis Kenzior <denkenz@gmail.com> wrote:
> On 10/24/19 4:47 PM, Andrew Zaborowski wrote:
> > On Thu, 24 Oct 2019 at 17:29, Denis Kenzior <denkenz@gmail.com> wrote:
> >>
> >> Hi Andrew,
> >>
> >> On 10/23/19 10:22 PM, Andrew Zaborowski wrote:
> >>> On Thu, 24 Oct 2019 at 04:54, Denis Kenzior <denkenz@gmail.com> wro=
te:
> >>>> Perhaps you're right.  Might make sense from a consistency point of =
view
> >>>> anyway.  So we only implement one way and be done with it.  Do note:
> >>>> there are frames which are protected, (SA Query family for example).=
  So
> >>>> the kernel would simply never forward them to us if the management
> >>>> encryption key is not setup.  These do not need to be part of a sock=
et
> >>>> set...  There may be others that fit this pattern.  So maybe we can
> >>>> cheat for at least some of these...
> >>>
> >>> Good point for the SA Query Request but for SA Query Responses we can
> >>> still use a separate group because we only want to be woken up if
> >>> we've sent the Request before.
> >>
> >> But do you want to pay the cost?  Since we established an encryption k=
ey
> >> to the AP, and a well behaved AP will send these to us only as a
> >> response, I don't see the point.
> >
> > Ok, maybe we can save that one group then, but depending on how the
> > tasks are divided between the firmware and the driver, the kernel may
> > still be getting woken up on spoofed frames if someone registered for
> > them.
> >
>
> This happens already.  Look at the mac80211 rx path.  I only really care

Right but for some drivers this will happen in the firmware and the
kernel won't be bothered if we haven't registered to those frame
prefixes.

> about saving this for beacons, probe requests and probe responses since
> there is an insane amount of these and the hardware can usually filter th=
em.

Ok, you'd said "any one of these is one too many" so I assumed it was
your priority to avoid any unneeded wakeups.

In any case the frame registration never happens in hot paths so the
overhead is going to be theoretical, but I think we should internally
come up with an API where the users don't need to care what the
implementation looks like... by doing the sets/groups thing we're
already pushing some of the complication that the kernel is creating
for us, into the users of the api.

>
> >>
> >> The kernel API is not ideal.  Lets make it work, but don't go crazy ;)
> >>
> >>>>
> >>>> What I'm a bit worried about is that I'm not sure you're really winn=
ing
> >>>> anything by trying to hide the set behind an id.  You probably end up
> >>>> having to look up the 'set' object every time based on the id, which=
 is
> >>>> sort of wasteful.
> >>>
> >>> Hmmm, I think we would only need a single look up when adding a new
> >>> frame registration.  We would have the groups in an l_queue for each
> >>> wdev (if we expect there to be few groups, or a hashmap if we expect
> >>> many)
> >>
> >> Exactly.  So you do something like:
> >>
> >> frame_watch_add(..);
> >> frame_watch_add(..);
> >>
> >> if (ap_has_ie())
> >>          frame_watch_add(..);
> >>
> >> if (ap_has_another_ie())
> >>          frame_watch_add(..);
> >>
> >> For each call you're looking up the group.  Instead of:
> >>
> >> frame_watch_set_new();
> >> frame_watch_set_add(..);
> >> frame_watch_set_add(..);
> >>
> >> if (ap_has_ie())
> >>          frame_watch_set_add();
> >>
> >> frame_watch_add_set();
> >>
> >> Something like this anyway...
> >>
> >>>
> >>>>
> >>>> Also, how would one pick IDs anyway?  You can't or shouldn't share t=
he
> >>>> id between different wdevs/netdevs anyway since their lifetimes are
> >>>> distinct.   So you end up trying to have these unique gids which mig=
ht
> >>>> as well be proper objects.
> >>>
> >>> I was thinking of the group_id being an additional argument and shared
> >>> between wdevs/netdevs because the wdev would still be passed in the
> >>> arguments.
> >>>
> >>> So netdev.c would have one group per watch lifetime:
> >>>
> >>> enum {
> >>>         FRAME_GROUP_CONNECTION,
> >>>         FRAME_GROUP_NR,
> >>>         FRAME_GROUP_SA_QUERY,
> >>> };
> >>>
> >>
> >> I think this will break down once we start supporting more action
> >> frames.  These will depend on the presence of IEs in the AP, and I wou=
ld
> >> expect the number of combinations will quickly overwhelm such an appro=
ach.
> >
> > We don't need separate groups for frames that we are interested in for
> > the entire time we're connected, just because they depend on some IE
> > so I don't see why this would be a problem.
> >
>
> You already have 3 groups / netdev above where I'd just have one / netdev.

You'll probably going to want one for the neighbor report responses,
but in any case we'll have more at some point.

>
> >>
> >>>> Also, the set is likely to be setup once and
> >>>> destroyed when the interface is cleaned up (e.g. on iftype change or
> >>>> ifdown).
> >>>
> >>> Yes but those are three additional pointers to store, for the three
> >>> groups in netdev, also three additional create calls.
> >>>
> >>
> >> Not sure I understand this last point?
> >
> > So in the integer group id approach we have this in netdev:
> >
> > enum {
> >         FRAME_GROUP_XXX,
> >         FRAME_GROUP_YYY,
> >         FRAME_GROUP_ZZZ,
> > };
> >
> > frame_watch_add(netdev, FRAME_GROUP_XXX, ...);
> > frame_watch_add(netdev, FRAME_GROUP_XXX, ...);
> >
> > if (ap_has_ie())
> >         frame_watch_add(netdev, FRAME_GROUP_XXX, ...);
> >
> > frame_watch_add(netdev, FRAME_GROUP_YYY, ...);
> >
> > In your approach we will have
> >
> > struct netdev {
> >         ...
> >         struct frame_watch_group *group_xxx;
> >         struct frame_watch_group *group_yyy;
> >         struct frame_watch_group *group_zzz;
>
> No, more like a single watch id:
>         uint32_t frame_watch;

Ok, can you give a more complete code example then?  Because I had
understood you wanted to avoid those lookups by group id by using
pointers, but now we're back to ints.

>
> Which is a result of us adding the entire set to framewatch.c,
> associated with the set of groups this netdev connection needs to handle.
>
> And maybe in the weird p2p cases you'd have two frame watches or somethin=
g.
>
> >         ...
> > };
> >
> > netdev->group_xxx =3D frame_watch_set_new(netdev, ...);
> > netdev->group_yyy =3D frame_watch_set_new(netdev, ...);
> > netdev->group_zzz =3D frame_watch_set_new(netdev, ...);
> >
> > frame_watch_set_add(netdev->group_xxx, ...);
> > frame_watch_set_add(netdev->group_xxx, ...);
> >
> > if (ap_has_ie())
> >         frame_watch_set_add(netdev->group_xxx, ...);
> >
> > frame_watch_set_add(netdev->group_yyy, ...);
> >
> > frame_watch_add_set(netdev->group_xxx);
> > frame_watch_add_set(netdev->group_yyy);
> > frame_watch_add_set(netdev->group_zzz);
> >
> > Or similar... you can have those groups be global but in any case
> > that's gonna be 6 extra calls for nothing, assuming 3 groups/sets in
> > netdev.  With possible error checking it adds up to a lot of burden.
>
> We can't have them be global since they're per wdev/netdev.  I'm
> probably missing something?

Well you could do:

group =3D frame_watch_set_new();

frame_watch_set_add(group, ...);
frame_watch_set_add(group, ...);

frame_watch_register_set(netdev, group, user_data);

or similar, in this case only the last of those calls would be done
per netdev... sort of similar to how you're creating dbus interfaces
and only use one call per actual dbus object to activate that
interface.

>
> Anyway, my point here is that submitting full sets by setting some
> attribute on the set object directly is still way less expensive
> compared to multiple l_queue_find / l_hashmap_find calls that you're
> proposing.

I will need a more complete example of the api you're proposing
because I can't see how in my case I'd be adding more lookups... and
in any case having usually only about 2-3 groups of frames, that look
up boils down to two integer comparisons when registering a new frame
prefix.

No lookup would be necessary when the frame is received.

>
> You might want to create a concrete scenario with say 3 devices and
> explain how many sockets we get to open.  What I'm saying is that we
> should be doing 1 socket / wdev/netdev with an active connection.  Maybe
> more in special circumstances, but they should be pretty special.

Right, we may just need 1 or 2 sockets in station mode, the three
groups was just an example.  But let's assume a scenario where we only
listen for one specific frame type.  It seems like a lot of code
overhead and poor design to require three method calls to register
that one frame prefix (set_new, set_add and add_set, vs. just
register_frame)

Best regards
--===============8377937933218042054==--

