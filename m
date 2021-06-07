Content-Type: multipart/mixed; boundary="===============4453690924447518025=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] ip-pool: Validate prefix lengths in used addresses
Date: Mon, 07 Jun 2021 23:26:27 +0200
Message-ID: <20210607212627.244204-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210607212627.244204-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4453690924447518025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Be paranoid and check that the prefix length in addresses from
used_addr4_list are not zero (they shouldn't be) and that address family
is AF_INET (it should be), mainly to quiet coverity warnings:

>>>     CID 370881:  Integer handling issues  (BAD_SHIFT)
>>>     In expression "1 << 32 - l_rtnl_address_get_prefix_length(rec->addr=
)", left shifting by more than 31 bits has undefined behavior.  The shift a=
mount, "32 - l_rtnl_address_get_prefix_length(rec->addr)", is 32.
151              uint32_t used_subnet_size =3D 1 <<
152                      (32 - l_rtnl_address_get_prefix_length(rec->addr));

>>>     CID 370878:  Memory - corruptions  (OVERRUN)
>>>     Overrunning array "addr_str" of 16 bytes by passing it to a functio=
n which accesses it at byte offset 45.
154              if (!l_rtnl_address_get_address(rec->addr, addr_str) ||

While there also fix one line's indentation.
---
 src/ip-pool.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/src/ip-pool.c b/src/ip-pool.c
index e3f02d5e..fc0bf6d7 100644
--- a/src/ip-pool.c
+++ b/src/ip-pool.c
@@ -148,13 +148,19 @@ int ip_pool_select_addr4(const char **addr_str_list, =
uint8_t subnet_prefix_len,
 		const struct ip_pool_addr4_record *rec =3D entry->data;
 		struct ip_pool_addr4_range *range;
 		char addr_str[INET_ADDRSTRLEN];
-		uint32_t used_subnet_size =3D 1 <<
-			(32 - l_rtnl_address_get_prefix_length(rec->addr));
-
-		if (!l_rtnl_address_get_address(rec->addr, addr_str) ||
+		uint8_t used_prefix_len =3D
+			l_rtnl_address_get_prefix_length(rec->addr);
+		uint32_t used_subnet_size;
+
+		if (l_rtnl_address_get_family(rec->addr) !=3D AF_INET ||
+				!l_rtnl_address_get_address(rec->addr,
+								addr_str) ||
+				used_prefix_len < 1 ||
 				inet_pton(AF_INET, addr_str, &ia) !=3D 1)
 			continue;
 =

+		used_subnet_size =3D 1 << (32 - used_prefix_len);
+
 		range =3D l_new(struct ip_pool_addr4_range, 1);
 		range->start =3D ntohl(ia.s_addr) & subnet_mask;
 		range->end =3D (range->start + used_subnet_size + subnet_size -
@@ -215,7 +221,7 @@ check_avail:
 	for (entry =3D l_queue_get_entries(ranges); entry; entry =3D entry->next)=
 {
 		struct ip_pool_addr4_range *range =3D entry->data;
 =

-	total +=3D (range->end - range->start) >>
+		total +=3D (range->end - range->start) >>
 			(32 - subnet_prefix_len);
 	}
 =

-- =

2.30.2

--===============4453690924447518025==--

