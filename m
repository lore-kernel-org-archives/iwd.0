Content-Type: multipart/mixed; boundary="===============7541806402635901080=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] ap: Move AP parameters to a struct
Date: Thu, 27 Aug 2020 12:02:56 -0500
Message-ID: <d3979177-37af-db20-1e49-0ff6bc871547@gmail.com>
In-Reply-To: <20200826001854.502627-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7541806402635901080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/25/20 7:18 PM, Andrew Zaborowski wrote:
> To limit the number of ap_start parameters, group basic AP config
> parameters in the ap_config struct that is passed as a pointer and owned
> by the ap_state.
> ---
>   src/ap.c | 134 +++++++++++++++++++++++++++++++------------------------
>   src/ap.h |  23 ++++++++--
>   2 files changed, 96 insertions(+), 61 deletions(-)
> =


<snip>

> @@ -94,6 +90,30 @@ struct sta_state {
>   =

>   static uint32_t netdev_watch;
>   =

> +void ap_config_free(struct ap_config *config)
> +{
> +	if (unlikely(!config))
> +		return;
> +
> +	l_free(config->ssid);
> +
> +	if (config->psk) {
> +		explicit_bzero(config->psk, strlen(config->psk));
> +		l_free(config->psk);
> +	}
> +
> +	if (config->authorized_macs) {
> +		uint8_t **mac;
> +
> +		for (mac =3D config->authorized_macs; *mac; mac++)
> +			l_free(mac);

Do you mean l_free(*mac) here?

> +
> +		l_free(config->authorized_macs);

But really, this is probably way better written as a while loop with array =
indexing.

int i =3D 0;
uint8_t *mac;
while (mac =3D config->authorized_macs[i++))
	l_free(mac);

l_free(config->authorized_macs);

I do wonder why you decided to make authorized_macs into a double-level arr=
ay =

instead of just a flat one...  You can always realloc if you need to grow i=
t..

> +	}
> +
> +	l_free(config);
> +}
> +
>   static void ap_sta_free(void *data)
>   {
>   	struct sta_state *sta =3D data;

<snip>

> @@ -1247,14 +1271,14 @@ static void ap_auth_cb(const struct mmpdu_header =
*hdr, const void *body,
>   			memcmp(hdr->address_3, bssid, 6))
>   		return;
>   =

> -	if (ap->authorized_macs) {
> -		int i;
> +	if (ap->config->authorized_macs) {
> +		uint8_t *const *mac;
>   =

> -		for (i =3D 0; i < ap->authorized_macs_num; i++)
> -			if (!memcmp(from, ap->authorized_macs + i * 6, 6))
> +		for (mac =3D ap->config->authorized_macs; *mac; mac++)
> +			if (!memcmp(from, *mac, 6))
>   				break;

Maybe consider a while loop here as well...

>   =

> -		if (i =3D=3D ap->authorized_macs_num) {
> +		if (!*mac) {
>   			ap_auth_reply(ap, from, MMPDU_REASON_CODE_UNSPECIFIED);
>   			return;
>   		}

<snip>

> @@ -1462,11 +1487,14 @@ static void ap_mlme_notify(struct l_genl_msg *msg=
, void *user_data)
>    * @event_func is required and must react to AP_EVENT_START_FAILED
>    * and AP_EVENT_STOPPING by forgetting the ap_state struct, which
>    * is going to be freed automatically.
> - * @channel is optional.
> + * In the @config struct only .ssid and .psk need to be non-NUL,
> + * other fields are optional.  If @ap_start succeeds, the returned
> + * ap_state takes ownership of @config and the caller shouldn't
> + * free it or any of the memory pointed to by its members (they
> + * also can't be static).  In principle there's no reason that the
> + * caller shouldn't read/update some of the members though.
>    */

I think eventually we probably want to make this a proper API.  like =

ap_config_new, ap_config_set_ssid, ap_config_set_passphrase, etc.

> -struct ap_state *ap_start(struct netdev *netdev, const char *ssid,
> -				const char *psk, int channel, bool no_cck_rates,
> -				const uint8_t **authorized_macs,
> +struct ap_state *ap_start(struct netdev *netdev, struct ap_config *confi=
g,
>   				ap_event_func_t event_func, void *user_data)

But this now looks much more manageable...

>   {
>   	struct ap_state *ap;

<snip>

> diff --git a/src/ap.h b/src/ap.h
> index b007b657..3ca9467f 100644
> --- a/src/ap.h
> +++ b/src/ap.h
> @@ -41,13 +41,30 @@ struct ap_event_station_removed_data {
>   	enum mmpdu_reason_code reason;
>   };
>   =

> +struct ap_event_registration_started_data {
> +	const uint8_t *mac;
> +	const struct iovec *assoc_ies;
> +};
> +
> +struct ap_event_registration_success_data {
> +	const uint8_t *mac;
> +};
> +

These don't seem to belong to this patch...

>   typedef void (*ap_event_func_t)(enum ap_event_type type, const void *ev=
ent_data,
>   				void *user_data);
>   typedef void (*ap_stopped_func_t)(void *user_data);
>   =

> -struct ap_state *ap_start(struct netdev *netdev, const char *ssid,
> -				const char *psk, int channel, bool no_cck_rates,
> -				const uint8_t **authorized_macs,
> +struct ap_config {
> +	char *ssid;
> +	char *psk;
> +	uint8_t channel;
> +	uint8_t **authorized_macs;
> +	bool no_cck_rates : 1;
> +};
> +

Adding a ap_config_new and setters would allow making this structure opaque.

> +void ap_config_free(struct ap_config *config);
> +
> +struct ap_state *ap_start(struct netdev *netdev, struct ap_config *confi=
g,
>   				ap_event_func_t event_func, void *user_data);
>   void ap_shutdown(struct ap_state *ap, ap_stopped_func_t stopped_func,
>   			void *user_data);
> =


Regards,
-Denis
--===============7541806402635901080==--

