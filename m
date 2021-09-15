Content-Type: multipart/mixed; boundary="===============4945070922808446948=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 05/13] network: set handshake SSID based on BSS, not
 network
Date: Wed, 15 Sep 2021 14:59:30 -0500
Message-ID: <b5de6e12-39bc-a33d-c6f8-64c9aa223a96@gmail.com>
In-Reply-To: 20210915173624.11917-5-prestwoj@gmail.com

--===============4945070922808446948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/15/21 12:36 PM, James Prestwood wrote:
> This is being added to support OWE transition mode. For these
> type of networks the OWE BSS may contain a different SSID than
> that of the network, but the WFA spec requires this be hidden
> from the user. This means we need to set the handshake SSID based
> on the BSS rather than the network object.
> ---
>   src/network.c | 5 ++---
>   src/network.h | 2 +-
>   src/station.c | 2 +-
>   3 files changed, 4 insertions(+), 5 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============4945070922808446948==--

