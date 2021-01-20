Content-Type: multipart/mixed; boundary="===============2338457421808015134=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/8] ap: add AP diagnostic interface
Date: Wed, 20 Jan 2021 14:11:58 -0600
Message-ID: <14796734-021a-d0b4-b955-f9c1a5b6be79@gmail.com>
In-Reply-To: <20210120183036.477287-4-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2338457421808015134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/20/21 12:30 PM, James Prestwood wrote:
> This adds a new AccessPointDiagnostic interface. This interface
> provides similar low level functionality as StationDiagnostic, but
> for when IWD is in AP mode. This uses netdev_get_all_stations
> which will dump all stations, parse, and return each station in
> an individual callback. Once the dump is complete the destroy is
> called and all data is packaged as an array of dictionaries.
> ---
>   src/ap.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 156 insertions(+)
> =

> diff --git a/src/ap.c b/src/ap.c
> index d9e7e404..6b3fb129 100644
> --- a/src/ap.c
> +++ b/src/ap.c
> @@ -2963,6 +2963,155 @@ static void ap_destroy_interface(void *user_data)
>   	l_free(ap_if);
>   }
>   =

> +struct diagnostic_data {
> +	struct l_dbus_message *pending;
> +	struct l_dbus_message_builder *builder;
> +};
> +
> +static void ap_get_station_cb(const struct netdev_station_info *info,
> +				void *user_data)
> +{
> +	struct diagnostic_data *data =3D user_data;
> +	int16_t rssi;
> +
> +	/* First station info */
> +	if (!data->builder) {
> +		struct l_dbus_message *reply =3D
> +				l_dbus_message_new_method_return(data->pending);
> +
> +		data->builder =3D l_dbus_message_builder_new(reply);
> +
> +		l_dbus_message_builder_enter_array(data->builder, "a{sv}");
> +	}
> +
> +	l_dbus_message_builder_enter_array(data->builder, "{sv}");
> +	dbus_append_dict_basic(data->builder, "Address", 's',
> +					util_address_to_string(info->addr));
> +
> +	rssi =3D (int16_t)info->cur_rssi;
> +
> +	if (info->have_cur_rssi)
> +		dbus_append_dict_basic(data->builder, "RSSI", 'n', &rssi);
> +
> +	if (info->have_rx_mcs) {
> +		switch (info->rx_mcs_type) {
> +		case NETDEV_MCS_TYPE_HT:
> +			dbus_append_dict_basic(data->builder, "RxMode", 's',
> +						"802.11n");
> +			dbus_append_dict_basic(data->builder, "RxMCS", 'y',
> +						&info->rx_mcs);
> +			break;
> +		case NETDEV_MCS_TYPE_VHT:
> +			dbus_append_dict_basic(data->builder, "RxMode", 's',
> +						"802.11ac");
> +			dbus_append_dict_basic(data->builder, "RxMCS", 'y',
> +						&info->rx_mcs);
> +			break;
> +		case NETDEV_MCS_TYPE_HE:
> +			dbus_append_dict_basic(data->builder, "RxMode", 's',
> +						"802.11ax");
> +			dbus_append_dict_basic(data->builder, "RxMCS", 'y',
> +						&info->rx_mcs);
> +			break;
> +		default:
> +			break;
> +		}
> +	}

This seems to be a copy-paste from station.c, should we add a utility funct=
ion =

for doing this somewhere?

> +
> +	if (info->have_tx_mcs) {
> +		switch (info->tx_mcs_type) {
> +		case NETDEV_MCS_TYPE_HT:
> +			dbus_append_dict_basic(data->builder, "TxMode", 's',
> +						"802.11n");
> +			dbus_append_dict_basic(data->builder, "TxMCS", 'y',
> +						&info->tx_mcs);
> +			break;
> +		case NETDEV_MCS_TYPE_VHT:
> +			dbus_append_dict_basic(data->builder, "TxMode", 's',
> +						"802.11ac");
> +			dbus_append_dict_basic(data->builder, "TxMCS", 'y',
> +						&info->tx_mcs);
> +			break;
> +		case NETDEV_MCS_TYPE_HE:
> +			dbus_append_dict_basic(data->builder, "TxMode", 's',
> +						"802.11ax");
> +			dbus_append_dict_basic(data->builder, "TxMCS", 'y',
> +						&info->tx_mcs);
> +			break;
> +		default:
> +			break;
> +		}
> +	}

Same as above.  Also seems that the basic structure is the same, only Rx/Tx =

prefix is different.  So maybe the two can be combined?

> +
> +	if (info->have_tx_bitrate)
> +		dbus_append_dict_basic(data->builder, "TxBitrate", 'u',
> +					&info->tx_bitrate);
> +
> +	if (info->have_rx_bitrate)
> +		dbus_append_dict_basic(data->builder, "RxBitrate", 'u',
> +					&info->rx_bitrate);
> +
> +	if (info->have_expected_throughput)
> +		dbus_append_dict_basic(data->builder, "ExpectedThroughput", 'u',
> +					&info->expected_throughput);
> +
> +	l_dbus_message_builder_leave_array(data->builder);
> +}
> +

<snip>

> +static void ap_setup_diagnostic_interface(struct l_dbus_interface *inter=
face)
> +{
> +	l_dbus_interface_method(interface, "GetDiagnostics", 0,
> +				ap_dbus_get_diagnostics, "aa{sv}", "", "diagnostic");

This seems to go over 80 chars

> +}
> +

Regards,
-Denis
--===============2338457421808015134==--

