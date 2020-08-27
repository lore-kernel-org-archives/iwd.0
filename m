Content-Type: multipart/mixed; boundary="===============1305909331779682627=="
MIME-Version: 1.0
From: Caleb Jorden <caljorden@hotmail.com>
Subject: Re: Issue with iwd + Linux 5.8.3 + WPA Enterprise
Date: Thu, 27 Aug 2020 04:56:36 +0000
Message-ID: <
 <BL0PR11MB329980406FA0A14A8EF61A07B9550@BL0PR11MB3299.namprd11.prod.outlook.com>>
In-Reply-To: <20200826221913.GA16175@gondor.apana.org.au>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1305909331779682627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I can tell you all assumed this, but just by way as a quick update on the o=
riginal issue:

I have confirmed that Herbert's patch (crypto: af_alg - Work around empty c=
ontrol messages without MSG_MORE) does indeed fix the original iwd 1.8 + WP=
A Enterprise issue.

Thank you!

Caleb Jorden

________________________________________
From: Herbert Xu <herbert@gondor.apana.org.au>
Sent: Thursday, August 27, 2020 3:49 AM
To: Ard Biesheuvel
Cc: Denis Kenzior; Andrew Zaborowski; Paul Menzel; Caleb Jorden; Sasha Levi=
n; iwd(a)lists.01.org; # 3.4.x; Greg KH; LKML; David S. Miller; Linux Crypt=
o Mailing List
Subject: Re: Issue with iwd + Linux 5.8.3 + WPA Enterprise

On Wed, Aug 26, 2020 at 05:42:27PM +0200, Ard Biesheuvel wrote:
>
> I still get a failure in aes_siv_encrypt(), which does not occur with
> the kernel side fix applied.

Where is this test from? I can't find it in the ell git tree.

Thanks,
--
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--===============1305909331779682627==--

