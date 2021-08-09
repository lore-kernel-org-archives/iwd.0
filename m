Content-Type: multipart/mixed; boundary="===============2229343841261772196=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/4] station: add ConnectBssid() developer method
Date: Mon, 09 Aug 2021 10:42:57 -0700
Message-ID: <20210809174259.537399-2-prestwoj@gmail.com>
In-Reply-To: <20210809174259.537399-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2229343841261772196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This method will initiate a connection to a specific BSS rather
than relying on a network based connection (which the user has
no control over which specific BSS is selected).
---
 src/station.c | 129 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 111 insertions(+), 18 deletions(-)

diff --git a/src/station.c b/src/station.c
index bc4e7539..9a053c85 100644
--- a/src/station.c
+++ b/src/station.c
@@ -286,6 +286,34 @@ static int bss_signal_strength_compare(const void *a, =
const void *b, void *user)
 	return (bss->signal_strength > new_bss->signal_strength) ? 1 : -1;
 }
 =

+static int station_parse_bss(struct station *station,
+				struct scan_bss *bss, char *ssid_out,
+				enum security *security_out,
+				char *path_out)
+{
+	struct ie_rsn_info info;
+	const char *path;
+	int r;
+
+	r =3D scan_bss_get_rsn_info(bss, &info);
+	if (r < 0) {
+		if (r !=3D -ENOENT)
+			return r;
+
+		*security_out =3D security_determine(bss->capability, NULL);
+	} else
+		*security_out =3D security_determine(bss->capability, &info);
+
+	memcpy(ssid_out, bss->ssid, bss->ssid_len);
+	ssid_out[bss->ssid_len] =3D '\0';
+
+	path =3D iwd_network_get_path(station, ssid_out, *security_out);
+
+	strcpy(path_out, path);
+
+	return 0;
+}
+
 /*
  * Returns the network object the BSS was added to or NULL if ignored.
  */
@@ -293,10 +321,8 @@ static struct network *station_add_seen_bss(struct sta=
tion *station,
 						struct scan_bss *bss)
 {
 	struct network *network;
-	struct ie_rsn_info info;
-	int r;
 	enum security security;
-	const char *path;
+	char path[256];
 	char ssid[33];
 	uint32_t kbps100 =3D DIV_ROUND_CLOSEST(bss->data_rate, 100000);
 =

@@ -315,25 +341,13 @@ static struct network *station_add_seen_bss(struct st=
ation *station,
 		return NULL;
 	}
 =

-	memcpy(ssid, bss->ssid, bss->ssid_len);
-	ssid[bss->ssid_len] =3D '\0';
-
 	if (!(bss->capability & IE_BSS_CAP_ESS)) {
-		l_debug("Ignoring non-ESS BSS \"%s\"", ssid);
+		l_debug("Ignoring non-ESS BSS \"%.32s\"", ssid);
 		return NULL;
 	}
 =

-	memset(&info, 0, sizeof(info));
-	r =3D scan_bss_get_rsn_info(bss, &info);
-	if (r < 0) {
-		if (r !=3D -ENOENT)
-			return NULL;
-
-		security =3D security_determine(bss->capability, NULL);
-	} else
-		security =3D security_determine(bss->capability, &info);
-
-	path =3D iwd_network_get_path(station, ssid, security);
+	if (station_parse_bss(station, bss, ssid, &security, path) < 0)
+		return NULL;
 =

 	network =3D l_hashmap_lookup(station->networks, path);
 	if (!network) {
@@ -3540,6 +3554,12 @@ static struct station *station_create(struct netdev =
*netdev)
 =

 	station_fill_scan_freq_subsets(station);
 =

+	if (iwd_is_developer_mode())
+		l_dbus_object_add_interface(dbus,
+					netdev_get_path(station->netdev),
+					IWD_STATION_DEBUG_INTERFACE,
+					station);
+
 	return station;
 }
 =

@@ -3553,6 +3573,10 @@ static void station_free(struct station *station)
 	l_dbus_object_remove_interface(dbus_get_bus(),
 					netdev_get_path(station->netdev),
 					IWD_STATION_DIAGNOSTIC_INTERFACE);
+	if (iwd_is_developer_mode())
+		l_dbus_object_remove_interface(dbus_get_bus(),
+					netdev_get_path(station->netdev),
+					IWD_STATION_DEBUG_INTERFACE);
 =

 	if (station->netconfig) {
 		netconfig_destroy(station->netconfig);
@@ -3761,6 +3785,19 @@ invalid_args:
 	return dbus_error_invalid_args(message);
 }
 =

+static struct network *station_find_network_from_bss(struct station *stati=
on,
+						struct scan_bss *bss)
+{
+	enum security security;
+	static char path[256];
+	char ssid[33];
+
+	if (station_parse_bss(station, bss, ssid, &security, path) < 0)
+		return NULL;
+
+	return l_hashmap_lookup(station->networks, path);
+}
+
 static void station_setup_diagnostic_interface(
 					struct l_dbus_interface *interface)
 {
@@ -3777,6 +3814,53 @@ static void station_destroy_diagnostic_interface(voi=
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
+	target =3D l_queue_find(bss_list, bss_match_bssid, mac);
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
@@ -3848,6 +3932,12 @@ static int station_init(void)
 					station_setup_diagnostic_interface,
 					station_destroy_diagnostic_interface,
 					false);
+	if (iwd_is_developer_mode())
+		l_dbus_register_interface(dbus_get_bus(),
+					IWD_STATION_DEBUG_INTERFACE,
+					station_setup_debug_interface,
+					NULL,
+					false);
 =

 	if (!l_settings_get_uint(iwd_get_config(), "General",
 					"ManagementFrameProtection",
@@ -3889,6 +3979,9 @@ static void station_exit(void)
 {
 	l_dbus_unregister_interface(dbus_get_bus(),
 					IWD_STATION_DIAGNOSTIC_INTERFACE);
+	if (iwd_is_developer_mode())
+		l_dbus_unregister_interface(dbus_get_bus(),
+					IWD_STATION_DEBUG_INTERFACE);
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_STATION_INTERFACE);
 	netdev_watch_remove(netdev_watch);
 	l_queue_destroy(station_list, NULL);
-- =

2.31.1

--===============2229343841261772196==--

