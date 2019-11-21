Content-Type: multipart/mixed; boundary="===============3653786729193139837=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/3] rrm: include actual scan start time in report
Date: Thu, 21 Nov 2019 09:28:43 -0800
Message-ID: <20191121172844.16796-2-prestwoj@gmail.com>
In-Reply-To: <20191121172844.16796-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3653786729193139837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/rrm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/rrm.c b/src/rrm.c
index 2b0a22fb..ca30a7f7 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -109,6 +109,7 @@ struct rrm_beacon_req_info {
 	char ssid[33];		/* Request filtered by SSID */
 	bool has_ssid;
 	uint32_t scan_id;
+	uint64_t scan_start_time;
 };
 =

 /* Per-netdev state */
@@ -249,8 +250,7 @@ static size_t build_report_for_bss(struct rrm_beacon_re=
q_info *beacon,
 =

 	*to++ =3D beacon->oper_class;
 	*to++ =3D scan_freq_to_channel(bss->frequency, NULL);
-	/* skip start time */
-	memset(to, 0, 8);
+	l_put_le64(beacon->scan_start_time, to);
 	to +=3D 8;
 	l_put_le16(beacon->duration, to);
 	to +=3D 2;
@@ -390,11 +390,18 @@ static bool rrm_scan_results(int err, struct l_queue =
*bss_list, void *userdata)
 static void rrm_scan_triggered(int err, void *userdata)
 {
 	struct rrm_state *rrm =3D userdata;
+	struct rrm_beacon_req_info *beacon =3D l_container_of(rrm->pending,
+						struct rrm_beacon_req_info,
+						info);
 =

 	if (err < 0) {
 		l_error("Could not start RRM scan");
 		rrm_reject_measurement_request(rrm, REPORT_REJECT_INCAPABLE);
+		return;
 	}
+
+	beacon->scan_start_time =3D scan_get_triggered_time(rrm->wdev_id,
+							beacon->scan_id);
 }
 =

 static void rrm_handle_beacon_scan(struct rrm_state *rrm,
-- =

2.17.1

--===============3653786729193139837==--

