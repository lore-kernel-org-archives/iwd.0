Content-Type: multipart/mixed; boundary="===============7994535175344988187=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] ap: Drop struct ap_config in favor of l_settings
Date: Mon, 26 Apr 2021 11:39:07 -0500
Message-ID: <49a98fb0-ba15-6339-db94-7f1991a401a4@gmail.com>
In-Reply-To: <20210426132638.758600-3-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7994535175344988187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 4/26/21 8:26 AM, Andrew Zaborowski wrote:
> Change ap_start to load all of the AP configuration from a struct
> l_settings, moving the 6 or so parameters from struct ap_config members
> to the l_settings groups and keys.  This extends the ap profile concept
> used for the DHCP settings.  ap_start callers create the l_settings
> object and fill the values in it or read the settings in from a file.
> =

> Since ap_setup_dhcp and ap_load_profile_and_dhcp no longer do the
> settings file loading, they needed to be refactored and some issues were
> fixed in their logic, e.g. l_dhcp_server_set_ip_address() was never
> called when the "IP pool" was used.  Also the IP pool was previously only
> used if the ap->config->profile was NULL and this didn't match what the
> docs said:
> "If [IPv4].Address is not provided and no IP address is set on the
> interface prior to calling StartProfile the IP pool will be used."
> ---
>   src/ap.c  | 542 ++++++++++++++++++++++++++++++++----------------------
>   src/ap.h  |  19 +-
>   src/p2p.c |  53 ++++--
>   3 files changed, 354 insertions(+), 260 deletions(-)
> =

> diff --git a/src/ap.c b/src/ap.c
> index 46821c04..d8b2a441 100644
> --- a/src/ap.c
> +++ b/src/ap.c
> @@ -61,7 +61,15 @@ struct ap_state {
>   	const struct ap_ops *ops;
>   	ap_stopped_func_t stopped_func;
>   	void *user_data;
> -	struct ap_config *config;
> +
> +	char ssid[33];
> +	char passphrase[64];
> +	uint8_t psk[32];
> +	uint8_t channel;
> +	uint8_t *authorized_macs;
> +	unsigned int authorized_macs_num;
> +	char wsc_name[33];
> +	struct wsc_primary_device_type wsc_primary_device_type;
>   =

>   	unsigned int ciphers;
>   	enum ie_rsn_cipher_suite group_cipher;

<snip>

> @@ -666,25 +661,23 @@ static size_t ap_write_wsc_ie(struct ap_state *ap,
>   =

>   		wsc_pr.response_type =3D WSC_RESPONSE_TYPE_AP;
>   		memcpy(wsc_pr.uuid_e, ap->wsc_uuid_r, sizeof(wsc_pr.uuid_e));
> -		wsc_pr.primary_device_type =3D
> -			ap->config->wsc_primary_device_type;
> +		wsc_pr.primary_device_type =3D ap->wsc_primary_device_type;
>   =

> -		if (ap->config->wsc_name)
> -			l_strlcpy(wsc_pr.device_name, ap->config->wsc_name,
> +		if (ap->wsc_name)

Hmm, isn't this always true?

> +			l_strlcpy(wsc_pr.device_name, ap->wsc_name,
>   					sizeof(wsc_pr.device_name));
>   =

>   		wsc_pr.config_methods =3D
>   			WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
>   =

> -		if (ap->config->authorized_macs_num) {
> -			size_t len;
> +		if (ap->authorized_macs_num) {
> +			size_t len =3D ap->authorized_macs_num * 6;
>   =

> -			len =3D ap->config->authorized_macs_num * 6;
>   			if (len > sizeof(wsc_pr.authorized_macs))
>   				len =3D sizeof(wsc_pr.authorized_macs);
>   =

>   			memcpy(wsc_pr.authorized_macs,
> -				ap->config->authorized_macs, len);
> +				ap->authorized_macs, len);
>   		}

For a future patch maybe, but should this be commonized? here and ..

>   =

>   		wsc_data =3D wsc_build_probe_response(&wsc_pr, &wsc_data_size);
> @@ -701,15 +694,14 @@ static size_t ap_write_wsc_ie(struct ap_state *ap,
>   				WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
>   		}
>   =

> -		if (ap->config->authorized_macs_num) {
> -			size_t len;
> +		if (ap->authorized_macs_num) {
> +			size_t len =3D ap->authorized_macs_num * 6;
>   =

> -			len =3D ap->config->authorized_macs_num * 6;
>   			if (len > sizeof(wsc_beacon.authorized_macs))
>   				len =3D sizeof(wsc_beacon.authorized_macs);
>   =

>   			memcpy(wsc_beacon.authorized_macs,
> -				ap->config->authorized_macs, len);
> +				ap->authorized_macs, len);

.. here is almost the same code

>   		}
>   =

>   		wsc_data =3D wsc_build_beacon(&wsc_beacon, &wsc_data_size);

<snip>

> @@ -2715,24 +2654,196 @@ static int ap_load_profile_and_dhcp(struct ap_st=
ate *ap, bool *wait_dhcp)
>   		err =3D 0;
>   	}
>   =

> -cleanup:
> -	l_settings_free(settings);
>   	return err;
>   }
>   =

> +static bool ap_load_psk(struct ap_state *ap, const struct l_settings *co=
nfig)
> +{
> +	size_t psk_len;
> +	L_AUTO_FREE_VAR(uint8_t *, psk) =3D l_settings_get_bytes(config,
> +								"Security",
> +								"PreSharedKey",
> +								&psk_len);
> +	L_AUTO_FREE_VAR(char *, passphrase) =3D l_settings_get_string(config,
> +								"Security",
> +								"Passphrase");
> +	int err;
> +
> +	if (l_settings_get_value(config, "Security", "PreSharedKey")) {

Hmm, you already used get_bytes beforehand, why use get_value again?  Perha=
ps =

using has_key would be clearer?

i.e. if (l_settings_has_key(config, "Security", "PreSharedKey") {
L_AUTO_FREE psk =3D ...

if (!psk)
...

> +		if (!psk || psk_len !=3D 32) {
> +			l_error("AP [Security].PreSharedKey must be a 32-byte "
> +				"hexstring");
> +			return false;
> +		}
> +
> +		memcpy(ap->psk, psk, 32);
> +		return true;
> +	}
> +
> +	if (!passphrase) {

If the PSK is valid, you never get to this check...?  Should probably be do=
ne =

first...

> +		l_error("AP requires one of [Security].PreSharedKey or "
> +			"[Security].Passphrase to be present");
> +		return false;
> +	}
> +
> +	if (strlen(passphrase) > 63) {
> +		l_error("AP [Security].Passphrase must not exceed "
> +			"63 characters");
> +		return false;
> +	}
> +
> +	err =3D crypto_psk_from_passphrase(passphrase, (uint8_t *) ap->ssid,
> +						strlen(ap->ssid), ap->psk);
> +	if (err < 0) {
> +		l_error("AP couldn't generate the PSK from given "
> +			"[Security].Passphrase value: %s (%i)",
> +			strerror(-err), -err);
> +		return false;
> +	}
> +
> +	strcpy(ap->passphrase, passphrase);
> +	return true;
> +}
> +
> +static int ap_load_config(struct ap_state *ap, const struct l_settings *=
config,
> +				bool *out_wait_dhcp, bool *out_cck_rates)
> +{
> +	size_t len;
> +	L_AUTO_FREE_VAR(char *, strval) =3D NULL;
> +	int err;
> +
> +	strval =3D l_settings_get_string(config, "General", "SSID");
> +	if (L_WARN_ON(!strval))

This is user-input, why L_WARN_ON?

> +		return -ENOMSG;
> +
> +	len =3D strlen(strval);
> +	if (len < 1 || len > 32) {
> +		l_error("AP SSID length outside the [1, 32] range");
> +		return -EINVAL;
> +	}
> +
> +	if (L_WARN_ON(!l_utf8_validate(strval, len, NULL)))
> +		return -EINVAL;

Same here...?

> +
> +	strcpy(ap->ssid, strval);
> +	l_free(l_steal_ptr(strval));
> +
> +	if (!ap_load_psk(ap, config))
> +		return -EINVAL;
> +
> +	/*
> +	 * This loads DHCP settings either from the l_settings object or uses
> +	 * the defaults. wait_on_address will be set true if an address change
> +	 * is required.
> +	 */
> +	err =3D ap_load_dhcp(ap, config, out_wait_dhcp);
> +	if (err)
> +		return err;
> +
> +	if (l_settings_get_value(config, "General", "Channel")) {

has_key might be better

> +		unsigned int uintval;
> +
> +		if (!l_settings_get_uint(config, "General", "Channel",
> +						&uintval) ||
> +				!scan_channel_to_freq(uintval,
> +							SCAN_BAND_2_4_GHZ)) {
> +			l_error("AP Channel value unsupported");
> +			return -EINVAL;
> +		}
> +
> +		ap->channel =3D uintval;
> +	} else
> +		/* TODO: Start a Get Survey to decide the channel */
> +		ap->channel =3D 6;
> +
> +	strval =3D l_settings_get_string(config, "WSC", "DeviceName");
> +	if (strval) {
> +		len =3D strlen(strval);
> +
> +		if (len > 32) {
> +			l_error("AP WSC name length outside the [1, 32] range");
> +			return -EINVAL;
> +		}
> +
> +		if (L_WARN_ON(!l_utf8_validate(strval, len, NULL)))
> +			return -EINVAL;

l_error?

> +
> +		strcpy(ap->wsc_name, strval);
> +		l_free(l_steal_ptr(strval));
> +	} else
> +		memcpy(ap->wsc_name, ap->ssid, 33);
> +
> +	strval =3D l_settings_get_string(config, "WSC", "PrimaryDeviceType");
> +	if (strval) {
> +		bool ok =3D wsc_device_type_from_setting_str(strval,
> +						&ap->wsc_primary_device_type);
> +
> +		if (!ok) {
> +			l_error("AP [WSC].PrimaryDeviceType format unknown");
> +			return -EINVAL;
> +		}
> +	} else {
> +		/* Make ourselves a WFA standard PC by default */
> +		ap->wsc_primary_device_type.category =3D 1;
> +		memcpy(ap->wsc_primary_device_type.oui, wsc_wfa_oui, 3);
> +		ap->wsc_primary_device_type.oui_type =3D 0x04;
> +		ap->wsc_primary_device_type.subcategory =3D 1;
> +	}
> +
> +	if (l_settings_get_value(config, "WSC", "AuthorizedMACs")) {
> +		char **strvval;
> +		unsigned int i;
> +
> +		strvval =3D l_settings_get_string_list(config, "WSC",
> +							"AuthorizedMACs", ',');
> +		if (!strvval) {
> +			l_error("AP Authorized MACs list format wrong");
> +			return -EINVAL;
> +		}
> +
> +		ap->authorized_macs_num =3D l_strv_length(strvval);
> +		ap->authorized_macs =3D l_malloc(ap->authorized_macs_num * 6);
> +
> +		for (i =3D 0; strvval[i]; i++)
> +			if (!util_string_to_address(strvval[i],
> +						ap->authorized_macs + i * 6)) {
> +				l_error("Bad authorized MAC format: %s",
> +					strvval[i]);
> +				l_strfreev(strvval);
> +				return -EINVAL;
> +			}
> +
> +		l_strfreev(strvval);
> +	}
> +
> +	if (l_settings_get_value(config, "General", "NoCCKRates")) {
> +		bool boolval;
> +
> +		if (!l_settings_get_bool(config, "General", "NoCCKRates",
> +						&boolval)) {
> +			l_error("AP [General].NoCCKRates not a valid "
> +				"boolean");
> +			return -EINVAL;
> +		}
> +
> +		*out_cck_rates =3D !boolval;
> +	} else
> +		*out_cck_rates =3D true;
> +
> +	return 0;
> +}
> +

<snip>

Regards,
-Denis
--===============7994535175344988187==--

