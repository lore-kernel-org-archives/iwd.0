Content-Type: multipart/mixed; boundary="===============2140223139813971426=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/5] station: add ConnectBssid() developer method
Date: Fri, 06 Aug 2021 22:42:26 -0500
Message-ID: <4935304d-5e5a-a7d2-8070-46c09a332b41@gmail.com>
In-Reply-To: <20210806230212.381657-5-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2140223139813971426==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/6/21 6:02 PM, James Prestwood wrote:
> This method will initiate a connection to a specific BSS rather
> than relying on a network based connection (which the user has
> no control over which specific BSS is selected).
> ---
>   src/station.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 98 insertions(+)
> =


<snip>

> @@ -3751,6 +3759,42 @@ invalid_args:
>   	return dbus_error_invalid_args(message);
>   }
>   =

> +static struct network *station_find_network_from_bss(struct station *sta=
tion,
> +						struct scan_bss *bss)
> +{
> +	struct ie_rsn_info info;
> +	int r;
> +	enum security security;
> +	const char *path;
> +	char ssid[33];
> +
> +	memcpy(ssid, bss->ssid, bss->ssid_len);
> +	ssid[bss->ssid_len] =3D '\0';
> +
> +	r =3D scan_bss_get_rsn_info(bss, &info);
> +	if (r < 0) {
> +		if (r !=3D -ENOENT)
> +			return NULL;
> +
> +		security =3D security_determine(bss->capability, NULL);
> +	} else
> +		security =3D security_determine(bss->capability, &info);
> +
> +	path =3D iwd_network_get_path(station, ssid, security);
> +
> +	return l_hashmap_lookup(station->networks, path);

Looks like station_add_seen_bss() does pretty much the same, so should this=
 be a =

utility function that is used by both?

> +}
> +
> +static bool find_bss_by_addr(const void *a, const void *b)

station.c already has bss_match_bssid()

> +{
> +	const struct scan_bss *bss =3D a;
> +
> +	if (!memcmp(bss->addr, b, 6))
> +		return true;
> +
> +	return false;
> +}
> +
>   static void station_setup_diagnostic_interface(
>   					struct l_dbus_interface *interface)
>   {

Regards,
-Denis
--===============2140223139813971426==--

