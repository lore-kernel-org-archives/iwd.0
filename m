Content-Type: multipart/mixed; boundary="===============8907706648416972083=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/7] station: autoconnect based on network, not BSS
Date: Fri, 07 May 2021 13:26:17 -0700
Message-ID: <20210507202620.93540-4-prestwoj@gmail.com>
In-Reply-To: <20210507202620.93540-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8907706648416972083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prior to the BSS blacklist a BSS based autoconnect list made
the most sense, but now station actually retries all BSS's upon
failure. This means that for each BSS in the autoconnect list
every other BSS under that SSID will be attempted to connect to
if there is a failure. Essentially this is a network based
autoconnect list, just an indirect way of doing it.

Intead the autoconnect list can be purely network based, using
the network rank for sorting. This avoids the need for a special
autoconnect_entry struct as well as ensures the last connected
network is chosen first (simply based on existing network ranking
logic).
---
 src/station.c | 66 +++++++++++----------------------------------------
 1 file changed, 14 insertions(+), 52 deletions(-)

diff --git a/src/station.c b/src/station.c
index 479f81f5..aa9a70aa 100644
--- a/src/station.c
+++ b/src/station.c
@@ -152,12 +152,6 @@ static bool station_is_autoconnecting(struct station *=
station)
 			station->state =3D=3D STATION_STATE_AUTOCONNECT_QUICK;
 }
 =

-struct autoconnect_entry {
-	uint16_t rank;
-	struct network *network;
-	struct scan_bss *bss;
-};
-
 static void station_property_set_scanning(struct station *station,
 								bool scanning)
 {
@@ -176,25 +170,23 @@ static void station_enter_state(struct station *stati=
on,
 =

 static void station_autoconnect_next(struct station *station)
 {
-	struct autoconnect_entry *entry;
+	struct network *network;
 	int r;
 =

-	while ((entry =3D l_queue_pop_head(station->autoconnect_list))) {
-		const char *ssid =3D network_get_ssid(entry->network);
+	while ((network =3D l_queue_pop_head(station->autoconnect_list))) {
+		const char *ssid =3D network_get_ssid(network);
+		struct scan_bss *bss =3D network_bss_select(network, false);
 =

 		l_debug("Considering autoconnecting to BSS '%s' with SSID: %s,"
 			" freq: %u, rank: %u, strength: %i",
-			util_address_to_string(entry->bss->addr), ssid,
-			entry->bss->frequency, entry->rank,
-			entry->bss->signal_strength);
+			util_address_to_string(bss->addr), ssid,
+			bss->frequency, bss->rank,
+			bss->signal_strength);
 =

-		if (blacklist_contains_bss(entry->bss->addr)) {
-			l_free(entry);
+		if (blacklist_contains_bss(bss->addr))
 			continue;
-		}
 =

-		r =3D network_autoconnect(entry->network, entry->bss);
-		l_free(entry);
+		r =3D network_autoconnect(network, bss);
 =

 		if (!r) {
 			station_enter_state(station, STATION_STATE_CONNECTING);
@@ -212,33 +204,6 @@ static void station_autoconnect_next(struct station *s=
tation)
 	}
 }
 =

-static int autoconnect_rank_compare(const void *a, const void *b, void *us=
er)
-{
-	const struct autoconnect_entry *new_ae =3D a;
-	const struct autoconnect_entry *ae =3D b;
-
-	return (ae->rank > new_ae->rank) ? 1 : -1;
-}
-
-static void station_add_autoconnect_bss(struct station *station,
-					struct network *network,
-					struct scan_bss *bss)
-{
-	double rankmod;
-	struct autoconnect_entry *entry;
-
-	/* See if network is autoconnectable (is a known network) */
-	if (!network_rankmod(network, &rankmod))
-		return;
-
-	entry =3D l_new(struct autoconnect_entry, 1);
-	entry->network =3D network;
-	entry->bss =3D bss;
-	entry->rank =3D bss->rank * rankmod;
-	l_queue_insert(station->autoconnect_list, entry,
-				autoconnect_rank_compare, NULL);
-}
-
 static void bss_free(void *data)
 {
 	struct scan_bss *bss =3D data;
@@ -457,12 +422,9 @@ static bool match_nai_realms(const struct network_info=
 *info, void *user_data)
 static void network_add_foreach(struct network *network, void *user_data)
 {
 	struct station *station =3D user_data;
-	struct scan_bss *bss =3D network_bss_select(network, false);
-
-	if (!bss)
-		return;
 =

-	station_add_autoconnect_bss(station, network, bss);
+	l_queue_insert(station->autoconnect_list, network,
+				network_rank_compare, NULL);
 }
 =

 static bool match_pending(const void *a, const void *b)
@@ -553,7 +515,7 @@ request_done:
 	/* Notify all watchers now that every ANQP request has finished */
 	l_queue_foreach_remove(station->anqp_pending, anqp_entry_foreach, NULL);
 =

-	l_queue_destroy(station->autoconnect_list, l_free);
+	l_queue_destroy(station->autoconnect_list, NULL);
 	station->autoconnect_list =3D l_queue_new();
 =

 	if (station_is_autoconnecting(station)) {
@@ -662,7 +624,7 @@ void station_set_scan_results(struct station *station,
 =

 	l_queue_clear(station->hidden_bss_list_sorted, NULL);
 =

-	l_queue_destroy(station->autoconnect_list, l_free);
+	l_queue_destroy(station->autoconnect_list, NULL);
 	station->autoconnect_list =3D l_queue_new();
 =

 	station_bss_list_remove_expired_bsses(station, freqs);
@@ -3600,7 +3562,7 @@ static void station_free(struct station *station)
 	l_hashmap_destroy(station->networks, network_free);
 	l_queue_destroy(station->bss_list, bss_free);
 	l_queue_destroy(station->hidden_bss_list_sorted, NULL);
-	l_queue_destroy(station->autoconnect_list, l_free);
+	l_queue_destroy(station->autoconnect_list, NULL);
 =

 	watchlist_destroy(&station->state_watches);
 =

-- =

2.31.1

--===============8907706648416972083==--

