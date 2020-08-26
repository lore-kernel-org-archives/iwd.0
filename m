Content-Type: multipart/mixed; boundary="===============7557630477585049893=="
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] crypto: af_alg - Work around empty control messages
 without MSG_MORE
Date: Wed, 26 Aug 2020 13:56:33 +0000
Message-ID: <CAMj1kXHCazXbeTDfcjD=rUyLVcOqrHcHqfgOnsDWt51dALfSpg@mail.gmail.com>
In-Reply-To: <20200826132952.GA4752@gondor.apana.org.au>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7557630477585049893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Aug 2020 at 15:30, Herbert Xu <herbert@gondor.apana.org.au> wr=
ote:
>
> The iwd daemon uses libell which sets up the skcipher operation with
> two separate control messages.  This is fine by itself but the first
> control message is sent without MSG_MORE.  This means that the first
> control message is interpreted as an empty request.
>
> While libell should be fixed to use MSG_MORE where appropriate, this
> patch works around the bug in the kernel so that existing binaries
> continue to work.
>
> We will print a warning however.
>
> Reported-by: Caleb Jorden <caljorden@hotmail.com>
> Fixes: f3c802a1f300 ("crypto: algif_aead - Only wake up when...")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>

Applied this onto v5.4.60, and it makes the iwd selftests pass again

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> index a6f581ab200c..3da21cadc326 100644
> --- a/crypto/af_alg.c
> +++ b/crypto/af_alg.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/net.h>
>  #include <linux/rwsem.h>
> +#include <linux/sched.h>
>  #include <linux/sched/signal.h>
>  #include <linux/security.h>
>
> @@ -846,8 +847,14 @@ int af_alg_sendmsg(struct socket *sock, struct msghd=
r *msg, size_t size,
>
>         lock_sock(sk);
>         if (ctx->init && (init || !ctx->more)) {
> -               err =3D -EINVAL;
> -               goto unlock;
> +               if (ctx->used) {
> +                       err =3D -EINVAL;
> +                       goto unlock;
> +               }
> +
> +               pr_info_once(
> +                       "%s sent an empty control message without MSG_MOR=
E.\n",
> +                       current->comm);
>         }
>         ctx->init =3D true;
>
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--===============7557630477585049893==--

