Content-Type: multipart/mixed; boundary="===============1544643331744038990=="
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Issue with iwd + Linux 5.8.3 + WPA Enterprise
Date: Thu, 27 Aug 2020 06:40:13 +0000
Message-ID: <CAMj1kXH-qZZhw5D5sBEVFP9=Z04pU+xCnQ78sDDw6WuSM-pRGQ@mail.gmail.com>
In-Reply-To: <20200826221913.GA16175@gondor.apana.org.au>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1544643331744038990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Aug 2020 at 00:19, Herbert Xu <herbert@gondor.apana.org.au> wr=
ote:
>
> On Wed, Aug 26, 2020 at 05:42:27PM +0200, Ard Biesheuvel wrote:
> >
> > I still get a failure in aes_siv_encrypt(), which does not occur with
> > the kernel side fix applied.
>
> Where is this test from? I can't find it in the ell git tree.
>

It is part of iwd - just build that and run 'make check'

With your patch applied, the occurrence of sendmsg() in
operate_cipher() triggers the warn_once(), but if I add MSG_MORE
there, the test hangs.
--===============1544643331744038990==--

