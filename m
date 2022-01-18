Content-Type: multipart/mixed; boundary="===============4951720147924933486=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] dpp-util: fix dpp_point_to_asn1 compressed type
Date: Tue, 18 Jan 2022 15:02:31 -0600
Message-ID: <aa1f48a8-4359-d421-4942-dbef6204f74d@gmail.com>
In-Reply-To: 20220118195950.1996926-1-prestwoj@gmail.com

--===============4951720147924933486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/18/22 13:59, James Prestwood wrote:
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


Applied, thanks.

Regards,
-Denis

--===============4951720147924933486==--

