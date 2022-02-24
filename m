Content-Type: multipart/mixed; boundary="===============1479032889026771820=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] sae: define _GNU_SOURCE for reallocarray definition
Date: Thu, 24 Feb 2022 12:15:42 -0600
Message-ID: <8148f6d0-e485-74ca-b6b8-2ad3dec22d82@gmail.com>
In-Reply-To: 20220224180037.2797609-1-prestwoj@gmail.com

--===============1479032889026771820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/24/22 12:00, James Prestwood wrote:
> sae.c was failing to build on some platforms:
> =

> error: implicit declaration of function 'reallocarray'; did you mean 'rea=
lloc'?
> 	[-Werror=3Dimplicit-function-declaration]
> ---
>   src/sae.c | 1 +
>   1 file changed, 1 insertion(+)

Applied, thanks.

Regards,
-Denis

--===============1479032889026771820==--

