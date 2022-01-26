Content-Type: multipart/mixed; boundary="===============7302498587298204809=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] handshake: use _hs directly in handshake_event
Date: Wed, 26 Jan 2022 12:17:08 -0600
Message-ID: <ab727f18-cc7b-1317-d06c-72e75d1599d1@gmail.com>
In-Reply-To: 20220126174100.3162606-1-prestwoj@gmail.com

--===============7302498587298204809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/26/22 11:41, James Prestwood wrote:
> Certain platforms/compilers were having issues with using the 'hs'
> local in this macro (likely has something to do with the caller
> also using a local 'hs' variable name). This caused a crash on these
> platforms. Using the macro argument _hs directly fixes the crash.
> ---
>   src/handshake.h | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7302498587298204809==--

