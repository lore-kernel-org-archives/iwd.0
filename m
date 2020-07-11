Content-Type: multipart/mixed; boundary="===============0020761432063153217=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 11/18] p2p: Implement the p2p.ServiceManager interface
Date: Sat, 11 Jul 2020 03:00:46 +0200
Message-ID: <20200711010053.224223-11-andrew.zaborowski@intel.com>
In-Reply-To: <20200711010053.224223-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0020761432063153217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The net.connman.iwd.p2p.ServiceManager interface on the /net/connman/iwd
object lets user applications register/unregister the Wi-Fi Display
service.  In this commit all this does is it adds local WFD information
as given by the app, to the frames we send out during discovery.

Instead of accepting raw WFD IE contents from the app and exposing
peers' raw WFD IEs to the app, we build the WFD IEs in our code based on
the few meaningful DBus properties that we support and using default
values for the rest.  If an app ever needs any of the other WFD
capabilities more properties can be added.
---
 src/dbus.h |   1 +
 src/p2p.c  | 302 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 293 insertions(+), 10 deletions(-)

diff --git a/src/dbus.h b/src/dbus.h
index ebae85d4..21d2943f 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -37,6 +37,7 @@
 #define IWD_STATION_INTERFACE "net.connman.iwd.Station"
 #define IWD_P2P_INTERFACE "net.connman.iwd.p2p.Device"
 #define IWD_P2P_PEER_INTERFACE "net.connman.iwd.p2p.Peer"
+#define IWD_P2P_SERVICE_MANAGER_INTERFACE "net.connman.iwd.p2p.ServiceMana=
ger"
 =

 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
diff --git a/src/p2p.c b/src/p2p.c
index 1e38c45b..891f425f 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -136,8 +136,22 @@ struct p2p_peer {
 	bool group;
 };
 =

+struct p2p_wfd_properties {
+	bool available;
+	bool source;
+	bool sink;
+	uint16_t port;
+	uint16_t throughput;
+	bool audio;
+	bool uibc;
+	bool cp;
+	bool r2;
+};
+
 static struct l_queue *p2p_device_list;
 static struct l_settings *p2p_dhcp_settings;
+static struct p2p_wfd_properties *p2p_own_wfd;
+static unsigned int p2p_wfd_disconnect_watch;
 =

 /*
  * For now we only scan the common 2.4GHz channels, to be replaced with
@@ -237,6 +251,65 @@ static void p2p_peer_put(void *user_data)
 static void p2p_device_discovery_start(struct p2p_device *dev);
 static void p2p_device_discovery_stop(struct p2p_device *dev);
 =

+/* Callers should reserve 32 bytes */
+static size_t p2p_build_wfd_ie(const struct p2p_wfd_properties *wfd,
+				uint8_t *buf)
+{
+	/*
+	 * Wi-Fi Display Technical Specification v2.1.0
+	 * Probe req: Section 5.2.2
+	 * Negotiation req: Section 5.2.6.1
+	 * Negotiation resp: Section 5.2.6.2
+	 * Negotiation confirm: Section 5.2.6.3
+	 * Provision disc req: Section 5.2.6.6
+	 */
+	size_t size =3D 0;
+	uint16_t dev_type =3D
+		wfd->source ? (wfd->sink ? WFD_DEV_INFO_TYPE_DUAL_ROLE :
+			WFD_DEV_INFO_TYPE_SOURCE) :
+		WFD_DEV_INFO_TYPE_PRIMARY_SINK;
+
+	buf[size++] =3D IE_TYPE_VENDOR_SPECIFIC;
+	size++;			/* IE Data length */
+	buf[size++] =3D wifi_alliance_oui[0];
+	buf[size++] =3D wifi_alliance_oui[1];
+	buf[size++] =3D wifi_alliance_oui[2];
+	buf[size++] =3D 0x0a;	/* OUI Type: WFD */
+
+	buf[size++] =3D WFD_SUBELEM_WFD_DEVICE_INFORMATION;
+	buf[size++] =3D 0;	/* WFD Subelement length */
+	buf[size++] =3D 6;
+	buf[size++] =3D 0x00;	/* WFD Device Information bitmap: */
+	buf[size++] =3D dev_type |
+		(wfd->available ? WFD_DEV_INFO_SESSION_AVAILABLE :
+		 WFD_DEV_INFO_SESSION_NOT_AVAILABLE) |
+		(wfd->audio ? 0 : WFD_DEV_INFO_NO_AUDIO_AT_PRIMARY_SINK) |
+		(wfd->cp ? WFD_DEV_INFO_CONTENT_PROTECTION_SUPPORT : 0);
+	buf[size++] =3D wfd->port >> 8; /* Session Mgmt Ctrl Port */
+	buf[size++] =3D wfd->port & 255;
+	buf[size++] =3D wfd->throughput >> 8; /* Maximum throughput */
+	buf[size++] =3D wfd->throughput & 255;
+
+	if (wfd->uibc) {
+		buf[size++] =3D WFD_SUBELEM_EXTENDED_CAPABILITY;
+		buf[size++] =3D 0;	/* WFD Subelement length */
+		buf[size++] =3D 2;
+		buf[size++] =3D 0x00;	/* WFD Extended Capability Bitmap: */
+		buf[size++] =3D 0x01;	/* UIBC Support */
+	}
+
+	if (wfd->r2) {
+		buf[size++] =3D WFD_SUBELEM_R2_DEVICE_INFORMATION;
+		buf[size++] =3D 0;	/* WFD Subelement length */
+		buf[size++] =3D 2;
+		buf[size++] =3D 0x00;	/* WFD R2 Device Information bitmap: */
+		buf[size++] =3D wfd->source ? wfd->sink ? 3 : 0 : 1;
+	}
+
+	buf[1] =3D size - 2;
+	return size;
+}
+
 /* TODO: convert to iovecs */
 static uint8_t *p2p_build_scan_ies(struct p2p_device *dev, uint8_t *buf,
 					size_t buf_len, size_t *out_len)
@@ -249,6 +322,8 @@ static uint8_t *p2p_build_scan_ies(struct p2p_device *d=
ev, uint8_t *buf,
 	size_t wsc_data_size;
 	L_AUTO_FREE_VAR(uint8_t *, wsc_ie) =3D NULL;
 	size_t wsc_ie_size;
+	uint8_t wfd_ie[32];
+	size_t wfd_ie_size;
 =

 	p2p_info.capability =3D dev->capability;
 	memcpy(p2p_info.listen_channel.country, dev->listen_country, 3);
@@ -292,14 +367,21 @@ static uint8_t *p2p_build_scan_ies(struct p2p_device =
*dev, uint8_t *buf,
 	if (!wsc_ie)
 		return NULL;
 =

-	/* WFD and other service IEs go here */
+	if (p2p_own_wfd)
+		wfd_ie_size =3D p2p_build_wfd_ie(p2p_own_wfd, wfd_ie);
+	else
+		wfd_ie_size =3D 0;
 =

-	if (buf_len < wsc_ie_size + p2p_ie_size)
+	if (buf_len < wsc_ie_size + p2p_ie_size + wfd_ie_size)
 		return NULL;
 =

 	memcpy(buf + 0, wsc_ie, wsc_ie_size);
 	memcpy(buf + wsc_ie_size, p2p_ie, p2p_ie_size);
-	*out_len =3D wsc_ie_size + p2p_ie_size;
+
+	if (wfd_ie_size)
+		memcpy(buf + wsc_ie_size + p2p_ie_size, wfd_ie, wfd_ie_size);
+
+	*out_len =3D wsc_ie_size + p2p_ie_size + wfd_ie_size;
 	return buf;
 }
 =

@@ -2616,6 +2698,7 @@ static void p2p_device_send_probe_resp(struct p2p_dev=
ice *dev,
 	size_t wsc_data_size;
 	uint8_t *wsc_ie;
 	size_t wsc_ie_size;
+	uint8_t wfd_ie[32];
 	struct iovec iov[16];
 	int iov_len =3D 0;
 	/* TODO: extract some of these from wiphy features */
@@ -2708,7 +2791,11 @@ static void p2p_device_send_probe_resp(struct p2p_de=
vice *dev,
 	iov[iov_len].iov_len =3D wsc_ie_size;
 	iov_len++;
 =

-	/* WFD and other service IEs go here */
+	if (p2p_own_wfd) {
+		iov[iov_len].iov_base =3D wfd_ie;
+		iov[iov_len].iov_len =3D p2p_build_wfd_ie(p2p_own_wfd, wfd_ie);
+		iov_len++;
+	}
 =

 	iov[iov_len].iov_base =3D NULL;
 =

@@ -3554,17 +3641,199 @@ static void p2p_peer_interface_setup(struct l_dbus=
_interface *interface)
 				p2p_peer_dbus_disconnect, "", "");
 }
 =

+static void p2p_own_wfd_free(void)
+{
+	const struct l_queue_entry *entry;
+
+	l_free(p2p_own_wfd);
+	p2p_own_wfd =3D NULL;
+
+	for (entry =3D l_queue_get_entries(p2p_device_list); entry;
+			entry =3D entry->next) {
+		struct p2p_device *dev =3D entry->data;
+
+		if (dev->conn_own_wfd)
+			p2p_connect_failed(dev);
+	}
+}
+
+static void p2p_wfd_disconnect_watch_cb(struct l_dbus *dbus, void *user_da=
ta)
+{
+	l_debug("P2P WFD service disconnected");
+
+	if (L_WARN_ON(unlikely(!p2p_own_wfd)))
+		return;
+
+	p2p_own_wfd_free();
+}
+
+static void p2p_wfd_disconnect_watch_destroy(void *user_data)
+{
+	p2p_wfd_disconnect_watch =3D 0;
+}
+
+static struct l_dbus_message *p2p_wfd_register(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	const char *prop_name;
+	struct l_dbus_message_iter prop_iter;
+	struct l_dbus_message_iter prop_variant;
+	struct p2p_wfd_properties props =3D {};
+	bool have_source =3D false;
+	bool have_sink =3D false;
+	bool have_port =3D false;
+	bool have_has_audio =3D false;
+	bool have_has_uibc =3D false;
+	bool have_has_cp =3D false;
+
+	if (!l_dbus_message_get_arguments(message, "a{sv}", &prop_iter))
+		return dbus_error_invalid_args(message);
+
+	while (l_dbus_message_iter_next_entry(&prop_iter, &prop_name,
+						&prop_variant)) {
+		if (!strcmp(prop_name, "Source")) {
+			if (have_source)
+				return dbus_error_invalid_args(message);
+
+			if (!l_dbus_message_iter_get_variant(&prop_variant, "b",
+								&props.source))
+				return dbus_error_invalid_args(message);
+
+			have_source =3D true;
+		} else if (!strcmp(prop_name, "Sink")) {
+			if (have_sink)
+				return dbus_error_invalid_args(message);
+
+			if (!l_dbus_message_iter_get_variant(&prop_variant, "b",
+								&props.sink))
+				return dbus_error_invalid_args(message);
+
+			have_sink =3D true;
+		} else if (!strcmp(prop_name, "Port")) {
+			if (have_port)
+				return dbus_error_invalid_args(message);
+
+			if (!l_dbus_message_iter_get_variant(&prop_variant, "q",
+								&props.port))
+				return dbus_error_invalid_args(message);
+
+			have_port =3D true;
+		} else if (!strcmp(prop_name, "HasAudio")) {
+			if (have_has_audio)
+				return dbus_error_invalid_args(message);
+
+			if (!l_dbus_message_iter_get_variant(&prop_variant, "b",
+								&props.audio))
+				return dbus_error_invalid_args(message);
+
+			have_has_audio =3D true;
+		} else if (!strcmp(prop_name, "HasUIBC")) {
+			if (have_has_uibc)
+				return dbus_error_invalid_args(message);
+
+			if (!l_dbus_message_iter_get_variant(&prop_variant, "b",
+								&props.uibc))
+				return dbus_error_invalid_args(message);
+
+			have_has_uibc =3D true;
+		} else if (!strcmp(prop_name, "HasContentProtection")) {
+			if (have_has_cp)
+				return dbus_error_invalid_args(message);
+
+			if (!l_dbus_message_iter_get_variant(&prop_variant, "b",
+								&props.cp))
+				return dbus_error_invalid_args(message);
+
+			have_has_cp =3D true;
+		} else
+			return dbus_error_invalid_args(message);
+	}
+
+	if ((!have_source || !props.source) && (!have_sink || !props.sink))
+		return dbus_error_invalid_args(message);
+
+	if (!have_source)
+		props.source =3D !props.sink;
+	else if (!have_sink)
+		props.sink =3D !props.source;
+
+	if (have_port && (!props.source || props.port =3D=3D 0))
+		return dbus_error_invalid_args(message);
+
+	if (props.source && !have_port)
+		props.port =3D 7236;
+
+	if (have_has_audio && !props.sink)
+		return dbus_error_invalid_args(message);
+	else if (!have_has_audio && props.sink)
+		props.audio =3D true;
+
+	/*
+	 * Should this be calculated based on Wi-Fi connection capacity?
+	 * Wi-Fi Display Technical Specification v2.1.0 only mentions this
+	 * in the context of the video format selection on the source (D.1.1):
+	 * "A WFD Source should determine averaged encoded video data rate
+	 * not to exceed the value indicated in the WFD Device Maximum
+	 * throughput field at WFD Device Information subelement transmitted
+	 * by the targeted WFD Sink [...]"
+	 */
+	props.throughput =3D 10;
+
+	if (p2p_own_wfd)
+		return dbus_error_already_exists(message);
+
+	p2p_wfd_disconnect_watch =3D l_dbus_add_disconnect_watch(dbus,
+					l_dbus_message_get_sender(message),
+					p2p_wfd_disconnect_watch_cb, NULL,
+					p2p_wfd_disconnect_watch_destroy);
+	p2p_own_wfd =3D l_memdup(&props, sizeof(props));
+	return l_dbus_message_new_method_return(message);
+}
+
+static struct l_dbus_message *p2p_wfd_unregister(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	if (!l_dbus_message_get_arguments(message, ""))
+		return dbus_error_invalid_args(message);
+
+	if (!p2p_own_wfd)
+		return dbus_error_not_found(message);
+
+	/* TODO: possibly check sender */
+	l_dbus_remove_watch(dbus, p2p_wfd_disconnect_watch);
+	p2p_own_wfd_free();
+	return l_dbus_message_new_method_return(message);
+}
+
+static void p2p_svc_mgr_interface_setup(struct l_dbus_interface *interface)
+{
+	l_dbus_interface_method(interface, "RegisterDisplayService", 0,
+				p2p_wfd_register, "", "a{sv}", "properties");
+	l_dbus_interface_method(interface, "UnregisterDisplayService", 0,
+				p2p_wfd_unregister, "", "");
+}
+
+static void p2p_svc_mgr_destroy_cb(void *user_data)
+{
+	if (p2p_own_wfd) {
+		l_dbus_remove_watch(dbus_get_bus(), p2p_wfd_disconnect_watch);
+		p2p_own_wfd_free();
+	}
+}
+
 static int p2p_init(void)
 {
-	if (!l_dbus_register_interface(dbus_get_bus(),
-					IWD_P2P_INTERFACE,
+	struct l_dbus *dbus =3D dbus_get_bus();
+
+	if (!l_dbus_register_interface(dbus, IWD_P2P_INTERFACE,
 					p2p_interface_setup,
 					NULL, false))
 		l_error("Unable to register the %s interface",
 			IWD_P2P_INTERFACE);
 =

-	if (!l_dbus_register_interface(dbus_get_bus(),
-					IWD_P2P_PEER_INTERFACE,
+	if (!l_dbus_register_interface(dbus, IWD_P2P_PEER_INTERFACE,
 					p2p_peer_interface_setup,
 					NULL, false))
 		l_error("Unable to register the %s interface",
@@ -3573,13 +3842,26 @@ static int p2p_init(void)
 	p2p_dhcp_settings =3D l_settings_new();
 	p2p_device_list =3D l_queue_new();
 =

+	if (!l_dbus_register_interface(dbus, IWD_P2P_SERVICE_MANAGER_INTERFACE,
+					p2p_svc_mgr_interface_setup,
+					p2p_svc_mgr_destroy_cb, false))
+		l_error("Unable to register the %s interface",
+			IWD_P2P_SERVICE_MANAGER_INTERFACE);
+	else if (!l_dbus_object_add_interface(dbus, IWD_AGENT_MANAGER_PATH,
+					IWD_P2P_SERVICE_MANAGER_INTERFACE,
+					NULL))
+		l_error("Unable to register the P2P Service Manager object");
+
 	return 0;
 }
 =

 static void p2p_exit(void)
 {
-	l_dbus_unregister_interface(dbus_get_bus(), IWD_P2P_INTERFACE);
-	l_dbus_unregister_interface(dbus_get_bus(), IWD_P2P_PEER_INTERFACE);
+	struct l_dbus *dbus =3D dbus_get_bus();
+
+	l_dbus_unregister_interface(dbus, IWD_P2P_INTERFACE);
+	l_dbus_unregister_interface(dbus, IWD_P2P_PEER_INTERFACE);
+	l_dbus_unregister_interface(dbus, IWD_P2P_SERVICE_MANAGER_INTERFACE);
 	l_queue_destroy(p2p_device_list, p2p_device_free);
 	p2p_device_list =3D NULL;
 	l_settings_free(p2p_dhcp_settings);
-- =

2.25.1

--===============0020761432063153217==--

