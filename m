Content-Type: multipart/mixed; boundary="===============6242318681877950336=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/17] manager: Create/destroy P2P devices
Date: Fri, 03 Apr 2020 18:14:16 +0200
Message-ID: <20200403161430.14168-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200403161430.14168-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6242318681877950336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create a P2P device interface along with the station interface when
setting up a wiphy and handle the interface being removed.
---
 src/manager.c | 122 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 101 insertions(+), 21 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 533975d2..f351c780 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -42,6 +42,7 @@
 #include "src/util.h"
 #include "src/common.h"
 #include "src/nl80211cmd.h"
+#include "src/p2p.h"
 =

 static struct l_genl_family *nl80211 =3D NULL;
 static char **whitelist_filter;
@@ -125,7 +126,8 @@ static bool manager_use_default(struct wiphy_setup_stat=
e *state)
 	return true;
 }
 =

-static void manager_new_interface_cb(struct l_genl_msg *msg, void *user_da=
ta)
+static void manager_new_station_interface_cb(struct l_genl_msg *msg,
+						void *user_data)
 {
 	struct wiphy_setup_state *state =3D user_data;
 	uint8_t addr_buf[6];
@@ -170,6 +172,25 @@ static void manager_new_interface_cb(struct l_genl_msg=
 *msg, void *user_data)
 	netdev_create_from_genl(msg, addr);
 }
 =

+static void manager_new_p2p_interface_cb(struct l_genl_msg *msg,
+						void *user_data)
+{
+	struct wiphy_setup_state *state =3D user_data;
+
+	l_debug("");
+
+	if (state->aborted)
+		return;
+
+	if (l_genl_msg_get_error(msg) < 0) {
+		l_error("NEW_INTERFACE failed for p2p-device: %s",
+			strerror(-l_genl_msg_get_error(msg)));
+		return;
+	}
+
+	p2p_device_update_from_genl(msg, true);
+}
+
 static void manager_new_interface_done(void *user_data)
 {
 	struct wiphy_setup_state *state =3D user_data;
@@ -184,7 +205,7 @@ static void manager_create_interfaces(struct wiphy_setu=
p_state *state)
 {
 	struct l_genl_msg *msg;
 	char ifname[10];
-	uint32_t iftype =3D NL80211_IFTYPE_STATION;
+	uint32_t iftype;
 	unsigned cmd_id;
 =

 	if (state->aborted)
@@ -192,19 +213,26 @@ static void manager_create_interfaces(struct wiphy_se=
tup_state *state)
 =

 	if (state->use_default) {
 		manager_use_default(state);
-		return;
+
+		/*
+		 * Some drivers don't let us touch the default interface
+		 * but still allow us to create/destroy P2P interfaces, so
+		 * give it a chance.
+		 */
+		goto try_create_p2p;
 	}
 =

 	/*
 	 * Current policy: we maintain one netdev per wiphy for station,
 	 * AP and Ad-Hoc modes, one optional p2p-device and zero or more
-	 * p2p-GOs or p2p-clients.  The P2P-related interfaces will be
+	 * p2p-GOs or p2p-clients.  The P2P-client/GO interfaces will be
 	 * created on request.
 	 */
 =

 	/* To be improved */
 	snprintf(ifname, sizeof(ifname), "wlan%i", (int) state->id);
 	l_debug("creating %s", ifname);
+	iftype =3D NL80211_IFTYPE_STATION;
 =

 	msg =3D l_genl_msg_new(NL80211_CMD_NEW_INTERFACE);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &state->id);
@@ -226,7 +254,48 @@ static void manager_create_interfaces(struct wiphy_set=
up_state *state)
 	}
 =

 	cmd_id =3D l_genl_family_send(nl80211, msg,
-					manager_new_interface_cb, state,
+					manager_new_station_interface_cb, state,
+					manager_new_interface_done);
+
+	if (!cmd_id) {
+		l_error("Error sending NEW_INTERFACE for %s", ifname);
+		return;
+	}
+
+	state->pending_cmd_count++;
+
+try_create_p2p:
+	/*
+	 * Require the MAC on create feature so we can send our desired
+	 * interface address during GO Negotiation before actually creating
+	 * the local Client/GO interface.  Could be worked around if needed.
+	 */
+	if (!wiphy_supports_iftype(state->wiphy, NL80211_IFTYPE_P2P_DEVICE) ||
+			!wiphy_supports_iftype(state->wiphy,
+						NL80211_IFTYPE_P2P_CLIENT) ||
+			!wiphy_has_feature(state->wiphy,
+						NL80211_FEATURE_MAC_ON_CREATE))
+		return;
+
+	/*
+	 * Use wlan%i-p2p for now.  We might want to use
+	 * <default_interface's_name>-p2p here (in case state->use_default
+	 * is true) but the risk is that we'd go over the interface name
+	 * length limit.
+	 */
+	snprintf(ifname, sizeof(ifname), "wlan%i-p2p", (int) state->id);
+	l_debug("creating %s", ifname);
+	iftype =3D NL80211_IFTYPE_P2P_DEVICE;
+
+	msg =3D l_genl_msg_new(NL80211_CMD_NEW_INTERFACE);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &state->id);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFTYPE, 4, &iftype);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFNAME,
+				strlen(ifname) + 1, ifname);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_4ADDR, 1, "\0");
+	l_genl_msg_append_attr(msg, NL80211_ATTR_SOCKET_OWNER, 0, "");
+	cmd_id =3D l_genl_family_send(nl80211, msg,
+					manager_new_p2p_interface_cb, state,
 					manager_new_interface_done);
 =

 	if (!cmd_id) {
@@ -378,17 +447,6 @@ static struct wiphy_setup_state *manager_find_pending(=
uint32_t id)
 				L_UINT_TO_PTR(id));
 }
 =

-static uint32_t manager_parse_ifindex(struct l_genl_msg *msg)
-{
-	uint32_t ifindex;
-
-	if (nl80211_parse_attrs(msg, NL80211_ATTR_IFINDEX, &ifindex,
-					NL80211_ATTR_UNSPEC) < 0)
-		return -1;
-
-	return ifindex;
-}
-
 static uint32_t manager_parse_wiphy_id(struct l_genl_msg *msg)
 {
 	uint32_t wiphy;
@@ -593,7 +651,6 @@ static int manager_wiphy_filtered_dump(uint32_t wiphy_i=
d,
 static void manager_config_notify(struct l_genl_msg *msg, void *user_data)
 {
 	uint8_t cmd;
-	struct netdev *netdev;
 	uint32_t wiphy_id;
 	struct wiphy_setup_state *state;
 =

@@ -692,13 +749,36 @@ static void manager_config_notify(struct l_genl_msg *=
msg, void *user_data)
 		return;
 =

 	case NL80211_CMD_DEL_INTERFACE:
-		netdev =3D netdev_find(manager_parse_ifindex(msg));
-		if (!netdev)
-			return;
+	{
+		uint32_t ifindex;
+
+		if (nl80211_parse_attrs(msg, NL80211_ATTR_IFINDEX, &ifindex,
+					NL80211_ATTR_UNSPEC) < 0) {
+			uint64_t wdev_id;
+			struct p2p_device *p2p_device;
+
+			if (nl80211_parse_attrs(msg, NL80211_ATTR_WDEV,
+						&wdev_id,
+						NL80211_ATTR_UNSPEC) < 0)
+				return;
+
+			p2p_device =3D p2p_device_find(wdev_id);
+			if (!p2p_device)
+				return;
+
+			p2p_device_destroy(p2p_device);
+		} else {
+			struct netdev *netdev =3D netdev_find(ifindex);
+
+			if (!netdev)
+				return;
+
+			netdev_destroy(netdev);
+		}
 =

-		netdev_destroy(netdev);
 		return;
 	}
+	}
 }
 =

 static int manager_init(void)
-- =

2.20.1

--===============6242318681877950336==--

