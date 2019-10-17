Content-Type: multipart/mixed; boundary="===============1170236736699555104=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH v2] util: add bounds check to util_get_{domain,username}
Date: Thu, 17 Oct 2019 09:11:43 -0700
Message-ID: <1ecf60655a0909d2cfaa047d973c8205b2ee3dfc.camel@gmail.com>
In-Reply-To: <0b1e4e35-e6a3-57cb-c96a-c40991b41f8f@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1170236736699555104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-17 at 11:04 -0500, Denis Kenzior wrote:
> Hi James,
> =

> On 10/17/19 10:49 AM, James Prestwood wrote:
> > Two cases were using strcpy, and the other two were using strncpy.
> > Instead all cases can use l_strlcpy which guarentees NULL
> > termination.
> > ---
> >   src/util.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > =

> > diff --git a/src/util.c b/src/util.c
> > index f787ce6b..1291d9c9 100644
> > --- a/src/util.c
> > +++ b/src/util.c
> > @@ -173,10 +173,10 @@ const char *util_get_domain(const char
> > *identity)
> >   	for (c =3D identity; *c; c++) {
> >   		switch (*c) {
> >   		case '\\':
> > -			strncpy(domain, identity, c - identity);
> > +			l_strlcpy(domain, identity, c - identity);
> =

> Using l_strlcpy here is wrong.  You want to copy a substrict of c - =

> identity bytes into domain where identity does not have any embedded =

> nulls.  But passing c - identity into l_strlcpy would not work the
> way =

> you think.   Also, the existing code has an inherent assumption that
> c - =

> identity is always <=3D 253 bytes.  So really, nothing here is
> dangerous...
> =

> If anything we should be using memcpy to make this more clear.  If
> you =

> want to be pedantic, then you need to check that c - identity is < =

> sizeof(domain).

Ok, since there is actually a comment explaining the identity length
assumption I will just do memcpy and not bother checking the length.
> > =

> =

> Regards,
> -Denis
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org

--===============1170236736699555104==--

