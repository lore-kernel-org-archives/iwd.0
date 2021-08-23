Content-Type: multipart/mixed; boundary="===============1351935257372413803=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/9] ie: Add FILS IP Address Assignment parsers and builders
Date: Mon, 23 Aug 2021 16:14:26 +0200
Message-ID: <20210823141430.223543-5-andrew.zaborowski@intel.com>
In-Reply-To: <20210823141430.223543-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1351935257372413803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ie.c | 347 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ie.h |  38 ++++++
 2 files changed, 385 insertions(+)

diff --git a/src/ie.c b/src/ie.c
index a73d5bbc..c03b16b4 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -25,6 +25,7 @@
 #endif
 =

 #include <errno.h>
+#include <arpa/inet.h>
 =

 #include <ell/ell.h>
 =

@@ -2103,3 +2104,349 @@ bool ie_rsnxe_capable(const uint8_t *rsnxe, unsigne=
d int bit)
 =

 	return test_bit(rsnxe + 2, bit);
 }
+
+/* 802.11ai-2016 Tables 9-589r, 9-262d, 9-262e */
+enum ie_fils_ip_addr_req_ctrl_bits {
+	IE_FILS_IP_ADDR_REQ_CTRL_IPV4_MASK =3D 3 << 0,
+	IE_FILS_IP_ADDR_REQ_CTRL_IPV4_NONE =3D 0 << 0,
+	IE_FILS_IP_ADDR_REQ_CTRL_IPV4_NEW =3D 2 << 0,
+	IE_FILS_IP_ADDR_REQ_CTRL_IPV4_SPECIFIC =3D 3 << 0,
+	IE_FILS_IP_ADDR_REQ_CTRL_IPV6_MASK =3D 3 << 2,
+	IE_FILS_IP_ADDR_REQ_CTRL_IPV6_NONE =3D 0 << 2,
+	IE_FILS_IP_ADDR_REQ_CTRL_IPV6_NEW =3D 2 << 2,
+	IE_FILS_IP_ADDR_REQ_CTRL_IPV6_SPECIFIC =3D 3 << 2,
+	IE_FILS_IP_ADDR_REQ_CTRL_DNS =3D 1 << 4,
+};
+
+/* 802.11ai-2016 Table 9-262f */
+enum ie_fils_ip_addr_resp_ctrl_bits {
+	IE_FILS_IP_ADDR_RESP_CTRL_IP_PENDING =3D 1 << 0,
+	IE_FILS_IP_ADDR_RESP_CTRL_IPV4_ASSIGNED =3D 1 << 1,
+	IE_FILS_IP_ADDR_RESP_CTRL_IPV4_GW_INCLUDED =3D 1 << 2,
+	IE_FILS_IP_ADDR_RESP_CTRL_IPV6_ASSIGNED =3D 1 << 3,
+	IE_FILS_IP_ADDR_RESP_CTRL_IPV6_GW_INCLUDED =3D 1 << 4,
+	IE_FILS_IP_ADDR_RESP_CTRL_IPV4_LIFETIME_INCLUDED =3D 1 << 5,
+	IE_FILS_IP_ADDR_RESP_CTRL_IPV6_LIFETIME_INCLUDED =3D 1 << 6,
+};
+
+/* 802.11ai-2016 Table 9-262h */
+enum ie_fils_ip_addr_resp_dns_ctrl_bits {
+	IE_FILS_IP_ADDR_RESP_DNS_CTRL_IPV4_DNS_INCLUDED =3D 1 << 0,
+	IE_FILS_IP_ADDR_RESP_DNS_CTRL_IPV6_DNS_INCLUDED =3D 1 << 1,
+	IE_FILS_IP_ADDR_RESP_DNS_CTRL_IPV4_DNS_MAC_INCLUDED =3D 1 << 2,
+	IE_FILS_IP_ADDR_RESP_DNS_CTRL_IPV6_DNS_MAC_INCLUDED =3D 1 << 3,
+};
+
+int ie_parse_fils_ip_addr_request(struct ie_tlv_iter *iter,
+				struct ie_fils_ip_addr_request_info *out)
+{
+	unsigned int len =3D ie_tlv_iter_get_length(iter);
+	const uint8_t *data =3D ie_tlv_iter_get_data(iter);
+	struct ie_fils_ip_addr_request_info info =3D {};
+	bool ipv4_specific_addr =3D false;
+	bool ipv6_specific_addr =3D false;
+
+	if (len < 1)
+		return -EMSGSIZE;
+
+	if (L_IN_SET(data[0] & IE_FILS_IP_ADDR_REQ_CTRL_IPV4_MASK,
+			IE_FILS_IP_ADDR_REQ_CTRL_IPV4_NEW,
+			IE_FILS_IP_ADDR_REQ_CTRL_IPV4_SPECIFIC)) {
+		info.ipv4 =3D true;
+		ipv4_specific_addr =3D
+			(data[0] & IE_FILS_IP_ADDR_REQ_CTRL_IPV4_MASK) =3D=3D
+			IE_FILS_IP_ADDR_REQ_CTRL_IPV4_SPECIFIC;
+	} else if ((data[0] & IE_FILS_IP_ADDR_REQ_CTRL_IPV4_MASK) !=3D
+			IE_FILS_IP_ADDR_REQ_CTRL_IPV4_NONE)
+		return -EINVAL;
+
+	if (L_IN_SET(data[0] & IE_FILS_IP_ADDR_REQ_CTRL_IPV6_MASK,
+			IE_FILS_IP_ADDR_REQ_CTRL_IPV6_NEW,
+			IE_FILS_IP_ADDR_REQ_CTRL_IPV6_SPECIFIC)) {
+		info.ipv6 =3D true;
+		ipv6_specific_addr =3D
+			(data[0] & IE_FILS_IP_ADDR_REQ_CTRL_IPV6_MASK) =3D=3D
+			IE_FILS_IP_ADDR_REQ_CTRL_IPV6_SPECIFIC;
+	} else if ((data[0] & IE_FILS_IP_ADDR_REQ_CTRL_IPV6_MASK) !=3D
+			IE_FILS_IP_ADDR_REQ_CTRL_IPV6_NONE)
+		return -EINVAL;
+
+	info.dns =3D !!(*data++ & IE_FILS_IP_ADDR_REQ_CTRL_DNS);
+
+	if (len < 1 + (ipv4_specific_addr ? 4u : 0u) +
+			(ipv6_specific_addr ? 16u : 0u))
+		return -EMSGSIZE;
+
+	if (ipv4_specific_addr) {
+		info.ipv4_requested_addr =3D l_get_u32(data);
+		data +=3D 4;
+
+		if (!info.ipv4_requested_addr)
+			return -EINVAL;
+	}
+
+	if (ipv6_specific_addr) {
+		memcpy(info.ipv6_requested_addr, data, 16);
+		data +=3D 16;
+
+		if (l_memeqzero(info.ipv6_requested_addr, 16))
+			return -EINVAL;
+	}
+
+	memcpy(out, &info, sizeof(info));
+	return 0;
+}
+
+void ie_build_fils_ip_addr_request(
+				const struct ie_fils_ip_addr_request_info *info,
+				uint8_t *to)
+{
+	uint8_t *len;
+	uint8_t *ctrl;
+
+	*to++ =3D IE_TYPE_EXTENSION;
+	len =3D to++;
+	*to++ =3D IE_TYPE_FILS_IP_ADDRESS & 0xff;
+	ctrl =3D to++;
+
+	*ctrl =3D info->dns ? IE_FILS_IP_ADDR_REQ_CTRL_DNS : 0;
+
+	if (info->ipv4) {
+		if (info->ipv4_requested_addr) {
+			l_put_u32(info->ipv4_requested_addr, to);
+			to +=3D 4;
+			*ctrl |=3D IE_FILS_IP_ADDR_REQ_CTRL_IPV4_SPECIFIC;
+		} else
+			*ctrl |=3D IE_FILS_IP_ADDR_REQ_CTRL_IPV4_NEW;
+	}
+
+	if (info->ipv6) {
+		if (!l_memeqzero(info->ipv6_requested_addr, 16)) {
+			memcpy(to, info->ipv6_requested_addr, 16);
+			to +=3D 16;
+			*ctrl |=3D IE_FILS_IP_ADDR_REQ_CTRL_IPV6_SPECIFIC;
+		} else
+			*ctrl |=3D IE_FILS_IP_ADDR_REQ_CTRL_IPV6_NEW;
+	}
+
+	*len =3D to - (len + 1);
+}
+
+#define NEXT_FIELD(data, len, size) (__extension__ ({	\
+	const uint8_t *_ptr =3D data;			\
+							\
+	if (len < size)					\
+		return -EMSGSIZE;			\
+							\
+	data +=3D size;					\
+	len -=3D size;					\
+	_ptr; }))
+
+int ie_parse_fils_ip_addr_response(struct ie_tlv_iter *iter,
+				struct ie_fils_ip_addr_response_info *out)
+{
+	unsigned int len =3D ie_tlv_iter_get_length(iter);
+	const uint8_t *data =3D ie_tlv_iter_get_data(iter);
+	struct ie_fils_ip_addr_response_info info =3D {};
+	const uint8_t *resp_ctrl;
+	const uint8_t *dns_ctrl;
+	const uint8_t *ptr;
+
+	resp_ctrl =3D NEXT_FIELD(data, len, 2);
+	dns_ctrl =3D resp_ctrl + 1;
+
+	info.response_pending =3D
+		!!(*resp_ctrl & IE_FILS_IP_ADDR_RESP_CTRL_IP_PENDING);
+
+	if (info.response_pending) {
+		info.response_timeout =3D
+			bit_field(*resp_ctrl, 1, 6); /* seconds */
+		return 0;
+	}
+
+	if (*resp_ctrl & IE_FILS_IP_ADDR_RESP_CTRL_IPV4_ASSIGNED) {
+		uint32_t netmask;
+
+		ptr =3D NEXT_FIELD(data, len, 8);
+		info.ipv4_addr =3D l_get_u32(ptr);
+		netmask =3D l_get_be32(ptr + 4);
+		info.ipv4_prefix_len =3D __builtin_popcount(netmask);
+
+		if (!info.ipv4_addr || info.ipv4_prefix_len > 30 || netmask !=3D
+				util_netmask_from_prefix(info.ipv4_prefix_len))
+			return -EINVAL;
+	}
+
+	if (*resp_ctrl & IE_FILS_IP_ADDR_RESP_CTRL_IPV4_GW_INCLUDED) {
+		ptr =3D NEXT_FIELD(data, len, 10);
+		info.ipv4_gateway =3D l_get_u32(ptr);
+		memcpy(info.ipv4_gateway_mac, ptr + 4, 6);
+
+		/* Check gateway is on the same subnet */
+		if (info.ipv4_addr && (ntohl(info.ipv4_addr ^ info.ipv4_gateway) &
+				util_netmask_from_prefix(info.ipv4_prefix_len)))
+			return -EINVAL;
+	}
+
+	if (*resp_ctrl & IE_FILS_IP_ADDR_RESP_CTRL_IPV6_ASSIGNED) {
+		ptr =3D NEXT_FIELD(data, len, 17);
+		memcpy(info.ipv6_addr, ptr, 16);
+		info.ipv6_prefix_len =3D ptr[16];
+
+		if (l_memeqzero(info.ipv6_addr, 16) ||
+				info.ipv6_prefix_len > 126)
+			return -EINVAL;
+	}
+
+	if (*resp_ctrl & IE_FILS_IP_ADDR_RESP_CTRL_IPV6_GW_INCLUDED) {
+		ptr =3D NEXT_FIELD(data, len, 22);
+		memcpy(info.ipv6_gateway, ptr, 16);
+		memcpy(info.ipv6_gateway_mac, ptr + 16, 6);
+
+		/* Check gateway is on the same subnet */
+		if (!l_memeqzero(info.ipv6_addr, 12)) {
+			int n =3D info.ipv6_prefix_len / 8;
+			uint8_t mask =3D (1 << (info.ipv6_prefix_len & 7)) - 1;
+
+			if (n && memcmp(info.ipv6_addr, info.ipv6_gateway, n))
+				return -EINVAL;
+
+			if (mask && ((info.ipv6_addr[n] ^
+						info.ipv6_gateway[n]) & mask))
+				return -EINVAL;
+		}
+	}
+
+	if (*resp_ctrl & IE_FILS_IP_ADDR_RESP_CTRL_IPV4_LIFETIME_INCLUDED)
+		info.ipv4_lifetime =3D *NEXT_FIELD(data, len, 1); /* seconds */
+
+	if (*resp_ctrl & IE_FILS_IP_ADDR_RESP_CTRL_IPV6_LIFETIME_INCLUDED)
+		info.ipv6_lifetime =3D *NEXT_FIELD(data, len, 1); /* seconds */
+
+	if (*dns_ctrl & IE_FILS_IP_ADDR_RESP_DNS_CTRL_IPV4_DNS_INCLUDED) {
+		info.ipv4_dns =3D l_get_u32(NEXT_FIELD(data, len, 4));
+
+		if (!info.ipv4_dns)
+			return -EINVAL;
+	}
+
+	if (*dns_ctrl & IE_FILS_IP_ADDR_RESP_DNS_CTRL_IPV6_DNS_INCLUDED) {
+		memcpy(info.ipv6_dns, NEXT_FIELD(data, len, 16), 16);
+
+		if (l_memeqzero(info.ipv6_dns, 16))
+			return -EINVAL;
+	}
+
+	if (*dns_ctrl & IE_FILS_IP_ADDR_RESP_DNS_CTRL_IPV4_DNS_MAC_INCLUDED)
+		memcpy(info.ipv4_dns_mac, NEXT_FIELD(data, len, 6), 6);
+
+	if (*dns_ctrl & IE_FILS_IP_ADDR_RESP_DNS_CTRL_IPV6_DNS_MAC_INCLUDED)
+		memcpy(info.ipv6_dns_mac, NEXT_FIELD(data, len, 6), 6);
+
+	memcpy(out, &info, sizeof(info));
+	return 0;
+}
+
+void ie_build_fils_ip_addr_response(
+			const struct ie_fils_ip_addr_response_info *info,
+			uint8_t *to)
+{
+	uint8_t *len;
+	uint8_t *resp_ctrl;
+	uint8_t *dns_ctrl;
+
+	*to++ =3D IE_TYPE_EXTENSION;
+	len =3D to++;
+	*to++ =3D IE_TYPE_FILS_IP_ADDRESS & 0xff;
+	resp_ctrl =3D to++;
+	dns_ctrl =3D to++;
+
+	*resp_ctrl =3D 0;
+	*dns_ctrl =3D 0;
+
+	if (info->response_pending) {
+		*resp_ctrl |=3D IE_FILS_IP_ADDR_RESP_CTRL_IP_PENDING;
+		*resp_ctrl |=3D info->response_timeout << 1;
+		goto done;
+	}
+
+	if (info->ipv4_addr) {
+		uint32_t netmask =3D
+			util_netmask_from_prefix(info->ipv4_prefix_len);
+
+		*resp_ctrl |=3D IE_FILS_IP_ADDR_RESP_CTRL_IPV4_ASSIGNED;
+
+		l_put_u32(info->ipv4_addr, to);
+		l_put_u32(htonl(netmask), to + 4);
+		to +=3D 8;
+	}
+
+	if (info->ipv4_gateway) {
+		*resp_ctrl |=3D IE_FILS_IP_ADDR_RESP_CTRL_IPV4_GW_INCLUDED;
+
+		l_put_u32(info->ipv4_gateway, to);
+		memcpy(to + 4, info->ipv4_gateway_mac, 6);
+		to +=3D 10;
+	}
+
+	if (!l_memeqzero(info->ipv6_addr, 16)) {
+		*resp_ctrl |=3D IE_FILS_IP_ADDR_RESP_CTRL_IPV6_ASSIGNED;
+
+		memcpy(to, info->ipv6_addr, 16);
+		to[16] =3D info->ipv6_prefix_len;
+		to +=3D 17;
+	}
+
+	if (!l_memeqzero(info->ipv6_gateway, 16)) {
+		*resp_ctrl |=3D IE_FILS_IP_ADDR_RESP_CTRL_IPV6_GW_INCLUDED;
+
+		memcpy(to, info->ipv6_gateway, 16);
+		memcpy(to + 16, info->ipv6_gateway_mac, 6);
+		to +=3D 22;
+	}
+
+	if (info->ipv4_lifetime) {
+		*resp_ctrl |=3D IE_FILS_IP_ADDR_RESP_CTRL_IPV4_LIFETIME_INCLUDED;
+
+		*to++ =3D info->ipv4_lifetime;
+	}
+
+	if (info->ipv6_lifetime) {
+		*resp_ctrl |=3D IE_FILS_IP_ADDR_RESP_CTRL_IPV6_LIFETIME_INCLUDED;
+
+		*to++ =3D info->ipv6_lifetime;
+	}
+
+	if (info->ipv4_dns) {
+		*dns_ctrl |=3D IE_FILS_IP_ADDR_RESP_DNS_CTRL_IPV4_DNS_INCLUDED;
+
+		l_put_u32(info->ipv4_dns, to);
+		to +=3D 4;
+	}
+
+	if (!l_memeqzero(info->ipv6_dns, 16)) {
+		*dns_ctrl |=3D IE_FILS_IP_ADDR_RESP_DNS_CTRL_IPV6_DNS_INCLUDED;
+
+		memcpy(to, info->ipv6_dns, 16);
+		to +=3D 16;
+	}
+
+	if (!l_memeqzero(info->ipv4_dns_mac, 6)) {
+		*dns_ctrl |=3D
+			IE_FILS_IP_ADDR_RESP_DNS_CTRL_IPV4_DNS_MAC_INCLUDED;
+
+		memcpy(to, info->ipv4_dns_mac, 6);
+		to +=3D 6;
+	}
+
+	if (!l_memeqzero(info->ipv6_dns_mac, 6)) {
+		*dns_ctrl |=3D
+			IE_FILS_IP_ADDR_RESP_DNS_CTRL_IPV6_DNS_MAC_INCLUDED;
+
+		memcpy(to, info->ipv6_dns_mac, 6);
+		to +=3D 6;
+	}
+
+done:
+	*len =3D to - (len + 1);
+}
diff --git a/src/ie.h b/src/ie.h
index 25b56302..05afce39 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -459,6 +459,33 @@ struct ie_neighbor_report_info {
 	bool bss_transition_pref_present : 1;
 };
 =

+struct ie_fils_ip_addr_request_info {
+	bool ipv4 : 1;
+	uint32_t ipv4_requested_addr;		/* Zero if none */
+	bool ipv6 : 1;
+	uint8_t ipv6_requested_addr[16];	/* Zero if none */
+	bool dns : 1;
+};
+
+struct ie_fils_ip_addr_response_info {
+	bool response_pending : 1;
+	uint8_t response_timeout;	/* Seconds */
+	uint32_t ipv4_addr;		/* Zero if not provided */
+	uint8_t ipv4_prefix_len;
+	uint32_t ipv4_gateway;		/* Zero if not provided */
+	uint8_t ipv4_gateway_mac[6];
+	uint32_t ipv4_dns;		/* Zero if not provided */
+	uint8_t ipv4_dns_mac[6];	/* Zero if not provided */
+	uint8_t ipv4_lifetime;		/* Zero if not provided */
+	uint8_t ipv6_addr[16];		/* Zero if not provided */
+	uint8_t ipv6_prefix_len;
+	uint8_t ipv6_gateway[16];	/* Zero if not provided */
+	uint8_t ipv6_gateway_mac[6];
+	uint8_t ipv6_dns[16];		/* Zero if not provided */
+	uint8_t ipv6_dns_mac[6];	/* Zero if not provided */
+	uint8_t ipv6_lifetime;		/* Zero if not provided */
+};
+
 extern const unsigned char ieee_oui[3];
 extern const unsigned char microsoft_oui[3];
 extern const unsigned char wifi_alliance_oui[3];
@@ -586,3 +613,14 @@ enum ie_rsnx_capability {
 };
 =

 bool ie_rsnxe_capable(const uint8_t *rsnxe, unsigned int bit);
+
+int ie_parse_fils_ip_addr_request(struct ie_tlv_iter *iter,
+				struct ie_fils_ip_addr_request_info *out);
+void ie_build_fils_ip_addr_request(
+				const struct ie_fils_ip_addr_request_info *info,
+				uint8_t *to);
+int ie_parse_fils_ip_addr_response(struct ie_tlv_iter *iter,
+				struct ie_fils_ip_addr_response_info *out);
+void ie_build_fils_ip_addr_response(
+			const struct ie_fils_ip_addr_response_info *info,
+			uint8_t *to);
-- =

2.30.2

--===============1351935257372413803==--

