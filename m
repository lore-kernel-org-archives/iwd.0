Content-Type: multipart/mixed; boundary="===============6218704666994914607=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/2] scan: use signal strength if bss ranks are equal
Date: Mon, 08 Nov 2021 13:50:58 -0600
Message-ID: <cdc6a49e-3959-b3a4-1f66-848a7dbacebd@gmail.com>
In-Reply-To: 20211108193930.1013040-1-prestwoj@gmail.com

--===============6218704666994914607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/8/21 1:39 PM, James Prestwood wrote:
> If two BSS's end up with the same rank sort them based on signal
> strength so IWD still prefers the higher strength BSS.
> ---
>   src/scan.c | 4 ++++
>   1 file changed, 4 insertions(+)

Both applied, thanks.

Regards,
-Denis

--===============6218704666994914607==--

