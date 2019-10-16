Content-Type: multipart/mixed; boundary="===============6003208005901007581=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 05/10] hotspot: fix multiple potential memory leaks
Date: Wed, 16 Oct 2019 18:18:34 -0500
Message-ID: <f966bfa8-d847-8820-14d5-804aa6f10197@gmail.com>
In-Reply-To: <20191016222953.513-5-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6003208005901007581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/16/19 5:29 PM, James Prestwood wrote:
> ---
>   src/hotspot.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> =

> diff --git a/src/hotspot.c b/src/hotspot.c
> index 20ebb2fd..1a783958 100644
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
> +			memset(config->hessid, 0, 6);

Why the memset?  Also, shouldn't we fail here?  Or at the very least =

delay checking the presence of hessid || nai_realms || rc_str until =

after the parsing has been validated?

> +		}
> +
>   		l_free(hessid_str);
>   	}
>   =


Also this seems to be unrelated to the patch description?

Regards,
-Denis
--===============6003208005901007581==--

