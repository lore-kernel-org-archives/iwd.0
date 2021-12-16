Content-Type: multipart/mixed; boundary="===============2886067548985479694=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v4 06/10] dpp: add DPP authentication protocol
Date: Thu, 16 Dec 2021 14:42:50 -0600
Message-ID: <0ddc36ad-487d-e3c0-e743-2f32b53d9492@gmail.com>
In-Reply-To: 20211216180854.39470-6-prestwoj@gmail.com

--===============2886067548985479694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/16/21 12:08, James Prestwood wrote:
> This implements the DPP protocol used to authenticate to a
> DPP configurator.
> =

> Note this is not a full implementation of the protocol and
> there are a few missing features which will be added as
> needed:
> =

>   - Mutual authentication (needed for BLE bootstrapping)
>   - Configurator support
>   - Initiator role
> ---
>   src/dpp.c | 571 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 571 insertions(+)
> =


<snip>

> @@ -143,6 +179,34 @@ static void dpp_send_frame(uint64_t wdev_id, struct =
iovec *iov, size_t iov_len,
>   		l_error("Could not send CMD_FRAME");
>   }
>   =

> +static uint8_t *dpp_unwrap_attr(enum dpp_frame_type type, const void *st=
art,
> +				const void *key, size_t key_len,
> +				const uint8_t *wrapped, size_t wrapped_len,
> +				size_t *unwrapped_len)
> +{
> +	uint8_t ad0[] =3D { 0x50, 0x6f, 0x9a, 0x1a, 0x01, type };
> +	struct iovec ad[2];
> +	uint8_t *unwrapped;
> +
> +	ad[0].iov_base =3D ad0;
> +	ad[0].iov_len =3D sizeof(ad0);
> +
> +	ad[1].iov_base =3D (void *)start;
> +	ad[1].iov_len =3D ((wrapped - 4) - ((const uint8_t *)start));

Ok, but I think you may need a comment about this referencing the spec =

explaining the AD data setup being used.

Also, why do you have 'wrapped' as a const uint8_t * and 'start' as a const=
 void =

*?  Might be easier to make them both const void * and avoid this cast.

> +
> +	unwrapped =3D l_malloc(wrapped_len - 16);
> +
> +	if (!aes_siv_decrypt(key, key_len, wrapped, wrapped_len, ad, 2,
> +				unwrapped)) {
> +		l_free(unwrapped);
> +		return NULL;
> +	}
> +
> +	*unwrapped_len =3D wrapped_len - 16;
> +
> +	return unwrapped;
> +}
> +
>   static size_t dpp_append_attr(uint8_t *to, enum dpp_attribute_type type,
>   				void *attr, size_t attr_len)
>   {

Do you want to split out the protocol parsers / builders from dpp.c into =

dpp-util or another file so they can be unit tested separately?

Regards,
-Denis
--===============2886067548985479694==--

