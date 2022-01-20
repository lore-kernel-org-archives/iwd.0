Content-Type: multipart/mixed; boundary="===============7764823407477268466=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 01/12] dpp-util: use ell/asn1-private.h for ASN1 generation
Date: Thu, 20 Jan 2022 14:04:54 -0600
Message-ID: <01cf0651-9736-71e2-d994-6c796eded55e@gmail.com>
In-Reply-To: 20220118212512.2017977-1-prestwoj@gmail.com

--===============7764823407477268466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/18/22 15:25, James Prestwood wrote:
> ASN1 parsing will soon be required which will need some utilities in
> asn1-private.h. To avoid duplication include this private header and
> replace the OID's with the defined structures as well as remove the
> duplicated macros.
> ---
>   src/dpp-util.c | 49 +++++++++++++++++++++++++------------------------
>   1 file changed, 25 insertions(+), 24 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7764823407477268466==--

