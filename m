Content-Type: multipart/mixed; boundary="===============9165331677066090765=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/8] ap: Refactor global address pool loading
Date: Tue, 01 Jun 2021 10:14:25 -0500
Message-ID: <6f05e4a5-61d3-26b2-ea1f-c50024317320@gmail.com>
In-Reply-To: <20210528004737.2878442-4-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9165331677066090765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 5/27/21 7:47 PM, Andrew Zaborowski wrote:
> Deprecate the global [General].APRanges setting in favour of
> [IPv4].APAddressPool with an extended (but backwards-compatible) syntax.
> Drop the existing address pool creation code.
> =

> The new APAddressPool setting has the same syntax as the profile-local
> [IPv4].Address setting and the subnet selection code will fall back
> to the global setting if it's missing, this way we use common code to
> handle both settings.
> ---
>   src/ap.c | 185 +++++++++++++------------------------------------------
>   1 file changed, 42 insertions(+), 143 deletions(-)
> =


<snip>

> +	if (netconfig_enabled) {
> +		if (l_settings_get_value(settings, "IPv4", "APAddressPool")) {
> +			global_addr4_strs =3D l_settings_get_string_list(settings,
> +								"IPv4",
> +								"APAddressPool",
> +								',');
> +			if (!global_addr4_strs || !*global_addr4_strs) {
> +				l_error("Can't parse the [IPv4].APAddressPool "
> +					"setting as a string list");
> +				l_strv_free(global_addr4_strs);
> +				global_addr4_strs =3D NULL;
> +			}
> +		} else if (l_settings_get_value(settings,
> +						"General", "APRanges")) {
> +			global_addr4_strs =3D l_settings_get_string_list(settings,
> +								"General",
> +								"APRanges",
> +								',');

Do you want to print a warning that this setting is deprecated?

> +			if (!global_addr4_strs || !*global_addr4_strs) {
> +				l_error("Can't parse the [General].APRanges "
> +					"setting as a string list");
> +				l_strv_free(global_addr4_strs);
> +				global_addr4_strs =3D NULL;
> +			}
>   		}
>   =


Applied, thanks.

Regards,
-Denis

--===============9165331677066090765==--

