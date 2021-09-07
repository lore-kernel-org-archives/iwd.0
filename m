Content-Type: multipart/mixed; boundary="===============0985971266063227658=="
MIME-Version: 1.0
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH 8/9] sae: don't send commit in confirmed state
Date: Wed, 08 Sep 2021 01:02:27 +0200
Message-ID: <3b994fe5-8b84-6f4d-e2d8-5e63fd05cd41@molgen.mpg.de>
In-Reply-To: <20210907211450.27270-8-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0985971266063227658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear James,


Am 07.09.21 um 23:14 schrieb James Prestwood:
> This works around a hostapd bug (described more in the TODO comment)

It=E2=80=99d be great, if you listed the hostapd version, you reproduced th=
is =

with, and, if you did, add a reference to the hostapd bug report.

> that deaths IWD if the initial commit is not acked. This behavior
> has been identified in consumer access points and likely won't ever
> be patched for older devices. Because of this IWD must work around
> the problem which can be eliminated by not sending out this commit
> message.

Excuse my ignorance, but how likely is it, that non-hostapd setups keep =

working?


Kind regards,

Paul


> ---
>   src/sae.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> =

> diff --git a/src/sae.c b/src/sae.c
> index fbd0298d..4eda9225 100644
> --- a/src/sae.c
> +++ b/src/sae.c
> @@ -1165,7 +1165,18 @@ static int sae_verify_confirmed(struct sae_sm *sm,=
 uint16_t trans,
>   	sm->sync++;
>   	sm->sc++;
>   =

> -	sae_send_commit(sm, true);
> +	/*
> +	 * TODO: There is a bug in hostapd which deaths stations if a commit
> +	 * is received in an Accepted SAE state. This can be triggered if the
> +	 * STA's commit is not acked, which triggers a re-transmission, and
> +	 * ultimated causes the AP to death IWD.
> +	 *
> +	 * Since this bug is present in production APs out in the wild we must
> +	 * work around it by going against the spec (802.11-2020 12.4.8.6.5) and
> +	 * only send a confirm here.
> +	 *
> +	 * sae_send_commit(sm, true);
> +	 */
>   =

>   	if (!sae_send_confirm(sm))
>   		return -EPROTO;
>=20
--===============0985971266063227658==--

