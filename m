Content-Type: multipart/mixed; boundary="===============4471424450906664411=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: update use of l_rtnl_set_mac
Date: Wed, 11 Mar 2020 18:52:51 -0400
Message-ID: <20200311225251.1322818-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4471424450906664411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This API was updated to take an extra boolean which will
automatically power up the device while changing the MAC
address. Since this is what IWD does anyways we can avoid
the need for an intermediate callback and go right into
netdev_initial_up_cb.
---
 src/netdev.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 846f7b07..35f2d7f0 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4137,20 +4137,6 @@ static void netdev_initial_up_cb(int error, uint16_t=
 type, const void *data,
 	netdev->events_ready =3D true;
 }
 =

-static void netdev_set_mac_cb(int error, uint16_t type, const void *data,
-					uint32_t len, void *user_data)
-{
-	struct netdev *netdev =3D user_data;
-
-	if (error)
-		l_error("Error setting mac address on %d: %s", netdev->index,
-			strerror(-error));
-
-	netdev->set_powered_cmd_id =3D
-		l_rtnl_set_powered(rtnl, netdev->index, true,
-					netdev_initial_up_cb, netdev, NULL);
-}
-
 static bool netdev_check_set_mac(struct netdev *netdev)
 {
 	if (util_mem_is_zero(netdev->set_mac_once, 6))
@@ -4159,8 +4145,8 @@ static bool netdev_check_set_mac(struct netdev *netde=
v)
 	l_debug("Setting initial address on ifindex: %d to: " MAC,
 		netdev->index, MAC_STR(netdev->set_mac_once));
 	netdev->set_powered_cmd_id =3D
-		l_rtnl_set_mac(rtnl, netdev->index, netdev->set_mac_once,
-				netdev_set_mac_cb, netdev, NULL);
+		l_rtnl_set_mac(rtnl, netdev->index, netdev->set_mac_once, true,
+				netdev_initial_up_cb, netdev, NULL);
 	memset(netdev->set_mac_once, 0, 6);
 	return true;
 }
-- =

2.24.1

--===============4471424450906664411==--

