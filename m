Content-Type: multipart/mixed; boundary="===============6798749612837491315=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/8] client: Ignore invalid agent requests
Date: Wed, 23 Oct 2019 17:51:58 -0500
Message-ID: <ed31e31c-7141-7189-bceb-12be83d9b801@gmail.com>
In-Reply-To: <20191023202403.9690-3-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6798749612837491315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 10/23/19 3:23 PM, Tim Kourt wrote:
> ---
>   client/agent.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> =

> diff --git a/client/agent.c b/client/agent.c
> index 5ed6538f..a64d71c5 100644
> --- a/client/agent.c
> +++ b/client/agent.c
> @@ -112,7 +112,9 @@ static struct l_dbus_message *request_passphrase_meth=
od_call(
>   					"'--"COMMAND_OPTION_PASSPHRASE"' "
>   						"command-line option.\n");
>   =

> -	l_dbus_message_get_arguments(message, "o", &path);
> +	if (!l_dbus_message_get_arguments(message, "o", &path))
> +		return NULL;
> +

This isn't actually correct.  If the method call fails to parse, then =

returning an error here just means that no reply is sent (and it will =

time out in 30 seconds or so, depending on dbus policy).  You probably =

want to send an error instead.

Returning NULL is generally only used for asynchronous callbacks.

>   	if (!path)
>   		return NULL;
>   =

> @@ -153,7 +155,9 @@ static struct l_dbus_message *request_private_key_pas=
sphrase_method_call(
>   					"'--"COMMAND_OPTION_PASSPHRASE"' "
>   						"command-line option.\n");
>   =

> -	l_dbus_message_get_arguments(message, "o", &path);
> +	if (!l_dbus_message_get_arguments(message, "o", &path))
> +		return NULL;
> +
>   	if (!path)
>   		return NULL;
>   =

> @@ -216,7 +220,9 @@ static struct l_dbus_message *request_username_and_pa=
ssword_method_call(
>   					"'--"COMMAND_OPTION_PASSWORD"' "
>   						"command-line option.\n");
>   =

> -	l_dbus_message_get_arguments(message, "o", &path);
> +	if (!l_dbus_message_get_arguments(message, "o", &path))
> +		return NULL;
> +
>   	if (!path)
>   		return NULL;
>   =

> @@ -275,7 +281,9 @@ static struct l_dbus_message *request_user_password_m=
ethod_call(
>   					"'--"COMMAND_OPTION_PASSWORD"' "
>   					"command-line option.\n");
>   =

> -	l_dbus_message_get_arguments(message, "os", &path, &username);
> +	if (!l_dbus_message_get_arguments(message, "os", &path, &username))
> +		return NULL;
> +
>   	if (!path || !username)
>   		return NULL;
>   =

> =


Same for all of these.

Regards,
-Denis
--===============6798749612837491315==--

