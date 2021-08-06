Content-Type: multipart/mixed; boundary="===============4917096599603707499=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] station: add ConnectBssid() developer method
Date: Fri, 06 Aug 2021 16:02:12 -0700
Message-ID: <20210806230212.381657-5-prestwoj@gmail.com>
In-Reply-To: <20210806230212.381657-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4917096599603707499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This method will initiate a connection to a specific BSS rather
than relying on a network based connection (which the user has
no control over which specific BSS is selected).
---
 src/station.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/src/station.c b/src/station.c
index a441a63d..ca6043f4 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3530,6 +3530,11 @@ static struct station *station_create(struct netdev =
*netdev)
 =

 	station_fill_scan_freq_subsets(station);
 =

+	l_dbus_object_add_interface(dbus,
+					netdev_get_path(station->netdev),
+					IWD_STATION_DEBUG_INTERFACE,
+					station);
+
 	return station;
 }
 =

@@ -3543,6 +3548,9 @@ static void station_free(struct station *station)
 	l_dbus_object_remove_interface(dbus_get_bus(),
 					netdev_get_path(station->netdev),
 					IWD_STATION_DIAGNOSTIC_INTERFACE);
+	l_dbus_object_remove_interface(dbus_get_bus(),
+					netdev_get_path(station->netdev),
+					IWD_STATION_DEBUG_INTERFACE);
 =

 	if (station->netconfig) {
 		netconfig_destroy(station->netconfig);
@@ -3751,6 +3759,42 @@ invalid_args:
 	return dbus_error_invalid_args(message);
 }
 =

+static struct network *station_find_network_from_bss(struct station *stati=
on,
+						struct scan_bss *bss)
+{
+	struct ie_rsn_info info;
+	int r;
+	enum security security;
+	const char *path;
+	char ssid[33];
+
+	memcpy(ssid, bss->ssid, bss->ssid_len);
+	ssid[bss->ssid_len] =3D '\0';
+
+	r =3D scan_bss_get_rsn_info(bss, &info);
+	if (r < 0) {
+		if (r !=3D -ENOENT)
+			return NULL;
+
+		security =3D security_determine(bss->capability, NULL);
+	} else
+		security =3D security_determine(bss->capability, &info);
+
+	path =3D iwd_network_get_path(station, ssid, security);
+
+	return l_hashmap_lookup(station->networks, path);
+}
+
+static bool find_bss_by_addr(const void *a, const void *b)
+{
+	const struct scan_bss *bss =3D a;
+
+	if (!memcmp(bss->addr, b, 6))
+		return true;
+
+	return false;
+}
+
 static void station_setup_diagnostic_interface(
 					struct l_dbus_interface *interface)
 {
@@ -3767,6 +3811,53 @@ static void station_destroy_diagnostic_interface(voi=
d *user_data)
 {
 }
 =

+static struct l_dbus_message *station_force_connect_bssid(struct l_dbus *d=
bus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct station *station =3D user_data;
+	struct l_queue *bss_list;
+	struct scan_bss *target;
+	struct network *network;
+	struct l_dbus_message_iter iter;
+	uint8_t *mac;
+	uint32_t mac_len;
+
+	if (!l_dbus_message_get_arguments(message, "ay", &iter))
+		goto invalid_args;
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter, &mac, &mac_len))
+		goto invalid_args;
+
+	if (mac_len !=3D 6)
+		return dbus_error_invalid_args(message);
+
+	bss_list =3D station_get_bss_list(station);
+
+	target =3D l_queue_find(bss_list, find_bss_by_addr, mac);
+	if (!target)
+		return dbus_error_invalid_args(message);
+
+	network =3D station_find_network_from_bss(station, target);
+	if (!network)
+		return dbus_error_invalid_args(message);
+
+	l_debug("Attempting forced connection to BSS "MAC, MAC_STR(mac));
+
+	return __network_connect(network, target, message);
+
+invalid_args:
+	return dbus_error_invalid_args(message);
+}
+
+static void station_setup_debug_interface(
+					struct l_dbus_interface *interface)
+{
+	l_dbus_interface_method(interface, "ConnectBssid", 0,
+					station_force_connect_bssid, "", "ay",
+					"mac");
+}
+
 static void ap_roam_frame_event(const struct mmpdu_header *hdr,
 					const void *body, size_t body_len,
 					int rssi, void *user_data)
@@ -3838,6 +3929,11 @@ static int station_init(void)
 					station_setup_diagnostic_interface,
 					station_destroy_diagnostic_interface,
 					false);
+	l_dbus_register_interface(dbus_get_bus(),
+					IWD_STATION_DEBUG_INTERFACE,
+					station_setup_debug_interface,
+					NULL,
+					false);
 =

 	if (!l_settings_get_uint(iwd_get_config(), "General",
 					"ManagementFrameProtection",
@@ -3879,6 +3975,8 @@ static void station_exit(void)
 {
 	l_dbus_unregister_interface(dbus_get_bus(),
 					IWD_STATION_DIAGNOSTIC_INTERFACE);
+	l_dbus_unregister_interface(dbus_get_bus(),
+					IWD_STATION_DEBUG_INTERFACE);
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_STATION_INTERFACE);
 	netdev_watch_remove(netdev_watch);
 	l_queue_destroy(station_list, NULL);
-- =

2.31.1

--===============4917096599603707499==--

