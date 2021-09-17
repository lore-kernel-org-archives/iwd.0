Content-Type: multipart/mixed; boundary="===============6823582095043118484=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v6 1/5] scan: add scan API specifically for OWE transition
 networks
Date: Fri, 17 Sep 2021 14:36:18 -0700
Message-ID: <20210917213622.21881-1-prestwoj@gmail.com>

--===============6823582095043118484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Specifically OWE networks with multiple open/hidden BSS's are troublesome
to scan for with the current APIs. The scan parameters are limited to a
single SSID and even if that was changed we have the potential of hitting
the max SSID's per scan limit. In all, it puts the burden onto the caller
to sort out the SSIDs/frequencies to scan for.

Rather than requiring station to handle this a new scan API was added,
scan_owe_hidden() which takes a list of open BSS's and will automatically
scan for the SSIDs in the OWE transition IE for each.

It is slightly optimized to first check if all the hidden SSID's are the
same. This is the most likely case (e.g. single pair or single network)
and a single scan command can be used. Otherwise individual scan commands
are queued for each SSID/frequency combo.
---
 src/scan.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 src/scan.h |   3 ++
 2 files changed, 134 insertions(+), 8 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index b2f199e5..7d6e46e9 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -583,6 +583,27 @@ static const struct wiphy_radio_work_item_ops work_ops=
 =3D {
 	.destroy =3D scan_request_free,
 };
 =

+static struct scan_request *scan_request_new(struct scan_context *sc,
+						bool passive,
+						scan_trigger_func_t trigger,
+						scan_notify_func_t notify,
+						void *userdata,
+						scan_destroy_func_t destroy)
+{
+	struct scan_request *sr;
+
+	sr =3D l_new(struct scan_request, 1);
+	sr->sc =3D sc;
+	sr->trigger =3D trigger;
+	sr->callback =3D notify;
+	sr->userdata =3D userdata;
+	sr->destroy =3D destroy;
+	sr->passive =3D passive;
+	sr->cmds =3D l_queue_new();
+
+	return sr;
+}
+
 static uint32_t scan_common(uint64_t wdev_id, bool passive,
 				const struct scan_parameters *params,
 				scan_trigger_func_t trigger,
@@ -597,14 +618,7 @@ static uint32_t scan_common(uint64_t wdev_id, bool pas=
sive,
 	if (!sc)
 		return 0;
 =

-	sr =3D l_new(struct scan_request, 1);
-	sr->sc =3D sc;
-	sr->trigger =3D trigger;
-	sr->callback =3D notify;
-	sr->userdata =3D userdata;
-	sr->destroy =3D destroy;
-	sr->passive =3D passive;
-	sr->cmds =3D l_queue_new();
+	sr =3D scan_request_new(sc, passive, trigger, notify, userdata, destroy);
 =

 	scan_cmds_add(sr->cmds, sc, passive, params);
 =

@@ -656,6 +670,115 @@ uint32_t scan_active_full(uint64_t wdev_id,
 					trigger, notify, userdata, destroy);
 }
 =

+static void add_owe_scan_cmd(struct scan_context *sc, struct scan_request =
*sr,
+				bool ignore_flush,
+				struct scan_freq_set *freqs,
+				const struct scan_bss *bss)
+{
+	struct l_genl_msg *cmd;
+	struct scan_parameters params =3D {};
+	struct scan_freq_set *tmp;
+
+	if (!freqs) {
+		tmp =3D scan_freq_set_new();
+		scan_freq_set_add(tmp, bss->frequency);
+		params.freqs =3D tmp;
+	} else
+		params.freqs =3D freqs;
+
+	params.ssid =3D bss->owe_trans_ssid;
+	params.ssid_len =3D bss->owe_trans_ssid_len;
+	params.flush =3D true;
+
+	cmd =3D scan_build_cmd(sc, ignore_flush, false, &params);
+
+	l_genl_msg_enter_nested(cmd, NL80211_ATTR_SCAN_SSIDS);
+	l_genl_msg_append_attr(cmd, 0, params.ssid_len, params.ssid);
+	l_genl_msg_leave_nested(cmd);
+
+	l_queue_push_tail(sr->cmds, cmd);
+
+	if (!freqs)
+		scan_freq_set_free(tmp);
+}
+
+uint32_t scan_owe_hidden(uint64_t wdev_id, struct l_queue *list,
+			scan_trigger_func_t trigger, scan_notify_func_t notify,
+			void *userdata, scan_destroy_func_t destroy)
+{
+	struct scan_context *sc;
+	struct scan_request *sr;
+	struct scan_freq_set *freqs;
+	const struct l_queue_entry *entry;
+	const uint8_t *ssid =3D NULL;
+	size_t ssid_len;
+	bool same_ssid =3D true;
+	struct scan_bss *bss;
+	bool ignore_flush =3D false;
+
+	sc =3D l_queue_find(scan_contexts, scan_context_match, &wdev_id);
+
+	if (!sc)
+		return 0;
+
+	sr =3D scan_request_new(sc, false, trigger, notify, userdata, destroy);
+
+	freqs =3D scan_freq_set_new();
+
+	/*
+	 * Start building up a frequency list if all SSIDs are the same. This
+	 * is hopefully the common case and will allow a single scan command.
+	 */
+	for (entry =3D l_queue_get_entries(list); entry; entry =3D entry->next) {
+		bss =3D entry->data;
+
+		scan_freq_set_add(freqs, bss->frequency);
+
+		/* First */
+		if (!ssid) {
+			ssid =3D bss->owe_trans_ssid;
+			ssid_len =3D bss->owe_trans_ssid_len;
+			continue;
+		}
+
+		if (ssid_len =3D=3D bss->owe_trans_ssid_len &&
+				!memcmp(ssid, bss->owe_trans_ssid,
+				bss->owe_trans_ssid_len))
+			continue;
+
+		same_ssid =3D false;
+		break;
+	}
+
+	if (same_ssid) {
+		bss =3D l_queue_peek_head(list);
+
+		add_owe_scan_cmd(sc, sr, ignore_flush, freqs, bss);
+
+		scan_freq_set_free(freqs);
+
+		goto done;
+	}
+
+	scan_freq_set_free(freqs);
+
+	/* SSIDs differed, use separate scan commands. */
+	for (entry =3D l_queue_get_entries(list); entry; entry =3D entry->next) {
+		bss =3D entry->data;
+
+		add_owe_scan_cmd(sc, sr, ignore_flush, NULL, bss);
+
+		/* Ignore flush on all subsequent commands */
+		if (!ignore_flush)
+			ignore_flush =3D true;
+	}
+
+done:
+	l_queue_push_tail(sc->requests, sr);
+
+	return wiphy_radio_work_insert(sc->wiphy, &sr->work, 2, &work_ops);
+}
+
 bool scan_cancel(uint64_t wdev_id, uint32_t id)
 {
 	struct scan_context *sc;
diff --git a/src/scan.h b/src/scan.h
index 99c66bb8..8f481f10 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -147,6 +147,9 @@ uint32_t scan_active_full(uint64_t wdev_id,
 			const struct scan_parameters *params,
 			scan_trigger_func_t trigger, scan_notify_func_t notify,
 			void *userdata, scan_destroy_func_t destroy);
+uint32_t scan_owe_hidden(uint64_t wdev_id, struct l_queue *list,
+			scan_trigger_func_t trigger, scan_notify_func_t notify,
+			void *userdata, scan_destroy_func_t destroy);
 bool scan_cancel(uint64_t wdev_id, uint32_t id);
 =

 void scan_periodic_start(uint64_t wdev_id, scan_trigger_func_t trigger,
-- =

2.31.1

--===============6823582095043118484==--

