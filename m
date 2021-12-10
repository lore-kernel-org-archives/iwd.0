Content-Type: multipart/mixed; boundary="===============5086530421477384994=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] dpp-util: check return of l_ecc_scalar_get_data
Date: Fri, 10 Dec 2021 10:43:16 -0600
Message-ID: <c26483df-125b-a542-ed76-b2ba551c7a1f@gmail.com>
In-Reply-To: 20211210164839.1938702-1-prestwoj@gmail.com

--===============5086530421477384994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/10/21 10:48 AM, James Prestwood wrote:
> Static analysis was not happy since this return can be negative and
> it was being fed into an unsigned argument. In reality this cannot
> happen since the key buffer is always set to the maximum size supported
> by any curves.
> ---
>   src/dpp-util.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============5086530421477384994==--

