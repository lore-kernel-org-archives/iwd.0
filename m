Content-Type: multipart/mixed; boundary="===============0136812756609102431=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 2/2] hotspot: check if HESSID parses correctly
Date: Wed, 16 Oct 2019 18:34:48 -0500
Message-ID: <f7f2ed00-1fff-31b3-7acc-09a6682caaf4@gmail.com>
In-Reply-To: <20191016232151.11778-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0136812756609102431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/16/19 6:21 PM, James Prestwood wrote:
> ---
>   src/hotspot.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> =

> diff --git a/src/hotspot.c b/src/hotspot.c
> index ad8af37c..e3a7a07a 100644
> --- a/src/hotspot.c
> +++ b/src/hotspot.c
> @@ -342,7 +342,11 @@ static struct hs20_config *hs20_config_new(struct l_=
settings *settings,
>   	config =3D l_new(struct hs20_config, 1);
>   =

>   	if (hessid_str) {
> -		util_string_to_address(hessid_str, config->hessid);
> +		if (!util_string_to_address(hessid_str, config->hessid)) {
> +			l_error("Invalid HESSID in settings");
> +			goto free_values;
> +		}
> +

This still looks wrong since you're allocating config above

>   		l_free(hessid_str);
>   	}
>   =

> =


Regards,
-Denis
--===============0136812756609102431==--

