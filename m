Content-Type: multipart/mixed; boundary="===============1613837498682339010=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/3] hwsim: check if radio name was already set
Date: Fri, 18 Feb 2022 14:45:29 -0600
Message-ID: <bcfb68b0-d98b-d819-e9ca-ffe8b7779703@gmail.com>
In-Reply-To: 20220218195506.2145602-1-prestwoj@gmail.com

--===============1613837498682339010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2/18/22 13:55, James Prestwood wrote:
> This was caught by static analysis and shouldn't ever happen.
> ---
>   tools/hwsim.c | 3 +++
>   1 file changed, 3 insertions(+)
> =

> diff --git a/tools/hwsim.c b/tools/hwsim.c
> index 3ff3faab..8c076f51 100644
> --- a/tools/hwsim.c
> +++ b/tools/hwsim.c
> @@ -639,6 +639,9 @@ static void get_radio_callback(struct l_genl_msg *msg=
, void *user_data)
>   			break;
>   =

>   		case HWSIM_ATTR_RADIO_NAME:
> +			if (name)
> +				return;
> +

I changed this to break instead of return.

>   			name =3D l_strndup(data, len);
>   			break;
>   		}
> =


Applied, thanks.

Regards,
-Denis

--===============1613837498682339010==--

