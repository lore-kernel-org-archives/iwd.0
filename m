Content-Type: multipart/mixed; boundary="===============7107216157608556128=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/6] scan: parse the scan start time
Date: Wed, 20 Nov 2019 09:31:44 -0800
Message-ID: <20191120173146.21452-4-prestwoj@gmail.com>
In-Reply-To: <20191120173146.21452-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7107216157608556128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The kernel sends NL80211_ATTR_SCAN_START_TIME_TSF with CMD_TRIGGER and
RRM requires this value for beacon measurement reports. Since this
value is sent with CMD_TRIGGER we have to store it in the scan_context
and set it into the scan_bss when the scan finishes.
---
 src/scan.c | 13 +++++++++++++
 src/scan.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index e007ce5d..52ed102c 100644
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
@@ -1312,6 +1315,7 @@ static void get_scan_callback(struct l_genl_msg *msg,=
 void *user_data)
 	}
 =

 	bss->time_stamp =3D results->time_stamp;
+	bss->start_time_tsf =3D sc->start_time_tsf;
 =

 	scan_bss_compute_rank(bss);
 	l_queue_insert(results->bss_list, bss, scan_bss_rank_compare, NULL);
@@ -1439,6 +1443,7 @@ static void scan_notify(struct l_genl_msg *msg, void =
*user_data)
 	uint32_t wiphy_id;
 	struct scan_context *sc;
 	bool active_scan =3D false;
+	uint64_t start_time_tsf =3D 0;
 =

 	cmd =3D l_genl_msg_get_command(msg);
 =

@@ -1461,6 +1466,12 @@ static void scan_notify(struct l_genl_msg *msg, void=
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

@@ -1543,6 +1554,8 @@ static void scan_notify(struct l_genl_msg *msg, void =
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
index 8fc2aa56..fcbbe285 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -67,6 +67,7 @@ struct scan_bss {
 	uint8_t hessid[6];
 	uint8_t *rc_ie;		/* Roaming consortium IE */
 	uint8_t hs20_version;
+	uint64_t start_time_tsf;
 	uint64_t parent_tsf;
 	bool mde_present : 1;
 	bool cc_present : 1;
-- =

2.17.1

--===============7107216157608556128==--

