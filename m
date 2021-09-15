Content-Type: multipart/mixed; boundary="===============2995366481786845488=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 09/13] station: handle OWE Transition procedure
Date: Wed, 15 Sep 2021 10:36:20 -0700
Message-ID: <20210915173624.11917-9-prestwoj@gmail.com>
In-Reply-To: 20210915173624.11917-1-prestwoj@gmail.com

--===============2995366481786845488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

OWE Transition is described in the WiFi Alliance OWE Specification
version 1.1. The idea behind it is to support both legacy devices
without any concept of OWE as well as modern ones which support the
OWE protocol.

OWE is a somewhat special type of network. Where it advertises an
RSN element but is still "open". This apparently confuses older
devices so the OWE transition procedure was created.

The idea is simple: have two BSS's, one open, and one as a hidden
OWE network. Each network advertises a vendor IE which points to the
other. A device sees the open network and can connect (legacy) or
parse the IE, scan for the hidden OWE network, and connect to that
instead.

Care was taken to handle connections to hidden networks directly.
The policy is being set that any hidden network with the WFA OWE IE
is not connectable via ConnectHiddenNetwork(). These networks are
special, and can only be connected to via the network object for
the paired open network.

When scan results come in from any source (DBus, quick, autoconnect)
each BSS is checked for the OWE Transition IE. A few paths can be
taken here when the IE is found:

1. The BSS is open. The BSSID in the IE is checked against the
   current scan results (excluding hidden networks). If a match is
   found we should already have the hidden OWE BSS and nothing
   else needs to be done (3).

2. The BSS is open. The BSSID in the IE is not found in the
   current scan results, and the open network also has no OWE BSS
   in it. Add this network to a list to scan for the hidden OWE
   BSS.

3. The BSS is not open and contains the OWE IE. This BSS will
   automatically get added to the network object and nothing else
   needs to be done.

After processing and networks added to this hidden OWE scan list
are processed. Each network should contain a single open BSS with
the OWE IE. The SSID from the IEs are added to the scan parameters
and the scan is started.

The scan results should contain only the (previously hidden) OWE
BSS's. These BSS's should contain the OWE IE which is used to look
up the original open networks. If found the OWE BSS's are added to
their respective networks.

>From here network.c can detect that this is an OWE transition
network and connect to the OWE BSS rather than the open one.
---
 src/station.c | 309 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 300 insertions(+), 9 deletions(-)

diff --git a/src/station.c b/src/station.c
index 8a28b9a8..b40b98aa 100644
--- a/src/station.c
+++ b/src/station.c
@@ -87,6 +87,8 @@ struct station {
 	uint32_t dbus_scan_id;
 	uint32_t quick_scan_id;
 	uint32_t hidden_network_scan_id;
+	uint32_t owe_transition_scan_id;
+	struct l_queue* owe_network_list;
 =

 	/* Roaming related members */
 	struct timespec roam_min_time;
@@ -361,6 +363,35 @@ static struct network *station_add_seen_bss(struct sta=
tion *station,
 	if (station_parse_bss_security(station, bss, &security) < 0)
 		return NULL;
 =

+	/* Hidden OWE transition network */
+	if (security =3D=3D SECURITY_NONE && bss->rsne &&
+					!l_memeqzero(bss->owe_trans_bssid, 6)) {
+		/*
+		 * WiFi Alliance OWE Specification v1.1 - Section 2.2.1:
+		 *
+		 * "2. An OWE AP shall use two different SSIDs, one for OWE
+		 *     and one for Open"
+		 *
+		 * "4. The OWE BSS shall include the OWE Transition Mode element
+		 *     in all Beacon and Probe Response frames to encapsulate
+		 *     the BSSID and SSID of the Open BSS"
+		 *
+		 * Meaning the hidden SSID should not match the SSID in the
+		 * hidden network's OWE IE. Might as well restrict BSSID as well
+		 * to be safe.
+		 */
+		if (!memcmp(bss->owe_trans_ssid, bss->ssid, bss->ssid_len))
+			return NULL;
+
+		if (!memcmp(bss->owe_trans_bssid, bss->addr, 6))
+			return NULL;
+
+		memcpy(ssid, bss->owe_trans_ssid, sizeof(bss->owe_trans_ssid));
+
+		l_debug("Found hidden OWE network, using %s for network lookup",
+				ssid);
+	}
+
 	path =3D iwd_network_get_path(station, ssid, security);
 =

 	network =3D l_hashmap_lookup(station->networks, path);
@@ -625,6 +656,210 @@ static bool station_start_anqp(struct station *statio=
n, struct network *network,
 	return true;
 }
 =

+static bool bss_match_bssid(const void *a, const void *b)
+{
+	const struct scan_bss *bss =3D a;
+	const uint8_t *bssid =3D b;
+
+	return !memcmp(bss->addr, bssid, sizeof(bss->addr));
+}
+
+static bool network_match_ssid(const void *a, const void *b)
+{
+	const struct network *network =3D a;
+	const char *ssid =3D b;
+
+	return !strcmp(network_get_ssid(network), ssid);
+}
+
+static void foreach_owe_hidden_started(void *data, void *user_data)
+{
+	struct network *network =3D data;
+
+	WATCHLIST_NOTIFY(&event_watches, station_event_watch_func_t,
+				STATION_EVENT_OWE_HIDDEN_STARTED, network);
+}
+
+static void foreach_owe_hidden_finished(void *data)
+{
+	struct network *network =3D data;
+
+	WATCHLIST_NOTIFY(&event_watches, station_event_watch_func_t,
+				STATION_EVENT_OWE_HIDDEN_FINISHED, network);
+}
+
+static bool station_owe_transition_results(int err, struct l_queue *bss_li=
st,
+					const struct scan_freq_set *freqs,
+					void *userdata)
+{
+	struct station *station =3D userdata;
+	struct scan_bss *bss;
+
+	station_property_set_scanning(station, false);
+
+	if (err)
+		return err =3D=3D 0;
+
+	/*
+	 * Insert all BSS's into station/network BSS list but don't create a
+	 * network for them. The idea here is for the user to connect to the
+	 * open network and IWD will transition them to the OWE network
+	 * automatically.
+	 */
+	while ((bss =3D l_queue_pop_head(bss_list))) {
+		struct network *network;
+		struct scan_bss *open;
+
+		/*
+		 * Don't parse the open BSS, hidden BSS, or BSS with
+		 * no OWE Transition IE
+		 */
+		if (!bss->rsne || l_memeqzero(bss->owe_trans_bssid, 6) ||
+				util_ssid_is_hidden(bss->ssid_len, bss->ssid))
+			goto free;
+
+		network =3D l_queue_find(station->owe_network_list,
+					network_match_ssid,
+					bss->owe_trans_ssid);
+		if (!network) {
+			l_warn("No open network %s found", bss->owe_trans_ssid);
+			goto free;
+		}
+
+		/*
+		 * Check if the Open network IE matches the BSS we have. If not
+		 * don't add this BSS. We should always find an open network
+		 * here since the lookup above succeeded, but just in case
+		 * don't continue.
+		 */
+		open =3D network_bss_find_by_addr(network, bss->owe_trans_bssid);
+		if (!open)
+			goto free;
+
+		if (memcmp(open->owe_trans_bssid, bss->addr, 6)) {
+			l_warn("BSS in results did not match Open OWE IE!");
+			goto free;
+		}
+
+		l_debug("Adding OWE transition network "MAC" to %s",
+				MAC_STR(bss->addr), network_get_ssid(network));
+
+		l_queue_push_tail(station->bss_list, bss);
+		network_bss_add(network, bss);
+
+		continue;
+
+free:
+		scan_bss_free(bss);
+	}
+
+	l_queue_destroy(bss_list, NULL);
+
+	return true;
+}
+
+static void station_owe_transition_triggered(int err, void *user_data)
+{
+	struct station *station =3D user_data;
+
+	if (err < 0) {
+		l_debug("OWE transition scan trigger failed: %i", err);
+		return;
+	}
+
+	l_debug("OWE transition scan triggered for %s",
+					netdev_get_name(station->netdev));
+
+	station_property_set_scanning(station, true);
+}
+
+static void station_owe_transition_destroy(void *userdata)
+{
+	struct station *station =3D userdata;
+
+	/*
+	 * Signal done to all networks. This needs to happen regardless of a
+	 * successful hidden scan.
+	 */
+	l_queue_destroy(station->owe_network_list, foreach_owe_hidden_finished);
+	station->owe_network_list =3D NULL;
+
+	station->owe_transition_scan_id =3D 0;
+
+	/*
+	 * Must resume autoconnect here regardless of an error since this logic
+	 * was bypassed in station_set_scan_results
+	 */
+	l_queue_destroy(station->autoconnect_list, NULL);
+	station->autoconnect_list =3D l_queue_new();
+
+	if (station_is_autoconnecting(station)) {
+		station_network_foreach(station, network_add_foreach, station);
+		station_autoconnect_next(station);
+	}
+}
+
+static void station_owe_transition_scan(struct station *station)
+{
+	struct scan_freq_set *freqs =3D NULL;
+	char **ssids =3D NULL;
+	const struct l_queue_entry *network_entry;
+	struct scan_parameters params =3D {
+		.flush =3D true,
+		.randomize_mac_addr_hint =3D false,
+	};
+
+	for (network_entry =3D l_queue_get_entries(station->owe_network_list);
+			network_entry; network_entry =3D network_entry->next) {
+		/*
+		 * Using network_bss_select here should be safe. The network
+		 * should not contain any hidden OWE networks yet. This is
+		 * guaranteed by station_build_owe_scan.
+		 */
+		struct network *network =3D network_entry->data;
+		struct scan_bss *bss =3D network_bss_select(network, true);
+
+		if (!ssids)
+			ssids =3D l_strv_new();
+
+		if (!freqs)
+			freqs =3D scan_freq_set_new();
+
+		ssids =3D l_strv_append(ssids, bss->owe_trans_ssid);
+		scan_freq_set_add(freqs, bss->frequency);
+
+		l_debug("OWE transition network found (%s) "MAC,
+					bss->owe_trans_ssid,
+					MAC_STR(bss->owe_trans_bssid));
+	}
+
+	params.freqs =3D freqs;
+	params.ssids =3D (const char **)ssids;
+
+	l_debug("Starting OWE transition scan");
+
+	station->owe_transition_scan_id =3D scan_active_full(
+					netdev_get_wdev_id(station->netdev),
+					&params,
+					station_owe_transition_triggered,
+					station_owe_transition_results, station,
+					station_owe_transition_destroy);
+
+	scan_freq_set_free(freqs);
+	l_strv_free(ssids);
+
+	if (station->owe_transition_scan_id) {
+		l_queue_foreach(station->owe_network_list,
+				foreach_owe_hidden_started, station);
+		return;
+	}
+
+	l_error("Error scanning for hidden OWE networks");
+
+	l_queue_destroy(station->owe_network_list, NULL);
+	station->owe_network_list =3D NULL;
+}
+
 static bool bss_free_if_ssid_not_utf8(void *data, void *user_data)
 {
 	struct scan_bss *bss =3D data;
@@ -641,6 +876,52 @@ static bool bss_free_if_ssid_not_utf8(void *data, void=
 *user_data)
 	return true;
 }
 =

+static bool match_bssid_not_hidden(const void *a, const void *b)
+{
+	const struct scan_bss *bss =3D a;
+	const uint8_t *bssid =3D b;
+
+	if (util_ssid_is_hidden(bss->ssid_len, bss->ssid))
+		return false;
+
+	return !memcmp(bss->addr, bssid, sizeof(bss->addr));
+}
+
+static void station_build_owe_scan(struct station *station,
+					struct l_queue *bss_list,
+					struct scan_bss *bss,
+					struct network *network)
+{
+	if (station->owe_transition_scan_id)
+		return;
+
+	/* only want the open networks with WFA OWE IE */
+	if (bss->rsne)
+		return;
+
+	/* BSS already in network object */
+	if (network_bss_find_by_addr(network, bss->owe_trans_bssid))
+		return;
+
+	/*
+	 * If the BSSID of the Open OWE IE is in the results we
+	 * are done. station_add_seen_bss will add this to the
+	 * network object.
+	 *
+	 * This is required if the Open BSS appears first in the
+	 * new_bss_list and the OWE network hasn't had a chance
+	 * to get added to the network.
+	 */
+	if (l_queue_find(bss_list, match_bssid_not_hidden,
+				bss->owe_trans_bssid))
+		return;
+
+	if (!station->owe_network_list)
+		station->owe_network_list =3D l_queue_new();
+
+	l_queue_push_tail(station->owe_network_list, network);
+}
+
 /*
  * Used when scan results were obtained; either from scan running
  * inside station module or scans running in other state machines, e.g. wsc
@@ -701,13 +982,21 @@ void station_set_scan_results(struct station *station,
 =

 		if (station_start_anqp(station, network, bss))
 			wait_for_anqp =3D true;
+
+		/* Network with OWE Transition IE */
+		if (!l_memeqzero(bss->owe_trans_bssid, 6))
+			station_build_owe_scan(station, new_bss_list,
+						bss, network);
 	}
 =

+	if (station->owe_network_list)
+		station_owe_transition_scan(station);
+
 	station->bss_list =3D new_bss_list;
 =

 	l_hashmap_foreach_remove(station->networks, process_network, station);
 =

-	if (!wait_for_anqp && add_to_autoconnect) {
+	if (!wait_for_anqp && !station->owe_network_list && add_to_autoconnect) {
 		station_network_foreach(station, network_add_foreach, station);
 		station_autoconnect_next(station);
 	}
@@ -1650,14 +1939,6 @@ static void station_transition_reassociate(struct st=
ation *station,
 	station_enter_state(station, STATION_STATE_ROAMING);
 }
 =

-static bool bss_match_bssid(const void *a, const void *b)
-{
-	const struct scan_bss *bss =3D a;
-	const uint8_t *bssid =3D b;
-
-	return !memcmp(bss->addr, bssid, sizeof(bss->addr));
-}
-
 static void station_preauthenticate_cb(struct netdev *netdev,
 					enum netdev_result result,
 					const uint8_t *pmk, void *user_data)
@@ -2906,6 +3187,10 @@ static struct l_dbus_message *station_dbus_connect_h=
idden_network(
 			l_queue_get_entries(station->hidden_bss_list_sorted);
 		struct scan_bss *target =3D network_bss_select(network, true);
 =

+		/* Treat OWE transition networks special */
+		if (!l_memeqzero(target->owe_trans_bssid, 6))
+			goto not_hidden;
+
 		for (; entry; entry =3D entry->next) {
 			struct scan_bss *bss =3D entry->data;
 =

@@ -2917,6 +3202,7 @@ static struct l_dbus_message *station_dbus_connect_hi=
dden_network(
 								message);
 		}
 =

+not_hidden:
 		return dbus_error_not_hidden(message);
 	}
 =

@@ -3678,9 +3964,14 @@ static void station_free(struct station *station)
 		scan_cancel(netdev_get_wdev_id(station->netdev),
 				station->hidden_network_scan_id);
 =

+	if (station->owe_transition_scan_id)
+		scan_cancel(netdev_get_wdev_id(station->netdev),
+				station->owe_transition_scan_id);
+
 	station_roam_state_clear(station);
 =

 	l_queue_destroy(station->networks_sorted, NULL);
+	l_queue_destroy(station->owe_network_list, NULL);
 	l_hashmap_destroy(station->networks, network_free);
 	l_queue_destroy(station->bss_list, bss_free);
 	l_queue_destroy(station->hidden_bss_list_sorted, NULL);
-- =

2.31.1

--===============2995366481786845488==--

