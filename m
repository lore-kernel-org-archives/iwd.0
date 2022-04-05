Content-Type: multipart/mixed; boundary="===============3616027517105330422=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3] network: Hide hidden networks on connection error
Date: Tue, 05 Apr 2022 09:34:29 -0500
Message-ID: <07242056-a1fb-64b3-4aa5-bcbc26deb49e@gmail.com>
In-Reply-To: MRZP264MB1544FC552250631C5868B22793E49@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM

--===============3616027517105330422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Emmanuel,

On 4/5/22 06:19, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> If a user connection fails on a freshly scanned psk or open hidden networ=
k,
> during passphrase request or after, it shall be removed from the network =
list.
> Otherwise, it would be possible to directly connect to that known
> network, which will appear as not hidden.
> =

> Commit 06ca8e20a9b0 ("station: Hide forgotten hidden networks")
> ---
>   src/network.c | 11 +++++++++++
>   src/station.c |  2 ++
>   2 files changed, 13 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============3616027517105330422==--

