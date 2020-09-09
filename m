Content-Type: multipart/mixed; boundary="===============0116350624585620263=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/17] ap: Fix iteration over ap->rates
Date: Thu, 10 Sep 2020 00:21:47 +0200
Message-ID: <CAOq732LB43FNzRyfmm5OE9BdRiZDc3jg-tJpgdhy-x3DeZFn-A@mail.gmail.com>
In-Reply-To: <5be3f883-2c9f-f69b-af33-fdd90d8618fb@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0116350624585620263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 9 Sep 2020 at 19:02, Denis Kenzior <denkenz@gmail.com> wrote:
> On 9/9/20 11:51 AM, Andrew Zaborowski wrote:
> > On Wed, 9 Sep 2020 at 17:37, Denis Kenzior <denkenz@gmail.com> wrote:
> >> On 9/8/20 6:49 PM, Andrew Zaborowski wrote:
> >>> In the for loops use a condition that works even if the uint32_t valu=
es
> >>> overflow since l_uintset_find_min/max() return UINT_MAX for empty set=
s.
> >>
> >> So it only returns UINT_MAX for set objects that are NULL, not empty.
> >
> > Ah, true.  If it's empty we'll get 201 as set->max is 200.
>
> So why is the set 200 anyway when the max is 127? ;)

I don't remember, I guess I could fix it in this same patch.

>
> >
> >> How are
> >> you even passing in NULL objects that you're hitting this condition?  =
That seems
> >> to be a logic error?
> >
> > It is/was, this is the other fix in this patch.
>
> Okay, then the rest of it is a big hammer for no good reason.  I'd just f=
ix the
> logic error where ap->rates was NULL and leave the rest as is.

I thought that was a very small change and since the uintset functions
under some conditions do return UINT_MAX maybe it's the better way to
write those loops.  But I can drop this change.

>
> Or use l_uintset_foreach...
>
> >>> -     for (r =3D minr; r <=3D maxr && count < 8; r++)
> >>> +     for (r =3D minr; (int32_t) (maxr - r) >=3D 0 && count < 8; r++)
> >>>                if (l_uintset_contains(ap->rates, r)) {
> >>>                        uint8_t flag =3D 0;
> >>
> >> Looking at this code closely I totally hate how this is done.  You are=
 only
> >> going to be calling l_uintset_contains a few million times even though=
 you know
> >> the basic rates are only 7 bits and the set cannot have more than 127 =
entries.
> >
> > If the set contains rates between 2 and 22 we only make 11 calls, the
> > loop iterates from l_uintset_find_min(ap->rates) to
> > l_uintset_find_max(ap->rates), or am I missing something?  If the set
> > is empty we make one call... we could replace that with an isempty()
> > call if needed.
>
> If the set is valid, sure.  But if the set wasn't valid you're iterating 2
> billion times or something,

You're iterating indefinitely.

Oh ok, yes, the original code contained an overflow bug, once I
understood it I didn't like it either ;-)  Hence the fix.

> when a static 0..127 would have been enough.

For an invalid set, 0..127 is still wasteful ;-)

>
> >
> > Granted we're iterating over values that don't correspond to standard
> > rates, we could store indexes into the array of known rates to save
> > some iterations.
> >
>
> Maybe consider just using wiphy_get_supported_rates() instead.

Right, but we're giving the user (of the ap.h API) some control over
which rates to support so the plan is to eventually call it but during
ap_start only.

Best regards
--===============0116350624585620263==--

