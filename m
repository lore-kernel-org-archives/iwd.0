Content-Type: multipart/mixed; boundary="===============6687105476940204696=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/9] ap: Track IPv4 addresses in use
Date: Sat, 15 May 2021 00:16:50 +0200
Message-ID: <CAOq732LRhXC_7bCJd4K4PHGWSYwvBL97ZeRScsVU-=cujavw7g@mail.gmail.com>
In-Reply-To: <236dfc54-2984-31f4-38a7-5faedf95afc5@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6687105476940204696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 14 May 2021 at 17:26, Denis Kenzior <denkenz@gmail.com> wrote:
> On 5/13/21 1:47 PM, Andrew Zaborowski wrote:
> > Add the ap_addr submodule that tracks IPv4 addresses in use on the
> > system for use when selecting the address for a new AP.
> > ---
> >   Makefile.am   |   3 +-
> >   src/ap-addr.c | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >   src/ap.h      |   9 +++
> >   3 files changed, 177 insertions(+), 1 deletion(-)
> >   create mode 100644 src/ap-addr.c
>
> Can we name it ippool or ipv4pool?

Ok, I assume without the ap prefix either.

I'll go for ippool so we don't have to create a new file if we want to
add IPv6 versions.

>
> > diff --git a/src/ap-addr.c b/src/ap-addr.c
> > new file mode 100644
> > index 00000000..238cc7b5
> > --- /dev/null
> > +++ b/src/ap-addr.c
> > @@ -0,0 +1,166 @@
> > +/*
> > + *
> > + *  Wireless daemon for Linux
> > + *
> > + *  Copyright (C) 2021  Intel Corporation. All rights reserved.
> > + *
> > + *  This library is free software; you can redistribute it and/or
> > + *  modify it under the terms of the GNU Lesser General Public
> > + *  License as published by the Free Software Foundation; either
> > + *  version 2.1 of the License, or (at your option) any later version.
> > + *
> > + *  This library is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + *  Lesser General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU Lesser General Public
> > + *  License along with this library; if not, write to the Free Software
> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1=
301  USA
> > + *
> > + */
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +
> > +#include <errno.h>
> > +#include <netinet/in.h>
> > +#include <arpa/inet.h>
> > +
> > +#include <ell/ell.h>
> > +
> > +#include "src/util.h"
> > +#include "src/iwd.h"
> > +#include "src/module.h"
> > +#include "src/netdev.h"
>
> Why does it need netdev or mpdu?

Both were required for ap.h.  I guess it's better to get around it by
adding the missing declarations to ap.h itself, will do that.

>
> > +#include "src/mpdu.h"
> > +#include "src/ap.h"
>
> Or ap?

Because we define the non-static functions exported by ap-addr.c in
ap.h.  If we're renaming it ippool.c, then ap.h isn't going to be
needed.

>
> > +
> > +static struct l_queue *used_addr4_list;
> > +static struct l_netlink *rtnl;
> > +
> > +static bool ap_rtnl_addr4_match_ifindex(const void *a, const void *b)
> > +{
> > +     const struct ap_rtnl_addr4_record *addr =3D a;
> > +
> > +     return addr->ifindex =3D=3D L_PTR_TO_UINT(b) && !addr->secondary;
> > +}
> > +
> > +const struct ap_rtnl_addr4_record *ap_get_addr4(struct netdev *netdev)
>
> I would think looking up by ifindex would be just as good?

Yep, that's what the previous versions did but since we more often
manage netdevs it made for a nicer API to receive the netdev.

>
> > +{
> > +     uint32_t ifindex =3D netdev ? netdev_get_ifindex(netdev) : 0;
>
> ?? 0 ?

Yep.  No netdev --> not excluding any addresses from the conflict
checks based on the target interface.

>
> > +
> > +     return l_queue_find(used_addr4_list, ap_rtnl_addr4_match_ifindex,
> > +                             L_UINT_TO_PTR(ifindex));
> > +}
> > +
> > +static bool ap_rtnl_addr4_match_free(void *data, void *user_data)
> > +{
> > +     const struct ap_rtnl_addr4_record *a =3D data;
> > +     const struct ap_rtnl_addr4_record *b =3D user_data;
> > +
> > +     if (a->ifindex !=3D b->ifindex || a->addr !=3D b->addr ||
> > +                     a->prefix_len !=3D b->prefix_len)
> > +             return false;
> > +
> > +     l_free(data);
> > +     return true;
> > +}
> > +
> > +static void ap_addr_notify(uint16_t type, const void *data, uint32_t l=
en,
> > +                             void *user_data)
> > +{
> > +     const struct ifaddrmsg *ifa =3D data;
> > +     char *ip_str =3D NULL;
> > +     int r;
> > +     struct in_addr ip;
> > +
> > +     if (ifa->ifa_family !=3D AF_INET || ifa->ifa_prefixlen < 1)
> > +             return;
> > +
> > +     len -=3D NLMSG_ALIGN(sizeof(struct ifaddrmsg));
> > +
> > +     l_rtnl_ifaddr4_extract(ifa, len, NULL, &ip_str, NULL);
> > +     if (!ip_str)
> > +             return;
> > +
> > +     r =3D inet_aton(ip_str, &ip);
> > +     l_free(ip_str);
> > +
> > +     if (r < 0)
> > +             return;
> > +
> > +     if (type =3D=3D RTM_NEWADDR) {
> > +             struct ap_rtnl_addr4_record *addr;
> > +
> > +             addr =3D l_new(struct ap_rtnl_addr4_record, 1);
> > +             addr->addr =3D ntohl(ip.s_addr);
> > +             addr->prefix_len =3D ifa->ifa_prefixlen;
> > +             addr->ifindex =3D ifa->ifa_index;
> > +             addr->secondary =3D !!(ifa->ifa_flags & IFA_F_SECONDARY);
>
> so why is l_rtnl_address not good enough?

1. Seems this is internal to ell/rtnl.c, 2. stores way more
information than we need and sort-of implies network byte order which
I didn't want to have to deal with (reduces readability too).

>
> > +
> > +             if (!used_addr4_list)
> > +                     used_addr4_list =3D l_queue_new();
>
> I don't think lazy initialization makes any sense in this case.  Just mov=
e it to
> the init function.

Ok, good point.

>
> > +
> > +             l_queue_push_tail(used_addr4_list, addr);
> > +     } else if (type =3D=3D RTM_DELADDR) {
> > +             struct ap_rtnl_addr4_record addr;
> > +
> > +             addr.addr =3D ntohl(ip.s_addr);
> > +             addr.prefix_len =3D ifa->ifa_prefixlen;
> > +             addr.ifindex =3D ifa->ifa_index;
> > +
> > +             l_queue_foreach_remove(used_addr4_list,
> > +                                     ap_rtnl_addr4_match_free, &addr);
> > +     }
> > +}
> > +
> > +static void ap_addr4_dump_cb(int error,
> > +                             uint16_t type, const void *data,
> > +                             uint32_t len, void *user_data)
> > +{
> > +     if (error) {
> > +             l_error("addr4_dump_cb: %s (%i)", strerror(-error), -erro=
r);
> > +             return;
> > +     }
> > +
> > +     ap_addr_notify(type, data, len, user_data);
> > +}
> > +
> > +static int ap_addr_init(void)
> > +{
> > +     const struct l_settings *settings =3D iwd_get_config();
> > +     bool netconfig_enabled;
> > +
> > +     if (!l_settings_get_bool(settings, "General",
> > +                             "EnableNetworkConfiguration",
> > +                             &netconfig_enabled))
> > +             netconfig_enabled =3D false;
> > +
> > +     if (!netconfig_enabled)
> > +             return 0;
> > +
> > +     rtnl =3D iwd_get_rtnl();
> > +
> > +     if (!l_netlink_register(rtnl, RTNLGRP_IPV4_IFADDR,
> > +                             ap_addr_notify, NULL, NULL)) {
> > +             l_error("Failed to register for RTNL link notifications");
> > +             return -EIO;
> > +     }
> > +
> > +     if (!l_rtnl_ifaddr4_dump(rtnl, ap_addr4_dump_cb, NULL, NULL)) {
> > +             l_error("Sending the IPv4 addr dump req failed");
> > +             return -EIO;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void ap_addr_exit(void)
> > +{
> > +     l_queue_destroy(used_addr4_list, l_free);
> > +     used_addr4_list =3D NULL;
> > +}
> > +
> > +IWD_MODULE(ap_addr, ap_addr_init, ap_addr_exit)
> > diff --git a/src/ap.h b/src/ap.h
> > index b0100f34..12baca8b 100644
> > --- a/src/ap.h
> > +++ b/src/ap.h
> > @@ -97,3 +97,12 @@ bool ap_station_disconnect(struct ap_state *ap, cons=
t uint8_t *mac,
> >
> >   bool ap_push_button(struct ap_state *ap);
> >   void ap_update_beacon(struct ap_state *ap);
> > +
> > +struct ap_rtnl_addr4_record {
> > +     uint32_t addr;
> > +     uint8_t prefix_len;
> > +     uint32_t ifindex;
> > +     bool secondary;
> > +};
> > +
> > +const struct ap_rtnl_addr4_record *ap_get_addr4(struct netdev *netdev);
> >
>
> Regards,
> -Denis
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
--===============6687105476940204696==--

