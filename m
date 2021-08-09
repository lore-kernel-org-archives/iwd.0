Content-Type: multipart/mixed; boundary="===============1499416353851480422=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] test-runner: Drop unused parameter
Date: Mon, 09 Aug 2021 11:20:10 +0200
Message-ID: <CAOq732JGC=-Oddn-C_QKYs5mBKym3DQvvQ-aCdvrQ4fPeKMK_w@mail.gmail.com>
In-Reply-To: <11b428f8f83524d45f5abf5bda179fcd8a9f4b23.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1499416353851480422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Aug 2021 at 04:46, James Prestwood <prestwoj@gmail.com> wrote:
> On Sat, 2021-08-07 at 03:51 +0200, Andrew Zaborowski wrote:
> > --- a/tools/test-runner
> > +++ b/tools/test-runner
> > @@ -164,7 +164,7 @@ class Process:
> >                 case.
> >         '''
> >         def __init__(self, args, wait=3DFalse, env=3DNone, ctx=3DNone,
> > check=3DFalse,
> > -                               outfile=3DNone, namespace=3DNone,
> > need_out=3DFalse, cleanup=3DNone):
> > +                               outfile=3DNone, namespace=3DNone,
> > cleanup=3DNone):
>
> This is fine, but we also need to remove the use in hostapd.py for
> list_sta/send_bss_transition.

Good point, looks like some tests will fail without that.  I'm also
fine dropping this patch.

Best regards
--===============1499416353851480422==--

