Content-Type: multipart/mixed; boundary="===============1889636151612599952=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/7] ft: create cache for FT-over-DS targets
Date: Wed, 28 Apr 2021 14:30:53 -0500
Message-ID: <11661e2a-15b1-fa7a-9b95-913aa26558f5@gmail.com>
In-Reply-To: <20210427194945.49731-4-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1889636151612599952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/27/21 2:49 PM, James Prestwood wrote:
> FT-over-DS is being separated into two independent stages. The
> first of which is the processing of the action frame response.
> The cache will hold all the parsed information from the action
> frame and allow it to be retrieved at a later time when IWD
> needs to roam.
> =

> Initial cache entires should be created when the action frame is
> being sent out. Once a response is received it can be parsed and
> the matching entry (if found) will be updated with the parsed
> IEs.
> =

> ft_over_ds_entry_create will create a new entry and push it into
> the queue. Entries are found based on the supplicant address and
> authenticator address. From an API standpoint the current handshake
> and target BSS are passed in. Neither the handshake nor scan_bss
> are saved directly, but only the information needed to do FT.
> =

> ft_over_ds_parse_action_response parses the action response from
> the AP, verifies, and updates the matching entry with the parsed
> IEs.
> =

> ft_over_ds_prepare_handshake is the final step prior to
> Reassociation. This sets all the stored IEs, anonce, and KH IDs
> into the handshake and derives the new PTK.
> ---
>   src/ft.c | 296 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/ft.h |  22 +++++
>   2 files changed, 318 insertions(+)
> =

> diff --git a/src/ft.c b/src/ft.c
> index 80782a58..d9387e9b 100644
> --- a/src/ft.c
> +++ b/src/ft.c
> @@ -32,6 +32,25 @@
>   #include "src/ft.h"
>   #include "src/mpdu.h"
>   #include "src/auth-proto.h"
> +#include "src/scan.h"
> +#include "src/util.h"
> +#include "src/netdev.h"
> +#include "src/module.h"
> +
> +struct ft_ds_info {
> +	uint32_t ifindex;

Why do you need the ifindex and spa?  I would have thought one or the other =

would be sufficient.

> +
> +	uint8_t spa[6];
> +	uint8_t aa[6];
> +	uint8_t snonce[32];
> +	uint8_t mde[3];
> +	uint8_t *authenticator_ie;

Why do you need to store this?  Can't you just use the one from the =

netdev->handshake_state?  Maybe just pass it into =

ft_over_ds_parse_action_response()?

> +	uint8_t *fte;
> +	void *user_data;
> +	ft_over_ds_destroy_func_t destroy;

Whats this for?

> +
> +	struct ie_ft_info ft_info;
> +};
>   =

>   struct ft_sm {
>   	struct auth_proto ap;
> @@ -43,6 +62,8 @@ struct ft_sm {
>   	void *user_data;
>   };
>   =

> +static struct l_queue *ft_over_ds_entries;
> +
>   /*
>    * Calculate the MIC field of the FTE and write it directly to that FTE,
>    * assuming it was all zeros before.  See 12.8.4 and 12.8.5.
> @@ -462,6 +483,52 @@ static bool ft_parse_fte(struct handshake_state *hs,
>   	return true;
>   }
>   =

> +static bool ft_over_ds_process_ies(struct handshake_state *hs,
> +					struct ft_ds_info *info,
> +					const uint8_t *ies,
> +					size_t ies_len)
> +{
> +	const uint8_t *rsne =3D NULL;
> +	const uint8_t *mde =3D NULL;
> +	const uint8_t *fte =3D NULL;
> +	bool is_rsn;
> +
> +	if (ft_parse_ies(ies, ies_len, &rsne, &mde, &fte) < 0)
> +		return false;
> +
> +	is_rsn =3D hs->supplicant_ie !=3D NULL;
> +
> +	if (is_rsn) {
> +		if (!ft_verify_rsne(rsne, hs->pmk_r0_name,
> +					info->authenticator_ie))
> +			goto ft_error;
> +	} else if (rsne)
> +		goto ft_error;
> +
> +	/*
> +	 * Check for an MD IE identical to the one we sent in message 1
> +	 *
> +	 * 12.8.3: "The MDE shall contain the MDID and FT Capability and
> +	 * Policy fields. This element shall be the same as the MDE
> +	 * advertised by the target AP in Beacon and Probe Response frames."
> +	 */
> +	if (!mde || memcmp(info->mde, mde + 2, sizeof(info->mde)))
> +		goto ft_error;
> +
> +	if (is_rsn) {
> +		if (!ft_parse_fte(hs, info->snonce, fte, &info->ft_info))
> +			goto ft_error;
> +
> +		info->fte =3D l_memdup(fte, fte[1] + 2);
> +	} else if (fte)
> +		goto ft_error;
> +
> +	return true;
> +
> +ft_error:
> +	return false;
> +}
> +
>   static int ft_process_ies(struct handshake_state *hs, const uint8_t *ie=
s,
>   			size_t ies_len)
>   {
> @@ -520,6 +587,221 @@ ft_error:
>   	return -EBADMSG;
>   }
>   =

> +struct ft_ds_finder {
> +	const uint8_t *spa;
> +	const uint8_t *aa;
> +};
> +
> +static bool ft_over_ds_match(const void *a, const void *b)
> +{
> +	const struct ft_ds_info *info =3D a;
> +	const struct ft_ds_finder *finder =3D b;
> +
> +	if (memcmp(finder->spa, info->spa, 6) !=3D 0)
> +		return false;
> +
> +	/* handle only SPA match for remove all */
> +	if (!finder->aa)
> +		return true;
> +
> +	if (memcmp(finder->aa, info->aa, 6) !=3D 0)
> +		return false;
> +
> +	return true;
> +}
> +
> +static struct ft_ds_info *ft_over_ds_find(const uint8_t *spa, const uint=
8_t *aa)
> +{
> +	struct ft_ds_finder finder;
> +
> +	finder.spa =3D spa;
> +	finder.aa =3D aa;
> +
> +	return l_queue_find(ft_over_ds_entries, ft_over_ds_match, &finder);
> +}
> +
> +/*
> + * Creates an initial over-DS entry to be updated later when IE's are ad=
ded
> + */
> +bool ft_over_ds_entry_create(uint32_t ifindex, struct handshake_state *h=
s,
> +				struct scan_bss *target,
> +				const uint8_t *snonce, void *user_data,
> +				ft_over_ds_destroy_func_t destroy)

This seems super-complicated since you already have struct =

netdev_ft_over_ds_info().  Maybe this structure could be a 'pure cache' ent=
ry. =

That way you can create it when sending the action frame, and only once a v=
alid =

response has been received, would you actually put the entry into the cache.

> +{
> +	struct ft_ds_info *info;
> +
> +	if (ft_over_ds_find(hs->spa, target->addr))
> +		return false;
> +
> +	info =3D l_new(struct ft_ds_info, 1);
> +
> +	info->ifindex =3D ifindex;
> +	memcpy(info->spa, hs->spa, 6);
> +	memcpy(info->aa, target->addr, 6);
> +	memcpy(info->mde, target->mde, sizeof(info->mde));
> +	memcpy(info->snonce, snonce, 32);
> +	info->user_data =3D user_data;
> +	info->destroy =3D destroy;
> +
> +	info->authenticator_ie =3D l_memdup(hs->authenticator_ie,
> +						hs->authenticator_ie[1] + 2);
> +
> +	l_queue_push_head(ft_over_ds_entries, info);

So instead of doing this here, add a ft_over_ds_cache_put();

> +
> +	l_debug("Created FT entry SPA: "MAC" AA: "MAC, MAC_STR(info->spa),
> +			MAC_STR(info->aa));
> +
> +	return true;
> +}
> +
> +static void ft_over_ds_info_free(void *data)
> +{
> +	struct ft_ds_info *info =3D data;
> +
> +	if (info->destroy)
> +		info->destroy(info->user_data);
> +
> +	if (info->authenticator_ie)
> +		l_free(info->authenticator_ie);
> +
> +	if (info->fte)
> +		l_free(info->fte);
> +
> +	l_free(info);
> +}
> +
> +static bool ft_over_ds_remove(void *data, void *user_data)

Then you wouldn't need this at all, since the cache entries would be wiped =
by =

ifindex or the spa.

> +{
> +	struct ft_ds_info *info =3D data;
> +
> +	if (memcmp(info->spa, user_data, 6) !=3D 0)
> +		return false;
> +
> +	ft_over_ds_info_free(info);
> +
> +	return true;
> +}
> +
> +bool ft_over_ds_entry_remove_all(const uint8_t *spa)
> +{
> +	l_queue_foreach_remove(ft_over_ds_entries, ft_over_ds_remove,
> +					(void *)spa);
> +
> +	return true;
> +}
> +
> +bool ft_over_ds_entry_remove(const uint8_t *spa, const uint8_t *aa)
> +{
> +	struct ft_ds_finder finder;
> +
> +	finder.spa =3D spa;
> +	finder.aa =3D aa;
> +
> +	l_queue_remove_if(ft_over_ds_entries, ft_over_ds_match, &finder);
> +
> +	return true;
> +}
> +
> +void *ft_over_ds_entry_get_userdata(const uint8_t *spa, const uint8_t *a=
a)
> +{
> +	struct ft_ds_info *info =3D ft_over_ds_find(spa, aa);
> +
> +	if (!info)
> +		return NULL;
> +
> +	return info->user_data;
> +}
> +
> +/*
> + * Updates an over-DS entry with the action response IE's. This will par=
se and
> + * verify the IEs, and remove the entry if invalid.
> + */
> +static bool ft_over_ds_entry_update(struct ft_ds_info *info,
> +				const uint8_t *ies, size_t ies_len)
> +{
> +	struct netdev *netdev;
> +	struct handshake_state *hs;
> +
> +	netdev =3D netdev_find(info->ifindex);
> +	if (!netdev) {
> +		/* Netdev went away, remove all cached entries */
> +		ft_over_ds_entry_remove_all(info->spa);
> +		return false;
> +	}
> +
> +	hs =3D netdev_get_handshake(netdev);
> +
> +	if (!ft_over_ds_process_ies(hs, info, ies, ies_len)) {
> +		l_queue_remove(ft_over_ds_entries, info);
> +		ft_over_ds_info_free(info);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +int ft_over_ds_parse_action_response(uint8_t *spa, const uint8_t *frame,
> +				size_t frame_len, const uint8_t **aa_out) > +{
> +	struct ft_ds_info *info;
> +	uint16_t status =3D 0;
> +	const uint8_t *aa;
> +
> +	if (frame_len < 16)
> +		goto parse_error;
> +
> +	/* Category FT */
> +	if (frame[0] !=3D 6)
> +		goto parse_error;
> +
> +	/* FT Action */
> +	if (frame[1] !=3D 2)
> +		goto parse_error;
> +
> +	if (memcmp(frame + 2, spa, 6))
> +		goto parse_error;
> +
> +	aa =3D frame + 8;
> +
> +	info =3D ft_over_ds_find(spa, aa);
> +	if (!info)
> +		return -ENOENT;
> +
> +	if (!ft_over_ds_entry_update(info, frame + 16, frame_len - 16))
> +		goto parse_error;

Hmm, why not have this function receive the frame + handshake + ft_over_ds_=
entry =

itself and if the parsing succeeds, then the (updated) entry is put into th=
e cache?

> +
> +	if (aa_out)
> +		*aa_out =3D aa;
> +
> +	return 0;
> +
> +parse_error:
> +	return (int)status;
> +}
> +
> +bool ft_over_ds_prepare_handshake(struct handshake_state *hs,
> +					struct scan_bss *target)

target is only used for the address, so you might as well just pass in the =
mac =

directly and avoid adding a dependency onto scan.h

> +{
> +	struct ft_ds_info *info =3D ft_over_ds_find(hs->spa, target->addr);
> +
> +	if (!info)
> +		return false;
> +
> +	memcpy(hs->snonce, info->snonce, sizeof(hs->snonce));
> +
> +	handshake_state_set_fte(hs, info->fte);
> +
> +	handshake_state_set_anonce(hs, info->ft_info.anonce);
> +
> +	handshake_state_set_kh_ids(hs, info->ft_info.r0khid,
> +						info->ft_info.r0khid_len,
> +						info->ft_info.r1khid);
> +
> +	handshake_state_derive_ptk(hs);
> +
> +	return true;
> +}
> +
>   static int ft_rx_action(struct auth_proto *ap, const uint8_t *frame,
>   				size_t frame_len)
>   {

<snip>

Regards,
-Denis
--===============1889636151612599952==--

