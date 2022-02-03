Content-Type: multipart/mixed; boundary="===============3846249987114003537=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] netdev: fix bug setting OWE IE length
Date: Thu, 03 Feb 2022 11:41:03 -0600
Message-ID: <a4bafff2-b9ff-367e-04e2-2ab11fe265f0@gmail.com>
In-Reply-To: 20220203172418.87777-1-prestwoj@gmail.com

--===============3846249987114003537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/3/22 11:24, James Prestwood wrote:
> The length was being set to whatever the last nl80211 attribute was,
> not the length for the RESP_IE iteration.
> ---
>   src/netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============3846249987114003537==--

