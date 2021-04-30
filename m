Content-Type: multipart/mixed; boundary="===============8207434532241303994=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 2/3] station: separate FT-over-DS stages
Date: Fri, 30 Apr 2021 12:09:06 -0500
Message-ID: <9a08c90e-436a-f978-f7e7-72b8bd6185e6@gmail.com>
In-Reply-To: <20210430164708.270461-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8207434532241303994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/30/21 11:47 AM, James Prestwood wrote:
> FT-over-DS was refactored to separate the FT action frame and
> reassociation. From stations standpoint IWD needs to call
> netdev_fast_transition_over_ds_action prior to actually roaming.
> For now these two stages are being combined and the action
> roam happens immediately after the action response callback.
> ---
>   src/station.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 53 insertions(+), 4 deletions(-)
> =

> v5:
>   * Fixed up comment
> =

> diff --git a/src/station.c b/src/station.c
> index c89b1901..de252d3f 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -113,6 +113,7 @@ struct station {
>   	bool ap_directed_roaming : 1;
>   	bool scanning : 1;
>   	bool autoconnect : 1;
> +	bool ft_over_ds : 1;
>   };
>   =

>   struct anqp_entry {
> @@ -1587,10 +1588,18 @@ static void station_roam_failed(struct station *s=
tation)
>   	l_debug("%u", netdev_get_ifindex(station->netdev));
>   =

>   	/*
> -	 * If we attempted a reassociation or a fast transition, and ended up
> -	 * here then we are now disconnected.
> +	 * If we attempted a reassociation or a fast transition and ended up
> +	 * here then we are now disconnected. This is special cased here to
> +	 * handle the action frame portion of FT-over-DS which can fail without
> +	 * resulting in a full disconnection as it has not yet commited to
> +	 * Auth/Assoc yet.
>   	 */
>   	if (station->state =3D=3D STATION_STATE_ROAMING) {
> +		if (station->ft_over_ds) {
> +			station_enter_state(station, STATION_STATE_CONNECTED);
> +			goto delayed_retry;

Why not just introduce station_roam_retry()

> +		}
> +
>   		station_disassociated(station);
>   		return;
>   	}
> @@ -1628,6 +1637,7 @@ delayed_retry:
>   	station->preparing_roam =3D false;
>   	station->roam_scan_full =3D false;
>   	station->ap_directed_roaming =3D false;
> +	station->ft_over_ds =3D false;

so as to avoid this book-keeping variable entirely.

>   =

>   	if (station->signal_low)
>   		station_roam_timeout_rearm(station, roam_retry_interval);
> @@ -1713,6 +1723,41 @@ static bool bss_match_bssid(const void *a, const v=
oid *b)
>   	return !memcmp(bss->addr, bssid, sizeof(bss->addr));
>   }
>   =

> +static void station_fast_transition_ds_cb(struct netdev *netdev,
> +					uint16_t status, const uint8_t *bssid,
> +					void *user_data)
> +{
> +	struct station *station =3D user_data;
> +	struct scan_bss *bss;
> +
> +	if (status !=3D 0)
> +		goto failed;

The question is really whether we should go straight into FT-over-Air inste=
ad at =

this point or disable FT-over-DS for the next attempt.  But we can handle t=
his =

later.

> +
> +	/*
> +	 * TODO: In the future it may be desired to start sending out these
> +	 * FT-over-DS action frames at the time of connecting then be able to
> +	 * roam immediately when required. If this is being done we can simply
> +	 * bail out now as ft already caches the entires. But since this was
> +	 * initiated due to a need to roam, do so now.
> +	 */
> +
> +	/* Make sure we still have our BSS */
> +	bss =3D l_queue_find(station->bss_list, bss_match_bssid, bssid);
> +	if (!bss)
> +		goto failed;
> +
> +	l_debug("Starting FT-over-DS roam");
> +
> +	if (netdev_fast_transition_over_ds(station->netdev, bss,
> +					station_fast_transition_cb) < 0)
> +		goto failed;
> +
> +	return;
> +
> +failed:
> +	station_roam_failed(station);

and then just call station_roam_retry() here instead?

> +}
> +
>   static void station_preauthenticate_cb(struct netdev *netdev,
>   					enum netdev_result result,
>   					const uint8_t *pmk, void *user_data)
> @@ -1810,8 +1855,12 @@ static void station_transition_start(struct statio=
n *station,
>   		/* FT-over-DS can be better suited for these situations */
>   		if ((hs->mde[4] & 1) && (station->ap_directed_roaming ||
>   				station->signal_low)) {
> -			if (netdev_fast_transition_over_ds(station->netdev, bss,
> -					station_fast_transition_cb) < 0) {
> +			station->ft_over_ds =3D true;

also, in theory you can avoid entering the ROAMING state until after the Ac=
tion =

phase has succeeded successfully...

> +
> +			if (netdev_fast_transition_over_ds_action(
> +					station->netdev, bss,
> +					station_fast_transition_ds_cb,
> +					station) < 0) {
>   				station_roam_failed(station);
>   				return;
>   			}
> =


Regards,
-Denis
--===============8207434532241303994==--

