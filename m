Content-Type: multipart/mixed; boundary="===============3145855373267195637=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/4] netdev: Replace bool randomize_mac with specific address
Date: Thu, 19 Dec 2019 04:50:56 +0100
Message-ID: <20191219035059.15214-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3145855373267195637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow netdev_create_from_genl callers to draw a random or non-random MAC
and pass it in the parameter instead of a bool to tell us to generating
the MAC locally.  In P2P we are generating the MAC some time before
creating the netdev in order to pass it to the peer during negotiation.
---
 src/manager.c | 22 ++++++++++++++++++----
 src/netdev.c  | 45 ++++++++++++++++++++++-----------------------
 src/netdev.h  |  3 ++-
 3 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 47874e11..4ad0f03c 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -102,6 +102,9 @@ static void wiphy_setup_state_destroy(struct wiphy_setu=
p_state *state)
 =

 static bool manager_use_default(struct wiphy_setup_state *state)
 {
+	uint8_t addr_buf[6];
+	uint8_t *addr =3D NULL;
+
 	l_debug("");
 =

 	if (!state->default_if_msg) {
@@ -110,13 +113,20 @@ static bool manager_use_default(struct wiphy_setup_st=
ate *state)
 		return false;
 	}
 =

-	netdev_create_from_genl(state->default_if_msg, randomize);
+	if (randomize) {
+		wiphy_generate_random_address(state->wiphy, addr_buf);
+		addr =3D addr_buf;
+	}
+
+	netdev_create_from_genl(state->default_if_msg, addr);
 	return true;
 }
 =

 static void manager_new_interface_cb(struct l_genl_msg *msg, void *user_da=
ta)
 {
 	struct wiphy_setup_state *state =3D user_data;
+	uint8_t addr_buf[6];
+	uint8_t *addr =3D NULL;
 =

 	l_debug("");
 =

@@ -134,9 +144,13 @@ static void manager_new_interface_cb(struct l_genl_msg=
 *msg, void *user_data)
 		return;
 	}
 =

-	netdev_create_from_genl(msg, randomize &&
-					!wiphy_has_feature(state->wiphy,
-						NL80211_FEATURE_MAC_ON_CREATE));
+	if (randomize && !wiphy_has_feature(state->wiphy,
+					NL80211_FEATURE_MAC_ON_CREATE)) {
+		wiphy_generate_random_address(state->wiphy, addr_buf);
+		addr =3D addr_buf;
+	}
+
+	netdev_create_from_genl(msg, addr);
 }
 =

 static void manager_new_interface_done(void *user_data)
diff --git a/src/netdev.c b/src/netdev.c
index 46c79fb0..77668151 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -125,6 +125,7 @@ struct netdev {
 	int8_t cur_rssi;
 	struct l_timeout *rssi_poll_timeout;
 	uint32_t rssi_poll_cmd_id;
+	uint8_t set_mac_once[6];
 =

 	uint32_t set_powered_cmd_id;
 	netdev_command_cb_t set_powered_cb;
@@ -147,7 +148,6 @@ struct netdev {
 	bool ignore_connect_event : 1;
 	bool expect_connect_failure : 1;
 	bool aborting : 1;
-	bool mac_randomize_once : 1;
 	bool events_ready : 1;
 };
 =

@@ -4259,6 +4259,20 @@ static void netdev_set_mac_cb(int error, uint16_t ty=
pe, const void *data,
 					netdev_initial_up_cb, netdev, NULL);
 }
 =

+static bool netdev_check_set_mac(struct netdev *netdev)
+{
+	if (util_mem_is_zero(netdev->set_mac_once, 6))
+		return false;
+
+	l_debug("Setting initial address on ifindex: %d to: " MAC,
+		netdev->index, MAC_STR(netdev->set_mac_once));
+	netdev->set_powered_cmd_id =3D
+		rtnl_set_mac(rtnl, netdev->index, netdev->set_mac_once,
+				netdev_set_mac_cb, netdev, NULL);
+	memset(netdev->set_mac_once, 0, 6);
+	return true;
+}
+
 static void netdev_initial_down_cb(int error, uint16_t type, const void *d=
ata,
 					uint32_t len, void *user_data)
 {
@@ -4274,17 +4288,8 @@ static void netdev_initial_down_cb(int error, uint16=
_t type, const void *data,
 		return;
 	}
 =

-	if (netdev->mac_randomize_once) {
-		uint8_t addr[ETH_ALEN];
-
-		wiphy_generate_random_address(netdev->wiphy, addr);
-		l_debug("Setting initial random address on "
-			"ifindex: %d to: "MAC, netdev->index, MAC_STR(addr));
-		netdev->set_powered_cmd_id =3D
-			rtnl_set_mac(rtnl, netdev->index, addr,
-					netdev_set_mac_cb, netdev, NULL);
+	if (netdev_check_set_mac(netdev))
 		return;
-	}
 =

 	netdev->set_powered_cmd_id =3D
 		rtnl_set_powered(rtnl, netdev->index, true,
@@ -4326,17 +4331,8 @@ static void netdev_getlink_cb(int error, uint16_t ty=
pe, const void *data,
 	 */
 	powered =3D netdev_get_is_up(netdev);
 =

-	if (!powered && netdev->mac_randomize_once) {
-		uint8_t addr[ETH_ALEN];
-
-		wiphy_generate_random_address(netdev->wiphy, addr);
-		l_debug("Setting initial random address on "
-			"ifindex: %d to: "MAC, netdev->index, MAC_STR(addr));
-		netdev->set_powered_cmd_id =3D
-			rtnl_set_mac(rtnl, netdev->index, addr,
-					netdev_set_mac_cb, netdev, NULL);
+	if (!powered && netdev_check_set_mac(netdev))
 		return;
-	}
 =

 	cb =3D powered ? netdev_initial_down_cb : netdev_initial_up_cb;
 =

@@ -4511,7 +4507,8 @@ error:
 	return NULL;
 }
 =

-struct netdev *netdev_create_from_genl(struct l_genl_msg *msg, bool random=
_mac)
+struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
+					const uint8_t *set_mac)
 {
 	struct l_genl_attr attr;
 	uint16_t type, len;
@@ -4628,7 +4625,9 @@ struct netdev *netdev_create_from_genl(struct l_genl_=
msg *msg, bool random_mac)
 	memcpy(netdev->name, ifname, ifname_len);
 	netdev->wiphy =3D wiphy;
 	netdev->pae_over_nl80211 =3D pae_io =3D=3D NULL;
-	netdev->mac_randomize_once =3D random_mac;
+
+	if (set_mac)
+		memcpy(netdev->set_mac_once, set_mac, 6);
 =

 	if (pae_io) {
 		netdev->pae_io =3D pae_io;
diff --git a/src/netdev.h b/src/netdev.h
index 032265f9..192cb4fe 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -205,5 +205,6 @@ uint32_t netdev_station_watch_add(struct netdev *netdev,
 =

 bool netdev_station_watch_remove(struct netdev *netdev, uint32_t id);
 =

-struct netdev *netdev_create_from_genl(struct l_genl_msg *msg, bool random=
_mac);
+struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
+					const uint8_t *set_mac);
 bool netdev_destroy(struct netdev *netdev);
-- =

2.20.1

--===============3145855373267195637==--

