Content-Type: multipart/mixed; boundary="===============0918583750362389588=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/11] netdev: Add a wdev_id based frame watch API
Date: Thu, 24 Oct 2019 05:22:59 +0200
Message-ID: <CAOq732+uiCx1VGzvs+w7PR8sgzTLkYzV-waJ-DXYFZgdxxtUqg@mail.gmail.com>
In-Reply-To: <35fddec5-0c10-fed0-8e47-10709445f783@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0918583750362389588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2019 at 04:54, Denis Kenzior <denkenz@gmail.com> wrote:
> On 10/23/19 7:59 PM, Andrew Zaborowski wrote:
> > I took a look at netdev and ap.c and we don't really have frames that
> > we need to be unconditionally listening to.  In ap.c we only register
> > the watches when starting the AP and in netdev some of the watches
> > should be registered for either when we connect, when we send a
> > Neighbor Report Request or SA Query Request.  So in the end it looks
> > like we'll be using the separate socket per set/group everywhere.
>
> Perhaps you're right.  Might make sense from a consistency point of view
> anyway.  So we only implement one way and be done with it.  Do note:
> there are frames which are protected, (SA Query family for example).  So
> the kernel would simply never forward them to us if the management
> encryption key is not setup.  These do not need to be part of a socket
> set...  There may be others that fit this pattern.  So maybe we can
> cheat for at least some of these...

Good point for the SA Query Request but for SA Query Responses we can
still use a separate group because we only want to be woken up if
we've sent the Request before.

>
> For AP, you know more than I.  I imagine that AP only needs a single set
> for the most part?  Can we even receive frames if AP hasn't been started
> yet?

True, we can't because we haven't even set a channel...

>
> >
> > Even if we had frames that we cared about for the whole time a
> > specific iftype is active, we'd still need the netdev/adhoc/ap modules
> > to update the user_data for the callbacks everytime we switch to that
> > iftype so it doesn't seem useful to automatically register to any
> > frames.
>
> Depends...  It can always fire off a callback with just the wdev/ifindex
> and let the station/adhoc/ap module figure it out.  Yes we'd need to run
> a find by ifindex/wdev, but that's not really a big deal in the common ca=
se.
>
> > So I take it you're fine with the whole group/set concept being
> > limited to the group_id (or set_id) parameter, in the user's view,
> > instead of the user having to issue a separate call to create or
> > destroy a "set".  So I wouldn't add calls like frame_watch_set_new().
> >
>
> What I'm a bit worried about is that I'm not sure you're really winning
> anything by trying to hide the set behind an id.  You probably end up
> having to look up the 'set' object every time based on the id, which is
> sort of wasteful.

Hmmm, I think we would only need a single look up when adding a new
frame registration.  We would have the groups in an l_queue for each
wdev (if we expect there to be few groups, or a hashmap if we expect
many)

>
> Also, how would one pick IDs anyway?  You can't or shouldn't share the
> id between different wdevs/netdevs anyway since their lifetimes are
> distinct.   So you end up trying to have these unique gids which might
> as well be proper objects.

I was thinking of the group_id being an additional argument and shared
between wdevs/netdevs because the wdev would still be passed in the
arguments.

So netdev.c would have one group per watch lifetime:

enum {
      FRAME_GROUP_CONNECTION,
      FRAME_GROUP_NR,
      FRAME_GROUP_SA_QUERY,
};

> Also, the set is likely to be setup once and
> destroyed when the interface is cleaned up (e.g. on iftype change or
> ifdown).

Yes but those are three additional pointers to store, for the three
groups in netdev, also three additional create calls.

Best regards
--===============0918583750362389588==--

