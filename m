Content-Type: multipart/mixed; boundary="===============1101760641139199653=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] dpp,dpp-util: cast size_t for constant arguments to
 va_arg
Date: Fri, 03 Jun 2022 11:55:46 -0500
Message-ID: <b2a30d65-20e9-7cd2-30a2-d070c841c793@gmail.com>
In-Reply-To: 20220603170016.182052-1-prestwoj@gmail.com

--===============1101760641139199653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/3/22 12:00, James Prestwood wrote:
> There were a few places in dpp/dpp-util which passed a single byte but
> was being read in with va_arg(va, size_t). On some architectures this was
> causing failures presumably from the compiler using an integer type
> smaller than size_t. As we do elsewhere, cast to size_t to force the
> compiler to pass a properly sized iteger to va_arg.
> ---
>   src/dpp-util.c |  6 ++++--
>   src/dpp.c      | 10 ++++++----
>   2 files changed, 10 insertions(+), 6 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============1101760641139199653==--

