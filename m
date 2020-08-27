Content-Type: multipart/mixed; boundary="===============4326212346925420061=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] ap: Add an optional client count limit parameter
Date: Thu, 27 Aug 2020 12:14:57 -0500
Message-ID: <0da1d9f7-de98-50de-9067-f68f0eda7cf7@gmail.com>
In-Reply-To: <20200826001854.502627-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4326212346925420061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/25/20 7:18 PM, Andrew Zaborowski wrote:
> Add ap_config.max_stations, we'll probably want to set it to 1 for P2P
> groups but this setting is also available in Android etc. when doing
> tethering.
> ---
>   src/ap.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/ap.h |  1 +
>   2 files changed, 65 insertions(+)
> =


<snip>

> @@ -430,6 +465,28 @@ static void ap_handshake_event(struct handshake_stat=
e *hs,
>   	va_start(args, user_data);
>   =

>   	switch (event) {
> +	case HANDSHAKE_EVENT_SETTING_KEYS:
> +		/*
> +		 * config->max_stations limits the number of fully connected
> +		 * STAs, i.e. the clients who have the credentials, so that
> +		 * those that don't have them can't keep the legit ones from
> +		 * connecting.  We've checked that we're below the limit when
> +		 * processing the Authentication frame, just so that we don't
> +		 * start a new handshake knowing that we can't accept another
> +		 * STA, but the definitive check is here just before
> +		 * authorizing the STA.
> +		 */
> +		if (sta->ap->config->max_stations &&
> +				ap_get_sta_count(sta->ap) >=3D
> +				sta->ap->config->max_stations) {
> +			l_debug("STA over max_stations limit being removed "
> +				"after successfull handshake");
> +			sta->remove_work =3D l_idle_create(ap_sta_remove_work,
> +								sta, NULL);

Not sure I really like this.  We generate a bunch of messages to the kernel=
 and =

only after the keys setting messages are sent / acked by the kernel would t=
he =

del_station actually get sent.

Perhaps we should introduce a pre-setting_keys state and have eapol.c check =

whether handshake_state should proceed after the event has been fired.

Regards,
-Denis
--===============4326212346925420061==--

