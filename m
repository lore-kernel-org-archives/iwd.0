Content-Type: multipart/mixed; boundary="===============6192905022998432010=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 2/3] main: remove unneeded stat call
Date: Fri, 18 Feb 2022 14:46:32 -0600
Message-ID: <4434da13-2ab1-2231-9535-dddbca6e734a@gmail.com>
In-Reply-To: 20220218195506.2145602-2-prestwoj@gmail.com

--===============6192905022998432010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/18/22 13:55, James Prestwood wrote:
> Static analysis flagged that 'path' was never being checked (which
> should not ever be NULL) but during that review I noticed stat()
> was being called, then fstat afterwards.
> ---
>   src/main.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> =

> diff --git a/src/main.c b/src/main.c
> index 7a378b64..d790f61f 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -428,11 +428,8 @@ static bool setup_system_key(void)
>   	}
>   =

>   	path =3D l_strdup_printf("%s/%s", cred_dir, key_id);
> -
> -	if (stat(path, &st) < 0) {
> -		l_warn("SystemdEncrypt: Could not stat %s", path);
> +	if (!path)
>   		return false;

l_strdup_printf doesn't fail, so I removed this if as well.

> -	}
>   =

>   	fd =3D open(path, O_RDONLY, 0);
>   	if (fd < 0) {
> =


Applied, thanks.

Regards,
-Denis
--===============6192905022998432010==--

