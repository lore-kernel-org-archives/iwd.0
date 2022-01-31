Content-Type: multipart/mixed; boundary="===============3222378302014047380=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] scan: parse BSS_SIGNAL_UNSPEC, fix potential zero signal
Date: Mon, 31 Jan 2022 13:48:52 -0600
Message-ID: <b6c16d7d-af37-755c-dd8f-4a55e2858327@gmail.com>
In-Reply-To: 20220125180206.3098383-1-prestwoj@gmail.com

--===============3222378302014047380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/25/22 12:02, James Prestwood wrote:
> A select few drivers send this instead of SIGNAL_MBM. The docs say this
> value is the signal 'in unspecified units, scaled to 0..100'. The range
> for SIGNAL_MBM is -10000..0 so this can be scaled to the MBM range easy
> enough...
> =

> Now, this isn't exactly correct because this value ultimately gets
> returned from GetOrderedNetworks() and is documented as 100 * dBm where
> in reality its just a unit-less signal strength value. Its not ideal, but
> this patch at least will fix BSS ranking for these few drivers.
> ---
>   src/scan.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> =

> I am fine leaving this on the list until we get an answer from the origin=
al
> thread about what driver this happened with:
> =

> https://lists.01.org/hyperkitty/list/iwd(a)lists.01.org/thread/PLYNHZWEEN=
Y3RIMUNAWDDPHHPHRDCJOR/
> =

> If its not one of these drivers, and not related to SIGNAL_UNSPEC, we
> will need to investigate further.
> =


Applied, thanks.

Regards,
-Denis

--===============3222378302014047380==--

