Content-Type: multipart/mixed; boundary="===============8637563401018162061=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] network: use L_AUTO_FREE_VAR
Date: Mon, 17 May 2021 10:45:42 -0500
Message-ID: <88936927-ab39-6063-834b-8edbd89a2d33@gmail.com>
In-Reply-To: <20210514163640.305070-1-Marc-Antoine@Perennou.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8637563401018162061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marc-Antoine,

On 5/14/21 11:36 AM, Marc-Antoine Perennou wrote:
> Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
> ---
>   src/network.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/src/network.c b/src/network.c
> index 9e858663..0eb3687e 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -380,10 +380,10 @@ static int network_load_psk(struct network *network=
, bool need_passphrase)
>   	size_t psk_len;
>   	uint8_t *psk =3D l_settings_get_bytes(network->settings, "Security",
>   						"PreSharedKey", &psk_len);
> -	_auto_(l_free) char *passphrase =3D
> +	L_AUTO_FREE_VAR(char *, passphrase) =3D
>   			l_settings_get_string(network->settings,
>   						"Security", "Passphrase");
> -	_auto_(l_free) char *path =3D
> +	L_AUTO_FREE_VAR(char *, path) =3D
>   		storage_get_network_file_path(security, ssid);
>   	int r;
>   =

> =


Was this supposed to be part of a different set?  Can you resend the entire =

series, it isn't quite clear to me where you're going with this?

I would guess your intent is to use _auto_ with destructors only and fall b=
ack =

to L_AUTO_FREE_VAR for l_free?

Regards,
-Denis
--===============8637563401018162061==--

