Content-Type: multipart/mixed; boundary="===============7806812128894005382=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 11/15] p2p: Set Linkmode/operstate on GO connection
Date: Fri, 04 Jun 2021 03:50:48 +0200
Message-ID: <20210604015052.163727-11-andrew.zaborowski@intel.com>
In-Reply-To: <20210604015052.163727-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7806812128894005382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2p.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index c7c8d785..cb6cd98b 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -34,6 +34,7 @@
 #include <errno.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
+#include <linux/if.h>
 =

 #include <ell/ell.h>
 =

@@ -977,6 +978,11 @@ static void p2p_group_event(enum ap_event_type type, c=
onst void *event_data,
 		if (dev->conn_peer_added)
 			break;
 =

+		l_rtnl_set_linkmode_and_operstate(iwd_get_rtnl(),
+					netdev_get_ifindex(dev->conn_netdev),
+					IF_LINK_MODE_DEFAULT, IF_OPER_UP,
+					NULL, NULL, NULL);
+
 		dev->conn_peer_added =3D true;
 		dev->conn_peer_ip =3D l_dhcp_lease_get_address(lease);
 		l_timeout_remove(dev->conn_dhcp_timeout);
-- =

2.30.2

--===============7806812128894005382==--

