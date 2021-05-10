Content-Type: multipart/mixed; boundary="===============4646196445836427360=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/11] ap: Add subnet address selection logic
Date: Mon, 10 May 2021 10:57:59 +0200
Message-ID: <20210510085806.174213-4-andrew.zaborowski@intel.com>
In-Reply-To: <20210510085806.174213-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4646196445836427360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the ap_select_addr4 function to select a random subnet of requested
size from an address space defined by a string list (for use with the
AP profile [IPv4].Address and the global [IPv4].APAddressPool settings),
avoiding those subnets that conflict with subnets from a second list.
We take care to give a similar weight to all subnets contained in the
specified ranges regardless of how many ranges contain each, basically
so that overlapping ranges don't affect the probabilities (debatable.)

This is added as src/ap-addr.c so that it's self-contained.
---
 Makefile.am   |   3 +-
 src/ap-addr.c | 231 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ap.h      |   9 ++
 3 files changed, 242 insertions(+), 1 deletion(-)
 create mode 100644 src/ap-addr.c

diff --git a/Makefile.am b/Makefile.am
index 68035e46..631ab710 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -220,7 +220,8 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.=
h src/missing.h \
 					src/knownnetworks.c \
 					src/rfkill.h src/rfkill.c \
 					src/ft.h src/ft.c \
-					src/ap.h src/ap.c src/adhoc.c \
+					src/ap.h src/ap.c src/ap-addr.c \
+					src/adhoc.c \
 					src/sae.h src/sae.c \
 					src/nl80211util.h src/nl80211util.c \
 					src/nl80211cmd.h src/nl80211cmd.c \
diff --git a/src/ap-addr.c b/src/ap-addr.c
new file mode 100644
index 00000000..5d911956
--- /dev/null
+++ b/src/ap-addr.c
@@ -0,0 +1,231 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2021  Intel Corporation. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+
+#include <ell/ell.h>
+
+#include "src/util.h"
+#include "src/mpdu.h"
+#include "src/wscutil.h"
+#include "src/netdev.h"
+#include "src/ap.h"
+
+struct ap_ip_range {
+	uint32_t start;
+	uint32_t end;
+};
+
+static int ap_ip_range_compare(const void *a, const void *b, void *user_da=
ta)
+{
+	const struct ap_ip_range *range_a =3D a;
+	const struct ap_ip_range *range_b =3D b;
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
+static void ap_append_range(struct l_queue *to, const struct ap_ip_range *=
range,
+				struct l_queue *used, const char *str)
+{
+	const struct l_queue_entry *entry =3D l_queue_get_entries(used);
+	const struct ap_ip_range *used_range =3D entry ? entry->data : NULL;
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
+			struct ap_ip_range *sub =3D l_new(struct ap_ip_range, 1);
+
+			sub->start =3D start;
+			sub->end =3D range->end;
+			l_queue_push_tail(to, sub);
+			l_queue_insert(used, l_memdup(sub, sizeof(*sub)),
+					ap_ip_range_compare, NULL);
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
+			struct ap_ip_range *sub =3D l_new(struct ap_ip_range, 1);
+
+			sub->start =3D start;
+			sub->end =3D used_range->start;
+			l_queue_push_tail(to, sub);
+			l_queue_insert(used, l_memdup(sub, sizeof(*sub)),
+					ap_ip_range_compare, NULL);
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
+int ap_select_addr4(const char **addr_str_list, uint8_t prefix,
+			const struct l_queue *used_addr_dump,
+			uint32_t *out_addr)
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
+	int err =3D -EINVAL;
+
+	/* Build a sorted list of used/unavailable subnets */
+	for (entry =3D l_queue_get_entries((struct l_queue *) used_addr_dump);
+			entry; entry =3D entry->next) {
+		const struct ap_rtnl_addr4_record *rec =3D entry->data;
+		struct ap_ip_range *range;
+
+		if (!rec->addr || !rec->prefix_len)
+			continue;
+
+		range =3D l_new(struct ap_ip_range, 1);
+		range->start =3D rec->addr & subnet_mask;
+		range->end =3D (range->start + (1 << (32 - rec->prefix_len)) +
+				subnet_size - 1) & subnet_mask;
+		l_queue_insert(used, range, ap_ip_range_compare, NULL);
+	}
+
+	/* Build the list of available subnets */
+
+	/* Check for the static IP syntax: Address=3D<IP> */
+	if (l_strv_length((char **) addr_str_list) =3D=3D 1 &&
+			inet_pton(AF_INET, *addr_str_list, &ia) =3D=3D 1) {
+		struct ap_ip_range range;
+
+		host_addr =3D ntohl(ia.s_addr);
+		range.start =3D host_addr & subnet_mask;
+		range.end =3D range.start + subnet_size;
+		ap_append_range(ranges, &range, used, *addr_str_list);
+		goto check_avail;
+	}
+
+	for (i =3D 0; addr_str_list[i]; i++) {
+		struct ap_ip_range range;
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
+		ap_append_range(ranges, &range, used, addr_str_list[i]);
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
+		struct ap_ip_range *range =3D entry->data;
+
+		total +=3D (range->end - range->start) >> (32 - prefix);
+	}
+
+	selected =3D l_getrandom_uint32() % total;
+
+	/* Find the @selected'th @prefix-sized subnet */
+	for (entry =3D l_queue_get_entries(ranges);; entry =3D entry->next) {
+		struct ap_ip_range *range =3D entry->data;
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
diff --git a/src/ap.h b/src/ap.h
index b0100f34..2163d2db 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -97,3 +97,12 @@ bool ap_station_disconnect(struct ap_state *ap, const ui=
nt8_t *mac,
 =

 bool ap_push_button(struct ap_state *ap);
 void ap_update_beacon(struct ap_state *ap);
+
+struct ap_rtnl_addr4_record {
+	uint32_t addr;
+	uint8_t prefix_len;
+};
+
+int ap_select_addr4(const char **addr_str_list, uint8_t prefix,
+			const struct l_queue *used_addr_dump,
+			uint32_t *out_addr);
-- =

2.27.0

--===============4646196445836427360==--

