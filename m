Content-Type: multipart/mixed; boundary="===============5253864726517533429=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/9] netconfig: Refactor setting new values to system
Date: Thu, 11 Nov 2021 17:54:35 +0100
Message-ID: <CAOq732+FEnXjE=Y3QBd2dW=gBbiA9tZCwkVjN2SyWnYzmbpK5A@mail.gmail.com>
In-Reply-To: 949b3051-728e-d0bc-9023-dd5441451501@gmail.com

--===============5253864726517533429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 10 Nov 2021 at 19:05, Denis Kenzior <denkenz(a)gmail.com> wrote:
> On 11/8/21 5:28 AM, Andrew Zaborowski wrote:
> >   src/netconfig.c | 541 +++++++++++++++++++++++++++++++++++-------------
> >   1 file changed, 398 insertions(+), 143 deletions(-)
> >
>
> It would be far easier if this was broken down into more digestible chunk=
s.  I
> could even apply some right away since many make sense on their own.

Right, it's grown some again but it was already a result of splitting
the previous version.

>
> > diff --git a/src/netconfig.c b/src/netconfig.c
> > index e7fd4855..ea77e818 100644
> > --- a/src/netconfig.c
> > +++ b/src/netconfig.c
> > @@ -52,6 +52,15 @@
> >   #include "src/netconfig.h"
> >   #include "src/sysfs.h"
> >
> > +enum netconfig_changed_flags {
> > +     NETCONFIG_CHANGED_ADDRESS       =3D 1 << 0,
> > +     NETCONFIG_CHANGED_NETMASK       =3D 1 << 1,
>
> Isn't netmask effectively part of the address?

It's more closely related to the gateway since it's part of talking to
outside subnets (unlike address).. but you can treat it in different
ways.  I tried to make this granular to give us flexibility in how
this gets exposed to user but ok, let's skip the netmask.

>  If netmask changes, then you
> need to change the connected route and the address on the interface anywa=
y.
>
> > +     NETCONFIG_CHANGED_GATEWAY       =3D 1 << 2,
> > +     NETCONFIG_CHANGED_DNS           =3D 1 << 3,
> > +     NETCONFIG_CHANGED_DOMAINS       =3D 1 << 4,
> > +     NETCONFIG_CHANGED_ALL           =3D 0x1f,
> > +};
> > +
> >   struct netconfig {
> >       uint32_t ifindex;
> >       struct l_dhcp_client *dhcp_client;
> > @@ -59,7 +68,9 @@ struct netconfig {
> >       uint8_t rtm_protocol;
> >       uint8_t rtm_v6_protocol;
> >       struct l_rtnl_address *v4_address;
> > +     struct l_rtnl_address *stale_v4_address;
> >       struct l_rtnl_address *v6_address;
> > +     struct l_rtnl_address *stale_v6_address;
>
> I really don't think these belong here.  If we're going in the direction =
of
> netconfig delegating the management of applying IP configuration settings=
, then
> this is up to the applying entity to store this information.  netconfig w=
ould
> only be responsible for obtaining the settings and notifying the new mana=
gement
> entity.
>
> The new management entity would either:
> A) invoke the agent, or
> B) apply the settings itself.
>
> Preferably, A & B would use the same API and be subclasses of some generic
> abstract interface.  Similarly to how we handle auth_protos, or perhaps m=
odeled
> after resolv_ops.

Ok, having these RTNL calls etc., in a separate file from where we
handle the config methods and policies will make the code a little
clearer but the API will probably need to include the optional details
like the MAC addresses.

>
> >       char **dns4_overrides;
> >       char **dns6_overrides;
> >       char **dns4_list;
> > @@ -70,6 +81,8 @@ struct netconfig {
> >       char *v6_gateway_str;
> >       char *v4_domain;
> >       char **v6_domains;
> > +     unsigned int pending_v4_set;
> > +     unsigned int pending_v6_set;
>
> These probably belong in the new management entity as well.
>
> >
> >       const struct l_settings *active_settings;
> >
> > @@ -813,10 +826,8 @@ static void netconfig_route6_add_cb(int error, uin=
t16_t type,
> >       }
> >   }
> >
> > -static bool netconfig_ipv4_routes_install(struct netconfig *netconfig)
> > +static bool netconfig_ipv4_subnet_route_install(struct netconfig *netc=
onfig)
> >   {
> > -     L_AUTO_FREE_VAR(char *, gateway) =3D NULL;
> > -     const uint8_t *gateway_mac =3D NULL;
> >       struct in_addr in_addr;
> >       char ip[INET_ADDRSTRLEN];
> >       char network[INET_ADDRSTRLEN];
> > @@ -839,10 +850,19 @@ static bool netconfig_ipv4_routes_install(struct =
netconfig *netconfig)
> >                                               netconfig_route_generic_c=
b,
> >                                               netconfig, NULL)) {
> >               l_error("netconfig: Failed to add subnet route.");
> > -
> >               return false;
> >       }
> >
> > +     return true;
> > +}
> > +
> > +static bool netconfig_ipv4_gateway_route_install(struct netconfig *net=
config)
> > +{
> > +     L_AUTO_FREE_VAR(char *, gateway) =3D NULL;
> > +     const uint8_t *gateway_mac =3D NULL;
> > +     struct in_addr in_addr;
> > +     char ip[INET_ADDRSTRLEN];
> > +
> >       gateway =3D netconfig_ipv4_get_gateway(netconfig, &gateway_mac);
> >       if (!gateway) {
> >               l_debug("No gateway obtained from %s.",
> > @@ -858,6 +878,10 @@ static bool netconfig_ipv4_routes_install(struct n=
etconfig *netconfig)
> >               return true;
> >       }
> >
> > +     if (!l_rtnl_address_get_address(netconfig->v4_address, ip) ||
> > +                     inet_pton(AF_INET, ip, &in_addr) < 1)
> > +             return false;
> > +
> >       netconfig->route4_add_gateway_cmd_id =3D
> >               l_rtnl_route4_add_gateway(rtnl, netconfig->ifindex, gatew=
ay, ip,
> >                                               ROUTE_PRIORITY_OFFSET,
> > @@ -871,50 +895,77 @@ static bool netconfig_ipv4_routes_install(struct =
netconfig *netconfig)
> >               return false;
> >       }
> >
> > -     if (gateway_mac) {
> > -             /*
> > -              * Attempt to use the gateway MAC address received from t=
he AP
> > -              * by writing the mapping directly into the netdev's ARP =
table
> > -              * so as to save one data frame roundtrip before first IP
> > -              * connections are established.  This is very low-priorit=
y but
> > -              * print error messages just because they may indicate bi=
gger
> > -              * problems.
> > -              */
> > -             if (!l_rtnl_neighbor_set_hwaddr(rtnl, netconfig->ifindex,
> > +     /*
> > +      * Attempt to use the gateway MAC address received from the AP by
> > +      * writing the mapping directly into the netdev's ARP table so as
> > +      * to save one data frame roundtrip before first IP connections
> > +      * are established.  This is very low-priority but print error
> > +      * messages just because they may indicate bigger problems.
> > +      */
> > +     if (gateway_mac && !l_rtnl_neighbor_set_hwaddr(rtnl, netconfig->i=
findex,
> >                                       AF_INET,
> >                                       &netconfig->fils_override->ipv4_g=
ateway,
> >                                       gateway_mac, 6,
> >                                       netconfig_set_neighbor_entry_cb, =
NULL,
> >                                       NULL))
> > -                     l_debug("l_rtnl_neighbor_set_hwaddr failed");
> > +             l_debug("l_rtnl_neighbor_set_hwaddr failed");
> > +
> > +     return true;
> > +}
>
> I cherry-picked these changes into a separate commit, please review.

Looks good.

>
> > +
> > +static bool netconfig_ipv6_static_gateway_route_install(
> > +                                             struct netconfig *netconf=
ig)
> > +{
> > +     _auto_(l_rtnl_route_free) struct l_rtnl_route *gateway =3D NULL;
> > +     const uint8_t *gateway_mac;
> > +
> > +     gateway =3D netconfig_get_static6_gateway(netconfig,
> > +                                             &netconfig->v6_gateway_st=
r,
> > +                                             &gateway_mac);
> > +     if (!gateway) {
> > +             l_debug("No IPv6 gateway set");
> > +             return true;
> >       }
> >
> > +     netconfig->route6_add_cmd_id =3D l_rtnl_route_add(rtnl,
> > +                                                     netconfig->ifinde=
x,
> > +                                                     gateway,
> > +                                                     netconfig_route6_=
add_cb,
> > +                                                     netconfig, NULL);
> > +     if (!L_WARN_ON(unlikely(!netconfig->route6_add_cmd_id)))
> > +             return false;
> > +
> > +     if (gateway_mac && !l_rtnl_neighbor_set_hwaddr(rtnl, netconfig->i=
findex,
> > +                                     AF_INET6,
> > +                                     netconfig->fils_override->ipv6_ga=
teway,
> > +                                     gateway_mac, 6,
> > +                                     netconfig_set_neighbor_entry_cb, =
NULL,
> > +                                     NULL))
> > +             l_debug("l_rtnl_neighbor_set_hwaddr failed");
> > +
> >       return true;
> >   }
>
> Note that netconfig behaves differently with dhcp6 client vs dhcp.  With =
dhcp,
> netconfig is the one setting routes and addresses.  But with dhcp6, we le=
t the
> dhcp6_client itself set the route and the address.  So this may need to be
> refactored to act similarly to how dhcp client is managed.  Otherwise the
> settings would be applied despite the agent being registered.

I don't think that's much of an issue but let's do it, one difficulty
is going to be synchronising the ell and iwd changes though.

>
> >
> > +static void netconfig_set(struct netconfig *netconfig, uint8_t af,
> > +                             unsigned int changed);
> > +
>
> doc/coding-style.txt item M17

It's the exception M17 talks about.

>
> <snip>
>
> > @@ -978,21 +1005,169 @@ static void netconfig_ifaddr_del_cmd_cb(int err=
or, uint16_t type,
> >                               "Error %d: %s", error, strerror(-error));
> >   }
> >
> > +static bool netconfig_address_cmp_address(const struct l_rtnl_address =
*a,
> > +                                             const struct l_rtnl_addre=
ss *b)
> > +{
> > +     char str_a[INET6_ADDRSTRLEN];
> > +     char str_b[INET6_ADDRSTRLEN];
> > +
> > +     if (a =3D=3D b)
> > +             return true;
> > +
> > +     if (!a || !b)
> > +             return false;
> > +
> > +     if (!l_rtnl_address_get_address(a, str_a) ||
> > +                     !l_rtnl_address_get_address(b, str_b))
> > +             return false;
> > +
> > +     return !strcmp(str_a, str_b);
> > +}
> > +
>
> This probably belongs in ell.

Ok.

>
> > +static void netconfig_set(struct netconfig *netconfig, uint8_t af,
> > +                             unsigned int changed)
> > +{
> > +     struct l_rtnl_address *stale_addr;
> > +
> > +     if (af =3D=3D AF_INET)
> > +             stale_addr =3D l_steal_ptr(netconfig->stale_v4_address);
> > +     else
> > +             stale_addr =3D l_steal_ptr(netconfig->stale_v6_address);
> > +
> > +     if (stale_addr) {
> > +             L_WARN_ON(!l_rtnl_ifaddr_delete(rtnl, netconfig->ifindex,
> > +                                             stale_addr,
> > +                                             netconfig_ifaddr_del_cmd_=
cb,
> > +                                             netconfig, NULL));
> > +             l_rtnl_address_free(stale_addr);
> > +     }
> > +
> > +     if (af =3D=3D AF_INET) {
> > +             if (!netconfig->v4_address)
> > +                     return;
> > +
> > +             if ((changed & (NETCONFIG_CHANGED_ADDRESS |
> > +                                     NETCONFIG_CHANGED_NETMASK)) &&
> > +                             !netconfig->addr4_add_cmd_id) {
> > +                     netconfig->addr4_add_cmd_id =3D l_rtnl_ifaddr_add=
(rtnl,
> > +                                     netconfig->ifindex,
> > +                                     netconfig->v4_address,
> > +                                     netconfig_ipv4_ifaddr_add_cmd_cb,
> > +                                     netconfig, NULL);
> > +                     if (!L_WARN_ON(!netconfig->addr4_add_cmd_id))
> > +                             changed &=3D ~(NETCONFIG_CHANGED_ADDRESS |
> > +                                             NETCONFIG_CHANGED_NETMASK=
);
> > +             }
> > +
> > +             /*
> > +              * If we either started the address addition now or one w=
as
> > +              * already in progress, wait for that operation's callback
> > +              * and we'll be called again to set the rest of the values
> > +              * in the changed bitmask.
>
> So I'd rather see the ipv4_ifaddr_add_cmd_cb or an intermediate function =
being
> invoked than trying to re-invoke netconfig_set in the callback.

The advantage of this approach is that it handles these async
operations well, i.e. you look at the bitmask and start the async ops
to apply the config bits that have changed, clearing the corresponding
bits from the bitmap.  If during one of those calls a new change
happens we don't apply the remaining bits and go back to the
beginning.  Let me see if these can be done differently...

>
> > +              */
> > +             if (netconfig->addr4_add_cmd_id) {
> > +                     netconfig->pending_v4_set |=3D changed;
> > +                     return;
> > +             }
> > +
> > +             /*
> > +              * For IPv6 the address, the subnet route and the gateway
> > +              * route are handled automatically for DHCP, only cover t=
he
> > +              * static and FILS-provided cases here.
> > +              */
> > +     } else if (netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC ||
> > +                     (netconfig->fils_override &&
> > +                      !l_memeqzero(netconfig->fils_override->ipv6_addr,
> > +                                     16))) {
> > +             if (!netconfig->v6_address)
> > +                     return;
> > +
>
> See my comment above about dhcp6_client setting addresses & routes by its=
elf.
>
> > +             if ((changed & (NETCONFIG_CHANGED_ADDRESS |
> > +                                     NETCONFIG_CHANGED_NETMASK)) &&
> > +                             !netconfig->addr6_add_cmd_id) {
> > +                     netconfig->addr6_add_cmd_id =3D l_rtnl_ifaddr_add=
(rtnl,
> > +                                     netconfig->ifindex,
> > +                                     netconfig->v6_address,
> > +                                     netconfig_ipv6_ifaddr_add_cmd_cb,
> > +                                     netconfig, NULL);
> > +                     if (!L_WARN_ON(!netconfig->addr6_add_cmd_id))
> > +                             changed &=3D ~(NETCONFIG_CHANGED_ADDRESS |
> > +                                             NETCONFIG_CHANGED_NETMASK=
);
> > +             }
> > +
> > +             /*
> > +              * If we either started the address addition now or one w=
as
> > +              * already in progress, wait for that operation's callback
> > +              * and we'll be called again to set the rest of the values
> > +              * in the changed bitmask.
> > +              */
>
> Is there a reason why we need to wait for the ipv4 address to be set prio=
r to
> setting the v6 address?

So within netconfig_set we don't wait, we can be setting them simultaneousl=
y.

>
> > +             if (netconfig->addr6_add_cmd_id) {
> > +                     netconfig->pending_v4_set |=3D changed;
> > +                     return;
> > +             }
> > +     }
> > +
> > +     if (af =3D=3D AF_INET) {
> > +             if (changed & NETCONFIG_CHANGED_GATEWAY) {
> > +                     netconfig_gateway_to_arp(netconfig);
> > +
> > +                     if (netconfig_ipv4_gateway_route_install(netconfi=
g))
> > +                             changed &=3D ~NETCONFIG_CHANGED_GATEWAY;
> > +             } else if (netconfig->notify) {
>
> This is really quite weird since netconfig_ipv4_gateway_route_install() c=
hecks
> that the gateway is NULL.  What is this trying to take care of?

You mean what is the if (netconfig_ipv4_gateway_route_install) trying
to take care of?  Error handling, though errors are not really
expected to happen there.

>
> > +                     /*
> > +                      * The gateway route addition callback notifies t=
he user
> > +                      * of netconfig success if a gateway is provided,=
 otherwise
> > +                      * notify here.
> > +                      */
> > +                     netconfig->notify(NETCONFIG_EVENT_CONNECTED,
> > +                                             netconfig->user_data);
> > +                     netconfig->notify =3D NULL;
> > +             }
> > +     } else if (netconfig->rtm_v6_protocol =3D=3D RTPROT_STATIC ||
> > +                     (netconfig->fils_override &&
> > +                      !l_memeqzero(netconfig->fils_override->ipv6_gate=
way,
> > +                                     16))) {
> > +             if (changed & (NETCONFIG_CHANGED_GATEWAY))
> > +                     if (netconfig_ipv6_static_gateway_route_install(
> > +                                                             netconfig=
))
> > +                             changed &=3D ~NETCONFIG_CHANGED_GATEWAY;
> > +     }
> > +
> > +     if (changed & NETCONFIG_CHANGED_DNS) {
> > +             netconfig_set_dns(netconfig);
> > +             changed &=3D ~NETCONFIG_CHANGED_DNS;
> > +     }
> > +
> > +     if (changed & NETCONFIG_CHANGED_DOMAINS) {
> > +             netconfig_set_domains(netconfig);
> > +             changed &=3D ~NETCONFIG_CHANGED_DOMAINS;
> > +     }
> > +}
> > +
> >   static void netconfig_ipv4_dhcp_event_handler(struct l_dhcp_client *c=
lient,
> >                                               enum l_dhcp_client_event =
event,
> >                                               void *userdata)
> >   {
> >       struct netconfig *netconfig =3D userdata;
> > +     unsigned int changed =3D 0;
> >
> >       l_debug("DHCPv4 event %d", event);
> >
> >       switch (event) {
> >       case L_DHCP_CLIENT_EVENT_IP_CHANGED:
> > -             L_WARN_ON(!l_rtnl_ifaddr_delete(rtnl, netconfig->ifindex,
> > -                                     netconfig->v4_address,
> > -                                     netconfig_ifaddr_del_cmd_cb,
> > -                                     netconfig, NULL));
> > -             /* Fall through. */
> >       case L_DHCP_CLIENT_EVENT_LEASE_OBTAINED:
> >       {
> >               char *gateway_str;
> > @@ -1004,9 +1179,19 @@ static void netconfig_ipv4_dhcp_event_handler(st=
ruct l_dhcp_client *client,
> >               else {
> >                       l_free(netconfig->v4_gateway_str);
> >                       netconfig->v4_gateway_str =3D gateway_str;
> > +                     changed |=3D NETCONFIG_CHANGED_GATEWAY;
> >               }
> >
> >               address =3D netconfig_get_dhcp4_address(netconfig);
> > +
> > +             if (!netconfig_address_cmp_prefix_len(netconfig->v4_addre=
ss,
> > +                                                     address))
> > +                     changed |=3D NETCONFIG_CHANGED_NETMASK;
> > +
> > +             if (!netconfig_address_cmp_address(netconfig->v4_address,
> > +                                                     address))
> > +                     changed |=3D NETCONFIG_CHANGED_ADDRESS;
> > +
>
> My impression is that the comparison of new vs old settings should be giv=
en over
> to the new management entity.

Ok.

So basically we pass a set of new values to the new
"netconfig-committer" entity, it checks what's changed, calls the
agent method first, if no agent is registered it falls back to the
local implementation.

Honestly I see no place for an "ops" structure there, it can be forced
between the "entity" and the agent code but it's adding more problems
than solving.

>
> >               l_rtnl_address_free(netconfig->v4_address);
> >               netconfig->v4_address =3D address;
> >
> > @@ -1016,26 +1201,36 @@ static void netconfig_ipv4_dhcp_event_handler(s=
truct l_dhcp_client *client,
> >                       return;
> >               }
> >
> > -             netconfig_dns_list_update(netconfig, AF_INET);
> > -             netconfig_domains_update(netconfig, AF_INET);
> > +             if (netconfig_dns_list_update(netconfig, AF_INET))
> > +                     changed |=3D NETCONFIG_CHANGED_DNS;
> >
> > -             L_WARN_ON(!(netconfig->addr4_add_cmd_id =3D
> > -                             l_rtnl_ifaddr_add(rtnl, netconfig->ifinde=
x,
> > -                                     netconfig->v4_address,
> > -                                     netconfig_ipv4_ifaddr_add_cmd_cb,
> > -                                     netconfig, NULL)));
> > +             if (netconfig_domains_update(netconfig, AF_INET))
> > +                     changed |=3D NETCONFIG_CHANGED_DOMAINS;
> > +
> > +             netconfig_set(netconfig, AF_INET, changed);
> >               break;
> >       }
> >       case L_DHCP_CLIENT_EVENT_LEASE_RENEWED:
> >               break;
> >       case L_DHCP_CLIENT_EVENT_LEASE_EXPIRED:
> > -             L_WARN_ON(!l_rtnl_ifaddr_delete(rtnl, netconfig->ifindex,
> > -                                     netconfig->v4_address,
> > -                                     netconfig_ifaddr_del_cmd_cb,
> > -                                     netconfig, NULL));
> > -             l_rtnl_address_free(netconfig->v4_address);
> > -             netconfig->v4_address =3D NULL;
> > -             l_free(l_steal_ptr(netconfig->v4_gateway_str));
> > +             l_debug("Lease for interface %u expired", netconfig->ifin=
dex);
> > +             changed =3D NETCONFIG_CHANGED_ADDRESS | NETCONFIG_CHANGED=
_NETMASK;
> > +             l_rtnl_address_free(netconfig->stale_v4_address);
> > +             netconfig->stale_v4_address =3D
> > +                     l_steal_ptr(netconfig->v4_address);
> > +
> > +             if (netconfig->v4_gateway_str) {
> > +                     changed |=3D NETCONFIG_CHANGED_GATEWAY;
> > +                     l_free(l_steal_ptr(netconfig->v4_gateway_str));
>
> Gateway should be cleared, not changed.  I believe this is done automagic=
ally
> when removing the address.

Right, netconfig_set doesn't take the "CHANGED" part literally, it's
more like a dbus property changed signal ;-)

>
> > +             }
> > +
> > +             if (netconfig_dns_list_update(netconfig, AF_INET))
> > +                     changed |=3D NETCONFIG_CHANGED_DNS;
> > +
> > +             if (netconfig_domains_update(netconfig, AF_INET))
> > +                     changed |=3D NETCONFIG_CHANGED_DOMAINS;
> > +
> > +             netconfig_set(netconfig, AF_INET, changed);
>
> Perhaps lease expiration, and thus the clearing out of all settings shoul=
d be a
> separate operation?  There's not much point setting domains, dns, etc in =
this case.

Special-casing it won't make the code clearer but ok.

Best regards
--===============5253864726517533429==--

