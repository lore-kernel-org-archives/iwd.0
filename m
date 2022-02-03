Content-Type: multipart/mixed; boundary="===============2381883002662546225=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd 1.21 stuck on connecting state
Date: Thu, 03 Feb 2022 09:28:55 -0800
Message-ID: <3a4f9626fdae0a61df24e6e9c9fd7d25f0dea9b7.camel@gmail.com>
In-Reply-To: 20220203160500.3721.69429@ml01.vlan13.01.org

--===============2381883002662546225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This actually got merged an hour or two ago:

https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=3Db02c2034d8f05b=
4d731196de51a31cf1ef282e1f


On Thu, 2022-02-03 at 16:05 +0000,
54d22547-afc0-4701-b1fc-5a2a2e411646(a)simplelogin.co wrote:
> Hi.
> =

> > Below is a patch for ELL [1]. If its possible for you to apply it and
> > rebuild both IWD/ELL manually to test that would be great. The issue
> > should be solved but you will see an additional print when you
> > normally
> > would see IWD hang and never get connected:
> =

> I'm trying to apply the patch but I got several errors. I'm just
> copying and pasting it on a new file.
> =

> This is how I'm applying it: patch -d ell -p1 -i ../dhcp.patch
> =

> First it complained about being malformed:
> =

> patching file ell/dhcp.c
> patch: **** malformed patch at line 72: void *userdata,
> =

> Just fixed it putting lines 71 and 72 together. Then all 3 hunks
> failed:
> =

> patching file ell/dhcp.c
> Hunk #1 FAILED at 757.
> Hunk #2 FAILED at 766.
> Hunk #3 FAILED at 832.
> 3 out of 3 hunks FAILED -- saving rejects to file ell/dhcp.c.rej
> =

> I'm not used diff patching so probably I'm doing something wrong.
> =

> > [1]
> > https://lists.01.org/hyperkitty/list/ell(a)lists.01.org/thread/DJHXIOGG=
OCGG
> > ...
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============2381883002662546225==--

