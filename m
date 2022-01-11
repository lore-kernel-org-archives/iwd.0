Content-Type: multipart/mixed; boundary="===============3443908429464434783=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 3/3] scan: don't special case periodic scan work
Date: Tue, 11 Jan 2022 09:10:03 -0600
Message-ID: <0b0471fd-0163-f12d-d5e3-7fe9f1c7633c@gmail.com>
In-Reply-To: 20220111001519.1013183-3-prestwoj@gmail.com

--===============3443908429464434783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/10/22 18:15, James Prestwood wrote:
> Periodic scans were handled specially where they were only
> started if no other requests were pending in the scan queue.
> This is fine, and what we want, but this can actually be
> handled automatically by nature of the wiphy work queue rather
> than needing to check the request queue explicitly.
> =

> Instead we can insert periodic scans at a lower priority than
> other scans. This puts them at the end of the work queue, as
> well as allows future requests to jump ahead if a periodic scan
> has not yet started.
> =

> Eventually, once all pending scans are done, the peridoic scan
> may begin. This is no different than the preivous behavior and
> avoids the need for any special checks once scan requests
> complete.
> =

> One check was added to address the problem of the periodic scan
> timer firing before the scan could even start. Currently this
> happened to be handled fine in scan_periodic_queue, as it checks
> the queue length. Since this check was removed we must see check
> for this condition inside scan_periodic_timeout.
> ---
>   src/scan.c | 48 +++++++++++++++++++++++++++---------------------
>   1 file changed, 27 insertions(+), 21 deletions(-)
> =


<snip>

> @@ -883,27 +882,30 @@ static bool scan_periodic_notify(int err, struct l_=
queue *bss_list,
>   	return false;
>   }
>   =

> +static void scan_periodic_destroy(void *user_data)
> +{
> +	struct scan_context *sc =3D user_data;
> +
> +	sc->sp.id =3D 0;
> +}
> +

This isn't being used?

>   static bool scan_periodic_queue(struct scan_context *sc)
>   {
> -	if (!l_queue_isempty(sc->requests)) {
> -		sc->sp.retry =3D true;
> -		return false;
> -	}
> +	struct scan_parameters params =3D {};
>   =

>   	if (sc->sp.needs_active_scan && known_networks_has_hidden()) {
> -		struct scan_parameters params =3D {
> -			.randomize_mac_addr_hint =3D true
> -		};
> +		params.randomize_mac_addr_hint =3D true;
>   =

>   		sc->sp.needs_active_scan =3D false;
> -
> -		sc->sp.id =3D scan_active_full(sc->wdev_id, &params,
> -						scan_periodic_triggered,
> -						scan_periodic_notify, sc, NULL);
> +		sc->sp.id =3D scan_common(sc->wdev_id, false, &params,
> +					SCAN_WORK_PRIORITY + 1,

This probably warrants its own define

> +					scan_periodic_triggered,
> +					scan_periodic_notify, sc, NULL);
>   	} else
> -		sc->sp.id =3D scan_passive(sc->wdev_id, NULL,
> -						scan_periodic_triggered,
> -						scan_periodic_notify, sc, NULL);
> +		sc->sp.id =3D scan_common(sc->wdev_id, true, &params,
> +					SCAN_WORK_PRIORITY + 1,
> +					scan_periodic_triggered,
> +					scan_periodic_notify, sc, NULL);
>   =

>   	return sc->sp.id !=3D 0;
>   }

<snip>

> @@ -1006,6 +1007,16 @@ static void scan_periodic_timeout(struct l_timeout=
 *timeout, void *user_data)
>   =

>   	l_debug("scan_periodic_timeout: %" PRIx64, sc->wdev_id);
>   =

> +	/*
> +	 * Timeout triggered before periodic scan could even start, just rearm
> +	 * with the same interval.
> +	 */
> +	if (sc->sp.id) {
> +		l_warn("Periodic scan timer called before scan could start!");

Not sure this is l_warn worthy.  I would downgrade this to l_debug.

> +		scan_periodic_rearm(sc);
> +		return;
> +	}
> +
>   	sc->sp.interval *=3D 2;
>   	if (sc->sp.interval > SCAN_MAX_INTERVAL)
>   		sc->sp.interval =3D SCAN_MAX_INTERVAL;

Regards,
-Denis
--===============3443908429464434783==--

