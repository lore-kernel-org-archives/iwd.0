Content-Type: multipart/mixed; boundary="===============0783740757135034871=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH] netconfig: Remove usage of in6_addr.__in6_u
Date: Thu, 16 Sep 2021 01:58:29 +0200
Message-ID: <20210915235829.536670-1-andrew.zaborowski@intel.com>

--===============0783740757135034871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

in6_addr.__in6_u.__u6_addr8 is glibc-specific and named differently in
the headers shipped with musl libc for example.  The POSIX compliant and
universal way of accessing it is in6_addr.s6_addr.
---
 src/netconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index ce95db0b..421270c9 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -171,7 +171,7 @@ static inline char *netconfig_ipv6_to_string(const uint=
8_t *addr)
 	struct in6_addr in6_addr;
 	char *addr_str =3D l_malloc(INET6_ADDRSTRLEN);
 =

-	memcpy(in6_addr.__in6_u.__u6_addr8, addr, 16);
+	memcpy(in6_addr.s6_addr, addr, 16);
 =

 	if (L_WARN_ON(unlikely(!inet_ntop(AF_INET6, &in6_addr, addr_str,
 						INET6_ADDRSTRLEN)))) {
-- =

2.30.2

--===============0783740757135034871==--

