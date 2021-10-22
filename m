Content-Type: multipart/mixed; boundary="===============5486033970056403476=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 03/12] netconfig: Track gateway address strings
Date: Fri, 22 Oct 2021 12:16:56 -0500
Message-ID: <2b2af412-93b9-d620-8e4e-7bdd7a1c35ad@gmail.com>
In-Reply-To: 20211021085041.294524-3-andrew.zaborowski@intel.com

--===============5486033970056403476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/21/21 3:50 AM, Andrew Zaborowski wrote:
> Cache the latest v4 and v6 gateway IP string in struct netconfig state
> to be able to more easily detect changes in those values in future
> commits and perhaps to simplify the ..._routes_install functions.
> netconfig_ipv4_get_gateway's out_mac parameter can now be NULL.  While
> editing that function fix a small formatting annoyance.
> ---
>   src/netconfig.c | 62 +++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 50 insertions(+), 12 deletions(-)
> =


<snip>

> @@ -436,6 +438,8 @@ static char *netconfig_ipv4_get_gateway(struct netcon=
fig *netconfig,
>   {
>   	const struct l_dhcp_lease *lease;
>   	char *gateway;
> +	const struct ie_fils_ip_addr_response_info *fils =3D
> +		netconfig->fils_override;
>   =

>   	switch (netconfig->rtm_protocol) {
>   	case RTPROT_STATIC:
> @@ -449,15 +453,12 @@ static char *netconfig_ipv4_get_gateway(struct netc=
onfig *netconfig,
>   		return gateway;
>   =

>   	case RTPROT_DHCP:
> -		if (netconfig->fils_override &&
> -				netconfig->fils_override->ipv4_gateway) {
> -			gateway =3D netconfig_ipv4_to_string(
> -					netconfig->fils_override->ipv4_gateway);
> +		if (fils && fils->ipv4_gateway) {
> +			gateway =3D netconfig_ipv4_to_string(fils->ipv4_gateway);
>   =

> -			if (gateway && !l_memeqzero(netconfig->fils_override->
> -							ipv4_gateway_mac, 6))
> -				*out_mac =3D netconfig->fils_override->
> -					ipv4_gateway_mac;
> +			if (gateway && out_mac &&
> +					!l_memeqzero(fils->ipv4_gateway_mac, 6))
> +				*out_mac =3D fils->ipv4_gateway_mac;
>   =

>   			return gateway;
>   		}
> @@ -495,7 +496,7 @@ static struct l_rtnl_address *netconfig_get_static6_a=
ddress(
>   	prefix_len =3D strtoul(p, NULL, 10);
>   	if (!unlikely(errno =3D=3D EINVAL || errno =3D=3D ERANGE ||
>   			!prefix_len || prefix_len > 128)) {
> -		l_error("netconfig: Invalid prefix '%s'  provided in network"
> +		l_error("netconfig: Invalid prefix '%s' provided in network"
>   				" configuration file", p);
>   		return NULL;
>   	}

I separated out these 3 chunks into 2 separate commits since they did not s=
eem =

to be related to the commit description.

So this commit became 3.  Please review.  Applied, thanks.

Regards,
-Denis
--===============5486033970056403476==--

