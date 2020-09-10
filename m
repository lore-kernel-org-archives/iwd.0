Content-Type: multipart/mixed; boundary="===============5875181376390676679=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/17] ap: Fix iteration over ap->rates
Date: Wed, 09 Sep 2020 20:50:43 -0500
Message-ID: <13dbefc0-af98-75e8-2d6c-84419a3094a8@gmail.com>
In-Reply-To: <CAOq732Jw7xiPvuDLk3V9Jqy91FJhyHrZ_K-R+xa3OTX5hvZ8XA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5875181376390676679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> called in an endless loop...) or the new code (which is fine either

I'm not sure its fine though?  By my reading it enters into the loop at lea=
st =

once, so you're sending a bogus IE anyway (with 0xff or something).  But an=
yhow, =

this is academic.

>> You're giving a no_cck hint, not control over the rates, right? So the r=
ates
>> should still come from wiphy_get_supported_rates().
> =

> To be specific I think the final set should be a result of multiple
> calls to wiphy_get_supported_rates and the no_cck_rates setting.

Why multiple? You're just operating on one band, no?

> =

>>   If you want to stuff these
>> into the uintset or just carry the no_cck hint into the IE builders is a
>> different question.  I would think the latter would be easier.
> =

> Not sure about that, but I didn't mean to refactor this code, only fix
> a few one-liners.  The refactoring if needed can happen in an
> independent commit without functionality changes.

Okay, then lets just fix the NULL set issue and move on without touching th=
e loops.

Regards,
-Denis
--===============5875181376390676679==--

