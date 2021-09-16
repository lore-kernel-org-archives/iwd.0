Content-Type: multipart/mixed; boundary="===============7961602740161060798=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 1/3] station: handle OWE Transition procedure
Date: Thu, 16 Sep 2021 13:49:25 -0700
Message-ID: <20210916204927.46007-1-prestwoj@gmail.com>

--===============7961602740161060798==
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
 src/station.c | 354 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 351 insertions(+), 3 deletions(-)

v4:
 * Added logic for handling multiple OWE BSS's with the same
   and different hidden SSIDs.

diff --git a/src/station.c b/src/station.c
index 2bd9ecfe..be8f49c3 100644
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
@@ -361,6 +363,44 @@ static struct network *station_add_seen_bss(struct sta=
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
@@ -625,6 +665,168 @@ static bool station_start_anqp(struct station *statio=
n, struct network *network,
 	return true;
 }
 =

+static int station_owe_scan(struct station *station, struct network *netwo=
rk);
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
+static bool network_match_ssid(const void *a, const void *b)
+{
+	const struct network *network =3D a;
+
+	return !strcmp(network_get_ssid(network), (const char *)b);
+}
+
+static void station_notify_network(struct station *station,
+					struct network *network)
+{
+	/*
+	 * If this network still exists in the list (duplicate) don't notify
+	 * yet since we may need to scan more.
+	 */
+	if (!l_queue_find(station->owe_network_list, network_match_ssid,
+				network_get_ssid(network)))
+		WATCHLIST_NOTIFY(&event_watches, station_event_watch_func_t,
+					STATION_EVENT_OWE_HIDDEN_FINISHED,
+					network);
+}
+
+/*
+ * Handling multiple BSS pairs (open/OWE) per network gets a bit nasty if =
the
+ * hidden BSS's also have the same SSID. In this case only one scan needs =
to be
+ * triggered but detecting this gets complicated trying to do so in
+ * station_set_scan_results. Further we only want to notify these networks=
 once
+ * rather than for each scan_bss we find (this is also true for OWE BSS wi=
th
+ * different SSIDs).
+ *
+ * Its somewhat easier sorting this out here because we can detect this ca=
se by
+ * the presense of duplicate network objects in the queue in addition to t=
he
+ * logic in station_owe_scan which will return -EALREADY if there is no sc=
an
+ * needed.
+ *
+ * We first pop/save save off the network associated with this current scan
+ * destructor. Then move onto the next and attempt to scan. Both for a sca=
nning
+ * error and -EALREADY nothing else needs to be done, just pop, notify if =
needed
+ * and continue to the next. On a successful scan set the scan ID, notify,=
 and
+ * wait for the next scan results.
+ */
+static void station_owe_transition_destroy(void *userdata)
+{
+	struct station *station =3D userdata;
+	struct network *last =3D l_queue_pop_head(station->owe_network_list);
+	struct network *network =3D l_queue_peek_head(station->owe_network_list);
+	int ret;
+
+	while (network) {
+		ret =3D station_owe_scan(station, network);
+		/*
+		 * Error, or this network already has its hidden OWE BSS's. In
+		 * This case pop this network, notify, and move onto the next.
+		 */
+		if (ret =3D=3D -EALREADY || ret =3D=3D 0) {
+			l_queue_pop_head(station->owe_network_list);
+
+			/* The 'last' network gets notified below */
+			if (network !=3D last)
+				station_notify_network(station, network);
+
+			network =3D l_queue_peek_head(station->owe_network_list);
+			continue;
+		}
+
+		station->owe_transition_scan_id =3D ret;
+
+		break;
+	}
+
+	station_notify_network(station, last);
+
+	if (station->owe_transition_scan_id > 0)
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
@@ -641,6 +843,132 @@ static bool bss_free_if_ssid_not_utf8(void *data, voi=
d *user_data)
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
+static int station_owe_scan(struct station *station, struct network *netwo=
rk)
+{
+	unsigned int id;
+	struct scan_freq_set *freqs =3D NULL;
+	struct scan_parameters params =3D {
+		.flush =3D true,
+	};
+	const struct l_queue_entry *entry;
+	struct scan_bss *open =3D NULL;
+
+	/*
+	 * Special case here for networks with multiple Open BSS's. We need to
+	 * find any open BSS's which have not yet been scanned for, i.e. they
+	 * do not have a paired OWE BSS in the network list.
+	 */
+	for (entry =3D network_bss_list_get_entries(network); entry;
+						entry =3D entry->next) {
+		struct scan_bss *bss =3D entry->data;
+
+		if (bss->rsne)
+			continue;
+
+		/* If network already has the OWE BSS */
+		if (network_bss_find_by_addr(network, bss->owe_trans_bssid))
+			continue;
+
+		open =3D bss;
+	}
+
+	if (!open)
+		return -EALREADY;
+
+	/* TODO: Add support for different channel/band info */
+	freqs =3D scan_freq_set_new();
+	scan_freq_set_add(freqs, open->frequency);
+
+	params.freqs =3D freqs;
+	params.ssid =3D open->owe_trans_ssid;
+	params.ssid_len =3D open->owe_trans_ssid_len;
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
+	int ret;
+
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
+	if (!station->owe_transition_scan_id) {
+		ret =3D station_owe_scan(station, network);
+		/* Already have the OWE BSS */
+		if (ret =3D=3D -EALREADY)
+			return false;
+
+		station->owe_transition_scan_id =3D ret;
+	}
+
+	if (!station->owe_transition_scan_id) {
+		l_error("Could not scan for hidden OWE network %s",
+				util_ssid_to_utf8(bss->owe_trans_ssid_len,
+							bss->owe_trans_ssid));
+		return false;
+	}
+
+	if (!station->owe_network_list)
+		station->owe_network_list =3D l_queue_new();
+
+	/*
+	 * Network may have already been added in the case of multiple Open
+	 * BSS's. We do still want to push the network here but only notify
+	 * this network once.
+	 */
+	if (!l_queue_find(station->owe_network_list, network_match_ssid,
+				network_get_ssid(network)))
+		WATCHLIST_NOTIFY(&event_watches, station_event_watch_func_t,
+				STATION_EVENT_OWE_HIDDEN_STARTED, network);
+
+	l_queue_push_tail(station->owe_network_list, network);
+
+	return true;
+}
+
 /*
  * Used when scan results were obtained; either from scan running
  * inside station module or scans running in other state machines, e.g. wsc
@@ -652,7 +980,7 @@ void station_set_scan_results(struct station *station,
 {
 	const struct l_queue_entry *bss_entry;
 	struct network *network;
-	bool wait_for_anqp =3D false;
+	bool wait =3D false;
 =

 	l_queue_foreach_remove(new_bss_list, bss_free_if_ssid_not_utf8, NULL);
 =

@@ -699,15 +1027,22 @@ void station_set_scan_results(struct station *statio=
n,
 		if (!network)
 			continue;
 =

+		/* Cached BSS entry, this should be handled already */
+		if (!scan_freq_set_contains(freqs, bss->frequency))
+			continue;
+
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
@@ -2812,6 +3147,9 @@ static bool station_hidden_network_scan_results(int e=
rr,
 					memcmp(bss->ssid, ssid, ssid_len))
 			goto next;
 =

+		if (!l_memeqzero(bss->owe_trans_bssid, 6))
+			goto next;
+
 		/*
 		 * Override time_stamp so that this entry is removed on
 		 * the next scan
@@ -2905,6 +3243,10 @@ static struct l_dbus_message *station_dbus_connect_h=
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

@@ -2916,6 +3258,7 @@ static struct l_dbus_message *station_dbus_connect_hi=
dden_network(
 								message);
 		}
 =

+not_hidden:
 		return dbus_error_not_hidden(message);
 	}
 =

@@ -3677,9 +4020,14 @@ static void station_free(struct station *station)
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

--===============7961602740161060798==--

