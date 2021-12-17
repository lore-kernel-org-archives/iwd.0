Content-Type: multipart/mixed; boundary="===============1685648849804028318=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v6 1/2] dpp: add support for configuration protocol
Date: Fri, 17 Dec 2021 15:34:41 -0600
Message-ID: <f41cf8e0-5636-9d94-e122-40a55b806439@gmail.com>
In-Reply-To: 20211217212952.228229-1-prestwoj@gmail.com

--===============1685648849804028318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/17/21 15:29, James Prestwood wrote:
> This is a minimal implementation only supporting legacy network
> configuration, i.e. only SSID and PSK/passphrase are supported.
> =

> Missing features include:
>   - Fragmentation/comeback delay support
>   - DPP AKM support
>   - 8021x/PKEX support
> ---
>   src/dpp.c | 334 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 334 insertions(+)
> =

> v6:
>   * Added length checks to configuration response
> =


Both applied, thanks.

Regards,
-Denis

--===============1685648849804028318==--

