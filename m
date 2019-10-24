Content-Type: multipart/mixed; boundary="===============0071395916104591834=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/11] netdev: Add a wdev_id based frame watch API
Date: Thu, 24 Oct 2019 10:29:49 -0500
Message-ID: <01809e6d-cd6a-1b70-a4d0-5c60b71490d5@gmail.com>
In-Reply-To: <CAOq732+uiCx1VGzvs+w7PR8sgzTLkYzV-waJ-DXYFZgdxxtUqg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0071395916104591834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/23/19 10:22 PM, Andrew Zaborowski wrote:
> On Thu, 24 Oct 2019 at 04:54, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 10/23/19 7:59 PM, Andrew Zaborowski wrote:
>>> I took a look at netdev and ap.c and we don't really have frames that
>>> we need to be unconditionally listening to.  In ap.c we only register
>>> the watches when starting the AP and in netdev some of the watches
>>> should be registered for either when we connect, when we send a
>>> Neighbor Report Request or SA Query Request.  So in the end it looks
>>> like we'll be using the separate socket per set/group everywhere.
>>
>> Perhaps you're right.  Might make sense from a consistency point of view
>> anyway.  So we only implement one way and be done with it.  Do note:
>> there are frames which are protected, (SA Query family for example).  So
>> the kernel would simply never forward them to us if the management
>> encryption key is not setup.  These do not need to be part of a socket
>> set...  There may be others that fit this pattern.  So maybe we can
>> cheat for at least some of these...
> =

> Good point for the SA Query Request but for SA Query Responses we can
> still use a separate group because we only want to be woken up if
> we've sent the Request before.

But do you want to pay the cost?  Since we established an encryption key =

to the AP, and a well behaved AP will send these to us only as a =

response, I don't see the point.

The kernel API is not ideal.  Lets make it work, but don't go crazy ;)

>>
>> What I'm a bit worried about is that I'm not sure you're really winning
>> anything by trying to hide the set behind an id.  You probably end up
>> having to look up the 'set' object every time based on the id, which is
>> sort of wasteful.
> =

> Hmmm, I think we would only need a single look up when adding a new
> frame registration.  We would have the groups in an l_queue for each
> wdev (if we expect there to be few groups, or a hashmap if we expect
> many)

Exactly.  So you do something like:

frame_watch_add(..);
frame_watch_add(..);

if (ap_has_ie())
	frame_watch_add(..);

if (ap_has_another_ie())
	frame_watch_add(..);

For each call you're looking up the group.  Instead of:

frame_watch_set_new();
frame_watch_set_add(..);
frame_watch_set_add(..);

if (ap_has_ie())
	frame_watch_set_add();

frame_watch_add_set();

Something like this anyway...

> =

>>
>> Also, how would one pick IDs anyway?  You can't or shouldn't share the
>> id between different wdevs/netdevs anyway since their lifetimes are
>> distinct.   So you end up trying to have these unique gids which might
>> as well be proper objects.
> =

> I was thinking of the group_id being an additional argument and shared
> between wdevs/netdevs because the wdev would still be passed in the
> arguments.
> =

> So netdev.c would have one group per watch lifetime:
> =

> enum {
>        FRAME_GROUP_CONNECTION,
>        FRAME_GROUP_NR,
>        FRAME_GROUP_SA_QUERY,
> };
> =


I think this will break down once we start supporting more action =

frames.  These will depend on the presence of IEs in the AP, and I would =

expect the number of combinations will quickly overwhelm such an approach.

>> Also, the set is likely to be setup once and
>> destroyed when the interface is cleaned up (e.g. on iftype change or
>> ifdown).
> =

> Yes but those are three additional pointers to store, for the three
> groups in netdev, also three additional create calls.
> =


Not sure I understand this last point?

Regards,
-Denis

--===============0071395916104591834==--

