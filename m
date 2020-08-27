Content-Type: multipart/mixed; boundary="===============2774941472826291084=="
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Issue with iwd + Linux 5.8.3 + WPA Enterprise
Date: Thu, 27 Aug 2020 07:54:23 +0000
Message-ID: <CAMj1kXFX_viiR4S8DiDrcS09o2NFQsZGmizdLc9xjrWOrhgjaA@mail.gmail.com>
In-Reply-To: <BL0PR11MB329980406FA0A14A8EF61A07B9550@BL0PR11MB3299.namprd11.prod.outlook.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2774941472826291084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Aug 2020 at 06:56, Caleb Jorden <caljorden@hotmail.com> wrote:
>
> I can tell you all assumed this, but just by way as a quick update on the=
 original issue:
>
> I have confirmed that Herbert's patch (crypto: af_alg - Work around empty=
 control messages without MSG_MORE) does indeed fix the original iwd 1.8 + =
WPA Enterprise issue.
>
> Thank you!
>
> Caleb Jorden
>

Thanks for confirming.

> ________________________________________
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Thursday, August 27, 2020 3:49 AM
> To: Ard Biesheuvel
> Cc: Denis Kenzior; Andrew Zaborowski; Paul Menzel; Caleb Jorden; Sasha Le=
vin; iwd(a)lists.01.org; # 3.4.x; Greg KH; LKML; David S. Miller; Linux Cry=
pto Mailing List
> Subject: Re: Issue with iwd + Linux 5.8.3 + WPA Enterprise
>
> On Wed, Aug 26, 2020 at 05:42:27PM +0200, Ard Biesheuvel wrote:
> >
> > I still get a failure in aes_siv_encrypt(), which does not occur with
> > the kernel side fix applied.
>
> Where is this test from? I can't find it in the ell git tree.
>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--===============2774941472826291084==--

