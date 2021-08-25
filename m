Content-Type: multipart/mixed; boundary="===============5602317387652277767=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 7/9] netconfig: Move loading settings to new method,
 refactor
Date: Thu, 26 Aug 2021 00:17:23 +0200
Message-ID: <CAOq732+DLLQqFcEzpJ+hZR1ucCXE8=iMdCU4xCproJhO96eKqw@mail.gmail.com>
In-Reply-To: <6b81dfe5-686e-5ad7-762a-1133d85a7de5@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5602317387652277767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Aug 2021 at 15:53, Denis Kenzior <denkenz@gmail.com> wrote:
> On 8/23/21 9:14 AM, Andrew Zaborowski wrote:
> > Split loading settings out of network_configure into a new method,
> > network_load_settings.  Make sure both consistently handle errors by
> > printing messages and informing the caller.
> > ---
> >   src/netconfig.c | 157 +++++++++++++++++++++++++++++++-----------------
> >   src/netconfig.h |   5 +-
> >   src/p2p.c       |  12 +++-
> >   src/station.c   |  20 +++---
> >   4 files changed, 127 insertions(+), 67 deletions(-)
> >
>
>    CC       src/netconfig.o
> src/netconfig.c: In function =E2=80=98netconfig_get_static4_address=E2=80=
=99:
> src/netconfig.c:298:5: error: implicit declaration of function
> =E2=80=98util_netmask_from_prefix=E2=80=99 [-Werror=3Dimplicit-function-d=
eclaration]
>    298 |     util_netmask_from_prefix(prefix_len)) {
>        |     ^~~~~~~~~~~~~~~~~~~~~~~~
> src/netconfig.c:297:29: error: comparison of integer expressions of diffe=
rent
> signedness: =E2=80=98__uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=
=99} and =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
>    297 |   if (ntohl(in_addr.s_addr) !=3D
>        |                             ^~
> cc1: all warnings being treated as errors

Oops, apparently I added the #include in the wrong commit.

>
> <snip>
>
> > @@ -998,22 +997,22 @@ static int validate_dns_list(int family, char **d=
ns_list)
> >       return n_valid;
> >   }
> >
> > -bool netconfig_configure(struct netconfig *netconfig,
> > +bool netconfig_load_settings(struct netconfig *netconfig,
> >                               const struct l_settings *active_settings,
> > -                             const uint8_t *mac_address,
> > -                             netconfig_notify_func_t notify, void *use=
r_data)
> > +                             const uint8_t *mac_address)
> >   {
> >       char *mdns;
> > -     char hostname[HOST_NAME_MAX + 1];
> >       bool send_hostname;
> > +     bool enabled;
> >
> > +     l_strfreev(netconfig->dns4_overrides);
>
> ? shouldn't this be taken care of by netconfig_reset?

I thought we might have a future use case for calling
netconfig_load_settings() multiple times without netconfig_reset
between, but no strong motivation for that.

>  We generally don't like
> side-effects in our APIs.

I wouldn't call avoiding a leak a side effect ;)

>
> >       netconfig->dns4_overrides =3D l_settings_get_string_list(active_s=
ettings,
> >                                                       "IPv4", "DNS", ' =
');
> >
> >       if (netconfig->dns4_overrides) {
> >               int r =3D validate_dns_list(AF_INET, netconfig->dns4_over=
rides);
> >
> > -             if (r <=3D 0) {
> > +             if (unlikely(r <=3D 0)) {
> >                       l_strfreev(netconfig->dns4_overrides);
> >                       netconfig->dns4_overrides =3D NULL;
> >               }
> > @@ -1022,13 +1021,14 @@ bool netconfig_configure(struct netconfig *netc=
onfig,
> >                       l_error("netconfig: Empty IPv4.DNS entry, skippin=
g...");
> >       }
> >
> > +     l_strfreev(netconfig->dns6_overrides);
>
> Same here?
>
> >       netconfig->dns6_overrides =3D l_settings_get_string_list(active_s=
ettings,
> >                                                       "IPv6", "DNS", ' =
');
> >
> >       if (netconfig->dns6_overrides) {
> >               int r =3D validate_dns_list(AF_INET6, netconfig->dns6_ove=
rrides);
> >
> > -             if (r <=3D 0) {
> > +             if (unlikely(r <=3D 0)) {
> >                       l_strfreev(netconfig->dns6_overrides);
> >                       netconfig->dns6_overrides =3D NULL;
> >               }
> > @@ -1038,8 +1038,6 @@ bool netconfig_configure(struct netconfig *netcon=
fig,
> >       }
> >
> >       netconfig->active_settings =3D active_settings;
>
> Do we even need active settings now?

So in this method I only removed the usage of the l_settings from
netconfig_configure() but not from other places (*_get_gateway(),
netconfig_set_domains()) which may be called asynchronously.  It's
something we could do separately if desired but my use case was only
for setting the value of netconfig->rtm_protocol early.

Best regards
--===============5602317387652277767==--

