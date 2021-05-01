Content-Type: multipart/mixed; boundary="===============1994843552292530570=="
MIME-Version: 1.0
From: Alexander Monakov <amonakov@ispras.ru>
Subject: Re: Use of kernel crypto lib
Date: Sun, 02 May 2021 01:09:49 +0300
Message-ID: <alpine.LNX.2.20.13.2105020001400.28416@monopod.intra.ispras.ru>
In-Reply-To: <D573918B-4D7E-4430-B5F1-6A874E0713D4@holtmann.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1994843552292530570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I was curious about IWD enough to try it, and it seems my investigation
helped to uncover a previously unknown compatibility issue. However, I'm not
happy with what I see, so probably I'm not going to use IWD on a regular
basis. I'll address individual points below:

On Sat, 1 May 2021, Marcel Holtmann wrote:

> every user has access to the Keys subsystem in the Linux kernel and can
> load whatever certificate they want. So I don=E2=80=99t buy this argument.

That is a strange reference to make. I am the only human user on my laptop,
and software I run (except IWD) is not going to load certificates obtained
from an untrusted network device to a keyring. For example, when I browse
the web, the browser is not giving websites sufficient access to do that.
And that is probably true for most users of IWD.

> Frankly any ANS.1 parsing that is vulnerable is an issue here since by
> definition a WiFi daemon has to run with pretty much root privileges.

As I said, with seccomp it's possible to confine risky computations to an
unprivileged subprocess.

> Even on a Linux with a recent systemd (where we take as much privileges
> away as possible), there is still a large risk for overtaking the daemon.
> That is also the reason why we generally limited our daemons to a single
> process (LimitNPROC=3D1) since if they can=E2=80=99t spawn any other proc=
ess, they
> also don=E2=80=99t get into being a shell. And consistent usage of CLOEXE=
C will
> quickly trigger a watchdog killing the process.

Yes, as you say a properly sandboxed daemon will deal less damage: an
adversary might not possess enough exploits at the same time to break
through all the mitigations. That is why short-cutting through all such
counter-measures with in-kernel certificate validation is a big issue.

> Anyhow, no system is prefect and neither are any TLS libraries.

Agreed, and that is why I want to see risky processing of untrusted network
input in a minimally privileged userspace instead of kernelspace.

> > I don't buy the comparison against signed modules offered on IRC. A ran=
dom
> > webpage I visit cannot trivially elevate itself to root to attempt to
> > load a module with crafted signature. IWD's use strikes me as reckless
> > to put it mildly.
> =

> No, not more reckless than any other daemon that has to run as root.

I don't see other daemons do in kernelspace what they could more safely
do in userspace.

> I still have to see a TLS library that is any good and that seamlessly
> integrates with hardware crypto and TPMs. So please enlighten us here.

I wouldn't mind the use of kernel crypto API when it's justified, but in
this case I see no benefit, and a few downsides like unnecessary risks and
highly complicated debugging, pushed by IWD on its users.

Thanks.
Alexander

--===============1994843552292530570==--

