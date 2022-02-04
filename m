Content-Type: multipart/mixed; boundary="===============3039976138471126418=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v4 7/7] hotspot: refactor dir watch to be like
 knownnetworks
Date: Fri, 04 Feb 2022 14:00:53 -0600
Message-ID: <b033b877-e2e5-f5d8-6cf7-14645de2baef@gmail.com>
In-Reply-To: 20220204173120.231730-7-prestwoj@gmail.com

--===============3039976138471126418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2/4/22 11:31, James Prestwood wrote:
> The create/removed/modified cases all can be combined like they are in
> known networks. Create/modified were both doing nearly the same thing,
> and removed can easily be detected if the config was already found.
> =

> This is now basically the same logic as in known networks.
> ---
>   src/hotspot.c | 57 ++++++++++++++++-----------------------------------
>   1 file changed, 18 insertions(+), 39 deletions(-)
> =

> diff --git a/src/hotspot.c b/src/hotspot.c
> index 832d7a31..1f9f74c5 100644
> --- a/src/hotspot.c
> +++ b/src/hotspot.c
> @@ -29,6 +29,7 @@
>   #include <stdio.h>
>   =

>   #include <ell/ell.h>
> +#include "ell/useful.h"
>   =

>   #include "src/iwd.h"
>   #include "src/module.h"
> @@ -409,7 +410,7 @@ static void hs20_dir_watch_cb(const char *filename,
>   				enum l_dir_watch_event event,
>   				void *user_data)
>   {
> -	struct l_settings *new;
> +	_auto_(l_settings_free) struct l_settings *new =3D NULL;
>   	uint64_t connected_time;
>   	struct hs20_config *hs20;
>   	struct network_config config;
> @@ -425,53 +426,31 @@ static void hs20_dir_watch_cb(const char *filename,
>   		return;
>   =

>   	full_path =3D storage_get_hotspot_path("%s", filename);
> +	hs20 =3D l_queue_find(hs20_settings, match_filename, full_path);
>   =

>   	switch (event) {
>   	case L_DIR_WATCH_EVENT_CREATED:
> -		new =3D l_settings_new();
> -
> -		if (!l_settings_load_from_file(new, full_path)) {
> -			l_settings_free(new);
> -			return;
> -		}
> -
> -		__network_config_parse(new, full_path, &config);
> -
> -		hs20 =3D hs20_config_new(new, full_path, &config);
> -		l_settings_free(new);
> -
> -		if (!hs20)
> -			return;
> -
> -		l_queue_push_head(hs20_settings, hs20);
> -		break;
>   	case L_DIR_WATCH_EVENT_REMOVED:
> -		hs20 =3D l_queue_remove_if(hs20_settings, match_filename,
> -						full_path);
> -		if (!hs20)
> -			return;
> -
> -		known_networks_remove(&hs20->super);
> -		break;
>   	case L_DIR_WATCH_EVENT_MODIFIED:
> -		hs20 =3D l_queue_find(hs20_settings, match_filename, full_path);
> -		if (!hs20)
> -			return;
> -

It seems that this logic is not being preserved with this patch.  Is this =

intentional?

>   		new =3D l_settings_new();
>   =

> -		if (!l_settings_load_from_file(new, full_path)) {
> -			l_settings_free(new);
> -			return;
> +		if (l_settings_load_from_file(new, full_path)) {
> +			__network_config_parse(new, full_path, &config);
> +
> +			if (hs20)
> +				known_network_update(&hs20->super, &config);
> +			else {
> +				hs20 =3D hs20_config_new(new, full_path, &config);
> +				if (!hs20)
> +					return;
> +
> +				l_queue_push_head(hs20_settings, hs20);
> +			}
> +		} else if (hs20) {
> +			l_queue_remove(hs20_settings, hs20);
> +			known_networks_remove(&hs20->super);
>   		}
>   =

> -		__network_config_parse(new, full_path, &config);
> -		known_network_update(&hs20->super, &config);
> -
> -		/* TODO: Update hotspot specific settings */
> -
> -		l_settings_free(new);
> -
>   		break;
>   	case L_DIR_WATCH_EVENT_ACCESSED:
>   		break;
> =


Regards,
-Denis
--===============3039976138471126418==--

