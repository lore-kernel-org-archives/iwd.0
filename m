Content-Type: multipart/mixed; boundary="===============3807566566409955123=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 11/16] eap-wsc: Registrar mode settings loading
Date: Thu, 13 Aug 2020 11:16:04 -0500
Message-ID: <67228342-87d2-9b90-8f45-8aa4b93478e3@gmail.com>
In-Reply-To: <20200813005338.295108-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3807566566409955123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/12/20 7:53 PM, Andrew Zaborowski wrote:
> Alongside the current EAP-WSC enrollee side support, add the initial
> part of registrar side.  In the same file, register a new method with
> the name string of "WSC-R".  In this patch only the load_settings
> method is added.  validate_identity and handle_response are added in
> later patches.
> ---
>   src/eap-wsc.c | 433 +++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 325 insertions(+), 108 deletions(-)
> =


<snip>

> +static bool eap_wsc_load_common(struct eap_state *eap,
> +					struct l_settings *settings,
> +					bool registrar)

so based on the name, I'd expect this function to do the common things, not =

if-else everything based on registrar variable.  The if-else also leads to =

excessive nesting, which we should avoid...

Perhaps it would be nicer if things that are only applicable to the particu=
lar =

role are moved in the specific load_settings functions below.

> +{
> +	struct eap_wsc_state *wsc;
> +	const char *v;
> +	uint8_t private_key[192];
> +	size_t len;
> +	unsigned int u32;
> +	char *str;
> +
> +	wsc =3D l_new(struct eap_wsc_state, 1);
> +	wsc->registrar =3D registrar;
> +
> +	if (registrar)
> +		wsc->state =3D STATE_EXPECT_IDENTITY;
> +	else
> +		wsc->state =3D STATE_EXPECT_START;

This for example can be set directly without a need for if-else

> +
> +	/*
> +	 * On the Enrollee we fill in all of the M1 data so that it's ready
> +	 * to send.  On the Registrar we store some information in wsc->m1
> +	 * for the actual M1's validation, and we fill in the elements of M2
> +	 * that don't depend on the received M1 data.
> +	 */
> +	wsc->m1 =3D l_new(struct wsc_m1, 1);
> +
> +	if (registrar)
> +		wsc->m2 =3D l_new(struct wsc_m2, 1);
> +	else {
> +		wsc->m1->version2 =3D true;
> +		wsc->m1->state =3D WSC_STATE_NOT_CONFIGURED;
> +		wsc->m1->association_state =3D WSC_ASSOCIATION_STATE_NOT_ASSOCIATED;
> +		wsc->m1->configuration_error =3D WSC_CONFIGURATION_ERROR_NO_ERROR;
> +
> +		wsc->m1->auth_type_flags =3D
> +					WSC_AUTHENTICATION_TYPE_WPA2_PERSONAL |
> +					WSC_AUTHENTICATION_TYPE_WPA_PERSONAL |
> +					WSC_AUTHENTICATION_TYPE_OPEN;
> +		wsc->m1->encryption_type_flags =3D WSC_ENCRYPTION_TYPE_NONE |
> +						WSC_ENCRYPTION_TYPE_AES_TKIP;
> +		wsc->m1->connection_type_flags =3D WSC_CONNECTION_TYPE_ESS;

This can be set up directly in the enrolee version.

> +	}
> +
> +	v =3D l_settings_get_value(settings, "WSC", "EnrolleeMAC");
> +	if (!v)
> +		goto err;
> +
> +	if (!util_string_to_address(v, wsc->m1->addr))
> +		goto err;
> +
> +	if (!wsc_uuid_from_addr(wsc->m1->addr, wsc->m1->uuid_e))
> +		goto err;
> +

This is common, so maybe just assume m1/m2 are created by the enrollee/regi=
strar =

specific methods.

> +	if (registrar && !load_hexencoded(settings, "UUID-R",
> +						wsc->m2->uuid_r, 16))
> +		goto err;

This can be put into the registrar method directly

> +
> +	if (!l_settings_get_uint(settings, "WSC", "ConfigurationMethods", &u32))
> +		u32 =3D WSC_CONFIGURATION_METHOD_VIRTUAL_DISPLAY_PIN;
> +
> +	if (!registrar)
> +		wsc->m1->config_methods =3D u32;
> +	else
> +		wsc->m2->config_methods =3D u32;
> +

Ok

> +	if (!registrar) {
> +		if (!load_device_data(settings,
> +					wsc->m1->manufacturer,
> +					wsc->m1->model_name,
> +					wsc->m1->model_number,
> +					wsc->m1->serial_number,
> +					&wsc->m1->primary_device_type,
> +					wsc->m1->device_name,
> +					&wsc->m1->rf_bands,
> +					&wsc->m1->os_version))
> +			goto err;
> +	} else {
> +		if (!load_device_data(settings,
> +					wsc->m2->manufacturer,
> +					wsc->m2->model_name,
> +					wsc->m2->model_number,
> +					wsc->m2->serial_number,
> +					&wsc->m2->primary_device_type,
> +					wsc->m2->device_name,
> +					&wsc->m2->rf_bands,
> +					&wsc->m2->os_version))
> +			goto err;
> +	}
>  =


Probably these belong in the enrolee/registrar specific methods

>   	if (!l_settings_get_uint(settings, "WSC", "DevicePasswordId", &u32))
>   		u32 =3D WSC_DEVICE_PASSWORD_ID_PUSH_BUTTON;
>   =

> -	wsc->m1->device_password_id =3D u32;
> +	if (!registrar)
> +		wsc->m1->device_password_id =3D u32;
> +	else
> +		wsc->m2->device_password_id =3D u32;
>   =

>   	wsc->device_password =3D l_settings_get_string(settings, "WSC",
>   							"DevicePassword");
> @@ -1361,11 +1411,141 @@ static bool eap_wsc_load_settings(struct eap_sta=
te *eap,
>   	} else
>   		wsc->device_password =3D l_strdup("00000000");
>   =

> -	if (!load_hexencoded(settings, "E-SNonce1", wsc->e_snonce1, 16))
> -		l_getrandom(wsc->e_snonce1, 16);
> +	if (registrar) {
> +		wsc->m2->auth_type_flags =3D 0;
>   =

> -	if (!load_hexencoded(settings, "E-SNonce2", wsc->e_snonce2, 16))
> -		l_getrandom(wsc->e_snonce2, 16);
> +		str =3D l_settings_get_string(settings, "WSC", "WPA2-SSID");
> +		if (str) {
> +			if (strlen(str) > 32)
> +				goto err;
> +
> +			wsc->m2->auth_type_flags |=3D
> +				WSC_AUTHENTICATION_TYPE_WPA2_PERSONAL;
> +			wsc->m2->encryption_type_flags |=3D
> +				WSC_ENCRYPTION_TYPE_AES_TKIP;
> +			wsc->wpa2_cred.auth_type =3D
> +				WSC_AUTHENTICATION_TYPE_WPA2_PERSONAL;
> +			wsc->wpa2_cred.encryption_type =3D
> +				WSC_ENCRYPTION_TYPE_AES_TKIP;
> +
> +			wsc->wpa2_cred.ssid_len =3D strlen(str);
> +			memcpy(wsc->wpa2_cred.ssid, str,
> +				wsc->wpa2_cred.ssid_len);
> +			l_free(str);
> +
> +			str =3D l_settings_get_string(settings, "WSC",
> +							"WPA2-Passphrase");
> +			if (str) {
> +				len =3D strlen(str);
> +				if (len < 8 || len > 63) {
> +					explicit_bzero(str, len);
> +					goto err;
> +				}
> +
> +				memcpy(wsc->wpa2_cred.network_key, str, len);
> +				wsc->wpa2_cred.network_key_len =3D len;
> +				explicit_bzero(str, len);
> +			} else {
> +				uint8_t buf[32];
> +				int i;
> +				static const char hexdigits[16] =3D
> +					"0123456789ABCDEF";
> +
> +				if (!load_hexencoded(settings, "WPA2-PSK",
> +							buf, 32))
> +					goto err;
> +
> +				for (i =3D 0; i < 32; i++) {
> +					wsc->wpa2_cred.network_key[i * 2] =3D
> +						hexdigits[buf[i] >> 4];
> +					wsc->wpa2_cred.network_key[i * 2 + 1] =3D
> +						hexdigits[buf[i] & 15];
> +				}

Hmm, what is this doing actually?  Is this some elaborate scheme to make su=
re =

that WPA2-PSK is a valid hex string?

> +
> +				wsc->wpa2_cred.network_key_len =3D 64;
> +				explicit_bzero(buf, 32);
> +			}
> +
> +			memcpy(wsc->wpa2_cred.addr, wsc->m1->addr, 6);
> +		}
> +
> +		str =3D l_settings_get_string(settings, "WSC", "Open-SSID");
> +		if (str) {
> +			if (strlen(str) > 32)
> +				goto err;
> +
> +			wsc->m2->auth_type_flags |=3D
> +				WSC_AUTHENTICATION_TYPE_OPEN;
> +			wsc->m2->encryption_type_flags |=3D
> +				WSC_ENCRYPTION_TYPE_NONE;
> +			wsc->open_cred.auth_type =3D
> +				WSC_AUTHENTICATION_TYPE_OPEN;
> +			wsc->open_cred.encryption_type =3D
> +				WSC_ENCRYPTION_TYPE_NONE;
> +
> +			wsc->open_cred.ssid_len =3D strlen(str);
> +			memcpy(wsc->open_cred.ssid, str,
> +				wsc->open_cred.ssid_len);
> +			l_free(str);
> +
> +			wsc->open_cred.network_key_len =3D 0;
> +
> +			memcpy(wsc->open_cred.addr, wsc->m1->addr, 6);
> +		}
> +
> +		if (!wsc->m2->auth_type_flags)
> +			goto err;
> +
> +		wsc->m2->connection_type_flags =3D WSC_CONNECTION_TYPE_ESS;
> +	}

This whole block seems to be registrar specific...

> +
> +	/*
> +	 * The settings we read below probably shouldn't be used except to
> +	 * eliminate randomness in debugging/tests.
> +	 */
> +	if (registrar) {
> +		if (!load_hexencoded(settings, "RegistrarNonce",
> +						wsc->m2->registrar_nonce, 16))
> +			l_getrandom(wsc->m2->registrar_nonce, 16);
> +	} else {
> +		if (!load_hexencoded(settings, "EnrolleeNonce",
> +						wsc->m1->enrollee_nonce, 16))
> +			l_getrandom(wsc->m1->enrollee_nonce, 16);
> +	}
> +

Individual methods here?

> +	if (load_hexencoded(settings, "PrivateKey", private_key, 192)) {
> +		if (!l_key_validate_dh_payload(private_key, 192,
> +						crypto_dh5_prime,
> +						crypto_dh5_prime_size)) {
> +			explicit_bzero(private_key, 192);
> +			goto err;
> +		}
> +
> +		wsc->private =3D l_key_new(L_KEY_RAW, private_key, 192);
> +		explicit_bzero(private_key, 192);
> +	} else
> +		wsc->private =3D l_key_generate_dh_private(crypto_dh5_prime,
> +							crypto_dh5_prime_size);
> +
> +	if (!wsc->private)
> +		goto err;
> +
> +	len =3D sizeof(wsc->m1->public_key);
> +	if (!l_key_compute_dh_public(dh5_generator, wsc->private, dh5_prime,
> +					registrar ? wsc->m2->public_key :
> +					wsc->m1->public_key, &len))
> +		goto err;
> +
> +	if (len !=3D sizeof(wsc->m1->public_key))
> +		goto err;

Ok

> +
> +	if (!load_hexencoded(settings, registrar ? "R-SNonce1" : "E-SNonce1",
> +							wsc->local_snonce1, 16))
> +		l_getrandom(wsc->local_snonce1, 16);
> +
> +	if (!load_hexencoded(settings, registrar ? "R-SNonce2" : "E-SNonce2",
> +							wsc->local_snonce2, 16))
> +		l_getrandom(wsc->local_snonce2, 16);

Ok

>   =

>   	if (!load_hexencoded(settings, "IV1", wsc->iv1, 16))
>   		l_getrandom(wsc->iv1, 16);
> @@ -1373,6 +1553,9 @@ static bool eap_wsc_load_settings(struct eap_state =
*eap,
>   	if (!load_hexencoded(settings, "IV2", wsc->iv2, 16))
>   		l_getrandom(wsc->iv2, 16);
>   =

> +	if (registrar && !load_hexencoded(settings, "IV3", wsc->iv3, 16))
> +		l_getrandom(wsc->iv3, 16);
> +

Seems registrar specific here as well..

>   	eap_set_data(eap, wsc);
>   =

>   	return true;
> @@ -1387,12 +1570,22 @@ err:
>   	if (wsc->private)
>   		l_key_free(wsc->private);
>   =

> +	explicit_bzero(&wsc->wpa2_cred, sizeof(struct wsc_credential));
> +	explicit_bzero(&wsc->open_cred, sizeof(struct wsc_credential));
>   	l_free(wsc->m1);
> +	l_free(wsc->m2);
>   	l_free(wsc);

In theory this cleanup block can be broken up to be more granular.  For exa=
mple, =

the cred zeroing can be done only in the registrar loader.

But you also have most of this being done in eap_wsc_free, so depending on =
how =

lazy you want to be, consider just calling that, or break it up into smalle=
r =

chunks and just call the relevant _free method.

>   =

>   	return false;
>   }
>   =


Regards,
-Denis
--===============3807566566409955123==--

