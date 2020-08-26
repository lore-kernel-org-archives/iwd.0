Content-Type: multipart/mixed; boundary="===============8968659157148311482=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: Issue with iwd + Linux 5.8.3 + WPA Enterprise
Date: Wed, 26 Aug 2020 12:58:15 +0000
Message-ID: <CAOq732JaP=4X9Yh_KjER5_ctQWoauxzXTZqyFP9KsLSxvVH8=w@mail.gmail.com>
In-Reply-To: <20200826120832.GA2996@gondor.apana.org.au>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8968659157148311482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Aug 2020 at 14:10, Herbert Xu <herbert@gondor.apana.org.au> wr=
ote:
> On Wed, Aug 26, 2020 at 01:59:53PM +0200, Ard Biesheuvel wrote:
> > On Wed, 26 Aug 2020 at 13:50, Herbert Xu <herbert@gondor.apana.org.au=
> wrote:
> > >
> > > On Wed, Aug 26, 2020 at 12:40:14PM +0200, Ard Biesheuvel wrote:
> > > >
> > > > It would be helpful if someone could explain for the non-mac80211
> > > > enlightened readers how iwd's EAP-PEAPv0 + MSCHAPv2 support relies =
on
> > > > the algif_aead socket interface, and which AEAD algorithms it uses.=
 I
> > > > assume this is part of libell?
> > >
> > > I see the problem.  libell/ell/checksum.c doesn't clear the MSG_MORE
> > > flag before doing the recv(2).
> >
> > But that code uses a hash not an aead, afaict.
>
> Good point.  In that case can we please get a strace with a -s
> option that's big enough to capture the crypto data?

Running iwd's and ell's unit tests I can see that at least the
following algorithms give EINVAL errors:
ecb(aes)
cbc(aes)
ctr(aes)

The first one fails in recv() and only for some input lengths.  The
latter two fail in send().  The relevant ell code starts at
https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/ell/cipher.c#n271

The tests didn't get to the point where aead is used.

Best regards
--===============8968659157148311482==--

