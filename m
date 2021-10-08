Content-Type: multipart/mixed; boundary="===============6897152481920782668=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 05/13] netdev: support extended key IDs
Date: Fri, 08 Oct 2021 09:11:12 -0500
Message-ID: <8a130c78-857e-794d-3776-2f67a7b25cef@gmail.com>
In-Reply-To: 20211007204957.3745985-5-prestwoj@gmail.com

--===============6897152481920782668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/7/21 3:49 PM, James Prestwood wrote:
> This implements the new handshake callback for setting a TK with
> an extended key ID. The procedure is different from legacy zero
> index TKs.
> =

> First the new TK is set as RX only. Then message 4 should be sent
> out (so it uses the existing TK). This poses a slight issue with
> PAE sockets since message order is not guaranteed. In this case
> the 4th message is stored and sent after the new TK is installed.
> Then the new TK is modified using SET_KEY to both send and
> receive.
> =

> In the case of control port over NL80211 the above can be avoided
> and we can simply install the new key, send message 4, and modify
> the TK as TX + RX all in sequence, without waiting for any callbacks.
> ---
>   src/netdev.c | 401 ++++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 297 insertions(+), 104 deletions(-)
> =


<snip>

> @@ -1823,7 +2047,8 @@ static void netdev_set_tk(struct handshake_state *h=
s,
>   		goto invalid_key;
>   =

>   	msg =3D netdev_build_cmd_new_key_pairwise(netdev, cipher, addr, tk_buf,
> -						crypto_cipher_key_len(cipher));
> +						crypto_cipher_key_len(cipher),
> +						hs->active_tk_index);

This seems inconsistent?  You pass the key_idx in the ext_tk callback, but =
not =

here.  Bit of a pain to change the signature, but it may be nicer to just p=
ass =

the desired index into this callback.

>   	nhs->pairwise_new_key_cmd_id =3D
>   		l_genl_family_send(nl80211, msg, netdev_new_pairwise_key_cb,
>   						nhs, NULL);
> @@ -1836,6 +2061,74 @@ invalid_key:
>   	netdev_setting_keys_failed(nhs, err);
>   }
>   =

> +static void netdev_set_ext_tk(struct handshake_state *hs, uint8_t key_id=
x,
> +				const uint8_t *tk, uint32_t cipher,
> +				const struct eapol_frame *step4, uint16_t proto,
> +				bool noencrypt)
> +{
> +	struct netdev_handshake_state *nhs =3D
> +		l_container_of(hs, struct netdev_handshake_state, super);
> +	uint8_t tk_buf[32];
> +	struct netdev *netdev =3D nhs->netdev;
> +	struct l_genl_msg *msg;
> +	const uint8_t *addr =3D netdev_choose_key_address(nhs);
> +	int err;
> +	size_t frame_size =3D sizeof(struct eapol_header) +
> +				L_BE16_TO_CPU(step4->header.packet_len);
> +
> +	err =3D -ENOENT;
> +	if (!netdev_copy_tk(tk_buf, tk, cipher, false))
> +		goto error;
> +
> +	msg =3D netdev_build_cmd_new_rx_key_pairwise(netdev, cipher, addr, tk_b=
uf,
> +						crypto_cipher_key_len(cipher),
> +						hs->active_tk_index);
> +	nhs->pairwise_new_key_cmd_id =3D
> +		l_genl_family_send(nl80211, msg, netdev_new_rx_pairwise_key_cb,
> +						nhs, NULL);
> +
> +	if (!nhs->pairwise_new_key_cmd_id)
> +		goto io_error;
> +
> +	/*
> +	 * Without control port we cannot guarantee the order that messages go
> +	 * out and must wait for NEW_KEY to call back before sending message 4
> +	 */
> +	if (!wiphy_control_port_enabled(netdev->wiphy)) {

nit: lets just use netdev->pae_over_nl80211 for consistency.

> +		netdev->ext_key_info =3D l_malloc(
> +					sizeof(struct netdev_ext_key_info) +
> +					frame_size);
> +		memcpy(netdev->ext_key_info->frame, step4, frame_size);
> +		netdev->ext_key_info->proto =3D proto;
> +		netdev->ext_key_info->noencrypt =3D noencrypt;
> +		return;
> +	}
> +
> +	/*
> +	 * Otherwise, order of messages will be guaranteed. Therefore we can
> +	 * send send message 4, and set the TK to TX (below) without waiting for
> +	 * any callbacks
> +	 */
> +	err =3D netdev_control_port_frame(netdev->index, netdev->handshake->aa,
> +					proto, step4, noencrypt, NULL);
> +	if (err < 0)
> +		goto error;
> +
> +	/* Then toggle to RX + TX */
> +	err =3D netdev_set_key_tx(netdev);
> +	if (err < 0)
> +		goto error;
> +
> +	return;
> +
> +io_error:
> +	err =3D -EIO;
> +	l_genl_msg_unref(msg);
> +
> +error:
> +	netdev_setting_keys_failed(nhs, err);
> +}
> +
>   static void netdev_set_pmk_cb(struct l_genl_msg *msg, void *user_data)
>   {
>   	struct netdev_handshake_state *nhs =3D user_data;

<snip>

Regards,
-Denis
--===============6897152481920782668==--

