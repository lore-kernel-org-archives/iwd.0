Content-Type: multipart/mixed; boundary="===============1962037861991684571=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/6] p2p: Start a basic P2P Group after GO Negotiation
Date: Wed, 16 Sep 2020 11:17:52 +0200
Message-ID: <20200916091754.516851-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200916091754.516851-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1962037861991684571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the ap.c API to start an AP on a P2P_GO interface after we've been
selected as the GO in the GO Negotiation.
---
 src/p2p.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 122 insertions(+), 13 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index ac9a8f97..cf4d4bf3 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -55,6 +55,7 @@
 #include "src/frame-xchg.h"
 #include "src/nl80211util.h"
 #include "src/netconfig.h"
+#include "src/ap.h"
 #include "src/p2p.h"
 =

 struct p2p_device {
@@ -110,6 +111,7 @@ struct p2p_device {
 	uint8_t conn_peer_interface_addr[6];
 =

 	struct p2p_group_id_attr go_group_id;
+	struct ap_state *group;
 =

 	bool enabled : 1;
 	bool have_roc_cookie : 1;
@@ -123,6 +125,7 @@ struct p2p_device {
 	bool disconnecting : 1;
 	bool is_go : 1;
 	bool conn_go_tie_breaker : 1;
+	bool conn_peer_added : 1;
 };
 =

 struct p2p_discovery_user {
@@ -217,8 +220,9 @@ static void p2p_discovery_user_free(void *data)
 =

 static inline bool p2p_peer_operational(struct p2p_peer *peer)
 {
-	return peer && peer->dev->conn_netdev && !peer->dev->conn_wsc_bss &&
-		!peer->wsc.pending_connect && !peer->dev->disconnecting;
+	return peer && peer->dev->conn_netdev && !peer->dev->disconnecting &&
+		((!peer->dev->is_go && !peer->dev->conn_wsc_bss) ||
+		 (peer->dev->is_go && peer->dev->conn_peer_added));
 }
 =

 static bool p2p_peer_match(const void *a, const void *b)
@@ -457,6 +461,14 @@ static void p2p_connection_reset(struct p2p_device *de=
v)
 	if (dev->conn_enrollee)
 		wsc_enrollee_cancel(dev->conn_enrollee, false);
 =

+	if (dev->group) {
+		ap_free(dev->group);
+		dev->group =3D NULL;
+		dev->conn_peer_added =3D false;
+	}
+
+	dev->capability.group_caps =3D 0;
+
 	if (dev->conn_netdev) {
 		struct l_genl_msg *msg;
 		uint64_t wdev_id =3D netdev_get_wdev_id(dev->conn_netdev);
@@ -628,10 +640,12 @@ static void p2p_peer_connect_done(struct p2p_device *=
dev)
 {
 	struct p2p_peer *peer =3D dev->conn_peer;
 =

-	/* We can free anything potentially needed for a retry */
-	scan_bss_free(dev->conn_wsc_bss);
-	dev->conn_wsc_bss =3D NULL;
-	explicit_bzero(dev->conn_psk, 32);
+	if (!dev->is_go) {
+		/* We can free anything potentially needed for a retry */
+		scan_bss_free(dev->conn_wsc_bss);
+		dev->conn_wsc_bss =3D NULL;
+		explicit_bzero(dev->conn_psk, 32);
+	}
 =

 	dbus_pending_reply(&peer->wsc.pending_connect,
 				l_dbus_message_new_method_return(
@@ -649,6 +663,96 @@ static void p2p_peer_connect_done(struct p2p_device *d=
ev)
 				"ConnectedIP");
 }
 =

+static void p2p_group_event(enum ap_event_type type, const void *event_dat=
a,
+				void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	l_debug("type=3D%i", type);
+
+	switch (type) {
+	case AP_EVENT_START_FAILED:
+	case AP_EVENT_STOPPING:
+		dev->group =3D NULL;
+		p2p_connect_failed(dev);
+		break;
+
+	case AP_EVENT_STARTED:
+		ap_push_button(dev->group);
+		break;
+
+	case AP_EVENT_STATION_ADDED:
+		dev->conn_peer_added =3D true;
+		p2p_peer_connect_done(dev);
+		break;
+
+	case AP_EVENT_STATION_REMOVED:
+		dev->conn_peer_added =3D false;
+		p2p_connect_failed(dev);
+		break;
+
+	case AP_EVENT_REGISTRATION_START:
+		/* Don't validate the P2P IE or WFD IE at this stage */
+		break;
+	case AP_EVENT_REGISTRATION_SUCCESS:
+		dev->capability.group_caps &=3D ~P2P_GROUP_CAP_GROUP_FORMATION;
+		break;
+	case AP_EVENT_PBC_MODE_EXIT:
+		break;
+	};
+}
+
+static const struct ap_ops p2p_go_ops =3D {
+	.handle_event =3D p2p_group_event,
+};
+
+static void p2p_group_start(struct p2p_device *dev)
+{
+	struct ap_config *config =3D l_new(struct ap_config, 1);
+
+	config->ssid =3D l_strdup(dev->go_group_id.ssid);
+	config->channel =3D dev->listen_channel;
+	config->wsc_name =3D l_strdup(dev->device_info.device_name);
+	config->wsc_primary_device_type =3D dev->device_info.primary_device_type;
+	config->no_cck_rates =3D true;
+
+	/*
+	 * Section 3.2.1: "The Credentials for a P2P Group issued to a
+	 * P2P Device shall: [...]
+	 *  - Use a Network Key Type of 64 Hex characters."
+	 *
+	 * This implies we have to send the PSK and not the passphrase to
+	 * the WSC clients.  For simplicity we directly generate random
+	 * PSKs and don't currently respect the requirement to maintain
+	 * a passphrase.  We have no practical use for the passphrase and
+	 * it's a little costlier to generate for the same cryptographic
+	 * strength as the PSK.
+	 */
+	if (!l_getrandom(config->psk, 32)) {
+		l_error("l_getrandom() failed");
+		ap_config_free(config);
+		p2p_connect_failed(dev);
+		return;
+	}
+
+	/*
+	 * Section 3.1.4.4: "It shall only allow association by the
+	 * P2P Device that it is currently in Group Formation with."
+	 */
+	config->authorized_macs =3D l_memdup(dev->conn_peer_interface_addr, 6);
+	config->authorized_macs_num =3D 1;
+
+	dev->capability.group_caps |=3D P2P_GROUP_CAP_GO;
+	dev->capability.group_caps |=3D P2P_GROUP_CAP_GROUP_FORMATION;
+
+	dev->group =3D ap_start(dev->conn_netdev, config, &p2p_go_ops, dev);
+	if (!dev->group) {
+		ap_config_free(config);
+		p2p_connect_failed(dev);
+		return;
+	}
+}
+
 static void p2p_netconfig_event_handler(enum netconfig_event event,
 					void *user_data)
 {
@@ -682,7 +786,7 @@ static void p2p_dhcp_timeout_destroy(void *user_data)
 	dev->conn_dhcp_timeout =3D NULL;
 }
 =

-static void p2p_start_dhcp(struct p2p_device *dev)
+static void p2p_start_dhcp_client(struct p2p_device *dev)
 {
 	uint32_t ifindex =3D netdev_get_ifindex(dev->conn_netdev);
 	unsigned int dhcp_timeout_val;
@@ -723,7 +827,7 @@ static void p2p_netdev_connect_cb(struct netdev *netdev,
 =

 	switch (result) {
 	case NETDEV_RESULT_OK:
-		p2p_start_dhcp(dev);
+		p2p_start_dhcp_client(dev);
 		break;
 	case NETDEV_RESULT_AUTHENTICATION_FAILED:
 	case NETDEV_RESULT_ASSOCIATION_FAILED:
@@ -1034,10 +1138,14 @@ static void p2p_device_netdev_notify(struct netdev =
*netdev,
 	case NETDEV_WATCH_EVENT_NEW:
 		/* Ignore the event if we're already connecting/connected */
 		if (dev->conn_enrollee || dev->conn_retry_count ||
-				!netdev_get_is_up(netdev))
+				dev->group || !netdev_get_is_up(netdev))
 			break;
 =

-		p2p_provision_connect(dev);
+		if (dev->is_go)
+			p2p_group_start(dev);
+		else
+			p2p_provision_connect(dev);
+
 		break;
 	case NETDEV_WATCH_EVENT_DEL:
 		dev->conn_netdev =3D NULL;
@@ -1094,13 +1202,14 @@ static void p2p_device_new_interface_destroy(void *=
user_data)
 =

 static void p2p_device_interface_create(struct p2p_device *dev)
 {
-	uint32_t iftype =3D NL80211_IFTYPE_P2P_CLIENT;
+	uint32_t iftype =3D dev->is_go ? NL80211_IFTYPE_P2P_GO :
+		NL80211_IFTYPE_P2P_CLIENT;
 	char ifname[32];
 	uint32_t wiphy_id =3D dev->wdev_id >> 32;
 	struct l_genl_msg *msg;
 =

-	snprintf(ifname, sizeof(ifname), "wlan%i-p2p-cl%i",
-			wiphy_id, dev->conn_num++);
+	snprintf(ifname, sizeof(ifname), "wlan%i-p2p-%s%i",
+			wiphy_id, dev->is_go ? "go" : "cl", dev->conn_num++);
 	l_debug("creating %s", ifname);
 =

 	msg =3D l_genl_msg_new(NL80211_CMD_NEW_INTERFACE);
-- =

2.25.1

--===============1962037861991684571==--

