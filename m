Content-Type: multipart/mixed; boundary="===============3432503176195111869=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/3] auto-t: iwd.py: remove StationDebug out of Device init
Date: Tue, 04 Jan 2022 11:44:04 -0600
Message-ID: <b9541a56-2e0e-0acf-4ed0-e84edac66751@gmail.com>
In-Reply-To: 20220104173736.93682-1-prestwoj@gmail.com

--===============3432503176195111869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/4/22 11:37, James Prestwood wrote:
> Since a Device class can represent multiple modes (AP, AdHoc, station)
> move StationDebug out of the init and only create this class when it
> is used (presumably only when the device is in station mode).
> =

> The StationDebug class is now created in a property method consistent
> with 'station_if'. If Device is not in station mode it is automatically
> switched if the test tries any StationDebug methods.
> =

> If the Device mode is changed from 'station' the StationDebug class
> instance is destroyed.
> ---
>   autotests/util/iwd.py | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============3432503176195111869==--

