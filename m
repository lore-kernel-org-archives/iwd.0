Content-Type: multipart/mixed; boundary="===============7887400308351225336=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] netconfig: Add IPv4 domain name helper and installer
Date: Mon, 09 Dec 2019 09:23:08 -0600
Message-ID: <71c65a22-0c01-2d00-5908-c99de1dd6624@gmail.com>
In-Reply-To: <20191209232805.2873-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7887400308351225336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 12/9/19 5:28 PM, Tim Kourt wrote:
> The provided domain name helper allows to override the DHCP lease
> option value with the static one from network configuration file.
> ---
>   src/netconfig.c | 34 +++++++++++++++++++++++++++++++++-
>   1 file changed, 33 insertions(+), 1 deletion(-)
> =

> diff --git a/src/netconfig.c b/src/netconfig.c
> index 9d32c37a..9f0127ac 100644
> --- a/src/netconfig.c
> +++ b/src/netconfig.c
> @@ -251,6 +251,28 @@ static char **netconfig_ipv4_get_dns(struct netconfi=
g *netconfig, uint8_t proto)
>   	return NULL;
>   }
>   =

> +static char *netconfig_ipv4_get_domain_name(struct netconfig *netconfig,
> +								uint8_t proto)
> +{
> +	const struct l_dhcp_lease *lease;
> +	char *domain_name;
> +
> +	domain_name =3D l_settings_get_string(netconfig->active_settings,
> +							"IPv4", "domain_name");

Lets use CamelCase here

> +	if (domain_name)
> +		/* Allow to override the DHCP domain name with setting entry. */
> +		return domain_name;
> +
> +	if (proto !=3D RTPROT_DHCP)
> +		return NULL;
> +
> +	lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client);
> +	if (!lease)
> +		return NULL;
> +
> +	return l_dhcp_lease_get_domain_name(lease);
> +}
> +
>   static struct netconfig_ifaddr *netconfig_ipv6_get_ifaddr(
>   						struct netconfig *netconfig,
>   						uint8_t proto)

Otherwise looks fine to me

Regards,
-Denis
--===============7887400308351225336==--

