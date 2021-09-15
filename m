Content-Type: multipart/mixed; boundary="===============7442356700267078652=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 5/7] station: handle OWE Transition procedure
Date: Wed, 15 Sep 2021 16:05:46 -0700
Message-ID: <20210915230548.179425-5-prestwoj@gmail.com>
In-Reply-To: 20210915230548.179425-1-prestwoj@gmail.com

--===============7442356700267078652==
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
 src/station.c | 248 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 245 insertions(+), 3 deletions(-)

v2:
 * Changed to use individual scans, this simplifies things and
   removes a bunch of lookup logic.

diff --git a/src/station.c b/src/station.c
index 6de5fd4a..dfdd2e9b 100644
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
@@ -625,6 +656,112 @@ static bool station_start_anqp(struct station *statio=
n, struct network *network,
 	return true;
 }
 =

+static unsigned int station_owe_scan(struct station *station,
+					struct network *network);
+
+static bool station_owe_transition_results(int err, struct l_queue *bss_li=
st,
+					const struct scan_freq_set *freqs,
+					void *userdata)
+{
+	struct station *station =3D userdata;
+	struct network *network =3D l_queue_peek_head(station->owe_network_list);
+	struct scan_bss *bss;
+
+	station->owe_transition_scan_id =3D 0;
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
+		/* Check if the Open network IE matches the BSS we have */
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
+	l_debug("OWE transition scan triggered");
+
+	station_property_set_scanning(station, true);
+}
+
+static void station_owe_transition_destroy(void *userdata)
+{
+	struct station *station =3D userdata;
+	struct network *network =3D l_queue_pop_head(station->owe_network_list);
+
+	WATCHLIST_NOTIFY(&event_watches, station_event_watch_func_t,
+				STATION_EVENT_OWE_HIDDEN_FINISHED, network);
+
+	network =3D l_queue_peek_head(station->owe_network_list);
+	if (network)
+		station->owe_transition_scan_id =3D station_owe_scan(station,
+								network);
+
+	/* More ongoing scans */
+	if (station->owe_transition_scan_id)
+		return;
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
 static bool bss_free_if_ssid_not_utf8(void *data, void *user_data)
 {
 	struct scan_bss *bss =3D data;
@@ -641,6 +778,98 @@ static bool bss_free_if_ssid_not_utf8(void *data, void=
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
+static unsigned int station_owe_scan(struct station *station,
+					struct network *network)
+{
+	unsigned int id;
+	struct scan_freq_set *freqs =3D NULL;
+	struct scan_parameters params =3D {
+		.flush =3D true,
+		.randomize_mac_addr_hint =3D false,
+	};
+	/*
+	 * Should be ok doing this as this network will only have a single open
+	 * BSS. This is ensured by the checks in station_start_owe_scan()
+	 */
+	struct scan_bss *open =3D network_bss_select(network, true);
+
+	freqs =3D scan_freq_set_new();
+	/* TODO: Add support for different channel/band info */
+	scan_freq_set_add(freqs, open->frequency);
+
+	params.freqs =3D freqs;
+	params.ssid =3D open->owe_trans_ssid;
+
+	id =3D scan_active_full(netdev_get_wdev_id(station->netdev),
+				&params, station_owe_transition_triggered,
+				station_owe_transition_results, station,
+				station_owe_transition_destroy);
+
+	scan_freq_set_free(freqs);
+
+	return id;
+}
+
+static bool station_start_owe_scan(struct station *station,
+					struct l_queue *bss_list,
+					struct scan_bss *bss,
+					struct network *network)
+{
+	if (l_memeqzero(bss->owe_trans_bssid, 6))
+		return false;
+
+	/* only want the open networks with WFA OWE IE */
+	if (bss->rsne)
+		return false;
+
+	/* BSS already in network object */
+	if (network_bss_find_by_addr(network, bss->owe_trans_bssid))
+		return false;
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
+		return false;
+
+	if (!station->owe_transition_scan_id)
+		station->owe_transition_scan_id =3D station_owe_scan(station,
+								network);
+	if (!station->owe_transition_scan_id) {
+		l_error("Could not scan for hidden OWE network %s",
+				bss->owe_trans_ssid);
+		return false;
+	}
+
+	WATCHLIST_NOTIFY(&event_watches, station_event_watch_func_t,
+				STATION_EVENT_OWE_HIDDEN_STARTED, network);
+
+	if (!station->owe_network_list)
+		station->owe_network_list =3D l_queue_new();
+
+	l_queue_push_tail(station->owe_network_list, network);
+
+	return true;
+}
+
 /*
  * Used when scan results were obtained; either from scan running
  * inside station module or scans running in other state machines, e.g. wsc
@@ -652,7 +881,7 @@ void station_set_scan_results(struct station *station,
 {
 	const struct l_queue_entry *bss_entry;
 	struct network *network;
-	bool wait_for_anqp =3D false;
+	bool wait =3D false;
 =

 	l_queue_foreach_remove(new_bss_list, bss_free_if_ssid_not_utf8, NULL);
 =

@@ -700,14 +929,17 @@ void station_set_scan_results(struct station *station,
 			continue;
 =

 		if (station_start_anqp(station, network, bss))
-			wait_for_anqp =3D true;
+			wait =3D true;
+
+		if (station_start_owe_scan(station, new_bss_list, bss, network))
+			wait =3D true;
 	}
 =

 	station->bss_list =3D new_bss_list;
 =

 	l_hashmap_foreach_remove(station->networks, process_network, station);
 =

-	if (!wait_for_anqp && add_to_autoconnect) {
+	if (!wait && add_to_autoconnect) {
 		station_network_foreach(station, network_add_foreach, station);
 		station_autoconnect_next(station);
 	}
@@ -2902,6 +3134,10 @@ static struct l_dbus_message *station_dbus_connect_h=
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

@@ -2913,6 +3149,7 @@ static struct l_dbus_message *station_dbus_connect_hi=
dden_network(
 								message);
 		}
 =

+not_hidden:
 		return dbus_error_not_hidden(message);
 	}
 =

@@ -3673,9 +3910,14 @@ static void station_free(struct station *station)
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

--===============7442356700267078652==--

