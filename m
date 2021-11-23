Content-Type: multipart/mixed; boundary="===============2603948698425900729=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 1/2] netdev: always honor disconnect events if issued
 by AP
Date: Tue, 23 Nov 2021 12:19:43 -0600
Message-ID: <36dcbf21-be6b-3899-09ac-24917830eed7@gmail.com>
In-Reply-To: 20211123181732.3617090-1-prestwoj@gmail.com

--===============2603948698425900729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/23/21 12:17 PM, James Prestwood wrote:
> The disconnect event handler was mistakenly bailing out if FT or
> reassociation was going on. This was done because a disconnect
> event is sent by the kernel when CMD_AUTH/CMD_ASSOC is used.
> =

> The problem is an AP could also disconnect IWD which should never
> be ignored.
> =

> To fix this always parse the disconnect event and, if issued by
> the AP, always notify watchers of the disconnect.
> ---
>   src/netdev.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============2603948698425900729==--

