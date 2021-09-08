Content-Type: multipart/mixed; boundary="===============4866826513438145030=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/9] sae: fix a few spec violations regarding dropped
 frames
Date: Tue, 07 Sep 2021 20:05:39 -0500
Message-ID: <2b08b1f9-289a-4ae4-36fd-641ffaff7d63@gmail.com>
In-Reply-To: <20210907211450.27270-7-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4866826513438145030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/7/21 4:14 PM, James Prestwood wrote:
> There were two places where SAE returned a fatal error code rather
> than silently drop the frame as the spec requires. These two cases
> return -EAGAIN which ultimately drops the frame in netdev.
> ---
>   src/sae.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/src/sae.c b/src/sae.c
> index 62fd6c88..fbd0298d 100644
> --- a/src/sae.c
> +++ b/src/sae.c
> @@ -678,7 +678,7 @@ static int sae_process_commit(struct sae_sm *sm, cons=
t uint8_t *from,
>   	if (l_ecc_scalars_are_equal(sm->p_scalar, sm->scalar) ||
>   			l_ecc_points_are_equal(sm->p_element, sm->element)) {
>   		l_warn("peer scalar or element matched own, discarding frame");
> -		return -ENOMSG;
> +		return -EAGAIN;

Hmm, this one seems like it should remain unchanged?

>   	}
>   =

>   	sm->sc++;
> @@ -1185,7 +1185,7 @@ static int sae_verify_accepted(struct sae_sm *sm, u=
int16_t trans,
>   	/* spec does not specify what to do here, so print and discard */
>   	if (trans !=3D SAE_STATE_CONFIRMED) {
>   		l_error("received transaction %u in accepted state", trans);
> -		return -EBADMSG;
> +		return -EAGAIN;

I guess you probably just want 'return 0' here and a quote from 12.4.8.6.1?

>   	}
>   =

>   	if (sm->sync > SAE_SYNC_MAX)
> =


Regards,
-Denis
--===============4866826513438145030==--

