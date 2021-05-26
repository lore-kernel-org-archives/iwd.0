Content-Type: multipart/mixed; boundary="===============3394171306125280741=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/7] ip-pool: Add subnet address selection logic
Date: Wed, 26 May 2021 14:56:39 -0500
Message-ID: <c119acaf-d675-fca9-62a4-87fcefca4000@gmail.com>
In-Reply-To: <20210525125508.2695708-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3394171306125280741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/25/21 7:55 AM, Andrew Zaborowski wrote:
> Add the ip_pool_select_addr4 function to select a random subnet of reques=
ted
> size from an address space defined by a string list (for use with the
> AP profile [IPv4].Address and the global [IPv4].APAddressPool settings),
> avoiding those subnets that conflict with subnets in use.  We take care
> to give a similar weight to all subnets contained in the specified
> ranges regardless of how many ranges contain each, basically so that
> overlapping ranges don't affect the probabilities (debatable.)
> ---
>   src/ip-pool.c | 207 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/ip-pool.h |   2 +
>   2 files changed, 209 insertions(+)
> =


<snip>

> diff --git a/src/ip-pool.h b/src/ip-pool.h
> index 6a220735..8c75d03e 100644
> --- a/src/ip-pool.h
> +++ b/src/ip-pool.h
> @@ -29,4 +29,6 @@ struct ip_pool_addr4_record {
>   	bool secondary;
>   };
>   =

> +int ip_pool_select_addr4(const char **addr_str_list, uint8_t prefix,
> +				struct netdev *netdev, uint32_t *out_addr);
>   const struct ip_pool_addr4_record *ip_pool_get_addr4(struct netdev *net=
dev);
> =


Similarly to previous patch, do we really need the netdev object here?

Also, what is 'prefix'?  It looks like it is used to convey the desired pre=
fix =

length size.  So should it be named appropriately?  Maybe target_prefix_len?

Do you really need the netdev argument? It looks like it is used to skip ad=
ding =

that netdev's addresses to the 'used' list.  Why?  How likely is this to ha=
ppen? =

  Can't we just leave those alone and assign a new subnet regardless? Or ha=
ve AP =

wipe the addresses first?

Regards,
-Denis
--===============3394171306125280741==--

