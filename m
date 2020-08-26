Content-Type: multipart/mixed; boundary="===============1700176769561455860=="
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Issue with iwd + Linux 5.8.3 + WPA Enterprise
Date: Wed, 26 Aug 2020 12:00:05 +0000
Message-ID: <CAMj1kXGjytfJEbLMbz50it3okQfiLScHB5YK2FMqR5CsmFEBbg@mail.gmail.com>
In-Reply-To: <20200826114952.GA2375@gondor.apana.org.au>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1700176769561455860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Aug 2020 at 13:50, Herbert Xu <herbert@gondor.apana.org.au> wr=
ote:
>
> On Wed, Aug 26, 2020 at 12:40:14PM +0200, Ard Biesheuvel wrote:
> >
> > It would be helpful if someone could explain for the non-mac80211
> > enlightened readers how iwd's EAP-PEAPv0 + MSCHAPv2 support relies on
> > the algif_aead socket interface, and which AEAD algorithms it uses. I
> > assume this is part of libell?
>
> I see the problem.  libell/ell/checksum.c doesn't clear the MSG_MORE
> flag before doing the recv(2).
>

But that code uses a hash not an aead, afaict.

> I was hoping nobody out there was doing this but obviously I've
> been proven wrong.
>
> So what I'm going to do is to specifically allow this case of
> a string of sendmsg(2)'s with MSG_MORE folloed by a recvmsg(2)
> in the same thread.  I'll add a WARN_ON_ONCE so user-space can
> eventually be fixed.
>
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--===============1700176769561455860==--

