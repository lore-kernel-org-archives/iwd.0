Content-Type: multipart/mixed; boundary="===============2266869619119802631=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v7 1/8] storage: convert storage to a module
Date: Tue, 15 Feb 2022 12:05:24 -0600
Message-ID: <dcc41b0b-dc58-0006-0403-2fafdf9a3919@gmail.com>
In-Reply-To: 20220210225842.895962-1-prestwoj@gmail.com

--===============2266869619119802631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/10/22 16:58, James Prestwood wrote:
> ---
>   src/main.c    |   6 ---
>   src/storage.c | 102 ++++++++++++++++++++++++++------------------------
>   src/storage.h |   2 -
>   3 files changed, 54 insertions(+), 56 deletions(-)
> =


<snip>

>   =

> -bool storage_create_dirs(void)
> -{
> -	const char *state_dir;
> -	char **state_dirs;
> -
> -	state_dir =3D getenv("STATE_DIRECTORY");
> -	if (!state_dir)
> -		state_dir =3D DAEMON_STORAGEDIR;
> -
> -	l_debug("Using state directory %s", state_dir);
> -
> -	state_dirs =3D l_strsplit(state_dir, ':');
> -	if (!state_dirs[0]) {
> -		l_strv_free(state_dirs);
> -		return false;
> -	}
> -
> -	storage_path =3D l_strdup(state_dirs[0]);
> -	l_strv_free(state_dirs);
> -
> -	if (create_dirs(storage_path)) {
> -		l_error("Failed to create %s", storage_path);
> -
> -		l_free(storage_path);
> -
> -		return false;
> -	}
> -
> -	storage_hotspot_path =3D l_strdup_printf("%s/hotspot/", storage_path);
> -
> -	if (create_dirs(storage_hotspot_path)) {
> -		l_error("Failed to create %s", storage_hotspot_path);
> -
> -		l_free(storage_path);
> -		l_free(storage_hotspot_path);
> -
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
> -void storage_cleanup_dirs(void)
> -{
> -	l_free(storage_path);
> -	l_free(storage_hotspot_path);
> -}
> -

So these two functions are actually extremely iwd specific.  I think we may=
be =

should just put them into main.c instead.

>   char *storage_get_path(const char *format, ...)
>   {
>   	va_list args;

Regards,
-Denis
--===============2266869619119802631==--

