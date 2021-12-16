Content-Type: multipart/mixed; boundary="===============7943005355300526097=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v4 01/10] dpp-util: add dpp_point_to_asn1
Date: Thu, 16 Dec 2021 14:19:03 -0600
Message-ID: <2f5a9c35-a873-732c-2a83-4b8576b0aa7d@gmail.com>
In-Reply-To: 20211216180854.39470-1-prestwoj@gmail.com

--===============7943005355300526097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/16/21 12:08, James Prestwood wrote:
> Converts an l_ecc_point to the DPP ASN.1 structure.
> ---
>   src/dpp-util.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/dpp-util.h |  2 ++
>   2 files changed, 92 insertions(+)
> =

> v4:
>   * Removed unneeded length check
>   * Removed '512 bit' OID, this isn't actually a key size
> =


Applied, thanks.

Regards,
-Denis

--===============7943005355300526097==--

