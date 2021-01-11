Content-Type: multipart/mixed; boundary="===============4511643614182697269=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/8] station: create StationDiagnostic interface
Date: Mon, 11 Jan 2021 15:04:40 -0600
Message-ID: <a58b5539-5282-cbd0-ae7a-a277598fd179@gmail.com>
In-Reply-To: <20210111171239.472372-7-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4511643614182697269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/11/21 11:12 AM, James Prestwood wrote:
> This interface sits aside the regular station interface but
> provides low level connection details for diagnostic and
> testing purposes.
> ---
>   src/station.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 116 insertions(+)
> =


<snip>

> @@ -3455,6 +3459,111 @@ static void station_destroy_interface(void *user_=
data)
>   	station_free(station);
>   }
>   =

> +/*
> + * Helper to append a dictionary value. This will only work for basic ty=
pes.
> + */
> +static void append_dict(struct l_dbus_message_builder *builder,
> +			const char *name, const char *type, const void *data)
> +{
> +	l_dbus_message_builder_enter_dict(builder, "sv");
> +	l_dbus_message_builder_append_basic(builder, 's', name);
> +	l_dbus_message_builder_enter_variant(builder, type);
> +	l_dbus_message_builder_append_basic(builder, type[0], data);
> +	l_dbus_message_builder_leave_variant(builder);
> +	l_dbus_message_builder_leave_dict(builder);
> +}

Maybe this belongs in src/dbus.[ch] somewhere.

<snip>

> +static void station_get_diagnostic_cb(struct netdev *netdev,
> +					struct netdev_station_info *info,
> +					void *user_data)
> +{
> +	struct station *station =3D user_data;
> +	struct l_dbus_message *reply;
> +
> +	if (!info) {
> +		reply =3D dbus_error_aborted(station->get_station_pending);
> +		goto done;
> +	}
> +
> +	reply =3D l_dbus_message_new_method_return(station->get_station_pending=
);
> +
> +	station_build_diagnostic_dict(station, reply, info);

Not sure why you break this into a separate step?

> +
> +done:
> +	dbus_pending_reply(&station->get_station_pending, reply);
> +}
> +
> +static void station_get_diagnostic_destroy(void *user_data)
> +{
> +	struct station *station =3D user_data;
> +	struct l_dbus_message *reply;
> +
> +	if (station->get_station_pending) {
> +		reply =3D l_dbus_message_new_method_return(
> +						station->get_station_pending);

Hmm, an empty message?  Maybe use dbus_error_aborted instead?  See how devi=
ce.c =

does this for example.

> +		dbus_pending_reply(&station->get_station_pending, reply);
> +	}
> +}
> +
> +static struct l_dbus_message *station_get_diagnostics(struct l_dbus *dbu=
s,
> +						struct l_dbus_message *message,
> +						void *user_data)
> +{
> +	struct station *station =3D user_data;
> +
> +	/*
> +	 * At this time all values depend on a connected state.
> +	 */
> +	if (station->state !=3D STATION_STATE_CONNECTED)
> +		return dbus_error_not_connected(message);
> +
> +	if (netdev_get_station(station->netdev, station->connected_bss->addr,
> +				station_get_diagnostic_cb, station,
> +				station_get_diagnostic_destroy) < 0)
> +		return dbus_error_busy(message);

Maybe use dbus_error_from_errno instead?

> +
> +	station->get_station_pending =3D l_dbus_message_ref(message);
> +
> +	return NULL;
> +}
> +

<snip>

Regards,
-Denis
--===============4511643614182697269==--

