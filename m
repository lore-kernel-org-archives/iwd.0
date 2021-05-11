Content-Type: multipart/mixed; boundary="===============7248788406938035888=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] netdev: Pass a reason code with
 NETDEV_EVENT_DISCONNECT_BY_*
Date: Tue, 11 May 2021 11:36:25 -0500
Message-ID: <71fc7943-1909-5d5f-ecd5-225df4206de0@gmail.com>
In-Reply-To: <20210510101204.175551-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7248788406938035888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/10/21 5:12 AM, Andrew Zaborowski wrote:
> Station callbacks expect a reason code (as opposed to status codes) with
> this event type.  This shouldn't matter a lot because
> station_disconnect_event() only actually looks at the value during

I'm not sure why station is written this way.  I'm pretty sure that calling =

station_disconnect_event() for NETDEV_EVENT_DISCONNECT_BY_SME() is the wron=
g =

thing to do.

> connection establishment so usually the "result" parameter is going to
> be HANDSHAKE_FAILED meaning that we'd already be getting a reason code
> in status_or_reason, but there could be corner cases where we got a
> different "result".

That is correct for AP disconnections during handshaking, but that is signa=
led =

by NETDEV_EVENT_DISCONNECT_BY_AP...

> ---
>   src/netdev.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> =

> diff --git a/src/netdev.c b/src/netdev.c
> index 4fbe813a..6c063df5 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -771,10 +771,15 @@ static void netdev_connect_failed(struct netdev *ne=
tdev,
>   =

>   	if (connect_cb)
>   		connect_cb(netdev, result, &status_or_reason, connect_data);
> -	else if (event_filter)
> +	else if (event_filter) {
> +		/* NETDEV_EVENT_DISCONNECT_BY_SME expects a reason code */
> +		if (result !=3D NETDEV_RESULT_HANDSHAKE_FAILED)
> +			status_or_reason =3D MMPDU_REASON_CODE_UNSPECIFIED;
> +

 From what I remember, the only time we can get here is if a rekey somehow =

fails, or setting keys during a rekey fails.  Are there other cases?

>   		event_filter(netdev, NETDEV_EVENT_DISCONNECT_BY_SME,
>   				&status_or_reason,
>   				connect_data);
> +	}
>   }
>   =

>   static void netdev_disconnect_cb(struct l_genl_msg *msg, void *user_dat=
a)
> =


Anyway, I applied this with a modified commit description.

Regards,
-Denis
--===============7248788406938035888==--

