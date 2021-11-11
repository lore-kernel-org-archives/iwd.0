Content-Type: multipart/mixed; boundary="===============7919798676080748484=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/9] netconfig: Refactor setting new values to system
Date: Thu, 11 Nov 2021 12:22:10 -0600
Message-ID: <7702ed9a-298d-cc96-8357-5dd85f2da575@gmail.com>
In-Reply-To: CAOq732+FEnXjE=Y3QBd2dW=gBbiA9tZCwkVjN2SyWnYzmbpK5A@mail.gmail.com

--===============7919798676080748484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> I really don't think these belong here.  If we're going in the direction=
 of
>> netconfig delegating the management of applying IP configuration setting=
s, then
>> this is up to the applying entity to store this information.  netconfig =
would
>> only be responsible for obtaining the settings and notifying the new man=
agement
>> entity.
>>
>> The new management entity would either:
>> A) invoke the agent, or
>> B) apply the settings itself.
>>
>> Preferably, A & B would use the same API and be subclasses of some gener=
ic
>> abstract interface.  Similarly to how we handle auth_protos, or perhaps =
modeled
>> after resolv_ops.
> =

> Ok, having these RTNL calls etc., in a separate file from where we
> handle the config methods and policies will make the code a little
> clearer but the API will probably need to include the optional details
> like the MAC addresses.
> =


That is fine.  Every time we logically separate pieces behind a clear API m=
akes =

the code more maintainable and easier to understand.  We pay a bit in code =
size, =

but it is worth it in my opinion.

>> Note that netconfig behaves differently with dhcp6 client vs dhcp.  With=
 dhcp,
>> netconfig is the one setting routes and addresses.  But with dhcp6, we l=
et the
>> dhcp6_client itself set the route and the address.  So this may need to =
be
>> refactored to act similarly to how dhcp client is managed.  Otherwise the
>> settings would be applied despite the agent being registered.
> =

> I don't think that's much of an issue but let's do it, one difficulty
> is going to be synchronising the ell and iwd changes though.

So I'm not sure how to interpret the statement that it isn't 'much of an is=
sue'? =

  The contract we have is that if the agent is registered, then iwd doesn't =

apply any settings to the netdevs.  But what I'm pointing out above is that=
: the =

way l_dhcp6_client is being driven today, this contract is broken.  netconf=
ig =

delegates setting of the address and routes to l_dhcp6_client/l_icmp6_clien=
t and =

these settings are always applied if IPv6 support is enabled / detected.

So yes, this is a an issue.  And it should probably be among the first thin=
gs =

that are refactored as a result of this agent-based approach since these ch=
anges =

can be regression-tested rather easily.

>>> +static void netconfig_set(struct netconfig *netconfig, uint8_t af,
>>> +                             unsigned int changed)
>>> +{
>>> +     struct l_rtnl_address *stale_addr;
>>> +
>>> +     if (af =3D=3D AF_INET)
>>> +             stale_addr =3D l_steal_ptr(netconfig->stale_v4_address);
>>> +     else
>>> +             stale_addr =3D l_steal_ptr(netconfig->stale_v6_address);
>>> +
>>> +     if (stale_addr) {
>>> +             L_WARN_ON(!l_rtnl_ifaddr_delete(rtnl, netconfig->ifindex,
>>> +                                             stale_addr,
>>> +                                             netconfig_ifaddr_del_cmd_=
cb,
>>> +                                             netconfig, NULL));
>>> +             l_rtnl_address_free(stale_addr);
>>> +     }
>>> +
>>> +     if (af =3D=3D AF_INET) {
>>> +             if (!netconfig->v4_address)
>>> +                     return;
>>> +
>>> +             if ((changed & (NETCONFIG_CHANGED_ADDRESS |
>>> +                                     NETCONFIG_CHANGED_NETMASK)) &&
>>> +                             !netconfig->addr4_add_cmd_id) {
>>> +                     netconfig->addr4_add_cmd_id =3D l_rtnl_ifaddr_add=
(rtnl,
>>> +                                     netconfig->ifindex,
>>> +                                     netconfig->v4_address,
>>> +                                     netconfig_ipv4_ifaddr_add_cmd_cb,
>>> +                                     netconfig, NULL);
>>> +                     if (!L_WARN_ON(!netconfig->addr4_add_cmd_id))
>>> +                             changed &=3D ~(NETCONFIG_CHANGED_ADDRESS |
>>> +                                             NETCONFIG_CHANGED_NETMASK=
);
>>> +             }
>>> +
>>> +             /*
>>> +              * If we either started the address addition now or one w=
as
>>> +              * already in progress, wait for that operation's callback
>>> +              * and we'll be called again to set the rest of the values
>>> +              * in the changed bitmask.
>>
>> So I'd rather see the ipv4_ifaddr_add_cmd_cb or an intermediate function=
 being
>> invoked than trying to re-invoke netconfig_set in the callback.
> =

> The advantage of this approach is that it handles these async
> operations well, i.e. you look at the bitmask and start the async ops
> to apply the config bits that have changed, clearing the corresponding
> bits from the bitmap.  If during one of those calls a new change
> happens we don't apply the remaining bits and go back to the
> beginning.  Let me see if these can be done differently...
> =


Ok, I can understand the logic behind this, but then again, we set the rout=
es, =

dns and domains once the address is set.  So you can really only 'interrupt=
' the =

ongoing setting operation after the address has been set.  Explicitly calli=
ng =

the address set callback would better reflect this reality.  But I can be =

convinced either way...

>>
>>> +              */
>>> +             if (netconfig->addr4_add_cmd_id) {
>>> +                     netconfig->pending_v4_set |=3D changed;
>>> +                     return;
>>> +             }
>>> +
>>> +             /*
>>> +              * For IPv6 the address, the subnet route and the gateway
>>> +              * route are handled automatically for DHCP, only cover t=
he
>>> +              * static and FILS-provided cases here.
>>> +              */
>>> +     } else if (netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC ||
>>> +                     (netconfig->fils_override &&
>>> +                      !l_memeqzero(netconfig->fils_override->ipv6_addr,
>>> +                                     16))) {
>>> +             if (!netconfig->v6_address)
>>> +                     return;
>>> +
>>
>> See my comment above about dhcp6_client setting addresses & routes by it=
self.
>>
>>> +             if ((changed & (NETCONFIG_CHANGED_ADDRESS |
>>> +                                     NETCONFIG_CHANGED_NETMASK)) &&
>>> +                             !netconfig->addr6_add_cmd_id) {
>>> +                     netconfig->addr6_add_cmd_id =3D l_rtnl_ifaddr_add=
(rtnl,
>>> +                                     netconfig->ifindex,
>>> +                                     netconfig->v6_address,
>>> +                                     netconfig_ipv6_ifaddr_add_cmd_cb,
>>> +                                     netconfig, NULL);
>>> +                     if (!L_WARN_ON(!netconfig->addr6_add_cmd_id))
>>> +                             changed &=3D ~(NETCONFIG_CHANGED_ADDRESS |
>>> +                                             NETCONFIG_CHANGED_NETMASK=
);
>>> +             }
>>> +
>>> +             /*
>>> +              * If we either started the address addition now or one w=
as
>>> +              * already in progress, wait for that operation's callback
>>> +              * and we'll be called again to set the rest of the values
>>> +              * in the changed bitmask.
>>> +              */
>>
>> Is there a reason why we need to wait for the ipv4 address to be set pri=
or to
>> setting the v6 address?
> =

> So within netconfig_set we don't wait, we can be setting them simultaneou=
sly.
> =


Ok, cool.

>>
>>> +             if (netconfig->addr6_add_cmd_id) {
>>> +                     netconfig->pending_v4_set |=3D changed;
>>> +                     return;
>>> +             }
>>> +     }
>>> +
>>> +     if (af =3D=3D AF_INET) {
>>> +             if (changed & NETCONFIG_CHANGED_GATEWAY) {
>>> +                     netconfig_gateway_to_arp(netconfig);
>>> +
>>> +                     if (netconfig_ipv4_gateway_route_install(netconfi=
g))
>>> +                             changed &=3D ~NETCONFIG_CHANGED_GATEWAY;
>>> +             } else if (netconfig->notify) {
>>
>> This is really quite weird since netconfig_ipv4_gateway_route_install() =
checks
>> that the gateway is NULL.  What is this trying to take care of?
> =

> You mean what is the if (netconfig_ipv4_gateway_route_install) trying
> to take care of?  Error handling, though errors are not really
> expected to happen there.

You have a special case for gateway being NULL in =

netconfig_ipv4_gateway_route_install().  When lease is lost or cleaning up,=
 you =

set NETCONFIG_CHANGED_GATEWAY flag and a debug message and other special =

processing takes place.  That seems bogus.

> =

>>
>>> +                     /*
>>> +                      * The gateway route addition callback notifies t=
he user
>>> +                      * of netconfig success if a gateway is provided,=
 otherwise
>>> +                      * notify here.
>>> +                      */
>>> +                     netconfig->notify(NETCONFIG_EVENT_CONNECTED,
>>> +                                             netconfig->user_data);
>>> +                     netconfig->notify =3D NULL;
>>> +             }

Also, it looks like even if a lease is obtained without a gateway, the chan=
ged =

flag is still set.  The only time a changed flag is not set is if the lease=
 is =

renewed and the gateway is the same.  Which makes the block above pretty su=
spect?

> =

> So basically we pass a set of new values to the new
> "netconfig-committer" entity, it checks what's changed, calls the
> agent method first, if no agent is registered it falls back to the
> local implementation.
> =

> Honestly I see no place for an "ops" structure there, it can be forced
> between the "entity" and the agent code but it's adding more problems
> than solving.

I disagree here.  It isn't forced at all.  The new entity just selects a ba=
ckend =

to be used based on some policy.  Similar to how resolve class works.

Right now we would have 2 backends, the agent one and our native one.  But =
we =

could add more in the future.  The change tracking wouldn't need to be in t=
he =

entity itself, but the backend.  This is because the agent based backend ha=
s no =

need to track changes at all.

>>
>> Gateway should be cleared, not changed.  I believe this is done automagi=
cally
>> when removing the address.
> =

> Right, netconfig_set doesn't take the "CHANGED" part literally, it's
> more like a dbus property changed signal ;-)
> =


I think this gets you into all sorts of trouble and should be changed.  See=
 above.

>>
>>> +             }
>>> +
>>> +             if (netconfig_dns_list_update(netconfig, AF_INET))
>>> +                     changed |=3D NETCONFIG_CHANGED_DNS;
>>> +
>>> +             if (netconfig_domains_update(netconfig, AF_INET))
>>> +                     changed |=3D NETCONFIG_CHANGED_DOMAINS;
>>> +
>>> +             netconfig_set(netconfig, AF_INET, changed);
>>
>> Perhaps lease expiration, and thus the clearing out of all settings shou=
ld be a
>> separate operation?  There's not much point setting domains, dns, etc in=
 this case.
> =

> Special-casing it won't make the code clearer but ok.

Again, I disagree completely.  There isn't much point to set empty domains =
or =

DNS info and cause unnecessary D-Bus traffic.  We do have resolve_revert fo=
r a =

reason.

Regards,
-Denis
--===============7919798676080748484==--

