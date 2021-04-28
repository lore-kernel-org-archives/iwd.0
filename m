Content-Type: multipart/mixed; boundary="===============4274260243960235687=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/7] ft: refactor FT-over-DS into two stages
Date: Wed, 28 Apr 2021 15:04:19 -0500
Message-ID: <653dc83d-24f9-b0ff-70e6-df6e264e1ed2@gmail.com>
In-Reply-To: <20210427194945.49731-5-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4274260243960235687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/27/21 2:49 PM, James Prestwood wrote:
> FT-over-DS followed the same pattern as FT-over-Air which worked,
> but really limited how the protocol could be used. FT-over-DS is
> unique in that we can authenticate to many APs by sending out
> FT action frames and parsing the results. Once parsed IWD can
> immediately Reassociate, or do so at a later time.
> =

> To take advantage of this IWD need to separate FT-over-DS into
> two stages: action frame and reassociation.
> =

> The initial action frame stage is started by netdev. The target
> BSS is sent an FT action frame and a new cache entry is created
> in ft.c. Once the response is received the entry is updated
> with all the needed data to Reassociate. To limit the record
> keeping on netdev each FT-over-DS entry holds a userdata pointer
> so netdev doesn't need to maintain its own list of data for
> callbacks.
> =

> Once the action response is parsed netdev will call back signalling
> the action frame sequence was completed (either successfully or not).
> At this point the 'normal' FT procedure can start using the
> FT-over-DS auth-proto.
> ---
>   src/ft.c      |  95 ++++--------------
>   src/ft.h      |   1 -
>   src/netdev.c  | 262 ++++++++++++++++++++++++++++++++++++--------------
>   src/netdev.h  |  11 ++-

I wonder if the netdev changes can be broken up some more to make it easier=
 to =

see what's happening?

>   src/station.c |   3 +-
>   5 files changed, 224 insertions(+), 148 deletions(-)
> =


<snip>

> diff --git a/src/netdev.c b/src/netdev.c
> index 2dae07df..d0f9cae8 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -187,6 +187,14 @@ struct netdev_watch {
>   	void *user_data;
>   };
>   =

> +struct netdev_ft_over_ds_info {
> +	struct netdev *netdev;
> +	uint8_t addr[ETH_ALEN];
> +	struct l_timeout *timeout;
> +	netdev_ft_over_ds_cb_t cb;
> +	void *user_data;
> +};
> +

So what about declaring this something like:

struct netdev_ft_over_ds_info {
	struct ft_ds_info super;
	...
}

and book-keeping it directly in netdev?  That way you won't need much of th=
e =

cache/finding/removal API in ft.[ch].  But you can keep most of the parsing=
 in =

ft.c for convenience.

<snip>

> diff --git a/src/netdev.h b/src/netdev.h
> index 7b321bfb..bebde242 100644
> --- a/src/netdev.h
> +++ b/src/netdev.h
> @@ -124,6 +124,10 @@ typedef void (*netdev_get_station_cb_t)(
>   =

>   const char *netdev_iftype_to_string(uint32_t iftype);
>   =

> +typedef void (*netdev_ft_over_ds_cb_t)(struct netdev *netdev,
> +					uint16_t status, const uint8_t *bssid,
> +					void *user_data);
> +
>   struct wiphy *netdev_get_wiphy(struct netdev *netdev);
>   const uint8_t *netdev_get_address(struct netdev *netdev);
>   uint32_t netdev_get_ifindex(struct netdev *netdev);
> @@ -157,9 +161,14 @@ int netdev_reassociate(struct netdev *netdev, struct=
 scan_bss *target_bss,
>   			netdev_connect_cb_t cb, void *user_data);
>   int netdev_fast_transition(struct netdev *netdev, struct scan_bss *targ=
et_bss,
>   				netdev_connect_cb_t cb);
> +int netdev_fast_transition_over_ds_action(struct netdev *netdev,
> +					struct scan_bss *target_bss,
> +					netdev_ft_over_ds_cb_t cb,
> +					void *user_data);
>   int netdev_fast_transition_over_ds(struct netdev *netdev,
>   					struct scan_bss *target_bss,
> -					netdev_connect_cb_t cb);
> +					netdev_connect_cb_t cb,
> +					void *user_data);

Why does this have a user_data and netdev_fast_transition does not?

>   int netdev_preauthenticate(struct netdev *netdev, struct scan_bss *targ=
et_bss,
>   				netdev_preauthenticate_cb_t cb,
>   				void *user_data);

Regards,
-Denis
--===============4274260243960235687==--

