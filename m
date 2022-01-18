Content-Type: multipart/mixed; boundary="===============3387711250646138406=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] dpp-util: fix dpp_point_to_asn1 compressed type
Date: Tue, 18 Jan 2022 13:55:37 -0600
Message-ID: <46d72047-bbad-2dcf-d80b-5d67fb7fd874@gmail.com>
In-Reply-To: 20220118165846.1968568-1-prestwoj@gmail.com

--===============3387711250646138406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/18/22 10:58, James Prestwood wrote:
> The point type was being hard coded to 0x3 (BIT1) which may have resulted
> in the peer subtracting Y from P when reading in the point (depending on
> if Y was odd or not).
> =

> Instead set the compressed type to whatever avoids the subtraction which
> both saves IWD from needing to do it, as well as the peer.
> ---
>   src/dpp-util.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> =


This patch doesn't apply cleanly.  Can you rebase?

Regards,
-Denis

--===============3387711250646138406==--

