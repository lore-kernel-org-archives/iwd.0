Content-Type: multipart/mixed; boundary="===============6435631334526613292=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Send hostname as part of DHCP request.
Date: Fri, 18 Jun 2021 10:22:34 -0500
Message-ID: <e1e67d58-c2c7-1001-b20e-117ae97ff414@gmail.com>
In-Reply-To: <20210618140006.2820.65634@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6435631334526613292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 6/18/21 9:00 AM, mjohnson459(a)gmail.com wrote:

Can you include a proper name in the next version so it can be applied?  We =

won't apply patches with just an email address and no proper author name.

> This is based on a previous patch by Roberto Santalla Fern=C3=A1ndez.
> =

> A new config is introduced into the network config file under IPv4
> called SendHostname. If this is set to true then we add the hostname
> into all DHCP requests. The default is false.

The patch looks fine.  Just a small nitpick below...

> ---
>   src/iwd.network.rst |  6 ++++++
>   src/netconfig.c     | 15 +++++++++++++++
>   2 files changed, 21 insertions(+)
> =


<snip>

> diff --git a/src/netconfig.c b/src/netconfig.c
> index 316431ee..eb6d80ff 100644
> --- a/src/netconfig.c
> +++ b/src/netconfig.c
> @@ -1004,6 +1004,8 @@ bool netconfig_configure(struct netconfig *netconfi=
g,
>   				netconfig_notify_func_t notify, void *user_data)
>   {
>   	char *mdns;
> +	char hostname[HOST_NAME_MAX + 1];
> +	bool send_hostname;
>   =

>   	netconfig->dns4_overrides =3D l_settings_get_string_list(active_settin=
gs,
>   							"IPv4", "DNS", ' ');
> @@ -1044,6 +1046,19 @@ bool netconfig_configure(struct netconfig *netconf=
ig,
>   	l_dhcp6_client_set_address(netconfig->dhcp6_client, ARPHRD_ETHER,
>   							mac_address, ETH_ALEN);
>   =

> +	if (!l_settings_get_bool(active_settings,
> +					"IPv4", "SendHostname", &send_hostname))
> +		send_hostname =3D false;
> +
> +	if (send_hostname) {
> +		if (gethostname(hostname, sizeof(hostname)) =3D=3D 0) {
> +			l_dhcp_client_set_hostname(
> +				netconfig->dhcp_client, hostname);
> +		} else {
> +			l_warn("netconfig: Unable to get hostname");
> +		}

Could you also print the errno / strerror() on the failure path so that we =
can =

easily see the reason this goes wrong in the logs?

> +	}
> +
>   	netconfig_ipv4_select_and_install(netconfig);
>   =

>   	netconfig_ipv6_select_and_install(netconfig);
> =


Regards,
-Denis
--===============6435631334526613292==--

