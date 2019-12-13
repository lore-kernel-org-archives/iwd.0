Content-Type: multipart/mixed; boundary="===============4300146222258911618=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] client: Follow the xdg base directory specification
Date: Fri, 13 Dec 2019 09:36:02 +0100
Message-ID: <FF5BDD7E-E3EF-4207-AA7C-E41FA9CB6A19@holtmann.org>
In-Reply-To: <20191210130609.5gnmcbb3cxthmfwi@blumerang>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4300146222258911618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Xaver,

> Use XDG_DATA_HOME as location for the history file.
> Also reads and migrates the history from the old location in the users
> home directory if present.
> ---
> client/display.c | 68 +++++++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 62 insertions(+), 6 deletions(-)
> =

> diff --git a/client/display.c b/client/display.c
> index 10c87b2a..d1a1a7f7 100644
> --- a/client/display.c
> +++ b/client/display.c
> @@ -27,6 +27,9 @@
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <signal.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> =

> #include <readline/history.h>
> #include <readline/readline.h>
> @@ -632,22 +635,75 @@ static void signal_handler(void *user_data)
> 		display_refresh_reset();
> }
> =

> +char * get_data_dir()
> +{
> +	const char *xdg_data_home;
> +	const char *home_path;
> +	char *data_dir;
> +
> +	xdg_data_home =3D getenv("XDG_DATA_HOME");
> +	if (!xdg_data_home || *xdg_data_home !=3D '/') {
> +		home_path =3D getenv("HOME");
> +		if (home_path)
> +			data_dir =3D l_strdup_printf("%s/%s", home_path,
> +						".local/share/iwctl");
> +		else
> +			return NULL;
> +	} else {
> +		data_dir =3D l_strdup_printf("%s/%s", xdg_data_home,
> +							"iwctl");
> +	}
> +	return data_dir;
> +}
> +
> +char * get_old_history_file()
> +{
> +	const char *home_path;
> +	char *old_history_path;
> +	struct stat st;
> +	int err;
> +
> +	home_path =3D getenv("HOME");
> +	if (home_path) {
> +		old_history_path =3D l_strdup_printf("%s/%s", home_path,
> +						".iwctl_history");
> +
> +		err =3D stat(old_history_path, &st);
> +		if (err || !S_ISREG(st.st_mode)) {
> +			l_free(old_history_path);
> +			return NULL;
> +		}
> +	}
> +	return old_history_path;
> +}
> +
> static char *history_path;
> =

> void display_init(void)
> {
> -	const char *home_path;
> +	char *data_dir;
> +	char *old_history_file;
> =

> 	display_refresh.redo_entries =3D l_queue_new();
> =

> 	stifle_history(24);
> =

> -	home_path =3D getenv("HOME");
> -	if (home_path)
> -		history_path =3D l_strdup_printf("%s/%s", home_path,
> -							".iwctl_history");
> +	data_dir =3D get_data_dir();
> +	if (data_dir) {
> +		mkdir(data_dir,0700);
> +
> +		history_path =3D l_strdup_printf("%s/%s", data_dir,
> +							"history");
> +		l_free(data_dir);
> +	}
> =

> -	read_history(history_path);
> +	old_history_file =3D get_old_history_file();
> +	if (old_history_file) {
> +		read_history(old_history_file);
> +		unlink(old_history_file);
> +		l_free(old_history_file);
> +	} else
> +		read_history(history_path);

I am not sure to bother with the old .iwctl_history file. For now I have cr=
eated and pushed a patch that moves this to iwctl/history under XDG_DATA_HO=
ME.

Regards

Marcel

--===============4300146222258911618==--

