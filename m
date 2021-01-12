Content-Type: multipart/mixed; boundary="===============1936618658554858918=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 2/8] netdev: add netdev_get_station/current_station
Date: Tue, 12 Jan 2021 13:41:20 -0600
Message-ID: <08f2e6e7-c50b-2555-afb4-f61ca350c91d@gmail.com>
In-Reply-To: <20210112171723.3025-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1936618658554858918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/12/21 11:17 AM, James Prestwood wrote:
> This adds a generalized API for GET_STATION. This API handles
> calling and parsing the results into a new structure,
> netdev_station_info. This results structure will hold any
> data needed by consumers of netdev_get_station. A helper API
> (netdev_get_current_station) was added as a convenience which
> automatically passes handshake->aa as the MAC.
> =

> For now only the RSSI is parsed as this is already being
> done for RSSI polling/events. Looking further more info will
> be added such as rx/tx rates and estimated throughput.
> ---
>   src/netdev.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/netdev.h |  17 +++++++
>   2 files changed, 139 insertions(+)
> =


<snip>

> @@ -114,6 +114,16 @@ typedef void (*netdev_station_watch_func_t)(struct n=
etdev *netdev,
>   					const uint8_t *mac, bool added,
>   					void *user_data);
>   =

> +struct netdev_station_info {
> +	uint8_t addr[6];
> +	int8_t cur_rssi;
> +
> +	bool have_cur_rssi : 1;
> +};
> +
> +typedef void (*netdev_get_station_cb_t)(struct netdev_station_info *info,

I made this const struct netdev_station_info *

> +					void *user_data);
> +
>   struct wiphy *netdev_get_wiphy(struct netdev *netdev);
>   const uint8_t *netdev_get_address(struct netdev *netdev);
>   uint32_t netdev_get_ifindex(struct netdev *netdev);

Applied, thanks.

Regards,
-Denis
--===============1936618658554858918==--

