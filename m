Content-Type: multipart/mixed; boundary="===============3123818655655400549=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ap: Pass extra IEs between mgmt frames and user
Date: Fri, 28 Aug 2020 11:27:12 -0500
Message-ID: <35504e30-96d9-703d-ca49-371642de390f@gmail.com>
In-Reply-To: <20200828152512.86105-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3123818655655400549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/28/20 10:25 AM, Andrew Zaborowski wrote:
> Allow passing user callbacks to add extra IEs to the AP's beacons and
> other frames.  I considered a few ways for the user to pass this data
> without callbacks but so far this seems to be the easiest and most
> versatile way.  Unfortunately the config is no longer static in a way
> that could be completely contained in an l_settings for example.

So this is for WFD I take it?

> =

> Similarly pass the string of IEs from STA association frames to the user
> through the AP events.  I dropped ap_event_station_added_data.rsn_ie
> because that probably would have never been very useful and the RSN IE
> is included in the IE array in any case.

Okay, this seems to be a separate thing.  No objection to this part.

> ---
>   src/ap.c | 59 +++++++++++++++++++++++++++++++++++++++++++++-----------
>   src/ap.h | 10 +++++++++-
>   2 files changed, 57 insertions(+), 12 deletions(-)
> =



<snip>

> diff --git a/src/ap.h b/src/ap.h
> index cb5238d1..19b72a33 100644
> --- a/src/ap.h
> +++ b/src/ap.h
> @@ -22,6 +22,7 @@
>   =

>   struct ap_state;
>   struct iovec;
> +enum mpdu_management_subtype;

Probably also fine to just use uint16 or something

>   =

>   enum ap_event_type {
>   	AP_EVENT_START_FAILED,
> @@ -36,7 +37,8 @@ enum ap_event_type {
>   =

>   struct ap_event_station_added_data {
>   	const uint8_t *mac;
> -	const uint8_t *rsn_ie;
> +	const uint8_t *assoc_ies;
> +	size_t assoc_ies_len;
>   };
>   =

>   struct ap_event_station_removed_data {
> @@ -46,6 +48,8 @@ struct ap_event_station_removed_data {
>   =

>   struct ap_event_registration_start_data {
>   	const uint8_t *mac;
> +	const uint8_t *assoc_ies;
> +	size_t assoc_ies_len;
>   };
>   =

>   struct ap_event_registration_success_data {
> @@ -64,6 +68,10 @@ struct ap_config {
>   	unsigned int authorized_macs_num;
>   	char *wsc_name;
>   	struct wsc_primary_device_type wsc_primary_device_type;
> +	size_t (*get_mgmt_frame_ies_len)(enum mpdu_management_subtype type,
> +						void *user_data);
> +	size_t (*write_mgmt_frame_ies)(enum mpdu_management_subtype type,
> +					uint8_t *out_buf, void *user_data);

We generally try to use operations carried on an object to take that object=
 as =

input.  Poor-man's classes in a way.  Which also means that we generally us=
e =

container_of in these cases and a destructor needs to be defined.  Since th=
ese =

seem to operate on arbitrary user_data, maybe they belong in a separate ops =

structure?

>   	bool no_cck_rates : 1;
>   };
>   =

> =


Regards,
-Denis
--===============3123818655655400549==--

