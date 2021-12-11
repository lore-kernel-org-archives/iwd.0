Content-Type: multipart/mixed; boundary="===============7447519811143220647=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] json: fix pointer arithmetic error
Date: Fri, 10 Dec 2021 18:00:14 -0600
Message-ID: <9dfbef87-bffd-1215-d512-d9e62f55ae26@gmail.com>
In-Reply-To: 20211211001307.2102791-1-prestwoj@gmail.com

--===============7447519811143220647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/10/21 6:13 PM, James Prestwood wrote:
> Subtracting the pointers is sufficient for counting the tokens,
> they do not need to be modulus the size of jsmntok_t
> ---
>   src/json.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7447519811143220647==--

