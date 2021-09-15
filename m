Content-Type: multipart/mixed; boundary="===============0989930646809954354=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 2/2] netconfig: Add IP configuration properties on Station
 and P2P
Date: Wed, 15 Sep 2021 11:36:46 +0200
Message-ID: <CAOq732Jb217VZ7LxUVGOuarg5F4XVnai_0LSosb8s5VpOr+=VA@mail.gmail.com>
In-Reply-To: 8b7683f4-bff8-f46a-7272-fb7c8ad384e4@gmail.com
Message-ID: <20210915093646.fBDYmkDcwsugaTrkVXeKDS5H5Cm5tbahQWVhv0BR-eM@z>

--===============0989930646809954354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 15 Sept 2021 at 00:08, Denis Kenzior <denkenz(a)gmail.com> wrote:
> On 9/8/21 4:44 PM, Andrew Zaborowski wrote:
> > @@ -703,6 +732,43 @@ static void netconfig_route_generic_cb(int error, =
uint16_t type,
> >       }
> >   }
> >
> > +static void netconfig_connected(struct netconfig *netconfig)
> > +{
> > +     struct l_dbus *dbus =3D dbus_get_bus();
> > +
> > +     netconfig->connected =3D true;
> > +
> > +     if (netconfig->notify) {
> > +             netconfig->notify(NETCONFIG_EVENT_CONNECTED,
> > +                                     netconfig->user_data);
> > +             netconfig->notify =3D NULL;
> > +     }
> > +
> > +     if (netconfig->dbus_path &&
> > +                     unlikely(!l_dbus_object_add_interface(dbus,
> > +                                             netconfig->dbus_path,
> > +                                             IWD_IPV4_CONFIG_INTERFACE,
> > +                                             &netconfig->ipv4_data)))
> > +             l_info("Unable to add %s at %s",
> > +                     IWD_IPV4_CONFIG_INTERFACE, netconfig->dbus_path);
> > +
> > +     if (netconfig->dbus_path &&
> > +                     unlikely(!l_dbus_object_add_interface(dbus,
> > +                                             netconfig->dbus_path,
> > +                                             IWD_IPV6_CONFIG_INTERFACE,
> > +                                             &netconfig->ipv6_data)))
> > +             l_info("Unable to add %s at %s",
> > +                     IWD_IPV6_CONFIG_INTERFACE, netconfig->dbus_path);
> > +
> > +     if (netconfig->dbus_path &&
> > +                     !l_dbus_object_add_interface(dbus, netconfig->dbu=
s_path,
> > +                                             L_DBUS_INTERFACE_PROPERTI=
ES,
> > +                                             netconfig))
> > +             /* Properties may already exist on the object, not an err=
or */
> > +             l_debug("Unable to add %s at %s",
> > +                     L_DBUS_INTERFACE_PROPERTIES, netconfig->dbus_path=
);
>
> So the connected event is fired once we have IPv4 or IPv6 configuration, =
right?
>
> Why would we populate both IPv6 and IPv4 interfaces here though?  Why don=
't you
> just make IPv6 interface available when IPv6 is configured, and similarly=
 for
> IPv4?  Would make a lot of the code simpler and require less
> l_dbus_property_changed() calls.

Yep, I was considering that, the semantics of the two interfaces are
going to be a little different but that should be fine for NM as the
potential user of the API.

I added a netconfig.connected, I'll need to split this into a
.connected4 and .connected6 or similar, to track whether we've added
the interfaces yet.

>
> > +}
> > +
> >   static void netconfig_route_add_cmd_cb(int error, uint16_t type,
> >                                               const void *data, uint32_=
t len,
> >                                               void *user_data)
>
> <snip>
>
> > @@ -897,10 +989,47 @@ static void netconfig_ipv4_dhcp_event_handler(str=
uct l_dhcp_client *client,
> >                                       netconfig->v4_address,
> >                                       netconfig_ifaddr_del_cmd_cb,
> >                                       netconfig, NULL));
> > -             l_rtnl_address_free(netconfig->v4_address);
> >               /* Fall through. */
> >       case L_DHCP_CLIENT_EVENT_LEASE_OBTAINED:
> > -             netconfig->v4_address =3D netconfig_get_dhcp4_address(net=
config);
> > +     {
> > +             char *gateway_str;
> > +             struct l_rtnl_address *address;
> > +
> > +             gateway_str =3D netconfig_ipv4_get_gateway(netconfig, NUL=
L);
> > +             if (l_streq0(netconfig->v4_gateway_str, gateway_str))
> > +                     l_free(gateway_str);
> > +             else {
> > +                     l_free(netconfig->v4_gateway_str);
> > +                     netconfig->v4_gateway_str =3D gateway_str;
> > +
> > +                     if (netconfig->dbus_path && netconfig->connected)
> > +                             l_dbus_property_changed(dbus,
> > +                                             netconfig->dbus_path,
> > +                                             IWD_IPV4_CONFIG_INTERFACE,
> > +                                             "Gateway");
> > +             }
>
> So in theory LEASE_OBTAINED should only ever be signaled once.  Why not r=
egister
> the IPv4 interface now and avoid all this logic?  If we lose the lease fo=
r some
> reason, then we should get a LEASE_LOST or LEASE_EXPIRED event first.

Yep, that'd be in line with making the interfaces be present only
during the time that we have a lease (if method is DHCP.)

>
> > +
> > +             address =3D netconfig_get_dhcp4_address(netconfig);
> > +
> > +             if (netconfig->dbus_path && netconfig->connected &&
> > +                             !netconfig_address_cmp_prefix_len(
> > +                                                     netconfig->v4_add=
ress,
> > +                                                     address))
> > +                     l_dbus_property_changed(dbus, netconfig->dbus_pat=
h,
> > +                                             IWD_IPV4_CONFIG_INTERFACE,
> > +                                             "Netmask");
> > +
> > +             if (netconfig->dbus_path && netconfig->connected &&
> > +                             netconfig_address_cmp_address(
> > +                                                     netconfig->v4_add=
ress,
> > +                                                     address))
> > +                     l_dbus_property_changed(dbus, netconfig->dbus_pat=
h,
> > +                                             IWD_IPV4_CONFIG_INTERFACE,
> > +                                             "Address");
> > +
> > +             l_rtnl_address_free(netconfig->v4_address);
> > +             netconfig->v4_address =3D address;
> > +
> >               if (!netconfig->v4_address) {
> >                       l_error("netconfig: Failed to obtain IP addresses=
 from "
> >                                                       "DHCPv4 lease.");
> > @@ -913,6 +1042,7 @@ static void netconfig_ipv4_dhcp_event_handler(stru=
ct l_dhcp_client *client,
> >                                       netconfig_ipv4_ifaddr_add_cmd_cb,
> >                                       netconfig, NULL)));
> >               break;
> > +     }
> >       case L_DHCP_CLIENT_EVENT_LEASE_RENEWED:
> >               break;
> >       case L_DHCP_CLIENT_EVENT_LEASE_EXPIRED:
> > @@ -923,6 +1053,25 @@ static void netconfig_ipv4_dhcp_event_handler(str=
uct l_dhcp_client *client,
> >               l_rtnl_address_free(netconfig->v4_address);
> >               netconfig->v4_address =3D NULL;
> >
> > +             if (netconfig->dbus_path && netconfig->connected) {
> > +                     l_dbus_property_changed(dbus, netconfig->dbus_pat=
h,
> > +                                             IWD_IPV4_CONFIG_INTERFACE,
> > +                                             "Address");
> > +                     l_dbus_property_changed(dbus, netconfig->dbus_pat=
h,
> > +                                             IWD_IPV4_CONFIG_INTERFACE,
> > +                                             "Netmask");
> > +             }
> > +
> > +             if (netconfig->v4_gateway_str) {
> > +                     if (netconfig->dbus_path && netconfig->connected)
> > +                             l_dbus_property_changed(dbus,
> > +                                             netconfig->dbus_path,
> > +                                             IWD_IPV4_CONFIG_INTERFACE,
> > +                                             "Gateway");
> > +
> > +                     l_free(l_steal_ptr(netconfig->v4_gateway_str));
> > +             }
>
> Why not simply remove the IPv4 interface?

Yep, same here.

>
> > +
> >               /* Fall through. */
> >       case L_DHCP_CLIENT_EVENT_NO_LEASE:
> >               /*
> > @@ -945,18 +1094,87 @@ static void netconfig_dhcp6_event_handler(struct=
 l_dhcp6_client *client,
> >                                               void *userdata)
> >   {
> >       struct netconfig *netconfig =3D userdata;
> > +     struct l_dbus *dbus =3D dbus_get_bus();
> >
> >       switch (event) {
> >       case L_DHCP6_CLIENT_EVENT_IP_CHANGED:
> >       case L_DHCP6_CLIENT_EVENT_LEASE_OBTAINED:
> >       case L_DHCP6_CLIENT_EVENT_LEASE_RENEWED:
> > +     {
> > +             __auto_type lease =3D
> > +                     l_dhcp6_client_get_lease(netconfig->dhcp6_client);
> > +             L_AUTO_FREE_VAR(char *, addr_str) =3D
> > +                     l_dhcp6_lease_get_address(lease);
> > +             struct l_rtnl_address *address;
> > +             __auto_type icmp6 =3D
> > +                     l_dhcp6_client_get_icmp6(netconfig->dhcp6_client);
> > +             __auto_type router =3D l_icmp6_client_get_router(icmp6);
> > +             char *gateway_str =3D l_icmp6_router_get_address(router);
> > +
> > +             if (l_streq0(netconfig->v6_gateway_str, gateway_str))
> > +                     l_free(gateway_str);
> > +             else {
> > +                     l_free(netconfig->v6_gateway_str);
> > +                     netconfig->v6_gateway_str =3D gateway_str;
> > +
> > +                     if (netconfig->dbus_path && netconfig->connected)
> > +                             l_dbus_property_changed(dbus,
> > +                                             netconfig->dbus_path,
> > +                                             IWD_IPV6_CONFIG_INTERFACE,
> > +                                             "Gateway");
> > +             }
> > +
> > +             address =3D l_rtnl_address_new(addr_str,
> > +                                     l_dhcp6_lease_get_prefix_length(l=
ease));
> > +
> > +             if (netconfig->dbus_path && netconfig->connected &&
> > +                             !netconfig_address_cmp_prefix_len(
> > +                                                     netconfig->v6_add=
ress,
> > +                                                     address))
> > +                     l_dbus_property_changed(dbus, netconfig->dbus_pat=
h,
> > +                                             IWD_IPV6_CONFIG_INTERFACE,
> > +                                             "Netmask");
> > +
> > +             if (netconfig->dbus_path && netconfig->connected &&
> > +                             netconfig_address_cmp_address(
> > +                                                     netconfig->v6_add=
ress,
> > +                                                     address))
> > +                     l_dbus_property_changed(dbus, netconfig->dbus_pat=
h,
> > +                                             IWD_IPV6_CONFIG_INTERFACE,
> > +                                             "Address");
> > +
> > +             l_rtnl_address_free(netconfig->v6_address);
> > +             netconfig->v4_address =3D address;
>
> v6 address?

Oops, yes.

>
> Also similar comments as above?  Why not just register the IPv6 interface=
 here
> instead?
>
> Also, I'm really not sure whether just Netmask/Address/Gateway are the on=
ly
> things that can change.  DNS, NTP, domain, etc information might also cha=
nge.
> So a more generic old lease / new lease comparison might be needed.  Or a=
lways
> send a PropertyChanged for all attributes and have the caller figure it o=
ut?

I mentioned in the commit that the signals don't cover all of the
properties since those are unlikely to be useful and are unlikely to
change, in fact ell/dhcp.c also only checks the netmask, the address
and the router when emitting the event.  I'll add the missing signals
just in case.

>
> <snip>
>
> > +static bool netconfig_property_get_domains(struct l_dbus *dbus,
> > +                                     struct l_dbus_message *message,
> > +                                     struct l_dbus_message_builder *bu=
ilder,
> > +                                     void *user_data)
> > +{
> > +     const struct interface_data *data =3D user_data;
> > +
> > +     if (data->is_ipv4) {
> > +             L_AUTO_FREE_VAR(char *, domain) =3D
> > +                     l_settings_get_string(data->netconfig->active_set=
tings,
> > +                                             "IPv4", "DomainName");
> > +
> > +             if (!domain) {
> > +                     const struct l_dhcp_lease *lease;
> > +
> > +                     if (data->netconfig->rtm_protocol !=3D RTPROT_DHC=
P)
> > +                             return false;
> > +
> > +                     lease =3D l_dhcp_client_get_lease(
> > +                                             data->netconfig->dhcp_cli=
ent);
> > +                     if (!lease)
> > +                             return false;
> > +
> > +                     if (!(domain =3D l_dhcp_lease_get_domain_name(lea=
se)))
> > +                             return false;
> > +             }
> > +
> > +             l_dbus_message_builder_enter_array(builder, "s");
> > +             l_dbus_message_builder_append_basic(builder, 's', domain);
> > +             l_dbus_message_builder_leave_array(builder);
> > +     } else {
> > +             const struct l_dhcp6_lease *lease;
> > +             char **domains;
> > +             char **i;
> > +
> > +             if (data->netconfig->rtm_v6_protocol !=3D RTPROT_DHCP)
> > +                     return false;
> > +
> > +             lease =3D l_dhcp6_client_get_lease(data->netconfig->dhcp6=
_client);
> > +             if (!lease)
> > +                     return false;
> > +
> > +             domains =3D l_dhcp6_lease_get_domains(lease);
> > +             if (!domains)
> > +                     return false;
> > +
> > +             l_dbus_message_builder_enter_array(builder, "s");
> > +
> > +             for (i =3D domains; *i; i++)
> > +                     l_dbus_message_builder_append_basic(builder, 's',=
 *i);
> > +
> > +             l_dbus_message_builder_leave_array(builder);
> > +             l_strv_free(domains);
> > +     }
> > +
> > +     return true;
>
> Might as well make this two separate functions

Ok.

Best regards
--===============0989930646809954354==--

