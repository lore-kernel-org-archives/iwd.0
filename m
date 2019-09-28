Content-Type: multipart/mixed; boundary="===============5633635031949197589=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 06/14] rtnlutil: Add parser for IPv6 RTNL packet
Date: Fri, 27 Sep 2019 17:12:25 -0700
Message-ID: <20190928001233.19217-6-tim.a.kourt@linux.intel.com>
In-Reply-To: <20190928001233.19217-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5633635031949197589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

At this time, we are only looking for IFA_ADDRESS attribute that
represents the IPv6 IP address.
---
 src/rtnlutil.c | 30 ++++++++++++++++++++++++++++++
 src/rtnlutil.h |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/src/rtnlutil.c b/src/rtnlutil.c
index d20b3284..b1d6450e 100644
--- a/src/rtnlutil.c
+++ b/src/rtnlutil.c
@@ -418,3 +418,33 @@ uint32_t rtnl_route_ipv4_add_gateway(struct l_netlink =
*rtnl, int ifindex,
 				gateway, src, priority_offset, proto, cb,
 				user_data, destroy);
 }
+
+void rtnl_ifaddr_ipv6_extract(const struct ifaddrmsg *ifa, int len, char *=
*ip)
+{
+	struct in6_addr in6_addr;
+	struct rtattr *attr;
+	char address[128];
+
+	for (attr =3D IFA_RTA(ifa); RTA_OK(attr, len);
+						attr =3D RTA_NEXT(attr, len)) {
+		switch (attr->rta_type) {
+		case IFA_ADDRESS:
+			if (!ip)
+				break;
+
+			memcpy(&in6_addr.s6_addr, RTA_DATA(attr),
+						sizeof(in6_addr.s6_addr));
+
+			if (!inet_ntop(AF_INET6, &in6_addr, address,
+							INET6_ADDRSTRLEN)) {
+
+				l_error("rtnl: Failed to extract IPv6 address");
+				break;
+			}
+
+			*ip =3D l_strdup(address);
+
+			break;
+		}
+	}
+}
diff --git a/src/rtnlutil.h b/src/rtnlutil.h
index b159d959..8c0a923d 100644
--- a/src/rtnlutil.h
+++ b/src/rtnlutil.h
@@ -67,3 +67,6 @@ uint32_t rtnl_route_ipv4_add_gateway(struct l_netlink *rt=
nl, int ifindex,
 					l_netlink_command_func_t cb,
 					void *user_data,
 					l_netlink_destroy_func_t destroy);
+
+void rtnl_ifaddr_ipv6_extract(const struct ifaddrmsg *ifa, int bytes,
+								char **ip);
-- =

2.13.6

--===============5633635031949197589==--

