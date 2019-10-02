Content-Type: multipart/mixed; boundary="===============6226305145908114702=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 3/5] netconfig: Add IPv6 static address
 installation/removal
Date: Wed, 02 Oct 2019 12:08:10 -0500
Message-ID: <2e9d15a1-3e5f-446a-c8b1-69ce297a8b2a@gmail.com>
In-Reply-To: <20191001234425.22913-3-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6226305145908114702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 10/1/19 6:44 PM, Tim Kourt wrote:
> The network configuration options for IPv6 are grouped under [IPv6] =

> and include the following: ip=3D ADDRESS/PREFIX gateway=3DADDRESS =

> dns=3DADDRESS
> =

> The placeholders for DHCPv6 are placed along the way and marked as
> TODO items. --- src/netconfig.c | 160
> +++++++++++++++++++++++++++++++++++++++++++++++++++++--- 1 file
> changed, 152 insertions(+), 8 deletions(-)
> =


<snip>

> @@ -224,6 +225,70 @@ static char **netconfig_ipv4_get_dns(struct
> netconfig *netconfig, uint8_t proto) return NULL; }
> =

> +static struct netconfig_ifaddr *netconfig_ipv6_get_ifaddr( +
> struct netconfig *netconfig, +						uint8_t proto) +{ +	struct
> in6_addr in6_addr; +	struct netconfig_ifaddr *ifaddr; +	char *ip; +
> char *p; + +	switch (proto) { +	case RTPROT_STATIC: +		if
> (!netconfig->active_settings) +			return NULL; + +		ip =3D
> l_settings_get_string(netconfig->active_settings, "IPv6", +
> "ip"); +		if (!ip) +			return NULL; + +		ifaddr =3D l_new(struct
> netconfig_ifaddr, 1); +		ifaddr->ip =3D ip; + +		p =3D
> strrchr(ifaddr->ip, '/'); +		if (!p) +			goto no_prefix_len; + +		*p
> =3D '\0'; + +		if (inet_pton(AF_INET6, ifaddr->ip, &in6_addr) < 1) { +
> l_error("netconfig: Invalid IPv6 address %s is " +				"provided in
> network configuration file.", +				ifaddr->ip); + +
> netconfig_ifaddr_destroy(ifaddr); + +			return NULL; +		} + +		if
> (*++p =3D=3D '\0') +			goto no_prefix_len; + +		ifaddr->prefix_len =3D
> strtoul(p, NULL, 10); + +		if (!unlikely(errno =3D=3D EINVAL || errno =3D=
=3D
> ERANGE || +				!ifaddr->prefix_len || +				ifaddr->prefix_len >
> 128)) +			goto proceed; + +no_prefix_len: +		ifaddr->prefix_len =3D
> 128; +proceed: +		ifaddr->family =3D AF_INET6; +

Didn't we agree to perform the validation in netconfig_configure?

> +		return ifaddr; + +	case RTPROT_DHCP: +		/* TODO */ + +		return
> NULL; +	} + +	return NULL; +} + static bool
> netconfig_ifaddr_match(const void *a, const void *b) { const struct
> netconfig_ifaddr *entry =3D a;

<snip>

> @@ -747,13 +890,13 @@ bool netconfig_reconfigure(struct netconfig
> *netconfig) bool netconfig_reset(struct netconfig *netconfig) { =

> netconfig_ipv4_select_and_uninstall(netconfig); +
> netconfig->rtm_protocol =3D 0;
> =

> -	/* TODO: IPv6 addressing */ +
> netconfig_ipv6_select_and_uninstall(netconfig); +
> netconfig->rtm_v6_protocol =3D 0;
> =

> resolve_remove(netconfig->ifindex);
> =

> -	netconfig->rtm_protocol =3D 0; - return true; }
> =

> @@ -790,13 +933,14 @@ void netconfig_destroy(struct netconfig
> *netconfig)
> =

> l_queue_remove(netconfig_list, netconfig);
> =

> -	if (netconfig->rtm_protocol) { +	if (netconfig->rtm_protocol) =

> netconfig_ipv4_select_and_uninstall(netconfig);
> =

> -		/* TODO Uninstall IPv6 addresses. */ +	if
> (netconfig->rtm_v6_protocol) +
> netconfig_ipv6_select_and_uninstall(netconfig);
> =

> +	if (netconfig->rtm_protocol || netconfig->rtm_v6_protocol) =

> resolve_remove(netconfig->ifindex); -	}

Shouldn't you implement netconfig_destroy using netconfig_reset?  Since
they perform nearly identical set of operations?

> =

> netconfig_free(netconfig); }
> =


Anyway, I'll just take this patch, but please fix these.

Regards,
-Denis
--===============6226305145908114702==--

