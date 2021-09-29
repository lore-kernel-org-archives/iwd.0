Content-Type: multipart/mixed; boundary="===============4471757902266107647=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] station: Move netconfig_reset() to common path
Date: Wed, 29 Sep 2021 14:51:02 -0500
Message-ID: <a85148df-d206-87d6-a3dd-9105ecc013ee@gmail.com>
In-Reply-To: 20210929164254.118503-1-andrew.zaborowski@intel.com

--===============4471757902266107647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/29/21 11:42 AM, Andrew Zaborowski wrote:
> Move the netconfig_reset calls to inside
> station_reset_connection_state() instead of having each caller do

This is on purpose.  There should be no need to call netconfig_reset if =

netconfig_configure wasn't called in the first place.

> netconfig_reset() followed by station_reset_connection_state().  One of
> the callers was missing the netconfig_reset() and this was resulting in
> the "netconfig: Failed to start DHCPv4 client for interface %u" warning.

You need to figure out why calling netconfig_load_settings causes side-effe=
cts =

and fix that instead.

> ---
>   src/station.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> =


Regards,
-Denis
--===============4471757902266107647==--

