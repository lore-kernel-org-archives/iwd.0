Content-Type: multipart/mixed; boundary="===============3839521213947170342=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/9] netconfig: add ACD client for static configuration
Date: Thu, 10 Dec 2020 20:34:07 +0000
Message-ID: <5b932990-6012-6552-2114-3450d650b696@gmail.com>
In-Reply-To: <20201210174525.874021-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3839521213947170342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/10/20 11:45 AM, James Prestwood wrote:
> When the IP is configured to be static we can now use ACD in
> order to check that the IP is available and not already in
> use. If a conflict is found netconfig will be reset and no IP
> will be set on the interface. The ACD client is left with
> the default 'defend once' policy, and probes are not turned
> off. This will increase connection time, but for static IP's
> it is the best approach.
> ---
>   src/netconfig.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 44 insertions(+), 1 deletion(-)
> =

> diff --git a/src/netconfig.c b/src/netconfig.c
> index f48a789a..24ad3fff 100644
> --- a/src/netconfig.c
> +++ b/src/netconfig.c
> @@ -64,6 +64,8 @@ struct netconfig {
>   	void *user_data;
>   =

>   	struct resolve *resolve;
> +
> +	struct l_acd *acd;
>   };
>   =

>   static struct l_netlink *rtnl;
> @@ -804,15 +806,56 @@ static void netconfig_dhcp6_event_handler(struct l_=
dhcp6_client *client,
>   	}
>   }
>   =

> +static void netconfig_ipv4_acd_event(enum l_acd_event event, void *user_=
data)
> +{
> +	struct netconfig *netconfig =3D user_data;
> +
> +	switch (event) {
> +	case L_ACD_EVENT_AVAILABLE:
> +		L_WARN_ON(!l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
> +					netconfig->v4_address,
> +					netconfig_ipv4_ifaddr_add_cmd_cb,
> +					netconfig, NULL));
> +		return;
> +	case L_ACD_EVENT_CONFLICT:
> +		l_error("netconfig: statically configured address conflict!");
> +		break;
> +	case L_ACD_EVENT_LOST:
> +		l_error("netconfig: statically configured address was lost");
> +		break;
> +	}
> +
> +	netconfig_reset(netconfig);

That might be a bit harsh.  We may still have ipv6 connectivity.

> +}
> +
>   static void netconfig_ipv4_select_and_install(struct netconfig *netconf=
ig)
>   {
>   	netconfig->v4_address =3D netconfig_get_static4_address(netconfig);
>   	if (netconfig->v4_address) {

Hmm, right now the assumption is that if v4_address is set, then we attempt=
ed to =

set it in the kernel and it is most likely set.  So on ACD failure we'd try=
 to =

reset an address that doesn't exist.  Harmless, but might be nicer not to d=
o =

unnecessary stuff.

> +		char ip[INET6_ADDRSTRLEN];
> +
>   		netconfig->rtm_protocol =3D RTPROT_STATIC;
> -		L_WARN_ON(!l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
> +		netconfig->acd =3D l_acd_new(netconfig->ifindex);
> +		l_acd_set_event_handler(netconfig->acd,
> +					netconfig_ipv4_acd_event, netconfig,
> +					NULL);
> +		if (getenv("IWD_ACD_DEBUG"))
> +			l_acd_set_debug(netconfig->acd, do_debug,
> +					"[ACD] ", NULL);
> +
> +		l_rtnl_address_get_address(netconfig->v4_address, ip);
> +
> +		if (!l_acd_start(netconfig->acd, ip)) {
> +			l_error("failed to start ACD, continuing anyways");
> +			l_acd_destroy(netconfig->acd);
> +			netconfig->acd =3D NULL;
> +
> +			L_WARN_ON(!l_rtnl_ifaddr_add(rtnl, netconfig->ifindex,
>   					netconfig->v4_address,
>   					netconfig_ipv4_ifaddr_add_cmd_cb,
>   					netconfig, NULL));
> +		}
> +
>   		return;
>   	}
>   =

> =


Regards,
-Denis
--===============3839521213947170342==--

