Content-Type: multipart/mixed; boundary="===============0141177608439613985=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/11] netdev: Add a wdev_id based frame watch API
Date: Wed, 23 Oct 2019 21:53:59 -0500
Message-ID: <35fddec5-0c10-fed0-8e47-10709445f783@gmail.com>
In-Reply-To: <CAOq732+um_VY=6saqOLxFeTZSyKSBUFjsiqW=YzqSLDLBGBW_A@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0141177608439613985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/23/19 7:59 PM, Andrew Zaborowski wrote:
> Hi Denis,
> =

> On Wed, 23 Oct 2019 at 03:32, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 10/22/19 8:04 PM, Andrew Zaborowski wrote:
>>> On Wed, 23 Oct 2019 at 02:23, Denis Kenzior <denkenz@gmail.com> wrote:
>>>> On 10/22/19 6:56 PM, Andrew Zaborowski wrote:
>>>>> On Tue, 22 Oct 2019 at 16:53, Denis Kenzior <denkenz@gmail.com> wro=
te:
>>>>>> This would allow
>>>>>> us to also track iftype changes and wipe out those frame watches that
>>>>>> are no longer registered with the kernel.  And also allow us not to =
try
>>>>>> and register frame watches that are already live (and bounce with an
>>>>>> -EAGAIN from the kernel).
>>>>>
>>>>> The problem is how we will know what logic is implemented in the
>>>>> running kernel version.  We also watch iftype changes inside netdev so
>>>>
>>>> Well, the particular fix from me got backported into every single LTS
>>>> kernel.  So we just assume the fix is included.  Unless you want to go
>>>> full wpa_s and use a separate socket for each frame watch.
>>>
>>> Ok, so we add a framewatch.c or similar, it'll keep a list of all
>>> registered frame types+prefixes even after our local users have
>>> unregistered from them.  It will listen for SET_INTERFACE events and
>>> drop the watches matching the wdev_id from the list.
>>>
>>
>> Yes, something like this.  One thing we might want to do is simply have
>> station, adhoc, ap, etc modules simply tell framewatch which events they
>> care about.  And framewatch will register to these whenever iftype chang=
es.
> =

> I took a look at netdev and ap.c and we don't really have frames that
> we need to be unconditionally listening to.  In ap.c we only register
> the watches when starting the AP and in netdev some of the watches
> should be registered for either when we connect, when we send a
> Neighbor Report Request or SA Query Request.  So in the end it looks
> like we'll be using the separate socket per set/group everywhere.

Perhaps you're right.  Might make sense from a consistency point of view =

anyway.  So we only implement one way and be done with it.  Do note: =

there are frames which are protected, (SA Query family for example).  So =

the kernel would simply never forward them to us if the management =

encryption key is not setup.  These do not need to be part of a socket =

set...  There may be others that fit this pattern.  So maybe we can =

cheat for at least some of these...

For AP, you know more than I.  I imagine that AP only needs a single set =

for the most part?  Can we even receive frames if AP hasn't been started =

yet?

> =

> Even if we had frames that we cared about for the whole time a
> specific iftype is active, we'd still need the netdev/adhoc/ap modules
> to update the user_data for the callbacks everytime we switch to that
> iftype so it doesn't seem useful to automatically register to any
> frames.

Depends...  It can always fire off a callback with just the wdev/ifindex =

and let the station/adhoc/ap module figure it out.  Yes we'd need to run =

a find by ifindex/wdev, but that's not really a big deal in the common case.

> So I take it you're fine with the whole group/set concept being
> limited to the group_id (or set_id) parameter, in the user's view,
> instead of the user having to issue a separate call to create or
> destroy a "set".  So I wouldn't add calls like frame_watch_set_new().
> =


What I'm a bit worried about is that I'm not sure you're really winning =

anything by trying to hide the set behind an id.  You probably end up =

having to look up the 'set' object every time based on the id, which is =

sort of wasteful.

Also, how would one pick IDs anyway?  You can't or shouldn't share the =

id between different wdevs/netdevs anyway since their lifetimes are =

distinct.   So you end up trying to have these unique gids which might =

as well be proper objects.  Also, the set is likely to be setup once and =

destroyed when the interface is cleaned up (e.g. on iftype change or =

ifdown).

So it wouldn't be the direction I'd go, but if you think it can work I'm =

okay with giving that a try.

Regards,
-Denis
--===============0141177608439613985==--

