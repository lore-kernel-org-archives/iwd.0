Content-Type: multipart/mixed; boundary="===============0785551186732511217=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 03/10] dpp: generate URI on StartEnrollee
Date: Tue, 14 Dec 2021 17:28:00 -0600
Message-ID: <e8578c20-5a39-9a4d-28cf-cb128335fc3f@gmail.com>
In-Reply-To: 20211214181225.2308043-3-prestwoj@gmail.com

--===============0785551186732511217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/14/21 12:12 PM, James Prestwood wrote:
> Generates the required keys, hashes, and sets the Uri property
> ---
>   src/dpp.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 118 insertions(+), 2 deletions(-)
> =

> v2;
>   * Removed Frequency option and just choose a default
>   * Use 19 as the default group
> =


<snip>

> @@ -72,23 +111,100 @@ static void dpp_netdev_watch(struct netdev *netdev,
>   	}
>   }
>   =

> +static bool dpp_parse_enrollee_params(struct l_dbus_message *message,
> +					const char **info_out,
> +					const char **host_out)
> +{
> +	struct l_dbus_message_iter iter;
> +	struct l_dbus_message_iter variant;
> +	const char *key;
> +	char *info =3D NULL, *host =3D NULL;
> +
> +	if (!l_dbus_message_get_arguments(message, "a{sv}", &iter)) {
> +		l_error("Failed to parse StartEnrollee parameters");
> +		return false;
> +	}
> +
> +	while (l_dbus_message_iter_next_entry(&iter, &key, &variant)) {
> +		if (!strcmp(key, "Information")) {
> +			if (!l_dbus_message_iter_get_variant(&variant, "s",
> +								&info))
> +				return false;
> +		} else if (!strcmp(key, "Host")) {
> +			if (!l_dbus_message_iter_get_variant(&variant, "s",
> +								&host))
> +				return false;
> +		}
> +		/*
> +		 * TODO:
> +		 *  - Allow a MAC to be specififed, this would require changing
> +		 *    the device MAC prior to starting.
> +		 *  - Allow a custom key pair to be supplied, or some way of
> +		 *    deterministically generating one based on some seed.
> +		 */
> +	}
> +

Note that Information & Hostname have some limitations as to what character=
s are =

allowed.  DBus strings are valid UTF8 strings, but it seems EasyConnect spe=
c =

wants these to be ASCII sans ';' characters.  Given the lack of utility of =
these =

parameters, perhaps we should just drop them entirely.

> +	if (info_out && info)
> +		*info_out =3D info;
> +	else if (!info_out && info)
> +		l_free(info);
> +
> +	if (host_out && host)
> +		*host_out =3D host;
> +	else if (!host_out && host)
> +		l_free(host);
> +
> +	return true;
> +}
> +
>   static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *db=
us,
>   						struct l_dbus_message *message,
>   						void *user_data)
>   {
>   	struct dpp_sm *dpp =3D user_data;
> +	const char *info =3D NULL, *host =3D NULL;
> +	uint32_t freq =3D band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
>   =

>   	if (!netdev_get_is_up(dpp->netdev))
>   		return dbus_error_not_available(message);
>   =

> -	return dbus_error_not_supported(message);
> +	if (!dpp_parse_enrollee_params(message, &info, &host))
> +		return dbus_error_invalid_args(message);
> +
> +	dpp->curve =3D l_ecc_curve_from_ike_group(19);
> +	dpp->key_len =3D l_ecc_curve_get_scalar_bytes(dpp->curve);
> +	dpp->nonce_len =3D dpp_nonce_len_from_key_len(dpp->key_len);
> +

Since the curve is most likely always going to be the same, it might make s=
ense =

to initialize these parts when creating the dpp_sm object.

> +	l_ecdh_generate_key_pair(dpp->curve, &dpp->boot_private,
> +					&dpp->boot_public);

Similarly, maybe the boot key should be created only once or when the dpp_s=
m =

object is created?

> +
> +	dpp->pub_asn1 =3D l_ecc_point_to_asn1(dpp->boot_public,
> +						&dpp->pub_asn1_len);
> +
> +	dpp_hash(L_CHECKSUM_SHA256, dpp->pub_boot_hash, 1,
> +			dpp->pub_asn1, dpp->pub_asn1_len);
> +
> +	dpp->uri =3D dpp_generate_uri(dpp->pub_asn1, dpp->pub_asn1_len, 2,
> +					netdev_get_address(dpp->netdev), &freq,
> +					1, info, host);
> +
> +	l_debug("DPP Start Enrollee: %s", dpp->uri);
> +
> +	l_dbus_property_changed(dbus_get_bus(), netdev_get_path(dpp->netdev),
> +					IWD_DPP_INTERFACE, "Uri");

There is no such property now.  And you should return the uri string as par=
t of =

the method return.

> +
> +	return l_dbus_message_new_method_return(message);
>   }
>   =


<snip>

Regards,
-Denis
--===============0785551186732511217==--

