Content-Type: multipart/mixed; boundary="===============8563623056275264409=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 10/14] rtnlutil: Add IPv6 address change helpers
Date: Fri, 27 Sep 2019 17:12:29 -0700
Message-ID: <20190928001233.19217-10-tim.a.kourt@linux.intel.com>
In-Reply-To: <20190928001233.19217-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8563623056275264409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implements the IPv6 helper functions to add/delete IP addresses.
---
 src/rtnlutil.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/rtnlutil.h |  9 +++++++++
 2 files changed, 72 insertions(+)

diff --git a/src/rtnlutil.c b/src/rtnlutil.c
index 0cee5ff5..cca83a40 100644
--- a/src/rtnlutil.c
+++ b/src/rtnlutil.c
@@ -469,3 +469,66 @@ uint32_t rtnl_ifaddr_ipv6_get(struct l_netlink *rtnl,
 =

 	return id;
 }
+
+static uint32_t rtnl_ifaddr_ipv6_change(struct l_netlink *rtnl,
+					uint16_t nlmsg_type,
+					int ifindex, uint8_t prefix_len,
+					const char *ip,
+					l_netlink_command_func_t cb,
+					void *user_data,
+					l_netlink_destroy_func_t destroy)
+{
+	struct ifaddrmsg *rtmmsg;
+	struct in6_addr in6_addr;
+	void *rta_buf;
+	size_t bufsize;
+	uint32_t id;
+
+	bufsize =3D NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
+					RTA_SPACE(sizeof(struct in6_addr));
+
+	rtmmsg =3D l_malloc(bufsize);
+	memset(rtmmsg, 0, bufsize);
+
+	rtmmsg->ifa_index =3D ifindex;
+	rtmmsg->ifa_family =3D AF_INET6;
+	rtmmsg->ifa_flags =3D IFA_F_PERMANENT;
+	rtmmsg->ifa_scope =3D RT_SCOPE_UNIVERSE;
+	rtmmsg->ifa_prefixlen =3D prefix_len;
+
+	rta_buf =3D (void *) rtmmsg + NLMSG_ALIGN(sizeof(struct ifaddrmsg));
+
+	if (inet_pton(AF_INET6, ip, &in6_addr) < 1) {
+		l_free(rtmmsg);
+		return 0;
+	}
+
+	rta_buf +=3D rta_add_data(rta_buf, IFA_LOCAL, &in6_addr,
+						sizeof(struct in6_addr));
+
+	id =3D l_netlink_send(rtnl, nlmsg_type, 0, rtmmsg,
+						rta_buf - (void *) rtmmsg, cb,
+						user_data, destroy);
+	l_free(rtmmsg);
+
+	return id;
+}
+
+uint32_t rtnl_ifaddr_ipv6_add(struct l_netlink *rtnl, int ifindex,
+				uint8_t prefix_len, const char *ip,
+				l_netlink_command_func_t cb, void *user_data,
+				l_netlink_destroy_func_t destroy)
+{
+	return rtnl_ifaddr_ipv6_change(rtnl, RTM_NEWADDR, ifindex, prefix_len,
+						ip, cb, user_data, destroy);
+}
+
+uint32_t rtnl_ifaddr_ipv6_delete(struct l_netlink *rtnl, int ifindex,
+					uint8_t prefix_len, const char *ip,
+					l_netlink_command_func_t cb,
+					void *user_data,
+					l_netlink_destroy_func_t destroy)
+{
+	return rtnl_ifaddr_ipv6_change(rtnl, RTM_DELADDR, ifindex, prefix_len,
+						ip, cb, user_data, destroy);
+}
diff --git a/src/rtnlutil.h b/src/rtnlutil.h
index ff1427c5..5a901234 100644
--- a/src/rtnlutil.h
+++ b/src/rtnlutil.h
@@ -74,3 +74,12 @@ uint32_t rtnl_ifaddr_ipv6_get(struct l_netlink *rtnl,
 				l_netlink_command_func_t cb,
 				void *user_data,
 				l_netlink_destroy_func_t destroy);
+uint32_t rtnl_ifaddr_ipv6_add(struct l_netlink *rtnl, int ifindex,
+				uint8_t prefix_len, const char *ip,
+				l_netlink_command_func_t cb, void *user_data,
+				l_netlink_destroy_func_t destroy);
+uint32_t rtnl_ifaddr_ipv6_delete(struct l_netlink *rtnl, int ifindex,
+					uint8_t prefix_len, const char *ip,
+					l_netlink_command_func_t cb,
+					void *user_data,
+					l_netlink_destroy_func_t destroy);
-- =

2.13.6

--===============8563623056275264409==--

