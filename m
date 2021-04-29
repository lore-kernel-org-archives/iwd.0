Content-Type: multipart/mixed; boundary="===============5348780991921381702=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 4/6] ft: netdev: refactor FT-over-DS into two stages
Date: Thu, 29 Apr 2021 15:33:44 -0500
Message-ID: <9d65f059-f3c9-9f30-4e59-09c1df2d5db9@gmail.com>
In-Reply-To: <20210429194103.207447-4-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5348780991921381702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/29/21 2:41 PM, James Prestwood wrote:
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
>   src/ft.c     |  74 ++-----------------
>   src/ft.h     |   1 -
>   src/netdev.c | 203 ++++++++++++++++++++++++++++++++++++++++-----------
>   src/netdev.h |   8 ++
>   4 files changed, 176 insertions(+), 110 deletions(-)
> =


<snip>

> @@ -3719,44 +3732,58 @@ static void prepare_ft(struct netdev *netdev, str=
uct scan_bss *target_bss)
>   	}
>   }
>   =

> -static void netdev_ft_request_cb(struct l_genl_msg *msg, void *user_data)
> +static void netdev_ft_over_ds_auth_failed(struct ft_ds_info *ft,

So really you might as well just pass netdev_ft... objects around..

> +						uint16_t status)
>   {
> -	struct netdev *netdev =3D user_data;
> -	int err =3D l_genl_msg_get_error(msg);
> +	struct netdev_ft_over_ds_info *info =3D l_container_of(ft,
> +					struct netdev_ft_over_ds_info, super);

to maybe avoid the need for the container_of.  Using the superclass pattern=
 here =

is fine, but it is actually overkill since we will not have any other types=
.  So =

even just ft_ds_info_init/ft_ds_info_deinit would be fine, but what you hav=
e now =

fine as well.

> +	if (info->cb)
> +		info->cb(info->netdev, status, info->super.aa, info->user_data);
>   =

> -	if (err < 0) {
> -		l_error("Could not send CMD_FRAME (%d)", err);
> -		netdev_connect_failed(netdev,
> -					NETDEV_RESULT_AUTHENTICATION_FAILED,
> -					MMPDU_STATUS_CODE_UNSPECIFIED);
> -	}
> +	ft_ds_info_free(ft);
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
> +	struct ft_ds_info *ft;
> +	struct netdev_ft_over_ds_info *info;
>   	int ret;
>   	uint16_t status_code =3D MMPDU_STATUS_CODE_UNSPECIFIED;
> -	struct netdev *netdev =3D user_data;
>   =

> -	if (!netdev->ap || !netdev->in_ft)
> +	if (!netdev->ft_ds_info)
>   		return;
>   =

> -	ret =3D auth_proto_rx_authenticate(netdev->ap, body, body_len);
> +	ft =3D netdev->ft_ds_info;
> +	info =3D l_container_of(ft, struct netdev_ft_over_ds_info, super);

isn't just &ft_ds_info->super simpler?

> +
> +	l_timeout_remove(info->timeout);
> +	info->timeout =3D NULL;
> +
> +	ret =3D ft_over_ds_parse_action_response(ft, netdev->handshake,
> +						body, body_len);

So how do you know it isn't just a rogue frame?

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
>   	return;
>   =

>   ft_error:
> -	netdev_connect_failed(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
> -				status_code);
> -	return;
> +	l_debug("FT-over-DS to "MAC" failed", MAC_STR(info->super.aa));
> +
> +	netdev_ft_over_ds_auth_failed(ft, status_code);
>   }
>   =

>   static void netdev_qos_map_frame_event(const struct mmpdu_header *hdr,

<snip>

Regards,
-Denis
--===============5348780991921381702==--

