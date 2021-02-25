Content-Type: multipart/mixed; boundary="===============6652665156834069034=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/7] utils: Add util_netmask_from_prefix
Date: Thu, 25 Feb 2021 22:27:22 +0100
Message-ID: <20210225212725.656746-4-andrew.zaborowski@intel.com>
In-Reply-To: <20210225212725.656746-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6652665156834069034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/util.h b/src/util.h
index e6b4747f..d2fe0d75 100644
--- a/src/util.h
+++ b/src/util.h
@@ -110,4 +110,9 @@ static inline uint32_t util_secure_fill_with_msb(uint32=
_t val)
 bool util_ip_prefix_tohl(const char *ip, uint8_t *prefix, uint32_t *start_=
out,
 				uint32_t *end_out, uint32_t *mask_out);
 =

+static inline uint32_t util_netmask_from_prefix(uint8_t prefix_len)
+{
+	return ~((1ull << (32 - prefix_len)) - 1);
+}
+
 #endif /* __UTIL_H */
-- =

2.27.0

--===============6652665156834069034==--

