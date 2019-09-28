Content-Type: multipart/mixed; boundary="===============6372070458804980951=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 08/14] rtnlutil: Add IPv6 address dump
Date: Fri, 27 Sep 2019 17:12:27 -0700
Message-ID: <20190928001233.19217-8-tim.a.kourt@linux.intel.com>
In-Reply-To: <20190928001233.19217-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6372070458804980951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/rtnlutil.c | 21 +++++++++++++++++++++
 src/rtnlutil.h |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/src/rtnlutil.c b/src/rtnlutil.c
index b1d6450e..0cee5ff5 100644
--- a/src/rtnlutil.c
+++ b/src/rtnlutil.c
@@ -448,3 +448,24 @@ void rtnl_ifaddr_ipv6_extract(const struct ifaddrmsg *=
ifa, int len, char **ip)
 		}
 	}
 }
+
+uint32_t rtnl_ifaddr_ipv6_get(struct l_netlink *rtnl,
+				l_netlink_command_func_t cb, void *user_data,
+				l_netlink_destroy_func_t destroy)
+{
+	struct ifaddrmsg *rtmmsg;
+	uint32_t id;
+
+	rtmmsg =3D l_malloc(sizeof(struct ifaddrmsg));
+	memset(rtmmsg, 0, sizeof(struct ifaddrmsg));
+
+	rtmmsg->ifa_family =3D AF_INET6;
+
+	id =3D l_netlink_send(rtnl, RTM_GETADDR, NLM_F_DUMP, rtmmsg,
+				sizeof(struct ifaddrmsg), cb, user_data,
+				destroy);
+
+	l_free(rtmmsg);
+
+	return id;
+}
diff --git a/src/rtnlutil.h b/src/rtnlutil.h
index 8c0a923d..ff1427c5 100644
--- a/src/rtnlutil.h
+++ b/src/rtnlutil.h
@@ -70,3 +70,7 @@ uint32_t rtnl_route_ipv4_add_gateway(struct l_netlink *rt=
nl, int ifindex,
 =

 void rtnl_ifaddr_ipv6_extract(const struct ifaddrmsg *ifa, int bytes,
 								char **ip);
+uint32_t rtnl_ifaddr_ipv6_get(struct l_netlink *rtnl,
+				l_netlink_command_func_t cb,
+				void *user_data,
+				l_netlink_destroy_func_t destroy);
-- =

2.13.6

--===============6372070458804980951==--

