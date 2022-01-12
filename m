Content-Type: multipart/mixed; boundary="===============3114103702044945713=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 07/10] dpp: support retransmitting frames with no ACK
Date: Wed, 12 Jan 2022 10:04:41 -0600
Message-ID: <763d1de1-b174-2e8d-d4af-4302a3aa3d47@gmail.com>
In-Reply-To: 20220112005558.1158405-7-prestwoj@gmail.com

--===============3114103702044945713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/11/22 18:55, James Prestwood wrote:
> The DPP spec says nothing about how to handle re-transmits but it
> was found in testing this can happen relatively easily for a few
> reasons.
> =

> If the configurator requests a channel switch but does not get onto
> the new channel quick enough the enrollee may have already sent the
> authenticate response and it was missed. Also by nature of how the
> kernel goes offchannel there are moments in time between ROC when
> the card is idle and not receiving any frames.
> =

> Only frames where there was no ACK will be retransmitted. If the
> peer received the frame and dropped it resending the same frame wont
> do any good.
> ---
>   src/dpp.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 94 insertions(+), 1 deletion(-)
> =


<snip>

> @@ -204,13 +211,26 @@ static void dpp_free(struct dpp_sm *dpp)
>   		dpp->boot_private =3D NULL;
>   	}
>   =

> +	if (dpp->mlme_watch) {
> +		l_genl_family_unregister(nl80211, dpp->mlme_watch);
> +		dpp->mlme_watch =3D 0;
> +	}
> +

Might be glass empty vs glass full thing, but wonder if registering the mlm=
e =

watch for each dpp object is more complicated than just doing it at the mod=
ule =

level (dpp_init?).  I guess you did it this way because we do not have a =

dpp_find() equivalent...

In theory it would probably be more efficient to parse the message once and=
 run =

dpp_find than having each dpp instance run the iterator.

Alternatively, maybe l_genl_family_register should be done only when DPP =

actually starts instead of at creation time?

Also, do we need to reset the cookie in dpp_reset or so?  Maybe it doesn't =
matter.

>   	l_free(dpp);
>   }
>   =


<snip>

> @@ -1575,6 +1595,76 @@ static void dpp_handle_frame(const struct mmpdu_he=
ader *frame,
>   	}
>   }
>   =

> +static void dpp_mlme_notify(struct l_genl_msg *msg, void *user_data)
> +{
> +	struct dpp_sm *dpp =3D user_data;
> +	uint64_t wdev_id =3D 0;
> +	uint64_t cookie =3D 0;
> +	bool ack =3D false;
> +	struct l_genl_attr attr;
> +	const void *data;
> +	uint16_t len;
> +	uint16_t type;
> +	const void *frame =3D NULL;
> +	uint16_t frame_len =3D 0;
> +	struct iovec iov;
> +	uint8_t cmd =3D l_genl_msg_get_command(msg);
> +
> +	if (cmd !=3D NL80211_CMD_FRAME_TX_STATUS)
> +		return;
> +
> +	if (dpp->state <=3D DPP_STATE_PRESENCE)
> +		return;
> +
> +	l_genl_attr_init(&attr, msg);
> +
> +	while (l_genl_attr_next(&attr, &type, &len, &data)) {
> +		switch (type) {
> +		case NL80211_ATTR_WDEV:
> +			if (len !=3D 8)
> +				return;
> +
> +			wdev_id =3D l_get_u64(data);
> +			break;
> +		case NL80211_ATTR_COOKIE:
> +			if (len !=3D 8)
> +				return;
> +
> +			cookie =3D l_get_u64(data);
> +			break;
> +		case NL80211_ATTR_ACK:
> +			ack =3D true;
> +			break;
> +		case NL80211_ATTR_FRAME:
> +			frame =3D data;
> +			frame_len =3D len;
> +			break;
> +		}
> +	}
> +

This may look nicer with nl80211_parse_attrs.  At least for cookie/wdev/ack=
. =

And avoids some of the silent returns you have when the length doesn't matc=
h =

what is expected.

> +	/*
> +	 * Only want to handle the no-ACK case. Re-transmitting an ACKed
> +	 * frame likely wont do any good, at least in the case of DPP.
> +	 */
> +	if (dpp->wdev_id !=3D wdev_id || dpp->frame_cookie !=3D cookie ||
> +				ack || !frame)
> +		return;
> +
> +	if (dpp->frame_retry > DPP_FRAME_MAX_RETRIES) {
> +		dpp_reset(dpp);
> +		return;
> +	}

That way you can check these before even needing the frame.

> +
> +	iov.iov_base =3D (void *)frame;
> +	iov.iov_len =3D frame_len;
> +

Actually, it occurs to me that we could add ATTR_FRAME support to =

nl80211_parse_attrs by using the struct iovec for it.

> +	l_debug("No ACK from peer, re-transmitting");
> +
> +	dpp->frame_retry++;
> +
> +	dpp_send_frame(dpp, &iov, 1, dpp->current_freq);
> +}
> +
>   static void dpp_create(struct netdev *netdev)
>   {
>   	struct l_dbus *dbus =3D dbus_get_bus();

Regards,
-Denis
--===============3114103702044945713==--

