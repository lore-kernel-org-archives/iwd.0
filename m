Content-Type: multipart/mixed; boundary="===============2932980042971874546=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] ft: remove frame type check in FT
Date: Mon, 23 May 2022 13:01:45 -0500
Message-ID: <4a37ea31-42b9-52f6-bb56-9db3134cccb0@gmail.com>
In-Reply-To: 20220523181649.33288-1-prestwoj@gmail.com

--===============2932980042971874546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/23/22 13:16, James Prestwood wrote:
> A user reported that IWD was failing to FT in some cases and this was
> due to the AP setting the Retry bit in the frame type. This was
> unexpected by IWD since it directly checks the frame type against
> 0x00b0 which does not account for any B8-B15 bits being set.
> =

> IWD doesn't need to verify the frame type field for a few reasons:
> First mpdu_validate checks the management frame type, Second the kernel
> checks prior to forwarding the event. Because of this the check was
> removed completely.
> ---
>   src/ft.c | 5 -----
>   1 file changed, 5 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============2932980042971874546==--

