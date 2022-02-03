Content-Type: multipart/mixed; boundary="===============7748978430309818203=="
MIME-Version: 1.0
From: 54d22547-afc0-4701-b1fc-5a2a2e411646 at simplelogin.co
To: iwd at lists.01.org
Subject: Re: iwd 1.21 stuck on connecting state
Date: Thu, 03 Feb 2022 16:05:00 +0000
Message-ID: <20220203160500.3721.69429@ml01.vlan13.01.org>
In-Reply-To: 693ddbdafd550d947e1e9a2e4e36685a9a0de4c2.camel@gmail.com

--===============7748978430309818203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi.

> Below is a patch for ELL [1]. If its possible for you to apply it and
> rebuild both IWD/ELL manually to test that would be great. The issue
> should be solved but you will see an additional print when you normally
> would see IWD hang and never get connected:

I'm trying to apply the patch but I got several errors. I'm just copying an=
d pasting it on a new file.

This is how I'm applying it: patch -d ell -p1 -i ../dhcp.patch

First it complained about being malformed:

patching file ell/dhcp.c
patch: **** malformed patch at line 72: void *userdata,

Just fixed it putting lines 71 and 72 together. Then all 3 hunks failed:

patching file ell/dhcp.c
Hunk #1 FAILED at 757.
Hunk #2 FAILED at 766.
Hunk #3 FAILED at 832.
3 out of 3 hunks FAILED -- saving rejects to file ell/dhcp.c.rej

I'm not used diff patching so probably I'm doing something wrong.

> [1]
> https://lists.01.org/hyperkitty/list/ell(a)lists.01.org/thread/DJHXIOGGOC=
GG...
--===============7748978430309818203==--

