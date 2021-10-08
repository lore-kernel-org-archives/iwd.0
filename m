Content-Type: multipart/mixed; boundary="===============2262331580283528046=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 04/13] eapol: support extended key IDs
Date: Fri, 08 Oct 2021 08:58:31 -0500
Message-ID: <99f9c0a5-c656-4e82-2c2b-70d2d0d13760@gmail.com>
In-Reply-To: 20211007204957.3745985-4-prestwoj@gmail.com

--===============2262331580283528046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

<snip>

> @@ -1856,6 +1862,44 @@ static void eapol_handle_ptk_3_of_4(struct eapol_s=
m *sm,
>   	} else
>   		igtk =3D NULL;
>   =

> +	key_id =3D handshake_util_find_kde(HANDSHAKE_KDE_KEY_ID,
> +					decrypted_key_data,
> +					decrypted_key_data_size, &key_id_len);
> +	if (hs->ext_key_id_capable) {
> +		uint8_t idx;
> +
> +		if (!key_id) {
> +			l_debug("No extended key KDE in frame 3/4");
> +			handshake_failed(sm, MMPDU_REASON_CODE_INVALID_IE);
> +			return;
> +		}
> +
> +		if (key_id_len !=3D 2) {
> +			l_error("invalid Key ID KDE format");
> +			handshake_failed(sm, MMPDU_REASON_CODE_INVALID_IE);
> +			return;
> +		}
> +
> +		idx =3D bit_field(key_id[0], 0, 2);
> +
> +		/*
> +		 * IEEE 802.11-2020 - 12.7.6.4 4-way handshake message 3
> +		 * "... the Authenticator assigns a new Key ID for the PTKSA in
> +		 * the range of 0 to 1 that is different from the Key ID
> +		 * assigned in the previous handshake"
> +		 */
> +		if ((idx !=3D 0 && idx !=3D 1) || (sm->rekey &&
> +						idx =3D=3D hs->active_tk_index)) {

I still don't see how this can work for retransmits?  Consider the followin=
g =

sequence of events and correct me if I'm wrong:

Initial connection:
PTK 1/4
PTK 3/4 -> AP sends Extended Key Index 0
Retransmit of PTK 3/4 -> This condition is never entered because rekey is s=
et to =

false.
... Rekey:
PTK 1/4
PTK 3/4 -> AP Sends Extended Key Index 1
Retransmit of PTK 3/4 -> We fail ?

> +			l_error("invalid Key ID KDE value (%u)", idx);
> +			handshake_failed(sm, MMPDU_REASON_CODE_INVALID_IE);
> +			return;
> +		}
> +
> +		hs->active_tk_index =3D idx;
> +
> +		l_debug("using Extended key ID %u", hs->active_tk_index);
> +	}
> +
>   	if (hs->support_ip_allocation) {
>   		size_t len;
>   		const uint8_t *ip_alloc_kde =3D

<snip>

> @@ -1928,18 +1971,11 @@ retransmit:
>   						handshake_state_get_kek_len(hs),
>   						step4, NULL, 0)) {
>   			l_debug("AES-SIV encryption failed");
> -			l_free(step4);
>   			handshake_failed(sm, MMPDU_REASON_CODE_UNSPECIFIED);
>   			return;
>   		}
>   	}
>   =

> -	eapol_sm_write(sm, (struct eapol_frame *) step4, unencrypted);
> -	l_free(step4);
> -
> -	if (hs->ptk_complete)
> -		return;
> -

So we shouldn't set any keys, including gtk or igtk, on a retransmitted fra=
me 3/4.

>   	/*
>   	 * For WPA1 the group handshake should be happening after we set the
>   	 * ptk, this flag tells netdev to wait for the gtk/igtk before
> @@ -1954,6 +1990,24 @@ retransmit:
>   	if (igtk)
>   		eapol_install_igtk(sm, igtk_key_index, igtk, igtk_len);
>   =

> +	/*
> +	 * Only install if this is the first 3/4 message (not retransmitting)
> +	 * and a rekey. Initial associations don't need the special RX -> TX
> +	 * procedure and can install the TK normally
> +	 */
> +	if (key_id && hs->ext_key_id_capable && sm->rekey) {
> +		handshake_state_install_ext_ptk(hs, hs->active_tk_index,
> +						(struct eapol_frame *) step4,
> +						ETH_P_PAE, unencrypted);
> +
> +		return;
> +	}
> +
> +	eapol_sm_write(sm, (struct eapol_frame *) step4, unencrypted);
> +
> +	if (hs->ptk_complete)
> +		return;
> +
>   	handshake_state_install_ptk(hs);
>   =

>   	if (rekey_offload)
> =


Regards,
-Denis
--===============2262331580283528046==--

