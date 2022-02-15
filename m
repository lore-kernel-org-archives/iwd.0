Content-Type: multipart/mixed; boundary="===============6005994439176876303=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] dpp: unregister interface on exit
Date: Tue, 15 Feb 2022 15:19:44 -0600
Message-ID: <ca6e1cad-b242-260a-7401-bf9073fec60c@gmail.com>
In-Reply-To: 20220215211646.1328388-1-prestwoj@gmail.com

--===============6005994439176876303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/15/22 15:16, James Prestwood wrote:
> This fixes a cleanup issue where DPP tries to cleanup both on
> dpp_exit() and when netdev goes down.
> ---
>   src/dpp.c | 2 ++
>   1 file changed, 2 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============6005994439176876303==--

