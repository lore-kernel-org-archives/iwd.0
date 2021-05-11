Content-Type: multipart/mixed; boundary="===============7865667107224657496=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 02/11] ap: Refactor DHCP settings loading
Date: Tue, 11 May 2021 09:56:11 -0500
Message-ID: <1119226d-84c5-0670-b225-091c9395fba8@gmail.com>
In-Reply-To: <20210510085806.174213-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7865667107224657496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/10/21 3:57 AM, Andrew Zaborowski wrote:
> Extend the [IPv4].Address setting's syntax to allow a new format: a list
> of <IP>/<prefix_len> -form strings that define the address space from
> which a subnet is selected.
> =

> Rewrite the DHCP settings loading without selecting a specific subnet at
> this stage because we will need to query the addresses already in use
> before this.  Validate some of the settings more thoroughly.  Name all
> netconfig-related ap_state members with the netconfig_ prefix.
> =

> Make sure we always call l_dhcp_server_set_netmask(), allow netmasks
> other than 24-bit and change the default to 28 bits.
> ---
>   src/ap.c | 346 ++++++++++++++++++++++++++-----------------------------
>   1 file changed, 165 insertions(+), 181 deletions(-)
> =


<snip>

> @@ -2490,182 +2479,185 @@ static void ap_mlme_notify(struct l_genl_msg *m=
sg, void *user_data)
>   	}
>   }
>   =

> -static bool dhcp_load_settings(struct ap_state *ap,
> -				const struct l_settings *settings)
> +#define AP_DEFAULT_IPV4_PREFIX_LEN 28
> +
> +static int ap_load_ipv4(struct ap_state *ap,
> +				const struct l_settings *config)
>   {
> -	struct l_dhcp_server *server =3D ap->server;
> +	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
> +	uint32_t static_addr4 =3D 0;
>   	struct in_addr ia;
>   =

> -	L_AUTO_FREE_VAR(char *, netmask) =3D l_settings_get_string(settings,
> -							"IPv4", "Netmask");
> -	L_AUTO_FREE_VAR(char *, gateway) =3D l_settings_get_string(settings,
> -							"IPv4", "Gateway");
> -	char **dns =3D l_settings_get_string_list(settings, "IPv4",
> -							"DNSList", ',');
> -	char **ip_range =3D l_settings_get_string_list(settings, "IPv4",
> -							"IPRange", ',');
> -	unsigned int lease_time;
> -	bool ret =3D false;
> -
> -	if (!l_settings_get_uint(settings, "IPv4", "LeaseTime", &lease_time))
> -		lease_time =3D 0;
> -
> -	if (gateway && !l_dhcp_server_set_gateway(server, gateway)) {
> -		l_error("[IPv4].Gateway value error");
> -		goto error;
> -	}
> +	if (!l_settings_has_group(config, "IPv4") || !pool.used)
> +		return 0;
>   =

> -	if (dns && !l_dhcp_server_set_dns(server, dns)) {
> -		l_error("[IPv4].DNSList value error");
> -		goto error;
> -	}
> +	ap->enable_netconfig4 =3D true;
>   =

> -	if (netmask && !l_dhcp_server_set_netmask(server, netmask)) {
> -		l_error("[IPv4].Netmask value error");
> -		goto error;
> -	}
> +	if (l_settings_has_key(config, "IPv4", "Netmask")) {
> +		L_AUTO_FREE_VAR(char *, netmask_str) =3D
> +			l_settings_get_string(config, "IPv4", "Netmask");
>   =

> -	if (ip_range) {
> -		if (l_strv_length(ip_range) !=3D 2) {
> -			l_error("Two addresses expected in [IPv4].IPRange");
> -			goto error;
> +		if (inet_pton(AF_INET, netmask_str, &ia) !=3D 1) {
> +			l_error("Can't parse the profile [IPv4].Netmask "
> +				"setting");
> +			return -EINVAL;
>   		}
>   =

> -		if (!l_dhcp_server_set_ip_range(server, ip_range[0],
> -							ip_range[1])) {
> -			l_error("Error setting IP range from [IPv4].IPRange");
> -			goto error;
> +		ap->netconfig_prefix_len4 =3D __builtin_popcount(ia.s_addr);
> +
> +		if (ntohl(ia.s_addr) !=3D util_netmask_from_prefix(
> +						ap->netconfig_prefix_len4)) {
> +			l_error("Invalid profile [IPv4].Netmask value");
> +			return -EINVAL;
> +		}
> +	} else
> +		ap->netconfig_prefix_len4 =3D AP_DEFAULT_IPV4_PREFIX_LEN;
> +
> +	if (l_settings_has_key(config, "IPv4", "Address")) {
> +		char **str_list =3D l_settings_get_string_list(config, "IPv4",
> +								"Address", ',');
> +
> +		if (!str_list || !*str_list) {
> +			l_error("Can't parse the profile [IPv4].Address "
> +				"setting as a string list");
> +			l_free(str_list);
> +			return -EINVAL;
>   		}
> +
> +		ap->netconfig_addr4_str_list =3D str_list;

So you assign str_list here...

> +
> +		/* Check for the static IP syntax: Address=3D<IP> */
> +		if (l_strv_length(str_list) =3D=3D 1 &&
> +				inet_pton(AF_INET, *str_list, &ia) =3D=3D 1)
> +			static_addr4 =3D ntohl(ia.s_addr);
>   	}
>   =

> -	if (lease_time && !l_dhcp_server_set_lease_time(server, lease_time)) {
> -		l_error("[IPv4].LeaseTime value error");
> -		goto error;
> +	ap->netconfig_dhcp =3D l_dhcp_server_new(ifindex);
> +	if (!ap->netconfig_dhcp) {
> +		l_error("Failed to create DHCP server on ifindex %u", ifindex);
> +		return -EINVAL;

But then it seems it is never freed?  I think in the end ap_reset does end =
up =

being called (several levels up), but I'd really prefer if we didn't side-e=
ffect =

things on error to make such error cases easier to maintain / review.

>   	}
>   =

> -	if (netmask && inet_pton(AF_INET, netmask, &ia) > 0)
> -		ap->ip_prefix =3D __builtin_popcountl(ia.s_addr);
> -	else
> -		ap->ip_prefix =3D 24;
> +	if (getenv("IWD_DHCP_DEBUG"))
> +		l_dhcp_server_set_debug(ap->netconfig_dhcp, do_debug,
> +					"[DHCPv4 SERV] ", NULL);
>   =

> -	ret =3D true;
> +	ia.s_addr =3D htonl(util_netmask_from_prefix(ap->netconfig_prefix_len4)=
);
>   =

> -error:
> -	l_strv_free(dns);
> -	l_strv_free(ip_range);
> -	return ret;
> -}
> +	if (!l_dhcp_server_set_netmask(ap->netconfig_dhcp, inet_ntoa(ia))) {
> +		l_error("l_dhcp_server_set_netmask failed");
> +		return -EINVAL;
> +	}
>   =

> -/*
> - * This will determine the IP being used for DHCP. The IP will be automa=
tically
> - * set to ap->own_ip.
> - *
> - * The address to set (or keep) is determined in this order:
> - * 1. Address defined in provisioning file
> - * 2. Address already set on interface
> - * 3. Address in IP pool.
> - *
> - * Returns:  0 if an IP was successfully selected and needs to be set
> - *          -EALREADY if an IP was already set on the interface or
> - *            IP configuration was not enabled,
> - *          -EEXIST if the IP pool ran out of IP's
> - *          -EINVAL if there was an error.
> - */
> -static int ap_setup_dhcp(struct ap_state *ap, const struct l_settings *s=
ettings)
> -{
> -	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
> -	struct in_addr ia;
> -	uint32_t address =3D 0;
> -	L_AUTO_FREE_VAR(char *, addr) =3D NULL;
> -	int ret =3D -EINVAL;
> +	if (l_settings_has_key(config, "IPv4", "Gateway")) {
> +		L_AUTO_FREE_VAR(char *, gateway_str) =3D
> +			l_settings_get_string(config, "IPv4", "Gateway");
> +
> +		if (!l_dhcp_server_set_gateway(ap->netconfig_dhcp,
> +						gateway_str)) {
> +			l_error("l_dhcp_server_set_gateway failed");
> +			return -EINVAL;
> +		}
> +	}
>   =

> -	/* get the current address if there is one */
> -	if (l_net_get_address(ifindex, &ia) && ia.s_addr !=3D 0)
> -		address =3D ia.s_addr;
> +	if (l_settings_get_value(config, "IPv4", "IPRange")) {
> +		char **ip_range =3D l_settings_get_string_list(config, "IPv4",
> +								"IPRange", ',');
> +		int i;
> +		uint32_t netmask;
> +		bool r;
>   =

> -	addr =3D l_settings_get_string(settings, "IPv4", "Address");
> -	if (addr) {
> -		if (inet_pton(AF_INET, addr, &ia) < 0)
> +		if (!static_addr4 || !l_settings_has_key(config,
> +							"IPv4", "Netmask")) {
> +			l_error("[IPv4].IPRange only makes sense in an AP "
> +				"profile if a static local address and "
> +				"netmask have also been specified");
> +			l_strv_free(ip_range);
>   			return -EINVAL;
> +		}
>   =

> -		/* Is a matching address already set on interface? */
> -		if (ia.s_addr =3D=3D address)
> -			ret =3D -EALREADY;
> -		else
> -			ret =3D 0;
> -	} else if (address) {
> -		/* No address in config, but interface has one set */
> -		addr =3D l_strdup(inet_ntoa(ia));
> -		ret =3D -EALREADY;
> -	} else if (pool.used) {
> -		/* No config file, no address set. Use IP pool */
> -		addr =3D ip_pool_get();
> -		if (!addr) {
> -			l_error("No more IP's in pool, cannot start AP on %u",
> -					ifindex);
> -			return -EEXIST;
> +		if (!ip_range || l_strv_length(ip_range) !=3D 2) {
> +			l_error("Can't parse the profile [IPv4].IPRange "
> +				"setting as two address strings");
> +			l_strv_free(ip_range);
> +			return -EINVAL;
>   		}
>   =

> -		ap->use_ip_pool =3D true;
> -		ap->ip_prefix =3D pool.prefix;
> -		ret =3D 0;
> -	} else
> -		return -EALREADY;
> +		netmask =3D util_netmask_from_prefix(ap->netconfig_prefix_len4);
>   =

> -	ap->server =3D l_dhcp_server_new(ifindex);
> -	if (!ap->server) {
> -		l_error("Failed to create DHCP server on %u", ifindex);
> -		return -EINVAL;
> -	}
> +		for (i =3D 0; i < 2; i++) {
> +			struct in_addr range_addr;
>   =

> -	if (getenv("IWD_DHCP_DEBUG"))
> -		l_dhcp_server_set_debug(ap->server, do_debug,
> -							"[DHCPv4 SERV] ", NULL);
> +			if (inet_aton(ip_range[i], &range_addr) !=3D 1) {
> +				l_error("Can't parse address in "
> +					"[IPv4].IPRange[%i]", i + 1);
> +				break;
> +			}
>   =

> -	/* Set the remaining DHCP options in config file */
> -	if (!dhcp_load_settings(ap, settings))
> -		return -EINVAL;
> +			if ((static_addr4 ^ ntohl(range_addr.s_addr)) &
> +					netmask) {
> +				struct in_addr addr =3D { htonl(static_addr4) };
>   =

> -	if (!l_dhcp_server_set_ip_address(ap->server, addr))
> -		return -EINVAL;
> +				l_error("[IPv4].IPRange[%i] is not in the "
> +					"%s/%i subnet", i + 1, inet_ntoa(addr),
> +					ap->netconfig_prefix_len4);
> +				break;
> +			}
> +		}
>   =

> -	ap->own_ip =3D l_steal_ptr(addr);
> -	return ret;
> -}
> +		if (i < 2) {
> +			l_strv_free(ip_range);
> +			return -EINVAL;
> +		}
>   =

> -static int ap_load_dhcp(struct ap_state *ap, const struct l_settings *co=
nfig,
> -			bool *wait_dhcp)
> -{
> -	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
> -	int err =3D -EINVAL;
> +		r =3D l_dhcp_server_set_ip_range(ap->netconfig_dhcp,
> +						ip_range[0], ip_range[1]);
> +		l_strv_free(ip_range);
>   =

> -	if (!l_settings_has_group(config, "IPv4"))
> -		return 0;
> +		if (!r) {
> +			l_error("l_dhcp_server_set_ip_range failed");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (l_settings_has_key(config, "IPv4", "DNSList")) {
> +		char **str_list =3D l_settings_get_string_list(config, "IPv4",
> +								"DNSList", ',');
> +		bool r;
>   =

> -	err =3D ap_setup_dhcp(ap, config);
> -	if (err =3D=3D 0) {
> -		/* Address change required */
> -		ap->rtnl_add_cmd =3D l_rtnl_ifaddr4_add(rtnl, ifindex,
> -					ap->ip_prefix, ap->own_ip,
> -					broadcast_from_ip(ap->own_ip),
> -					ap_ifaddr4_added_cb, ap, NULL);
> -
> -		if (!ap->rtnl_add_cmd) {
> -			l_error("Failed to add IPv4 address");
> -			return -EIO;
> +		if (!str_list || !*str_list) {
> +			l_error("Can't parse the profile [IPv4].DNSList "
> +				"setting as a string list");
> +			l_free(str_list);
> +			return -EINVAL;
>   		}
>   =

> -		ap->cleanup_ip =3D true;
> +		r =3D l_dhcp_server_set_dns(ap->netconfig_dhcp, str_list);
> +		l_strv_free(str_list);
>   =

> -		*wait_dhcp =3D true;
> -		err =3D 0;
> -	/* Selected address already set, continue normally */
> -	} else if (err =3D=3D -EALREADY) {
> -		*wait_dhcp =3D false;
> -		err =3D 0;
> +		if (!r) {
> +			l_error("l_dhcp_server_set_dns failed");
> +			return -EINVAL;
> +		}
>   	}
>   =

> -	return err;
> +	if (l_settings_has_key(config, "IPv4", "LeaseTime")) {
> +		unsigned int lease_time;
> +
> +		if (!l_settings_get_uint(config, "IPv4", "LeaseTime",
> +						&lease_time)) {
> +			l_error("Error parsing [IPv4].LeaseTime as an integer");
> +			return -EINVAL;
> +		}
> +
> +		if (!l_dhcp_server_set_lease_time(ap->netconfig_dhcp,
> +							lease_time)) {
> +			l_error("l_dhcp_server_set_lease_time failed");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
>   }
>   =

>   static bool ap_load_psk(struct ap_state *ap, const struct l_settings *c=
onfig)

Regards,
-Denis
--===============7865667107224657496==--

