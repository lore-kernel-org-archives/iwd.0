Content-Type: multipart/mixed; boundary="===============7496565854551527524=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/6] rtnlutil: Move rtnl_set_powered from netdev to rtnlutil
Date: Wed, 20 Nov 2019 23:23:44 +0100
Message-ID: <20191120222346.7881-4-andrew.zaborowski@intel.com>
In-Reply-To: <20191120222346.7881-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7496565854551527524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This function fits with the other utilities in rtnlutil and netdev.c
can slim down.
---
 src/netdev.c   | 46 ++++++++++++----------------------------------
 src/rtnlutil.c | 26 ++++++++++++++++++++++++++
 src/rtnlutil.h |  4 ++++
 3 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 3c1510b9..bdd9dc77 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -343,31 +343,6 @@ static void netdev_set_powered_destroy(void *user_data)
 	netdev->set_powered_user_data =3D NULL;
 }
 =

-static uint32_t rtnl_set_powered(int ifindex, bool powered,
-				l_netlink_command_func_t cb, void *user_data,
-				l_netlink_destroy_func_t destroy)
-{
-	struct ifinfomsg *rtmmsg;
-	size_t bufsize;
-	uint32_t id;
-
-	bufsize =3D NLMSG_ALIGN(sizeof(struct ifinfomsg));
-
-	rtmmsg =3D l_malloc(bufsize);
-	memset(rtmmsg, 0, bufsize);
-
-	rtmmsg->ifi_family =3D AF_UNSPEC;
-	rtmmsg->ifi_index =3D ifindex;
-	rtmmsg->ifi_change =3D IFF_UP;
-	rtmmsg->ifi_flags =3D powered ? IFF_UP : 0;
-
-	id =3D l_netlink_send(rtnl, RTM_SETLINK, 0, rtmmsg, bufsize,
-					cb, user_data, destroy);
-
-	l_free(rtmmsg);
-	return id;
-}
-
 int netdev_set_powered(struct netdev *netdev, bool powered,
 			netdev_command_cb_t callback, void *user_data,
 			netdev_destroy_func_t destroy)
@@ -377,7 +352,7 @@ int netdev_set_powered(struct netdev *netdev, bool powe=
red,
 		return -EBUSY;
 =

 	netdev->set_powered_cmd_id =3D
-		rtnl_set_powered(netdev->index, powered,
+		rtnl_set_powered(rtnl, netdev->index, powered,
 					netdev_set_powered_result, netdev,
 					netdev_set_powered_destroy);
 	if (!netdev->set_powered_cmd_id)
@@ -667,7 +642,7 @@ static void netdev_shutdown_one(void *data, void *user_=
data)
 	struct netdev *netdev =3D data;
 =

 	if (netdev_get_is_up(netdev))
-		rtnl_set_powered(netdev->index, false, NULL, NULL, NULL);
+		rtnl_set_powered(rtnl, netdev->index, false, NULL, NULL, NULL);
 }
 =

 static bool netdev_match(const void *a, const void *b)
@@ -3949,7 +3924,7 @@ static void netdev_set_iftype_cb(struct l_genl_msg *m=
sg, void *user_data)
 		goto done;
 =

 	netdev->set_powered_cmd_id =3D
-			rtnl_set_powered(netdev->index, true,
+			rtnl_set_powered(rtnl, netdev->index, true,
 					netdev_set_iftype_up_cb, req,
 					netdev_set_iftype_request_destroy);
 	if (!netdev->set_powered_cmd_id) {
@@ -4045,7 +4020,7 @@ int netdev_set_iftype(struct netdev *netdev, enum net=
dev_iftype type,
 		l_genl_msg_unref(msg);
 	} else {
 		netdev->set_powered_cmd_id =3D
-			rtnl_set_powered(netdev->index, false,
+			rtnl_set_powered(rtnl, netdev->index, false,
 					netdev_set_iftype_down_cb, req,
 					netdev_set_iftype_request_destroy);
 		if (netdev->set_powered_cmd_id)
@@ -4276,8 +4251,8 @@ static void netdev_set_mac_cb(int error, uint16_t typ=
e, const void *data,
 			strerror(-error));
 =

 	netdev->set_powered_cmd_id =3D
-		rtnl_set_powered(netdev->index, true, netdev_initial_up_cb,
-					netdev, NULL);
+		rtnl_set_powered(rtnl, netdev->index, true,
+					netdev_initial_up_cb, netdev, NULL);
 }
 =

 static void netdev_initial_down_cb(int error, uint16_t type, const void *d=
ata,
@@ -4308,8 +4283,8 @@ static void netdev_initial_down_cb(int error, uint16_=
t type, const void *data,
 	}
 =

 	netdev->set_powered_cmd_id =3D
-		rtnl_set_powered(netdev->index, true, netdev_initial_up_cb,
-					netdev, NULL);
+		rtnl_set_powered(rtnl, netdev->index, true,
+					netdev_initial_up_cb, netdev, NULL);
 }
 =

 static void netdev_getlink_cb(int error, uint16_t type, const void *data,
@@ -4367,7 +4342,8 @@ static void netdev_getlink_cb(int error, uint16_t typ=
e, const void *data,
 	cb =3D powered ? netdev_initial_down_cb : netdev_initial_up_cb;
 =

 	netdev->set_powered_cmd_id =3D
-		rtnl_set_powered(ifi->ifi_index, !powered, cb, netdev, NULL);
+		rtnl_set_powered(rtnl, ifi->ifi_index, !powered, cb, netdev,
+					NULL);
 }
 =

 static void netdev_frame_watch_free(struct watchlist_item *item)
@@ -4729,6 +4705,8 @@ static void netdev_link_notify(uint16_t type, const v=
oid *data, uint32_t len,
 	if (ifi->ifi_type !=3D ARPHRD_ETHER)
 		return;
 =

+	l_debug("event %u on ifindex %u", type, ifi->ifi_index);
+
 	bytes =3D len - NLMSG_ALIGN(sizeof(struct ifinfomsg));
 =

 	switch (type) {
diff --git a/src/rtnlutil.c b/src/rtnlutil.c
index 833f7103..cd5c11a0 100644
--- a/src/rtnlutil.c
+++ b/src/rtnlutil.c
@@ -25,6 +25,7 @@
 #endif
 =

 #include <sys/socket.h>
+#include <linux/if.h>
 #include <linux/rtnetlink.h>
 #include <arpa/inet.h>
 =

@@ -130,6 +131,31 @@ uint32_t rtnl_set_mac(struct l_netlink *rtnl, int ifin=
dex,
 	return id;
 }
 =

+uint32_t rtnl_set_powered(struct l_netlink *rtnl, int ifindex, bool powere=
d,
+				l_netlink_command_func_t cb, void *user_data,
+				l_netlink_destroy_func_t destroy)
+{
+	struct ifinfomsg *rtmmsg;
+	size_t bufsize;
+	uint32_t id;
+
+	bufsize =3D NLMSG_ALIGN(sizeof(struct ifinfomsg));
+
+	rtmmsg =3D l_malloc(bufsize);
+	memset(rtmmsg, 0, bufsize);
+
+	rtmmsg->ifi_family =3D AF_UNSPEC;
+	rtmmsg->ifi_index =3D ifindex;
+	rtmmsg->ifi_change =3D IFF_UP;
+	rtmmsg->ifi_flags =3D powered ? IFF_UP : 0;
+
+	id =3D l_netlink_send(rtnl, RTM_SETLINK, 0, rtmmsg, bufsize,
+					cb, user_data, destroy);
+	l_free(rtmmsg);
+
+	return id;
+}
+
 void rtnl_ifaddr_extract(const struct ifaddrmsg *ifa, int bytes,
 				char **label, char **ip, char **broadcast)
 {
diff --git a/src/rtnlutil.h b/src/rtnlutil.h
index 383d562f..dc053783 100644
--- a/src/rtnlutil.h
+++ b/src/rtnlutil.h
@@ -32,6 +32,10 @@ uint32_t rtnl_set_mac(struct l_netlink *rtnl, int ifinde=
x,
 					void *user_data,
 					l_netlink_destroy_func_t destroy);
 =

+uint32_t rtnl_set_powered(struct l_netlink *rtnl, int ifindex, bool powere=
d,
+				l_netlink_command_func_t cb, void *user_data,
+				l_netlink_destroy_func_t destroy);
+
 void rtnl_ifaddr_extract(const struct ifaddrmsg *ifa, int bytes,
 				char **label, char **ip, char **broadcast);
 uint32_t rtnl_ifaddr_get(struct l_netlink *rtnl, l_netlink_command_func_t =
cb,
-- =

2.20.1

--===============7496565854551527524==--

