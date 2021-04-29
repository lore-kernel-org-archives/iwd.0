Content-Type: multipart/mixed; boundary="===============8747750120523581644=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/6] ft: create class for FT-over-DS targets
Date: Thu, 29 Apr 2021 15:23:11 -0500
Message-ID: <b50eb493-57e3-4054-3b05-cc69a57de7e9@gmail.com>
In-Reply-To: <20210429194103.207447-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8747750120523581644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/29/21 2:40 PM, James Prestwood wrote:
> FT-over-DS is being separated into two independent stages. The
> first of which is the processing of the action frame response.
> This new class will hold all the parsed information from the action
> frame and allowing it to be retrieved at a later time when IWD
> needs to roam.
> =

> Initial info class should be created when the action frame is
> being sent out. Once a response is received it can be parsed
> with ft_over_ds_parse_action_response. This verifies the frame
> and updates the ft_ds_info class with the parsed data.
> =

> ft_over_ds_prepare_handshake is the final step prior to
> Reassociation. This sets all the stored IEs, anonce, and KH IDs
> into the handshake and derives the new PTK.
> ---
>   src/ft.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/ft.h |  25 +++++++++++++
>   2 files changed, 131 insertions(+)
> =

> diff --git a/src/ft.c b/src/ft.c
> index 85d2d369..82c790de 100644
> --- a/src/ft.c
> +++ b/src/ft.c
> @@ -465,6 +465,52 @@ static bool ft_parse_fte(struct handshake_state *hs,
>   	return true;
>   }
>   =

> +static bool ft_over_ds_process_ies(struct ft_ds_info *info,
> +					struct handshake_state *hs,
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
> +					hs->authenticator_ie))
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

So this seems like a copy-paste of ft_process_ies.  Maybe they should be un=
ified =

somehow.

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
> @@ -523,6 +569,55 @@ ft_error:
>   	return -EBADMSG;
>   }
>   =

> +int ft_over_ds_parse_action_response(struct ft_ds_info *info,
> +					struct handshake_state *hs,
> +					const uint8_t *frame, size_t frame_len)
> +{
> +	uint16_t status =3D 0;
> +
> +	if (frame_len < 16)
> +		goto parse_error;

So this results in a 0 being returned?  I'm not sure that this is intended?

> +
> +	/* Category FT */
> +	if (frame[0] !=3D 6)
> +		goto parse_error;
> +

This should really return different error types based on what actually happ=
ened. =

  i.e. -EINVAL

> +	/* FT Action */
> +	if (frame[1] !=3D 2)
> +		goto parse_error;
> +
> +	if (memcmp(frame + 2, info->spa, 6))
> +		goto parse_error;

-ENOENT

> +	if (memcmp(frame + 8, info->aa, 6))
> +		goto parse_error;

-ENOENT or something

> +
> +	if (!ft_over_ds_process_ies(info, hs, frame + 16, frame_len - 16))
> +		goto parse_error;

EBADMSG

> +
> +	return 0;
> +
> +parse_error:
> +	return (int)status;
> +}
> +
> +bool ft_over_ds_prepare_handshake(struct ft_ds_info *info,
> +					struct handshake_state *hs)
> +{
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

This also seems to be straight out of ft_process_ies...?  Does this need to=
 be =

done only if the RSN is present?  Have you tested this on Open networks?

> +	return true;
> +}
> +
>   static int ft_rx_action(struct auth_proto *ap, const uint8_t *frame,
>   				size_t frame_len)
>   {
> @@ -551,6 +646,17 @@ auth_error:
>   	return (int)status_code;
>   }
>   =

> +void ft_ds_info_free(struct ft_ds_info *info)
> +{
> +	__typeof__(info->free) destroy =3D info->free;
> +
> +	if (info->fte)
> +		l_free(info->fte);
> +
> +	if (destroy)
> +		destroy(info);
> +}
> +
>   static int ft_rx_authenticate(struct auth_proto *ap, const uint8_t *fra=
me,
>   				size_t frame_len)
>   {
> diff --git a/src/ft.h b/src/ft.h
> index f24b3b5e..907c3d5d 100644
> --- a/src/ft.h
> +++ b/src/ft.h
> @@ -20,15 +20,37 @@
>    *
>    */
>   =

> +struct handshake_state;
> +
>   typedef void (*ft_tx_authenticate_func_t)(struct iovec *iov, size_t iov=
_len,
>   					void *user_data);
>   typedef void (*ft_tx_associate_func_t)(struct iovec *ie_iov, size_t iov=
_len,
>   					void *user_data);
>   =

> +typedef void (*ft_ds_free_func_t)(void *user_data);
> +
> +struct ft_ds_info {
> +	uint8_t spa[6];
> +	uint8_t aa[6];
> +	uint8_t snonce[32];
> +	uint8_t mde[3];
> +	uint8_t *fte;
> +
> +	struct ie_ft_info ft_info;
> +
> +	void (*free)(struct ft_ds_info *s);
> +};
> +
> +void ft_ds_info_free(struct ft_ds_info *info);
> +
>   bool ft_build_authenticate_ies(struct handshake_state *hs,
>   				const uint8_t *new_snonce, uint8_t *buf,
>   				size_t *len);
>   =

> +int ft_over_ds_parse_action_response(struct ft_ds_info *info,
> +					struct handshake_state *hs,
> +					const uint8_t *frame, size_t frame_len);
> +
>   struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
>   				ft_tx_authenticate_func_t tx_auth,
>   				ft_tx_associate_func_t tx_assoc,
> @@ -38,3 +60,6 @@ struct auth_proto *ft_over_ds_sm_new(struct handshake_s=
tate *hs,
>   				ft_tx_authenticate_func_t tx_auth,
>   				ft_tx_associate_func_t tx_assoc,
>   				void *user_data);
> +
> +bool ft_over_ds_prepare_handshake(struct ft_ds_info *info,
> +					struct handshake_state *hs);
> =


Regards,
-Denis
--===============8747750120523581644==--

