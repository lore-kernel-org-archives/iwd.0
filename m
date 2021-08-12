Content-Type: multipart/mixed; boundary="===============5126484079707968280=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/3] station: add ConnectBssid() developer method
Date: Thu, 12 Aug 2021 14:59:51 -0500
Message-ID: <4323558b-c5d4-3bfe-12b4-4bbd975de6a6@gmail.com>
In-Reply-To: <20210812190723.732722-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5126484079707968280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/12/21 2:07 PM, James Prestwood wrote:
> This method will initiate a connection to a specific BSS rather
> than relying on a network based connection (which the user has
> no control over which specific BSS is selected).
> ---
>   src/station.c | 143 ++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 109 insertions(+), 34 deletions(-)
> =

> v4:
>   * Reworked station_parse_bss to just parse security
>   * Updated the common code in station to use station_parse_bss_security
>   * Limited ConnectBssid() to only non-hidden networks
> =


All applied, thanks.

Regards,
-Denis

--===============5126484079707968280==--

