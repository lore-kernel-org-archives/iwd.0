Content-Type: multipart/mixed; boundary="===============2640558851042394248=="
MIME-Version: 1.0
From: Prestwood, James <james.prestwood@intel.com>
Subject: Re: [PATCH] crypto: fix copy size causing overruns/crashing
Date: Thu, 03 Oct 2019 16:44:56 +0000
Message-ID: <d5eab9f2eececb6530ff6d466f6484d28412c836.camel@intel.com>
In-Reply-To: <20191003113516.GC8802@dtznix>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2640558851042394248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Thu, 2019-10-03 at 11:35 -0500, Will Dietz wrote:
> num_ad is already accounted for in `sizeof(iov)`
> as iov has size `sizeof(struct iovec) * (num_ad+1)`.
> ---
>  src/crypto.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/src/crypto.c b/src/crypto.c
> index 632117d..62edd44 100644
> --- a/src/crypto.c
> +++ b/src/crypto.c
> @@ -311,7 +311,7 @@ bool aes_siv_encrypt(const uint8_t *key, size_t
> key_len, const uint8_t *in,
>         struct iovec iov[num_ad + 1];
>         uint8_t v[16];
>  =

> -       memcpy(iov, ad, sizeof(iov) * num_ad);
> +       memcpy(iov, ad, sizeof(struct iovec) * num_ad);

Good catch! I'm fine with this way, but also fine with simply removing
* num_ad and leaving sizeof(iov) as is. Lets see what Denis prefers.

Thanks,
James
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org

--===============2640558851042394248==--

