Content-Type: multipart/mixed; boundary="===============4783388977873810524=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] crypto: incorporate C implementation of ARC4
Date: Mon, 03 Aug 2020 16:31:08 -0500
Message-ID: <4225d828-ac0f-c88d-c16c-5363a8bc86d9@gmail.com>
In-Reply-To: <20200803104509.124604-1-ardb@kernel.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4783388977873810524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ard,

On 8/3/20 5:45 AM, Ard Biesheuvel wrote:
> Incorporate the LGPL v2.1 licensed implementation of ARC4, taken from
> the Nettle project (https://git.lysator.liu.se/nettle/nettle.git,
> commit 3e7a480a1e351884), and tweak it a bit so we don't have to
> operate on a skip buffer to fast forward the stream cipher, but can
> simply invoke it with NULL dst or src arguments to achieve the same.
> =

> This removes the dependency [via libell] on the OS's implementation of
> ecb(arc4), which may be going away, and which is not usually accelerated
> in the first place.
> =

> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

We don't use S-o-B tags, so I dropped this one

> ---
>   src/crypto.c      | 82 ++++++++++++++++++++++++++++++-----------------
>   src/main.c        |  8 -----
>   unit/test-eapol.c |  3 +-
>   3 files changed, 53 insertions(+), 40 deletions(-)
> =


Applied, thanks.

Regards,
-Denis
--===============4783388977873810524==--

