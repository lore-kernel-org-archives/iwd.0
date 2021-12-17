Content-Type: multipart/mixed; boundary="===============3727047638857721481=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v5 4/4] dpp: handle protocol errors in ROC timeout
Date: Fri, 17 Dec 2021 14:23:41 -0600
Message-ID: <270a6675-b6d0-172f-efac-fabbb920c55e@gmail.com>
In-Reply-To: 20211217191451.179444-4-prestwoj@gmail.com

--===============3727047638857721481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/17/21 13:14, James Prestwood wrote:
> This is a standing TODO of properly handling these timeouts but
> for now just treat any ROC timeout as an error if authenticating
> or configuring.
> ---
>   src/dpp.c | 36 +++++++++++++++++++++++++++++++++---
>   1 file changed, 33 insertions(+), 3 deletions(-)
> =

> diff --git a/src/dpp.c b/src/dpp.c

<snip>

> @@ -1091,6 +1115,12 @@ static void dpp_presence_timeout(int error, void *=
user_data)
>   	dpp->offchannel_id =3D offchannel_start(netdev_get_wdev_id(dpp->netdev=
),
>   			dpp->current_freq, dpp->dwell, dpp_roc_started,
>   			dpp, dpp_presence_timeout);
> +	return;
> +
> +protocol_failed:
> +	dpp_reset(dpp);
> +	dpp_free_auth_data(dpp);

Isn't dpp_reset already calling dpp_free_auth_data?

> +	return;
>   }
>   =

>   /*
> =


Regards,
-Denis
--===============3727047638857721481==--

