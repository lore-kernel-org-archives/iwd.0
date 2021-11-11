Content-Type: multipart/mixed; boundary="===============6484757398416752249=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/9] netconfig: Refactor setting new values to system
Date: Thu, 11 Nov 2021 14:07:29 -0600
Message-ID: <0880f7a8-c889-ef01-8342-e704d8d9257e@gmail.com>
In-Reply-To: CAOq732JEb7_1v-g9gV6Kj5zRfqrJAPbjFQrkJCqEPXQto_zkmQ@mail.gmail.com

--===============6484757398416752249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/11/21 1:29 PM, Andrew Zaborowski wrote:
> On Thu, 11 Nov 2021 at 19:35, Denis Kenzior <denkenz(a)gmail.com> wrote:
>>>> I really don't think these belong here.  If we're going in the directi=
on of
>>>> netconfig delegating the management of applying IP configuration setti=
ngs, then
>>>> this is up to the applying entity to store this information.  netconfi=
g would
>>>> only be responsible for obtaining the settings and notifying the new m=
anagement
>>>> entity.
>>>>
>>>> The new management entity would either:
>>>> A) invoke the agent, or
>>>> B) apply the settings itself.
>>>>
>>>> Preferably, A & B would use the same API and be subclasses of some gen=
eric
>>>> abstract interface.  Similarly to how we handle auth_protos, or perhap=
s modeled
>>>> after resolv_ops.
>>>
>>> Ok, having these RTNL calls etc., in a separate file from where we
>>> handle the config methods and policies will make the code a little
>>> clearer but the API will probably need to include the optional details
>>> like the MAC addresses.
>>>
>>
>> That is fine.  Every time we logically separate pieces behind a clear AP=
I makes
>> the code more maintainable and easier to understand.  We pay a bit in co=
de size,
>> but it is worth it in my opinion.
> =

> Every time we say "every time" it's probably wrong ;-)
> =

> I mean let's do this, but there's obviously a threshold of complexity
> where this starts to make sense.

Oh I agree.  And so far I would say that we only did such restructuring whe=
n it =

made sense.  Of course you can disagree, but I don't recall any situation w=
here =

we did something like this and said: "that was a terrible idea."

> =

> And in general clear APIs are not generally ones that use function
> pointers, or wrap simple things like a memcpy or integer operations in
> functions -- in terms of readability you simply can't beat a language
> feature (I know you disagree, not proposing we spend any more time on
> this topic..).

This is a classic example of polymorphic behavior.  Hiding this behind a vi=
rtual =

interface + backend is about as clear as things can get ;)

> =

>>
>>>> Note that netconfig behaves differently with dhcp6 client vs dhcp.  Wi=
th dhcp,
>>>> netconfig is the one setting routes and addresses.  But with dhcp6, we=
 let the
>>>> dhcp6_client itself set the route and the address.  So this may need t=
o be
>>>> refactored to act similarly to how dhcp client is managed.  Otherwise =
the
>>>> settings would be applied despite the agent being registered.
>>>
>>> I don't think that's much of an issue but let's do it, one difficulty
>>> is going to be synchronising the ell and iwd changes though.
>>
>> So I'm not sure how to interpret the statement that it isn't 'much of an=
 issue'?
>>    The contract we have is that if the agent is registered, then iwd doe=
sn't
>> apply any settings to the netdevs.
> =

> Well that's the proposal, not a contract that we have or one that has
> to be implemented fully from the start (there's hardly any protocol we

Eh, why not?  Especially if you want NM to use it?  Not honoring contracts =
is =

amateur hour.  I mean why would they even bother if we can't keep our contr=
acts?

> implement 100% and especially in netconfig -- yet it got merged).  In
> any case there's not much that that agent can do other than the same
> thing l_dhcp6_client does.

Sure, but it has to be done, not hand-waved away.

> =

>>   But what I'm pointing out above is that: the
>> way l_dhcp6_client is being driven today, this contract is broken.  netc=
onfig
>> delegates setting of the address and routes to l_dhcp6_client/l_icmp6_cl=
ient and
>> these settings are always applied if IPv6 support is enabled / detected.
> =

> Right, the difference between l_dhcp_client and l_dhcp6_client is
> strange and didn't seem to be mentioned anywhere in the netconfig.c
> until the comment I add in this patch.

Well, we tried it one way with dhcpv4.  We tried another approach with dhcp=
v6. =

Arguably, the dhcpv6 approach made a whole lot more sense until this agent =

proposal came about.  Having ell / dhcp{4|6}_client be able to set settings =

directly still might make sense for certain applications...

>>>>> +             if (netconfig->addr6_add_cmd_id) {
>>>>> +                     netconfig->pending_v4_set |=3D changed;
>>>>> +                     return;
>>>>> +             }
>>>>> +     }
>>>>> +
>>>>> +     if (af =3D=3D AF_INET) {
>>>>> +             if (changed & NETCONFIG_CHANGED_GATEWAY) {
>>>>> +                     netconfig_gateway_to_arp(netconfig);
>>>>> +
>>>>> +                     if (netconfig_ipv4_gateway_route_install(netcon=
fig))
>>>>> +                             changed &=3D ~NETCONFIG_CHANGED_GATEWAY;
>>>>> +             } else if (netconfig->notify) {
>>>>
>>>> This is really quite weird since netconfig_ipv4_gateway_route_install(=
) checks
>>>> that the gateway is NULL.  What is this trying to take care of?
>>>
>>> You mean what is the if (netconfig_ipv4_gateway_route_install) trying
>>> to take care of?  Error handling, though errors are not really
>>> expected to happen there.
>>
>> You have a special case for gateway being NULL in
>> netconfig_ipv4_gateway_route_install().  When lease is lost or cleaning =
up, you
>> set NETCONFIG_CHANGED_GATEWAY flag and a debug message and other special
>> processing takes place.  That seems bogus.
>>
>>>
>>>>
>>>>> +                     /*
>>>>> +                      * The gateway route addition callback notifies=
 the user
>>>>> +                      * of netconfig success if a gateway is provide=
d, otherwise
>>>>> +                      * notify here.
>>>>> +                      */
>>>>> +                     netconfig->notify(NETCONFIG_EVENT_CONNECTED,
>>>>> +                                             netconfig->user_data);
>>>>> +                     netconfig->notify =3D NULL;
>>>>> +             }
>>
>> Also, it looks like even if a lease is obtained without a gateway, the c=
hanged
>> flag is still set.  The only time a changed flag is not set is if the le=
ase is
>> renewed and the gateway is the same.  Which makes the block above pretty=
 suspect?
> =

> If there was no gateway and the new lease has no gateway (or the lease
> is gone), then there's no change in the gateway, right?  We don't set
> NETCONFIG_CHANGED_GATEWAY in that case.

Sure, but you still try to call the notifier saying that we're 'connected'?=
  How =

does that make sense?  Yes, I know the notifier is likely NULL by now.  But=
 I =

see no circumstances where this code path would even be hit.  And if it is =
hit, =

it is probably doing the wrong thing anyway.  So why have it in the first p=
lace?

> =

> When the value has changed then we set NETCONFIG_CHANGED_GATEWAY.  I'm
> not sure I understand what is bogus about this.  The wording CHANGED
> is because it's literally changing (new is different than the old --
> that's how you define a change), now if this is committed at the
> system level through an erase and re-add doesn't mean that the gateway
> address hasn't changed...
> =


What you say is absolutely correct.  Yet still wrong ;)  Just look at what =

happens on a 'change'.  You try to call the notifier with 'connected' event=
. =

You also print a debug message saying there's no gateway in the lease.  Nei=
ther =

make sense.

>>
>>>
>>> So basically we pass a set of new values to the new
>>> "netconfig-committer" entity, it checks what's changed, calls the
>>> agent method first, if no agent is registered it falls back to the
>>> local implementation.
>>>
>>> Honestly I see no place for an "ops" structure there, it can be forced
>>> between the "entity" and the agent code but it's adding more problems
>>> than solving.
>>
>> I disagree here.  It isn't forced at all.  The new entity just selects a=
 backend
>> to be used based on some policy.  Similar to how resolve class works.
>>
>> Right now we would have 2 backends, the agent one and our native one.  B=
ut we
>> could add more in the future.
> =

> Hypothetically we could but in the end each backend basically does the
> same simple thing in this case.
> =

> What I suspect that someone will eventually have a usecase for is
> exposing those config properties on D-Bus, in fact I think there was
> talk about this since very early on when Tim added netconfig and then
> again when I was adding P2P (I eventually added the "ConnectedIP"
> property to start with the bare minimum).

Sure.  But why do you think this is somehow at odds with the proposed archi=
tecture?

> =

>>   The change tracking wouldn't need to be in the
>> entity itself, but the backend.  This is because the agent based backend=
 has no
>> need to track changes at all.
> =

> Well we can send all of the parameters to the agent every time, that
> will work too.

We could.

> =

>>>> Perhaps lease expiration, and thus the clearing out of all settings sh=
ould be a
>>>> separate operation?  There's not much point setting domains, dns, etc =
in this case.
>>>
>>> Special-casing it won't make the code clearer but ok.
>>
>> Again, I disagree completely.  There isn't much point to set empty domai=
ns or
>> DNS info and cause unnecessary D-Bus traffic.  We do have resolve_revert=
 for a
>> reason.
> =

> We don't set them when they're empty, but we make the "committer" part
> aware that the value has changed (is different than it was).
> =


We have to see.  I think an explicit flag stating that v4/v6 info is invali=
dated =

would be a nice hint to the backend to simply invoke RevertLink or whatever=
. =

Given this, I'd also generate events and give both ipv4 and ipv6 change set=
s in =

one operation.  Even if only ipv4 or ipv6 changes were made.

Regards,
-Denis
--===============6484757398416752249==--

