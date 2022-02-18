Content-Type: multipart/mixed; boundary="===============0505983709587072592=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 3/3] dpp: check return of aes_siv_encrypt
Date: Fri, 18 Feb 2022 14:47:20 -0600
Message-ID: <c90e67e5-57e5-5fd0-7e94-c929b108f519@gmail.com>
In-Reply-To: 20220218195506.2145602-3-prestwoj@gmail.com

--===============0505983709587072592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/18/22 13:55, James Prestwood wrote:
> This was caught by static analysis. As is common this should never
> happen in the real world since the only way this can fail (apart from
> extreme circumstances like OOM) is if the key size is incorrect, which
> it will never be.
> ---
>   src/dpp.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0505983709587072592==--

