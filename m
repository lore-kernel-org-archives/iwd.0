Content-Type: multipart/mixed; boundary="===============1933127913795987702=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] fils: pragma false positive for uninitialized variable
Date: Fri, 10 Jun 2022 13:59:36 -0500
Message-ID: <abdb0d23-8395-93a4-770f-5083794b10aa@gmail.com>
In-Reply-To: 20220610184017.356608-1-prestwoj@gmail.com

--===============1933127913795987702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/10/22 13:40, James Prestwood wrote:
> On musl-gcc the compiler is giving a warning for igtk_key_index
> and gtk_key_index being used uninitialized. This isn't possible
> since they are only used if gtk/igtk are non-NULL so pragma to
> ignore the warning.
> =

> src/fils.c: In function 'fils_rx_associate':
> src/fils.c:580:17: error: 'igtk_key_index' may be used uninitialized
> 	in this function [-Werror=3Dmaybe-uninitialized]
>    580 |                 handshake_state_install_igtk(fils->hs,
> 					igtk_key_index,igtk + 6,
> 					igtk_len - 6, igtk);
> =

> (same error for gtk_key_index)
> ---
>   src/fils.c | 3 +++
>   1 file changed, 3 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============1933127913795987702==--

