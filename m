Content-Type: multipart/mixed; boundary="===============6278942788418579364=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/8] ap: Save AP address as l_rtnl_address
Date: Tue, 01 Jun 2021 10:20:26 -0500
Message-ID: <393c3b03-37f2-0a9d-f2c9-300020f09745@gmail.com>
In-Reply-To: <20210528004737.2878442-6-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6278942788418579364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/27/21 7:47 PM, Andrew Zaborowski wrote:
> Change the char *addr_str and uint8_t prefix_len pair to an
> l_rtnl_address object and use ell/rtnl.h utilities that use that
> directly.  Extend broadcast_from_ip to handle prefix_len.
> ---
>   src/ap.c | 43 +++++++++++++++++--------------------------
>   1 file changed, 17 insertions(+), 26 deletions(-)
> =


<snip>

> @@ -132,20 +131,15 @@ static char **global_addr4_strs;
>   static uint32_t netdev_watch;
>   static struct l_netlink *rtnl;
>   =

> -static const char *broadcast_from_ip(const char *ip)
> +static const char *broadcast_from_ip(const char *ip, uint8_t prefix_len)
>   {
>   	struct in_addr ia;
> -	uint32_t bcast;
> +	uint32_t netmask =3D util_netmask_from_prefix(prefix_len);
>   =

>   	if (inet_aton(ip, &ia) !=3D 1)
>   		return NULL;
>   =

> -	bcast =3D ntohl(ia.s_addr);
> -	bcast &=3D 0xffffff00;
> -	bcast |=3D 0x000000ff;
> -
> -	ia.s_addr =3D htonl(bcast);
> -
> +	ia.s_addr |=3D htonl(~netmask);
>   	return inet_ntoa(ia);
>   }
>   =


Okay, but don't you really want to use l_rtnl_address_set_broadcast(rtnl, N=
ULL) =

instead?  Also, you may want to do this directly in ip-pool.c?

Applied, thanks.

Regards,
-Denis
--===============6278942788418579364==--

