Content-Type: multipart/mixed; boundary="===============8843183733617487413=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/2] ie: refactor parsing supported data rates
Date: Fri, 14 May 2021 14:30:14 -0500
Message-ID: <b469964f-85d6-46db-ec54-49a566df4820@gmail.com>
In-Reply-To: <20210514192253.454140-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8843183733617487413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/14/21 2:22 PM, James Prestwood wrote:
> Both ext/supported rates IEs are obtained from scan results. These
> IEs are passed to ie_tlv_init/ie_tlv_next, as well as direct length
> checks (for supported rates at least, extended supported rates can
> be as long as a single byte integer can hold, 1 - 255) which verifies
> that the length in the IE matches the overall IE length that is
> stored in scan_bss. Because of this, ie_parse_supported_rates_from_data
> was doing double duty re-initializing a TLV iterator.
> =

> Intead, since we know the IE length is within bounds, the length/data
> can simply be directly accessed out of the buffer. This avoids the need
> for a wrapper function entirely.
> =

> The length parameters were also removed, since this is now obtained
> directly from the IE.
> ---
>   src/ie.c | 76 +++++++++++++++-----------------------------------------
>   src/ie.h |  6 -----
>   2 files changed, 20 insertions(+), 62 deletions(-)
> =

> v3:
>   * Added back in len =3D=3D 0 check. This is NOT verified in scan.c, only
>     the total length is sanity checked.
> =


Applied, thanks.

Regards,
-Denis

--===============8843183733617487413==--

