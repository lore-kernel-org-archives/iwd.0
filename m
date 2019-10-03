Content-Type: multipart/mixed; boundary="===============6448546356099755235=="
MIME-Version: 1.0
From: Prestwood, James <james.prestwood@intel.com>
Subject: Re: [PATCH] crypto: fix copy size causing overruns/crashing
Date: Thu, 03 Oct 2019 16:47:19 +0000
Message-ID: <6081f774c424ff47a1d46037ed7e1df67acc070f.camel@intel.com>
In-Reply-To: <d5eab9f2eececb6530ff6d466f6484d28412c836.camel@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6448546356099755235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-03 at 16:44 +0000, Prestwood, James wrote:
> Hi Will,
> =

> On Thu, 2019-10-03 at 11:35 -0500, Will Dietz wrote:
> > num_ad is already accounted for in `sizeof(iov)`
> > as iov has size `sizeof(struct iovec) * (num_ad+1)`.
> > ---
> >  src/crypto.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > =

> > diff --git a/src/crypto.c b/src/crypto.c
> > index 632117d..62edd44 100644
> > --- a/src/crypto.c
> > +++ b/src/crypto.c
> > @@ -311,7 +311,7 @@ bool aes_siv_encrypt(const uint8_t *key, size_t
> > key_len, const uint8_t *in,
> >         struct iovec iov[num_ad + 1];
> >         uint8_t v[16];
> >  =

> > -       memcpy(iov, ad, sizeof(iov) * num_ad);
> > +       memcpy(iov, ad, sizeof(struct iovec) * num_ad);
> =

> Good catch! I'm fine with this way, but also fine with simply
> removing
> * num_ad and leaving sizeof(iov) as is. Lets see what Denis prefers.

Oh sorry, this wont work. That would copy past 'ad'. Nevermind, lets do
it your way ;)

> =

> Thanks,
> James
> > _______________________________________________
> > iwd mailing list -- iwd(a)lists.01.org
> > To unsubscribe send an email to iwd-leave(a)lists.01.org
> =

> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org

--===============6448546356099755235==--

