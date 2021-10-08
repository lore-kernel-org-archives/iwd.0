Content-Type: multipart/mixed; boundary="===============5001483337128660778=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] netdev: set TK index to zero for FT
Date: Fri, 08 Oct 2021 14:14:13 -0500
Message-ID: <7f82d3b3-5e26-d31b-1678-74b72c28126b@gmail.com>
In-Reply-To: 20211008185005.2911529-1-prestwoj@gmail.com

--===============5001483337128660778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/8/21 1:50 PM, James Prestwood wrote:
> Since FT re-uses the handshake the active TK index may be set to a
> non-zero value.
> ---
>   src/netdev.c | 1 +
>   1 file changed, 1 insertion(+)
> =


Applied, thanks.

Regards,
-Denis

--===============5001483337128660778==--

