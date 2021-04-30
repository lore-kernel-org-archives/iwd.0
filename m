Content-Type: multipart/mixed; boundary="===============2682735162775413023=="
MIME-Version: 1.0
From: Alexander Monakov <amonakov@ispras.ru>
Subject: Use of kernel crypto lib
Date: Sat, 01 May 2021 02:04:58 +0300
Message-ID: <alpine.LNX.2.20.13.2105010134530.28416@monopod.intra.ispras.ru>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2682735162775413023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I raised the topic of inappropriate use of kernel crypto lib for
certchain validation in IWD and was told it was discussed previously. I
do not see such threads in the archives (but at the moment archives
before September 2019 are not available).

To me this design looks poorly justified. IWD seems to basically use the
kernel crypto API as a normal crypto library, just running with kernel
privileges. The kernel code is evidently imperfect, and IWD is basically
short-cutting any defense-in-depth measures that could have been in
place by feeding certificates presented by random APs to the kernel.

I don't want to get a kernel oops (or worse) by simply walking past by
an "evil" access point.

If history tells us that ASN.1 parsing code usually has mistakes, then
applying also the principle of least privilege I expect certificate
validation to run in a seccomp'ed child subprocess of IWD, not the
kernel.

I don't buy the comparison against signed modules offered on IRC. A random
webpage I visit cannot trivially elevate itself to root to attempt to
load a module with crafted signature. IWD's use strikes me as reckless
to put it mildly.

(there's also the "patch-the-kernel-to-use-IWD" angle, which is less
important, but still: whenever kernel crypto lib doesn't cut it, the
user has to upgrade the kernel or ditch IWD; in my adjacent thread it
happened due to leaf cert not following RFC, but it could plausibly
happen with completely valid certificates as well)

Alexander
--===============2682735162775413023==--

