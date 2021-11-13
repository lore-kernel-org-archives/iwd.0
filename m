Content-Type: multipart/mixed; boundary="===============7343080998373078369=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/9] netconfig: Refactor setting new values to system
Date: Sat, 13 Nov 2021 02:15:51 +0100
Message-ID: <CAOq732+dBw_aqg31Q=rrc8i==_cJiu1LhRDu+Y6XmXjPKWuZXw@mail.gmail.com>
In-Reply-To: 0880f7a8-c889-ef01-8342-e704d8d9257e@gmail.com

--===============7343080998373078369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, 11 Nov 2021 at 21:10, Denis Kenzior <denkenz(a)gmail.com> wrote:
> On 11/11/21 1:29 PM, Andrew Zaborowski wrote:
> > On Thu, 11 Nov 2021 at 19:35, Denis Kenzior <denkenz(a)gmail.com> wrote:
> >>>> Note that netconfig behaves differently with dhcp6 client vs dhcp.  =
With dhcp,
> >>>> netconfig is the one setting routes and addresses.  But with dhcp6, =
we let the
> >>>> dhcp6_client itself set the route and the address.  So this may need=
 to be
> >>>> refactored to act similarly to how dhcp client is managed.  Otherwis=
e the
> >>>> settings would be applied despite the agent being registered.
> >>>
> >>> I don't think that's much of an issue but let's do it, one difficulty
> >>> is going to be synchronising the ell and iwd changes though.
> >>
> >> So I'm not sure how to interpret the statement that it isn't 'much of =
an issue'?
> >>    The contract we have is that if the agent is registered, then iwd d=
oesn't
> >> apply any settings to the netdevs.
> >
> > Well that's the proposal, not a contract that we have or one that has
> > to be implemented fully from the start (there's hardly any protocol we
>
> Eh, why not?  Especially if you want NM to use it?  Not honoring contract=
s is
> amateur hour.  I mean why would they even bother if we can't keep our con=
tracts?
>
> > implement 100% and especially in netconfig -- yet it got merged).  In
> > any case there's not much that that agent can do other than the same
> > thing l_dhcp6_client does.
>
> Sure, but it has to be done, not hand-waved away.

Right, but the risk is that it's done twice (less harmful), not that
it doesn't get done.

So looking at l_dhcp6_client it looks like simply skipping
l_dhcp6_client_set_rtnl()/l_icmp6_client_set_rtnl() will make it
behave like l_dhcp_client, no new flag is needed.

> >>>>> +             if (netconfig->addr6_add_cmd_id) {
> >>>>> +                     netconfig->pending_v4_set |=3D changed;
> >>>>> +                     return;
> >>>>> +             }
> >>>>> +     }
> >>>>> +
> >>>>> +     if (af =3D=3D AF_INET) {
> >>>>> +             if (changed & NETCONFIG_CHANGED_GATEWAY) {
> >>>>> +                     netconfig_gateway_to_arp(netconfig);
> >>>>> +
> >>>>> +                     if (netconfig_ipv4_gateway_route_install(netc=
onfig))
> >>>>> +                             changed &=3D ~NETCONFIG_CHANGED_GATEW=
AY;
> >>>>> +             } else if (netconfig->notify) {
> >>>>
> >>>> This is really quite weird since netconfig_ipv4_gateway_route_instal=
l() checks
> >>>> that the gateway is NULL.  What is this trying to take care of?
> >>>
> >>> You mean what is the if (netconfig_ipv4_gateway_route_install) trying
> >>> to take care of?  Error handling, though errors are not really
> >>> expected to happen there.
> >>
> >> You have a special case for gateway being NULL in
> >> netconfig_ipv4_gateway_route_install().  When lease is lost or cleanin=
g up, you
> >> set NETCONFIG_CHANGED_GATEWAY flag and a debug message and other speci=
al
> >> processing takes place.  That seems bogus.
> >>
> >>>
> >>>>
> >>>>> +                     /*
> >>>>> +                      * The gateway route addition callback notifi=
es the user
> >>>>> +                      * of netconfig success if a gateway is provi=
ded, otherwise
> >>>>> +                      * notify here.
> >>>>> +                      */
> >>>>> +                     netconfig->notify(NETCONFIG_EVENT_CONNECTED,
> >>>>> +                                             netconfig->user_data);
> >>>>> +                     netconfig->notify =3D NULL;
> >>>>> +             }
> >>
> >> Also, it looks like even if a lease is obtained without a gateway, the=
 changed
> >> flag is still set.  The only time a changed flag is not set is if the =
lease is
> >> renewed and the gateway is the same.  Which makes the block above pret=
ty suspect?
> >
> > If there was no gateway and the new lease has no gateway (or the lease
> > is gone), then there's no change in the gateway, right?  We don't set
> > NETCONFIG_CHANGED_GATEWAY in that case.
>
> Sure, but you still try to call the notifier saying that we're 'connected=
'?  How
> does that make sense?  Yes, I know the notifier is likely NULL by now.  B=
ut I
> see no circumstances where this code path would even be hit.  And if it i=
s hit,
> it is probably doing the wrong thing anyway.  So why have it in the first=
 place?

Ok, I think I see what you mean.  It's not really clear why we're
trying to signal NETCONFIG_EVENT_CONNECTED whenever netconfig_set is
called.  It's basically to mirror how the original code works, I could
have probably improved it.

In the original code, when it's time to set the new gateway (i.e.
after we've set the address etc.) we either notify in the
route_add_cmd_cb, or if no gateway address is received, we emit
NETCONFIG_EVENT_CONNECTED directly in
netconfig_ipv4_gateway_route_install.  I mirrored this behaviour for
the sake of review, so it's easy to confirm that this is pure
refactoring and the sequence of RTNL commands, netconfig events and
other interactions is unaffected in the end.

Perhaps we should add a function that is guaranteed to be called after
all the bits from a new lease have been committed to the netdev and
that's where we'd emit the event, if we're not yet in connected state
(in a separate commit).

>
> >
> > When the value has changed then we set NETCONFIG_CHANGED_GATEWAY.  I'm
> > not sure I understand what is bogus about this.  The wording CHANGED
> > is because it's literally changing (new is different than the old --
> > that's how you define a change), now if this is committed at the
> > system level through an erase and re-add doesn't mean that the gateway
> > address hasn't changed...
> >
>
> What you say is absolutely correct.  Yet still wrong ;)  Just look at what
> happens on a 'change'.  You try to call the notifier with 'connected' eve=
nt.
> You also print a debug message saying there's no gateway in the lease.  N=
either
> make sense.

Ok the debug message is indeed wrong if we're handling an
L_DHCP_CLIENT_EVENT_LEASE_EXPIRED.

>
> >>
> >>>
> >>> So basically we pass a set of new values to the new
> >>> "netconfig-committer" entity, it checks what's changed, calls the
> >>> agent method first, if no agent is registered it falls back to the
> >>> local implementation.
> >>>
> >>> Honestly I see no place for an "ops" structure there, it can be forced
> >>> between the "entity" and the agent code but it's adding more problems
> >>> than solving.
> >>
> >> I disagree here.  It isn't forced at all.  The new entity just selects=
 a backend
> >> to be used based on some policy.  Similar to how resolve class works.
> >>
> >> Right now we would have 2 backends, the agent one and our native one. =
 But we
> >> could add more in the future.
> >
> > Hypothetically we could but in the end each backend basically does the
> > same simple thing in this case.
> >
> > What I suspect that someone will eventually have a usecase for is
> > exposing those config properties on D-Bus, in fact I think there was
> > talk about this since very early on when Tim added netconfig and then
> > again when I was adding P2P (I eventually added the "ConnectedIP"
> > property to start with the bare minimum).
>
> Sure.  But why do you think this is somehow at odds with the proposed arc=
hitecture?

The "changed" flags logic is helpful for that kind of interface.
Moving that logic into one of those proposed "backends" prevents the
other backends and interfaces from having this information.

> We have to see.  I think an explicit flag stating that v4/v6 info is inva=
lidated
> would be a nice hint to the backend to simply invoke RevertLink or whatev=
er.
> Given this, I'd also generate events and give both ipv4 and ipv6 change s=
ets in
> one operation.  Even if only ipv4 or ipv6 changes were made.

Ok.

Best regards
--===============7343080998373078369==--

