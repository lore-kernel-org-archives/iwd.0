Content-Type: multipart/mixed; boundary="===============0469856493388944926=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC connman v1 1/1] gsupplicant: Add support for WPA3-Personal
 transition mode
Date: Thu, 05 Aug 2021 08:07:50 +0200
Message-ID: <20210805060750.kbrvx5uouuq37egk@beryllium.lan>
In-Reply-To: <20210804212315.265376-2-ariel.dalessandro@collabora.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0469856493388944926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[adding the new mailing list]

On Wed, Aug 04, 2021 at 06:23:15PM -0300, Ariel D'Alessandro wrote:
> This commit adds support for WPA3-Personal transition mode, which
> supports both WPA2-Personal (PSK) and WPA3-Personal (SAE).
> =

> Based on the AP accepted key management protocols, connman configures
> wpa_supplicant as follows:
> =

> * WPA3-Personal-only mode: key_mgmt=3D"SAE" ; ieee80211w=3D2
> * WPA3-Personal transition mode: key_mgmt=3D"SAE WPA-PSK" ; ieee80211w=3D1
> =

> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  gsupplicant/supplicant.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> =

> diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
> index 58c78fd1..8316f48a 100644
> --- a/gsupplicant/supplicant.c
> +++ b/gsupplicant/supplicant.c
> @@ -4903,17 +4903,16 @@ static void add_network_security_proto(DBusMessag=
eIter *dict,
>  	g_free(proto);
>  }
>  =

> -static void add_network_ieee80211w(DBusMessageIter *dict, GSupplicantSSI=
D *ssid)
> +static void add_network_ieee80211w(DBusMessageIter *dict, GSupplicantSSI=
D *ssid,
> +				   GSupplicantMfpOptions ieee80211w)
>  {
> -	if (!(ssid->keymgmt & G_SUPPLICANT_KEYMGMT_SAE))
> -		return;
> -
>  	supplicant_dbus_dict_append_basic(dict, "ieee80211w", DBUS_TYPE_UINT32,
> -					  &ssid->ieee80211w);
> +					  &ieee80211w);
>  }
>  =

>  static void add_network_security(DBusMessageIter *dict, GSupplicantSSID =
*ssid)
>  {
> +	GSupplicantMfpOptions ieee80211w;
>  	char *key_mgmt;
>  =

>  	switch (ssid->security) {
> @@ -4929,10 +4928,22 @@ static void add_network_security(DBusMessageIter =
*dict, GSupplicantSSID *ssid)
>  		add_network_security_ciphers(dict, ssid);
>  		break;
>  	case G_SUPPLICANT_SECURITY_PSK:
> -		if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_SAE)
> -			key_mgmt =3D "SAE";
> -		else
> +		if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_SAE) {
> +			if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_WPA_PSK) {
> +				/*
> +				 * WPA3-Personal transition mode: supports both
> +				 * WPA2-Personal (PSK) and WPA3-Personal (SAE)
> +				 */
> +				key_mgmt =3D "SAE WPA-PSK";
> +				ieee80211w =3D G_SUPPLICANT_MFP_OPTIONAL;
> +			} else {
> +				key_mgmt =3D "SAE";
> +				ieee80211w =3D G_SUPPLICANT_MFP_REQUIRED;
> +			}
> +			add_network_ieee80211w(dict, ssid, ieee80211w);
> +		} else {
>  			key_mgmt =3D "WPA-PSK";
> +		}
>  		add_network_security_psk(dict, ssid);
>  		add_network_security_ciphers(dict, ssid);
>  		add_network_security_proto(dict, ssid);
> @@ -4994,8 +5005,6 @@ static void interface_add_network_params(DBusMessag=
eIter *iter, void *user_data)
>  =

>  	add_network_security(&dict, ssid);
>  =

> -	add_network_ieee80211w(&dict, ssid);
> -
>  	supplicant_dbus_dict_append_fixed_array(&dict, "ssid",
>  					DBUS_TYPE_BYTE, &ssid->ssid,
>  						ssid->ssid_len);
> -- =

> 2.30.2
>=20
--===============0469856493388944926==--

