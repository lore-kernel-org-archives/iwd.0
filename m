Content-Type: multipart/mixed; boundary="===============5180646379577420113=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] netconfig: Add IP configuration properties on Station and
 P2P
Date: Thu, 23 Sep 2021 00:19:27 +0200
Message-ID: <CAOq732K5p9ctz2ORSULxQ0auwv8q+gdO6vgiBWoW3watGnHH7w@mail.gmail.com>
In-Reply-To: 9a08d49a-ebfc-a57b-e6d4-a863063a2e54@gmail.com

--===============5180646379577420113==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 22 Sept 2021 at 22:16, Denis Kenzior <denkenz(a)gmail.com> wrote:
>
> Hi Andrew,
>
> On 9/17/21 5:18 AM, Andrew Zaborowski wrote:
> > Add the IPv{4,6}Configuration D-Bus interfaces on the station and P2P
> > objects that expose current netconfig values.  Access Point and P2P-GO
> > are not handled yet.
> > ---
> >   src/dbus.h      |   2 +
> >   src/netconfig.c | 651 +++++++++++++++++++++++++++++++++++++++++++-----
> >   src/netconfig.h |   2 +-
> >   src/p2p.c       |   4 +-
> >   src/station.c   |   8 +-
> >   5 files changed, 604 insertions(+), 63 deletions(-)
> >
>
> Can you split this patch up a bit more, there's just way too much going o=
n.  It
> is really hard to review in this form.

Ok, it's grown a bit.

>
> > diff --git a/src/dbus.h b/src/dbus.h
> > index 7703b37f..a345f7ac 100644
> > --- a/src/dbus.h
> > +++ b/src/dbus.h
> > @@ -43,6 +43,8 @@
> >   #define IWD_STATION_DIAGNOSTIC_INTERFACE "net.connman.iwd.StationDiag=
nostic"
> >   #define IWD_AP_DIAGNOSTIC_INTERFACE "net.connman.iwd.AccessPointDiagn=
ostic"
> >   #define IWD_STATION_DEBUG_INTERFACE "net.connman.iwd.StationDebug"
> > +#define IWD_IPV4_CONFIG_INTERFACE "net.connman.iwd.IPv4Configuration"
> > +#define IWD_IPV6_CONFIG_INTERFACE "net.connman.iwd.IPv6Configuration"
> >
> >   #define IWD_BASE_PATH "/net/connman/iwd"
> >   #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
> > diff --git a/src/netconfig.c b/src/netconfig.c
> > index 421270c9..a529fad4 100644
> > --- a/src/netconfig.c
> > +++ b/src/netconfig.c
> > @@ -49,6 +49,7 @@
> >   #include "src/resolve.h"
> >   #include "src/util.h"
> >   #include "src/ie.h"
> > +#include "src/dbus.h"
> >   #include "src/netconfig.h"
> >
> >   struct netconfig {
> > @@ -58,14 +59,23 @@ struct netconfig {
> >       uint8_t rtm_protocol;
> >       uint8_t rtm_v6_protocol;
> >       struct l_rtnl_address *v4_address;
> > +     struct l_rtnl_address *v6_address;
> >       char **dns4_overrides;
> >       char **dns6_overrides;
> > +     char **dns4_list;
> > +     char **dns6_list;
> >       struct ie_fils_ip_addr_response_info *fils_override;
> > +     char *v4_gateway_str;
> > +     char *v6_gateway_str;
> > +     char *v4_domain;
> > +     char **v6_domains;
>
> Maybe a commit for each member you're adding and a short blurb why..
>
> >
> >       const struct l_settings *active_settings;
> >
> >       netconfig_notify_func_t notify;
> >       void *user_data;
> > +     bool v4_configured;
> > +     bool v6_configured;
>
> Then the IPv4 & IPv6 DBus interfaces
>
> >
> >       struct resolve *resolve;
> >
> > @@ -74,6 +84,13 @@ struct netconfig {
> >       uint32_t addr4_add_cmd_id;
> >       uint32_t addr6_add_cmd_id;
> >       uint32_t route4_add_gateway_cmd_id;
> > +     uint32_t route6_add_cmd_id;
>
> This seems like it would belong in a separate commit?

Ok.

>
> > +
> > +     char *dbus_path;
> > +     struct interface_data {
> > +             bool is_ipv4;
> > +             struct netconfig *netconfig;
> > +     } v4_data, v6_data;
> >   };
> >
> >   static struct l_netlink *rtnl;
> > @@ -132,6 +149,7 @@ static void netconfig_free(void *data)
> >       l_dhcp_client_destroy(netconfig->dhcp_client);
> >       l_dhcp6_client_destroy(netconfig->dhcp6_client);
> >
> > +     l_free(netconfig->dbus_path);
> >       l_free(netconfig);
> >   }
> >
> > @@ -257,6 +275,18 @@ static void netconfig_set_neighbor_entry_cb(int er=
ror,
> >                       strerror(-error), error);
> >   }
> >
> > +static bool netconfig_strv_eq(char *const *a, char *const *b)
> > +{
> > +     if (l_strv_length((char **) a) !=3D l_strv_length((char **) b))
> > +             return false;
> > +
> > +     for (; a && *a; a++, b++)
> > +             if (strcmp(*a, *b))
> > +                     return false;
> > +
> > +     return true;
>
> This probably belongs in ell?

Ok.

>
> > +}
> > +
> >   static int netconfig_set_dns(struct netconfig *netconfig)
> >   {
> >       const uint8_t *fils_dns4_mac =3D NULL;
> > @@ -270,23 +300,25 @@ static int netconfig_set_dns(struct netconfig *ne=
tconfig)
> >       char **dns_list;
> >       const struct ie_fils_ip_addr_response_info *fils =3D
> >               netconfig->fils_override;
> > +     struct l_dbus *dbus =3D dbus_get_bus();
> >
> > -     if (!dns4_list && !dns6_list)
> > -             return 0;
> > +     if (dns6_list) {
> > +             dns_list =3D l_malloc(sizeof(char *) *
> > +                                     (n_entries4 + n_entries6 + 1));
> >
> > -     dns_list =3D dns4_list;
> > +             if (dns4_list)
> > +                     memcpy(dns_list, dns4_list,
> > +                             sizeof(char *) * n_entries4);
> >
> > -     if (dns6_list) {
> > -             dns_list =3D l_realloc(dns_list,
> > -                             sizeof(char *) * (n_entries4 + n_entries6=
 + 1));
> >               memcpy(dns_list + n_entries4, dns6_list,
> >                       sizeof(char *) * (n_entries6 + 1));
> > -             /* Contents now belong to dns_list, so no l_strfreev */
> > -             l_free(dns6_list);
> > -     }
> > +     } else
> > +             dns_list =3D dns4_list;
> >
> >       resolve_set_dns(netconfig->resolve, dns_list);
> > -     l_strv_free(dns_list);
> > +
> > +     if (dns6_list)
> > +             l_free(dns_list);
>
> Why are you doing all this when you can just check for dns[4|6]_list being
> changed prior to building the list for submission to resolve_set_dns?

Do you mean why is the code calling resolve_set_dns() even if the
values haven't changed?  Mostly to keep the current behaviour.

I can check for changes first, this might save cycles if the call
isn't necessary -- I wasn't sure if it's only needed when the lists
have changed. It won't save lines of code

>
> >
> >       if (fils_dns4_mac && !l_rtnl_neighbor_set_hwaddr(rtnl,
> >                                       netconfig->ifindex, AF_INET,
> > @@ -302,6 +334,30 @@ static int netconfig_set_dns(struct netconfig *net=
config)
> >                                       NULL))
> >               l_debug("l_rtnl_neighbor_set_hwaddr failed");
> >
> > +     if (netconfig_strv_eq(netconfig->dns4_list, dns4_list))
> > +             l_strv_free(dns4_list);
> > +     else {
> > +             l_strv_free(netconfig->dns4_list);
> > +             netconfig->dns4_list =3D dns4_list;
> > +
> > +             if (netconfig->dbus_path && netconfig->v4_configured)
> > +                     l_dbus_property_changed(dbus, netconfig->dbus_pat=
h,
> > +                                             IWD_IPV4_CONFIG_INTERFACE,
> > +                                             "DomainNameServers");
> > +     }
> > +
> > +     if (netconfig_strv_eq(netconfig->dns6_list, dns6_list))
> > +             l_strv_free(dns6_list);
> > +     else {
> > +             l_strv_free(netconfig->dns6_list);
> > +             netconfig->dns6_list =3D dns6_list;
> > +
> > +             if (netconfig->dbus_path && netconfig->v6_configured)
> > +                     l_dbus_property_changed(dbus, netconfig->dbus_pat=
h,
> > +                                             IWD_IPV6_CONFIG_INTERFACE,
> > +                                             "DomainNameServers");
> > +     }
> > +
>
> This really needs a convenience method instead of copy-pasting it all ove=
r.

Ok.

>
> >       return 0;
> >   }
> >
> > @@ -328,6 +384,7 @@ static int netconfig_set_domains(struct netconfig *=
netconfig)
> >       char *v4_domain =3D NULL;
> >       char **v6_domains =3D NULL;
> >       char **p;
> > +     struct l_dbus *dbus =3D dbus_get_bus();
> >
> >       memset(domains, 0, sizeof(domains));
> >
> > @@ -358,8 +415,30 @@ static int netconfig_set_domains(struct netconfig =
*netconfig)
> >                                       L_ARRAY_SIZE(domains) - 1, *p);
> >
> >       resolve_set_domains(netconfig->resolve, domains);
> > -     l_strv_free(v6_domains);
> > -     l_free(v4_domain);
> > +
> > +     if (l_streq0(v4_domain, netconfig->v4_domain))
> > +             l_free(v4_domain);
> > +     else {
> > +             l_free(netconfig->v4_domain);
> > +             netconfig->v4_domain =3D v4_domain;
> > +
> > +             if (netconfig->dbus_path && netconfig->v4_configured)
> > +                     l_dbus_property_changed(dbus, netconfig->dbus_pat=
h,
> > +                                             IWD_IPV4_CONFIG_INTERFACE,
> > +                                             "DomainNames");
> > +     }
> > +
> > +     if (netconfig_strv_eq(netconfig->v6_domains, v6_domains))
> > +             l_strv_free(v6_domains);
> > +     else {
> > +             l_strv_free(netconfig->v6_domains);
> > +             netconfig->v6_domains =3D v6_domains;
> > +
> > +             if (netconfig->dbus_path && netconfig->v6_configured)
> > +                     l_dbus_property_changed(dbus, netconfig->dbus_pat=
h,
> > +                                             IWD_IPV6_CONFIG_INTERFACE,
> > +                                             "DomainNames");
> > +     }
>
> As above.  And I still wonder whether this belongs in the methods that in=
voke
> the resolve_* functionality.  The logic that invokes these methods might
> actually have a better idea if anything actually changed or it is being i=
nvoked
> for the first time due to a lease being obtained...

It'd probably be an intermediate function that builds the lists,
checks for changes and then calls resolve_set_domains/dns() and emits
the events, so as to avoid duplication, I can do that.

Best regards
--===============5180646379577420113==--

