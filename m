Content-Type: multipart/mixed; boundary="===============3920547134546477477=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 6/7] station: separate FT-over-DS stages
Date: Fri, 30 Apr 2021 10:27:47 -0500
Message-ID: <f070db04-2d24-5cfd-8117-0bbccdfe4ca3@gmail.com>
In-Reply-To: <20210429230841.222368-6-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3920547134546477477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/29/21 6:08 PM, James Prestwood wrote:
> FT-over-DS was refactored to separate the FT action frame and
> reassociation. From stations standpoint IWD needs to call
> netdev_fast_transition_over_ds_action prior to actually roaming.
> For now these two stages are being combined and the action
> roam happens immediately after the action response callback.
> ---
>   src/station.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 52 insertions(+), 4 deletions(-)
> =

> diff --git a/src/station.c b/src/station.c
> index c89b1901..6a308cfd 100644
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
> @@ -1587,10 +1588,17 @@ static void station_roam_failed(struct station *s=
tation)
>   	l_debug("%u", netdev_get_ifindex(station->netdev));
>   =

>   	/*
> -	 * If we attempted a reassociation or a fast transition, and ended up
> -	 * here then we are now disconnected.
> +	 * If we attempted a reassociation or a fast transition (except DS),

The comment is factually correct, but is easy to misinterpret.  There's rea=
lly =

no difference between Re-Association and FT (over DS or Air).  They all go =

through Authenticate/(Re)Associate dance.  If the Association fails -> we'r=
e =

disconnected.

> +	 * and ended up here then we are now disconnected. In the case of
> +	 * FT over DS we can remain connected to the AP even if the transition
> +	 * fails.

This isn't correct.  See above.  What can fail is the Action frame stage.  =
Once =

we are committed to the Authenticate/Associate stage, failure should be tre=
ated =

the same.

Before, we used to fail in the Action phase and erroneously station thought=
 we =

were disconnected...

>   	 */
>   	if (station->state =3D=3D STATION_STATE_ROAMING) {
> +		if (station->ft_over_ds) {
> +			station_enter_state(station, STATION_STATE_CONNECTED);
> +			goto delayed_retry;
> +		}
> +
>   		station_disassociated(station);
>   		return;
>   	}
> @@ -1628,6 +1636,7 @@ delayed_retry:
>   	station->preparing_roam =3D false;
>   	station->roam_scan_full =3D false;
>   	station->ap_directed_roaming =3D false;
> +	station->ft_over_ds =3D false;
>   =

>   	if (station->signal_low)
>   		station_roam_timeout_rearm(station, roam_retry_interval);
> @@ -1713,6 +1722,41 @@ static bool bss_match_bssid(const void *a, const v=
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
> +}
> +
>   static void station_preauthenticate_cb(struct netdev *netdev,
>   					enum netdev_result result,
>   					const uint8_t *pmk, void *user_data)
> @@ -1810,8 +1854,12 @@ static void station_transition_start(struct statio=
n *station,
>   		/* FT-over-DS can be better suited for these situations */
>   		if ((hs->mde[4] & 1) && (station->ap_directed_roaming ||
>   				station->signal_low)) {
> -			if (netdev_fast_transition_over_ds(station->netdev, bss,
> -					station_fast_transition_cb) < 0) {
> +			station->ft_over_ds =3D true;
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
--===============3920547134546477477==--

