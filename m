Content-Type: multipart/mixed; boundary="===============5162586517613594968=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/9] netconfig: Move loading settings to new method,
 refactor
Date: Wed, 25 Aug 2021 08:50:56 -0500
Message-ID: <6b81dfe5-686e-5ad7-762a-1133d85a7de5@gmail.com>
In-Reply-To: <20210823141430.223543-7-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5162586517613594968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 8/23/21 9:14 AM, Andrew Zaborowski wrote:
> Split loading settings out of network_configure into a new method,
> network_load_settings.  Make sure both consistently handle errors by
> printing messages and informing the caller.
> ---
>   src/netconfig.c | 157 +++++++++++++++++++++++++++++++-----------------
>   src/netconfig.h |   5 +-
>   src/p2p.c       |  12 +++-
>   src/station.c   |  20 +++---
>   4 files changed, 127 insertions(+), 67 deletions(-)
> =


   CC       src/netconfig.o
src/netconfig.c: In function =E2=80=98netconfig_get_static4_address=E2=80=
=99:
src/netconfig.c:298:5: error: implicit declaration of function =

=E2=80=98util_netmask_from_prefix=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
   298 |     util_netmask_from_prefix(prefix_len)) {
       |     ^~~~~~~~~~~~~~~~~~~~~~~~
src/netconfig.c:297:29: error: comparison of integer expressions of differe=
nt =

signedness: =E2=80=98__uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=
=99} and =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
   297 |   if (ntohl(in_addr.s_addr) !=3D
       |                             ^~
cc1: all warnings being treated as errors

<snip>

> @@ -998,22 +997,22 @@ static int validate_dns_list(int family, char **dns=
_list)
>   	return n_valid;
>   }
>   =

> -bool netconfig_configure(struct netconfig *netconfig,
> +bool netconfig_load_settings(struct netconfig *netconfig,
>   				const struct l_settings *active_settings,
> -				const uint8_t *mac_address,
> -				netconfig_notify_func_t notify, void *user_data)
> +				const uint8_t *mac_address)
>   {
>   	char *mdns;
> -	char hostname[HOST_NAME_MAX + 1];
>   	bool send_hostname;
> +	bool enabled;
>   =

> +	l_strfreev(netconfig->dns4_overrides);

? shouldn't this be taken care of by netconfig_reset?  We generally don't l=
ike =

side-effects in our APIs.

>   	netconfig->dns4_overrides =3D l_settings_get_string_list(active_settin=
gs,
>   							"IPv4", "DNS", ' ');
>   =

>   	if (netconfig->dns4_overrides) {
>   		int r =3D validate_dns_list(AF_INET, netconfig->dns4_overrides);
>   =

> -		if (r <=3D 0) {
> +		if (unlikely(r <=3D 0)) {
>   			l_strfreev(netconfig->dns4_overrides);
>   			netconfig->dns4_overrides =3D NULL;
>   		}
> @@ -1022,13 +1021,14 @@ bool netconfig_configure(struct netconfig *netcon=
fig,
>   			l_error("netconfig: Empty IPv4.DNS entry, skipping...");
>   	}
>   =

> +	l_strfreev(netconfig->dns6_overrides);

Same here?

>   	netconfig->dns6_overrides =3D l_settings_get_string_list(active_settin=
gs,
>   							"IPv6", "DNS", ' ');
>   =

>   	if (netconfig->dns6_overrides) {
>   		int r =3D validate_dns_list(AF_INET6, netconfig->dns6_overrides);
>   =

> -		if (r <=3D 0) {
> +		if (unlikely(r <=3D 0)) {
>   			l_strfreev(netconfig->dns6_overrides);
>   			netconfig->dns6_overrides =3D NULL;
>   		}
> @@ -1038,8 +1038,6 @@ bool netconfig_configure(struct netconfig *netconfi=
g,
>   	}
>   =

>   	netconfig->active_settings =3D active_settings;

Do we even need active settings now?

> -	netconfig->notify =3D notify;
> -	netconfig->user_data =3D user_data;
>   =

>   	l_dhcp_client_set_address(netconfig->dhcp_client, ARPHRD_ETHER,
>   							mac_address, ETH_ALEN);

Regards,
-Denis
--===============5162586517613594968==--

