Content-Type: multipart/mixed; boundary="===============6712254839906225596=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 06/10] dpp: pass dpp_sm to dpp_send_frame
Date: Wed, 12 Jan 2022 09:40:45 -0600
Message-ID: <def6a55e-7fc6-8579-31a7-2fde7ba1e3ea@gmail.com>
In-Reply-To: 20220112005558.1158405-6-prestwoj@gmail.com

--===============6712254839906225596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/11/22 18:55, James Prestwood wrote:
> The SM has the wdev_id already, so rather than using that or looking
> up just pass the dpp_sm directly.
> ---
>   src/dpp.c | 20 +++++++++-----------
>   1 file changed, 9 insertions(+), 11 deletions(-)
> =


<snip>

>   =

> -static void dpp_send_frame(uint64_t wdev_id, struct iovec *iov, size_t i=
ov_len,
> +static void dpp_send_frame(struct dpp_sm *dpp, struct iovec *iov, size_t=
 iov_len,
>   			uint32_t freq)

I fixed up this line being > 80 chars and applied, thanks.

Regards,
-Denis
--===============6712254839906225596==--

