Content-Type: multipart/mixed; boundary="===============0692126442754129347=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 04/11] ap: Add subnet address selection logic
Date: Tue, 11 May 2021 10:06:09 -0500
Message-ID: <bff1b2f2-c61e-bc8a-0574-ce371a897ec2@gmail.com>
In-Reply-To: <20210510085806.174213-4-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0692126442754129347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/10/21 3:57 AM, Andrew Zaborowski wrote:
> Add the ap_select_addr4 function to select a random subnet of requested
> size from an address space defined by a string list (for use with the
> AP profile [IPv4].Address and the global [IPv4].APAddressPool settings),
> avoiding those subnets that conflict with subnets from a second list.
> We take care to give a similar weight to all subnets contained in the
> specified ranges regardless of how many ranges contain each, basically
> so that overlapping ranges don't affect the probabilities (debatable.)
> =

> This is added as src/ap-addr.c so that it's self-contained.
> ---
>   Makefile.am   |   3 +-
>   src/ap-addr.c | 231 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/ap.h      |   9 ++
>   3 files changed, 242 insertions(+), 1 deletion(-)
>   create mode 100644 src/ap-addr.c
> =


I would rather we made this into a self contained module that pays attentio=
n to =

RTNL and tracks any addresses added / removed.  That way the caller isn't f=
orced =

into performing an RTNL dump first...

> diff --git a/src/ap.h b/src/ap.h
> index b0100f34..2163d2db 100644
> --- a/src/ap.h
> +++ b/src/ap.h
> @@ -97,3 +97,12 @@ bool ap_station_disconnect(struct ap_state *ap, const =
uint8_t *mac,
>   =

>   bool ap_push_button(struct ap_state *ap);
>   void ap_update_beacon(struct ap_state *ap);
> +
> +struct ap_rtnl_addr4_record {
> +	uint32_t addr;
> +	uint8_t prefix_len;
> +};
> +
> +int ap_select_addr4(const char **addr_str_list, uint8_t prefix,
> +			const struct l_queue *used_addr_dump,
> +			uint32_t *out_addr);
> =


Do we have a chance of collisions if 2 APs are brought up simultaneously? =

Should there be an explicit reserve / release semantic?  I know you use =

l_getrandom to pick the subnet, but what if the IP pool size is pretty smal=
l?

Regards,
-Denis
--===============0692126442754129347==--

