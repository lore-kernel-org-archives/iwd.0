Content-Type: multipart/mixed; boundary="===============8995383738483116510=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] netconfig: Don't clear IPv6 addresses on shutdown
Date: Wed, 09 Oct 2019 15:43:33 -0700
Message-ID: <20191009224333.28884-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8995383738483116510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unlike IPv4, the IPv6 address are removed by the kernel.
---
 src/netconfig.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index c48e25b1..c4785fb6 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -1111,9 +1111,6 @@ void netconfig_destroy(struct netconfig *netconfig)
 	if (netconfig->rtm_protocol)
 		netconfig_ipv4_select_and_uninstall(netconfig);
 =

-	if (netconfig->rtm_v6_protocol)
-		netconfig_ipv6_select_and_uninstall(netconfig);
-
 	if (netconfig->rtm_protocol || netconfig->rtm_v6_protocol)
 		resolve_remove(netconfig->ifindex);
 =

-- =

2.13.6

--===============8995383738483116510==--

