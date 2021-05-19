Content-Type: multipart/mixed; boundary="===============2220489848090329614=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/7] scan: rework BSS ranking
Date: Wed, 19 May 2021 10:00:47 -0500
Message-ID: <59d5f498-f319-1dd1-755e-b8df66b48c0b@gmail.com>
In-Reply-To: <20210507202620.93540-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2220489848090329614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/7/21 3:26 PM, James Prestwood wrote:
> It was observed that IWD's ranking for BSS's did not always
> end up with the fastest being chosen. This was due to IWD's
> heavy weight on signal strength. This is a decent way of ranking
> but even better is calculating a theoretical data rate which
> was also done and factored in. The problem is the data rate
> factor was always outdone by the signal strength.
> =

> Intead remove signal strength entirely as this is already taken
> into account with the data rate calculation. This also removes
> the check for rate IEs. If no IEs are found the parser will
> base the data rate soley on RSSI.
> =

> There were a few other factors removed which will be added back
> when ranking *networks* rather than BSS's. WPA version (or open)
> was removed as well as the privacy capability. These values really
> should not differ between BSS's in the same SSID and as such
> should be used for network ranking instead.
> ---
>   src/scan.c | 63 ++++++++++++++----------------------------------------
>   1 file changed, 16 insertions(+), 47 deletions(-)
> =

> v2:
>   * Added support for BSS's that did not have any rate IEs by
>     using the same ie_parse_data_rates
> =


I went ahead and applied the rest of this series (2-4).

Regards,
-Denis

--===============2220489848090329614==--

