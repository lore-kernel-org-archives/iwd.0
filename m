Content-Type: multipart/mixed; boundary="===============0650365916968034563=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/3] scan: parse the scan start time
Date: Thu, 21 Nov 2019 09:28:42 -0800
Message-ID: <20191121172844.16796-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0650365916968034563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The kernel sends NL80211_ATTR_SCAN_START_TIME_TSF with CMD_TRIGGER and
RRM requires this value for beacon measurement reports.

The start time is parsed during CMD_TRIGGER and set into the scan context.
A getter was added to obtain this time value for an already triggered
scan.
---
 src/scan.c | 31 +++++++++++++++++++++++++++++++
 src/scan.h |  2 ++
 2 files changed, 33 insertions(+)

-v3:
 * Added getter for scan triggered time rather than storing it in each
   bss individually.

diff --git a/src/scan.c b/src/scan.c
index e007ce5d..43e4cb84 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -91,6 +91,9 @@ struct scan_context {
 	unsigned int start_cmd_id;
 	/* Non-zero if GET_SCAN is still running */
 	unsigned int get_scan_cmd_id;
+
+	/* The time the current scan was started. Reported in TRIGGER_SCAN */
+	uint64_t start_time_tsf;
 	/*
 	 * Whether the top request in the queue has triggered the current
 	 * scan.  May be set and cleared multiple times during a single
@@ -778,6 +781,25 @@ bool scan_periodic_stop(uint64_t wdev_id)
 	return true;
 }
 =

+uint64_t scan_get_triggered_time(uint64_t wdev_id, uint32_t id)
+{
+	struct scan_context *sc;
+	struct scan_request *sr;
+
+	sc =3D l_queue_find(scan_contexts, scan_context_match, &wdev_id);
+	if (!sc)
+		return 0;
+
+	sr =3D l_queue_find(sc->requests, scan_request_match, L_UINT_TO_PTR(id));
+	if (!sr)
+		return 0;
+
+	if (!sc->triggered)
+		return 0;
+
+	return sc->start_time_tsf;
+}
+
 static void scan_periodic_timeout(struct l_timeout *timeout, void *user_da=
ta)
 {
 	struct scan_context *sc =3D user_data;
@@ -1439,6 +1461,7 @@ static void scan_notify(struct l_genl_msg *msg, void =
*user_data)
 	uint32_t wiphy_id;
 	struct scan_context *sc;
 	bool active_scan =3D false;
+	uint64_t start_time_tsf =3D 0;
 =

 	cmd =3D l_genl_msg_get_command(msg);
 =

@@ -1461,6 +1484,12 @@ static void scan_notify(struct l_genl_msg *msg, void=
 *user_data)
 		case NL80211_ATTR_SCAN_SSIDS:
 			active_scan =3D true;
 			break;
+		case NL80211_ATTR_SCAN_START_TIME_TSF:
+			if (len !=3D sizeof(uint64_t))
+				return;
+
+			start_time_tsf =3D l_get_u64(data);
+			break;
 		}
 	}
 =

@@ -1543,6 +1572,8 @@ static void scan_notify(struct l_genl_msg *msg, void =
*user_data)
 		else
 			sc->state =3D SCAN_STATE_PASSIVE;
 =

+		sc->start_time_tsf =3D start_time_tsf;
+
 		break;
 =

 	case NL80211_CMD_SCAN_ABORTED:
diff --git a/src/scan.h b/src/scan.h
index 8fc2aa56..b6c4e12d 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -124,6 +124,8 @@ void scan_periodic_start(uint64_t wdev_id, scan_trigger=
_func_t trigger,
 				scan_notify_func_t func, void *userdata);
 bool scan_periodic_stop(uint64_t wdev_id);
 =

+uint64_t scan_get_triggered_time(uint64_t wdev_id, uint32_t id);
+
 void scan_bss_free(struct scan_bss *bss);
 int scan_bss_rank_compare(const void *a, const void *b, void *user);
 =

-- =

2.17.1

--===============0650365916968034563==--

