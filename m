Content-Type: multipart/mixed; boundary="===============7415415591612884646=="
MIME-Version: 1.0
From: Robert Joslyn <robert.joslyn@redrectangle.org>
Subject: Re: [PATCH] wiphy: Relpace rawmemchr with memchr
Date: Mon, 03 Feb 2020 22:15:10 -0800
Message-ID: <124a2f29aacf742c57b51ac1c59cd4040542a0c5.camel@redrectangle.org>
In-Reply-To: <f89b63ef-cfe5-d950-c1a0-f3eaaab4fe4c@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7415415591612884646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-03 at 11:55 -0600, Denis Kenzior wrote:
> Hi Robert,
> =

> On 2/1/20 1:53 AM, Robert Joslyn wrote:
> > The rawmemchr function is a GNU extension, and not available in other
> > libc implementations, such as musl.
> > ---
> >   src/wiphy.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > =

> > diff --git a/src/wiphy.c b/src/wiphy.c
> > index 1da479db..141b3cb9 100644
> > --- a/src/wiphy.c
> > +++ b/src/wiphy.c
> > @@ -500,7 +500,7 @@ const uint8_t *wiphy_get_supported_rates(struct
> > wiphy *wiphy, unsigned int band,
> >   =

> >   	if (out_num)
> >   		*out_num =3D
> > -			(uint8_t *) rawmemchr(wiphy-
> > >supported_rates[band], 0) -
> > +			(uint8_t *) memchr(wiphy->supported_rates[band],
> > 0, (size_t)-1) -
> >   			wiphy->supported_rates[band];
> >   =

> >   	return wiphy->supported_rates[band];
> > =

> =

> Unfortunately this causes gcc to complain:
> =

> src/wiphy.c: In function =E2=80=98wiphy_get_supported_rates=E2=80=99:
> src/wiphy.c:503:16: error: =E2=80=98memchr=E2=80=99 specified size 184467=
44073709551615 =

> exceeds maximum object size 9223372036854775807 [-Werror=3Dstringop-
> overflow=3D]
>    503 |    (uint8_t *) memchr(wiphy->supported_rates[band], 0, =

> (size_t)-1) -
>        |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ~~~
> =

> can you try the attached patch instead?
> =

> Regards,
> -Denis

Hi Denis,

Sorry about that. I'm doing my builds with Yocto/OpenEmbedded (master
branch) and was able to build with both glibc and musl with my original
patch, but compile flags or gcc version are probably different.

Your patch works fine for me and looks like a better approach.

This got me curious, so I looked at what glibc does: =

http://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dstring/rawmemchr.c;h=
=3Db62d285d7efa882b3928fae03318273d588f15bd;hb=3DHEAD

I expect the use of strlen when looking for null is slightly faster, but
probably doesn't really matter here.

Thanks for taking a look and working on a fix!

Robert

--===============7415415591612884646==--

