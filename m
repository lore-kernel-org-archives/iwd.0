Content-Type: multipart/mixed; boundary="===============0282836004817941445=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/7] ip-pool: Add subnet address selection logic
Date: Tue, 25 May 2021 14:55:03 +0200
Message-ID: <20210525125508.2695708-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210525125508.2695708-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0282836004817941445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the ip_pool_select_addr4 function to select a random subnet of requested
size from an address space defined by a string list (for use with the
AP profile [IPv4].Address and the global [IPv4].APAddressPool settings),
avoiding those subnets that conflict with subnets in use.  We take care
to give a similar weight to all subnets contained in the specified
ranges regardless of how many ranges contain each, basically so that
overlapping ranges don't affect the probabilities (debatable.)
---
 src/ip-pool.c | 207 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ip-pool.h |   2 +
 2 files changed, 209 insertions(+)

diff --git a/src/ip-pool.c b/src/ip-pool.c
index 1166383c..88428eb6 100644
--- a/src/ip-pool.c
+++ b/src/ip-pool.c
@@ -36,9 +36,216 @@
 #include "src/netdev.h"
 #include "src/ip-pool.h"
 =

+struct ip_pool_addr4_range {
+	uint32_t start;
+	uint32_t end;
+};
+
 static struct l_queue *used_addr4_list;
 static struct l_netlink *rtnl;
 =

+static int ip_pool_addr4_range_compare(const void *a, const void *b,
+					void *user_data)
+{
+	const struct ip_pool_addr4_range *range_a =3D a;
+	const struct ip_pool_addr4_range *range_b =3D b;
+
+	return range_a->start > range_b->start ? 1 : -1;
+}
+
+/*
+ * Append any address ranges within an input start/end range which contain
+ * at least one full subnet and don't intersect with any subnets already in
+ * use.  This may result in the input range being split into multiple rang=
es
+ * of different sizes or being skipped altogether.
+ * All inputs must be rounded to the subnet boundary and the @used queue
+ * sorted by the subnet start address.
+ */
+static void ip_pool_append_range(struct l_queue *to,
+					const struct ip_pool_addr4_range *range,
+					struct l_queue *used, const char *str)
+{
+	const struct l_queue_entry *entry =3D l_queue_get_entries(used);
+	const struct ip_pool_addr4_range *used_range =3D
+		entry ? entry->data : NULL;
+	uint32_t start =3D range->start;
+	bool print =3D true;
+
+	while (range->end > start) {
+		while (used_range && used_range->end <=3D start) {
+			entry =3D entry->next;
+			used_range =3D entry ? entry->data : NULL;
+		}
+
+		/* No more used ranges that intersect with @start/@range->end */
+		if (!used_range || range->end <=3D used_range->start) {
+			struct ip_pool_addr4_range *sub =3D
+				l_new(struct ip_pool_addr4_range, 1);
+
+			sub->start =3D start;
+			sub->end =3D range->end;
+			l_queue_push_tail(to, sub);
+			l_queue_insert(used, l_memdup(sub, sizeof(*sub)),
+					ip_pool_addr4_range_compare, NULL);
+			return;
+		}
+
+		if (print) {
+			l_debug("Address spec %s intersects with at least one "
+				"subnet already in use on the system or "
+				"specified in the settings", str);
+			print =3D false;
+		}
+
+		/* Now we know @used_range is non-NULL and intersects */
+		if (start < used_range->start) {
+			struct ip_pool_addr4_range *sub =3D
+				l_new(struct ip_pool_addr4_range, 1);
+
+			sub->start =3D start;
+			sub->end =3D used_range->start;
+			l_queue_push_tail(to, sub);
+			l_queue_insert(used, l_memdup(sub, sizeof(*sub)),
+					ip_pool_addr4_range_compare, NULL);
+		}
+
+		/* Skip to the start of the next subnet */
+		start =3D used_range->end;
+	}
+}
+
+/*
+ * Select a subnet and a host address from a defined space.
+ *
+ * Returns:  0 when an address was selected and written to *out_addr,
+ *          -EEXIST if all available subnet addresses are in use,
+ *          -EINVAL if there was a different error.
+ */
+int ip_pool_select_addr4(const char **addr_str_list, uint8_t prefix,
+				struct netdev *netdev, uint32_t *out_addr)
+{
+	uint32_t total =3D 0;
+	uint32_t selected;
+	unsigned int i;
+	uint32_t subnet_size =3D 1 << (32 - prefix);
+	uint32_t host_mask =3D subnet_size - 1;
+	uint32_t subnet_mask =3D ~host_mask;
+	uint32_t host_addr =3D 0;
+	struct l_queue *ranges =3D l_queue_new();
+	struct l_queue *used =3D l_queue_new();
+	struct in_addr ia;
+	const struct l_queue_entry *entry;
+	uint32_t ifindex =3D netdev ? netdev_get_ifindex(netdev) : 0;
+	int err =3D -EINVAL;
+
+	/* Build a sorted list of used/unavailable subnets */
+	for (entry =3D l_queue_get_entries((struct l_queue *) used_addr4_list);
+			entry; entry =3D entry->next) {
+		const struct ip_pool_addr4_record *rec =3D entry->data;
+		struct ip_pool_addr4_range *range;
+
+		/*
+		 * Don't add current subnets from the target interface to the used
+		 * subnet address list because we'll be replacing them (or adding
+		 * another secondary address) so there won't be a routing conflict.
+		 */
+		if (rec->ifindex =3D=3D ifindex)
+			continue;
+
+		if (!rec->addr || !rec->prefix_len)
+			continue;
+
+		range =3D l_new(struct ip_pool_addr4_range, 1);
+		range->start =3D rec->addr & subnet_mask;
+		range->end =3D (range->start + (1 << (32 - rec->prefix_len)) +
+				subnet_size - 1) & subnet_mask;
+		l_queue_insert(used, range, ip_pool_addr4_range_compare, NULL);
+	}
+
+	/* Build the list of available subnets */
+
+	/* Check for the static IP syntax: Address=3D<IP> */
+	if (l_strv_length((char **) addr_str_list) =3D=3D 1 &&
+			inet_pton(AF_INET, *addr_str_list, &ia) =3D=3D 1) {
+		struct ip_pool_addr4_range range;
+
+		host_addr =3D ntohl(ia.s_addr);
+		range.start =3D host_addr & subnet_mask;
+		range.end =3D range.start + subnet_size;
+		ip_pool_append_range(ranges, &range, used, *addr_str_list);
+		goto check_avail;
+	}
+
+	for (i =3D 0; addr_str_list[i]; i++) {
+		struct ip_pool_addr4_range range;
+		uint32_t addr;
+		uint8_t addr_prefix;
+
+		if (!util_ip_prefix_tohl(addr_str_list[i], &addr_prefix, &addr,
+						NULL, NULL)) {
+			l_error("Can't parse %s as a subnet address",
+				addr_str_list[i]);
+			goto cleanup;
+		}
+
+		if (addr_prefix > prefix) {
+			l_debug("Address spec %s smaller than requested "
+				"subnet (prefix len %i)", addr_str_list[i],
+				prefix);
+			continue;
+		}
+
+		range.start =3D addr & subnet_mask;
+		range.end =3D range.start + (1 << (32 - addr_prefix));
+		ip_pool_append_range(ranges, &range, used, addr_str_list[i]);
+	}
+
+check_avail:
+	if (l_queue_isempty(ranges)) {
+		l_error("No IP subnets available for new Access Point after "
+			"eliminating those already in use on the system");
+		err =3D -EEXIST;
+		goto cleanup;
+	}
+
+	if (host_addr)
+		goto done;
+
+	/* Count available @prefix-sized subnets */
+	for (entry =3D l_queue_get_entries(ranges); entry; entry =3D entry->next)=
 {
+		struct ip_pool_addr4_range *range =3D entry->data;
+
+		total +=3D (range->end - range->start) >> (32 - prefix);
+	}
+
+	selected =3D l_getrandom_uint32() % total;
+
+	/* Find the @selected'th @prefix-sized subnet */
+	for (entry =3D l_queue_get_entries(ranges);; entry =3D entry->next) {
+		struct ip_pool_addr4_range *range =3D entry->data;
+		uint32_t count =3D (range->end - range->start) >> (32 - prefix);
+
+		if (selected < count) {
+			host_addr =3D range->start + (selected << (32 - prefix));
+			break;
+		}
+
+		selected -=3D count;
+	}
+
+	if ((host_addr & 0xff) =3D=3D 0)
+		host_addr +=3D 1;
+
+done:
+	err =3D 0;
+	*out_addr =3D host_addr;
+
+cleanup:
+	l_queue_destroy(ranges, l_free);
+	l_queue_destroy(used, l_free);
+	return err;
+}
+
 static bool ip_pool_addr4_match_ifindex(const void *a, const void *b)
 {
 	const struct ip_pool_addr4_record *addr =3D a;
diff --git a/src/ip-pool.h b/src/ip-pool.h
index 6a220735..8c75d03e 100644
--- a/src/ip-pool.h
+++ b/src/ip-pool.h
@@ -29,4 +29,6 @@ struct ip_pool_addr4_record {
 	bool secondary;
 };
 =

+int ip_pool_select_addr4(const char **addr_str_list, uint8_t prefix,
+				struct netdev *netdev, uint32_t *out_addr);
 const struct ip_pool_addr4_record *ip_pool_get_addr4(struct netdev *netdev=
);
-- =

2.27.0

--===============0282836004817941445==--

