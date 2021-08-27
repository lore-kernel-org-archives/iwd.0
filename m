Content-Type: multipart/mixed; boundary="===============1608375743430114468=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/5] ie: Extract same-subnet check code to util.h
Date: Fri, 27 Aug 2021 05:02:06 +0200
Message-ID: <20210827030207.353705-4-andrew.zaborowski@intel.com>
In-Reply-To: <20210827030207.353705-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1608375743430114468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ie.c   | 22 +++++++++-------------
 src/util.h | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/src/ie.c b/src/ie.c
index 6f487912..0aa86af6 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -2309,8 +2309,10 @@ int ie_parse_fils_ip_addr_response(struct ie_tlv_ite=
r *iter,
 		memcpy(info.ipv4_gateway_mac, ptr + 4, 6);
 =

 		/* Check gateway is on the same subnet */
-		if (info.ipv4_addr && (ntohl(info.ipv4_addr ^ info.ipv4_gateway) &
-				util_netmask_from_prefix(info.ipv4_prefix_len)))
+		if (info.ipv4_addr &&
+				!util_ip_subnet_match(info.ipv4_prefix_len,
+							&info.ipv4_addr,
+							&info.ipv4_gateway))
 			return -EINVAL;
 	}
 =

@@ -2330,17 +2332,11 @@ int ie_parse_fils_ip_addr_response(struct ie_tlv_it=
er *iter,
 		memcpy(info.ipv6_gateway_mac, ptr + 16, 6);
 =

 		/* Check gateway is on the same subnet */
-		if (!l_memeqzero(info.ipv6_addr, 12)) {
-			int n =3D info.ipv6_prefix_len / 8;
-			uint8_t mask =3D (1 << (info.ipv6_prefix_len & 7)) - 1;
-
-			if (n && memcmp(info.ipv6_addr, info.ipv6_gateway, n))
-				return -EINVAL;
-
-			if (mask && ((info.ipv6_addr[n] ^
-						info.ipv6_gateway[n]) & mask))
-				return -EINVAL;
-		}
+		if (!l_memeqzero(info.ipv6_addr, 16) &&
+				!util_ip_subnet_match(info.ipv6_prefix_len,
+							info.ipv6_addr,
+							info.ipv6_gateway))
+			return -EINVAL;
 	}
 =

 	if (*resp_ctrl & IE_FILS_IP_ADDR_RESP_CTRL_IPV4_LIFETIME_INCLUDED)
diff --git a/src/util.h b/src/util.h
index 1604a372..ae640698 100644
--- a/src/util.h
+++ b/src/util.h
@@ -82,9 +82,23 @@ static inline uint32_t util_secure_fill_with_msb(uint32_=
t val)
 bool util_ip_prefix_tohl(const char *ip, uint8_t *prefix, uint32_t *start_=
out,
 				uint32_t *end_out, uint32_t *mask_out);
 =

+/* Host byte-order IPv4 netmask */
 static inline uint32_t util_netmask_from_prefix(uint8_t prefix_len)
 {
 	return ~((1ull << (32 - prefix_len)) - 1);
 }
 =

+/* Expects network byte-order (big-endian) addresses */
+static inline bool util_ip_subnet_match(uint8_t prefix_len,
+					const void *addr1, const void *addr2)
+{
+	const uint8_t *u8_1 =3D addr1;
+	const uint8_t *u8_2 =3D addr2;
+	uint8_t pref_bytes =3D prefix_len / 8;
+
+	return (!pref_bytes || !memcmp(u8_1, u8_2, pref_bytes)) &&
+		!((u8_1[pref_bytes] ^ u8_2[pref_bytes]) &
+		  ~((1u << (8 - (prefix_len % 8))) - 1));
+}
+
 #endif /* __UTIL_H */
-- =

2.30.2

--===============1608375743430114468==--

