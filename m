Content-Type: multipart/mixed; boundary="===============6355511891703236775=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] scan: add scan_get_firmware_scan
Date: Mon, 15 Mar 2021 10:29:28 -0700
Message-ID: <20210315172931.173107-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6355511891703236775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds support for getting firmware scan results from the kernel.
This is intended to be used after the firmware roamed automatically
and the scan result is require for handshake initialization.

The scan 'request' is competely separate from the normal scan
queue, though scan_results, scan_request, and the scan_context
are all used for consistency and code reuse.
---
 src/scan.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/scan.h |  3 +++
 2 files changed, 79 insertions(+)

v2:
 * It was found GET_SCAN could be used to grab actual scan
   results rather than trying to gather up sparse info from
   GET_STATION/GET_INTERFACE. This also allows reuse of existing
   scan parsing code.

diff --git a/src/scan.c b/src/scan.c
index 1ec7335b..a77e5b34 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -100,6 +100,11 @@ struct scan_context {
 	unsigned int start_cmd_id;
 	/* Non-zero if GET_SCAN is still running */
 	unsigned int get_scan_cmd_id;
+	/*
+	 * Special request used for getting scan results after the firmware
+	 * roamed automatically.
+	 */
+	unsigned int get_fw_scan_cmd_id;
 	/*
 	 * Whether the top request in the queue has triggered the current
 	 * scan.  May be set and cleared multiple times during a single
@@ -208,6 +213,9 @@ static void scan_context_free(struct scan_context *sc)
 	if (sc->get_scan_cmd_id && nl80211)
 		l_genl_family_cancel(nl80211, sc->get_scan_cmd_id);
 =

+	if (sc->get_fw_scan_cmd_id && nl80211)
+		l_genl_family_cancel(nl80211, sc->get_fw_scan_cmd_id);
+
 	l_free(sc);
 }
 =

@@ -845,6 +853,74 @@ uint64_t scan_get_triggered_time(uint64_t wdev_id, uin=
t32_t id)
 	return sr->start_time_tsf;
 }
 =

+static void get_fw_scan_done(void *userdata)
+{
+	struct scan_results *results =3D userdata;
+	struct scan_request *sr =3D results->sr;
+	struct scan_context *sc =3D results->sc;
+	int err =3D l_queue_length(results->bss_list) =3D=3D 0 ? -ENOENT : 0;
+	bool new_owner =3D false;
+
+	sc->get_fw_scan_cmd_id =3D 0;
+
+	if (sr->callback)
+		new_owner =3D sr->callback(err, results->bss_list, NULL,
+						sr->userdata);
+
+	if (!new_owner)
+		l_queue_destroy(results->bss_list,
+				(l_queue_destroy_func_t) scan_bss_free);
+
+	if (sr->destroy)
+		sr->destroy(sr->userdata);
+
+	l_free(sr);
+	l_free(results);
+}
+
+static void get_scan_callback(struct l_genl_msg *msg, void *user_data);
+
+bool scan_get_firmware_scan(uint64_t wdev_id, scan_notify_func_t notify,
+				void *userdata, scan_destroy_func_t destroy)
+{
+	struct l_genl_msg *scan_msg;
+	struct scan_results *results;
+	struct scan_request *sr;
+	struct scan_context *sc =3D l_queue_find(scan_contexts,
+						scan_context_match, &wdev_id);
+
+	if (!sc)
+		return false;
+
+	sr =3D l_new(struct scan_request, 1);
+	sr->callback =3D notify;
+	sr->destroy =3D destroy;
+	sr->userdata =3D userdata;
+
+	results =3D l_new(struct scan_results, 1);
+	results->sc =3D sc;
+	results->time_stamp =3D l_time_now();
+	results->bss_list =3D l_queue_new();
+	results->sr =3D sr;
+
+	scan_msg =3D l_genl_msg_new_sized(NL80211_CMD_GET_SCAN, 8);
+	l_genl_msg_append_attr(scan_msg, NL80211_ATTR_WDEV, 8, &sc->wdev_id);
+
+	sc->get_fw_scan_cmd_id =3D l_genl_family_dump(nl80211, scan_msg,
+							get_scan_callback,
+							results,
+							get_fw_scan_done);
+	if (!sc->get_fw_scan_cmd_id) {
+		l_queue_destroy(results->bss_list,
+				(l_queue_destroy_func_t) scan_bss_free);
+		l_free(results);
+		l_free(sr);
+		return false;
+	}
+
+	return true;
+}
+
 static void scan_periodic_timeout(struct l_timeout *timeout, void *user_da=
ta)
 {
 	struct scan_context *sc =3D user_data;
diff --git a/src/scan.h b/src/scan.h
index 355b4b5a..498e8b2a 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -151,6 +151,9 @@ bool scan_periodic_stop(uint64_t wdev_id);
 =

 uint64_t scan_get_triggered_time(uint64_t wdev_id, uint32_t id);
 =

+bool scan_get_firmware_scan(uint64_t wdev_id, scan_notify_func_t notify,
+				void *userdata, scan_destroy_func_t destroy);
+
 void scan_bss_free(struct scan_bss *bss);
 int scan_bss_rank_compare(const void *a, const void *b, void *user);
 =

-- =

2.26.2

--===============6355511891703236775==--

