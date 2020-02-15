Content-Type: multipart/mixed; boundary="===============7603512299177904087=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH 1/3] netdev: Use ell's rtnl APIs
Date: Sat, 15 Feb 2020 10:48:39 +0100
Message-ID: <20200215094841.28265-2-wagi@monom.org>
In-Reply-To: <20200215094841.28265-1-wagi@monom.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7603512299177904087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 1fbf3d3b89f3..f44c7ec215b4 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -341,7 +341,7 @@ int netdev_set_powered(struct netdev *netdev, bool powe=
red,
 		return -EBUSY;
 =

 	netdev->set_powered_cmd_id =3D
-		rtnl_set_powered(rtnl, netdev->index, powered,
+		l_rtnl_set_powered(rtnl, netdev->index, powered,
 					netdev_set_powered_result, netdev,
 					netdev_set_powered_destroy);
 	if (!netdev->set_powered_cmd_id)
@@ -632,7 +632,8 @@ static void netdev_shutdown_one(void *data, void *user_=
data)
 	struct netdev *netdev =3D data;
 =

 	if (netdev_get_is_up(netdev))
-		rtnl_set_powered(rtnl, netdev->index, false, NULL, NULL, NULL);
+		l_rtnl_set_powered(rtnl, netdev->index, false,
+					NULL, NULL, NULL);
 }
 =

 static bool netdev_match(const void *a, const void *b)
@@ -986,7 +987,7 @@ static void netdev_operstate_cb(int error, uint16_t typ=
e,
 =

 static void netdev_connect_ok(struct netdev *netdev)
 {
-	rtnl_set_linkmode_and_operstate(rtnl, netdev->index,
+	l_rtnl_set_linkmode_and_operstate(rtnl, netdev->index,
 					IF_LINK_MODE_DORMANT, IF_OPER_UP,
 					netdev_operstate_cb,
 					L_UINT_TO_PTR(netdev->index), NULL);
@@ -3817,7 +3818,7 @@ static void netdev_set_iftype_cb(struct l_genl_msg *m=
sg, void *user_data)
 		goto done;
 =

 	netdev->set_powered_cmd_id =3D
-			rtnl_set_powered(rtnl, netdev->index, true,
+			l_rtnl_set_powered(rtnl, netdev->index, true,
 					netdev_set_iftype_up_cb, req,
 					netdev_set_iftype_request_destroy);
 	if (!netdev->set_powered_cmd_id) {
@@ -3913,7 +3914,7 @@ int netdev_set_iftype(struct netdev *netdev, enum net=
dev_iftype type,
 		l_genl_msg_unref(msg);
 	} else {
 		netdev->set_powered_cmd_id =3D
-			rtnl_set_powered(rtnl, netdev->index, false,
+			l_rtnl_set_powered(rtnl, netdev->index, false,
 					netdev_set_iftype_down_cb, req,
 					netdev_set_iftype_request_destroy);
 		if (netdev->set_powered_cmd_id)
@@ -4116,7 +4117,7 @@ static void netdev_initial_up_cb(int error, uint16_t =
type, const void *data,
 			return;
 	}
 =

-	rtnl_set_linkmode_and_operstate(rtnl, netdev->index,
+	l_rtnl_set_linkmode_and_operstate(rtnl, netdev->index,
 					IF_LINK_MODE_DORMANT, IF_OPER_DOWN,
 					netdev_operstate_cb,
 					L_UINT_TO_PTR(netdev->index), NULL);
@@ -4146,7 +4147,7 @@ static void netdev_set_mac_cb(int error, uint16_t typ=
e, const void *data,
 			strerror(-error));
 =

 	netdev->set_powered_cmd_id =3D
-		rtnl_set_powered(rtnl, netdev->index, true,
+		l_rtnl_set_powered(rtnl, netdev->index, true,
 					netdev_initial_up_cb, netdev, NULL);
 }
 =

@@ -4158,7 +4159,7 @@ static bool netdev_check_set_mac(struct netdev *netde=
v)
 	l_debug("Setting initial address on ifindex: %d to: " MAC,
 		netdev->index, MAC_STR(netdev->set_mac_once));
 	netdev->set_powered_cmd_id =3D
-		rtnl_set_mac(rtnl, netdev->index, netdev->set_mac_once,
+		l_rtnl_set_mac(rtnl, netdev->index, netdev->set_mac_once,
 				netdev_set_mac_cb, netdev, NULL);
 	memset(netdev->set_mac_once, 0, 6);
 	return true;
@@ -4183,7 +4184,7 @@ static void netdev_initial_down_cb(int error, uint16_=
t type, const void *data,
 		return;
 =

 	netdev->set_powered_cmd_id =3D
-		rtnl_set_powered(rtnl, netdev->index, true,
+		l_rtnl_set_powered(rtnl, netdev->index, true,
 					netdev_initial_up_cb, netdev, NULL);
 }
 =

@@ -4228,7 +4229,7 @@ static void netdev_getlink_cb(int error, uint16_t typ=
e, const void *data,
 	cb =3D powered ? netdev_initial_down_cb : netdev_initial_up_cb;
 =

 	netdev->set_powered_cmd_id =3D
-		rtnl_set_powered(rtnl, ifi->ifi_index, !powered, cb, netdev,
+		l_rtnl_set_powered(rtnl, ifi->ifi_index, !powered, cb, netdev,
 					NULL);
 }
 =

-- =

2.25.0
--===============7603512299177904087==--

