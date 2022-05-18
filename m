Content-Type: multipart/mixed; boundary="===============1631370328694112005=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel at holtmann.org>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 1/2] netconfig: Add multiple levels to IWD_DHCP_DEBUG
Date: Wed, 18 May 2022 16:48:23 +0200
Message-ID: <0886D7EE-6F64-4B79-A752-980FEA0752B4@holtmann.org>
In-Reply-To: 20220518143915.105007-1-mjohnson459@gmail.com

--===============1631370328694112005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

> Allows granularly specifying the DHCP logging level. This allows the
> user to tailor the output to what they need. By default, always display
> info, errors and warnings to match the rest of iwd.
> =

> Setting `IWD_DHCP_DEBUG` to "debug", "info", "warn", "error" will limit
> the logging to that level or higher allowing the default logging
> verbosity to be reduced.
> =

> Setting `IWD_DHCP_DEBUG` to "1" as per the current behavior will
> continue to enable debug level logging.
> ---
> src/netconfig.c | 21 ++++++++++++++++++---
> 1 file changed, 18 insertions(+), 3 deletions(-)
> =

> diff --git a/src/netconfig.c b/src/netconfig.c
> index 6694a0e9..0042a55d 100644
> --- a/src/netconfig.c
> +++ b/src/netconfig.c
> @@ -1621,6 +1621,8 @@ struct netconfig *netconfig_new(uint32_t ifindex)
> 	struct netdev *netdev =3D netdev_find(ifindex);
> 	struct netconfig *netconfig;
> 	struct l_icmp6_client *icmp6;
> +	const char *debug_level =3D NULL;
> +	int dhcp_priority =3D L_LOG_INFO;
> =

> 	if (!netconfig_list)
> 		return NULL;
> @@ -1640,9 +1642,22 @@ struct netconfig *netconfig_new(uint32_t ifindex)
> 					netconfig_ipv4_dhcp_event_handler,
> 					netconfig, NULL);
> =

> -	if (getenv("IWD_DHCP_DEBUG"))
> -		l_dhcp_client_set_debug(netconfig->dhcp_client, do_debug,
> -							"[DHCPv4] ", NULL);
> +	debug_level =3D getenv("IWD_DHCP_DEBUG");
> +	if (debug_level !=3D NULL) {
> +		if (strcmp("debug", debug_level) =3D=3D 0)
> +			dhcp_priority =3D L_LOG_DEBUG;
> +		else if (strcmp("info", debug_level) =3D=3D 0)
> +			dhcp_priority =3D L_LOG_INFO;
> +		else if (strcmp("warn", debug_level) =3D=3D 0)
> +			dhcp_priority =3D L_LOG_WARNING;
> +		else if (strcmp("error", debug_level) =3D=3D 0)
> +			dhcp_priority =3D L_LOG_ERR;
> +		else 	/* Default for backwards compatibility */
> +			dhcp_priority =3D L_LOG_DEBUG;
> +	}
> +
> +	l_dhcp_client_set_debug(netconfig->dhcp_client, do_debug,
> +					"[DHCPv4] ", NULL, dhcp_priority);

please don=E2=80=99t always set l_dhcp_client_set_debug. It should not be s=
et. And I don=E2=80=99t like the dhcp_priority parameter at all. That is ju=
st convoluted code and there is no precedence with any _set_debug() APIs.

Regards

Marcel

--===============1631370328694112005==--

