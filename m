Content-Type: multipart/mixed; boundary="===============8182100608778830712=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/7] wsc: Refactor to separate station-specific code
Date: Sun, 08 Dec 2019 22:40:00 -0600
Message-ID: <6166b743-403e-a0e1-0843-3bd0dc1800ed@gmail.com>
In-Reply-To: <20191205032244.5957-4-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8182100608778830712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 12/4/19 9:22 PM, Andrew Zaborowski wrote:
> Split the interface-specific logic out of the core WSC logic.  The core
> WSC code is the part that we can re-use between P2P and station and
> doesn't include the scanning for the target BSS or the attempt to make
> a station mode connection.
> ---
>   src/wsc.c | 141 ++++++++++++++++++++++++++++++++++++++----------------
>   src/wsc.h |   3 ++
>   2 files changed, 103 insertions(+), 41 deletions(-)
> =


<snip>

> @@ -224,33 +242,34 @@ static void wsc_connect_cb(struct netdev *netdev, e=
num netdev_result result,
>   =

>   	l_debug("%d, result: %d", netdev_get_ifindex(wsc->netdev), result);
>   =

> -	wsc->wsc_association =3D false;
> -
> -	l_settings_free(wsc->eap_settings);
> -	wsc->eap_settings =3D NULL;
> +	wsc_connect_cleanup(wsc);
>   =

>   	if (result =3D=3D NETDEV_RESULT_HANDSHAKE_FAILED && wsc->n_creds > 0) {
> -		wsc_store_credentials(wsc);
> -		wsc_try_credentials(wsc);
> +		struct wsc_credentials_info creds[L_ARRAY_SIZE(wsc->creds)];
> +		uint32_t n_creds =3D wsc->n_creds;
> +
> +		memcpy(creds, wsc->creds, sizeof(creds));
> +		explicit_bzero(wsc->creds, sizeof(creds));
> +		wsc->n_creds =3D 0;
> +		wsc->done_cb(0, creds, n_creds, wsc->done_data);
> +		explicit_bzero(creds, sizeof(creds));

Can you tell me why this temporary creds array is needed?  It would seem =

you can simply call done_cb with wsc->creds directly?

>   		return;
>   	}
>   =

>   	switch (result) {
>   	case NETDEV_RESULT_ABORTED:
> -		dbus_pending_reply(&wsc->pending,
> -					dbus_error_aborted(wsc->pending));
> +		wsc->done_cb(-ECANCELED, NULL, 0, wsc->done_data);
>   		return;
>   	case NETDEV_RESULT_HANDSHAKE_FAILED:
> -		dbus_pending_reply(&wsc->pending,
> -					wsc_error_no_credentials(wsc->pending));
> +		wsc->done_cb(-ENOKEY, NULL, 0, wsc->done_data);
>   		break;
>   	default:
> -		dbus_pending_reply(&wsc->pending,
> -					dbus_error_failed(wsc->pending));
> +		wsc->done_cb(-EIO, NULL, 0, wsc->done_data);
>   		break;
>   	}
>   =

> -	station_set_autoconnect(wsc->station, true);
> +	if (wsc->station)
> +		station_set_autoconnect(wsc->station, true);
>   }
>   =

>   static void wsc_credential_obtained(struct wsc *wsc,
> @@ -452,30 +471,24 @@ static void wsc_connect(struct wsc *wsc)
>   	l_settings_set_uint(settings, "WSC", "RFBand",
>   					freq_to_rf_band(bss->frequency));
>   	l_settings_set_uint(settings, "WSC", "ConfigurationMethods",
> -				WSC_CONFIGURATION_METHOD_VIRTUAL_DISPLAY_PIN |
> -				WSC_CONFIGURATION_METHOD_VIRTUAL_PUSH_BUTTON |
> -				WSC_CONFIGURATION_METHOD_KEYPAD);
> +					wsc->config_method);

This part seems tricky.  You remove DISPLAY_PIN and use either =

PUSH_BUTTON or KEYPAD below.  This won't really work as the spec =

mandates that the DISPLAY bit is used specially and we sort of depend on =

that to be set.  See Section 7.4.3, item 2.  Without Display bit set we =

can't use 4 digit PINs.  Not that this is a good idea, but still...

Also, (a bit fuzzy now, so I might be incorrect here) we might be the =

initiator on a device with no keypad.  So we auto-generate the PIN, =

display it to the user and the user has to enter it into the AP UI.

Generally I find the specs to be rather fuzzy on the use of =

Configuration Methods attribute.  Probe Requests should contain all =

methods we support, and seemingly M1 messages should as well.

I think you probably want to use the DPID as the selector here instead.

>   	l_settings_set_string(settings, "WSC", "PrimaryDeviceType",
>   					"0-00000000-0");
>   	l_settings_set_string(settings, "WSC", "EnrolleeMAC",
>   		util_address_to_string(netdev_get_address(wsc->netdev)));
>   =

> -	if (!strcmp(l_dbus_message_get_member(wsc->pending), "StartPin")) {
> -		const char *pin;
> -
> -		if (l_dbus_message_get_arguments(wsc->pending, "s", &pin)) {
> -			enum wsc_device_password_id dpid;
> +	if (wsc->config_method =3D=3D WSC_CONFIGURATION_METHOD_KEYPAD) {
> +		enum wsc_device_password_id dpid;
>   =

> -			if (strlen(pin) =3D=3D 4 || wsc_pin_is_checksum_valid(pin))
> -				dpid =3D WSC_DEVICE_PASSWORD_ID_DEFAULT;
> -			else
> -				dpid =3D WSC_DEVICE_PASSWORD_ID_USER_SPECIFIED;
> +		if (strlen(wsc->pin) =3D=3D 4 ||
> +				wsc_pin_is_checksum_valid(wsc->pin))
> +			dpid =3D WSC_DEVICE_PASSWORD_ID_DEFAULT;
> +		else
> +			dpid =3D WSC_DEVICE_PASSWORD_ID_USER_SPECIFIED;
>   =

> -			l_settings_set_uint(settings, "WSC",
> -						"DevicePasswordId", dpid);
> -			l_settings_set_string(settings, "WSC",
> -						"DevicePassword", pin);
> -		}
> +		l_settings_set_uint(settings, "WSC", "DevicePasswordId", dpid);
> +		l_settings_set_string(settings, "WSC", "DevicePassword",
> +					wsc->pin);
>   	}
>   =

>   	handshake_state_set_event_func(hs, wsc_handshake_event, wsc);

<snip>

> @@ -541,6 +587,22 @@ static void wsc_check_can_connect(struct wsc *wsc, s=
truct scan_bss *target)
>   	wsc->target =3D target;
>   	station_set_autoconnect(wsc->station, false);
>   =

> +	if (!strcmp(l_dbus_message_get_member(wsc->pending), "StartPin")) {
> +		char *pin;
> +
> +		wsc->config_method =3D WSC_CONFIGURATION_METHOD_KEYPAD;
> +
> +		if (!l_dbus_message_get_arguments(wsc->pending, "s", &pin))
> +			goto error;
> +
> +		wsc->pin =3D l_strdup(pin);
> +	} else
> +		wsc->config_method =3D
> +			WSC_CONFIGURATION_METHOD_VIRTUAL_PUSH_BUTTON;
> +
> +	wsc->done_cb =3D wsc_dbus_done_cb;
> +	wsc->done_data =3D wsc;
> +

So this might need to be reworked, see above...

>   	switch (station_get_state(wsc->station)) {
>   	case STATION_STATE_DISCONNECTED:
>   		wsc_connect(wsc);

Regards,
-Denis
--===============8182100608778830712==--

