Content-Type: multipart/mixed; boundary="===============8494863540402245727=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/17] ap: Fix iteration over ap->rates
Date: Thu, 10 Sep 2020 03:43:30 +0200
Message-ID: <CAOq732Jw7xiPvuDLk3V9Jqy91FJhyHrZ_K-R+xa3OTX5hvZ8XA@mail.gmail.com>
In-Reply-To: <04b8b097-cb98-41c8-9a2a-7ee630b5e958@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8494863540402245727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Sep 2020 at 02:47, Denis Kenzior <denkenz@gmail.com> wrote:
> > Oh ok, yes, the original code contained an overflow bug, once I
> > understood it I didn't like it either ;-)  Hence the fix.
>
> Ok, I'm not following now.  Are you saying there was a possibility of an =
empty
> (not NULL) set somehow?  If so, shouldn't this have been caught in ap_sta=
rt
> somewhere?  In the end, a NULL or empty set would produce an invalid IE.
> Assuming a set is valid, then I don't see anything wrong with the current=
 code?

Currently we add either 3 or 8 numbers to the set, but we had a bug there.

You said:

> Looking at this code closely I totally hate how this is done.  You are on=
ly
> going to be calling l_uintset_contains a few million times

I was trying to understand whether you referred to the old code (which
was fine except if ap->rates was NULL where l_uintset_contains was
called in an endless loop...) or the new code (which is fine either
way).  I guess you must have referred to the old code in the ap->rates
=3D=3D NULL scenario... in that case I guess I also dislike that code
because of the corner case overflow bug but I can't see anything wrong
with it otherwise.  And both versions should be fine once we fix the
ap_start bug...

Hence the fix ;-)

> Or am I missing something?
>
> i.e. what is wrong with
> if (L_WARN_ON(!ap->rates || l_uintset_isempty(ap->rates))
>         return 0;
>
> .. proceed as before.

Since ap->rates shouldn't need to ever change after ap_start, I'd
rather not add explicit checks everywhere.

>
> >
> >> when a static 0..127 would have been enough.
> >
> > For an invalid set, 0..127 is still wasteful ;-)
> >
>
> Of course, but at least you don't have to think about the cast and the
> arithmetic and go 'what in the world is that doing'...
>
> But really, l_uintset_foreach seems to be the better candidate here.

Ok.

>
> >>
> >>>
> >>> Granted we're iterating over values that don't correspond to standard
> >>> rates, we could store indexes into the array of known rates to save
> >>> some iterations.
> >>>
> >>
> >> Maybe consider just using wiphy_get_supported_rates() instead.
> >
> > Right, but we're giving the user (of the ap.h API) some control over
> > which rates to support so the plan is to eventually call it but during
> > ap_start only.
>
> You're giving a no_cck hint, not control over the rates, right? So the ra=
tes
> should still come from wiphy_get_supported_rates().

To be specific I think the final set should be a result of multiple
calls to wiphy_get_supported_rates and the no_cck_rates setting.

>  If you want to stuff these
> into the uintset or just carry the no_cck hint into the IE builders is a
> different question.  I would think the latter would be easier.

Not sure about that, but I didn't mean to refactor this code, only fix
a few one-liners.  The refactoring if needed can happen in an
independent commit without functionality changes.

Best regards
--===============8494863540402245727==--

