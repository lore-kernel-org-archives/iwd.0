Content-Type: multipart/mixed; boundary="===============4564702995436155918=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 8/9] ie: Add FILS IP Address Assignment parsers and
 builders
Date: Fri, 13 Aug 2021 21:08:02 -0500
Message-ID: <e1242d68-6b9e-7140-a6dd-1ce895238e0a@gmail.com>
In-Reply-To: <20210807021048.321664-8-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4564702995436155918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/6/21 9:10 PM, Andrew Zaborowski wrote:
> ---
>   src/ie.c | 336 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/ie.h |  38 +++++++
>   2 files changed, 374 insertions(+)
> =

> diff --git a/src/ie.c b/src/ie.c
> index a73d5bbc..27950025 100644
> --- a/src/ie.c
> +++ b/src/ie.c
> @@ -25,6 +25,7 @@
>   #endif
>   =

>   #include <errno.h>
> +#include <arpa/inet.h>
>   =

>   #include <ell/ell.h>
>   =

> @@ -2103,3 +2104,338 @@ bool ie_rsnxe_capable(const uint8_t *rsnxe, unsig=
ned int bit)
>   =

>   	return test_bit(rsnxe + 2, bit);
>   }
> +
> +int ie_parse_fils_ip_addr_request(struct ie_tlv_iter *iter,
> +				struct ie_fils_ip_addr_request_info *out)
> +{
> +	unsigned int len =3D ie_tlv_iter_get_length(iter);
> +	const uint8_t *data =3D ie_tlv_iter_get_data(iter);
> +	struct ie_fils_ip_addr_request_info info =3D {};
> +	bool ipv4_specific_addr =3D false;
> +	bool ipv6_specific_addr =3D false;
> +
> +	if (len < 1)
> +		return -EMSGSIZE;
> +
> +	if (bit_field(data[0], 0, 2) =3D=3D 1)
> +		return -EINVAL;
> +	else if (bit_field(data[0], 0, 2) >=3D 2) {
> +		info.ipv4 =3D true;
> +		ipv4_specific_addr =3D (bit_field(data[0], 0, 2) =3D=3D 3);
> +	}
> +
> +	if (bit_field(data[0], 2, 2) =3D=3D 1)
> +		return -EINVAL;
> +	else if (bit_field(data[0], 2, 2) >=3D 2) {
> +		info.ipv6 =3D true;
> +		ipv6_specific_addr =3D (bit_field(data[0], 2, 2) =3D=3D 3);
> +	}
> +
> +	info.dns =3D test_bit(data++, 4);
> +
> +	if (len < 1 + (ipv4_specific_addr ? 4u : 0u) +
> +			(ipv4_specific_addr ? 16u : 0u))

ipv6_specific_addr?

> +		return -EMSGSIZE;
> +
> +	if (ipv4_specific_addr) {
> +		info.ipv4_requested_addr =3D l_get_u32(data);
> +		data +=3D 4;
> +
> +		if (!info.ipv4_requested_addr)
> +			return -EINVAL;
> +	}
> +
> +	if (ipv6_specific_addr) {
> +		memcpy(info.ipv6_requested_addr, data, 16);
> +		data +=3D 16;
> +
> +		if (l_memeqzero(info.ipv6_requested_addr, 16))
> +			return -EINVAL;
> +	}
> +
> +	memcpy(out, &info, sizeof(info));
> +	return 0;
> +}
> +
> +void ie_build_fils_ip_addr_request(
> +				const struct ie_fils_ip_addr_request_info *info,
> +				uint8_t *to)
> +{
> +	uint8_t *len;
> +
> +	*to++ =3D IE_TYPE_EXTENSION;
> +	len =3D to++;
> +	*to++ =3D IE_TYPE_FILS_IP_ADDRESS & 0xff;
> +	*to++ =3D ((info->ipv4 ? info->ipv4_requested_addr ? 3 : 2 : 0) << 0) |
> +		((info->ipv6 ? !l_memeqzero(info->ipv6_requested_addr, 16) ?
> +		  3 : 2 : 0) << 2) |
> +		((info->dns ? 1 : 0) << 4);

I think it would look a lot nicer if you used set_bit instead.  Maybe avoid=
 an =

extra l_memeqzero too...

> +
> +	if (info->ipv4_requested_addr) {
> +		l_put_u32(info->ipv4_requested_addr, to);
> +		to +=3D 4;
> +	}
> +
> +	if (!l_memeqzero(info->ipv6_requested_addr, 16)) {
> +		memcpy(to, info->ipv6_requested_addr, 16);
> +		to +=3D 16;
> +	}
> +
> +	*len =3D to - (len + 1);
> +}
> +
> +int ie_parse_fils_ip_addr_response(struct ie_tlv_iter *iter,
> +				struct ie_fils_ip_addr_response_info *out)
> +{
> +	unsigned int len =3D ie_tlv_iter_get_length(iter);
> +	const uint8_t *data =3D ie_tlv_iter_get_data(iter);
> +	struct ie_fils_ip_addr_response_info info =3D {};
> +	const uint8_t *response_ctrl;
> +	const uint8_t *dns_ctrl;
> +
> +	if (len < 2)
> +		return -EMSGSIZE;
> +
> +	info.response_pending =3D test_bit(data, 0);
> +
> +	if (info.response_pending) {
> +		info.response_timeout =3D bit_field(data[0], 1, 6); /* seconds */
> +		return 0;
> +	}
> +
> +	response_ctrl =3D data++;
> +	dns_ctrl =3D data++;
> +	len -=3D 2;
> +
> +	if (test_bit(response_ctrl, 1)) {
> +		uint32_t netmask;
> +
> +		if (len < 8)
> +			return -EMSGSIZE;
> +
> +		info.ipv4_addr =3D l_get_u32(data);
> +		netmask =3D l_get_be32(data + 4);
> +		info.ipv4_prefix_len =3D __builtin_popcount(netmask);
> +		data +=3D 8;
> +		len -=3D 8;
> +
> +		if (!info.ipv4_addr || info.ipv4_prefix_len > 30 || netmask !=3D
> +				util_netmask_from_prefix(info.ipv4_prefix_len))
> +			return -EINVAL;
> +	}
> +
> +	if (test_bit(response_ctrl, 2)) {
> +		if (len < 10)
> +			return -EMSGSIZE;
> +
> +		info.ipv4_gateway =3D l_get_u32(data);
> +		memcpy(info.ipv4_gateway_mac, data + 4, 6);
> +		data +=3D 10;
> +		len -=3D 10;
> +
> +		/* Check gateway is on the same subnet */
> +		if (info.ipv4_addr && (ntohl(info.ipv4_addr ^ info.ipv4_gateway) &
> +				util_netmask_from_prefix(info.ipv4_prefix_len)))
> +			return -EINVAL;
> +	}
> +
> +	if (test_bit(response_ctrl, 3)) {
> +		if (len < 17)
> +			return -EMSGSIZE;
> +
> +		memcpy(info.ipv6_addr, data, 16);
> +		info.ipv6_prefix_len =3D data[16];
> +		data +=3D 17;
> +		len -=3D 17;
> +
> +		if (l_memeqzero(info.ipv6_addr, 16) ||
> +				info.ipv6_prefix_len > 126)
> +			return -EINVAL;
> +	}
> +
> +	if (test_bit(response_ctrl, 4)) {
> +		if (len < 22)
> +			return -EMSGSIZE;
> +
> +		memcpy(info.ipv6_gateway, data, 16);
> +		memcpy(info.ipv6_gateway_mac, data + 16, 6);
> +		data +=3D 22;
> +		len -=3D 22;
> +
> +		/* Check gateway is on the same subnet */
> +		if (!l_memeqzero(info.ipv6_addr, 12)) {
> +			int n =3D info.ipv6_prefix_len / 8;
> +			uint8_t mask =3D (1 << (info.ipv6_prefix_len & 7)) - 1;
> +
> +			if (n && memcmp(info.ipv6_addr, info.ipv6_gateway, n))
> +				return -EINVAL;
> +
> +			if (mask && ((info.ipv6_addr[n] ^
> +						info.ipv6_gateway[n]) & mask))
> +				return -EINVAL;
> +		}
> +	}
> +
> +	if (test_bit(response_ctrl, 5)) {
> +		if (len < 1)
> +			return -EMSGSIZE;
> +
> +		info.ipv4_lifetime =3D *data++;
> +		len--;
> +	}
> +
> +	if (test_bit(response_ctrl, 6)) {
> +		if (len < 1)
> +			return -EMSGSIZE;
> +
> +		info.ipv6_lifetime =3D *data++;
> +		len--;
> +	}
> +
> +	if (test_bit(dns_ctrl, 0)) {
> +		if (len < 4)
> +			return -EMSGSIZE;
> +
> +		info.ipv4_dns =3D l_get_u32(data);
> +		data +=3D 4;
> +		len -=3D 4;
> +
> +		if (!info.ipv4_dns)
> +			return -EINVAL;
> +	}
> +
> +	if (test_bit(dns_ctrl, 1)) {
> +		if (len < 16)
> +			return -EMSGSIZE;
> +
> +		memcpy(info.ipv6_dns, data, 16);
> +		data +=3D 16;
> +		len -=3D 16;
> +
> +		if (l_memeqzero(info.ipv6_dns, 16))
> +			return -EINVAL;
> +	}
> +
> +	if (test_bit(dns_ctrl, 2)) {
> +		if (len < 6)
> +			return -EMSGSIZE;
> +
> +		memcpy(info.ipv4_dns_mac, data, 6);
> +		data +=3D 6;
> +		len -=3D 6;

Can we come up with a clever macro that would automate this somewhat?  Simi=
lar =

to RSNE_ADVANCE maybe?

> +	}
> +
> +	if (test_bit(dns_ctrl, 3)) {
> +		if (len < 6)
> +			return -EMSGSIZE;
> +
> +		memcpy(info.ipv6_dns_mac, data, 6);
> +		data +=3D 6;
> +		len -=3D 6;
> +	}
> +
> +	memcpy(out, &info, sizeof(info));
> +	return 0;
> +}
> +
> +void ie_build_fils_ip_addr_response(
> +			const struct ie_fils_ip_addr_response_info *info,
> +			uint8_t *to)
> +{
> +	uint8_t *len;
> +	uint8_t *response_ctrl;
> +	uint8_t *dns_ctrl;
> +
> +	*to++ =3D IE_TYPE_EXTENSION;
> +	len =3D to++;
> +	*to++ =3D IE_TYPE_FILS_IP_ADDRESS & 0xff;
> +	response_ctrl =3D to++;
> +	dns_ctrl =3D to++;
> +
> +	*response_ctrl =3D 0;
> +	*dns_ctrl =3D 0;
> +
> +	if (info->response_pending) {
> +		*response_ctrl |=3D 1 << 0;
> +		*response_ctrl |=3D info->response_timeout << 1;
> +		goto done;
> +	}
> +
> +	if (info->ipv4_addr) {
> +		uint32_t netmask =3D
> +			util_netmask_from_prefix(info->ipv4_prefix_len);
> +
> +		*response_ctrl |=3D 1 << 1;

set_bit please.  May even want to make a private enum for the bits too for =

easier reading.  Similar to enum ie_rsnx_capability maybe?

> +
> +		l_put_u32(info->ipv4_addr, to);
> +		l_put_u32(htonl(netmask), to + 4);
> +		to +=3D 8;
> +	}
> +
> +	if (info->ipv4_gateway) {
> +		*response_ctrl |=3D 1 << 2;
> +
> +		l_put_u32(info->ipv4_gateway, to);
> +		memcpy(to + 4, info->ipv4_gateway_mac, 6);
> +		to +=3D 10;
> +	}
> +
> +	if (!l_memeqzero(info->ipv6_addr, 16)) {
> +		*response_ctrl |=3D 1 << 3;
> +
> +		memcpy(to, info->ipv6_addr, 16);
> +		to[16] =3D info->ipv6_prefix_len;
> +		to +=3D 17;
> +	}
> +
> +	if (!l_memeqzero(info->ipv6_gateway, 16)) {
> +		*response_ctrl |=3D 1 << 4;
> +
> +		memcpy(to, info->ipv6_gateway, 16);
> +		memcpy(to + 16, info->ipv6_gateway_mac, 6);
> +		to +=3D 22;
> +	}
> +
> +	if (info->ipv4_lifetime) {
> +		*response_ctrl |=3D 1 << 5;
> +
> +		*to++ =3D info->ipv4_lifetime;
> +	}
> +
> +	if (info->ipv6_lifetime) {
> +		*response_ctrl |=3D 1 << 6;
> +
> +		*to++ =3D info->ipv6_lifetime;
> +	}
> +
> +	if (info->ipv4_dns) {
> +		*dns_ctrl |=3D 1 << 0;
> +
> +		l_put_u32(info->ipv4_dns, to);
> +		to +=3D 4;
> +	}
> +
> +	if (!l_memeqzero(info->ipv6_dns, 16)) {
> +		*dns_ctrl |=3D 1 << 1;
> +
> +		memcpy(to, info->ipv6_dns, 16);
> +		to +=3D 16;
> +	}
> +
> +	if (!l_memeqzero(info->ipv4_dns_mac, 6)) {
> +		*dns_ctrl |=3D 1 << 2;
> +
> +		memcpy(to, info->ipv4_dns_mac, 6);
> +		to +=3D 6;
> +	}
> +
> +	if (!l_memeqzero(info->ipv6_dns_mac, 6)) {
> +		*dns_ctrl |=3D 1 << 3;
> +
> +		memcpy(to, info->ipv6_dns_mac, 6);
> +		to +=3D 6;
> +	}
> +
> +done:
> +	*len =3D to - (len + 1);
> +}
> diff --git a/src/ie.h b/src/ie.h
> index 25b56302..05afce39 100644
> --- a/src/ie.h
> +++ b/src/ie.h
> @@ -459,6 +459,33 @@ struct ie_neighbor_report_info {
>   	bool bss_transition_pref_present : 1;
>   };
>   =

> +struct ie_fils_ip_addr_request_info {
> +	bool ipv4 : 1;
> +	uint32_t ipv4_requested_addr;		/* Zero if none */
> +	bool ipv6 : 1;
> +	uint8_t ipv6_requested_addr[16];	/* Zero if none */
> +	bool dns : 1;
> +};
> +
> +struct ie_fils_ip_addr_response_info {
> +	bool response_pending : 1;
> +	uint8_t response_timeout;	/* Seconds */
> +	uint32_t ipv4_addr;		/* Zero if not provided */
> +	uint8_t ipv4_prefix_len;
> +	uint32_t ipv4_gateway;		/* Zero if not provided */
> +	uint8_t ipv4_gateway_mac[6];
> +	uint32_t ipv4_dns;		/* Zero if not provided */
> +	uint8_t ipv4_dns_mac[6];	/* Zero if not provided */
> +	uint8_t ipv4_lifetime;		/* Zero if not provided */
> +	uint8_t ipv6_addr[16];		/* Zero if not provided */
> +	uint8_t ipv6_prefix_len;
> +	uint8_t ipv6_gateway[16];	/* Zero if not provided */
> +	uint8_t ipv6_gateway_mac[6];
> +	uint8_t ipv6_dns[16];		/* Zero if not provided */
> +	uint8_t ipv6_dns_mac[6];	/* Zero if not provided */
> +	uint8_t ipv6_lifetime;		/* Zero if not provided */
> +};
> +
>   extern const unsigned char ieee_oui[3];
>   extern const unsigned char microsoft_oui[3];
>   extern const unsigned char wifi_alliance_oui[3];
> @@ -586,3 +613,14 @@ enum ie_rsnx_capability {
>   };
>   =

>   bool ie_rsnxe_capable(const uint8_t *rsnxe, unsigned int bit);
> +
> +int ie_parse_fils_ip_addr_request(struct ie_tlv_iter *iter,
> +				struct ie_fils_ip_addr_request_info *out);
> +void ie_build_fils_ip_addr_request(
> +				const struct ie_fils_ip_addr_request_info *info,
> +				uint8_t *to);
> +int ie_parse_fils_ip_addr_response(struct ie_tlv_iter *iter,
> +				struct ie_fils_ip_addr_response_info *out);
> +void ie_build_fils_ip_addr_response(
> +			const struct ie_fils_ip_addr_response_info *info,
> +			uint8_t *to);
> =


Regards,
-Denis
--===============4564702995436155918==--

