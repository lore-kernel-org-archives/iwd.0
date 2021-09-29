Content-Type: multipart/mixed; boundary="===============3807693957064270264=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] station: Add missing netconfig_reset()
Date: Wed, 29 Sep 2021 18:12:03 -0500
Message-ID: <082cbccd-46d4-7f99-16cf-e57a5702881c@gmail.com>
In-Reply-To: 20210929222201.124492-1-andrew.zaborowski@intel.com

--===============3807693957064270264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/29/21 5:22 PM, Andrew Zaborowski wrote:
> On NETDEV_EVENT_DISCONNECT_BY_* events during netconfig, we'd forget to
> call netconfig_reset() before trying a new netconfig_configure()
> resulting in the "netconfig: Failed to start DHCPv4 client for interface
> %u" warning and a L_WARN_ON.  Add the missing call.

So you're still not including the useful information that would be very use=
ful =

that was mentioned in the earlier thread...

> ---
>   src/station.c | 3 +++
>   1 file changed, 3 insertions(+)
> =

> diff --git a/src/station.c b/src/station.c
> index 934815f2..1c073fc1 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -2810,6 +2810,9 @@ static void station_disconnect_event(struct station=
 *station, void *event_data)
>   	switch (station->state) {
>   	case STATION_STATE_CONNECTING:
>   	case STATION_STATE_CONNECTING_AUTO:
> +		if (station->netconfig)
> +			netconfig_reset(station->netconfig);
> +

NAK.  This is still not addressing the underlying bug.  It should not go vi=
a the =

station_connect_cb path at all.  Perhaps you need to add a new =

CONNECTED_NETCONFIG state instead.

>   		station_connect_cb(station->netdev,
>   					NETDEV_RESULT_HANDSHAKE_FAILED,
>   					event_data, station);
> =


Regards,
-Denis
--===============3807693957064270264==--

