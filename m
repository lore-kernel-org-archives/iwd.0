Content-Type: multipart/mixed; boundary="===============0377791553587123302=="
MIME-Version: 1.0
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: Re: [RFC connman v2 1/1] WIP: Add wpa_supplicant WPA3-SAE support
Date: Fri, 30 Jul 2021 15:28:57 -0300
Message-ID: <8e29598a-fb6f-c3e8-0dbe-810cb2838aa0@collabora.com>
In-Reply-To: <20210527214134.33792-2-ariel.dalessandro@collabora.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0377791553587123302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

This patch has been merged already. However, I'd like to have your
comments, see below.

On 5/27/21 6:41 PM, Ariel D'Alessandro wrote:
> Implement WPA3-SAE authentication on connman side using wpa_supplicant
> backend.
> =

> Initially based on Tizen project:
> =

>   https://review.tizen.org/git/?p=3Dplatform/upstream/connman.git
> =

> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  gsupplicant/gsupplicant.h | 10 ++++++++++
>  gsupplicant/supplicant.c  | 33 ++++++++++++++++++++++++++++++---
>  plugins/wifi.c            | 21 +++++++++++++++++++++
>  3 files changed, 61 insertions(+), 3 deletions(-)
[snip]
> diff --git a/plugins/wifi.c b/plugins/wifi.c
> index 6233fe11..f990d40c 100644
> --- a/plugins/wifi.c
> +++ b/plugins/wifi.c[snip]> @@ -2148,6 +2153,7 @@ static GSupplicantSecur=
ity
network_security(const char *security)
>  =

>  static void ssid_init(GSupplicantSSID *ssid, struct connman_network *net=
work)
>  {
> +	struct wifi_network *network_data =3D connman_network_get_data(network);
>  	const char *security;
>  =

>  	memset(ssid, 0, sizeof(*ssid));
> @@ -2157,6 +2163,8 @@ static void ssid_init(GSupplicantSSID *ssid, struct=
 connman_network *network)
>  	ssid->scan_ssid =3D 1;
>  	security =3D connman_network_get_string(network, "WiFi.Security");
>  	ssid->security =3D network_security(security);
> +	ssid->keymgmt =3D network_data->keymgmt;
> +	ssid->ieee80211w =3D G_SUPPLICANT_MFP_OPTIONAL;

Should this be G_SUPPLICANT_MFP_REQUIRED?

According to wpa_supplicant docs [0] section "# ieee80211w:": it is
stated "WPA3-Personal-only mode: ieee80211w=3D2 and key_mgmt=3DSAE". This
means that the parameter ieee80211w has to be set to 2 (required) if SAE
is used.

Should this be fixed?

[0] https://w1.fi/cgit/hostap/plain/wpa_supplicant/wpa_supplicant.conf

Regards,
Ariel
--===============0377791553587123302==--

