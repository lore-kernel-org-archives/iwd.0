Content-Type: multipart/mixed; boundary="===============7406296023612811115=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 2/4] ap: add support for scanning while in AP mode
Date: Mon, 28 Feb 2022 10:49:37 -0800
Message-ID: <20220228184939.3150560-2-prestwoj@gmail.com>
In-Reply-To: 20220228184939.3150560-1-prestwoj@gmail.com

--===============7406296023612811115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Scanning while in AP mode is somewhat of an edge case, but it does
have some usefulness specifically with onboarding new devices, i.e.
a new device starts an AP, a station connects and provides the new
device with network credentials, the new device switches to station
mode and connects to the desired network.

In addition this could be used later for ACS (though this is a bit
overkill for IWD's access point needs).

Since AP performance is basically non-existant while scanning this
feature is meant to be used in a limited scope.

Two DBus API's were added which mirror the station interface: Scan and
GetOrderedNetworks.

Scan is no different than the station variant, and will perform an active
scan on all channels.

GetOrderedNetworks diverges from station and simply returns an array of
dictionaries containing basic information about networks:

{
    Name: <ssid>
    SignalStrength: <mBm>
    Security: <psk, open, or 8021x>
}

Limitations:
 - Hidden networks are not supported. This isn't really possible since
   the SSID's are unknown from the AP perspective.

 - Sharing scan results with station is not supported. This would be a
   convenient improvement in the future with respect to onboarding new
   devices. The scan could be performed in AP mode, then switch to
   station and connect immediately without needing to rescan. A quick
   hack could better this situation by not flushing scan results in
   station (if the kernel retains these on an iftype change).
---
 src/ap.c | 248 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 248 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index 6f3dfa60..7b705c9c 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -58,6 +58,7 @@
 #include "src/storage.h"
 #include "src/diagnostic.h"
 #include "src/band.h"
+#include "src/common.h"
 =

 struct ap_state {
 	struct netdev *netdev;
@@ -99,11 +100,16 @@ struct ap_state {
 	uint8_t netconfig_gateway4_mac[6];
 	uint8_t netconfig_dns4_mac[6];
 =

+	uint32_t scan_id;
+	struct l_dbus_message *scan_pending;
+	struct l_queue *networks;
+
 	bool started : 1;
 	bool gtk_set : 1;
 	bool netconfig_set_addr4 : 1;
 	bool in_event : 1;
 	bool free_pending : 1;
+	bool scanning : 1;
 };
 =

 struct sta_state {
@@ -136,10 +142,76 @@ struct ap_wsc_pbc_probe_record {
 	uint64_t timestamp;
 };
 =

+struct ap_network {
+	char ssid[33];
+	int16_t signal;
+	enum security security;
+};
+
 static char **global_addr4_strs;
 static uint32_t netdev_watch;
 static struct l_netlink *rtnl;
 =

+static bool network_match_ssid(const void *a, const void *b)
+{
+	const struct ap_network *network =3D a;
+	const char *ssid =3D b;
+
+	return !strcmp(network->ssid, ssid);
+}
+
+static int network_signal_compare(const void *a, const void *b, void *user)
+{
+	const struct ap_network *new_network =3D a;
+	const struct ap_network *network =3D b;
+
+	return (network->signal > new_network->signal) ? 1 : -1;
+}
+
+static struct ap_network *ap_network_find(struct ap_state *ap,
+						struct scan_bss *bss)
+{
+	char ssid[33];
+
+	memcpy(ssid, bss->ssid, bss->ssid_len);
+	ssid[bss->ssid_len] =3D '\0';
+
+	return l_queue_find(ap->networks, network_match_ssid, ssid);
+}
+
+static void ap_network_append(struct ap_state *ap, struct scan_bss *bss)
+{
+	struct ap_network *network;
+	enum security security;
+
+	if (util_ssid_is_hidden(bss->ssid_len, bss->ssid))
+		return;
+
+	network =3D ap_network_find(ap, bss);
+	if (!network) {
+		if (scan_bss_get_security(bss, &security) < 0)
+			return;
+
+		network =3D l_new(struct ap_network, 1);
+		network->signal =3D bss->signal_strength;
+		network->security =3D security;
+
+		memcpy(network->ssid, bss->ssid, bss->ssid_len);
+		network->ssid[bss->ssid_len] =3D '\0';
+
+		goto insert;
+	}
+
+	if (bss->signal_strength <=3D network->signal)
+		return;
+
+	l_queue_remove(ap->networks, network);
+	network->signal =3D bss->signal_strength;
+
+insert:
+	l_queue_insert(ap->networks, network, network_signal_compare, NULL);
+}
+
 static void ap_stop_handshake(struct sta_state *sta)
 {
 	if (sta->sm) {
@@ -257,6 +329,16 @@ static void ap_reset(struct ap_state *ap)
 		l_dhcp_server_destroy(ap->netconfig_dhcp);
 		ap->netconfig_dhcp =3D NULL;
 	}
+
+	if (ap->scan_id) {
+		scan_cancel(netdev_get_wdev_id(ap->netdev), ap->scan_id);
+		ap->scan_id =3D 0;
+	}
+
+	if (ap->networks) {
+		l_queue_destroy(ap->networks, l_free);
+		ap->networks =3D NULL;
+	}
 }
 =

 static bool ap_event_done(struct ap_state *ap, bool prev_in_event)
@@ -3207,6 +3289,7 @@ struct ap_state *ap_start(struct netdev *netdev, stru=
ct l_settings *config,
 	ap->ciphers =3D wiphy_select_cipher(wiphy, 0xffff);
 	ap->group_cipher =3D wiphy_select_cipher(wiphy, 0xffff);
 	ap->beacon_interval =3D 100;
+	ap->networks =3D l_queue_new();
 =

 	wsc_uuid_from_addr(netdev_get_address(netdev), ap->wsc_uuid_r);
 =

@@ -3670,6 +3753,147 @@ error:
 	return dbus_error_from_errno(err, message);
 }
 =

+static void ap_set_scanning(struct ap_state *ap, bool scanning)
+{
+	if (ap->scanning =3D=3D scanning)
+		return;
+
+	ap->scanning =3D scanning;
+
+	l_dbus_property_changed(dbus_get_bus(), netdev_get_path(ap->netdev),
+					IWD_AP_INTERFACE, "Scanning");
+}
+
+static void ap_scan_triggered(int err, void *user_data)
+{
+	struct ap_state *ap =3D user_data;
+	struct l_dbus_message *reply;
+
+	if (err < 0) {
+		reply =3D dbus_error_from_errno(err, ap->scan_pending);
+		dbus_pending_reply(&ap->scan_pending, reply);
+		return;
+	}
+
+	l_debug("AP scan triggered for %s", netdev_get_name(ap->netdev));
+
+	reply =3D l_dbus_message_new_method_return(ap->scan_pending);
+	l_dbus_message_set_arguments(reply, "");
+	dbus_pending_reply(&ap->scan_pending, reply);
+
+	ap_set_scanning(ap, true);
+}
+
+static bool ap_scan_notify(int err, struct l_queue *bss_list,
+				const struct scan_freq_set *freqs,
+				void *user_data)
+{
+	struct ap_state *ap =3D user_data;
+	const struct l_queue_entry *bss_entry;
+
+	ap_set_scanning(ap, false);
+
+	/* Remove all networks, then re-populate with fresh BSS list */
+	l_queue_clear(ap->networks, l_free);
+
+	for (bss_entry =3D l_queue_get_entries(bss_list); bss_entry;
+						bss_entry =3D bss_entry->next) {
+		struct scan_bss *bss =3D bss_entry->data;
+
+		ap_network_append(ap, bss);
+	}
+
+	l_debug("");
+
+	return false;
+}
+
+static void ap_scan_destroy(void *user_data)
+{
+	struct ap_state *ap =3D user_data;
+
+	ap->scan_id =3D 0;
+}
+
+static struct l_dbus_message *ap_dbus_scan(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct ap_if_data *ap_if =3D user_data;
+	uint64_t wdev_id =3D netdev_get_wdev_id(ap_if->netdev);
+	struct scan_parameters params =3D { 0};
+
+	if (wiphy_has_feature(wiphy_find_by_wdev(wdev_id),
+				NL80211_FEATURE_AP_SCAN))
+		params.ap_scan =3D true;
+
+	/*
+	 * TODO: There is really nothing preventing scanning while stopped.
+	 *       The only consideration would be if a scan is ongoing and the
+	 *       AP is started. Queuing Start() as wiphy work may be required to
+	 *       handle this case if needed. For now just limit to started APs.
+	 */
+	if (!ap_if->ap || !ap_if->ap->started)
+		return dbus_error_not_available(message);
+
+	if (ap_if->ap->scan_id)
+		return dbus_error_busy(message);
+
+	ap_if->ap->scan_id =3D scan_active_full(wdev_id, &params,
+						ap_scan_triggered,
+						ap_scan_notify,
+						ap_if->ap, ap_scan_destroy);
+	if (!ap_if->ap->scan_id)
+		return dbus_error_failed(message);
+
+	ap_if->ap->scan_pending =3D l_dbus_message_ref(message);
+
+	return NULL;
+}
+
+static void dbus_append_network(struct l_dbus_message_builder *builder,
+					struct ap_network *network)
+{
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	dbus_append_dict_basic(builder, "Name", 's', network->ssid);
+	dbus_append_dict_basic(builder, "SignalStrength", 'n',
+					&network->signal);
+	dbus_append_dict_basic(builder, "Type", 's',
+					security_to_str(network->security));
+	l_dbus_message_builder_leave_array(builder);
+}
+
+static struct l_dbus_message *ap_dbus_get_networks(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct ap_if_data *ap_if =3D user_data;
+	struct l_dbus_message *reply;
+	struct l_dbus_message_builder *builder;
+	const struct l_queue_entry *entry;
+
+	if (!ap_if->ap || !ap_if->ap->started)
+		return dbus_error_not_available(message);
+
+	reply =3D l_dbus_message_new_method_return(message);
+	builder =3D l_dbus_message_builder_new(reply);
+
+	l_dbus_message_builder_enter_array(builder, "a{sv}");
+
+	for (entry =3D l_queue_get_entries(ap_if->ap->networks); entry;
+							entry =3D entry->next) {
+		struct ap_network *network =3D entry->data;
+
+		dbus_append_network(builder, network);
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	return reply;
+}
+
 static bool ap_dbus_property_get_started(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -3699,6 +3923,24 @@ static bool ap_dbus_property_get_name(struct l_dbus =
*dbus,
 	return true;
 }
 =

+static bool ap_dbus_property_get_scanning(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct ap_if_data *ap_if =3D user_data;
+	bool bval;
+
+	if (!ap_if->ap || !ap_if->ap->started)
+		return false;
+
+	bval =3D ap_if->ap->scanning;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &bval);
+
+	return true;
+}
+
 static void ap_setup_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "Start", 0, ap_dbus_start, "",
@@ -3707,11 +3949,17 @@ static void ap_setup_interface(struct l_dbus_interf=
ace *interface)
 	l_dbus_interface_method(interface, "StartProfile", 0,
 					ap_dbus_start_profile, "", "s",
 					"ssid");
+	l_dbus_interface_method(interface, "Scan", 0, ap_dbus_scan, "", "");
+	l_dbus_interface_method(interface, "GetOrderedNetworks", 0,
+					ap_dbus_get_networks, "aa{sv}",
+					"", "networks");
 =

 	l_dbus_interface_property(interface, "Started", 0, "b",
 					ap_dbus_property_get_started, NULL);
 	l_dbus_interface_property(interface, "Name", 0, "s",
 					ap_dbus_property_get_name, NULL);
+	l_dbus_interface_property(interface, "Scanning", 0, "b",
+					ap_dbus_property_get_scanning, NULL);
 }
 =

 static void ap_destroy_interface(void *user_data)
-- =

2.34.1

--===============7406296023612811115==--

