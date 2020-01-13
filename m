Content-Type: multipart/mixed; boundary="===============0298343160603560613=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] wsc: Split out enrollee state machine to own object
Date: Mon, 13 Jan 2020 06:56:13 -0600
Message-ID: <989bd8f8-ffff-4a2b-6946-d0bba591239e@gmail.com>
In-Reply-To: <20200113133243.2799-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0298343160603560613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/13/20 7:32 AM, Andrew Zaborowski wrote:
> Create struct wsc_enrollee which is allocated with wsc_enrollee_new,
> taking a done callback as a parameter.  The callback is always
> called so there's no need for a separate destroy callback.  The object
> only lives until the done callback happens so wsc_enrollee_cancel can
> only be used before this.
> =

> Looks like the rest of the file is much simplified thanks to this.

Yes, this is looking really nice now.  Just a couple of small things:

> ---
>   src/wsc.c | 456 ++++++++++++++++++++++++++----------------------------
>   src/wsc.h |   8 +
>   2 files changed, 228 insertions(+), 236 deletions(-)
> =


<snip>

> +void wsc_enrollee_cancel(struct wsc_enrollee *wsce)
> +{
> +	wsce->done_cb(-ECANCELED, NULL, 0, wsce->done_data);
> +	wsce->done_cb =3D NULL;
> +	/* Results in a call to wsc_enrollee_free */
> +	netdev_disconnect(wsce->netdev, NULL, NULL);

Are you sure you don't want to wait for netdev_disconnect to finish =

prior to signaling the request as aborted & canceled?  In theory this =

could lead to station bouncing against an -EBUSY error once =

station_set_autoconnect is called.

> +
> +		/*
> +		 * TODO: Mark this network as known.  We might be getting
> +		 * multiple credentials from WSC, so there is a possibility
> +		 * that the network is not known and / or not in scan results.
> +		 * In both cases, the network should be considered for
> +		 * auto-connect.  Note, since we sync the settings, the next
> +		 * reboot will put the network on the known list.
> +		 */

This TODO comment is now likely stale and can be removed (in a separate =

commit).

> +	}
>   }
>   =

>   /* Done callback for when WSC is triggered by DBus methods */
> @@ -541,14 +530,22 @@ static void wsc_dbus_done_cb(int err, struct wsc_cr=
edentials_info *creds,
>   {
>   	struct wsc *wsc =3D user_data;
>   =

> +	wsc->enrollee =3D NULL;
> +	wsc->target =3D NULL;
> +
>   	l_debug("err=3D%i", err);
>   =

> +	if (err && wsc->station)
> +		station_set_autoconnect(wsc->station, true);
> +
>   	switch (err) {
>   	case 0:
>   		break;
>   	case -ECANCELED:
> -		dbus_pending_reply(&wsc->pending,
> +		if (wsc->pending)
> +			dbus_pending_reply(&wsc->pending,
>   					dbus_error_aborted(wsc->pending));

Hmm, why the if ()?

Also, if you wait until netdev_disconnect_cb to signal done_cb with =

-ECANCELED, you can reply to both the pending and cancel messages here.

> +
>   		return;
>   	case -ENOKEY:
>   		dbus_pending_reply(&wsc->pending,

<snip>

> diff --git a/src/wsc.h b/src/wsc.h
> index ada08c89..48a3297a 100644
> --- a/src/wsc.h
> +++ b/src/wsc.h
> @@ -31,5 +31,13 @@ struct wsc_credentials_info {
>   	bool has_passphrase;
>   };
>   =

> +struct wsc_enrollee;
> +
>   typedef void (*wsc_done_cb_t)(int err, struct wsc_credentials_info *cre=
ds,
>   				unsigned int n_creds, void *user_data);
> +
> +struct wsc_enrollee *wsc_enrollee_new(struct netdev *netdev,
> +					struct scan_bss *target,
> +					const char *pin,
> +					wsc_done_cb_t done_cb, void *user_data);
> +void wsc_enrollee_cancel(struct wsc_enrollee *wsce);
> =


You may still want an explicit wsc_enrollee_free for cases where =

netdev_disconnect shouldn't be used / attempted.

Regards,
-Denis
--===============0298343160603560613==--

