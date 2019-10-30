Content-Type: multipart/mixed; boundary="===============8847353156627067116=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 05/16] handshake: Convert handshake event callbacks
 variadic functions
Date: Wed, 30 Oct 2019 14:16:18 -0500
Message-ID: <fbccc6d7-58f3-138b-987c-df21abfc686c@gmail.com>
In-Reply-To: <20191028140508.13518-5-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8847353156627067116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/28/19 9:04 AM, Andrew Zaborowski wrote:
> Convert the handshake event callback type to use variable argument
> list to allow for more flexibility in event-specific arguments
> passed to the callbacks.
> ---
>   src/adhoc.c     |  2 +-
>   src/ap.c        |  9 +++++++--
>   src/handshake.c |  7 -------
>   src/handshake.h | 13 +++++++++----
>   src/station.c   |  9 +++++++--
>   src/wsc.c       | 11 +++++++++--
>   6 files changed, 33 insertions(+), 18 deletions(-)
> =

> diff --git a/src/adhoc.c b/src/adhoc.c
> index 00f3a7e3..755e9493 100644
> --- a/src/adhoc.c
> +++ b/src/adhoc.c
> @@ -159,7 +159,7 @@ static bool ap_sta_match_addr(const void *a, const vo=
id *b)
>   }
>   =

>   static void adhoc_handshake_event(struct handshake_state *hs,
> -		enum handshake_event event, void *event_data, void *user_data)
> +		enum handshake_event event, void *user_data, ...)
>   {
>   	struct sta_state *sta =3D user_data;
>   	struct adhoc_state *adhoc =3D sta->adhoc;
> diff --git a/src/ap.c b/src/ap.c
> index b06b6691..cacfa807 100644
> --- a/src/ap.c
> +++ b/src/ap.c
> @@ -382,16 +382,19 @@ static uint32_t ap_send_mgmt_frame(struct ap_state =
*ap,
>   }
>   =

>   static void ap_handshake_event(struct handshake_state *hs,
> -		enum handshake_event event, void *event_data, void *user_data)
> +		enum handshake_event event, void *user_data, ...)
>   {
>   	struct sta_state *sta =3D user_data;
> +	va_list args;
> +
> +	va_start(args, user_data);
>   =

>   	switch (event) {
>   	case HANDSHAKE_EVENT_COMPLETE:
>   		ap_new_rsna(sta);
>   		break;
>   	case HANDSHAKE_EVENT_FAILED:
> -		netdev_handshake_failed(hs, l_get_u16(event_data));
> +		netdev_handshake_failed(hs, l_get_u16(va_arg(args, void *)));

So since you make the caller extract arguments via va_arg, I wonder if =

it would be cleaner to pass unsigned/int to va_arg directly instead of =

using void pointers?

So do something like handshake_event(hs,
HANDSHAKE_EVENT_FAILED, reason_code);

>   		/* fall through */
>   	case HANDSHAKE_EVENT_SETTING_KEYS_FAILED:
>   		sta->sm =3D NULL;
> @@ -399,6 +402,8 @@ static void ap_handshake_event(struct handshake_state=
 *hs,
>   	default:
>   		break;
>   	}
> +
> +	va_end(args);
>   }
>   =

>   static void ap_start_rsna(struct sta_state *sta, const uint8_t *gtk_rsc)
> diff --git a/src/handshake.c b/src/handshake.c
> index 8e1aeec9..a3e236bb 100644
> --- a/src/handshake.c
> +++ b/src/handshake.c
> @@ -912,10 +912,3 @@ bool handshake_decode_fte_key(struct handshake_state=
 *s, const uint8_t *wrapped,
>   =

>   	return true;
>   }
> -
> -void handshake_event(struct handshake_state *hs,
> -			enum handshake_event event, void *event_data)
> -{
> -	if (hs->event_func)
> -		hs->event_func(hs, event, event_data, hs->user_data);
> -}
> diff --git a/src/handshake.h b/src/handshake.h
> index 08503190..cd0c1dc9 100644
> --- a/src/handshake.h
> +++ b/src/handshake.h
> @@ -54,7 +54,7 @@ enum handshake_event {
>   =

>   typedef void (*handshake_event_func_t)(struct handshake_state *hs,
>   					enum handshake_event event,
> -					void *event_data, void *user_data);
> +					void *user_data, ...);
>   =

>   typedef bool (*handshake_get_nonce_func_t)(uint8_t nonce[]);
>   typedef void (*handshake_install_tk_func_t)(struct handshake_state *hs,
> @@ -130,6 +130,14 @@ struct handshake_state {
>   	handshake_event_func_t event_func;
>   };
>   =

> +#define handshake_event(hs, event, ...)	\
> +	do {	\
> +		if (!(hs)->event_func)	\
> +			break;	\
> +	\
> +		(hs)->event_func(hs, event, (hs)->user_data, ##__VA_ARGS__); \
second hs is not in ()s here?
> +	} while (0)
> +
>   void handshake_state_free(struct handshake_state *s);
>   =

>   void handshake_state_set_supplicant_address(struct handshake_state *s,

Regards,
-Denis
--===============8847353156627067116==--

