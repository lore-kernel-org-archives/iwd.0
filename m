Content-Type: multipart/mixed; boundary="===============4124697540013529077=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] storage: add storage_get_ap_path
Date: Fri, 30 Oct 2020 13:41:57 -0500
Message-ID: <aac22e4c-862a-57f5-5f28-7afad5aa9296@gmail.com>
In-Reply-To: <20201030163413.2446645-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4124697540013529077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/30/20 11:34 AM, James Prestwood wrote:
> ---
>   src/storage.c | 30 ++++++++++++++++++++++++++++++
>   src/storage.h |  1 +
>   2 files changed, 31 insertions(+)
> =

> diff --git a/src/storage.c b/src/storage.c
> index 60fb1bc3..e7ac3938 100644
> --- a/src/storage.c
> +++ b/src/storage.c
> @@ -50,6 +50,7 @@
>   =

>   static char *storage_path =3D NULL;
>   static char *storage_hotspot_path =3D NULL;
> +static char *storage_ap_path =3D NULL;
>   =

>   static int create_dirs(const char *filename)
>   {
> @@ -221,6 +222,16 @@ bool storage_create_dirs(void)
>   		return false;
>   	}
>   =

> +	storage_ap_path =3D l_strdup_printf("%s/ap/", storage_path);
> +
> +	if (create_dirs(storage_ap_path)) {
> +		l_error("Failed to create %s", storage_ap_path);
> +
> +		l_free(storage_path);
> +		l_free(storage_hotspot_path);
> +		l_free(storage_ap_path);

This might look better using a goto instead.

> +	}
> +
>   	return true;
>   }
>   =

> @@ -228,6 +239,7 @@ void storage_cleanup_dirs(void)
>   {
>   	l_free(storage_path);
>   	l_free(storage_hotspot_path);
> +	l_free(storage_ap_path);
>   }
>   =

>   char *storage_get_path(const char *format, ...)
> @@ -266,6 +278,24 @@ char *storage_get_hotspot_path(const char *format, .=
..)
>   	return str;
>   }
>   =

> +char *storage_get_ap_path(const char *format, ...)
> +{
> +	va_list args;
> +	char *fmt, *str;
> +
> +	if (!format)
> +		return l_strdup(storage_ap_path);
> +
> +	fmt =3D l_strdup_printf("%s/%s", storage_ap_path, format);
> +
> +	va_start(args, format);
> +	str =3D l_strdup_vprintf(fmt, args);
> +	va_end(args);
> +
> +	l_free(fmt);
> +	return str;
> +}
> +

I think this really isn't necessary, you could use storage_get_path for thi=
s =

just as well.  Or just return storage_ap_path which is all you're using thi=
s for.

The more useful thing might be to actually obtain the AP path given an SSID=
...

>   char *storage_get_network_file_path(enum security type, const char *ssi=
d)
>   {
>   	char *path;
> diff --git a/src/storage.h b/src/storage.h
> index d9b17c7f..a6076d63 100644
> --- a/src/storage.h
> +++ b/src/storage.h
> @@ -36,6 +36,7 @@ bool storage_create_dirs(void);
>   void storage_cleanup_dirs(void);
>   char *storage_get_path(const char *format, ...);
>   char *storage_get_hotspot_path(const char *format, ...);
> +char *storage_get_ap_path(const char *format, ...);
>   =

>   const char *storage_network_filename_from_path(const char *path);
>   const char *storage_network_ssid_from_path(const char *path,
> =


Regards,
-Denis
--===============4124697540013529077==--

