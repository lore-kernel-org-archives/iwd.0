Content-Type: multipart/mixed; boundary="===============3791692926365216093=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 05/10] dpp: send presence announcements on StartEnrollee
Date: Tue, 14 Dec 2021 17:50:11 -0600
Message-ID: <57cf74a1-8bf3-5fec-7b22-6480fe0b7294@gmail.com>
In-Reply-To: 20211214181225.2308043-5-prestwoj@gmail.com

--===============3791692926365216093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/14/21 12:12 PM, James Prestwood wrote:
> The presence procedure implemented is a far cry from what the spec
> actually wants. There are two reason for this: a) the kernels offchannel
> support is not at a level where it will work without rather annoying
> work arounds, and b) doing the procedure outlined in the spec will
> result in terrible discovery performance.
> =

> Because of this a simpler single channel announcement is done by default
> and the full presence procedure is left out until/if it is needed.
> ---
>   src/dpp.c | 251 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 250 insertions(+), 1 deletion(-)
> =

> v2:
>   * Use a single frequency by default
>   * Removed scanning from presence procedure
> =

> diff --git a/src/dpp.c b/src/dpp.c
> index 10d8f542..ddc7c3c9 100644
> --- a/src/dpp.c
> +++ b/src/dpp.c
> @@ -24,15 +24,33 @@
>   #include <config.h>
>   #endif
>   =

> +#include <errno.h>
> +
>   #include <ell/ell.h>
>   =

> +#include "linux/nl80211.h"
> +
>   #include "src/dbus.h"
>   #include "src/netdev.h"
>   #include "src/module.h"
>   #include "src/dpp-util.h"
>   #include "src/band.h"
> +#include "src/offchannel.h"
> +#include "src/scan.h"

Do you need this part if no scanning is done?

> +#include "src/wiphy.h"
> +#include "src/ie.h"
> +#include "src/frame-xchg.h"

Or this?

> +#include "src/iwd.h"
> +#include "src/util.h"
>   =

>   static uint32_t netdev_watch;
> +static struct l_genl_family *nl80211;
> +static uint8_t broadcast[] =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
> +

nit: space after { and before }.

> +enum dpp_state {
> +	DPP_STATE_NOTHING,
> +	DPP_STATE_PRESENCE,
> +};
>   =

>   struct dpp_sm {
>   	struct netdev *netdev;
> @@ -48,14 +66,120 @@ struct dpp_sm {
>   	size_t nonce_len;
>   	struct l_ecc_scalar *boot_private;
>   	struct l_ecc_point *boot_public;
> +
> +	enum dpp_state state;
> +
> +	uint32_t *freqs;
> +	size_t freqs_len;
> +	size_t freqs_idx;
> +	uint32_t dwell;
> +	uint32_t current_freq;
> +	struct scan_freq_set *presence_list;
> + > +	uint32_t offchannel_id;
>   };
>   =


<snip>

> +static void dpp_presence_announce(struct dpp_sm *dpp)
> +{
> +	struct netdev *netdev =3D dpp->netdev;
> +	uint8_t hdr[32];
> +	uint8_t attrs[32 + 4];
> +	uint8_t hash[32];
> +	uint8_t *ptr =3D attrs;
> +	const uint8_t *addr =3D netdev_get_address(netdev);
> +	struct iovec iov[3];

Hmm, you only use 2 iovs?

> +
> +	iov[0].iov_len =3D dpp_build_header(addr, broadcast,
> +					DPP_FRAME_PRESENCE_ANNOUNCEMENT, hdr);
> +	iov[0].iov_base =3D hdr;
> +
> +	dpp_hash(L_CHECKSUM_SHA256, hash, 2, "chirp", strlen("chirp"),
> +			dpp->pub_asn1, dpp->pub_asn1_len);
> +
> +	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH, hash, 3=
2);
> +
> +	iov[1].iov_base =3D attrs;
> +	iov[1].iov_len =3D ptr - attrs;
> +	iov[2].iov_base =3D NULL;

This one seems extraneous.

> +
> +	l_debug("Sending presense annoucement on frequency %u and waiting %u",
> +		dpp->current_freq, dpp->dwell);
> +
> +	dpp_send_frame(netdev_get_wdev_id(netdev), iov, 2, dpp->current_freq);
> +}
> +

<snip>

> +/*
> + * TODO: There is an entire procedure defined in the spec where you incr=
ease
> + * the ROC timeout with each unsuccessful iteration of channels, wait on=
 channel
> + * for long periods of time etc. Due to offchannel issues in the kernel =
this
> + * procedure is not being fully implemented. In reality doing this would=
 result
> + * in quite terrible DPP performance anyways.
> + */
> +static void dpp_start_presence_announcements(struct dpp_sm *dpp,
> +						uint32_t *limit_freqs,
> +						size_t limit_len)
> +{
> +	uint32_t max_roc =3D wiphy_get_max_roc_duration(
> +					wiphy_find_by_wdev(dpp->wdev_id));
> +
> +	if (2000 < max_roc)
> +		max_roc =3D 2000;
> +
> +	if (limit_freqs) {
> +		dpp->freqs =3D limit_freqs;
> +		dpp->freqs_len =3D limit_len;

This seems wrong since you're pointing to stack memory that will go *poof*.

> +	} else
> +		dpp->freqs =3D dpp_add_default_channels(dpp, &dpp->freqs_len);
> +
> +	dpp->dwell =3D max_roc;
> +	dpp->freqs_idx =3D 0;
> +	dpp->current_freq =3D dpp->freqs[0];
> +
> +	dpp->offchannel_id =3D offchannel_start(netdev_get_wdev_id(dpp->netdev),
> +			dpp->current_freq, dpp->dwell, dpp_roc_started,
> +			dpp, dpp_presence_timeout);
> +}
> +
>   static bool dpp_parse_enrollee_params(struct l_dbus_message *message,
>   					const char **info_out,
>   					const char **host_out)
> @@ -164,10 +390,14 @@ static struct l_dbus_message *dpp_dbus_start_enroll=
ee(struct l_dbus *dbus,
>   	struct dpp_sm *dpp =3D user_data;
>   	const char *info =3D NULL, *host =3D NULL;
>   	uint32_t freq =3D band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
> +	struct l_dbus_message *reply;
>   =

>   	if (!netdev_get_is_up(dpp->netdev))
>   		return dbus_error_not_available(message);
>   =

> +	if (dpp->state !=3D DPP_STATE_NOTHING)
> +		return dbus_error_already_exists(message);

dbus_error_busy

> +
>   	if (!dpp_parse_enrollee_params(message, &info, &host))
>   		return dbus_error_invalid_args(message);
>   =

> @@ -188,12 +418,25 @@ static struct l_dbus_message *dpp_dbus_start_enroll=
ee(struct l_dbus *dbus,
>   					netdev_get_address(dpp->netdev), &freq,
>   					1, info, host);
>   =

> +	dpp->state =3D DPP_STATE_PRESENCE;
> +
>   	l_debug("DPP Start Enrollee: %s", dpp->uri);
>   =

>   	l_dbus_property_changed(dbus_get_bus(), netdev_get_path(dpp->netdev),
>   					IWD_DPP_INTERFACE, "Uri");
>   =

> -	return l_dbus_message_new_method_return(message);
> +	/*
> +	 * Going off spec here. Select a single channel to send presence
> +	 * announcements on. This will be advertised in the URI. The full
> +	 * presence procedure can be implemented if it is ever needed.
> +	 */
> +	dpp_start_presence_announcements(dpp, &freq, 1);

Looks like freq from patch 03 belongs here.

> +
> +	reply =3D l_dbus_message_new_method_return(message);
> +
> +	l_dbus_message_set_arguments(reply, "s", dpp->uri);
> +
> +	return reply;
>   }
>   =

>   static struct l_dbus_message *dpp_dbus_stop(struct l_dbus *dbus,

Regards,
-Denis
--===============3791692926365216093==--

