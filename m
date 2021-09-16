Content-Type: multipart/mixed; boundary="===============7005088911472223176=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 4/7] network: fix pending hidden OWE scan logic
Date: Thu, 16 Sep 2021 11:11:17 -0500
Message-ID: <e1c845e4-b6ee-6110-d8cd-588ce793caa4@gmail.com>
In-Reply-To: 20210915230548.179425-4-prestwoj@gmail.com

--===============7005088911472223176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/15/21 6:05 PM, James Prestwood wrote:
> This was actually broken if triggered because __network_connect
> checks if network->connect_after_owe_hidden is set and returns
> already in progress. We want to keep this behavior though for
> obvious reasons.
> =

> To fix this station_connect_network can be called directly which
> bypasses the check. This is essentially how ANQP avoids this
> problem as well.
> ---
>   src/network.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7005088911472223176==--

