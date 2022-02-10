Content-Type: multipart/mixed; boundary="===============6948893765745763358=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] station: only log station_autoconnect_start if
 autoconnecting
Date: Thu, 10 Feb 2022 16:21:49 -0600
Message-ID: <21bce403-d320-11b8-6f0c-92b9dc87b181@gmail.com>
In-Reply-To: 20220210205400.865795-1-prestwoj@gmail.com

--===============6948893765745763358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/10/22 14:54, James Prestwood wrote:
> This debug print was before any checks which could bail out prior to
> autoconnect starting. This was confusing because debug logs would
> contain multiple "station_autoconnect_start()" prints making you think
> autoconnect was started several times.
> ---
>   src/station.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============6948893765745763358==--

