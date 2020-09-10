Content-Type: multipart/mixed; boundary="===============4877483832559570579=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/17] ap: Fix iteration over ap->rates
Date: Thu, 10 Sep 2020 04:33:05 +0200
Message-ID: <CAOq732LwLcZReUR4uXLpK31HVMJ_X-fLT5739e4UbToUvkOeVw@mail.gmail.com>
In-Reply-To: <13dbefc0-af98-75e8-2d6c-84419a3094a8@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4877483832559570579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Sep 2020 at 04:04, Denis Kenzior <denkenz@gmail.com> wrote:
> > called in an endless loop...) or the new code (which is fine either
>
> I'm not sure its fine though?  By my reading it enters into the loop at l=
east
> once, so you're sending a bogus IE anyway (with 0xff or something).  But =
anyhow,
> this is academic.

l_uintset_contains() would be false, so the IE would be empty but in
any case invalid.

>
> >> You're giving a no_cck hint, not control over the rates, right? So the=
 rates
> >> should still come from wiphy_get_supported_rates().
> >
> > To be specific I think the final set should be a result of multiple
> > calls to wiphy_get_supported_rates and the no_cck_rates setting.
>
> Why multiple? You're just operating on one band, no?

Yes, true, we probably need just one call.

>
> >
> >>   If you want to stuff these
> >> into the uintset or just carry the no_cck hint into the IE builders is=
 a
> >> different question.  I would think the latter would be easier.
> >
> > Not sure about that, but I didn't mean to refactor this code, only fix
> > a few one-liners.  The refactoring if needed can happen in an
> > independent commit without functionality changes.
>
> Okay, then lets just fix the NULL set issue and move on without touching =
the loops.

Ok.

Best regards
--===============4877483832559570579==--

