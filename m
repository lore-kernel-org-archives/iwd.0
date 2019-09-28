Content-Type: multipart/mixed; boundary="===============5023411678786967578=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 12/14] rtnlutil: Add IPv6 default route helper
Date: Fri, 27 Sep 2019 17:12:31 -0700
Message-ID: <20190928001233.19217-12-tim.a.kourt@linux.intel.com>
In-Reply-To: <20190928001233.19217-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5023411678786967578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/rtnlutil.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/rtnlutil.h |  7 +++++++
 2 files changed, 60 insertions(+)

diff --git a/src/rtnlutil.c b/src/rtnlutil.c
index cca83a40..4090d311 100644
--- a/src/rtnlutil.c
+++ b/src/rtnlutil.c
@@ -532,3 +532,56 @@ uint32_t rtnl_ifaddr_ipv6_delete(struct l_netlink *rtn=
l, int ifindex,
 	return rtnl_ifaddr_ipv6_change(rtnl, RTM_DELADDR, ifindex, prefix_len,
 						ip, cb, user_data, destroy);
 }
+
+uint32_t rtnl_route_ipv6_add_gateway(struct l_netlink *rtnl, int ifindex,
+					const char *gateway,
+					uint32_t priority_offset,
+					uint8_t proto,
+					l_netlink_command_func_t cb,
+					void *user_data,
+					l_netlink_destroy_func_t destroy)
+{
+	L_AUTO_FREE_VAR(struct rtmsg *, rtmmsg) =3D NULL;
+	struct in6_addr in6_addr;
+	size_t bufsize;
+	void *rta_buf;
+	uint16_t flags;
+
+	if (!gateway)
+		return 0;
+
+	bufsize =3D NLMSG_ALIGN(sizeof(struct rtmsg)) +
+			RTA_SPACE(sizeof(uint32_t)) +
+			(priority_offset ? RTA_SPACE(sizeof(uint32_t)) : 0) +
+			(gateway ? RTA_SPACE(sizeof(struct in6_addr)) : 0);
+
+	rtmmsg =3D l_malloc(bufsize);
+	memset(rtmmsg, 0, bufsize);
+
+	rtmmsg->rtm_family =3D AF_INET6;
+	rtmmsg->rtm_table =3D RT_TABLE_MAIN;
+	rtmmsg->rtm_protocol =3D proto;
+	rtmmsg->rtm_type =3D RTN_UNICAST;
+	rtmmsg->rtm_scope =3D RT_SCOPE_UNIVERSE;
+
+	flags =3D NLM_F_CREATE | NLM_F_REPLACE;
+
+	rta_buf =3D (void *) rtmmsg + NLMSG_ALIGN(sizeof(struct rtmsg));
+	rta_buf +=3D rta_add_u32(rta_buf, RTA_OIF, ifindex);
+
+	if (priority_offset)
+		rta_buf +=3D rta_add_u32(rta_buf, RTA_PRIORITY,
+						priority_offset + ifindex);
+
+	if (gateway) {
+		if (inet_pton(AF_INET6, gateway, &in6_addr) < 1)
+			return 0;
+
+		rta_buf +=3D rta_add_data(rta_buf, RTA_GATEWAY, &in6_addr,
+						sizeof(struct in6_addr));
+	}
+
+	return l_netlink_send(rtnl, RTM_NEWROUTE, flags, rtmmsg,
+				rta_buf - (void *) rtmmsg, cb, user_data,
+								destroy);
+}
diff --git a/src/rtnlutil.h b/src/rtnlutil.h
index 5a901234..6689e16e 100644
--- a/src/rtnlutil.h
+++ b/src/rtnlutil.h
@@ -83,3 +83,10 @@ uint32_t rtnl_ifaddr_ipv6_delete(struct l_netlink *rtnl,=
 int ifindex,
 					l_netlink_command_func_t cb,
 					void *user_data,
 					l_netlink_destroy_func_t destroy);
+uint32_t rtnl_route_ipv6_add_gateway(struct l_netlink *rtnl, int ifindex,
+					const char *gateway,
+					uint32_t priority_offset,
+					uint8_t proto,
+					l_netlink_command_func_t cb,
+					void *user_data,
+					l_netlink_destroy_func_t destroy);
-- =

2.13.6

--===============5023411678786967578==--

