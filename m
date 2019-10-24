Content-Type: multipart/mixed; boundary="===============3985917621098499067=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/11] netdev: Add a wdev_id based frame watch API
Date: Thu, 24 Oct 2019 23:47:42 +0200
Message-ID: <CAOq732+rpGwc7Mmke4dZd2COhSPfM6Ey1P5nn7KU=Yhv72WNhw@mail.gmail.com>
In-Reply-To: <01809e6d-cd6a-1b70-a4d0-5c60b71490d5@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3985917621098499067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, 24 Oct 2019 at 17:29, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Andrew,
>
> On 10/23/19 10:22 PM, Andrew Zaborowski wrote:
> > On Thu, 24 Oct 2019 at 04:54, Denis Kenzior <denkenz@gmail.com> wrote:
> >> Perhaps you're right.  Might make sense from a consistency point of vi=
ew
> >> anyway.  So we only implement one way and be done with it.  Do note:
> >> there are frames which are protected, (SA Query family for example).  =
So
> >> the kernel would simply never forward them to us if the management
> >> encryption key is not setup.  These do not need to be part of a socket
> >> set...  There may be others that fit this pattern.  So maybe we can
> >> cheat for at least some of these...
> >
> > Good point for the SA Query Request but for SA Query Responses we can
> > still use a separate group because we only want to be woken up if
> > we've sent the Request before.
>
> But do you want to pay the cost?  Since we established an encryption key
> to the AP, and a well behaved AP will send these to us only as a
> response, I don't see the point.

Ok, maybe we can save that one group then, but depending on how the
tasks are divided between the firmware and the driver, the kernel may
still be getting woken up on spoofed frames if someone registered for
them.

>
> The kernel API is not ideal.  Lets make it work, but don't go crazy ;)
>
> >>
> >> What I'm a bit worried about is that I'm not sure you're really winning
> >> anything by trying to hide the set behind an id.  You probably end up
> >> having to look up the 'set' object every time based on the id, which is
> >> sort of wasteful.
> >
> > Hmmm, I think we would only need a single look up when adding a new
> > frame registration.  We would have the groups in an l_queue for each
> > wdev (if we expect there to be few groups, or a hashmap if we expect
> > many)
>
> Exactly.  So you do something like:
>
> frame_watch_add(..);
> frame_watch_add(..);
>
> if (ap_has_ie())
>         frame_watch_add(..);
>
> if (ap_has_another_ie())
>         frame_watch_add(..);
>
> For each call you're looking up the group.  Instead of:
>
> frame_watch_set_new();
> frame_watch_set_add(..);
> frame_watch_set_add(..);
>
> if (ap_has_ie())
>         frame_watch_set_add();
>
> frame_watch_add_set();
>
> Something like this anyway...
>
> >
> >>
> >> Also, how would one pick IDs anyway?  You can't or shouldn't share the
> >> id between different wdevs/netdevs anyway since their lifetimes are
> >> distinct.   So you end up trying to have these unique gids which might
> >> as well be proper objects.
> >
> > I was thinking of the group_id being an additional argument and shared
> > between wdevs/netdevs because the wdev would still be passed in the
> > arguments.
> >
> > So netdev.c would have one group per watch lifetime:
> >
> > enum {
> >        FRAME_GROUP_CONNECTION,
> >        FRAME_GROUP_NR,
> >        FRAME_GROUP_SA_QUERY,
> > };
> >
>
> I think this will break down once we start supporting more action
> frames.  These will depend on the presence of IEs in the AP, and I would
> expect the number of combinations will quickly overwhelm such an approach.

We don't need separate groups for frames that we are interested in for
the entire time we're connected, just because they depend on some IE
so I don't see why this would be a problem.

>
> >> Also, the set is likely to be setup once and
> >> destroyed when the interface is cleaned up (e.g. on iftype change or
> >> ifdown).
> >
> > Yes but those are three additional pointers to store, for the three
> > groups in netdev, also three additional create calls.
> >
>
> Not sure I understand this last point?

So in the integer group id approach we have this in netdev:

enum {
       FRAME_GROUP_XXX,
       FRAME_GROUP_YYY,
       FRAME_GROUP_ZZZ,
};

frame_watch_add(netdev, FRAME_GROUP_XXX, ...);
frame_watch_add(netdev, FRAME_GROUP_XXX, ...);

if (ap_has_ie())
       frame_watch_add(netdev, FRAME_GROUP_XXX, ...);

frame_watch_add(netdev, FRAME_GROUP_YYY, ...);

In your approach we will have

struct netdev {
       ...
       struct frame_watch_group *group_xxx;
       struct frame_watch_group *group_yyy;
       struct frame_watch_group *group_zzz;
       ...
};

netdev->group_xxx =3D frame_watch_set_new(netdev, ...);
netdev->group_yyy =3D frame_watch_set_new(netdev, ...);
netdev->group_zzz =3D frame_watch_set_new(netdev, ...);

frame_watch_set_add(netdev->group_xxx, ...);
frame_watch_set_add(netdev->group_xxx, ...);

if (ap_has_ie())
       frame_watch_set_add(netdev->group_xxx, ...);

frame_watch_set_add(netdev->group_yyy, ...);

frame_watch_add_set(netdev->group_xxx);
frame_watch_add_set(netdev->group_yyy);
frame_watch_add_set(netdev->group_zzz);

Or similar... you can have those groups be global but in any case
that's gonna be 6 extra calls for nothing, assuming 3 groups/sets in
netdev.  With possible error checking it adds up to a lot of burden.

Best regards
--===============3985917621098499067==--

