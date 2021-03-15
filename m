Content-Type: multipart/mixed; boundary="===============5065023147118754293=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/4] scan: add scan_get_firmware_scan
Date: Mon, 15 Mar 2021 13:34:57 -0500
Message-ID: <a45dd4ed-0f3a-dc14-c9a9-0ca72df60828@gmail.com>
In-Reply-To: <20210315172931.173107-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5065023147118754293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 3/15/21 12:29 PM, James Prestwood wrote:
> Adds support for getting firmware scan results from the kernel.
> This is intended to be used after the firmware roamed automatically
> and the scan result is require for handshake initialization.
> =

> The scan 'request' is competely separate from the normal scan
> queue, though scan_results, scan_request, and the scan_context
> are all used for consistency and code reuse.
> ---
>   src/scan.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/scan.h |  3 +++
>   2 files changed, 79 insertions(+)
> =

> v2:
>   * It was found GET_SCAN could be used to grab actual scan
>     results rather than trying to gather up sparse info from
>     GET_STATION/GET_INTERFACE. This also allows reuse of existing
>     scan parsing code.
> =


I went ahead and applied all 4 with the following minor tweaks:

- In patch 1, I moved the code down in the file in order to get rid of the =

forward-declaration.
- In patch 3, I renamed the function to 'wiphy_supports_firmware_roam' sinc=
e =

'fw' is not a common contraction.
- Patch 4 was modified with the naming from patch 3 tweak.

Regards,
-Denis

--===============5065023147118754293==--

