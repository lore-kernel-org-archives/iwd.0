Content-Type: multipart/mixed; boundary="===============4487727536469939777=="
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [v2 PATCH] crypto: af_alg - Work around empty control messages
 without MSG_MORE
Date: Thu, 27 Aug 2020 07:40:13 +0000
Message-ID: <CAMj1kXGJWRXu1Mx=ObTkztTdBQusv0N8o-cH1f+KM7d7geD20w@mail.gmail.com>
In-Reply-To: <20200827071436.GA30281@gondor.apana.org.au>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4487727536469939777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Aug 2020 at 09:15, Herbert Xu <herbert@gondor.apana.org.au> wr=
ote:
>
> On Thu, Aug 27, 2020 at 08:40:01AM +0200, Ard Biesheuvel wrote:
> >
> > It is part of iwd - just build that and run 'make check'
> >
> > With your patch applied, the occurrence of sendmsg() in
> > operate_cipher() triggers the warn_once(), but if I add MSG_MORE
> > there, the test hangs.
>
> I see.  This is a different issue.  The original kernel change
> was a bit too strict here and it is barfing at the fact that two
> successive sendmsg's of the same request both contain a control
> message.
>
> Here's an updated patch to allow this.
>
> ---8<---
> The iwd daemon uses libell which sets up the skcipher operation with
> two separate control messages.  As the first control message is sent
> without MSG_MORE, it is interpreted as an empty request.
>
> While libell should be fixed to use MSG_MORE where appropriate, this
> patch works around the bug in the kernel so that existing binaries
> continue to work.
>
> We will print a warning however.
>
> A separate issue is that the new kernel code no longer allows the
> control message to be sent twice within the same request.  This
> restriction is obviously incompatible with what iwd was doing (first
> setting an IV and then sending the real control message).  This
> patch changes the kernel so that this is explicitly allowed.
>
> Reported-by: Caleb Jorden <caljorden@hotmail.com>
> Fixes: f3c802a1f300 ("crypto: algif_aead - Only wake up when...")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> index a6f581ab200c..8be8bec07cdd 100644
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
> @@ -845,9 +846,15 @@ int af_alg_sendmsg(struct socket *sock, struct msghd=
r *msg, size_t size,
>         }
>
>         lock_sock(sk);
> -       if (ctx->init && (init || !ctx->more)) {
> -               err =3D -EINVAL;
> -               goto unlock;
> +       if (ctx->init && !ctx->more) {
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

Yep, that works.
--===============4487727536469939777==--

