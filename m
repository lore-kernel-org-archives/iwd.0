Content-Type: multipart/mixed; boundary="===============3789397425215908145=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v1] dpp: fix implicit declaration of function
 explicit_bzero warning
Date: Mon, 10 Jan 2022 15:44:49 -0600
Message-ID: <b42ac45a-0b40-b488-6e26-4ad5a3beee5e@gmail.com>
In-Reply-To: 20220110213218.12896-1-ps.report@gmx.net

--===============3789397425215908145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 1/10/22 15:32, Peter Seiderer wrote:
> - add missing src/missing.h include for explicit_bzero, fixes uclibc
>    compile/linking
> =

> Fixes:
> =

>    src/dpp.c:166:2: warning: implicit declaration of function =E2=80=98ex=
plicit_bzero=E2=80=99 [-Wimplicit-function-declaration]
>      166 |  explicit_bzero(dpp->r_nonce, dpp->nonce_len);
>          |  ^~~~~~~~~~~~~~
> ---
>   src/dpp.c | 1 +
>   1 file changed, 1 insertion(+)
> =


Applied, thanks.

Regards,
-Denis

--===============3789397425215908145==--

