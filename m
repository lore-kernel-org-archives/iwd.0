Content-Type: multipart/mixed; boundary="===============1336313537824343057=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 1/6] dpp: don't allocate transient ssid strings
Date: Mon, 10 Jan 2022 10:59:48 -0600
Message-ID: <4557c689-fec6-d555-ed0a-364ad9c886e7@gmail.com>
In-Reply-To: 20220108001333.723634-1-prestwoj@gmail.com

--===============1336313537824343057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/7/22 18:13, James Prestwood wrote:
> These can be kept on the stack and avoid the need for
> allocated memory and unneeded auto-free functionality.
> ---
>   src/dpp.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============1336313537824343057==--

