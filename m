Content-Type: multipart/mixed; boundary="===============7207377045227625612=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: Enabling IPv6 causes immediate segfault on connect
Date: Wed, 10 Nov 2021 09:30:04 -0600
Message-ID: <243fa539-ee0b-6286-0c99-b52afe19273a@gmail.com>
In-Reply-To: 20211110081638.8a1b690f39566ffce5f8f765@gmx.com

--===============7207377045227625612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 11/10/21 7:16 AM, Tmore1 wrote:
> Hello,
> =

> After many years of managing wireless with Debian's ifupdown +
> wpa_supplicant, I tried iwd, and I love it so far: I really appreciate
> its polish, cleanliness, and responsiveness. Thanks much for this
> software!

Thank you for the kind words.  We're glad you like it!

> =

> There seems to be a problem with its IPv6 support: on my system
> (Debian Sid, iwd 1.19 from distro repo), iwd works perfectly out of the
> box, and continues to work with "EnableNetworkConfiguration=3DTrue", but
> with "EnableIPv6=3Dtrue", it segfaults immediately upon connect. (This is
> especially awkward when iwd is being managed by systemd, since I then
> get an endless loop of the daemon crashing and immediately restarting,
> with a steady stream of messages hitting syslog ;))

I believe this issue is already fixed in ell upstream.  Commit d0f00698245a =

("dhcp6: Switch to BOUND before LEASE_OBTAINED") here:
https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=3Dd0f00698245a2d=
ccbd4b853e3d7b94e7a76cd906

Note that IPv6 support in iwd is still somewhat experimental since we still=
 lack =

support for SLAAC, but DHCPv6 should be mostly functional.

Regards,
-Denis
--===============7207377045227625612==--

