Content-Type: multipart/mixed; boundary="===============2577620286521238010=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/6] scan: Drop unused frequency list parsing
Date: Tue, 29 Sep 2020 18:37:07 +0200
Message-ID: <20200929163717.754459-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200929163717.754459-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2577620286521238010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
I have sent this once or twice before but this code is still
unused.

 src/scan.c | 53 -----------------------------------------------------
 1 file changed, 53 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index b4135d7c..fe780f51 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -115,7 +115,6 @@ struct scan_context {
 struct scan_results {
 	struct scan_context *sc;
 	struct l_queue *bss_list;
-	struct scan_freq_set *freqs;
 	uint64_t time_stamp;
 	struct scan_request *sr;
 };
@@ -1200,28 +1199,6 @@ fail:
 	return NULL;
 }
 =

-static struct scan_freq_set *scan_parse_attr_scan_frequencies(
-						struct l_genl_attr *attr)
-{
-	uint16_t type, len;
-	const void *data;
-	struct scan_freq_set *set;
-
-	set =3D scan_freq_set_new();
-
-	while (l_genl_attr_next(attr, &type, &len, &data)) {
-		uint32_t freq;
-
-		if (len !=3D sizeof(uint32_t))
-			continue;
-
-		freq =3D *((uint32_t *) data);
-		scan_freq_set_add(set, freq);
-	}
-
-	return set;
-}
-
 static struct scan_bss *scan_parse_result(struct l_genl_msg *msg,
 						uint64_t *out_wdev)
 {
@@ -1541,9 +1518,6 @@ static void get_scan_done(void *user)
 		l_queue_destroy(results->bss_list,
 				(l_queue_destroy_func_t) scan_bss_free);
 =

-	if (results->freqs)
-		scan_freq_set_free(results->freqs);
-
 	l_free(results);
 }
 =

@@ -1563,31 +1537,6 @@ static bool scan_parse_flush_flag_from_msg(struct l_=
genl_msg *msg)
 	return false;
 }
 =

-static void scan_parse_new_scan_results(struct l_genl_msg *msg,
-					struct scan_results *results)
-{
-	struct l_genl_attr attr, nested;
-	uint16_t type, len;
-	const void *data;
-
-	if (!l_genl_attr_init(&attr, msg))
-		return;
-
-	while (l_genl_attr_next(&attr, &type, &len, &data)) {
-		switch (type) {
-		case NL80211_ATTR_SCAN_FREQUENCIES:
-			if (!l_genl_attr_recurse(&attr, &nested)) {
-				l_warn("Failed to parse ATTR_SCAN_FREQUENCIES");
-				break;
-			}
-
-			results->freqs =3D
-				scan_parse_attr_scan_frequencies(&nested);
-			break;
-		}
-	}
-}
-
 static void scan_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct l_genl_attr attr;
@@ -1706,8 +1655,6 @@ static void scan_notify(struct l_genl_msg *msg, void =
*user_data)
 		results->sr =3D sr;
 		results->bss_list =3D l_queue_new();
 =

-		scan_parse_new_scan_results(msg, results);
-
 		scan_msg =3D l_genl_msg_new_sized(NL80211_CMD_GET_SCAN, 8);
 		l_genl_msg_append_attr(scan_msg, NL80211_ATTR_WDEV, 8,
 					&sc->wdev_id);
-- =

2.25.1

--===============2577620286521238010==--

