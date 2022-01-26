Content-Type: multipart/mixed; boundary="===============5821293540622386723=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] sae: fix missing reallocarray definition
Date: Wed, 26 Jan 2022 12:22:44 -0600
Message-ID: <5191c2f7-d234-2444-91b1-4ea94cba38f6@gmail.com>
In-Reply-To: 20220126181942.3165190-1-prestwoj@gmail.com

--===============5821293540622386723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/26/22 12:19, James Prestwood wrote:
> Building on GCC 8 resulted in this compiler error. Newer versions seem
> to find malloc.h without the include, but not on GCC 8.
> =

> src/sae.c:107:25: error: implicit declaration of function 'reallocarray';
> 	did you mean 'realloc'? [-Werror=3Dimplicit-function-declaration]
> 	sm->rejected_groups =3D reallocarray(NULL, 2, sizeof(uint16_t));
> ---
>   src/sae.c | 2 ++
>   1 file changed, 2 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============5821293540622386723==--

