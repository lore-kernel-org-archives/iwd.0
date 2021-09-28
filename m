Content-Type: multipart/mixed; boundary="===============4016002732919295348=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 1/5] ft: check authenticator_ie from ft_ds_info, not
 handshake
Date: Tue, 28 Sep 2021 17:26:59 -0500
Message-ID: <da52d384-b966-eff3-97fc-48315e483979@gmail.com>
In-Reply-To: 20210928222553.1096611-1-prestwoj@gmail.com

--===============4016002732919295348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/28/21 5:25 PM, James Prestwood wrote:
> The handshake contains the current BSS's RSNE/WPA which may differ
> from the FT-over-DS target. When verifying the target BSS's RSNE/WPA
> IE needs to be checked, not the current BSS.
> ---
>   src/ft.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============4016002732919295348==--

