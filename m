Content-Type: multipart/mixed; boundary="===============1828875839368043851=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 7/9] ap: Delay ap_free if called inside event handler
Date: Tue, 09 Nov 2021 14:32:40 -0600
Message-ID: <095fad7e-1960-1541-5f17-d700d442c419@gmail.com>
In-Reply-To: 20211108112838.372416-7-andrew.zaborowski@intel.com

--===============1828875839368043851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/8/21 5:28 AM, Andrew Zaborowski wrote:
> ap.c has been mostly careful to call the event handler at the end of any
> externally called function to allow methods like ap_free() to be called
> within the handler, but that isn't enough.  For example in
> ap_del_station we may end up emitting two events: STATION_REMOVED and
> DHCP_LEASE_EXPIRED.  Use a slightly more complicated mechanism to
> explicitly guard ap_free calls inside the event handler.
> =

> To make it easier, simplify cleanup in ap_assoc_reassoc with the use of
> _auto_.
> =

> In ap_del_station reorder the actions to send the STATION_REMOVED event
> first as the DHCP_LEASE_EXPIRED is a consequence of the former and it
> makes sense for the handler to react to it first.
> ---
>   src/ap.c | 125 +++++++++++++++++++++++++++++++++++--------------------
>   1 file changed, 80 insertions(+), 45 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============1828875839368043851==--

