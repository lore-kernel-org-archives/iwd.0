Content-Type: multipart/mixed; boundary="===============9000289620719805923=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v5 3/4] dpp: add support for configuration protocol
Date: Fri, 17 Dec 2021 14:22:03 -0600
Message-ID: <0a88c6c9-4f66-d1fe-782b-eccdcd194a6f@gmail.com>
In-Reply-To: 20211217191451.179444-3-prestwoj@gmail.com

--===============9000289620719805923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/17/21 13:14, James Prestwood wrote:
> This is a minimal implementation only supporting legacy network
> configuration, i.e. only SSID and PSK/passphrase are supported.
> =

> Missing features include:
>   - Fragmentation/comeback delay support
>   - DPP AKM support
>   - 8021x/PKEX support
> ---
>   src/dpp.c | 328 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 328 insertions(+)
> =

> v5:
>   * Updated use of wrap/unwrap APIs
>   * Added comments about how AAD is used with configuration
> =


<snip>

> +static void dpp_handle_config_response_frame(const struct mmpdu_header *=
frame,
> +				const void *body, size_t body_len,
> +				int rssi, void *user_data)
> +{
> +	struct dpp_sm *dpp =3D user_data;
> +	const uint8_t *ptr =3D body;
> +	uint16_t status;
> +	uint16_t fragmented; /* Fragmented/Comeback delay field */
> +	uint8_t adv_protocol_element[] =3D { 0x6C, 0x08, 0x7F };
> +	uint8_t adv_protocol_id[] =3D { 0xDD, 0x05, 0x50, 0x6F,
> +					0x9A, 0x1A, 0x01 };
> +	uint16_t query_len;
> +	struct dpp_attr_iter iter;
> +	enum dpp_attribute_type type;
> +	size_t len;
> +	const uint8_t *data;
> +	const char *json =3D NULL;
> +	size_t json_len =3D 0;
> +	int dstatus =3D -1;
> +	const uint8_t *wrapped =3D NULL;
> +	const uint8_t *e_nonce =3D NULL;
> +	size_t wrapped_len =3D 0;
> +	_auto_(l_free) uint8_t *unwrapped =3D NULL;
> +	struct dpp_configuration *config;
> +	uint8_t ad0[] =3D { 0x00, 0x10, 0x01, 0x00, 0x05 };
> +
> +	if (dpp->state !=3D DPP_STATE_CONFIGURING)
> +		return;
> +
> +	ptr +=3D 2;
> +
> +	/*
> +	 * Can a configuration request come from someone other than who you
> +	 * authenticated to?
> +	 */
> +	if (memcmp(dpp->auth_addr, frame->address_2, 6))
> +		return;

Hmm, I'm not seeing any length checking?

> +
> +	if (*ptr++ !=3D dpp->diag_token)
> +		return;
> +
> +	status =3D l_get_le16(ptr);
> +	ptr +=3D 2;
> +
> +	if (status !=3D 0) {
> +		l_debug("Bad configuration status %u", status);
> +		return;
> +	}
> +
> +	fragmented =3D l_get_le16(ptr);
> +	ptr +=3D 2;
> +
> +	/*
> +	 * TODO: handle 0x0001 (fragmented), as well as comeback delay.
> +	 */
> +	if (fragmented !=3D 0) {
> +		l_debug("Fragmented messages not currently supported");
> +		return;
> +	}
> +
> +	if (memcmp(ptr, adv_protocol_element, sizeof(adv_protocol_element))) {
> +		l_debug("Invalid Advertisement protocol element");
> +		return;
> +	}
> +
> +	ptr +=3D sizeof(adv_protocol_element);
> +
> +	if (memcmp(ptr, adv_protocol_id, sizeof(adv_protocol_id))) {
> +		l_debug("Invalid Advertisement protocol ID");
> +		return;
> +	}
> +
> +	ptr +=3D sizeof(adv_protocol_id);
> +
> +	query_len =3D l_get_le16(ptr);
> +	ptr +=3D 2;
> +

How do we know query_len is valid for

> +	dpp_attr_iter_init(&iter, ptr, query_len);

this invocation?

> +
> +	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
> +		switch (type) {
> +		case DPP_ATTR_STATUS:
> +			dstatus =3D l_get_u8(data);
> +			break;
> +		case DPP_ATTR_WRAPPED_DATA:
> +			wrapped =3D data;
> +			wrapped_len =3D len;
> +			break;
> +		default:
> +			/*
> +			 * TODO: CSR Attribute
> +			 */
> +			break;
> +		}
> +	}
> +
> +	if (dstatus !=3D DPP_STATUS_OK || !wrapped) {
> +		l_debug("Bad status or missing attributes");
> +		return;
> +	}
> +
> +	unwrapped =3D dpp_unwrap_attr(ad0, sizeof(ad0), NULL, 0, dpp->ke,
> +					dpp->key_len, wrapped, wrapped_len,
> +					&wrapped_len);
> +	if (!unwrapped) {
> +		l_debug("Failed to unwrap");
> +		return;
> +	}
> +
> +	dpp_attr_iter_init(&iter, unwrapped, wrapped_len);
> +
> +	while (dpp_attr_iter_next(&iter, &type, &len, &data)) {
> +		switch (type) {
> +		case DPP_ATTR_ENROLLEE_NONCE:
> +			if (len !=3D dpp->nonce_len)
> +				break;
> +
> +			if (memcmp(data, dpp->e_nonce, dpp->nonce_len))
> +				break;
> +
> +			e_nonce =3D data;
> +			break;
> +		case DPP_ATTR_CONFIGURATION_OBJECT:
> +			json =3D (const char *)data;
> +			json_len =3D len;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (!json || !e_nonce) {
> +		l_debug("No configuration object in response");
> +		return;
> +	}
> +
> +	config =3D dpp_parse_configuration_object(json, json_len);
> +	if (!config) {
> +		l_error("Configuration object did not parse");
> +		return;
> +	}
> +
> +	dpp_write_config(config);
> +	/*
> +	 * TODO: Depending on the info included in the configuration object a
> +	 * limited scan could be issued to get autoconnect to trigger faster.
> +	 * In addition this network may already be in past scan results and
> +	 * could be joined immediately.
> +	 *
> +	 * For now just wait for autoconnect.
> +	 */
> +
> +	dpp_configuration_free(config);
> +
> +	send_config_result(dpp, dpp->auth_addr);
> +}
> +
>   /*
>    * The Authentication protocol has a consistent use of AD components, a=
nd this
>    * use is defined in 6.3.1.4:

Regards,
-Denis
--===============9000289620719805923==--

