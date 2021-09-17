Content-Type: multipart/mixed; boundary="===============9213910022956626496=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v5 2/4] station: handle OWE Transition procedure
Date: Fri, 17 Sep 2021 12:39:02 -0700
Message-ID: <20210917193904.16413-2-prestwoj@gmail.com>
In-Reply-To: 20210917193904.16413-1-prestwoj@gmail.com

--===============9213910022956626496==
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
   in it. Add this BSS to a list to scan for the hidden OWE
   BSS.

3. The BSS is not open and contains the OWE IE. This BSS will
   automatically get added to the network object and nothing else
   needs to be done.

The populated BSS list is passed to scan_owe_hidden. The results
should contain only the (previously hidden) OWE BSS's. These BSS's
should contain the OWE IE which is used to look up the original
open networks. If found the OWE BSS's are added to their respective
networks, and network is notified.

>From here network.c can detect that this is an OWE transition
network and connect to the OWE BSS rather than the open one.
---
 src/station.c | 264 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 264 insertions(+)

v5:
 * Changed logic to use new scan_owe_hidden API. This takes the
   burden off station to sort out SSID's/frequencies, as well as
   consolidates all scan results into a single callback which is
   much easier to process.

diff --git a/src/station.c b/src/station.c
index e9bc7e65..29523795 100644
--- a/src/station.c
+++ b/src/station.c
@@ -87,6 +87,8 @@ struct station {
 	uint32_t dbus_scan_id;
 	uint32_t quick_scan_id;
 	uint32_t hidden_network_scan_id;
+	uint32_t owe_transition_scan_id;
+	struct l_queue* owe_scan_list;
 =

 	/* Roaming related members */
 	struct timespec roam_min_time;
@@ -254,6 +256,9 @@ static void station_autoconnect_start(struct station *s=
tation)
 	if (!l_queue_isempty(station->anqp_pending))
 		return;
 =

+	if (station->owe_transition_scan_id)
+		return;
+
 	if (L_WARN_ON(station->autoconnect_list))
 		l_queue_destroy(station->autoconnect_list, NULL);
 =

@@ -395,6 +400,44 @@ static struct network *station_add_seen_bss(struct sta=
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
@@ -645,6 +688,139 @@ static bool station_start_anqp(struct station *statio=
n, struct network *network,
 	return true;
 }
 =

+static bool owe_open_bss_match(const void *a, const void *b)
+{
+	const struct scan_bss *open =3D a;
+	const struct scan_bss *owe =3D b;
+
+	/*
+	 * Check if this is an Open/Hidden pair:
+	 *
+	 * Open SSID equals the SSID in OWE IE
+	 * Open BSSID equals the BSSID in OWE IE
+	 *
+	 * OWE SSID equals the SSID in Open IE
+	 * OWE BSSID equals the BSSID in Open IE
+	 */
+	return open->ssid_len =3D=3D owe->owe_trans_ssid_len &&
+		open->owe_trans_ssid_len =3D=3D owe->ssid_len &&
+		!memcmp(open->ssid, owe->owe_trans_ssid, open->ssid_len) &&
+		!memcmp(open->owe_trans_ssid, owe->ssid, owe->ssid_len) &&
+		!memcmp(open->addr, owe->owe_trans_bssid, 6) &&
+		!memcmp(open->owe_trans_bssid, owe->addr, 6);
+}
+
+static bool bss_match_ssid(const void *a, const void *b)
+{
+	const struct scan_bss *bss =3D a;
+	const struct scan_bss *bss_new =3D b;
+
+	return bss->ssid_len =3D=3D bss_new->ssid_len &&
+			!memcmp(bss->ssid, bss_new->ssid, bss->ssid_len);
+}
+
+static bool station_owe_transition_results(int err, struct l_queue *bss_li=
st,
+					const struct scan_freq_set *freqs,
+					void *userdata)
+{
+	struct station *station =3D userdata;
+	struct network *network;
+	struct scan_bss *bss;
+
+	station->owe_transition_scan_id =3D 0;
+
+	station_property_set_scanning(station, false);
+
+	if (err)
+		return err =3D=3D 0;
+
+	while ((bss =3D l_queue_pop_head(bss_list))) {
+		struct scan_bss *open;
+
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
+		/* Check if we have an open BSS that matches */
+		open =3D l_queue_find(station->owe_scan_list,
+					owe_open_bss_match, bss);
+		if (!open)
+			goto free;
+
+		network =3D station_network_find(station,
+				util_ssid_to_utf8(open->ssid_len, open->ssid),
+				SECURITY_NONE);
+		if (L_WARN_ON(!network))
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
+	/* Networks get notified in destroy */
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
+	struct network *network;
+	struct scan_bss *open;
+
+	while ((open =3D l_queue_pop_head(station->owe_scan_list))) {
+		network =3D station_network_find(station,
+				util_ssid_to_utf8(open->ssid_len, open->ssid),
+				SECURITY_NONE);
+		if (L_WARN_ON(!network))
+			continue;
+
+		/*
+		 * Check if there are any pending BSS's with the same SSID we
+		 * only want to notify network once.
+		 */
+		if (!l_queue_find(station->owe_scan_list, bss_match_ssid, open))
+			WATCHLIST_NOTIFY(&event_watches,
+					station_event_watch_func_t,
+					STATION_EVENT_OWE_HIDDEN_FINISHED,
+					network);
+	}
+
+	l_queue_destroy(station->owe_scan_list, NULL);
+	station->owe_scan_list =3D NULL;
+
+	station_autoconnect_start(station);
+}
+
 static bool bss_free_if_ssid_not_utf8(void *data, void *user_data)
 {
 	struct scan_bss *bss =3D data;
@@ -661,6 +837,80 @@ static bool bss_free_if_ssid_not_utf8(void *data, void=
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
+static bool station_build_owe_list(struct station *station,
+					struct l_queue *bss_list,
+					struct scan_bss *bss,
+					struct network *network,
+					struct l_queue **list)
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
+	if (!*list)
+		*list =3D l_queue_new();
+
+	/*
+	 * The network for this BSS may have already been notified in the case
+	 * of multiple Open BSS's. We do still want to push the BSS here in case
+	 * the frequency is different but only notify this network once.
+	 */
+	if (!l_queue_find(*list, bss_match_ssid, bss))
+		WATCHLIST_NOTIFY(&event_watches, station_event_watch_func_t,
+				STATION_EVENT_OWE_HIDDEN_STARTED, network);
+
+	l_queue_push_head(*list, bss);
+
+	return true;
+}
+
+static bool station_start_owe_scan(struct station *station,
+					struct l_queue *list)
+{
+	station->owe_transition_scan_id =3D scan_owe_hidden(
+					netdev_get_wdev_id(station->netdev),
+					list, station_owe_transition_triggered,
+					station_owe_transition_results, station,
+					station_owe_transition_destroy);
+	if (!station->owe_transition_scan_id)
+		return false;
+
+	station->owe_scan_list =3D list;
+
+	return true;
+}
+
 /*
  * Used when scan results were obtained; either from scan running
  * inside station module or scans running in other state machines, e.g. wsc
@@ -672,6 +922,7 @@ void station_set_scan_results(struct station *station,
 {
 	const struct l_queue_entry *bss_entry;
 	struct network *network;
+	struct l_queue *owe_scan_list =3D NULL;
 =

 	l_queue_foreach_remove(new_bss_list, bss_free_if_ssid_not_utf8, NULL);
 =

@@ -723,6 +974,14 @@ void station_set_scan_results(struct station *station,
 			continue;
 =

 		station_start_anqp(station, network, bss);
+
+		station_build_owe_list(station, new_bss_list, bss, network,
+					&owe_scan_list);
+	}
+
+	if (owe_scan_list) {
+		if (!station_start_owe_scan(station, owe_scan_list))
+			l_queue_destroy(owe_scan_list, NULL);
 	}
 =

 	station->bss_list =3D new_bss_list;
@@ -3705,9 +3964,14 @@ static void station_free(struct station *station)
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
+	l_queue_destroy(station->owe_scan_list, NULL);
 	l_hashmap_destroy(station->networks, network_free);
 	l_queue_destroy(station->bss_list, bss_free);
 	l_queue_destroy(station->hidden_bss_list_sorted, NULL);
-- =

2.31.1

--===============9213910022956626496==--

