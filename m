Content-Type: multipart/mixed; boundary="===============1034264616613436232=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/6] peap: Extend EAP Extensions to handle multiple TLVs
Date: Mon, 09 Dec 2019 01:46:02 -0600
Message-ID: <9eb554d4-2aee-d2a2-828e-44af7b7411a9@gmail.com>
In-Reply-To: <20191205211354.19075-4-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1034264616613436232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 12/5/19 3:13 PM, Tim Kourt wrote:
> The handler for EAP Extensions has been modified to support multiple
> TLV types instead of the single Result TLV. This will allow to handle
> the other TLVs such as Crypto-Binding TLV.
> ---
>   src/eap-peap.c | 90 ++++++++++++++++++++++++++++++++++++++++++---------=
-------
>   1 file changed, 65 insertions(+), 25 deletions(-)
> =

> diff --git a/src/eap-peap.c b/src/eap-peap.c
> index ed18c667..8cd73c82 100644
> --- a/src/eap-peap.c
> +++ b/src/eap-peap.c
> @@ -111,6 +111,7 @@ static void eap_peap_phase2_complete(enum eap_result =
result, void *user_data)
>    */
>   #define EAP_EXTENSIONS_HEADER_LEN 5
>   #define EAP_EXTENSIONS_TLV_HEADER_LEN 4
> +#define EAP_EXTENSIONS_TLV_M_BIT_MASK 0x8000
>   =

>   enum eap_extensions_tlv_type {
>   	/* Reserved =3D 0x0000, */
> @@ -119,6 +120,8 @@ enum eap_extensions_tlv_type {
>   	EAP_EXTENSIONS_TLV_TYPE_RESULT =3D 0x8003,
>   };
>   =

> +#define TLV_RESULT_VAL_LEN 2
> +

Generally we don't like using #define for something that will be used =

only in one place.  Use a static const function variable if you feel =

using a constant isn't elegant.

>   enum eap_extensions_result {
>   	EAP_EXTENSIONS_RESULT_SUCCCESS =3D 1,
>   	EAP_EXTENSIONS_RESULT_FAILURE  =3D 2,
> @@ -126,31 +129,15 @@ enum eap_extensions_result {
>   =

>   static int eap_extensions_handle_result_tlv(struct eap_state *eap,
>   						const uint8_t *data,
> -						size_t data_len,
> +						uint16_t tlv_value_len,

I'm not sure this is any better

>   						uint8_t *response)
>   {
>   	struct peap_state *peap_state;
> -	uint16_t type;
> -	uint16_t len;
>   	uint16_t result;
>   =

> -	if (data_len < EAP_EXTENSIONS_TLV_HEADER_LEN + 2)
> -		return -ENOENT;
> -
> -	type =3D l_get_be16(data);
> -
> -	if (type !=3D EAP_EXTENSIONS_TLV_TYPE_RESULT)
> -		return -ENOENT;
> -
> -	data +=3D 2;
> -
> -	len =3D l_get_be16(data);
> -
> -	if (len !=3D 2)
> +	if (tlv_value_len !=3D TLV_RESULT_VAL_LEN)
>   		return -ENOENT;

Just nitpicking, but I don't think ENOENT fits now.  Use -EINVAL or -EBADMSG
>   =

> -	data +=3D 2;
> -
>   	result =3D l_get_be16(data);
>   =

>   	l_debug("result: %d", result);
> @@ -169,11 +156,62 @@ static int eap_extensions_handle_result_tlv(struct =
eap_state *eap,
>   		return -ENOENT;
>   	}
>   =

> -	l_put_be16(EAP_EXTENSIONS_TLV_TYPE_RESULT,
> -					&response[EAP_EXTENSIONS_HEADER_LEN]);
> -	l_put_be16(2, &response[EAP_EXTENSIONS_HEADER_LEN + 2]);
> -	l_put_be16(result, &response[EAP_EXTENSIONS_HEADER_LEN +
> -						EAP_EXTENSIONS_TLV_HEADER_LEN]);
> +	/* Build response Result TLV */
> +
> +	l_put_be16(EAP_EXTENSIONS_TLV_TYPE_RESULT, response);
> +	response +=3D 2;
> +
> +	l_put_be16(TLV_RESULT_VAL_LEN, response);
> +	response +=3D 2;
> +
> +	l_put_be16(result, response);
> +
> +	return result;
> +}
> +
> +static int eap_extensions_process_tlvs(struct eap_state *eap,
> +						const uint8_t *data,
> +						size_t data_len,
> +						uint8_t *response)
> +{
> +	uint16_t tlv_type;
> +	uint16_t tlv_value_len;
> +	int r;
> +	int result =3D EAP_EXTENSIONS_RESULT_FAILURE;
> +
> +	while (data_len >=3D EAP_EXTENSIONS_TLV_HEADER_LEN) {
> +		tlv_type =3D l_get_be16(data);
> +		data +=3D 2;
> +
> +		tlv_value_len =3D l_get_be16(data);
> +		data +=3D 2;
> +
> +		data_len -=3D EAP_EXTENSIONS_TLV_HEADER_LEN;
> +
> +		if (data_len < tlv_value_len)
> +			return -ENOENT;

Same here, -EBADMSG might be better

> +
> +		switch (tlv_type) {
> +		case EAP_EXTENSIONS_TLV_TYPE_RESULT:
> +			result =3D r =3D eap_extensions_handle_result_tlv(eap,
> +						data, tlv_value_len, response);
> +
> +			response +=3D EAP_EXTENSIONS_TLV_HEADER_LEN +
> +							TLV_RESULT_VAL_LEN;
> +			break;
> +		default:
> +			if (tlv_type & EAP_EXTENSIONS_TLV_M_BIT_MASK)
> +				return -ENOENT;
> +
> +			break;
> +		}
> +
> +		if (r < 0)
> +			return r;
> +
> +		data +=3D tlv_value_len;
> +		data_len -=3D tlv_value_len;
> +	}
>   =

>   	return result;
>   }
> @@ -185,8 +223,10 @@ static void eap_extensions_handle_request(struct eap=
_state *eap,
>   {
>   	struct peap_state *peap_state;
>   	uint8_t response[EAP_EXTENSIONS_HEADER_LEN +
> -					EAP_EXTENSIONS_TLV_HEADER_LEN + 2];
> -	int r =3D eap_extensions_handle_result_tlv(eap, pkt, len, response);
> +				EAP_EXTENSIONS_TLV_HEADER_LEN +
> +						TLV_RESULT_VAL_LEN];
> +	int r =3D eap_extensions_process_tlvs(eap, pkt, len,
> +					&response[EAP_EXTENSIONS_HEADER_LEN]);
>   =

>   	if (r < 0)
>   		return;
> =


Regards,
-Denis
--===============1034264616613436232==--

