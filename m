Content-Type: multipart/mixed; boundary="===============7157910911443453859=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v7 3/5] station: handle OWE Transition procedure
Date: Fri, 17 Sep 2021 15:58:38 -0700
Message-ID: <20210917225840.26848-3-prestwoj@gmail.com>
In-Reply-To: 20210917225840.26848-1-prestwoj@gmail.com

--===============7157910911443453859==
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
   in it. This will be processed after scan results.

3. The BSS is not open and contains the OWE IE. This BSS will
   automatically get added to the network object and nothing else
   needs to be done.

After the scan results each network is checked for any non-paired
open BSS's. If found a scan is started for these BSS's per-network.
Once these scan results come in the network is notified.

>From here network.c can detect that this is an OWE transition
network and connect to the OWE BSS rather than the open one.
---
 src/station.c | 221 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 221 insertions(+)

diff --git a/src/station.c b/src/station.c
index e9bc7e65..d30f99b7 100644
--- a/src/station.c
+++ b/src/station.c
@@ -87,6 +87,7 @@ struct station {
 	uint32_t dbus_scan_id;
 	uint32_t quick_scan_id;
 	uint32_t hidden_network_scan_id;
+	struct l_queue *owe_hidden_scan_ids;
 =

 	/* Roaming related members */
 	struct timespec roam_min_time;
@@ -254,6 +255,9 @@ static void station_autoconnect_start(struct station *s=
tation)
 	if (!l_queue_isempty(station->anqp_pending))
 		return;
 =

+	if (!l_queue_isempty(station->owe_hidden_scan_ids))
+		return;
+
 	if (L_WARN_ON(station->autoconnect_list))
 		l_queue_destroy(station->autoconnect_list, NULL);
 =

@@ -395,6 +399,44 @@ static struct network *station_add_seen_bss(struct sta=
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
+		 *
+		 * In addition this SSID must be a valid utf8 string otherwise
+		 * we could not look up the network. Note that this is not true
+		 * for the open BSS IE, it can be non-utf8.
+		 */
+		if (!util_ssid_is_utf8(bss->owe_trans_ssid_len,
+					bss->owe_trans_ssid))
+			return NULL;
+
+		if (!memcmp(bss->owe_trans_ssid, bss->ssid, bss->ssid_len))
+			return NULL;
+
+		if (!memcmp(bss->owe_trans_bssid, bss->addr, 6))
+			return NULL;
+
+		memcpy(ssid, bss->owe_trans_ssid, sizeof(bss->owe_trans_ssid));
+		ssid[bss->owe_trans_ssid_len] =3D '\0';
+
+		l_debug("Found hidden OWE network, using %s for network lookup",
+				ssid);
+	}
+
 	path =3D iwd_network_get_path(station, ssid, security);
 =

 	network =3D l_hashmap_lookup(station->networks, path);
@@ -645,6 +687,169 @@ static bool station_start_anqp(struct station *statio=
n, struct network *network,
 	return true;
 }
 =

+static bool network_has_open_pair(struct network *network, struct scan_bss=
 *owe)
+{
+	const struct l_queue_entry *entry;
+
+	for (entry =3D network_bss_list_get_entries(network); entry;
+				entry =3D entry->next) {
+		struct scan_bss *open =3D entry->data;
+
+		/*
+		 * Check if this is an Open/Hidden pair:
+		 *
+		 * Open SSID equals the SSID in OWE IE
+		 * Open BSSID equals the BSSID in OWE IE
+		 *
+		 * OWE SSID equals the SSID in Open IE
+		 * OWE BSSID equals the BSSID in Open IE
+		 */
+		if (open->ssid_len =3D=3D owe->owe_trans_ssid_len &&
+				open->owe_trans_ssid_len =3D=3D owe->ssid_len &&
+				!memcmp(open->ssid, owe->owe_trans_ssid,
+					open->ssid_len) &&
+				!memcmp(open->owe_trans_ssid, owe->ssid,
+					owe->ssid_len) &&
+				!memcmp(open->addr, owe->owe_trans_bssid, 6) &&
+				!memcmp(open->owe_trans_bssid, owe->addr, 6))
+			return true;
+	}
+
+	return false;
+}
+
+static bool station_owe_transition_results(int err, struct l_queue *bss_li=
st,
+					const struct scan_freq_set *freqs,
+					void *userdata)
+{
+	struct network *network =3D userdata;
+	struct station *station =3D network_get_station(network);
+	struct scan_bss *bss;
+
+	station_property_set_scanning(station, false);
+
+	if (err)
+		goto done;
+
+	while ((bss =3D l_queue_pop_head(bss_list))) {
+		/*
+		 * Don't handle the open BSS, hidden BSS, BSS with no OWE
+		 * Transition IE, or an IE with a non-utf8 SSID
+		 */
+		if (!bss->rsne || l_memeqzero(bss->owe_trans_bssid, 6) ||
+				util_ssid_is_hidden(bss->ssid_len, bss->ssid) ||
+				!util_ssid_is_utf8(bss->owe_trans_ssid_len,
+							bss->owe_trans_ssid))
+			goto free;
+
+
+		/* Check if we have an open BSS that matches */
+		if (!network_has_open_pair(network, bss))
+			goto free;
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
+done:
+	l_queue_pop_head(station->owe_hidden_scan_ids);
+
+	WATCHLIST_NOTIFY(&event_watches, station_event_watch_func_t,
+				STATION_EVENT_OWE_HIDDEN_FINISHED, network);
+
+	station_autoconnect_start(station);
+
+	return err =3D=3D 0;
+}
+
+static void station_owe_transition_triggered(int err, void *user_data)
+{
+	struct network *network =3D user_data;
+	struct station *station =3D network_get_station(network);
+
+	if (err < 0) {
+		l_debug("OWE transition scan trigger failed: %i", err);
+
+		l_queue_pop_head(station->owe_hidden_scan_ids);
+
+		WATCHLIST_NOTIFY(&event_watches, station_event_watch_func_t,
+				STATION_EVENT_OWE_HIDDEN_FINISHED, network);
+
+		return;
+	}
+
+	l_debug("OWE transition scan triggered");
+
+	station_property_set_scanning(station, true);
+}
+
+static void foreach_add_owe_scan(struct network *network, void *data)
+{
+	struct station *station =3D data;
+	const struct l_queue_entry *entry;
+	struct l_queue *list =3D NULL;
+	uint32_t id;
+
+	if (network_get_security(network) !=3D SECURITY_NONE)
+		return;
+
+	for (entry =3D network_bss_list_get_entries(network); entry;
+				entry =3D entry->next) {
+		struct scan_bss *open =3D entry->data;
+
+		if (l_memeqzero(open->owe_trans_bssid, 6))
+			continue;
+
+		/* only want the open networks with WFA OWE IE */
+		if (open->rsne)
+			continue;
+
+		/* BSS already in network object */
+		if (network_bss_find_by_addr(network, open->owe_trans_bssid))
+			continue;
+
+		if (!list)
+			list =3D l_queue_new();
+
+		l_queue_push_tail(list, open);
+	}
+
+	if (!list)
+		return;
+
+	id =3D scan_owe_hidden(netdev_get_wdev_id(station->netdev), list,
+				station_owe_transition_triggered,
+				station_owe_transition_results, network, NULL);
+
+	l_queue_destroy(list, NULL);
+
+	if (!id)
+		return;
+
+	if (!station->owe_hidden_scan_ids)
+		station->owe_hidden_scan_ids =3D l_queue_new();
+
+	l_queue_push_tail(station->owe_hidden_scan_ids, L_UINT_TO_PTR(id));
+
+	WATCHLIST_NOTIFY(&event_watches, station_event_watch_func_t,
+				STATION_EVENT_OWE_HIDDEN_STARTED, network);
+}
+
+static void station_process_owe_transition_networks(struct station *statio=
n)
+{
+	station_network_foreach(station, foreach_add_owe_scan, station);
+}
+
 static bool bss_free_if_ssid_not_utf8(void *data, void *user_data)
 {
 	struct scan_bss *bss =3D data;
@@ -991,6 +1196,8 @@ static bool new_scan_results(int err, struct l_queue *=
bss_list,
 =

 	station_set_scan_results(station, bss_list, freqs, true);
 =

+	station_process_owe_transition_networks(station);
+
 	return true;
 }
 =

@@ -1061,6 +1268,8 @@ static bool station_quick_scan_results(int err, struc=
t l_queue *bss_list,
 =

 	station_set_scan_results(station, bss_list, freqs, true);
 =

+	station_process_owe_transition_networks(station);
+
 done:
 	if (station->state =3D=3D STATION_STATE_AUTOCONNECT_QUICK)
 		/*
@@ -3155,6 +3364,8 @@ static void station_dbus_scan_done(struct station *st=
ation,
 	station->dbus_scan_id =3D 0;
 	station_property_set_scanning(station, false);
 =

+	station_process_owe_transition_networks(station);
+
 	if (try_autoconnect) {
 		station->autoconnect_can_start =3D true;
 		station_autoconnect_start(station);
@@ -3705,6 +3916,16 @@ static void station_free(struct station *station)
 		scan_cancel(netdev_get_wdev_id(station->netdev),
 				station->hidden_network_scan_id);
 =

+	if (station->owe_hidden_scan_ids) {
+		void *ptr;
+
+		while ((ptr =3D l_queue_pop_head(station->owe_hidden_scan_ids)))
+			scan_cancel(netdev_get_wdev_id(station->netdev),
+					L_PTR_TO_UINT(ptr));
+
+		l_queue_destroy(station->owe_hidden_scan_ids, NULL);
+	}
+
 	station_roam_state_clear(station);
 =

 	l_queue_destroy(station->networks_sorted, NULL);
-- =

2.31.1

--===============7157910911443453859==--

