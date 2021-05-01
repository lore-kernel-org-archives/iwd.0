Content-Type: multipart/mixed; boundary="===============4759194721509773179=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Use of kernel crypto lib
Date: Sat, 01 May 2021 04:27:48 +0200
Message-ID: <D573918B-4D7E-4430-B5F1-6A874E0713D4@holtmann.org>
In-Reply-To: <alpine.LNX.2.20.13.2105010134530.28416@monopod.intra.ispras.ru>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4759194721509773179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

> I raised the topic of inappropriate use of kernel crypto lib for
> certchain validation in IWD and was told it was discussed previously. I
> do not see such threads in the archives (but at the moment archives
> before September 2019 are not available).
> =

> To me this design looks poorly justified. IWD seems to basically use the
> kernel crypto API as a normal crypto library, just running with kernel
> privileges. The kernel code is evidently imperfect, and IWD is basically
> short-cutting any defense-in-depth measures that could have been in
> place by feeding certificates presented by random APs to the kernel.
> =

> I don't want to get a kernel oops (or worse) by simply walking past by
> an "evil" access point.
> =

> If history tells us that ASN.1 parsing code usually has mistakes, then
> applying also the principle of least privilege I expect certificate
> validation to run in a seccomp'ed child subprocess of IWD, not the
> kernel.

every user has access to the Keys subsystem in the Linux kernel and can loa=
d whatever certificate they want. So I don=E2=80=99t buy this argument. Fra=
nkly any ANS.1 parsing that is vulnerable is an issue here since by definit=
ion a WiFi daemon has to run with pretty much root privileges. Even on a Li=
nux with a recent systemd (where we take as much privileges away as possibl=
e), there is still a large risk for overtaking the daemon. That is also the=
 reason why we generally limited our daemons to a single process (LimitNPRO=
C=3D1) since if they can=E2=80=99t spawn any other process, they also don=
=E2=80=99t get into being a shell. And consistent usage of CLOEXEC will qui=
ckly trigger a watchdog killing the process.

Anyhow, no system is prefect and neither are any TLS libraries.

> I don't buy the comparison against signed modules offered on IRC. A random
> webpage I visit cannot trivially elevate itself to root to attempt to
> load a module with crafted signature. IWD's use strikes me as reckless
> to put it mildly.

No, not more reckless than any other daemon that has to run as root.

> (there's also the "patch-the-kernel-to-use-IWD" angle, which is less
> important, but still: whenever kernel crypto lib doesn't cut it, the
> user has to upgrade the kernel or ditch IWD; in my adjacent thread it
> happened due to leaf cert not following RFC, but it could plausibly
> happen with completely valid certificates as well)

I still have to see a TLS library that is any good and that seamlessly inte=
grates with hardware crypto and TPMs. So please enlighten us here.

Regards

Marcel

--===============4759194721509773179==--

