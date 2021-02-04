Content-Type: multipart/mixed; boundary="===============0740358379756361635=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix missing `#include "missing.h"`.
Date: Thu, 04 Feb 2021 09:15:53 -0600
Message-ID: <36c1ae16-ff42-76a1-e46d-d1633deefeb9@gmail.com>
In-Reply-To: <20210204092937.1726283-1-mc5686@mclink.it>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0740358379756361635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

Patches against ell should go to ell(a)lists.01.org.  But since this is suc=
h a =

trivial one, I'll take care of it.

On 2/4/21 3:29 AM, Mauro Condarelli wrote:
> If explicit_bzero() is not available (e.g.: with uClibc) build fails
> because of:
> =

> ell/cert.c: In function =E2=80=98cert_key_from_pkcs8_encrypted_private_ke=
y_info=E2=80=99:
> ell/cert.c:665:2: warning: implicit declaration of function =E2=80=98expl=
icit_bzero=E2=80=99 [-Wimplicit-function-declaration]
>    665 |  explicit_bzero(decrypted, data_len);
>        |  ^~~~~~~~~~~~~~
> =

> in spite of correct detection:
> =

> checking for explicit_bzero... no
> =

> and:
> =

> ...
> /* Define to 1 if you have the `explicit_bzero' function. */
> /* #undef HAVE_EXPLICIT_BZERO */
> ...
> =

> Fix is adding `#include "missing.h"` as it is done in simila files.
> =

> Signed-off-by: Mauro Condarelli <mc5686@mclink.it>

We don't use the Signed-off-by tags in ell or iwd, so feel free to drop the=
se.

> ---
>   ell/cert.c | 1 +
>   1 file changed, 1 insertion(+)
> =


Applied with a slight tweak to the commit description.

Regards,
-Denis
--===============0740358379756361635==--

