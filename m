Content-Type: multipart/mixed; boundary="===============5049936671158218401=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/7] netdev: manager: pass mac type to netdev_create_from_genl
Date: Tue, 17 Mar 2020 10:38:50 -0700
Message-ID: <20200317173855.19680-2-prestwoj@gmail.com>
In-Reply-To: <20200317173855.19680-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5049936671158218401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This change updates netdev_create_from_genl to take an enum which
describes what type of MAC address we are using. These types map
1:1 to the valid 'AddressRandomization' configuration values:

disabled: use permanent address for adapter
once: randomize the MAC address once, on startup

The current behavior is maintained but instead of generating a MAC inside
manager (for the 'once' case) we generate it inside netdev. This patch is
to prepare for address randomization per-network.
---
 src/manager.c | 33 +++++++++++----------------------
 src/netdev.c  | 12 +++++++++---
 src/netdev.h  |  2 +-
 3 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index a63f35ee..05f61b6f 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -46,7 +46,7 @@
 static struct l_genl_family *nl80211 =3D NULL;
 static char **whitelist_filter;
 static char **blacklist_filter;
-static bool randomize;
+static enum netdev_set_mac_type mac_type;
 static bool use_default;
 =

 struct wiphy_setup_state {
@@ -104,9 +104,6 @@ static void wiphy_setup_state_destroy(struct wiphy_setu=
p_state *state)
 =

 static bool manager_use_default(struct wiphy_setup_state *state)
 {
-	uint8_t addr_buf[6];
-	uint8_t *addr =3D NULL;
-
 	l_debug("");
 =

 	if (!state->default_if_msg) {
@@ -116,20 +113,13 @@ static bool manager_use_default(struct wiphy_setup_st=
ate *state)
 		return false;
 	}
 =

-	if (randomize) {
-		wiphy_generate_random_address(state->wiphy, addr_buf);
-		addr =3D addr_buf;
-	}
-
-	netdev_create_from_genl(state->default_if_msg, addr);
+	netdev_create_from_genl(state->default_if_msg, mac_type);
 	return true;
 }
 =

 static void manager_new_interface_cb(struct l_genl_msg *msg, void *user_da=
ta)
 {
 	struct wiphy_setup_state *state =3D user_data;
-	uint8_t addr_buf[6];
-	uint8_t *addr =3D NULL;
 	int error;
 =

 	l_debug("");
@@ -161,13 +151,12 @@ static void manager_new_interface_cb(struct l_genl_ms=
g *msg, void *user_data)
 		return;
 	}
 =

-	if (randomize && !wiphy_has_feature(state->wiphy,
-					NL80211_FEATURE_MAC_ON_CREATE)) {
-		wiphy_generate_random_address(state->wiphy, addr_buf);
-		addr =3D addr_buf;
-	}
+	/* MAC will already be set, no need for netdev to set it again */
+	if (mac_type =3D=3D NETDEV_SET_MAC_ONCE && wiphy_has_feature(state->wiphy,
+					NL80211_FEATURE_MAC_ON_CREATE))
+		mac_type =3D NETDEV_SET_MAC_DISABLED;
 =

-	netdev_create_from_genl(msg, addr);
+	netdev_create_from_genl(msg, mac_type);
 }
 =

 static void manager_new_interface_done(void *user_data)
@@ -214,7 +203,7 @@ static void manager_create_interfaces(struct wiphy_setu=
p_state *state)
 	l_genl_msg_append_attr(msg, NL80211_ATTR_4ADDR, 1, "\0");
 	l_genl_msg_append_attr(msg, NL80211_ATTR_SOCKET_OWNER, 0, "");
 =

-	if (randomize && wiphy_has_feature(state->wiphy,
+	if (mac_type =3D=3D NETDEV_SET_MAC_ONCE && wiphy_has_feature(state->wiphy,
 					NL80211_FEATURE_MAC_ON_CREATE)) {
 		uint8_t random_addr[6];
 =

@@ -756,9 +745,9 @@ static int manager_init(void)
 							"AddressRandomization");
 	if (randomize_str) {
 		if (!strcmp(randomize_str, "once"))
-			randomize =3D true;
+			mac_type =3D NETDEV_SET_MAC_ONCE;
 		else if (!strcmp(randomize_str, "disabled"))
-			randomize =3D false;
+			mac_type =3D NETDEV_SET_MAC_DISABLED;
 		else
 			l_warn("Invalid [General].AddressRandomization"
 				" value: %s", randomize_str);
@@ -796,7 +785,7 @@ static void manager_exit(void)
 =

 	l_genl_family_free(nl80211);
 	nl80211 =3D NULL;
-	randomize =3D false;
+	mac_type =3D NETDEV_SET_MAC_DISABLED;
 }
 =

 IWD_MODULE(manager, manager_init, manager_exit);
diff --git a/src/netdev.c b/src/netdev.c
index c11a483f..7aed9da5 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4276,7 +4276,7 @@ error:
 }
 =

 struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
-					const uint8_t *set_mac)
+					enum netdev_set_mac_type mac_type)
 {
 	const char *ifname;
 	const uint8_t *ifaddr;
@@ -4337,8 +4337,14 @@ struct netdev *netdev_create_from_genl(struct l_genl=
_msg *msg,
 	netdev->wiphy =3D wiphy;
 	netdev->pae_over_nl80211 =3D pae_io =3D=3D NULL;
 =

-	if (set_mac)
-		memcpy(netdev->set_mac_once, set_mac, 6);
+	switch (mac_type) {
+	case NETDEV_SET_MAC_ONCE:
+		wiphy_generate_random_address(netdev->wiphy,
+						netdev->set_mac_once);
+		break;
+	default:
+		break;
+	}
 =

 	if (pae_io) {
 		netdev->pae_io =3D pae_io;
diff --git a/src/netdev.h b/src/netdev.h
index d468dc46..a553e3d4 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -197,5 +197,5 @@ uint32_t netdev_station_watch_add(struct netdev *netdev,
 bool netdev_station_watch_remove(struct netdev *netdev, uint32_t id);
 =

 struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
-					const uint8_t *set_mac);
+					enum netdev_set_mac_type mac_type);
 bool netdev_destroy(struct netdev *netdev);
-- =

2.21.1

--===============5049936671158218401==--

