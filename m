Content-Type: multipart/mixed; boundary="===============1686706972440787775=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/8] netdev: add netdev_get_station
Date: Mon, 11 Jan 2021 14:49:34 -0600
Message-ID: <942c0148-7da3-d984-2670-923df7755011@gmail.com>
In-Reply-To: <20210111171239.472372-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1686706972440787775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/11/21 11:12 AM, James Prestwood wrote:
> This adds a generalized API for GET_STATION. This API handles
> calling and parsing the results into a new structure,
> netdev_station_info. This results structure will hold any
> data needed by consumers of netdev_get_station.
> =

> For now only the RSSI is parsed as this is already being
> done for RSSI polling/events. Looking further more info will
> be added such as rx/tx rates and estimated throughput.
> ---
>   src/netdev.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/netdev.h |  12 ++++++
>   2 files changed, 115 insertions(+)
> =


<snip>

> +int netdev_get_station(struct netdev *netdev, const uint8_t *mac,
> +			netdev_get_station_cb_t cb, void *user_data,
> +			netdev_destroy_func_t destroy)
> +{
> +	struct l_genl_msg *msg;
> +
> +	if (netdev->get_station_cmd_id)
> +		return -EBUSY;
> +
> +	msg =3D l_genl_msg_new_sized(NL80211_CMD_GET_STATION, 64);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
> +	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, mac);
> +
> +	netdev->get_station_cmd_id =3D l_genl_family_send(nl80211, msg,
> +						netdev_get_station_cb, netdev,
> +						netdev_get_station_destroy);
> +	if (!netdev->get_station_cmd_id)
> +		return -EIO;

I think you're leaking msg here

> +
> +	netdev->get_station_cb =3D cb;
> +	netdev->get_station_data =3D user_data;
> +	netdev->get_station_destroy =3D destroy;
> +
> +	return 0;
> +}
> +
>   static int netdev_cqm_rssi_update(struct netdev *netdev)
>   {
>   	struct l_genl_msg *msg;
> diff --git a/src/netdev.h b/src/netdev.h
> index 65fdbaaf..5cf38076 100644
> --- a/src/netdev.h
> +++ b/src/netdev.h
> @@ -114,6 +114,14 @@ typedef void (*netdev_station_watch_func_t)(struct n=
etdev *netdev,
>   					const uint8_t *mac, bool added,
>   					void *user_data);
>   =

> +struct netdev_station_info {
> +	int8_t cur_rssi;
> +};
> +
> +typedef void (*netdev_get_station_cb_t)(struct netdev *netdev,
> +					struct netdev_station_info *info,

const struct netdev_...?

> +					void *user_data);
> +
>   struct wiphy *netdev_get_wiphy(struct netdev *netdev);
>   const uint8_t *netdev_get_address(struct netdev *netdev);
>   uint32_t netdev_get_ifindex(struct netdev *netdev);
> @@ -174,6 +182,10 @@ int netdev_neighbor_report_req(struct netdev *netdev,
>   int netdev_set_rssi_report_levels(struct netdev *netdev, const int8_t *=
levels,
>   					size_t levels_num);
>   =

> +int netdev_get_station(struct netdev *netdev, const uint8_t *mac,

Do you want to add a convenience method to grab the current station?  The m=
ac =

parameter is for cases where you might have multiple ones, like AP.

> +			netdev_get_station_cb_t cb, void *user_data,
> +			netdev_destroy_func_t destroy);
> +
>   void netdev_handshake_failed(struct handshake_state *hs, uint16_t reaso=
n_code);
>   =

>   struct netdev *netdev_find(int ifindex);
> =


Regards,
-Denis
--===============1686706972440787775==--

