Content-Type: multipart/mixed; boundary="===============8090752877188364652=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] ip-pool: Track IPv4 addresses in use
Date: Wed, 26 May 2021 14:43:34 -0500
Message-ID: <18de2797-b3fd-fd9f-7843-e34faf382278@gmail.com>
In-Reply-To: <20210525125508.2695708-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8090752877188364652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/25/21 7:55 AM, Andrew Zaborowski wrote:
> Add the ip-pool submodule that tracks IPv4 addresses in use on the
> system for use when selecting the address for a new AP.
> ---
>   Makefile.am   |   1 +
>   src/ip-pool.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/ip-pool.h |  32 ++++++++++
>   3 files changed, 193 insertions(+)
>   create mode 100644 src/ip-pool.c
>   create mode 100644 src/ip-pool.h
> =


<snip>

So I'm completely fine with the implementation now...

> diff --git a/src/ip-pool.h b/src/ip-pool.h
> new file mode 100644
> index 00000000..6a220735
> --- /dev/null
> +++ b/src/ip-pool.h
> @@ -0,0 +1,32 @@
> +/*
> + *
> + *  Wireless daemon for Linux
> + *
> + *  Copyright (C) 2021  Intel Corporation. All rights reserved.
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +
> +struct netdev;

Is there a strong reason for making this tighly-coupled to netdev?  I mean =
in =

theory ip-pool can be reused by netconfig for example, which also tracks IP=
v4/v6 =

addresses (for some unknown reason, but one thing at a time...)

> +
> +struct ip_pool_addr4_record {
> +	uint32_t addr;
> +	uint8_t prefix_len;
> +	uint32_t ifindex;
> +	bool secondary;
> +};

Is there a compelling reason to use a dedicated structure (leaking =

implementation details) instead of returning a newly allocated l_rtnl_addre=
ss =

instead?

> +
> +const struct ip_pool_addr4_record *ip_pool_get_addr4(struct netdev *netd=
ev);
> =


This function is used exactly once, when the profile is loaded.  So it isn'=
t =

exactly on the hot-path where raw access to the store is needed.

Regards,
-Denis
--===============8090752877188364652==--

