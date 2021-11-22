Content-Type: multipart/mixed; boundary="===============8404634067813957634=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: Re: iwd / wireless direct / P2P documentation
Date: Mon, 22 Nov 2021 15:57:56 +0100
Message-ID: <CAOq732KEN8HVDXEksH_DArx8wNwveFvDXLKMw_kx9G8=63jiKQ@mail.gmail.com>
In-Reply-To: CADdae-gewCJPSGY-MXTYBrWGzAG-SD1LJt-+YN17Bq8wNJQAYQ@mail.gmail.com

--===============8404634067813957634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Mon, 22 Nov 2021 at 15:46, Nicolas Prochazka
<nicolas.prochazka(a)gmail.com> wrote:
> Hello,
> Is there a tutorial or example for configuring two linux boxes in P2P mod=
e with iwctl ?

There isn't one and no P2P commands are available in iwctl at this
time.  P2P is still work-in-progress in IWD but generally you need a
program that implements a P2P service (similar to bluetooth profile)
and that program can talk to IWD directly, so iwctl commands would not
be useful.  Wi-Fi Display is the main service that is targeted.

Technically you should be able to run the test/connect-p2p script on
one machine without passing any peer name, and run:

test/connect-p2p <first-machine's-name>

on the other and that should give you an IP connection if successful.
Both IWD instances need to have EnableNetworkConfiguration=3D1 in their
main.conf.

Best regards
--===============8404634067813957634==--

