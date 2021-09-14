Content-Type: multipart/mixed; boundary="===============0838394079099722876=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 2/2] netconfig: Add IP configuration properties on Station
 and P2P
Date: Tue, 14 Sep 2021 16:54:02 -0500
Message-ID: <8b7683f4-bff8-f46a-7272-fb7c8ad384e4@gmail.com>
In-Reply-To: 20210908214440.358243-2-andrew.zaborowski@intel.com
Message-ID: <20210914215402.uoj9v1_9HHBCgwPbYE9M9Z1PoGRw1g9PUD187mDRjcA@z>

--===============0838394079099722876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/8/21 4:44 PM, Andrew Zaborowski wrote:
> Add the IPv{4,6}Configuration D-Bus interfaces on the station and P2P
> objects that expose current netconfig values.  Access Point and P2P-GO
> are not handled yet, and some of the IP config properties may not
> automatically generate PropertiesChanged on DHCP lease renewals but
> their values are unlikely to change.
> ---
>   src/dbus.h      |   2 +
>   src/netconfig.c | 640 ++++++++++++++++++++++++++++++++++++++++--------
>   src/netconfig.h |   2 +-
>   src/p2p.c       |   4 +-
>   src/station.c   |   8 +-
>   5 files changed, 551 insertions(+), 105 deletions(-)
> =


<snip>

> @@ -152,20 +164,6 @@ static struct netconfig *netconfig_find(uint32_t ifi=
ndex)
>   	return NULL;
>   }
>   =

> -#define APPEND_STRDUPV(dest, index, src)			\
> -	do {							\
> -		char **p;					\
> -		for (p =3D src; p && *p; p++)			\
> -			dest[index++] =3D l_strdup(*p);		\
> -	} while (0)						\
> -
> -#define APPENDV(dest, index, src)				\
> -	do {							\
> -		char **p;					\
> -		for (p =3D src; p && *p; p++)			\
> -			dest[index++] =3D *p;			\
> -	} while (0)						\
> -
>   static inline char *netconfig_ipv4_to_string(uint32_t addr)
>   {
>   	struct in_addr in_addr =3D { .s_addr =3D addr };
> @@ -196,77 +194,108 @@ static inline char *netconfig_ipv6_to_string(const=
 uint8_t *addr)
>   	return addr_str;
>   }
>   =

> -static void netconfig_set_neighbor_entry_cb(int error,
> -						uint16_t type, const void *data,
> -						uint32_t len, void *user_data)
> -{
> -	if (error)
> -		l_error("l_rtnl_neighbor_set_hwaddr failed: %s (%i)",
> -			strerror(-error), error);
> -}
> -
> -static int netconfig_set_dns(struct netconfig *netconfig)
> +static char **netconfig_get_dns_list(struct netconfig *netconfig, int af,
> +					const uint8_t **out_dns_mac)
>   {
> -	char **dns6_list =3D NULL;
> -	char **dns4_list =3D NULL;
> -	unsigned int n_entries =3D 0;
> -	char **dns_list;
> -	const uint8_t *fils_dns4_mac =3D NULL;
> -	const uint8_t *fils_dns6_mac =3D NULL;
>   	const struct ie_fils_ip_addr_response_info *fils =3D
>   		netconfig->fils_override;
>   =

> -	if (!netconfig->dns4_overrides &&
> -			netconfig->rtm_protocol =3D=3D RTPROT_DHCP) {
> +	if (af =3D=3D AF_INET) {
>   		const struct l_dhcp_lease *lease;
>   =

> +		if (netconfig->dns4_overrides)
> +			return l_strv_copy(netconfig->dns4_overrides);
> +
> +		if (netconfig->rtm_protocol !=3D RTPROT_DHCP)
> +			return NULL;
> +
>   		if (fils && fils->ipv4_dns) {
> -			dns4_list =3D l_new(char *, 2);
> -			dns4_list[0] =3D netconfig_ipv4_to_string(fils->ipv4_dns);
> +			char **dns_list =3D l_new(char *, 2);
>   =

>   			if (!l_memeqzero(fils->ipv4_dns_mac, 6) &&
> +					out_dns_mac &&
>   					util_ip_subnet_match(
>   							fils->ipv4_prefix_len,
>   							&fils->ipv4_addr,
>   							&fils->ipv4_dns))
> -				fils_dns4_mac =3D fils->ipv4_dns_mac;
> -		} else if ((lease =3D l_dhcp_client_get_lease(
> -						netconfig->dhcp_client)))
> -			dns4_list =3D l_dhcp_lease_get_dns(lease);
> -	}
> +				*out_dns_mac =3D fils->ipv4_dns_mac;
> +
> +			dns_list[0] =3D netconfig_ipv4_to_string(fils->ipv4_dns);
> +			return dns_list;
> +		}
>   =

> -	if (!netconfig->dns6_overrides &&
> -			netconfig->rtm_v6_protocol =3D=3D RTPROT_DHCP) {
> +		if (!(lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client)))
> +			return NULL;
> +
> +		return l_dhcp_lease_get_dns(lease);
> +	} else {
>   		const struct l_dhcp6_lease *lease;
>   =

> -		if (fils && !l_memeqzero(fils->ipv6_dns,
> -						16)) {
> -			dns6_list =3D l_new(char *, 2);
> -			dns6_list[0] =3D netconfig_ipv6_to_string(fils->ipv6_dns);
> +		if (netconfig->dns6_overrides)
> +			return l_strv_copy(netconfig->dns6_overrides);
> +
> +		if (netconfig->rtm_v6_protocol !=3D RTPROT_DHCP)
> +			return NULL;
> +
> +		if (fils && !l_memeqzero(fils->ipv6_dns, 16)) {
> +			char **dns_list =3D l_new(char *, 2);
>   =

>   			if (!l_memeqzero(fils->ipv6_dns_mac, 6) &&
> +					out_dns_mac &&
>   					util_ip_subnet_match(
>   							fils->ipv6_prefix_len,
>   							fils->ipv6_addr,
>   							fils->ipv6_dns))
> -				fils_dns6_mac =3D fils->ipv6_dns_mac;
> -		} else if ((lease =3D l_dhcp6_client_get_lease(
> +				*out_dns_mac =3D fils->ipv6_dns_mac;
> +
> +			dns_list[0] =3D netconfig_ipv6_to_string(fils->ipv6_dns);
> +			return dns_list;
> +		}
> +
> +		if (!(lease =3D l_dhcp6_client_get_lease(
>   						netconfig->dhcp6_client)))
> -			dns6_list =3D l_dhcp6_lease_get_dns(lease);
> +			return NULL;
> +
> +		return l_dhcp6_lease_get_dns(lease);
>   	}
> +}
> +
> +static void netconfig_set_neighbor_entry_cb(int error,
> +						uint16_t type, const void *data,
> +						uint32_t len, void *user_data)
> +{
> +	if (error)
> +		l_error("l_rtnl_neighbor_set_hwaddr failed: %s (%i)",
> +			strerror(-error), error);
> +}
> +
> +static int netconfig_set_dns(struct netconfig *netconfig)
> +{
> +	const uint8_t *fils_dns4_mac =3D NULL;
> +	const uint8_t *fils_dns6_mac =3D NULL;
> +	char **dns4_list =3D netconfig_get_dns_list(netconfig, AF_INET,
> +							&fils_dns4_mac);
> +	char **dns6_list =3D netconfig_get_dns_list(netconfig, AF_INET6,
> +							&fils_dns6_mac);
> +	unsigned int n_entries4 =3D l_strv_length(dns4_list);
> +	unsigned int n_entries6 =3D l_strv_length(dns6_list);
> +	char **dns_list;
> +	const struct ie_fils_ip_addr_response_info *fils =3D
> +		netconfig->fils_override;
>   =

> -	n_entries +=3D l_strv_length(netconfig->dns4_overrides);
> -	n_entries +=3D l_strv_length(netconfig->dns6_overrides);
> -	n_entries +=3D l_strv_length(dns4_list);
> -	n_entries +=3D l_strv_length(dns6_list);
> +	if (!dns4_list && !dns6_list)
> +		return 0;
>   =

> -	dns_list =3D l_new(char *, n_entries + 1);
> -	n_entries =3D 0;
> +	dns_list =3D l_realloc(dns4_list,
> +				sizeof(char *) * (n_entries4 + n_entries6 + 1));
> +
> +	if (dns6_list) {
> +		memcpy(dns_list + n_entries4, dns6_list,
> +			sizeof(char *) * (n_entries6 + 1));
> +		/* Contents now belong to dns_list, so no l_strfreev */
> +		l_free(dns6_list);
> +	}
>   =

> -	APPEND_STRDUPV(dns_list, n_entries, netconfig->dns4_overrides);
> -	APPENDV(dns_list, n_entries, dns4_list);
> -	APPEND_STRDUPV(dns_list, n_entries, netconfig->dns6_overrides);
> -	APPENDV(dns_list, n_entries, dns6_list);
>   	resolve_set_dns(netconfig->resolve, dns_list);
>   =

>   	if (fils_dns4_mac && !l_rtnl_neighbor_set_hwaddr(rtnl,
> @@ -284,9 +313,6 @@ static int netconfig_set_dns(struct netconfig *netcon=
fig)
>   		l_debug("l_rtnl_neighbor_set_hwaddr failed");
>   =

>   	l_strv_free(dns_list);
> -	/* Contents belonged to dns_list, so not l_strfreev */
> -	l_free(dns4_list);
> -	l_free(dns6_list);
>   	return 0;
>   }
>   =


I applied this part separately in commit 8b573fe3984d ("netconfig: Refactor =

netconfig_set_dns")

<snip>

> @@ -703,6 +732,43 @@ static void netconfig_route_generic_cb(int error, ui=
nt16_t type,
>   	}
>   }
>   =

> +static void netconfig_connected(struct netconfig *netconfig)
> +{
> +	struct l_dbus *dbus =3D dbus_get_bus();
> +
> +	netconfig->connected =3D true;
> +
> +	if (netconfig->notify) {
> +		netconfig->notify(NETCONFIG_EVENT_CONNECTED,
> +					netconfig->user_data);
> +		netconfig->notify =3D NULL;
> +	}
> +
> +	if (netconfig->dbus_path &&
> +			unlikely(!l_dbus_object_add_interface(dbus,
> +						netconfig->dbus_path,
> +						IWD_IPV4_CONFIG_INTERFACE,
> +						&netconfig->ipv4_data)))
> +		l_info("Unable to add %s at %s",
> +			IWD_IPV4_CONFIG_INTERFACE, netconfig->dbus_path);
> +
> +	if (netconfig->dbus_path &&
> +			unlikely(!l_dbus_object_add_interface(dbus,
> +						netconfig->dbus_path,
> +						IWD_IPV6_CONFIG_INTERFACE,
> +						&netconfig->ipv6_data)))
> +		l_info("Unable to add %s at %s",
> +			IWD_IPV6_CONFIG_INTERFACE, netconfig->dbus_path);
> +
> +	if (netconfig->dbus_path &&
> +			!l_dbus_object_add_interface(dbus, netconfig->dbus_path,
> +						L_DBUS_INTERFACE_PROPERTIES,
> +						netconfig))
> +		/* Properties may already exist on the object, not an error */
> +		l_debug("Unable to add %s at %s",
> +			L_DBUS_INTERFACE_PROPERTIES, netconfig->dbus_path);

So the connected event is fired once we have IPv4 or IPv6 configuration, ri=
ght?

Why would we populate both IPv6 and IPv4 interfaces here though?  Why don't=
 you =

just make IPv6 interface available when IPv6 is configured, and similarly f=
or =

IPv4?  Would make a lot of the code simpler and require less =

l_dbus_property_changed() calls.

> +}
> +
>   static void netconfig_route_add_cmd_cb(int error, uint16_t type,
>   						const void *data, uint32_t len,
>   						void *user_data)

<snip>

> @@ -897,10 +989,47 @@ static void netconfig_ipv4_dhcp_event_handler(struc=
t l_dhcp_client *client,
>   					netconfig->v4_address,
>   					netconfig_ifaddr_del_cmd_cb,
>   					netconfig, NULL));
> -		l_rtnl_address_free(netconfig->v4_address);
>   		/* Fall through. */
>   	case L_DHCP_CLIENT_EVENT_LEASE_OBTAINED:
> -		netconfig->v4_address =3D netconfig_get_dhcp4_address(netconfig);
> +	{
> +		char *gateway_str;
> +		struct l_rtnl_address *address;
> +
> +		gateway_str =3D netconfig_ipv4_get_gateway(netconfig, NULL);
> +		if (l_streq0(netconfig->v4_gateway_str, gateway_str))
> +			l_free(gateway_str);
> +		else {
> +			l_free(netconfig->v4_gateway_str);
> +			netconfig->v4_gateway_str =3D gateway_str;
> +
> +			if (netconfig->dbus_path && netconfig->connected)
> +				l_dbus_property_changed(dbus,
> +						netconfig->dbus_path,
> +						IWD_IPV4_CONFIG_INTERFACE,
> +						"Gateway");
> +		}

So in theory LEASE_OBTAINED should only ever be signaled once.  Why not reg=
ister =

the IPv4 interface now and avoid all this logic?  If we lose the lease for =
some =

reason, then we should get a LEASE_LOST or LEASE_EXPIRED event first.

> +
> +		address =3D netconfig_get_dhcp4_address(netconfig);
> +
> +		if (netconfig->dbus_path && netconfig->connected &&
> +				!netconfig_address_cmp_prefix_len(
> +							netconfig->v4_address,
> +							address))
> +			l_dbus_property_changed(dbus, netconfig->dbus_path,
> +						IWD_IPV4_CONFIG_INTERFACE,
> +						"Netmask");
> +
> +		if (netconfig->dbus_path && netconfig->connected &&
> +				netconfig_address_cmp_address(
> +							netconfig->v4_address,
> +							address))
> +			l_dbus_property_changed(dbus, netconfig->dbus_path,
> +						IWD_IPV4_CONFIG_INTERFACE,
> +						"Address");
> +
> +		l_rtnl_address_free(netconfig->v4_address);
> +		netconfig->v4_address =3D address;
> +
>   		if (!netconfig->v4_address) {
>   			l_error("netconfig: Failed to obtain IP addresses from "
>   							"DHCPv4 lease.");
> @@ -913,6 +1042,7 @@ static void netconfig_ipv4_dhcp_event_handler(struct=
 l_dhcp_client *client,
>   					netconfig_ipv4_ifaddr_add_cmd_cb,
>   					netconfig, NULL)));
>   		break;
> +	}
>   	case L_DHCP_CLIENT_EVENT_LEASE_RENEWED:
>   		break;
>   	case L_DHCP_CLIENT_EVENT_LEASE_EXPIRED:
> @@ -923,6 +1053,25 @@ static void netconfig_ipv4_dhcp_event_handler(struc=
t l_dhcp_client *client,
>   		l_rtnl_address_free(netconfig->v4_address);
>   		netconfig->v4_address =3D NULL;
>   =

> +		if (netconfig->dbus_path && netconfig->connected) {
> +			l_dbus_property_changed(dbus, netconfig->dbus_path,
> +						IWD_IPV4_CONFIG_INTERFACE,
> +						"Address");
> +			l_dbus_property_changed(dbus, netconfig->dbus_path,
> +						IWD_IPV4_CONFIG_INTERFACE,
> +						"Netmask");
> +		}
> +
> +		if (netconfig->v4_gateway_str) {
> +			if (netconfig->dbus_path && netconfig->connected)
> +				l_dbus_property_changed(dbus,
> +						netconfig->dbus_path,
> +						IWD_IPV4_CONFIG_INTERFACE,
> +						"Gateway");
> +
> +			l_free(l_steal_ptr(netconfig->v4_gateway_str));
> +		}

Why not simply remove the IPv4 interface?

> +
>   		/* Fall through. */
>   	case L_DHCP_CLIENT_EVENT_NO_LEASE:
>   		/*
> @@ -945,18 +1094,87 @@ static void netconfig_dhcp6_event_handler(struct l=
_dhcp6_client *client,
>   						void *userdata)
>   {
>   	struct netconfig *netconfig =3D userdata;
> +	struct l_dbus *dbus =3D dbus_get_bus();
>   =

>   	switch (event) {
>   	case L_DHCP6_CLIENT_EVENT_IP_CHANGED:
>   	case L_DHCP6_CLIENT_EVENT_LEASE_OBTAINED:
>   	case L_DHCP6_CLIENT_EVENT_LEASE_RENEWED:
> +	{
> +		__auto_type lease =3D
> +			l_dhcp6_client_get_lease(netconfig->dhcp6_client);
> +		L_AUTO_FREE_VAR(char *, addr_str) =3D
> +			l_dhcp6_lease_get_address(lease);
> +		struct l_rtnl_address *address;
> +		__auto_type icmp6 =3D
> +			l_dhcp6_client_get_icmp6(netconfig->dhcp6_client);
> +		__auto_type router =3D l_icmp6_client_get_router(icmp6);
> +		char *gateway_str =3D l_icmp6_router_get_address(router);
> +
> +		if (l_streq0(netconfig->v6_gateway_str, gateway_str))
> +			l_free(gateway_str);
> +		else {
> +			l_free(netconfig->v6_gateway_str);
> +			netconfig->v6_gateway_str =3D gateway_str;
> +
> +			if (netconfig->dbus_path && netconfig->connected)
> +				l_dbus_property_changed(dbus,
> +						netconfig->dbus_path,
> +						IWD_IPV6_CONFIG_INTERFACE,
> +						"Gateway");
> +		}
> +
> +		address =3D l_rtnl_address_new(addr_str,
> +					l_dhcp6_lease_get_prefix_length(lease));
> +
> +		if (netconfig->dbus_path && netconfig->connected &&
> +				!netconfig_address_cmp_prefix_len(
> +							netconfig->v6_address,
> +							address))
> +			l_dbus_property_changed(dbus, netconfig->dbus_path,
> +						IWD_IPV6_CONFIG_INTERFACE,
> +						"Netmask");
> +
> +		if (netconfig->dbus_path && netconfig->connected &&
> +				netconfig_address_cmp_address(
> +							netconfig->v6_address,
> +							address))
> +			l_dbus_property_changed(dbus, netconfig->dbus_path,
> +						IWD_IPV6_CONFIG_INTERFACE,
> +						"Address");
> +
> +		l_rtnl_address_free(netconfig->v6_address);
> +		netconfig->v4_address =3D address;

v6 address?

Also similar comments as above?  Why not just register the IPv6 interface h=
ere =

instead?

Also, I'm really not sure whether just Netmask/Address/Gateway are the only =

things that can change.  DNS, NTP, domain, etc information might also chang=
e. =

So a more generic old lease / new lease comparison might be needed.  Or alw=
ays =

send a PropertyChanged for all attributes and have the caller figure it out?

<snip>

> +static bool netconfig_property_get_domains(struct l_dbus *dbus,
> +					struct l_dbus_message *message,
> +					struct l_dbus_message_builder *builder,
> +					void *user_data)
> +{
> +	const struct interface_data *data =3D user_data;
> +
> +	if (data->is_ipv4) {
> +		L_AUTO_FREE_VAR(char *, domain) =3D
> +			l_settings_get_string(data->netconfig->active_settings,
> +						"IPv4", "DomainName");
> +
> +		if (!domain) {
> +			const struct l_dhcp_lease *lease;
> +
> +			if (data->netconfig->rtm_protocol !=3D RTPROT_DHCP)
> +				return false;
> +
> +			lease =3D l_dhcp_client_get_lease(
> +						data->netconfig->dhcp_client);
> +			if (!lease)
> +				return false;
> +
> +			if (!(domain =3D l_dhcp_lease_get_domain_name(lease)))
> +				return false;
> +		}
> +
> +		l_dbus_message_builder_enter_array(builder, "s");
> +		l_dbus_message_builder_append_basic(builder, 's', domain);
> +		l_dbus_message_builder_leave_array(builder);
> +	} else {
> +		const struct l_dhcp6_lease *lease;
> +		char **domains;
> +		char **i;
> +
> +		if (data->netconfig->rtm_v6_protocol !=3D RTPROT_DHCP)
> +			return false;
> +
> +		lease =3D l_dhcp6_client_get_lease(data->netconfig->dhcp6_client);
> +		if (!lease)
> +			return false;
> +
> +		domains =3D l_dhcp6_lease_get_domains(lease);
> +		if (!domains)
> +			return false;
> +
> +		l_dbus_message_builder_enter_array(builder, "s");
> +
> +		for (i =3D domains; *i; i++)
> +			l_dbus_message_builder_append_basic(builder, 's', *i);
> +
> +		l_dbus_message_builder_leave_array(builder);
> +		l_strv_free(domains);
> +	}
> +
> +	return true;

Might as well make this two separate functions

> +}
> +

Regards,
-Denis
--===============0838394079099722876==--

