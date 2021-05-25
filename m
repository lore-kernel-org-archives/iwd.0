Content-Type: multipart/mixed; boundary="===============6749990070484351935=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/7] ip-pool: Track IPv4 addresses in use
Date: Tue, 25 May 2021 14:55:02 +0200
Message-ID: <20210525125508.2695708-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6749990070484351935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the ip-pool submodule that tracks IPv4 addresses in use on the
system for use when selecting the address for a new AP.
---
 Makefile.am   |   1 +
 src/ip-pool.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ip-pool.h |  32 ++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 src/ip-pool.c
 create mode 100644 src/ip-pool.h

diff --git a/Makefile.am b/Makefile.am
index 68035e46..083bc95a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -243,6 +243,7 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.=
h src/missing.h \
 					src/eap-wsc.c src/eap-wsc.h \
 					src/wscutil.h src/wscutil.c \
 					src/diagnostic.h src/diagnostic.c \
+					src/ip-pool.h src/ip-pool.c \
 					$(eap_sources) \
 					$(builtin_sources)
 =

diff --git a/src/ip-pool.c b/src/ip-pool.c
new file mode 100644
index 00000000..1166383c
--- /dev/null
+++ b/src/ip-pool.c
@@ -0,0 +1,160 @@
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
+#include "src/iwd.h"
+#include "src/module.h"
+#include "src/netdev.h"
+#include "src/ip-pool.h"
+
+static struct l_queue *used_addr4_list;
+static struct l_netlink *rtnl;
+
+static bool ip_pool_addr4_match_ifindex(const void *a, const void *b)
+{
+	const struct ip_pool_addr4_record *addr =3D a;
+
+	return addr->ifindex =3D=3D L_PTR_TO_UINT(b) && !addr->secondary;
+}
+
+const struct ip_pool_addr4_record *ip_pool_get_addr4(struct netdev *netdev)
+{
+	return l_queue_find(used_addr4_list, ip_pool_addr4_match_ifindex,
+				L_UINT_TO_PTR(netdev_get_ifindex(netdev)));
+}
+
+static bool ip_pool_addr4_match_free(void *data, void *user_data)
+{
+	const struct ip_pool_addr4_record *a =3D data;
+	const struct ip_pool_addr4_record *b =3D user_data;
+
+	if (a->ifindex !=3D b->ifindex || a->addr !=3D b->addr ||
+			a->prefix_len !=3D b->prefix_len)
+		return false;
+
+	l_free(data);
+	return true;
+}
+
+static void ip_pool_addr_notify(uint16_t type, const void *data, uint32_t =
len,
+				void *user_data)
+{
+	const struct ifaddrmsg *ifa =3D data;
+	char *ip_str =3D NULL;
+	int r;
+	struct in_addr ip;
+
+	if (ifa->ifa_family !=3D AF_INET || ifa->ifa_prefixlen < 1)
+		return;
+
+	len -=3D NLMSG_ALIGN(sizeof(struct ifaddrmsg));
+
+	l_rtnl_ifaddr4_extract(ifa, len, NULL, &ip_str, NULL);
+	if (!ip_str)
+		return;
+
+	r =3D inet_aton(ip_str, &ip);
+	l_free(ip_str);
+
+	if (r < 0)
+		return;
+
+	if (type =3D=3D RTM_NEWADDR) {
+		struct ip_pool_addr4_record *addr;
+
+		addr =3D l_new(struct ip_pool_addr4_record, 1);
+		addr->addr =3D ntohl(ip.s_addr);
+		addr->prefix_len =3D ifa->ifa_prefixlen;
+		addr->ifindex =3D ifa->ifa_index;
+		addr->secondary =3D !!(ifa->ifa_flags & IFA_F_SECONDARY);
+		l_queue_push_tail(used_addr4_list, addr);
+	} else if (type =3D=3D RTM_DELADDR) {
+		struct ip_pool_addr4_record addr;
+
+		addr.addr =3D ntohl(ip.s_addr);
+		addr.prefix_len =3D ifa->ifa_prefixlen;
+		addr.ifindex =3D ifa->ifa_index;
+
+		l_queue_foreach_remove(used_addr4_list,
+					ip_pool_addr4_match_free, &addr);
+	}
+}
+
+static void ip_pool_addr4_dump_cb(int error,
+					uint16_t type, const void *data,
+					uint32_t len, void *user_data)
+{
+	if (error) {
+		l_error("addr4_dump_cb: %s (%i)", strerror(-error), -error);
+		return;
+	}
+
+	ip_pool_addr_notify(type, data, len, user_data);
+}
+
+static int ip_pool_init(void)
+{
+	const struct l_settings *settings =3D iwd_get_config();
+	bool netconfig_enabled;
+
+	if (!l_settings_get_bool(settings, "General",
+				"EnableNetworkConfiguration",
+				&netconfig_enabled))
+		netconfig_enabled =3D false;
+
+	if (!netconfig_enabled)
+		return 0;
+
+	rtnl =3D iwd_get_rtnl();
+
+	if (!l_netlink_register(rtnl, RTNLGRP_IPV4_IFADDR,
+				ip_pool_addr_notify, NULL, NULL)) {
+		l_error("Failed to register for RTNL link notifications");
+		return -EIO;
+	}
+
+	if (!l_rtnl_ifaddr4_dump(rtnl, ip_pool_addr4_dump_cb, NULL, NULL)) {
+		l_error("Sending the IPv4 addr dump req failed");
+		return -EIO;
+	}
+
+	used_addr4_list =3D l_queue_new();
+	return 0;
+}
+
+static void ip_pool_exit(void)
+{
+	l_queue_destroy(used_addr4_list, l_free);
+	used_addr4_list =3D NULL;
+}
+
+IWD_MODULE(ip_pool, ip_pool_init, ip_pool_exit)
diff --git a/src/ip-pool.h b/src/ip-pool.h
new file mode 100644
index 00000000..6a220735
--- /dev/null
+++ b/src/ip-pool.h
@@ -0,0 +1,32 @@
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
+struct netdev;
+
+struct ip_pool_addr4_record {
+	uint32_t addr;
+	uint8_t prefix_len;
+	uint32_t ifindex;
+	bool secondary;
+};
+
+const struct ip_pool_addr4_record *ip_pool_get_addr4(struct netdev *netdev=
);
-- =

2.27.0

--===============6749990070484351935==--

