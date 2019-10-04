Content-Type: multipart/mixed; boundary="===============1492161453636119988=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] netconfig: Allow to override IPv4 DHCP DNSs with
 static addresses
Date: Fri, 04 Oct 2019 12:14:29 -0500
Message-ID: <fe6ecf07-eb69-51d2-5701-b64f12bc45e5@gmail.com>
In-Reply-To: <20191003204851.9781-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1492161453636119988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 10/3/19 3:48 PM, Tim Kourt wrote:
> ---
>   src/netconfig.c | 37 +++++++++++++++++++++++++++++--------
>   1 file changed, 29 insertions(+), 8 deletions(-)
> =

> diff --git a/src/netconfig.c b/src/netconfig.c
> index 285d5fef..51d06ce1 100644
> --- a/src/netconfig.c
> +++ b/src/netconfig.c
> @@ -207,14 +207,37 @@ static char *netconfig_ipv4_get_gateway(struct netc=
onfig *netconfig)
>   static char **netconfig_ipv4_get_dns(struct netconfig *netconfig, uint8=
_t proto)
>   {
>   	const struct l_dhcp_lease *lease;
> +	struct in_addr in_addr;
> +	char **dns_list;
> +	char **p;

In general it is always a good idea to limit the scope of variables.  So =

char **p could be defined in the opening if() below.

>   =

> -	switch (proto) {
> -	case RTPROT_STATIC:
> -
> -		return l_settings_get_string_list(netconfig->active_settings,
> +	p =3D dns_list =3D l_settings_get_string_list(netconfig->active_setting=
s,
>   							"IPv4", "dns", ' ');
> +	if (dns_list && *dns_list) {
> +		for (; *p; p++) {
> +			if (inet_pton(AF_INET, *p, &in_addr) =3D=3D 1)
> +				continue;
>   =

> -	case RTPROT_DHCP:
> +			l_error("netconfig: Invalid IPv4 DNS address '%s' is "
> +				"provided in network configuration file.", *p);
> +
> +			l_strv_free(dns_list);

So the way you have it implemented now, it might be nice to fall back to =

DHCP-provided DNS if parsing the override fails and DHCP is enabled.

I still would like to get the parameter validation done up-front so that =

such policy decisions can be made there...

> +
> +			return NULL;
> +		}
> +
> +		/* Allow to override the DHCP DNSs with static addressing. */
> +		return dns_list;
> +	} else if (dns_list) {
> +		l_error("netconfig: No IPv4 DNS address is provided in network "
> +							"configuration file.");
> +
> +		l_strv_free(dns_list);
> +
> +		return NULL;
> +	}
> +
> +	if (proto =3D=3D RTPROT_DHCP) {
>   		lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client);
>   		if (!lease)
>   			return NULL;
> @@ -662,9 +685,7 @@ static void netconfig_ipv4_ifaddr_add_cmd_cb(int erro=
r, uint16_t type,
>   =

>   	dns =3D netconfig_ipv4_get_dns(netconfig, netconfig->rtm_protocol);
>   	if (!dns) {
> -		l_error("netconfig: Failed to obtain DNS addresses from %s.",
> -				netconfig->rtm_protocol =3D=3D RTPROT_STATIC ?
> -				"setting file" : "DHCPv4 lease");
> +		l_error("netconfig: Failed to obtain DNS addresses.");
>   		goto done;
>   	}
>   =

> =


Anyway, applied.

Regards,
-Denis
--===============1492161453636119988==--

