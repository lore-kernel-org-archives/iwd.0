Content-Type: multipart/mixed; boundary="===============1346591690049534136=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/6] scan: use structure for OWE transition parsing
Date: Wed, 22 Sep 2021 11:26:51 -0700
Message-ID: <20210922182655.46220-2-prestwoj@gmail.com>
In-Reply-To: 20210922182655.46220-1-prestwoj@gmail.com

--===============1346591690049534136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This changes scan_bss from using separate members for each
OWE transition element data type (ssid, ssid_len, and bssid)
to a structure that holds them all.

This is being done because OWE transition has option operating
class and channel bytes which will soon be parsed. This would
end up needing 5 separate members in scan_bss which is a bit
much for a single IE that needs to be parsed.

This makes checking the presense of the IE more convenient
as well since it can be done with a simple NULL pointer check
rather than having to l_memeqzero the BSSID.
---
 src/ie.c      | 10 ++++------
 src/ie.h      |  4 +---
 src/network.c |  9 ++-------
 src/scan.c    | 26 ++++++++++++++++----------
 src/scan.h    |  5 ++---
 src/station.c | 43 ++++++++++++++++++++++---------------------
 6 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/src/ie.c b/src/ie.c
index 0440373c..773c54e0 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -2500,9 +2500,7 @@ int ie_parse_network_cost(const void *data, size_t le=
n,
 }
 =

 int ie_parse_owe_transition(const void *data, size_t len,
-				uint8_t bssid[static 6],
-				uint8_t ssid[static 32],
-				size_t *ssid_len)
+				struct ie_owe_transition_info *info)
 {
 	const uint8_t *ie =3D data;
 	size_t slen;
@@ -2534,10 +2532,10 @@ int ie_parse_owe_transition(const void *data, size_=
t len,
 	if (len !=3D slen + 13)
 		return -ENOMSG;
 =

-	memcpy(bssid, ie + 6, 6);
+	memcpy(info->bssid, ie + 6, 6);
 =

-	memcpy(ssid, ie + 13, slen);
-	*ssid_len =3D slen;
+	memcpy(info->ssid, ie + 13, slen);
+	info->ssid_len =3D slen;
 =

 	return 0;
 }
diff --git a/src/ie.h b/src/ie.h
index 02892724..5258c6f3 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -639,6 +639,4 @@ int ie_parse_network_cost(const void *data, size_t len,
 				uint16_t *flags, uint16_t *level);
 =

 int ie_parse_owe_transition(const void *data, size_t len,
-				uint8_t bssid[static 6],
-				uint8_t ssid[static 32],
-				size_t *ssid_len);
+				struct ie_owe_transition_info *info);
diff --git a/src/network.c b/src/network.c
index 7240b029..110c8577 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1110,11 +1110,6 @@ const struct l_queue_entry *network_bss_list_get_ent=
ries(
 	return l_queue_get_entries(network->bss_list);
 }
 =

-static bool bss_is_owe(struct scan_bss *bss)
-{
-	return !l_memeqzero(bss->owe_trans_bssid, 6) && bss->rsne;
-}
-
 struct scan_bss *network_bss_select(struct network *network,
 						bool fallback_to_blacklist)
 {
@@ -1141,13 +1136,13 @@ struct scan_bss *network_bss_select(struct network =
*network,
 			candidate =3D bss;
 =

 		/* OWE Transition BSS */
-		if (!l_memeqzero(bss->owe_trans_bssid, 6)) {
+		if (!bss->owe_trans) {
 			/* Don't want to connect to the Open BSS if possible */
 			if (!bss->rsne)
 				continue;
 =

 			/* Candidate is not OWE, set this as new candidate */
-			if (!bss_is_owe(candidate))
+			if (!(candidate->owe_trans && candidate->rsne))
 				candidate =3D bss;
 		}
 =

diff --git a/src/scan.c b/src/scan.c
index 7d6e46e9..54a7bc84 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -686,8 +686,8 @@ static void add_owe_scan_cmd(struct scan_context *sc, s=
truct scan_request *sr,
 	} else
 		params.freqs =3D freqs;
 =

-	params.ssid =3D bss->owe_trans_ssid;
-	params.ssid_len =3D bss->owe_trans_ssid_len;
+	params.ssid =3D bss->owe_trans->ssid;
+	params.ssid_len =3D bss->owe_trans->ssid_len;
 	params.flush =3D true;
 =

 	cmd =3D scan_build_cmd(sc, ignore_flush, false, &params);
@@ -736,14 +736,14 @@ uint32_t scan_owe_hidden(uint64_t wdev_id, struct l_q=
ueue *list,
 =

 		/* First */
 		if (!ssid) {
-			ssid =3D bss->owe_trans_ssid;
-			ssid_len =3D bss->owe_trans_ssid_len;
+			ssid =3D bss->owe_trans->ssid;
+			ssid_len =3D bss->owe_trans->ssid_len;
 			continue;
 		}
 =

-		if (ssid_len =3D=3D bss->owe_trans_ssid_len &&
-				!memcmp(ssid, bss->owe_trans_ssid,
-				bss->owe_trans_ssid_len))
+		if (ssid_len =3D=3D bss->owe_trans->ssid_len &&
+				!memcmp(ssid, bss->owe_trans->ssid,
+				bss->owe_trans->ssid_len))
 			continue;
 =

 		same_ssid =3D false;
@@ -1060,9 +1060,14 @@ static void scan_parse_vendor_specific(struct scan_b=
ss *bss, const void *data,
 	}
 =

 	if (is_ie_wfa_ie(data, len, IE_WFA_OI_OWE_TRANSITION)) {
-		ie_parse_owe_transition(data - 2, len + 2, bss->owe_trans_bssid,
-					bss->owe_trans_ssid,
-					&bss->owe_trans_ssid_len);
+		bss->owe_trans =3D l_new(struct ie_owe_transition_info, 1);
+
+		if (ie_parse_owe_transition(data - 2, len + 2,
+						bss->owe_trans) < 0) {
+			l_free(bss->owe_trans);
+			bss->owe_trans =3D NULL;
+		}
+
 		return;
 	}
 =

@@ -1511,6 +1516,7 @@ void scan_bss_free(struct scan_bss *bss)
 	l_free(bss->osen);
 	l_free(bss->rc_ie);
 	l_free(bss->wfd);
+	l_free(bss->owe_trans);
 =

 	switch (bss->source_frame) {
 	case SCAN_BSS_PROBE_RESP:
diff --git a/src/scan.h b/src/scan.h
index 8f481f10..22981585 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -22,6 +22,7 @@
 =

 struct scan_freq_set;
 struct ie_rsn_info;
+struct ie_owe_transition_info;
 struct p2p_probe_resp;
 struct p2p_probe_req;
 struct p2p_beacon;
@@ -62,6 +63,7 @@ struct scan_bss {
 		struct p2p_probe_req *p2p_probe_req_info;
 		struct p2p_beacon *p2p_beacon_info;
 	};
+	struct ie_owe_transition_info *owe_trans;
 	uint8_t mde[3];
 	uint8_t ssid[32];
 	uint8_t ssid_len;
@@ -76,9 +78,6 @@ struct scan_bss {
 	uint64_t parent_tsf;
 	uint8_t *wfd;		/* Concatenated WFD IEs */
 	ssize_t wfd_size;	/* Size of Concatenated WFD IEs */
-	uint8_t owe_trans_ssid[32];
-	size_t owe_trans_ssid_len;
-	uint8_t owe_trans_bssid[6];
 	bool mde_present : 1;
 	bool cc_present : 1;
 	bool cap_rm_neighbor_report : 1;
diff --git a/src/station.c b/src/station.c
index d30f99b7..4a41fe05 100644
--- a/src/station.c
+++ b/src/station.c
@@ -400,8 +400,8 @@ static struct network *station_add_seen_bss(struct stat=
ion *station,
 		return NULL;
 =

 	/* Hidden OWE transition network */
-	if (security =3D=3D SECURITY_NONE && bss->rsne &&
-					!l_memeqzero(bss->owe_trans_bssid, 6)) {
+	if (security =3D=3D SECURITY_NONE && bss->rsne && bss->owe_trans) {
+		struct ie_owe_transition_info *info =3D bss->owe_trans;
 		/*
 		 * WiFi Alliance OWE Specification v1.1 - Section 2.2.1:
 		 *
@@ -420,18 +420,17 @@ static struct network *station_add_seen_bss(struct st=
ation *station,
 		 * we could not look up the network. Note that this is not true
 		 * for the open BSS IE, it can be non-utf8.
 		 */
-		if (!util_ssid_is_utf8(bss->owe_trans_ssid_len,
-					bss->owe_trans_ssid))
+		if (!util_ssid_is_utf8(info->ssid_len, info->ssid))
 			return NULL;
 =

-		if (!memcmp(bss->owe_trans_ssid, bss->ssid, bss->ssid_len))
+		if (!memcmp(info->ssid, bss->ssid, bss->ssid_len))
 			return NULL;
 =

-		if (!memcmp(bss->owe_trans_bssid, bss->addr, 6))
+		if (!memcmp(info->bssid, bss->addr, 6))
 			return NULL;
 =

-		memcpy(ssid, bss->owe_trans_ssid, sizeof(bss->owe_trans_ssid));
-		ssid[bss->owe_trans_ssid_len] =3D '\0';
+		memcpy(ssid, info->ssid, info->ssid_len);
+		ssid[info->ssid_len] =3D '\0';
 =

 		l_debug("Found hidden OWE network, using %s for network lookup",
 				ssid);
@@ -690,10 +689,12 @@ static bool station_start_anqp(struct station *statio=
n, struct network *network,
 static bool network_has_open_pair(struct network *network, struct scan_bss=
 *owe)
 {
 	const struct l_queue_entry *entry;
+	struct ie_owe_transition_info *owe_info =3D owe->owe_trans;
 =

 	for (entry =3D network_bss_list_get_entries(network); entry;
 				entry =3D entry->next) {
 		struct scan_bss *open =3D entry->data;
+		struct ie_owe_transition_info *open_info =3D open->owe_trans;
 =

 		/*
 		 * Check if this is an Open/Hidden pair:
@@ -704,14 +705,14 @@ static bool network_has_open_pair(struct network *net=
work, struct scan_bss *owe)
 		 * OWE SSID equals the SSID in Open IE
 		 * OWE BSSID equals the BSSID in Open IE
 		 */
-		if (open->ssid_len =3D=3D owe->owe_trans_ssid_len &&
-				open->owe_trans_ssid_len =3D=3D owe->ssid_len &&
-				!memcmp(open->ssid, owe->owe_trans_ssid,
+		if (open->ssid_len =3D=3D owe_info->ssid_len &&
+				open_info->ssid_len =3D=3D owe->ssid_len &&
+				!memcmp(open->ssid, owe_info->ssid,
 					open->ssid_len) &&
-				!memcmp(open->owe_trans_ssid, owe->ssid,
+				!memcmp(open_info->ssid, owe->ssid,
 					owe->ssid_len) &&
-				!memcmp(open->addr, owe->owe_trans_bssid, 6) &&
-				!memcmp(open->owe_trans_bssid, owe->addr, 6))
+				!memcmp(open->addr, owe_info->bssid, 6) &&
+				!memcmp(open_info->bssid, owe->addr, 6))
 			return true;
 	}
 =

@@ -736,10 +737,10 @@ static bool station_owe_transition_results(int err, s=
truct l_queue *bss_list,
 		 * Don't handle the open BSS, hidden BSS, BSS with no OWE
 		 * Transition IE, or an IE with a non-utf8 SSID
 		 */
-		if (!bss->rsne || l_memeqzero(bss->owe_trans_bssid, 6) ||
+		if (!bss->rsne || !bss->owe_trans ||
 				util_ssid_is_hidden(bss->ssid_len, bss->ssid) ||
-				!util_ssid_is_utf8(bss->owe_trans_ssid_len,
-							bss->owe_trans_ssid))
+				!util_ssid_is_utf8(bss->owe_trans->ssid_len,
+							bss->owe_trans->ssid))
 			goto free;
 =

 =

@@ -807,7 +808,7 @@ static void foreach_add_owe_scan(struct network *networ=
k, void *data)
 				entry =3D entry->next) {
 		struct scan_bss *open =3D entry->data;
 =

-		if (l_memeqzero(open->owe_trans_bssid, 6))
+		if (!open->owe_trans)
 			continue;
 =

 		/* only want the open networks with WFA OWE IE */
@@ -815,7 +816,7 @@ static void foreach_add_owe_scan(struct network *networ=
k, void *data)
 			continue;
 =

 		/* BSS already in network object */
-		if (network_bss_find_by_addr(network, open->owe_trans_bssid))
+		if (network_bss_find_by_addr(network, open->owe_trans->bssid))
 			continue;
 =

 		if (!list)
@@ -3037,7 +3038,7 @@ static bool station_hidden_network_scan_results(int e=
rr,
 					memcmp(bss->ssid, ssid, ssid_len))
 			goto next;
 =

-		if (!l_memeqzero(bss->owe_trans_bssid, 6))
+		if (bss->owe_trans)
 			goto next;
 =

 		/*
@@ -3134,7 +3135,7 @@ static struct l_dbus_message *station_dbus_connect_hi=
dden_network(
 		struct scan_bss *target =3D network_bss_select(network, true);
 =

 		/* Treat OWE transition networks special */
-		if (!l_memeqzero(target->owe_trans_bssid, 6))
+		if (target->owe_trans)
 			goto not_hidden;
 =

 		for (; entry; entry =3D entry->next) {
-- =

2.31.1

--===============1346591690049534136==--

