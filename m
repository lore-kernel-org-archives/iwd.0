Content-Type: multipart/mixed; boundary="===============1917949690526176988=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/9] ie: Add FILS IP Address Assignment parsers and
 builders
Date: Wed, 25 Aug 2021 08:47:28 -0500
Message-ID: <611d1fd3-fd8e-3b42-0e9f-32f0edcc4ac7@gmail.com>
In-Reply-To: <20210823141430.223543-5-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1917949690526176988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/23/21 9:14 AM, Andrew Zaborowski wrote:
> ---
>   src/ie.c | 347 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/ie.h |  38 ++++++
>   2 files changed, 385 insertions(+)
> =


<snip>

> +	if (*resp_ctrl & IE_FILS_IP_ADDR_RESP_CTRL_IPV4_GW_INCLUDED) {
> +		ptr =3D NEXT_FIELD(data, len, 10);
> +		info.ipv4_gateway =3D l_get_u32(ptr);
> +		memcpy(info.ipv4_gateway_mac, ptr + 4, 6);
> +
> +		/* Check gateway is on the same subnet */
> +		if (info.ipv4_addr && (ntohl(info.ipv4_addr ^ info.ipv4_gateway) &
> +				util_netmask_from_prefix(info.ipv4_prefix_len)))

This line is over 80 chars.  Also, it seems you're repeating this pattern i=
n =

many places by now.  Please add a utility function so one doesn't wonder wh=
at =

this is doing on every reading ;)

> +			return -EINVAL;
> +	}
> +

<snip>

> +
> +			if (mask && ((info.ipv6_addr[n] ^
> +						info.ipv6_gateway[n]) & mask))

Same thing here it seems

> +				return -EINVAL;
> +		}
> +	}
> +

I went ahead and applied patches 1-6.

Regards,
-Denis
--===============1917949690526176988==--

