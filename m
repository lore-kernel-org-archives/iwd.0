Content-Type: multipart/mixed; boundary="===============2611452346040143311=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [connman v1] wifi: Set ieee80211w as required for
 WPA3-Personal-only mode
Date: Tue, 03 Aug 2021 09:41:04 +0200
Message-ID: <20210803074104.dawii3v3bknovg2e@beryllium.lan>
In-Reply-To: <20210802151006.28183-1-ariel.dalessandro@collabora.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2611452346040143311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ariel,

Thanks for tracking this! Just a stupid question:

On Mon, Aug 02, 2021 at 12:10:06PM -0300, Ariel D'Alessandro wrote:
> From wpa_supplicant docs [0] section "ieee80211w":
> =

>   "WPA3-Personal-only mode: ieee80211w=3D2 and key_mgmt=3DSAE".
> =

> This means that the parameter ieee80211w has to be set to 2 (required)
> if SAE is used. Fix it.
> =

> [0] https://w1.fi/cgit/hostap/plain/wpa_supplicant/wpa_supplicant.conf
> ---
>  plugins/wifi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> =

> diff --git a/plugins/wifi.c b/plugins/wifi.c
> index 578b4be7..02603e85 100644
> --- a/plugins/wifi.c
> +++ b/plugins/wifi.c
> @@ -2174,7 +2174,12 @@ static void ssid_init(GSupplicantSSID *ssid, struc=
t connman_network *network)
>  	security =3D connman_network_get_string(network, "WiFi.Security");
>  	ssid->security =3D network_security(security);
>  	ssid->keymgmt =3D network_data->keymgmt;
> -	ssid->ieee80211w =3D G_SUPPLICANT_MFP_OPTIONAL;
> +	/*
> +	 * From wpa_supplicant docs:
> +	 * "WPA3-Personal-only mode: ieee80211w=3D2 and key_mgmt=3DSAE".
> +	 * Set ieee80211w as required, which is sent if SAE key is used.
> +	 */
> +	ssid->ieee80211w =3D G_SUPPLICANT_MFP_REQUIRED;

Should we check the keymgmt is SAE and only then set the ieee80211w
value?

Thanks,
Daniel
--===============2611452346040143311==--

