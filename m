Content-Type: multipart/mixed; boundary="===============2751031391708941475=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/17] ap: Fix iteration over ap->rates
Date: Wed, 09 Sep 2020 18:51:46 +0200
Message-ID: <CAOq732Ko9cO5+htHGvh9aRNFYYkqjJh_Fr3t6HzX15C6er1RFw@mail.gmail.com>
In-Reply-To: <a133e6d5-ac1b-80e7-b0b4-450b1ef8d4b7@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2751031391708941475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 9 Sep 2020 at 17:37, Denis Kenzior <denkenz@gmail.com> wrote:
> On 9/8/20 6:49 PM, Andrew Zaborowski wrote:
> > In the for loops use a condition that works even if the uint32_t values
> > overflow since l_uintset_find_min/max() return UINT_MAX for empty sets.
>
> So it only returns UINT_MAX for set objects that are NULL, not empty.

Ah, true.  If it's empty we'll get 201 as set->max is 200.

> How are
> you even passing in NULL objects that you're hitting this condition?  Tha=
t seems
> to be a logic error?

It is/was, this is the other fix in this patch.

>
> > If the condition is r <=3D l_uintset_find_max() or similar, it's always
> > true.
> >
> > Make sure ap->rates is non-NULL both with and without no_cck_rates.
> >
> > Update "count" in the for loop in ap_build_beacon_pr_head()
> > ---
> >   src/ap.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/src/ap.c b/src/ap.c
> > index 1cee185c..84d4539a 100644
> > --- a/src/ap.c
> > +++ b/src/ap.c
> > @@ -371,7 +371,7 @@ static size_t ap_build_beacon_pr_head(struct ap_sta=
te *ap,
> >       minr =3D l_uintset_find_min(ap->rates);
> >       maxr =3D l_uintset_find_max(ap->rates);
> >       count =3D 0;
> > -     for (r =3D minr; r <=3D maxr && count < 8; r++)
> > +     for (r =3D minr; (int32_t) (maxr - r) >=3D 0 && count < 8; r++)
> >               if (l_uintset_contains(ap->rates, r)) {
> >                       uint8_t flag =3D 0;
>
> Looking at this code closely I totally hate how this is done.  You are on=
ly
> going to be calling l_uintset_contains a few million times even though yo=
u know
> the basic rates are only 7 bits and the set cannot have more than 127 ent=
ries.

If the set contains rates between 2 and 22 we only make 11 calls, the
loop iterates from l_uintset_find_min(ap->rates) to
l_uintset_find_max(ap->rates), or am I missing something?  If the set
is empty we make one call... we could replace that with an isempty()
call if needed.

Granted we're iterating over values that don't correspond to standard
rates, we could store indexes into the array of known rates to save
some iterations.

>
> >
> > @@ -2071,6 +2071,7 @@ struct ap_state *ap_start(struct netdev *netdev, =
struct ap_config *config,
> >       ap->ciphers =3D wiphy_select_cipher(wiphy, 0xffff);
> >       ap->group_cipher =3D wiphy_select_cipher(wiphy, 0xffff);
> >       ap->beacon_interval =3D 100;
> > +     ap->rates =3D l_uintset_new(200);
> >
> >       /* TODO: Pick from actual supported rates */
> >       if (config->no_cck_rates) {
> > @@ -2083,7 +2084,6 @@ struct ap_state *ap_start(struct netdev *netdev, =
struct ap_config *config,
> >               l_uintset_put(ap->rates, 96); /* 48 Mbps*/
> >               l_uintset_put(ap->rates, 108); /* 54 Mbps*/
> >       } else {
> > -             ap->rates =3D l_uintset_new(200);
> >               l_uintset_put(ap->rates, 2); /* 1 Mbps*/

These two changes fix not allocating ap->rates if no_cck_rates was
set, this is why it was NULL.

Best regards
--===============2751031391708941475==--

