Content-Type: multipart/mixed; boundary="===============4436841983437065681=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/5] ap: Refactor IP address selection
Date: Wed, 03 Mar 2021 20:17:46 +0100
Message-ID: <CAOq732J6m4g83b0TpYbXWGx3927bn=Lu=eDmLHfNOOjGR2AQ=Q@mail.gmail.com>
In-Reply-To: <088ad181-760f-9211-bb04-1f4e83f03b2f@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4436841983437065681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Mar 2021 at 18:14, Denis Kenzior <denkenz@gmail.com> wrote:
> On 3/2/21 6:08 AM, Andrew Zaborowski wrote:
> > Refactor how the subnet IP address is selected and change related
> > settings syntax in the following way:
> >
> > * [IPv4].Address in an AP profile can now be given as just an IP address
> >    or a list of prefix notation address spaces.  In the latter case one
> >    subnet address of the size implied by [IPv4].Netmask is selected
> >    randomly from that space, defaults to a 28-bit netmask.  In the form=
er
> >    case [IPv4].Address is now also checked for conflicts with addresses
> >    already in use.
> >
> > * main.conf's [IPv4].APAddressPool is now the fallback setting that uses
> >    the same syntax as profile-local [IPv4].Address and has a default
> >    value of 192.168.0.0/16.
> >
> > * main.conf's [General].APRanges is deprecated in favour of
> >    [IPv4].APAddressPool but this change should be backwards compatible.
> >
> > ap_setup_dhcp now always prints error messages, it seems it was assumed
> > that the caller would do this before but it didn't.  It also now always
> > reads [IPv4].Netmask or the value already set on the interface (when
> > existing IP is used) and uses that value.  Previously the configured
> > netmask was only being announced through DHCP but not used locally.
> > Require that the WPA-PSK passphrase is present in the AP profile,
> > previously it was treated as optional but the rest of the code was
> > expecting it to always be present.
>
> So I really wish this patch was broken up more.  Reviewing 800 line patch=
sets is
> already a pain.  And you have a bunch of different things going on here.

Right, partly it's because I'm replacing the existing code and I can't
change just one part of it but I'll try to perhaps drop it in one
patch and re-add in steps.

>
> >
> > Drop the l_net_get_address() usage, replace with the more complicated
> > l_rtnl_* calls.  This is to avoid also adding an l_net_get_netmask() to
> > ell since we'd need that and we reportely don't want to keep using the
> > netdev ioctls.
>
> This is really metadata / change log.  Does not belong in the description.

Ok, although personally when I'm looking through a commit log a lot of
the time my first question is *why* something is being changed.

>
> > ---
> >   src/ap.c | 804 ++++++++++++++++++++++++++++++++++---------------------
> >   1 file changed, 502 insertions(+), 302 deletions(-)
> >
> > diff --git a/src/ap.c b/src/ap.c
> > index 2042cde6..d871f973 100644
> > --- a/src/ap.c
> > +++ b/src/ap.c
> > @@ -28,6 +28,7 @@
> >   #include <linux/if_ether.h>
> >   #include <netinet/in.h>
> >   #include <arpa/inet.h>
> > +#include <ifaddrs.h>
> >
> >   #include <ell/ell.h>
> >
> > @@ -78,15 +79,16 @@ struct ap_state {
> >       uint16_t last_aid;
> >       struct l_queue *sta_states;
> >
> > +     struct l_settings *profile;
> >       struct l_dhcp_server *server;
> > +     uint32_t rtnl_dump_cmd;
> >       uint32_t rtnl_add_cmd;
> >       char *own_ip;
> > -     unsigned int ip_prefix;
> > +     uint8_t ip_prefix;
> >
> >       bool started : 1;
> >       bool gtk_set : 1;
> >       bool cleanup_ip : 1;
> > -     bool use_ip_pool : 1;
> >   };
> >
> >   struct sta_state {
> > @@ -115,99 +117,11 @@ struct ap_wsc_pbc_probe_record {
> >       uint64_t timestamp;
> >   };
> >
> > -struct ap_ip_pool {
> > -     uint32_t start;
> > -     uint32_t end;
> > -     uint8_t prefix;
> > -
> > -     /* Fist/last valid subnet */
> > -     uint8_t sub_start;
> > -     uint8_t sub_end;
> > -
> > -     struct l_uintset *used;
> > -};
> > -
> > -struct ap_ip_pool pool;
> > +static bool netconfig_enabled;
> > +static char **global_addr_strs;
> >   static uint32_t netdev_watch;
> >   struct l_netlink *rtnl;
> >
> > -/*
> > - * Creates pool of IPs which AP intefaces can use. Each call to ip_poo=
l_get
> > - * will advance the subnet +1 so there are no IP conflicts between AP
> > - * interfaces
> > - */
> > -static bool ip_pool_create(const char *ip_prefix)
> > -{
> > -     if (!util_ip_prefix_tohl(ip_prefix, &pool.prefix, &pool.start,
> > -                                     &pool.end, NULL))
> > -             return false;
> > -
> > -     if (pool.prefix > 24) {
> > -             l_error("APRanges prefix must 24 or less (%u used)",
> > -                             pool.prefix);
> > -             memset(&pool, 0, sizeof(pool));
> > -             return false;
> > -     }
> > -
> > -     /*
> > -      * Find the number of subnets we can use, this will dictate the n=
umber
> > -      * of AP interfaces that can be created (when using DHCP)
> > -      */
> > -     pool.sub_start =3D (pool.start & 0x0000ff00) >> 8;
> > -     pool.sub_end =3D (pool.end & 0x0000ff00) >> 8;
> > -
> > -     pool.used =3D l_uintset_new_from_range(pool.sub_start, pool.sub_e=
nd);
> > -
> > -     return true;
> > -}
> > -
> > -static char *ip_pool_get()
> > -{
> > -     uint32_t ip;
> > -     struct in_addr ia;
> > -     uint8_t next_subnet =3D (uint8_t)l_uintset_find_unused_min(pool.u=
sed);
> > -
> > -     /* This shouldn't happen */
> > -     if (next_subnet < pool.sub_start || next_subnet > pool.sub_end)
> > -             return NULL;
> > -
> > -     l_uintset_put(pool.used, next_subnet);
> > -
> > -     ip =3D pool.start;
> > -     ip &=3D 0xffff00ff;
> > -     ip |=3D (next_subnet << 8);
> > -
> > -     ia.s_addr =3D htonl(ip);
> > -     return l_strdup(inet_ntoa(ia));
> > -}
> > -
> > -static bool ip_pool_put(const char *address)
> > -{
> > -     struct in_addr ia;
> > -     uint32_t ip;
> > -     uint8_t subnet;
> > -
> > -     if (inet_aton(address, &ia) < 0)
> > -             return false;
> > -
> > -     ip =3D ntohl(ia.s_addr);
> > -
> > -     subnet =3D (ip & 0x0000ff00) >> 8;
> > -
> > -     if (subnet < pool.sub_start || subnet > pool.sub_end)
> > -             return false;
> > -
> > -     return l_uintset_take(pool.used, subnet);
> > -}
> > -
> > -static void ip_pool_destroy()
> > -{
> > -     if (pool.used)
> > -             l_uintset_free(pool.used);
> > -
> > -     memset(&pool, 0, sizeof(pool));
> > -}
> > -
> >   static const char *broadcast_from_ip(const char *ip)
> >   {
> >       struct in_addr ia;
> > @@ -304,6 +218,13 @@ static void ap_reset(struct ap_state *ap)
> >       if (ap->start_stop_cmd_id)
> >               l_genl_family_cancel(ap->nl80211, ap->start_stop_cmd_id);
> >
> > +     if (ap->rtnl_dump_cmd) {
> > +             uint32_t cmd =3D ap->rtnl_dump_cmd;
> > +
> > +             ap->rtnl_dump_cmd =3D 0;
> > +             l_netlink_cancel(rtnl, cmd);
>
> Why is this so complicated?  Isn't rtnl_dump_cmd reset in the destructor?

I abused rtnl_dump_cmd =3D 0 here to signal that there's no need to call
ap_netconfig_start.

>
> > +     }
> > +
> >       if (ap->rtnl_add_cmd)
> >               l_netlink_cancel(rtnl, ap->rtnl_add_cmd);
> >
> > @@ -326,16 +247,16 @@ static void ap_reset(struct ap_state *ap)
> >                                       broadcast_from_ip(ap->own_ip),
> >                                       NULL, NULL, NULL);
> >
> > -     if (ap->own_ip) {
> > -             /* Release IP from pool if used */
> > -             if (ap->use_ip_pool)
> > -                     ip_pool_put(ap->own_ip);
> > -
> > +     if (ap->own_ip)
> >               l_free(ap->own_ip);
> > -     }
> >
> >       if (ap->server)
> >               l_dhcp_server_stop(ap->server);
> > +
> > +     if (ap->profile) {
> > +             l_settings_free(ap->profile);
> > +             ap->profile =3D NULL;
> > +     }
> >   }
> >
> >   static void ap_del_station(struct sta_state *sta, uint16_t reason,
> > @@ -2172,34 +2093,41 @@ static struct l_genl_msg *ap_build_cmd_start_ap=
(struct ap_state *ap)
> >       return cmd;
> >   }
> >
> > -static void ap_ifaddr4_added_cb(int error, uint16_t type, const void *=
data,
> > -                             uint32_t len, void *user_data)
> > +static bool ap_start_send(struct ap_state *ap)
> >   {
> > -     struct ap_state *ap =3D user_data;
> > -     struct l_genl_msg *cmd;
> > -
> > -     ap->rtnl_add_cmd =3D 0;
> > +     struct l_genl_msg *cmd =3D ap_build_cmd_start_ap(ap);
> >
> > -     if (error) {
> > -             l_error("Failed to set IP address");
> > -             goto error;
> > +     if (!cmd) {
> > +             l_error("ap_build_cmd_start_ap failed");
> > +             return false;
> >       }
> >
> > -     cmd =3D ap_build_cmd_start_ap(ap);
> > -     if (!cmd)
> > -             goto error;
> > -
> >       ap->start_stop_cmd_id =3D l_genl_family_send(ap->nl80211, cmd,
> >                                                       ap_start_cb, ap, =
NULL);
> >       if (!ap->start_stop_cmd_id) {
> > +             l_error("AP_START l_genl_family_send failed");
> >               l_genl_msg_unref(cmd);
> > -             goto error;
> > +             return false;
> >       }
> >
> > -     return;
> > +     return true;
> > +}
> >
> > -error:
> > -     ap_start_failed(ap);
> > +static void ap_ifaddr4_added_cb(int error, uint16_t type, const void *=
data,
> > +                             uint32_t len, void *user_data)
> > +{
> > +     struct ap_state *ap =3D user_data;
> > +
> > +     ap->rtnl_add_cmd =3D 0;
> > +
> > +     if (error) {
> > +             l_error("Failed to set IP address");
> > +             ap_start_failed(ap);
> > +             return;
> > +     }
> > +
> > +     if (!ap_start_send(ap))
> > +             ap_start_failed(ap);
> >   }
> >
> >   static bool ap_parse_new_station_ies(const void *data, uint16_t len,
> > @@ -2394,23 +2322,21 @@ static void ap_mlme_notify(struct l_genl_msg *m=
sg, void *user_data)
> >       }
> >   }
> >
> > -static bool dhcp_load_settings(struct ap_state *ap, struct l_settings =
*settings)
> > +static bool ap_load_dhcp_settings(struct ap_state *ap,
> > +                                     uint32_t own_ip, uint8_t prefix)
>
> One thing I don't like about this is that the primary IP selection is done
> elsewhere, but then Netmask/IPRange settings are parsed after the fact.

Actually I'm not a fan of that either but that's how the existing (and
reviewed?) code does it. In this patch I'm moving the Netconfig
handling together with the subnet selection but I didn't touch the
IPRange parsing, the change is already big as you noted.

>  I'm not
> sure if it makes sense for a profile to have Netmask/IPRange settings if =
it also
> doesn't have the Address set to a single subnet.

Agreed about IPRange, but for Netmask I see it as a way to specify the
prefix length basically, i.e. how much address space the AP wants.

>  l_dhcp_server probably only
> works with prefixes >=3D 24 when allocating addresses.

I haven't looked at it but even then you may want to specify your own
value between 24 - 28 or 29... 28 being the new default.

(Obviously all of these are very specific settings... I assume there's
some reason why we have them)

>  Shouldn't we load the
> profile and verify it mostly in one place?

I haven't really checked but my assumption was that the existing code
skips some of the verification because the l_dhcp_* methods would
verify the values passed to it and we avoid duplicating that work.

>
> Things like DNSList and LeaseTime are probably OK done separately, since =
they're
> not dependent on the IP selection.
>
> >   {
> >       struct l_dhcp_server *server =3D ap->server;
> > -     struct in_addr ia;
> >
> > -     L_AUTO_FREE_VAR(char *, netmask) =3D l_settings_get_string(settin=
gs,
> > -                                                     "IPv4", "Netmask"=
);
> > -     L_AUTO_FREE_VAR(char *, gateway) =3D l_settings_get_string(settin=
gs,
> > +     L_AUTO_FREE_VAR(char *, gateway) =3D l_settings_get_string(ap->pr=
ofile,
> >                                                       "IPv4", "Gateway"=
);
> > -     char **dns =3D l_settings_get_string_list(settings, "IPv4",
> > +     char **dns =3D l_settings_get_string_list(ap->profile, "IPv4",
> >                                                       "DNSList", ',');
> > -     char **ip_range =3D l_settings_get_string_list(settings, "IPv4",
> > +     char **ip_range =3D l_settings_get_string_list(ap->profile, "IPv4=
",
> >                                                       "IPRange", ',');
> >       unsigned int lease_time;
> >       bool ret =3D false;
> >
> > -     if (!l_settings_get_uint(settings, "IPv4", "LeaseTime", &lease_ti=
me))
> > +     if (!l_settings_get_uint(ap->profile, "IPv4", "LeaseTime", &lease=
_time))
> >               lease_time =3D 0;
> >
> >       if (gateway && !l_dhcp_server_set_gateway(server, gateway)) {
> > @@ -2423,17 +2349,34 @@ static bool dhcp_load_settings(struct ap_state =
*ap, struct l_settings *settings)
> >               goto error;
> >       }
> >
> > -     if (netmask && !l_dhcp_server_set_netmask(server, netmask)) {
> > -             l_error("[IPv4].Netmask value error");
> > -             goto error;
> > -     }
> > -
> >       if (ip_range) {
> > +             int i;
> > +
> >               if (l_strv_length(ip_range) !=3D 2) {
> >                       l_error("Two addresses expected in [IPv4].IPRange=
");
> >                       goto error;
> >               }
> >
> > +             for (i =3D 0; i < 2; i++) {
> > +                     struct in_addr range_addr;
> > +
> > +                     if (inet_aton(ip_range[i], &range_addr) !=3D 1) {
> > +                             l_error("Can't parse address in "
> > +                                     "[IPv4].IPRange[%i]", i + 1);
> > +                             goto error;
> > +                     }
> > +
> > +                     if ((own_ip ^ ntohl(range_addr.s_addr)) &
> > +                                     util_netmask_from_prefix(prefix))=
 {
> > +                             struct in_addr addr =3D { htonl(own_ip) };
> > +
> > +                             l_error("[IPv4].IPRange[%i] is not in the=
 "
> > +                                     "%s/%i subnet", i + 1,
> > +                                     inet_ntoa(addr), prefix);
> > +                             goto error;
> > +                     }
> > +             }
> > +
> >               if (!l_dhcp_server_set_ip_range(server, ip_range[0],
> >                                                       ip_range[1])) {
> >                       l_error("Error setting IP range from [IPv4].IPRan=
ge");
> > @@ -2446,11 +2389,6 @@ static bool dhcp_load_settings(struct ap_state *=
ap, struct l_settings *settings)
> >               goto error;
> >       }
> >
> > -     if (netmask && inet_pton(AF_INET, netmask, &ia) > 0)
> > -             ap->ip_prefix =3D __builtin_popcountl(ia.s_addr);
> > -     else
> > -             ap->ip_prefix =3D 24;
> > -
> >       ret =3D true;
> >
> >   error:
> > @@ -2459,166 +2397,404 @@ error:
> >       return ret;
> >   }
> >
> > +struct ap_ip_range {
> > +     uint32_t start;
> > +     uint32_t end;
> > +};
> > +
> > +static int ap_ip_range_compare(const void *a, const void *b, void *use=
r_data)
> > +{
> > +     const struct ap_ip_range *range_a =3D a;
> > +     const struct ap_ip_range *range_b =3D b;
> > +
> > +     return range_a->start > range_b->start;
> > +}
> > +
> >   /*
> > - * This will determine the IP being used for DHCP. The IP will be auto=
matically
> > - * set to ap->own_ip.
> > - *
> > - * The address to set (or keep) is determined in this order:
> > - * 1. Address defined in provisioning file
> > - * 2. Address already set on interface
> > - * 3. Address in IP pool.
> > - *
> > - * Returns:  0 if an IP was successfully selected and needs to be set
> > - *          -EALREADY if an IP was already set on the interface
> > - *          -EEXIST if the IP pool ran out of IP's
> > - *          -EINVAL if there was an error.
> > + * Append any address ranges within an input start/end range, which co=
ntain
> > + * at least one full subnet and don't intersect with any subnets alrea=
dy in
> > + * use.  This may result in the input range being split into multiple =
ranges
> > + * of different sizes or being skipped altogether.
> > + * All inputs must be rounded to the subnet boundary and the @used que=
ue
> > + * sorted by the subnet start address.
> >    */
> > -static int ap_setup_dhcp(struct ap_state *ap, struct l_settings *setti=
ngs)
> > +static void ap_append_range(struct l_queue *to, const struct ap_ip_ran=
ge *range,
> > +                             struct l_queue *used, const char *str)
> > +{
> > +     const struct l_queue_entry *entry =3D l_queue_get_entries(used);
> > +     const struct ap_ip_range *used_range =3D entry ? entry->data : NU=
LL;
> > +     uint32_t start =3D range->start;
> > +     bool print =3D true;
> > +
> > +     while (range->end > start) {
> > +             while (used_range && used_range->end <=3D start) {
> > +                     entry =3D entry->next;
> > +                     used_range =3D entry ? entry->data : NULL;
> > +             }
> > +
> > +             /* No more used ranges that intersect with @start/@range-=
>end */
> > +             if (!used_range || range->end <=3D used_range->start) {
> > +                     struct ap_ip_range *sub =3D l_new(struct ap_ip_ra=
nge, 1);
> > +
> > +                     sub->start =3D start;
> > +                     sub->end =3D range->end;
> > +                     l_queue_push_tail(to, sub);
> > +                     l_queue_insert(used, l_memdup(sub, sizeof(*sub)),
> > +                                     ap_ip_range_compare, NULL);
> > +                     return;
> > +             }
> > +
> > +             if (print) {
> > +                     l_debug("Address spec %s intersects with at least=
 one "
> > +                             "subnet already in use on the system or "
> > +                             "specified in the settings", str);
> > +                     print =3D false;
> > +             }
> > +
> > +             /* Now we know @used_range is non-NULL and intersects */
> > +             if (start < used_range->start) {
> > +                     struct ap_ip_range *sub =3D l_new(struct ap_ip_ra=
nge, 1);
> > +
> > +                     sub->start =3D start;
> > +                     sub->end =3D used_range->start;
> > +                     l_queue_push_tail(to, sub);
> > +                     l_queue_insert(used, l_memdup(sub, sizeof(*sub)),
> > +                                     ap_ip_range_compare, NULL);
> > +             }
> > +
> > +             /* Skip to the start of the next subnet */
> > +             start =3D used_range->end;
> > +     }
> > +}
>
> Can we split out the address allocation logic out into a separate file so=
 that
> we can more easily add unit tests for it?

Ok.  Note that the autotests James added already test the logic pretty well.

>
> > +
> > +/* Select a subnet and a host address from a defined space */
> > +static int ap_select_addr(const char **addr_str_list, uint8_t prefix,
> > +                             const char *ifname, uint32_t *out_addr)
> >   {
> > -     uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
> > +     uint32_t total =3D 0;
> > +     uint32_t selected;
> > +     unsigned int i;
> > +     uint32_t addr;
> > +     struct ifaddrs *ifaddr;
> > +     const struct ifaddrs *ifa;
> > +     uint32_t subnet_size =3D 1 << (32 - prefix);
> > +     uint32_t host_mask =3D subnet_size - 1;
> > +     uint32_t subnet_mask =3D ~host_mask;
> > +     uint32_t host_addr =3D 0;
> > +     struct l_queue *ranges =3D l_queue_new();
> > +     struct l_queue *used =3D l_queue_new();
> >       struct in_addr ia;
> > -     uint32_t address =3D 0;
> > -     int ret =3D -EINVAL;
> > +     const struct l_queue_entry *entry;
> > +     int err =3D -EINVAL;
> >
> > -     ap->server =3D l_dhcp_server_new(ifindex);
> > -     if (!ap->server) {
> > -             l_error("Failed to create DHCP server on %u", ifindex);
> > -             return -EINVAL;;
> > +     /* Build a sorted list of used/unavailable subnets */
> > +     if (getifaddrs(&ifaddr) !=3D 0)
> > +             ifaddr =3D NULL;
>
> So you already made an RTNL dump elsewhere, and are now effectively doing=
 it
> again.  Can we not combine the two somehow?

True, I should probably combine them.

>
> > +
> > +     for (ifa =3D ifaddr; ifa; ifa =3D ifa->ifa_next) {
> > +             const struct sockaddr_in *addr_sa;
> > +             const struct sockaddr_in *netmask_sa;
> > +             uint32_t used_addr;
> > +             uint32_t used_prefix;
> > +             struct ap_ip_range *range;
> > +
> > +             if (ifa->ifa_addr->sa_family !=3D AF_INET)
> > +                     continue;
> > +
> > +             /*
> > +              * Ignore the subnet set on the target interface, we'll be
> > +              * overwriting it if everything goes well.
> > +              */
> > +             if (!strcmp(ifa->ifa_name, ifname))
> > +                     continue;
> > +
> > +             addr_sa =3D (struct sockaddr_in *) ifa->ifa_addr;
> > +             netmask_sa =3D (struct sockaddr_in *) ifa->ifa_netmask;
> > +             if (!addr_sa || !netmask_sa)
> > +                     continue;
> > +
> > +             used_addr =3D ntohl(addr_sa->sin_addr.s_addr);
> > +             used_prefix =3D __builtin_popcountl(netmask_sa->sin_addr.=
s_addr);
> > +
> > +             range =3D l_new(struct ap_ip_range, 1);
> > +             range->start =3D used_addr & subnet_mask;
> > +             range->end =3D (range->start + (1 << (32 - used_prefix)) +
> > +                             subnet_size - 1) & subnet_mask;
> > +             l_queue_insert(used, range, ap_ip_range_compare, NULL);
> >       }
> >
> > -     if (getenv("IWD_DHCP_DEBUG"))
> > -             l_dhcp_server_set_debug(ap->server, do_debug,
> > -                                                     "[DHCPv4 SERV] ",=
 NULL);
> > +     freeifaddrs(ifaddr);
> >
> > -     /* get the current address if there is one */
> > -     if (l_net_get_address(ifindex, &ia) && ia.s_addr !=3D 0)
> > -             address =3D ia.s_addr;
> > +     /* Build the list of available subnets */
> >
> > -     if (ap->config->profile) {
> > -             char *addr;
> > -
> > -             addr =3D l_settings_get_string(settings, "IPv4", "Address=
");
> > -             if (addr) {
> > -                     if (inet_pton(AF_INET, addr, &ia) < 0)
> > -                             goto free_addr;
> > -
> > -                     /* Is a matching address already set on interface=
? */
> > -                     if (ia.s_addr =3D=3D address)
> > -                             ret =3D -EALREADY;
> > -                     else
> > -                             ret =3D 0;
> > -             } else if (address) {
> > -                     /* No address in config, but interface has one se=
t */
> > -                     addr =3D l_strdup(inet_ntoa(ia));
> > -                     ret =3D -EALREADY;
> > -             } else
> > -                     goto free_addr;
> > +     /* Check for the static IP syntax: Address=3D<IP> */
> > +     if (l_strv_length((char **) addr_str_list) =3D=3D 1 &&
> > +                     inet_pton(AF_INET, *addr_str_list, &ia) =3D=3D 1)=
 {
> > +             struct ap_ip_range range;
> >
> > -             /* Set the remaining DHCP options in config file */
> > -             if (!dhcp_load_settings(ap, settings)) {
> > -                     ret =3D -EINVAL;
> > -                     goto free_addr;
> > +             host_addr =3D ntohl(ia.s_addr);
> > +             range.start =3D host_addr & subnet_mask;
> > +             range.end =3D range.start + subnet_size;
> > +             ap_append_range(ranges, &range, used, *addr_str_list);
> > +             goto select_addr;
> > +     }
> > +
> > +     for (i =3D 0; addr_str_list[i]; i++) {
> > +             struct ap_ip_range range;
> > +             uint8_t addr_prefix;
> > +
> > +             if (!util_ip_prefix_tohl(addr_str_list[i], &addr_prefix, =
&addr,
> > +                                             NULL, NULL)) {
> > +                     l_error("Can't parse %s as a subnet address",
> > +                             addr_str_list[i]);
> > +                     goto done;
> >               }
> >
> > -             if (!l_dhcp_server_set_ip_address(ap->server, addr)) {
> > -                     ret =3D -EINVAL;
> > -                     goto free_addr;
> > +             if (addr_prefix > prefix) {
> > +                     l_debug("Address spec %s smaller than requested "
> > +                             "subnet (prefix len %i)", addr_str_list[i=
],
> > +                             prefix);
> > +                     continue;
> >               }
> >
> > -             ap->own_ip =3D l_strdup(addr);
> > +             range.start =3D addr & subnet_mask;
> > +             range.end =3D range.start + (1 << (32 - addr_prefix));
> > +             ap_append_range(ranges, &range, used, addr_str_list[i]);
> > +     }
> > +
> > +select_addr:
> > +     if (l_queue_isempty(ranges)) {
> > +             l_error("No IP subnets available for new Access Point aft=
er "
> > +                     "eliminating those already in use on the system");
> > +             err =3D -EEXIST;
> > +             goto done;
> > +     }
> >
> > -free_addr:
> > -             l_free(addr);
> > +     /* Count available @prefix-sized subnets */
> > +     for (entry =3D l_queue_get_entries(ranges); entry; entry =3D entr=
y->next) {
> > +             struct ap_ip_range *range =3D entry->data;
> >
> > -             return ret;
> > -     } else if (address) {
> > -             /* No config file and address is already set */
> > -             ap->own_ip =3D l_strdup(inet_ntoa(ia));
> > +             total +=3D (range->end - range->start) >> (32 - prefix);
> > +     }
> >
> > -             return -EALREADY;
> > -     } else if (pool.used) {
> > -             /* No config file, no address set. Use IP pool */
> > -             ap->own_ip =3D ip_pool_get();
> > -             if (!ap->own_ip) {
> > -                     l_error("No more IP's in pool, cannot start AP on=
 %u",
> > -                                     ifindex);
> > -                     return -EEXIST;
> > -             }
> > +     selected =3D l_getrandom_uint32() % total;
> >
> > -             ap->use_ip_pool =3D true;
> > -             ap->ip_prefix =3D pool.prefix;
> > +     /* Find the @selected'th @prefix-sized subnet */
> > +     for (entry =3D l_queue_get_entries(ranges);; entry =3D entry->nex=
t) {
> > +             struct ap_ip_range *range =3D entry->data;
> > +             uint32_t count =3D (range->end - range->start) >> (32 - p=
refix);
> >
> > -             return 0;
> > +             if (selected < count) {
> > +                     addr =3D range->start + (selected << (32 - prefix=
));
> > +                     break;
> > +             }
> > +
> > +             selected -=3D count;
> >       }
> >
> > -     return -EINVAL;
> > +     if (!host_addr)
> > +             host_addr =3D addr + 1;
> > +
> > +     err =3D 0;
> > +     *out_addr =3D host_addr;
> > +
> > +done:
> > +     l_queue_destroy(ranges, l_free);
> > +     l_queue_destroy(used, l_free);
> > +     return err;
> >   }
> >
> > -static int ap_load_profile_and_dhcp(struct ap_state *ap, bool *wait_dh=
cp)
> > +#define AP_DEFAULT_IPV4_PREFIX_LEN 28
> > +
> > +/*
> > + * This will determine the IP to be used for DHCP.  ap->server,
> > + * ap->own_ip and ap->ip_prefix will be set.
> > + *
> > + * The address to set (or keep) is determined in this order:
> > + * 1. Select from address pool defined in the provisioning file
> > + * 2. Keep address already set on the interface
> > + * 3. Select from the global address pool (default 192.168.0.0/16)
> > + *
> > + * Returns:  0 if an IP was successfully selected and needs to be set,
> > + *          -EALREADY if an IP is already set on the interface (succes=
s),
> > + *          -EEXIST if all available subnet addresses are in use (erro=
r),
> > + *          -EINVAL if there was a different error.
> > + */
> > +static int ap_setup_dhcp(struct ap_state *ap, uint32_t existing_addres=
s,
> > +                             uint8_t existing_prefix)
> >   {
> >       uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
> > -     char *passphrase;
> > -     struct l_settings *settings =3D NULL;
> > -     int err =3D -EINVAL;
> > +     struct in_addr if_addr;
> > +     struct in_addr if_netmask;
> > +     uint32_t address;
> > +     uint8_t prefix;
> > +     int ret =3D -EINVAL;
> > +     char **addr_str_list;
> > +     L_AUTO_FREE_VAR(char *, netmask_str) =3D
> > +             l_settings_get_string(ap->profile, "IPv4", "Netmask");
>
> Elsewhere you check that ap->profile is not NULL, but not here.  Seems in=
consistent.

Good point.

>
> Also, I'm a bit lost why ap->profile might be NULL.  Shouldn't we simply =
create
> an empty profile instead to simplify the logic?

I'm not sure how much this is going to simplify the logic but we can
do that, again that wasn't my choice.

>
> >
> > -     /* No profile or DHCP settings */
> > -     if (!ap->config->profile && !pool.used)
> > -             return 0;
> > +     ap->server =3D l_dhcp_server_new(ifindex);
>
> Ah l_dhcp_server_new can't fail...

Ok.

>
> > +     if (!ap->server) {
> > +             l_error("Failed to create DHCP server on %u", ifindex);
> > +             return -EINVAL;
> > +     }
> >
> > -     if (ap->config->profile) {
> > -             settings =3D l_settings_new();
> > +     if (getenv("IWD_DHCP_DEBUG"))
> > +             l_dhcp_server_set_debug(ap->server, do_debug,
> > +                                                     "[DHCPv4 SERV] ",=
 NULL);
> >
> > -             if (!l_settings_load_from_file(settings, ap->config->prof=
ile))
> > -                     goto cleanup;
> > +     if (ap->profile &&
> > +                     l_settings_get_value(ap->profile, "IPv4", "Addres=
s")) {
> > +             addr_str_list =3D l_settings_get_string_list(ap->profile,=
 "IPv4",
> > +                                                             "Address"=
, ',');
> > +             if (!addr_str_list || !*addr_str_list) {
> > +                     l_error("Can't parse the profile [IPv4].Address "
> > +                             "setting as a string list");
> > +                     goto done;
> > +             }
> > +     } else if (existing_address) {
> > +             addr_str_list =3D NULL;
> > +     } else
> > +             addr_str_list =3D global_addr_strs;
> >
> > -             passphrase =3D l_settings_get_string(settings, "Security",
> > -                                                     "Passphrase");
> > -             if (passphrase) {
> > -                     if (strlen(passphrase) > 63) {
> > -                             l_error("[Security].Passphrase must not e=
xceed "
> > -                                             "63 characters");
> > -                             l_free(passphrase);
> > -                             goto cleanup;
> > +     if (addr_str_list) {
> > +             int r;
> > +
> > +             if (netmask_str) {
> > +                     uint32_t netmask;
> > +
> > +                     if (inet_pton(AF_INET, netmask_str, &if_netmask) =
< 0) {
> > +                             l_error("Can't parse the profile "
> > +                                     "[IPv4].Netmask setting");
> > +                             goto done;
> >                       }
> >
> > -                     strcpy(ap->config->passphrase, passphrase);
> > -                     l_free(passphrase);
> > -             }
> > +                     netmask =3D if_netmask.s_addr;
> > +                     prefix =3D __builtin_popcountl(netmask);
> > +                     if ((ntohl(netmask) !=3D
> > +                                     util_netmask_from_prefix(prefix))=
) {
> > +                             l_error("Invalid netmask %s", netmask_str=
);
> > +                             goto done;
> > +                     }
> >
> > -             if (!l_settings_has_group(settings, "IPv4")) {
> > -                     *wait_dhcp =3D false;
> > -                     err =3D 0;
> > -                     goto cleanup;
> > +                     if (prefix > 30 || prefix < 8) {
> > +                             l_error("Netmasks between 8 and 30 bits "
> > +                                     "are allowed");
> > +                             goto done;
> > +                     }
> > +             } else
> > +                     prefix =3D AP_DEFAULT_IPV4_PREFIX_LEN;
> > +
> > +             r =3D ap_select_addr((const char **) addr_str_list, prefi=
x,
> > +                                     netdev_get_name(ap->netdev), &add=
ress);
> > +             if (r < 0) {
> > +                     ret =3D r;
> > +                     goto done;
> >               }
> > +     } else {
> > +             address =3D existing_address;
> > +             prefix =3D existing_prefix;
> > +     }
> > +
> > +     if_addr.s_addr =3D htonl(address);
> > +     if (!l_dhcp_server_set_ip_address(ap->server, inet_ntoa(if_addr))=
) {
> > +             l_error("l_dhcp_server_set_ip_address failed");
> > +             goto done;
> > +     }
> > +
> > +     if_netmask.s_addr =3D htonl(util_netmask_from_prefix(prefix));
> > +     if (!l_dhcp_server_set_netmask(ap->server, inet_ntoa(if_netmask))=
) {
> > +             l_error("l_dhcp_server_set_netmask failed");
> > +             goto done;
> >       }
> >
> > -     err =3D ap_setup_dhcp(ap, settings);
> > +     /* Set the remaining DHCP options in config file */
> > +     if (ap->profile && !ap_load_dhcp_settings(ap, address, prefix))
> > +             goto done;
> > +
> > +     ap->own_ip =3D l_strdup(inet_ntoa(if_addr));
> > +     ap->ip_prefix =3D prefix;
> > +     ret =3D (address =3D=3D existing_address && prefix =3D=3D existin=
g_prefix) ?
> > +             -EALREADY : 0;
> > +
> > +done:
> > +     if (addr_str_list !=3D global_addr_strs)
> > +             l_strv_free(addr_str_list);
> > +
> > +     return ret;
> > +}
> > +
> > +static void ap_netconfig_start(struct ap_state *ap, uint32_t existing_=
addr,
> > +                             uint8_t existing_prefix)
> > +{
> > +     uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
> > +     int err;
> > +
> > +     err =3D ap_setup_dhcp(ap, existing_addr, existing_prefix);
> >       if (err =3D=3D 0) {
> >               /* Address change required */
> >               ap->rtnl_add_cmd =3D l_rtnl_ifaddr4_add(rtnl, ifindex,
> >                                       ap->ip_prefix, ap->own_ip,
> >                                       broadcast_from_ip(ap->own_ip),
> >                                       ap_ifaddr4_added_cb, ap, NULL);
> > -
> > -             if (!ap->rtnl_add_cmd) {
> > -                     l_error("Failed to add IPv4 address");
> > -                     err =3D -EIO;
> > -                     goto cleanup;
> > +             if (ap->rtnl_add_cmd) {
> > +                     ap->cleanup_ip =3D true;
> > +                     return;
> >               }
>
> So we decided not to remove any existing addresses?

I didn't decide it ;-) but I think it's safe to not remove them if
we're lazy.  You said:

21:51 <@denkenz_> add something like l_rtnl_ifaddr_flush
21:53 <@denkenz_> or simply assign multiple addresses, that works too

So you seemed to be ok with this, in any case it's orthogonal to this patch=
set.

>
> >
> > -             ap->cleanup_ip =3D true;
> > -
> > -             *wait_dhcp =3D true;
> > -             err =3D 0;
> > +             l_error("Failed to add IPv4 address");
> >       /* Selected address already set, continue normally */
> >       } else if (err =3D=3D -EALREADY) {
> > -             *wait_dhcp =3D false;
> > -             err =3D 0;
> > +             if (ap_start_send(ap))
> > +                     return;
> >       }
> >
> > -cleanup:
> > -     l_settings_free(settings);
> > -     return err;
> > +     ap_start_failed(ap);
> > +}
> > +
> > +static void ap_ifaddr4_dump_cb(int error,
> > +                             uint16_t type, const void *data,
> > +                             uint32_t len, void *user_data)
> > +{
> > +     struct ap_state *ap =3D user_data;
> > +     const struct ifaddrmsg *ifa =3D data;
> > +     char *ip_str =3D NULL;
> > +     struct in_addr ip =3D {};
> > +     uint8_t prefix =3D 0;
> > +     uint32_t cmd;
> > +
> > +     if (!error && ifa->ifa_index !=3D netdev_get_ifindex(ap->netdev))
> > +             return;
> > +
> > +     if (error || type !=3D RTM_NEWADDR ||
> > +                     ifa->ifa_prefixlen > 30 || ifa->ifa_prefixlen < 1=
) {
> > +             l_error("Error getting existing IPv4 address on AP iface"=
);
> > +             goto done;
> > +     }
> > +
> > +     l_rtnl_ifaddr4_extract(ifa, len, NULL, &ip_str, NULL);
>
> So FYI, this API is slated for the chopping block now that we have
> l_rtnl_address object.  I just haven't gotten around to it yet.
>
> > +     inet_aton(ip_str, &ip);
> > +     l_free(ip_str);
> > +     prefix =3D ifa->ifa_prefixlen;
> > +
> > +done:
> > +     cmd =3D ap->rtnl_dump_cmd;
> > +     ap->rtnl_dump_cmd =3D 0;
> > +     l_netlink_cancel(rtnl, cmd);
> > +
> > +     ap_netconfig_start(ap, ntohl(ip.s_addr), prefix);
> > +}
> > +
> > +static void ap_ifaddr4_dump_destroy_cb(void *user_data)
> > +{
> > +     struct ap_state *ap =3D user_data;
> > +
> > +     if (!ap->rtnl_dump_cmd)
> > +             return;
> > +
> > +     ap->rtnl_dump_cmd =3D 0;
> > +     l_debug("No existing IPv4 addresses on AP iface");
> > +     ap_netconfig_start(ap, 0, 0);
> >   }
> >
> >   /*
> > @@ -2639,13 +2815,10 @@ struct ap_state *ap_start(struct netdev *netdev=
, struct ap_config *config,
> >   {
> >       struct ap_state *ap;
> >       struct wiphy *wiphy =3D netdev_get_wiphy(netdev);
> > -     struct l_genl_msg *cmd;
> >       uint64_t wdev_id =3D netdev_get_wdev_id(netdev);
> > -     int err =3D -EINVAL;
> > -     bool wait_on_address =3D false;
> >
> >       if (err_out)
> > -             *err_out =3D err;
> > +             *err_out =3D -EINVAL;
> >
> >       if (L_WARN_ON(!config->ssid))
> >               return NULL;
> > @@ -2661,15 +2834,33 @@ struct ap_state *ap_start(struct netdev *netdev=
, struct ap_config *config,
> >       ap->ops =3D ops;
> >       ap->user_data =3D user_data;
> >
> > -     /*
> > -      * This both loads a profile if required and loads DHCP settings =
either
> > -      * by the profile itself or the IP pool (or does nothing in the c=
ase
> > -      * of a profile-less configuration). wait_on_address will be set =
true
> > -      * if an address change is required.
> > -      */
> > -     err =3D ap_load_profile_and_dhcp(ap, &wait_on_address);
> > -     if (err < 0)
> > -             goto error;
> > +     if (ap->config->profile) {
> > +             char *passphrase;
> > +
> > +             ap->profile =3D l_settings_new();
> > +
> > +             if (!l_settings_load_from_file(ap->profile, ap->config->p=
rofile))
> > +                     goto error;
> > +
> > +             passphrase =3D l_settings_get_string(ap->profile, "Securi=
ty",
> > +                                                     "Passphrase");
> > +             if (!passphrase) {
> > +                     l_error("[Security].Passphrase not found in "
> > +                             "AP profile");
> > +                     goto error;
> > +             }
> > +
> > +             /* (full checks done later in crypto_passphrase_is_valid)=
 */
> > +             if (strlen(passphrase) > 63) {
> > +                     l_error("[Security].Passphrase must not exceed "
> > +                             "63 characters");
> > +                     l_free(passphrase);
> > +                     goto error;
> > +             }
> > +
> > +             strcpy(ap->config->passphrase, passphrase);
> > +             l_free(passphrase);
> > +     }
> >
> >       if (!config->channel)
> >               /* TODO: Start a Get Survey to decide the channel */
> > @@ -2752,33 +2943,31 @@ struct ap_state *ap_start(struct netdev *netdev=
, struct ap_config *config,
> >       if (!ap->mlme_watch)
> >               l_error("Registering for MLME notification failed");
> >
> > -     if (wait_on_address) {
> > -             if (err_out)
> > -                     *err_out =3D 0;
> > +     if (netconfig_enabled &&
> > +                     (!ap->profile ||
> > +                      l_settings_has_group(ap->profile, "IPv4"))) {
>
> It seems to me the logic should go something like this:
>
> 1. Load the profile
> 2. If the profile contains a single address / subnet, go to step 6

So the current logic retrieves the current address anyway just to
check if it's the same as the one we want to set, I think it doesn't
harm to do this and the only difference is steps 2 and 3 are reversed.

> 3. Issue ifaddr4_dump and record any used ranges
> 4. If an address is set on the interface and IPv4.Address isn't set, pick=
 one
> (non secondary address), doesn't matter which one and use it as the DHCP
> address.  Goto step 7.
> 5. Pick an address from the pool taking into account used ranges found in=
 step 3.
> 6. Set the address picked in step 2, or step 5
> 7. Start DHCP & AP

Best regards
--===============4436841983437065681==--

