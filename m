Content-Type: multipart/mixed; boundary="===============2410496759113879306=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/19] p2p: Add device enable/disable logic
Date: Thu, 23 Apr 2020 18:24:33 +0200
Message-ID: <20200423162447.15750-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200423162447.15750-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2410496759113879306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement the Enabled property on device interface.  The P2P device is
currently disabled on startup but automatically enabling the P2P device
can be considered.
---
 src/p2p.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index 030224e1..f4e0965b 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -58,12 +58,18 @@
 struct p2p_device {
 	uint64_t wdev_id;
 	uint8_t addr[6];
+	struct l_genl_family *nl80211;
 	struct wiphy *wiphy;
 	unsigned int connections_left;
 	struct p2p_capability_attr capability;
 	struct p2p_device_info_attr device_info;
+	uint32_t start_stop_cmd_id;
+	l_dbus_property_complete_cb_t pending_complete;
+	struct l_dbus_message *pending_message;
 =

 	struct l_queue *peer_list;
+
+	bool enabled : 1;
 };
 =

 struct p2p_peer {
@@ -123,6 +129,74 @@ static void p2p_peer_put(void *user_data)
 	p2p_peer_free(peer);
 }
 =

+static void p2p_device_enable_cb(struct l_genl_msg *msg, void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+	int error =3D l_genl_msg_get_error(msg);
+	struct l_dbus_message *message =3D dev->pending_message;
+
+	l_debug("START/STOP_P2P_DEVICE: %s (%i)", strerror(-error), -error);
+
+	if (error)
+		goto done;
+
+	dev->enabled =3D !dev->enabled;
+
+done:
+	dev->pending_complete(dbus_get_bus(), message,
+				error ? dbus_error_failed(message) :
+				NULL);
+	dev->pending_message =3D NULL;
+	dev->pending_complete =3D NULL;
+
+	if (!error)
+		l_dbus_property_changed(dbus_get_bus(),
+					p2p_device_get_path(dev),
+					IWD_P2P_INTERFACE, "Enabled");
+}
+
+static void p2p_device_enable_destroy(void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+
+	dev->start_stop_cmd_id =3D 0;
+}
+
+static void p2p_device_start_stop(struct p2p_device *dev,
+				l_dbus_property_complete_cb_t complete,
+				struct l_dbus_message *message)
+{
+	struct l_genl_msg *cmd;
+
+	if (!dev->enabled)
+		cmd =3D l_genl_msg_new_sized(NL80211_CMD_START_P2P_DEVICE, 16);
+	else
+		cmd =3D l_genl_msg_new_sized(NL80211_CMD_STOP_P2P_DEVICE, 16);
+
+	l_genl_msg_append_attr(cmd, NL80211_ATTR_WDEV, 8, &dev->wdev_id);
+
+	dev->start_stop_cmd_id =3D l_genl_family_send(dev->nl80211, cmd,
+						p2p_device_enable_cb, dev,
+						p2p_device_enable_destroy);
+	if (!dev->start_stop_cmd_id) {
+		l_genl_msg_unref(cmd);
+		complete(dbus_get_bus(), message, dbus_error_failed(message));
+		return;
+	}
+
+	dev->pending_message =3D message;
+	dev->pending_complete =3D complete;
+
+	if (dev->enabled) {
+		/*
+		 * Stopping the P2P device, drop all peers as we can't start
+		 * new connections from now on.
+		 */
+		l_queue_destroy(dev->peer_list, p2p_peer_put);
+		dev->peer_list =3D NULL;
+	}
+}
+
 #define P2P_SUPPORTED_METHODS	(			\
 	WSC_CONFIGURATION_METHOD_LABEL |		\
 	WSC_CONFIGURATION_METHOD_KEYPAD |		\
@@ -213,6 +287,7 @@ struct p2p_device *p2p_device_update_from_genl(struct l=
_genl_msg *msg,
 	dev =3D l_new(struct p2p_device, 1);
 	dev->wdev_id =3D *wdev_id;
 	memcpy(dev->addr, ifaddr, ETH_ALEN);
+	dev->nl80211 =3D l_genl_family_new(iwd_get_genl(), NL80211_GENL_NAME);
 	dev->wiphy =3D wiphy;
 	gethostname(hostname, sizeof(hostname));
 	dev->connections_left =3D 1;
@@ -303,8 +378,19 @@ static void p2p_device_free(void *user_data)
 {
 	struct p2p_device *dev =3D user_data;
 =

+	if (dev->pending_message) {
+		struct l_dbus_message *reply =3D
+			dbus_error_aborted(dev->pending_message);
+
+		dev->pending_complete(dbus_get_bus(),
+					dev->pending_message, reply);
+		dev->pending_message =3D NULL;
+		dev->pending_complete =3D NULL;
+	}
+
 	l_dbus_unregister_object(dbus_get_bus(), p2p_device_get_path(dev));
 	l_queue_destroy(dev->peer_list, p2p_peer_put);
+	l_genl_family_free(dev->nl80211); /* Cancels dev->start_stop_cmd_id */
 	l_free(dev);
 }
 =

@@ -317,6 +403,43 @@ bool p2p_device_destroy(struct p2p_device *dev)
 	return true;
 }
 =

+static bool p2p_device_get_enabled(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+	bool enabled =3D dev->enabled;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &enabled);
+
+	return true;
+}
+
+static struct l_dbus_message *p2p_device_set_enabled(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct p2p_device *dev =3D user_data;
+	bool new_enabled;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "b", &new_enabled))
+		return dbus_error_invalid_args(message);
+
+	if (dev->start_stop_cmd_id || dev->pending_message)
+		return dbus_error_busy(message);
+
+	if (dev->enabled =3D=3D new_enabled) {
+		complete(dbus, message, NULL);
+		return NULL;
+	}
+
+	p2p_device_start_stop(dev, complete, message);
+	return NULL;
+}
+
 static bool p2p_device_get_name(struct l_dbus *dbus,
 				struct l_dbus_message *message,
 				struct l_dbus_message_builder *builder,
@@ -414,6 +537,9 @@ static struct l_dbus_message *p2p_device_get_peers(stru=
ct l_dbus *dbus,
 =

 static void p2p_interface_setup(struct l_dbus_interface *interface)
 {
+	l_dbus_interface_property(interface, "Enabled", 0, "b",
+					p2p_device_get_enabled,
+					p2p_device_set_enabled);
 	l_dbus_interface_property(interface, "Name", 0, "s",
 					p2p_device_get_name,
 					p2p_device_set_name);
-- =

2.20.1

--===============2410496759113879306==--

