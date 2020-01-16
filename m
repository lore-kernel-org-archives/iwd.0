Content-Type: multipart/mixed; boundary="===============8991937399986977429=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] wsc: Split out enrollee state machine to own object
Date: Wed, 15 Jan 2020 19:54:16 -0600
Message-ID: <78e91025-815f-8bbc-bcb4-89a15e6b6efd@gmail.com>
In-Reply-To: <CAOq732KZY9zWPJQ0NY5Q+2aZ32Tr2zaHejz362ra0e8zriqH6A@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8991937399986977429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/15/20 5:45 PM, Andrew Zaborowski wrote:
> On Thu, 16 Jan 2020 at 00:09, Denis Kenzior <denkenz@gmail.com> wrote:
>>>> Are you sure? netdev_connect_free doesn't invoke callbacks.  It is
>>>> netdev_connect_failed and netdev_connect_ok that do.
>>>
>>> True, I misread something.
>>>
>>
>> Also note that by extension, netdev_disconnect only calls the connect_cb
>> with ABORTED.  It doesn't do anything if the connection is 'operational'.
> =

> It calls netdev_connect_free, and that wipes the callback so it does
> exactly what we need.
> =


Yes, exactly.  But it doesn't call the event filter.  So the only reason =

for station to call netdev is to have netdev perform cleanup.

To state it another way, netdev is relying on one of its clients to be =

well-behaved and remember to clean up after itself.  I think this is the =

wrong approach.  netdev already knows what it needs to do, let it clean =

up itself.

The above makes sense even from a re-use point of view, i.e. centralize =

this cleanup instead of having each module depending on netdev doing it =

(or more likely forgetting to do it) manually.

>>> station and wsc_enrollee shouldn't assume whether the netdev is going
>>> away or not, based on whether station and/or wsc_enrollee are going
>>
>> They should not.  But in effect they're being told that they're being
>> removed and to clean up after themselves immediately.  No async cleanup
>> is possible.
> =

> So here you're agreeing that station_free should not be assuming that
> the netdev is going away --> station_free *should* call some sort of
> netdev cleanup function (netdev_disconnect or a new function that
> doesn't send a CMD_DISCONNECT, but does call netdev_connect_free)...

No.  See above.  station shouldn't care what netdev is doing.  All it =

cares about is it was just informed that netdev is down and no longer in =

a state where it can accept any commands.  It should clean up after =

itself immediately and cease to exist.

> =

>>
>>> away.  So rather than assume the connect callback is not getting
>>> happening anymore, they also should call a cleanup-right-away function
>>> for netdev.  Or ideally they'd just call a 'cleanup' function and it
>>> would be netdev figuring out which cleanup it needs, but if you want
>>> two separate methods I can add this.
>>
>> They should not.  netdev already knows everything it needs to clean up
>> after itself.
> =

> ...But here you're saying they shouldn't call any netdev cleanup
> function?  Perhaps I'm misunderstanding you.
> =


Yes, because netdev will clean up after itself.  So we don't have to =

rely on station, ap, wsc, adhoc, etc to remember to do it for netdev.

>> netdev should cleanup whatever stale state it has when it receives 1.
>> It *knows* what just happened, it should not be depending on every
>> client it has to do the right thing instead.
> =

> That will hardcode the assumption that the netdev is disappearing in
> station.  If they have a "client" type relationship then station
> should take care of cleaning up the processes it has initiated.
> Otherwise it would need to be very well documented in the comments and
> I bet we'll still occasionally get it wrong, the relationship just
> becomes very complex.

I don't see how you came to this conclusion :)  netdev is telling its =

clients that it is either
	1. Disappearing and ceasing to exist.
	2. In the DOWN state where pretty much nothing works.

In both cases netdev should have already cleaned up whatever pending =

operations there were and there's not much for the clients to do anyway.

>> Curious.  For what purpose?
> =

> Same as the netdev_disconnect call makes netdev forget station's
> connect_cb, as far as I'm reading netdev.c there's currently no place
> where disconnect_cb is forgotten when station gets freed so we likely
> have the same crash there.
> =


I see.  Makes sense.  But I'd rather have the disconnect state cleaned =

up by netdev itself.

Regards,
-Denis
--===============8991937399986977429==--

