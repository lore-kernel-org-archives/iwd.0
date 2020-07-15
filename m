Content-Type: multipart/mixed; boundary="===============0885271400764395270=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v8] netdev: use wiphy radio work queue for connections
Date: Wed, 15 Jul 2020 17:12:21 -0500
Message-ID: <9f4b0e4d-f0eb-31f2-6235-aa3b1203dd00@gmail.com>
In-Reply-To: <20200715212917.16717-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0885271400764395270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 7/15/20 4:29 PM, James Prestwood wrote:
> This adds connection/FT attempts to the radio work queue. This
> will ensure that connections aren't delayed or done concurrently
> with scanning.
> ---
>   src/netdev.c  | 191 ++++++++++++++++++++++++++++++++++++--------------
>   src/station.c |   8 +--
>   2 files changed, 141 insertions(+), 58 deletions(-)
> =

> v8:
>   - Put auth-proto/normal connects back together as this prevented SAE
>     from randomizing the address
>   - Separated out ft work into its own worker function
> =


Applied, thanks.

Regards,
-Denis

--===============0885271400764395270==--

