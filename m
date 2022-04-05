Content-Type: multipart/mixed; boundary="===============2995284338860981090=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/2] netdev: check for connected in FT frame event
Date: Tue, 05 Apr 2022 13:31:50 -0500
Message-ID: <0bb84991-90e4-4ebc-164f-d7542156ce43@gmail.com>
In-Reply-To: 20220405182141.855536-1-prestwoj@gmail.com

--===============2995284338860981090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/5/22 13:21, James Prestwood wrote:
> This frame could come unsolicited and cause a NULL dereference
> if IWD is not connected.
> ---
>   src/netdev.c | 3 +++
>   1 file changed, 3 insertions(+)
> =


Both applied, thanks.

Regards,
-Denis

--===============2995284338860981090==--

