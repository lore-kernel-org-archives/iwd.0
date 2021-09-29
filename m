Content-Type: multipart/mixed; boundary="===============4113908232397104991=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 2/8] netconfig: Cache the IPv6 l_rtnl_address object
Date: Wed, 29 Sep 2021 15:16:10 -0500
Message-ID: <cdb27a68-8b72-9785-a68d-f0b14caa113d@gmail.com>
In-Reply-To: 20210925011153.25195-2-andrew.zaborowski@intel.com

--===============4113908232397104991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/24/21 8:11 PM, Andrew Zaborowski wrote:
> For symmetry with IPv4 and to make it easier to track changes to the
> IPv6 address and netmask in future commits, add a netconfig->v6_address
> treated in the same way as the existing netconfig->v4_address.
> ---
>   src/netconfig.c | 46 ++++++++++++++++++++++++++++++++--------------
>   1 file changed, 32 insertions(+), 14 deletions(-)
> =

> diff --git a/src/netconfig.c b/src/netconfig.c
> index da775480..493a5c13 100644
> --- a/src/netconfig.c
> +++ b/src/netconfig.c
> @@ -58,6 +58,7 @@ struct netconfig {
>   	uint8_t rtm_protocol;
>   	uint8_t rtm_v6_protocol;
>   	struct l_rtnl_address *v4_address;
> +	struct l_rtnl_address *v6_address;
>   	char **dns4_overrides;
>   	char **dns6_overrides;
>   	struct ie_fils_ip_addr_response_info *fils_override;
> @@ -983,13 +984,28 @@ static void netconfig_dhcp6_event_handler(struct l_=
dhcp6_client *client,
>   	case L_DHCP6_CLIENT_EVENT_IP_CHANGED:
>   	case L_DHCP6_CLIENT_EVENT_LEASE_OBTAINED:
>   	case L_DHCP6_CLIENT_EVENT_LEASE_RENEWED:
> +	{
> +		__auto_type lease =3D
> +			l_dhcp6_client_get_lease(netconfig->dhcp6_client);

Please no.  It is fine to use __auto_type in macros where they're out of si=
ght, =

but we shouldn't use this in the general case.

> +		L_AUTO_FREE_VAR(char *, addr_str) =3D
> +			l_dhcp6_lease_get_address(lease);

_auto_ would be preferred and shorter.

> +		struct l_rtnl_address *address;
> +
> +		address =3D l_rtnl_address_new(addr_str,
> +					l_dhcp6_lease_get_prefix_length(lease));
> +		l_rtnl_address_free(netconfig->v6_address);
> +		netconfig->v6_address =3D address;
> +
>   		netconfig_set_dns(netconfig);
>   		netconfig_set_domains(netconfig);
>   		break;
> +	}
>   	case L_DHCP6_CLIENT_EVENT_LEASE_EXPIRED:
>   		l_debug("Lease for interface %u expired", netconfig->ifindex);
>   		netconfig_set_dns(netconfig);
>   		netconfig_set_domains(netconfig);
> +		l_rtnl_address_free(netconfig->v6_address);
> +		netconfig->v6_address =3D NULL;
>   =

>   		/* Fall through */
>   	case L_DHCP6_CLIENT_EVENT_NO_LEASE:

<snip>

> @@ -1291,7 +1304,6 @@ bool netconfig_load_settings(struct netconfig *netc=
onfig,
>   =

>   	if (l_settings_has_key(active_settings, "IPv6", "Address")) {
>   		v6_address =3D netconfig_get_static6_address(active_settings);
> -		l_rtnl_address_free(v6_address);

Ugh.  Can we just make v6_address use _auto_.  The current upstream code is =

bonkers right now.

>   =

>   		if (unlikely(!v6_address)) {
>   			l_error("netconfig: Can't parse IPv6 address");
> @@ -1309,11 +1321,14 @@ bool netconfig_load_settings(struct netconfig *ne=
tconfig,
>   =

>   	if (!v6_enabled)
>   		netconfig->rtm_v6_protocol =3D RTPROT_UNSPEC;
> -	else if (v6_address)
> +	else if (v6_address) {
> +		netconfig->v6_address =3D l_steal_ptr(v6_address);

If the intent behind netconfig_load_settings to do more than validate the =

settings, then you should make sure you're not leaking anything.

Before you started refactoring the API, the semantics were quite clear:

netconfig_configure() --> Apply settings
netconfig_reset() -> Tear down

ad228461abbf ("netconfig: Move loading settings to new method, refactor") d=
oes =

not mention anything about changing the API semantics of this method, and f=
or =

the most part it didn't.  I think only problem area is v4_address handling.

If you want to change the API semantics, then you need to explicitly call t=
hat =

out.   netconfig_load_settings() should either be safely callable multiple =

times, or introduce a new API that would tear down anything that =

netconfig_load_settings did.

>   		netconfig->rtm_v6_protocol =3D RTPROT_STATIC;
> -	else
> +	} else
>   		netconfig->rtm_v6_protocol =3D RTPROT_DHCP;
>   =

> +	l_rtnl_address_free(v6_address);
> +
>   	if (send_hostname)
>   		l_dhcp_client_set_hostname(netconfig->dhcp_client, hostname);
>   =


Regards,
-Denis
--===============4113908232397104991==--

