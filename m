Content-Type: multipart/mixed; boundary="===============4923767150781035612=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 08/11] ap: Push Button mode API and beacon changes
Date: Thu, 27 Aug 2020 14:42:10 -0500
Message-ID: <1c918a34-562e-06b7-1716-5ba8ab47503e@gmail.com>
In-Reply-To: <20200827181453.61823-8-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4923767150781035612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/27/20 1:14 PM, Andrew Zaborowski wrote:
> This adds the API for putting the AP in Push Button mode, which we'll
> need to P2P GO side but may be useful on its own too.  A WSC IE is added
> to our beacons and probe responses indicating whether the PBC mode is
> active.
> ---
>   src/ap.c | 207 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   src/ap.h |  15 ++++
>   2 files changed, 219 insertions(+), 3 deletions(-)
> =


<snip>

So just some general comments since this patch doesn't compile without patc=
h 1:

> diff --git a/src/ap.h b/src/ap.h
> index 330ae011..4351fdc5 100644
> --- a/src/ap.h
> +++ b/src/ap.h
> @@ -29,6 +29,9 @@ enum ap_event_type {
>   	AP_EVENT_STOPPING,
>   	AP_EVENT_STATION_ADDED,
>   	AP_EVENT_STATION_REMOVED,
> +	AP_EVENT_REGISTRATION_START,
> +	AP_EVENT_REGISTRATION_SUCCESS,

These two are not used in this patch, but ok..

> +	AP_EVENT_PBC_MODE_EXIT,
>   };
>   =

>   struct ap_event_station_added_data {
> @@ -41,6 +44,14 @@ struct ap_event_station_removed_data {
>   	enum mmpdu_reason_code reason;
>   };
>   =

> +struct ap_event_registration_started_data {
> +	const uint8_t *mac;
> +};
> +
> +struct ap_event_registration_success_data {
> +	const uint8_t *mac;
> +};
> +

As above

>   typedef void (*ap_event_func_t)(enum ap_event_type type, const void *ev=
ent_data,
>   				void *user_data);
>   typedef void (*ap_stopped_func_t)(void *user_data);
> @@ -51,6 +62,8 @@ struct ap_config {
>   	uint8_t channel;
>   	uint8_t *authorized_macs;
>   	unsigned int authorized_macs_num;
> +	char *wsc_name;
> +	struct wsc_primary_device_type wsc_primary_device_type;
>   	bool no_cck_rates : 1;
>   };
>   =

> @@ -64,3 +77,5 @@ void ap_free(struct ap_state *ap);
>   =

>   bool ap_station_disconnect(struct ap_state *ap, const uint8_t *mac,
>   				enum mmpdu_reason_code reason);
> +
> +bool ap_push_button(struct ap_state *ap);
> =


So correct me if I'm wrong, but the intent here seems to be:

Have P2P-GO start AP in PBC mode by setting authorized_macs to whatever, th=
en =

run ap_push_button().  Then the AP has to be shut down and restarted (or ma=
ybe =

not?)  But regardless, it seems that PBC cannot be restarted with AP runnin=
g =

after the previous PBC transaction has finished.

This seems like an unnecessary limitation.  Why not implement PBC (and in t=
he =

future PIN) as a transitory state instead?  This way we could have our AP (=
non =

P2P-GO) mode support push buttons / PINs almost for free...

So something like:

ap_push_button(struct ap_state *ap, struct wsc_config *wsc);

Regards,
-Denis
--===============4923767150781035612==--

