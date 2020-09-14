Content-Type: multipart/mixed; boundary="===============8524907968430638772=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/8] ap: Support working without passphrase
Date: Mon, 14 Sep 2020 11:44:43 -0500
Message-ID: <c149c009-5133-71c5-0d1d-93bc588247d0@gmail.com>
In-Reply-To: <20200911195103.385070-7-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8524907968430638772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/11/20 2:51 PM, Andrew Zaborowski wrote:
> Add a "psk" setting to allow the user to pass the binary PSK directly
> instead of generating it from the passphrase and the SSID.  In that case
> we'll only send the PSK to WSC enrollees.
> ---
>   src/ap.c | 40 ++++++++++++++++++++++++++--------------
>   src/ap.h |  3 ++-
>   2 files changed, 28 insertions(+), 15 deletions(-)
> =


<snip>

> @@ -794,8 +792,18 @@ static void ap_start_eap_wsc(struct sta_state *sta)
>   				WSC_CONFIGURATION_METHOD_PUSH_BUTTON);
>   	l_settings_set_string(sta->wsc_settings, "WSC", "WPA2-SSID",
>   				ap->config->ssid);
> -	l_settings_set_string(sta->wsc_settings, "WSC", "WPA2-Passphrase",
> -				ap->config->psk);
> +
> +	if (ap->config->passphrase)
> +		l_settings_set_string(sta->wsc_settings,
> +					"WSC", "WPA2-Passphrase",
> +					ap->config->passphrase);
> +	else {
> +		L_AUTO_FREE_VAR(char *, psk_str) =3D
> +			l_util_hexstring(ap->config->psk, 32);
> +
> +		l_settings_set_string(sta->wsc_settings,
> +					"WSC", "WPA2-PSK", psk_str);

Just nitpicking, but, maybe we should consider adding l_settings_set_hexstr=
ing();

> +	}
>   =

>   	sta->hs =3D netdev_handshake_state_new(ap->netdev);
>   	handshake_state_set_authenticator(sta->hs, true);
> @@ -2037,8 +2045,9 @@ static void ap_mlme_notify(struct l_genl_msg *msg, =
void *user_data)
>    * @ops.handle_event is required and must react to AP_EVENT_START_FAILED
>    * and AP_EVENT_STOPPING by forgetting the ap_state struct, which is
>    * going to be freed automatically.
> - * In the @config struct only .ssid and .psk need to be non-NULL,
> - * other fields are optional.  If @ap_start succeeds, the returned
> + * In the @config struct only .ssid and either of .passprhase and .psk
> + * need to be present, other fields are optional.  If .psk is used

Not sure I can parse the last sentence here..?

> + * whenever .passphrase is NULL.  If @ap_start succeeds, the returned
>    * ap_state takes ownership of @config and the caller shouldn't
>    * free it or any of the memory pointed to by its members (they
>    * also can't be static).
> @@ -2097,8 +2106,11 @@ struct ap_state *ap_start(struct netdev *netdev, s=
truct ap_config *config,
>   =

>   	wsc_uuid_from_addr(netdev_get_address(netdev), ap->wsc_uuid_r);
>   =

> -	if (crypto_psk_from_passphrase(config->psk, (uint8_t *) config->ssid,
> -					strlen(config->ssid), ap->pmk) < 0)
> +	if (!config->passphrase &&

This part seems like it should be config->passphrase?

> +			crypto_psk_from_passphrase(config->passphrase,
> +						(uint8_t *) config->ssid,
> +						strlen(config->ssid),
> +						config->psk) < 0)

In other words, if passphrase && passphrase derivation fails, then error.

>   		goto error;

Also, should there be a sanity check that psk was provided somehow?

>   =

>   	if (!frame_watch_add(wdev_id, 0, 0x0000 |
> @@ -2395,7 +2407,7 @@ static struct l_dbus_message *ap_dbus_start(struct =
l_dbus *dbus,
>   =

>   	config =3D l_new(struct ap_config, 1);
>   	config->ssid =3D l_strdup(ssid);
> -	config->psk =3D l_strdup(wpa2_psk);
> +	config->passphrase =3D l_strdup(wpa2_psk);

This argument should probably be renamed.

>   =

>   	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, ap_if);
>   	if (!ap_if->ap) {
> diff --git a/src/ap.h b/src/ap.h
> index bbfecd6d..4232a735 100644
> --- a/src/ap.h
> +++ b/src/ap.h
> @@ -56,7 +56,8 @@ typedef void (*ap_stopped_func_t)(void *user_data);
>   =

>   struct ap_config {
>   	char *ssid;
> -	char *psk;
> +	char *passphrase;

In theory passphrase is 63 bytes, so no real need to malloc...

> +	uint8_t psk[32];
>   	uint8_t channel;
>   	uint8_t *authorized_macs;
>   	unsigned int authorized_macs_num;
> =


Regards,
-Denis
--===============8524907968430638772==--

