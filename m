Content-Type: multipart/mixed; boundary="===============2119778989860975256=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: question on failed tests
Date: Wed, 09 Sep 2020 09:32:45 -0500
Message-ID: <907a6d62-215e-376a-34a7-e30084ad7bb4@gmail.com>
In-Reply-To: <CAG17S_OcQNrcOXfxOidK7wst=+UAUztYxX-kND2UNKy-VR+gnA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2119778989860975256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On 9/9/20 9:10 AM, KeithG wrote:
> I just built the iwd 1.9 for arch arm on armv6h, armv7h, and aarch64. The=
 aarch =

> 64 builds and fails 0 tests. The armv6 fails the crypto and eapol tests a=
nd the =

> armv7 fails the eapol test.

What kernels are running on these systems?

Note that Linux Kernel 5.8.4 or so had a regression in the crypto subsystem =

which would result in a failure in the way iwd/ell used the AF_ALG API.  Th=
is =

was patched shortly after.  You can upgrade, downgrade or backport the fix =
[1]

> Which kernel configs do I need to enable so that iwd fails 0 tests on all=
 3 =

> architectures?
> I searched the kernel configs for 'eapol' and found nothing. The 'crypto'=
 search =

> revealed a lot of settings, but all looked to be either 'm'=C2=A0 or 'y'.=
 I am a bit =

> out of my depth, here but i'm capable of building kernels for all 3 =

> architectures. Thanks for any guidance.

This script should have all the kernel options required for crypto (3rd sec=
tion =

from the top, starting at line 12):

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/tools/test_run=
ner_kernel_config#n12

[1] =

https://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git/comm=
it/?id=3Dc195d66a8a75c60515819b101975f38b7ec6577f

Regards,
-Denis
--===============2119778989860975256==--

