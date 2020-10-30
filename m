Content-Type: multipart/mixed; boundary="===============4639961032536863687=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] ap: add StartWithConfig DBus method
Date: Fri, 30 Oct 2020 13:37:06 -0500
Message-ID: <a15dfd36-254e-08d8-bf7c-9554b26409d8@gmail.com>
In-Reply-To: <20201030163413.2446645-4-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4639961032536863687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/30/20 11:34 AM, James Prestwood wrote:
> Users can now start an AP from settings based off a config file
> on disk. The only argument is the SSID which will be used to
> lookup the ap_config loaded during ap_init.
> ---
>   src/ap.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> =

> diff --git a/src/ap.c b/src/ap.c
> index 956b7be9..92e8ce62 100644
> --- a/src/ap.c
> +++ b/src/ap.c
> @@ -2711,6 +2711,44 @@ static struct l_dbus_message *ap_dbus_stop(struct =
l_dbus *dbus,
>   	return NULL;
>   }
>   =

> +static bool match_ssid(const void *a, const void *data)
> +{
> +	const struct ap_config *config =3D a;
> +	const char *ssid =3D data;
> +
> +	return !strcmp(config->ssid, ssid);
> +}
> +
> +static struct l_dbus_message *ap_dbus_start_with_config(struct l_dbus *d=
bus,
> +						struct l_dbus_message *message,
> +						void *user_data)
> +{
> +	struct ap_if_data *ap_if =3D user_data;
> +	const char *ssid;
> +	struct ap_config *config;
> +	int err;
> +
> +	if (ap_if->ap && ap_if->ap->started)
> +		return dbus_error_already_exists(message);
> +
> +	if (ap_if->ap || ap_if->pending)
> +		return dbus_error_busy(message);
> +
> +	if (!l_dbus_message_get_arguments(message, "s", &ssid))
> +		return dbus_error_invalid_args(message);
> +

You may want to check that the SSID is valid if the profile is SSID based.

> +	config =3D l_queue_find(ap_configs, match_ssid, ssid);
> +	if (!config)
> +		return dbus_error_not_found(message);

Question, why store the profiles in a list when you could simply try and lo=
ad =

the profile here?  Then you wouldn't really need to distinguish between =

filesystem and non-filesystem based ap_configs.

> +
> +	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, &err, ap_if=
);
> +	if (!ap_if->ap)
> +		return dbus_error_from_errno(err, message);
> +
> +	ap_if->pending =3D l_dbus_message_ref(message);
> +	return NULL;
> +}
> +
>   static bool ap_dbus_property_get_started(struct l_dbus *dbus,
>   					struct l_dbus_message *message,
>   					struct l_dbus_message_builder *builder,
> @@ -2729,6 +2767,9 @@ static void ap_setup_interface(struct l_dbus_interf=
ace *interface)
>   	l_dbus_interface_method(interface, "Start", 0, ap_dbus_start, "",
>   			"ss", "ssid", "wpa2_passphrase");
>   	l_dbus_interface_method(interface, "Stop", 0, ap_dbus_stop, "", "");
> +	l_dbus_interface_method(interface, "StartWithConfig", 0,

Lets try to avoid shortened words in the API.  StartWithConfiguration or =

StartProfile would be better.

> +					ap_dbus_start_with_config, "", "s",
> +					"ssid");
>   =

>   	l_dbus_interface_property(interface, "Started", 0, "b",
>   					ap_dbus_property_get_started, NULL);
> =


Regards,
-Denis
--===============4639961032536863687==--

