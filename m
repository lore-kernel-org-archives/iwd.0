Content-Type: multipart/mixed; boundary="===============3946459073629758187=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 1/3] station: add ConnectBssid() developer method
Date: Thu, 12 Aug 2021 12:07:21 -0700
Message-ID: <20210812190723.732722-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3946459073629758187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This method will initiate a connection to a specific BSS rather
than relying on a network based connection (which the user has
no control over which specific BSS is selected).
---
 src/station.c | 143 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 109 insertions(+), 34 deletions(-)

v4:
 * Reworked station_parse_bss to just parse security
 * Updated the common code in station to use station_parse_bss_security
 * Limited ConnectBssid() to only non-hidden networks

diff --git a/src/station.c b/src/station.c
index bc4e7539..49f78fce 100644
--- a/src/station.c
+++ b/src/station.c
@@ -286,6 +286,25 @@ static int bss_signal_strength_compare(const void *a, =
const void *b, void *user)
 	return (bss->signal_strength > new_bss->signal_strength) ? 1 : -1;
 }
 =

+static int station_parse_bss_security(struct station *station,
+				struct scan_bss *bss,
+				enum security *security_out)
+{
+	struct ie_rsn_info info;
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
+	return 0;
+}
+
 /*
  * Returns the network object the BSS was added to or NULL if ignored.
  */
@@ -293,8 +312,6 @@ static struct network *station_add_seen_bss(struct stat=
ion *station,
 						struct scan_bss *bss)
 {
 	struct network *network;
-	struct ie_rsn_info info;
-	int r;
 	enum security security;
 	const char *path;
 	char ssid[33];
@@ -323,15 +340,8 @@ static struct network *station_add_seen_bss(struct sta=
tion *station,
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
+	if (station_parse_bss_security(station, bss, &security) < 0)
+		return NULL;
 =

 	path =3D iwd_network_get_path(station, ssid, security);
 =

@@ -1872,8 +1882,6 @@ static bool station_roam_scan_notify(int err, struct =
l_queue *bss_list,
 =

 	while ((bss =3D l_queue_pop_head(bss_list))) {
 		double rank;
-		struct ie_rsn_info info;
-		int r;
 =

 		/* Skip the BSS we are connected to if doing an AP roam */
 		if (station->ap_directed_roaming && !memcmp(bss->addr,
@@ -1886,15 +1894,8 @@ static bool station_roam_scan_notify(int err, struct=
 l_queue *bss_list,
 				memcmp(bss->ssid, hs->ssid, hs->ssid_len))
 			goto next;
 =

-		memset(&info, 0, sizeof(info));
-		r =3D scan_bss_get_rsn_info(bss, &info);
-		if (r < 0) {
-			if (r !=3D -ENOENT)
-				goto next;
-
-			security =3D security_determine(bss->capability, NULL);
-		} else
-			security =3D security_determine(bss->capability, &info);
+		if (station_parse_bss_security(station, bss, &security) < 0)
+			goto next;
 =

 		if (security !=3D orig_security)
 			goto next;
@@ -3023,20 +3024,10 @@ static struct l_dbus_message *station_dbus_get_hidd=
en_access_points(
 						entry; entry =3D entry->next) {
 		struct scan_bss *bss =3D entry->data;
 		int16_t signal_strength =3D bss->signal_strength;
-		struct ie_rsn_info info;
 		enum security security;
-		int r;
 =

-		memset(&info, 0, sizeof(info));
-		r =3D scan_bss_get_rsn_info(bss, &info);
-		if (r < 0) {
-			if (r !=3D -ENOENT)
-				continue;
-
-			security =3D security_determine(bss->capability, NULL);
-		} else {
-			security =3D security_determine(bss->capability, &info);
-		}
+		if (station_parse_bss_security(station, bss, &security) < 0)
+			continue;
 =

 		l_dbus_message_builder_enter_struct(builder, "sns");
 		l_dbus_message_builder_append_basic(builder, 's',
@@ -3540,6 +3531,12 @@ static struct station *station_create(struct netdev =
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

@@ -3553,6 +3550,10 @@ static void station_free(struct station *station)
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
@@ -3761,6 +3762,21 @@ invalid_args:
 	return dbus_error_invalid_args(message);
 }
 =

+static struct network *station_find_network_from_bss(struct station *stati=
on,
+						struct scan_bss *bss)
+{
+	enum security security;
+	char ssid[33];
+
+	memcpy(ssid, bss->ssid, bss->ssid_len);
+	ssid[bss->ssid_len] =3D '\0';
+
+	if (station_parse_bss_security(station, bss, &security) < 0)
+		return NULL;
+
+	return station_network_find(station, ssid, security);
+}
+
 static void station_setup_diagnostic_interface(
 					struct l_dbus_interface *interface)
 {
@@ -3777,6 +3793,56 @@ static void station_destroy_diagnostic_interface(voi=
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
+	if (util_ssid_is_hidden(target->ssid_len, target->ssid))
+		return dbus_error_not_found(message);
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
@@ -3848,6 +3914,12 @@ static int station_init(void)
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
@@ -3889,6 +3961,9 @@ static void station_exit(void)
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

--===============3946459073629758187==--

