Content-Type: multipart/mixed; boundary="===============4880340846367462188=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] network: free psk on error
Date: Mon, 08 Feb 2021 15:29:20 -0600
Message-ID: <dd9408c2-d4a8-470d-a208-9cd5c763d632@gmail.com>
In-Reply-To: <20210208211812.612391-3-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4880340846367462188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/8/21 3:18 PM, James Prestwood wrote:
> ---
>   src/network.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> =

> diff --git a/src/network.c b/src/network.c
> index 7cae413f..8f129718 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -403,8 +403,10 @@ static int network_load_psk(struct network *network,=
 bool need_passphrase)
>   		l_error("%s: invalid PreSharedKey format", path);
>   		l_free(path);
>   =

> -		if (!passphrase)
> +		if (!passphrase) {
> +			l_free(psk);
>   			return -EINVAL;
> +		}

That only frees it if there's passphrase.  But if we have to re-derive the =
PSK, =

it is still leaked...

>   	}
>   =

>   	network->psk =3D l_malloc(32);
> =


Regards,
-Denis
--===============4880340846367462188==--

