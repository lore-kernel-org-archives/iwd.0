Content-Type: multipart/mixed; boundary="===============7696394364732390935=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/4] rtnlutil: Add IPv6 route deletion helper
Date: Wed, 02 Oct 2019 13:39:56 -0700
Message-ID: <20191002203959.5582-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7696394364732390935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/rtnlutil.c | 31 +++++++++++++++++++++++++++++--
 src/rtnlutil.h |  7 +++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/src/rtnlutil.c b/src/rtnlutil.c
index 4090d311..f90e9dcf 100644
--- a/src/rtnlutil.c
+++ b/src/rtnlutil.c
@@ -533,7 +533,8 @@ uint32_t rtnl_ifaddr_ipv6_delete(struct l_netlink *rtnl=
, int ifindex,
 						ip, cb, user_data, destroy);
 }
 =

-uint32_t rtnl_route_ipv6_add_gateway(struct l_netlink *rtnl, int ifindex,
+static uint32_t rtnl_route_ipv6_change(struct l_netlink *rtnl,
+					uint16_t nlmsg_type, int ifindex,
 					const char *gateway,
 					uint32_t priority_offset,
 					uint8_t proto,
@@ -581,7 +582,33 @@ uint32_t rtnl_route_ipv6_add_gateway(struct l_netlink =
*rtnl, int ifindex,
 						sizeof(struct in6_addr));
 	}
 =

-	return l_netlink_send(rtnl, RTM_NEWROUTE, flags, rtmmsg,
+	return l_netlink_send(rtnl, nlmsg_type, flags, rtmmsg,
 				rta_buf - (void *) rtmmsg, cb, user_data,
 								destroy);
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
+	return rtnl_route_ipv6_change(rtnl, RTM_NEWROUTE, ifindex, gateway,
+					priority_offset, proto, cb,
+					user_data, destroy);
+}
+
+uint32_t rtnl_route_ipv6_delete_gateway(struct l_netlink *rtnl, int ifinde=
x,
+					const char *gateway,
+					uint32_t priority_offset,
+					uint8_t proto,
+					l_netlink_command_func_t cb,
+					void *user_data,
+					l_netlink_destroy_func_t destroy)
+{
+	return rtnl_route_ipv6_change(rtnl, RTM_DELROUTE, ifindex, gateway,
+					priority_offset, proto, cb,
+					user_data, destroy);
+}
diff --git a/src/rtnlutil.h b/src/rtnlutil.h
index 6689e16e..383d562f 100644
--- a/src/rtnlutil.h
+++ b/src/rtnlutil.h
@@ -90,3 +90,10 @@ uint32_t rtnl_route_ipv6_add_gateway(struct l_netlink *r=
tnl, int ifindex,
 					l_netlink_command_func_t cb,
 					void *user_data,
 					l_netlink_destroy_func_t destroy);
+uint32_t rtnl_route_ipv6_delete_gateway(struct l_netlink *rtnl, int ifinde=
x,
+					const char *gateway,
+					uint32_t priority_offset,
+					uint8_t proto,
+					l_netlink_command_func_t cb,
+					void *user_data,
+					l_netlink_destroy_func_t destroy);
-- =

2.13.6

--===============7696394364732390935==--

