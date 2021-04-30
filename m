Content-Type: multipart/mixed; boundary="===============1736224941634918892=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 5/7] ft: netdev: refactor FT-over-DS into two stages
Date: Fri, 30 Apr 2021 10:17:42 -0500
Message-ID: <3472a3f0-9857-32b5-7c7f-744f124e3af0@gmail.com>
In-Reply-To: <20210429230841.222368-5-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1736224941634918892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/29/21 6:08 PM, James Prestwood wrote:
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
>   src/ft.c     |  74 +++----------------
>   src/ft.h     |   1 -
>   src/netdev.c | 196 ++++++++++++++++++++++++++++++++++++++++-----------
>   src/netdev.h |   8 +++
>   4 files changed, 169 insertions(+), 110 deletions(-)
> =


<snip>

> @@ -3719,44 +3732,52 @@ static void prepare_ft(struct netdev *netdev, str=
uct scan_bss *target_bss)
>   	}
>   }
>   =

> -static void netdev_ft_request_cb(struct l_genl_msg *msg, void *user_data)
> +static void netdev_ft_over_ds_auth_failed(struct netdev_ft_over_ds_info =
*info,
> +						uint16_t status)
>   {
> -	struct netdev *netdev =3D user_data;
> -	int err =3D l_genl_msg_get_error(msg);
> +	if (info->cb)
> +		info->cb(info->netdev, status, info->super.aa, info->user_data);
>   =

> -	if (err < 0) {
> -		l_error("Could not send CMD_FRAME (%d)", err);
> -		netdev_connect_failed(netdev,
> -					NETDEV_RESULT_AUTHENTICATION_FAILED,
> -					MMPDU_STATUS_CODE_UNSPECIFIED);
> -	}
> +	ft_ds_info_free(&info->super);
> +
> +	info->netdev->ft_ds_info =3D NULL;
>   }
>   =

>   static void netdev_ft_response_frame_event(const struct mmpdu_header *h=
dr,
>   					const void *body, size_t body_len,
>   					int rssi, void *user_data)
>   {
> +	struct netdev *netdev =3D user_data;
> +	struct netdev_ft_over_ds_info *info =3D netdev->ft_ds_info;
>   	int ret;
>   	uint16_t status_code =3D MMPDU_STATUS_CODE_UNSPECIFIED;
> -	struct netdev *netdev =3D user_data;
>   =

> -	if (!netdev->ap || !netdev->in_ft)
> +	if (!info)
>   		return;
>   =

> -	ret =3D auth_proto_rx_authenticate(netdev->ap, body, body_len);
> +	l_timeout_remove(info->timeout);
> +	info->timeout =3D NULL;
> +

So why do you kill the timeout before checking whether the frame was valid =
or not?

> +	ret =3D ft_over_ds_parse_action_response(&info->super, netdev->handshak=
e,
> +						body, body_len);
>   	if (ret < 0)
> -		goto ft_error;
> -	else if (ret > 0) {
> +		return;
> +
> +	/* Now make sure the packet contained a success status code */
> +	if (ret > 0) {
>   		status_code =3D (uint16_t)ret;
>   		goto ft_error;
>   	}
>   =

> +	if (info->cb)
> +		info->cb(netdev, 0, info->super.aa, info->user_data);
> +

Do you need to set a flag of some sort to indicate that the info has been f=
illed =

successfully?

>   	return;
>   =

>   ft_error:
> -	netdev_connect_failed(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
> -				status_code);
> -	return;
> +	l_debug("FT-over-DS to "MAC" failed", MAC_STR(info->super.aa));
> +
> +	netdev_ft_over_ds_auth_failed(info, status_code);
>   }
>   =

>   static void netdev_qos_map_frame_event(const struct mmpdu_header *hdr,

<snip>

> @@ -3855,6 +3853,11 @@ int netdev_fast_transition_over_ds(struct netdev *=
netdev,
>   					struct scan_bss *target_bss,
>   					netdev_connect_cb_t cb)
>   {
> +	struct netdev_ft_over_ds_info *info =3D netdev->ft_ds_info;
> +
> +	if (!info)
> +		return -ENOENT;
> +
>   	if (!netdev->operational)
>   		return -ENOTCONN;
>   =

> @@ -3865,13 +3868,14 @@ int netdev_fast_transition_over_ds(struct netdev =
*netdev,
>   =

>   	prepare_ft(netdev, target_bss);
>   =

> -	handshake_state_new_snonce(netdev->handshake);
> +	if (!ft_over_ds_prepare_handshake(&info->super, netdev->handshake))
> +		return -ENOENT;

This function doesn't seem to fail?

> diff --git a/src/netdev.h b/src/netdev.h
> index 43ea3893..2f7f3647 100644
> --- a/src/netdev.h
> +++ b/src/netdev.h
> @@ -125,6 +125,10 @@ typedef void (*netdev_get_station_cb_t)(
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
> @@ -158,6 +162,10 @@ int netdev_reassociate(struct netdev *netdev, struct=
 scan_bss *target_bss,
>   			netdev_connect_cb_t cb, void *user_data);
>   int netdev_fast_transition(struct netdev *netdev, struct scan_bss *targ=
et_bss,
>   				netdev_connect_cb_t cb);
> +int netdev_fast_transition_over_ds_action(struct netdev *netdev,
> +					struct scan_bss *target_bss,

Ideally you should use const struct scan_bss * whenever possible.

> +					netdev_ft_over_ds_cb_t cb,
> +					void *user_data);
>   int netdev_fast_transition_over_ds(struct netdev *netdev,
>   					struct scan_bss *target_bss,
>   					netdev_connect_cb_t cb);
> =


Regards,
-Denis
--===============1736224941634918892==--

