Content-Type: multipart/mixed; boundary="===============8232575949841313694=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] agent: enforce a maximum passphrase length
Date: Fri, 06 Mar 2020 12:27:44 -0600
Message-ID: <c2094193-46d1-7419-0f78-e76252b39c35@gmail.com>
In-Reply-To: <20200306174843.26578-3-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8232575949841313694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/6/20 11:48 AM, James Prestwood wrote:
> ---
>   src/agent.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> =

> diff --git a/src/agent.c b/src/agent.c
> index d213f3cd..44039a89 100644
> --- a/src/agent.c
> +++ b/src/agent.c
> @@ -159,6 +159,9 @@ static void passphrase_reply(struct l_dbus_message *r=
eply,
>   	if (!l_dbus_message_get_arguments(reply, "s", &passphrase))
>   		goto done;
>   =

> +	if (strlen(passphrase) > IWD_MAX_PASSPHRASE_LEN)
> +		goto done;
> +

This callback is used for three things from what I remember:
	1. The passphrase for decrypting private keys
	2. The passphrase for PSK networks.
	3. The password for EAP methods.

This checking should only apply to 3, no?

>   	result =3D AGENT_RESULT_OK;
>   =

>   done:
> @@ -181,6 +184,9 @@ static void user_name_passwd_reply(struct l_dbus_mess=
age *reply,
>   	if (!l_dbus_message_get_arguments(reply, "ss", &username, &passwd))
>   		goto done;
>   =

> +	if (strlen(passwd) > IWD_MAX_PASSPHRASE_LEN)
> +		goto done;
> +
>   	result =3D AGENT_RESULT_OK;
>   =

>   done:
> =


Regards,
-Denis
--===============8232575949841313694==--

