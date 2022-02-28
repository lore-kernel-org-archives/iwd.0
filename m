Content-Type: multipart/mixed; boundary="===============6996670584759785011=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 1/4] scan: add support for scanning on AP interface type
Date: Mon, 28 Feb 2022 13:33:08 -0600
Message-ID: <eb27b001-b1f4-c078-5d3b-6e1cfabec7e9@gmail.com>
In-Reply-To: 20220228184939.3150560-1-prestwoj@gmail.com

--===============6996670584759785011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/28/22 12:49, James Prestwood wrote:
> This adds a new flag, force_ap to the scan parameters. When enabled
> this will set NL80211_SCAN_FLAG_AP.
> ---
>   src/scan.c | 3 +++
>   src/scan.h | 1 +
>   2 files changed, 4 insertions(+)
> =

> v3:
>   * Removed the feature check.
> =


All applied, thanks.

Regards,
-Denis

--===============6996670584759785011==--

