Content-Type: multipart/mixed; boundary="===============7818124010909176199=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 3/4] netconfig: Optimize IPv4 address deletion
Date: Wed, 02 Oct 2019 13:39:58 -0700
Message-ID: <20191002203959.5582-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191002203959.5582-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7818124010909176199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Decrease the queue traversals to a single pass
---
 src/netconfig.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index cf951245..2175d9be 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -427,22 +427,22 @@ static void netconfig_ifaddr_deleted(struct netconfig=
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

-- =

2.13.6

--===============7818124010909176199==--

