Content-Type: multipart/mixed; boundary="===============2860099657237411033=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/11] netdev: Add a wdev_id based frame watch API
Date: Thu, 24 Oct 2019 20:27:52 -0500
Message-ID: <22f31cba-eab2-5045-00db-972c0313b5a8@gmail.com>
In-Reply-To: <CAOq732L7v5_aG8pSw-16prC6DFWiz8MUXtosO6_b7DOU540fhw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2860099657237411033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> about saving this for beacons, probe requests and probe responses since
>> there is an insane amount of these and the hardware can usually filter t=
hem.
> =

> Ok, you'd said "any one of these is one too many" so I assumed it was
> your priority to avoid any unneeded wakeups.
> =

> In any case the frame registration never happens in hot paths so the
> overhead is going to be theoretical, but I think we should internally

How do you figure? You're the one arguing that frame registrations =

should only be done when connected.  So when exactly do you want to =

register the frames then?  Just prior to connection? Just after =

connection? Still seems like a hot path to me.

> come up with an API where the users don't need to care what the
> implementation looks like... by doing the sets/groups thing we're
> already pushing some of the complication that the kernel is creating
> for us, into the users of the api.

iwd is close to the metal, so I don't really consider such a goal to be =

a primary one.

>>
>> No, more like a single watch id:
>>          uint32_t frame_watch;
> =

> Ok, can you give a more complete code example then?  Because I had
> understood you wanted to avoid those lookups by group id by using
> pointers, but now we're back to ints.
> =


It depends on how we want to design the frame watch set.

Case 1: It is a standalone class, sort of like genl, that just opens a =

socket on frame_watch_set_new() and closes it on =

frame_watch_set_destroy().  Then any frame_watch_set_add() would just =

register for a frame watch on a given wdev.  The caller is responsible =

for lifetime management.  Since you didn't think that paying attention =

to set_interface events was worthwhile, it doesn't need to know about =

any of those details.

Case 2: the set is managed by framewatch module.  In which case the =

parameters are stored in the frame_watch_set, then passed to framewatch =

module which performs the necessary registrations.  uint32 is returned =

as a handle to destroy / cancel the set when the caller determines it =

should be.  Case 2 assumes that some frame watches can be handled as =

they are today, and we can take advantage of paying attention to =

set_interface events, etc.

>>
>> We can't have them be global since they're per wdev/netdev.  I'm
>> probably missing something?
> =

> Well you could do:
> =

> group =3D frame_watch_set_new();
> =

> frame_watch_set_add(group, ...);
> frame_watch_set_add(group, ...);
> =


So if I understand correctly your groups are semi static.  And then you =

have netdevs register to a set of groups.  Where each group instance is =

per netdev.  But again, I think this runs into combinatorial problem I =

mentioned earlier where each optional IE results in a different group =

being required.

> frame_watch_register_set(netdev, group, user_data);

Well this is not what you suggested earlier with an enumeration.  So now =

you're trying to optimize away the l_queue/l_hashmap lookup by making =

the group global.  I doubt you get this to work without using an actual =

global variable, but okay, I'll admit this might negate my speed argument.

However, each frame_watch_register_set results in a socket being =

created.  So for 3 groups you get 3 sockets.  I doubt this is what we want.

> =

> or similar, in this case only the last of those calls would be done
> per netdev... sort of similar to how you're creating dbus interfaces
> and only use one call per actual dbus object to activate that
> interface.
> =


I rather just have one socket / wdev and the wdev decides at connection =

time or shortly after what it really cares about watching.  So yes, we =

need to minimize kernel wakeups as much as possible, but lets not go =

overboard creating a socket for each frame type & wdev pair here.  We =

need to find a balance that makes sense.

>>
>> Anyway, my point here is that submitting full sets by setting some
>> attribute on the set object directly is still way less expensive
>> compared to multiple l_queue_find / l_hashmap_find calls that you're
>> proposing.
> =

> I will need a more complete example of the api you're proposing
> because I can't see how in my case I'd be adding more lookups... and
> in any case having usually only about 2-3 groups of frames, that look
> up boils down to two integer comparisons when registering a new frame
> prefix.
> =

> No lookup would be necessary when the frame is received.
> =

>>
>> You might want to create a concrete scenario with say 3 devices and
>> explain how many sockets we get to open.  What I'm saying is that we
>> should be doing 1 socket / wdev/netdev with an active connection.  Maybe
>> more in special circumstances, but they should be pretty special.
> =

> Right, we may just need 1 or 2 sockets in station mode, the three
> groups was just an example.  But let's assume a scenario where we only
> listen for one specific frame type.  It seems like a lot of code
> overhead and poor design to require three method calls to register
> that one frame prefix (set_new, set_add and add_set, vs. just
> register_frame)

No, I think you misunderstood.  It literally would be one set that holds =

all frames for the current connection.

i.e.

set =3D frame_set_new(..);

if (rrm_enabled)
	frame_set_watch(set, NeighborReport);

if (mfp_enabled)
	frame_set_watch(set, SA Query Request);
	frame_set_watch(set, SA Query Response);

if (using_ft)
	frame_set_watch(set, FT Response);

Regards,
-Denis

> =

> Best regards
>=20

--===============2860099657237411033==--

