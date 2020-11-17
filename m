Content-Type: multipart/mixed; boundary="===============5579213281275673085=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] station: get neighbor reports early
Date: Mon, 16 Nov 2020 18:16:13 -0600
Message-ID: <98d26206-c11f-7505-558d-4f27a6cceb29@gmail.com>
In-Reply-To: <20201116235400.3498197-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5579213281275673085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/16/20 5:54 PM, James Prestwood wrote:
> Waiting to request neighbor reports until we are in need of a roam
> delays the roam time, and probably isn't as reliable since we are
> most likely in a low RSSI state. Instead the neighbor report can
> be requested immediately after connecting, saved, and used if/when
> a roam is needed. The existing behavior is maintained if the early
> neighbor report fails where a neighbor report is requested at the
> time of the roam.
> =

> The code which parses the reports was factored out and shared
> between the existing (late) neighbor report callback and the early
> neighbor report callback.
> ---
>   src/station.c | 134 +++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 95 insertions(+), 39 deletions(-)
> =

> v2:
>   - NULL roam_freqs when resetting connection
>   - Keep comment about narrowing down scan results (just added to it)
>   - Fixed a few function argument formatting issues
> =


Applied, thanks.

Regards,
-Denis

--===============5579213281275673085==--

