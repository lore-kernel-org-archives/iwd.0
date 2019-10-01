Content-Type: multipart/mixed; boundary="===============3424170666260263247=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v3 1/5] netconfig: Subscribe for IPv6 address changes
Date: Tue, 01 Oct 2019 09:31:20 -0700
Message-ID: <20191001163124.1179-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3424170666260263247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The IPv6 addresses changes are maintained in ifaddr_list.
---
 src/netconfig.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 98 insertions(+), 7 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 4e294512..c9b0b66e 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -224,6 +224,23 @@ static char **netconfig_ipv4_get_dns(struct netconfig =
*netconfig, uint8_t proto)
 	return NULL;
 }
 =

+static bool netconfig_ifaddr_match(const void *a, const void *b)
+{
+	const struct netconfig_ifaddr *entry =3D a;
+	const struct netconfig_ifaddr *query =3D b;
+
+	if (entry->family !=3D query->family)
+		return false;
+
+	if (entry->prefix_len !=3D query->prefix_len)
+		return false;
+
+	if (strcmp(entry->ip, query->ip))
+		return false;
+
+	return true;
+}
+
 static struct netconfig_ifaddr *netconfig_ifaddr_find(
 					const struct netconfig *netconfig,
 					uint8_t family, uint8_t prefix_len,
@@ -276,22 +293,22 @@ static void netconfig_ifaddr_deleted(struct netconfig=
 *netconfig,
 					uint32_t len)
 {
 	struct netconfig_ifaddr *ifaddr;
-	char *ip;
+	struct netconfig_ifaddr query;
 =

-	rtnl_ifaddr_extract(ifa, len, NULL, &ip, NULL);
+	rtnl_ifaddr_extract(ifa, len, NULL, &query.ip, NULL);
 =

-	ifaddr =3D netconfig_ifaddr_find(netconfig, ifa->ifa_family,
-							ifa->ifa_prefixlen, ip);
+	query.family =3D ifa->ifa_family;
+	query.prefix_len =3D ifa->ifa_prefixlen;
 =

-	l_free(ip);
+	ifaddr =3D l_queue_remove_if(netconfig->ifaddr_list,
+						netconfig_ifaddr_match, &query);
+	l_free(query.ip);
 =

 	if (!ifaddr)
 		return;
 =

 	l_debug("ifaddr %s/%u", ifaddr->ip, ifaddr->prefix_len);
 =

-	l_queue_remove(netconfig->ifaddr_list, ifaddr);
-
 	netconfig_ifaddr_destroy(ifaddr);
 }
 =

@@ -335,6 +352,72 @@ static void netconfig_ifaddr_cmd_cb(int error, uint16_=
t type,
 	netconfig_ifaddr_notify(type, data, len, user_data);
 }
 =

+static void netconfig_ifaddr_ipv6_added(struct netconfig *netconfig,
+					const struct ifaddrmsg *ifa,
+					uint32_t len)
+{
+	struct netconfig_ifaddr *ifaddr;
+
+	ifaddr =3D l_new(struct netconfig_ifaddr, 1);
+	ifaddr->family =3D ifa->ifa_family;
+	ifaddr->prefix_len =3D ifa->ifa_prefixlen;
+
+	rtnl_ifaddr_ipv6_extract(ifa, len, &ifaddr->ip);
+
+	l_debug("ifindex %u: ifaddr %s/%u", netconfig->ifindex, ifaddr->ip,
+							ifaddr->prefix_len);
+
+	l_queue_push_tail(netconfig->ifaddr_list, ifaddr);
+}
+
+static void netconfig_ifaddr_ipv6_deleted(struct netconfig *netconfig,
+						const struct ifaddrmsg *ifa,
+						uint32_t len)
+{
+	struct netconfig_ifaddr *ifaddr;
+	char *ip;
+
+	rtnl_ifaddr_ipv6_extract(ifa, len, &ip);
+
+	ifaddr =3D netconfig_ifaddr_find(netconfig, ifa->ifa_family,
+							ifa->ifa_prefixlen, ip);
+
+	l_free(ip);
+
+	if (!ifaddr)
+		return;
+
+	l_debug("ifaddr %s/%u", ifaddr->ip, ifaddr->prefix_len);
+
+	l_queue_remove(netconfig->ifaddr_list, ifaddr);
+
+	netconfig_ifaddr_destroy(ifaddr);
+}
+
+static void netconfig_ifaddr_ipv6_notify(uint16_t type, const void *data,
+						uint32_t len, void *user_data)
+{
+	const struct ifaddrmsg *ifa =3D data;
+	struct netconfig *netconfig;
+	uint32_t bytes;
+
+	netconfig =3D netconfig_find(ifa->ifa_index);
+	if (!netconfig)
+		/* Ignore the interfaces which aren't managed by iwd. */
+		return;
+
+	bytes =3D len - NLMSG_ALIGN(sizeof(struct ifaddrmsg));
+
+	switch (type) {
+	case RTM_NEWADDR:
+		netconfig_ifaddr_ipv6_added(netconfig, ifa, bytes);
+		break;
+	case RTM_DELADDR:
+		netconfig_ifaddr_ipv6_deleted(netconfig, ifa, bytes);
+		break;
+	}
+}
+
 static void netconfig_route_cmd_cb(int error, uint16_t type,
 						const void *data, uint32_t len,
 						void *user_data)
@@ -757,6 +840,14 @@ static int netconfig_init(void)
 		goto error;
 	}
 =

+	r =3D l_netlink_register(rtnl, RTNLGRP_IPV6_IFADDR,
+				netconfig_ifaddr_ipv6_notify, NULL, NULL);
+	if (!r) {
+		l_error("netconfig: Failed to register for RTNL link IPv6 "
+					"address notifications.");
+		goto error;
+	}
+
 	if (!l_settings_get_uint(iwd_get_config(), "General",
 							"route_priority_offset",
 							&ROUTE_PRIORITY_OFFSET))
-- =

2.13.6

--===============3424170666260263247==--

