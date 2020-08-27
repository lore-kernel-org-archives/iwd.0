Content-Type: multipart/mixed; boundary="===============1025407294060415530=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 04/11] ap: Move AP parameters to a struct
Date: Thu, 27 Aug 2020 14:00:49 -0500
Message-ID: <912c4aee-1660-23eb-212a-c0e71cdc9e04@gmail.com>
In-Reply-To: <20200827181453.61823-4-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1025407294060415530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,


On 8/27/20 1:14 PM, Andrew Zaborowski wrote:
> To limit the number of ap_start parameters, group basic AP config
> parameters in the ap_config struct that is passed as a pointer and owned
> by the ap_state.
> ---
>   src/ap.c | 127 ++++++++++++++++++++++++++++++-------------------------
>   src/ap.h |  15 +++++--
>   2 files changed, 81 insertions(+), 61 deletions(-)
> =


<snip>

> @@ -1462,11 +1480,14 @@ static void ap_mlme_notify(struct l_genl_msg *msg=
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

Yeah, no ;)  That last sentence should not happen (and definitely should no=
t be =

explicitly encouraged) for reasons already discussed.  I amended this comme=
nt to =

leave this out and applied.

>    */
> -struct ap_state *ap_start(struct netdev *netdev, const char *ssid,
> -				const char *psk, int channel, bool no_cck_rates,
> -				const uint8_t **authorized_macs,
> +struct ap_state *ap_start(struct netdev *netdev, struct ap_config *confi=
g,
>   				ap_event_func_t event_func, void *user_data)
>   {
>   	struct ap_state *ap;

Regards,
-Denis
--===============1025407294060415530==--

