Content-Type: multipart/mixed; boundary="===============7230707432524669146=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH] test-runner: Drop unused parameter
Date: Mon, 09 Aug 2021 13:39:50 -0700
Message-ID: <8621b6783199237a7305d2f479b02213b95e3be0.camel@gmail.com>
In-Reply-To: <CAOq732JGC=-Oddn-C_QKYs5mBKym3DQvvQ-aCdvrQ4fPeKMK_w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7230707432524669146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-08-09 at 11:20 +0200, Andrew Zaborowski wrote:
> On Sat, 7 Aug 2021 at 04:46, James Prestwood <prestwoj@gmail.com>
> wrote:
> > On Sat, 2021-08-07 at 03:51 +0200, Andrew Zaborowski wrote:
> > > --- a/tools/test-runner
> > > +++ b/tools/test-runner
> > > @@ -164,7 +164,7 @@ class Process:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 case.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '''
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def __init__(self, args, w=
ait=3DFalse, env=3DNone, ctx=3DNone,
> > > check=3DFalse,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 outfile=3DNone, namespace=3DNone,
> > > need_out=3DFalse, cleanup=3DNone):
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 outfile=3DNone, namespace=3DNone,
> > > cleanup=3DNone):
> > =

> > This is fine, but we also need to remove the use in hostapd.py for
> > list_sta/send_bss_transition.
> =

> Good point, looks like some tests will fail without that.=C2=A0 I'm also
> fine dropping this patch.

I think we should still remove it since Process.out is always populated
now. But another consideration is that I am touching just about every
autotest in existence as well as utility files so I can just tack this
onto my current patch set to avoid any rebase pain.

Thanks,
James

> =

> Best regards


--===============7230707432524669146==--

