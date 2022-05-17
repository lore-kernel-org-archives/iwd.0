Content-Type: multipart/mixed; boundary="===============3100187884104494859=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 1/2] netconfig: Add multiple levels to IWD_DHCP_DEBUG
Date: Tue, 17 May 2022 13:09:02 -0500
Message-ID: <04786874-f47b-aaa8-f3f3-1492fd268b01@gmail.com>
In-Reply-To: 20220517171642.147923-1-mjohnson459@gmail.com

--===============3100187884104494859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 5/17/22 12:16, Michael Johnson wrote:
> Allows granularly specifying the DHCP logging level. This allows the
> user to tailor the output to what they need. By default always display
> errors and warnings.
> =

> 1 =3D INFO
> 2 =3D DEBUG
> ---
>   src/netconfig.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> =

> diff --git a/src/netconfig.c b/src/netconfig.c
> index 6694a0e9..da9969f2 100644
> --- a/src/netconfig.c
> +++ b/src/netconfig.c
> @@ -1621,6 +1621,8 @@ struct netconfig *netconfig_new(uint32_t ifindex)
>   	struct netdev *netdev =3D netdev_find(ifindex);
>   	struct netconfig *netconfig;
>   	struct l_icmp6_client *icmp6;
> +	const char *debug_level =3D NULL;
> +	int dhcp_priority =3D L_LOG_WARNING;
>   =

>   	if (!netconfig_list)
>   		return NULL;
> @@ -1640,9 +1642,18 @@ struct netconfig *netconfig_new(uint32_t ifindex)
>   					netconfig_ipv4_dhcp_event_handler,
>   					netconfig, NULL);
>   =

> -	if (getenv("IWD_DHCP_DEBUG"))
> -		l_dhcp_client_set_debug(netconfig->dhcp_client, do_debug,
> -							"[DHCPv4] ", NULL);
> +	debug_level =3D getenv("IWD_DHCP_DEBUG");
> +	if (debug_level !=3D NULL)
> +	{
> +		// Convert from user 1 or 2 to L_LOG_*

Actually, that's not our coding style.  We use Linux Kernel style, so it wo=
uld be:

if (debug_level !=3D NULL) {

and no C++ comments please.

> +		if (*debug_level =3D=3D '1')
> +			dhcp_priority =3D L_LOG_INFO;
> +		else if (*debug_level =3D=3D '2')
> +			dhcp_priority =3D L_LOG_DEBUG;
> +	}
> +

This changes the semantics slightly.  In our wiki, etc we show IWD_DHCP_DEB=
UG =

with value "1" to enable debugging, so I think we should be nice and keep t=
hat =

behavior if possible.  How about:

if IWD_DHCP_DEBUG is not set, use L_LOG_WARNING.

If IWD_DHCP_DEBUG is set and has a non-NULL value, use L_LOG_DEBUG

If the value above is from the set L_LOG_ERR .. L_LOG_DEBUG (3 .. 7), then =
use that.

> +	l_dhcp_client_set_debug(netconfig->dhcp_client, do_debug,
> +					"[DHCPv4] ", NULL, dhcp_priority);
>   =

>   	netconfig->dhcp6_client =3D l_dhcp6_client_new(ifindex);
>   	l_dhcp6_client_set_event_handler(netconfig->dhcp6_client,
> =


Regards,
-Denis
--===============3100187884104494859==--

