Content-Type: multipart/mixed; boundary="===============6193864359871045621=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 01/14] netconfig: Rename netconfig destructor
Date: Fri, 27 Sep 2019 17:12:20 -0700
Message-ID: <20190928001233.19217-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6193864359871045621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The old name will be repurposed for the API.
---
 src/netconfig.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index fea322cd..25ac014a 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -83,7 +83,7 @@ static void netconfig_ifaddr_destroy(void *data)
 	l_free(ifaddr);
 }
 =

-static void netconfig_destroy(void *data)
+static void netconfig_free(void *data)
 {
 	struct netconfig *netconfig =3D data;
 =

@@ -750,7 +750,7 @@ bool netconfig_ifindex_remove(uint32_t ifindex)
 		resolve_remove(netconfig->ifindex);
 	}
 =

-	netconfig_destroy(netconfig);
+	netconfig_free(netconfig);
 =

 	return true;
 }
@@ -818,7 +818,7 @@ static void netconfig_exit(void)
 	l_netlink_destroy(rtnl);
 	rtnl =3D NULL;
 =

-	l_queue_destroy(netconfig_list, netconfig_destroy);
+	l_queue_destroy(netconfig_list, netconfig_free);
 }
 =

 IWD_MODULE(netconfig, netconfig_init, netconfig_exit)
-- =

2.13.6

--===============6193864359871045621==--

