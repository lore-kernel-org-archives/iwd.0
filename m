Content-Type: multipart/mixed; boundary="===============5321304132977699832=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] station: fix OWE scan logic with autoconnect
Date: Thu, 20 Jan 2022 13:54:36 -0600
Message-ID: <eb24bc28-a724-482d-c518-b793c495ff07@gmail.com>
In-Reply-To: 20220119190345.2265563-1-prestwoj@gmail.com

--===============5321304132977699832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/19/22 13:03, James Prestwood wrote:
> station_set_scan_results takes an autoconnect flag which was being
> set true in both regular/quick autoconnect scans. Since OWE networks
> are processed after setting the scan results IWD could end up
> connecting to a network before all the OWE hidden networks are
> populated.
> =

> To fix this regular/quick autoconnect results will set the flag to
> false, then process OWE networks, then start autoconnect. If any
> OWE network scans are pending station_autoconnect_start will fail
> but will pick back up after the hidden OWE scan.
> ---
>   src/station.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
Denis

--===============5321304132977699832==--

