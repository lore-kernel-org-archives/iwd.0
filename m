Content-Type: multipart/mixed; boundary="===============6861521846932095128=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 4/8] netconfig: Subscribe for IPv6 address changes
Date: Mon, 30 Sep 2019 15:13:04 -0500
Message-ID: <d35cb892-f918-08f1-e88d-b2f178339da5@gmail.com>
In-Reply-To: <20190930163558.28123-4-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6861521846932095128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 9/30/19 11:35 AM, Tim Kourt wrote:
> The IPv6 addresses changes are maintained in ifaddr_list.
> ---
>   src/netconfig.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 74 insertions(+)
> =


<snip>

> +static void netconfig_ifaddr_ipv6_deleted(struct netconfig *netconfig,
> +						const struct ifaddrmsg *ifa,
> +						uint32_t len)
> +{
> +	struct netconfig_ifaddr *ifaddr;
> +	char *ip;
> +
> +	rtnl_ifaddr_ipv6_extract(ifa, len, &ip);
> +
> +	ifaddr =3D netconfig_ifaddr_find(netconfig, ifa->ifa_family,
> +							ifa->ifa_prefixlen, ip);
> +
> +	l_free(ip);
> +
> +	if (!ifaddr)
> +		return;

Can we use l_queue_remove_if instead here to avoid walking the list twice?

> +
> +	l_debug("ifaddr %s/%u", ifaddr->ip, ifaddr->prefix_len);
> +
> +	l_queue_remove(netconfig->ifaddr_list, ifaddr);
> +
> +	netconfig_ifaddr_destroy(ifaddr);
> +}
> +

Regards,
-Denis

--===============6861521846932095128==--

