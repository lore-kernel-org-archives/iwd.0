Content-Type: multipart/mixed; boundary="===============1267645950836859829=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v7 1/5] scan: add scan API specifically for OWE transition
 networks
Date: Fri, 17 Sep 2021 18:05:43 -0500
Message-ID: <2defe7dd-86f5-ce1d-9ebd-eadb66b19922@gmail.com>
In-Reply-To: 20210917225840.26848-1-prestwoj@gmail.com

--===============1267645950836859829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/17/21 5:58 PM, James Prestwood wrote:
> Specifically OWE networks with multiple open/hidden BSS's are troublesome
> to scan for with the current APIs. The scan parameters are limited to a
> single SSID and even if that was changed we have the potential of hitting
> the max SSID's per scan limit. In all, it puts the burden onto the caller
> to sort out the SSIDs/frequencies to scan for.
> =

> Rather than requiring station to handle this a new scan API was added,
> scan_owe_hidden() which takes a list of open BSS's and will automatically
> scan for the SSIDs in the OWE transition IE for each.
> =

> It is slightly optimized to first check if all the hidden SSID's are the
> same. This is the most likely case (e.g. single pair or single network)
> and a single scan command can be used. Otherwise individual scan commands
> are queued for each SSID/frequency combo.
> ---
>   src/scan.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>   src/scan.h |   3 ++
>   2 files changed, 134 insertions(+), 8 deletions(-)

All applied, thanks.

Regards,
-Denis

--===============1267645950836859829==--

