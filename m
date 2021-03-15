Content-Type: multipart/mixed; boundary="===============6665108594162675293=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] netdev: station: support full mac roaming
Date: Mon, 15 Mar 2021 10:29:29 -0700
Message-ID: <20210315172931.173107-2-prestwoj@gmail.com>
In-Reply-To: <20210315172931.173107-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6665108594162675293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Roaming on a full mac card is quite different than soft mac
and needs to be specially handled. The process starts with
the CMD_ROAM event, which tells us the driver is already
roamed and associated with a new AP. After this it expects
the 4-way handshake to be initiated. This in itself is quite
simple, the complexity comes with how this is piped into IWD.

After CMD_ROAM fires its assumed that a scan result is
available in the kernel, which is obtained using a newly
added scan API scan_get_firmware_scan. The only special
bit of this is that it does not 'schedule' a scan but simply
calls GET_SCAN. This is treated special and will not be
queued behind any other pending scan requests. This lets us
reuse some parsing code paths in scan and initialize a
scan_bss object which ultimately gets handed to station so
it can update connected_bss/bss_list.

For consistency station must also transition to a roaming state.
Since this roam is all handled by netdev two new events were
added, NETDEV_EVENT_ROAMING and NETDEV_EVENT_ROAMED. Both allow
station to transition between roaming/connected states, and ROAMED
provides station with the new scan_bss to replace connected_bss.
---
 src/netdev.c  | 151 +++++++++++++++++++++++++++++++++++++++++++++++++-
 src/netdev.h  |   2 +
 src/station.c |  23 ++++++++
 3 files changed, 173 insertions(+), 3 deletions(-)

v2:
 * Updated to use scan_get_firmware_scan

diff --git a/src/netdev.c b/src/netdev.c
index 620f52ff..0a603fc1 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -128,6 +128,8 @@ struct netdev {
 	uint32_t rssi_poll_cmd_id;
 	uint8_t set_mac_once[6];
 =

+	struct scan_bss *fw_roam_bss;
+
 	uint32_t set_powered_cmd_id;
 	netdev_command_cb_t set_powered_cb;
 	void *set_powered_user_data;
@@ -770,6 +772,9 @@ static void netdev_free(void *data)
 		netdev->get_station_cmd_id =3D 0;
 	}
 =

+	if (netdev->fw_roam_bss)
+		scan_bss_free(netdev->fw_roam_bss);
+
 	if (netdev->events_ready)
 		WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
 					netdev, NETDEV_WATCH_EVENT_DEL);
@@ -1188,6 +1193,17 @@ static void netdev_connect_ok(struct netdev *netdev)
 =

 	netdev->operational =3D true;
 =

+	if (netdev->fw_roam_bss) {
+		if (netdev->event_filter)
+			netdev->event_filter(netdev, NETDEV_EVENT_ROAMED,
+						netdev->fw_roam_bss,
+						netdev->user_data);
+		else
+			scan_bss_free(netdev->fw_roam_bss);
+
+		netdev->fw_roam_bss =3D NULL;
+	}
+
 	if (netdev->connect_cb) {
 		netdev->connect_cb(netdev, NETDEV_RESULT_OK, NULL,
 					netdev->user_data);
@@ -1807,6 +1823,7 @@ static void netdev_connect_event(struct l_genl_msg *m=
sg, struct netdev *netdev)
 	struct ie_tlv_iter iter;
 	const uint8_t *resp_ies =3D NULL;
 	size_t resp_ies_len;
+	uint8_t cmd =3D l_genl_msg_get_command(msg);
 =

 	l_debug("");
 =

@@ -1860,9 +1877,16 @@ static void netdev_connect_event(struct l_genl_msg *=
msg, struct netdev *netdev)
 			goto error;
 	}
 =

-	/* AP Rejected the authenticate / associate */
-	if (!status_code || *status_code !=3D 0)
-		goto error;
+	/*
+	 * A CMD_ROAM event will not have a status code, since it indicates
+	 * the hardware has already roamed. A failed roam on fullmac should
+	 * result in an explicit disconnect event.
+	 */
+	if (cmd =3D=3D NL80211_CMD_CONNECT) {
+		/* AP Rejected the authenticate / associate */
+		if (!status_code || *status_code !=3D 0)
+			goto error;
+	}
 =

 	if (!ies)
 		goto process_resp_ies;
@@ -1948,6 +1972,18 @@ process_resp_ies:
 	}
 =

 	if (netdev->sm) {
+		/*
+		 * Let station know about the roam so a state change can occur.
+		 */
+		if (cmd =3D=3D NL80211_CMD_ROAM) {
+			if (netdev->event_filter)
+				netdev->event_filter(netdev,
+						NETDEV_EVENT_ROAMING,
+						NULL, netdev->user_data);
+			/* EAPoL started after GET_SCAN */
+			return;
+		}
+
 		/*
 		 * Start processing EAPoL frames now that the state machine
 		 * has all the input data even in FT mode.
@@ -3905,6 +3941,111 @@ static void netdev_scan_notify(struct l_genl_msg *m=
sg, void *user_data)
 	}
 }
 =

+static bool match_addr(const void *a, const void *b)
+{
+	const struct scan_bss *bss =3D a;
+
+	return memcmp(bss->addr, b, 6) =3D=3D 0;
+}
+
+static bool netdev_get_fw_scan_cb(int err, struct l_queue *bss_list,
+					const struct scan_freq_set *freqs,
+					void *user_data)
+{
+	struct netdev *netdev =3D user_data;
+	struct scan_bss *bss =3D NULL;
+
+	/*
+	 * If there was a failure in netdev_connect_event this would reset
+	 * the connect state (netdev_connect_free) causing the sm to be freed.
+	 * In this case we should just ignore this and allow the disconnect
+	 * logic to continue.
+	 */
+	if (!netdev->sm)
+		return false;
+
+	if (err < 0) {
+		l_error("Failed to get scan after roam (%d)", err);
+		netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+					MMPDU_REASON_CODE_UNSPECIFIED);
+		return false;
+	}
+
+	/*
+	 * We don't actually need the entire list since we only provide
+	 * station with the roamed BSS. We can remove the BSS we want and by
+	 * returning false scan will keep ownership of the list.
+	 */
+	bss =3D l_queue_remove_if(bss_list, match_addr, netdev->handshake->aa);
+
+	if (!bss) {
+		l_error("Roam target BSS not found in scan results");
+		netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+					MMPDU_REASON_CODE_UNSPECIFIED);
+		return false;
+	}
+
+	netdev->fw_roam_bss =3D bss;
+
+	handshake_state_set_authenticator_ie(netdev->handshake, bss->rsne);
+
+	eapol_start(netdev->sm);
+
+	return false;
+}
+
+/*
+ * CMD_ROAM indicates that the driver has already roamed/associated with a=
 new
+ * AP. This event is nearly identical to the CMD_CONNECT event which is why
+ * netdev_connect_event will handle all the parsing of IE's just as it does
+ * normally.
+ *
+ * Using GET_SCAN we can grab all the required scan_bss data, create that =
object
+ * and provide it to station.
+ *
+ * The current handshake/netdev_handshake objects are reused after being
+ * reset to allow eapol to happen again without it thinking this is a re-k=
ey.
+ */
+static bool netdev_roam_event(struct l_genl_msg *msg, struct netdev *netde=
v)
+{
+	struct netdev_handshake_state *nhs =3D
+			l_container_of(netdev->handshake,
+					struct netdev_handshake_state,
+					super);
+	const uint8_t *mac;
+
+	l_debug("");
+
+	netdev->operational =3D false;
+
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_MAC, &mac,
+					NL80211_ATTR_UNSPEC) < 0) {
+		l_error("Failed to parse ATTR_MAC from CMD_ROAM");
+		goto failed;
+	}
+
+	/* Reset handshake state */
+	nhs->complete =3D false;
+	nhs->ptk_installed =3D false;
+	nhs->gtk_installed =3D true;
+	nhs->igtk_installed =3D true;
+	handshake_state_set_authenticator_address(netdev->handshake, mac);
+	netdev->handshake->ptk_complete =3D false;
+
+	if (!scan_get_firmware_scan(netdev->wdev_id, netdev_get_fw_scan_cb,
+					netdev, NULL))
+		goto failed;
+
+	return true;
+
+failed:
+	l_error("Failed to roam to new BSS");
+	netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+					MMPDU_REASON_CODE_UNSPECIFIED);
+
+	return false;
+}
+
 static void netdev_mlme_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev *netdev =3D NULL;
@@ -3946,6 +4087,10 @@ static void netdev_mlme_notify(struct l_genl_msg *ms=
g, void *user_data)
 	case NL80211_CMD_ASSOCIATE:
 		netdev_associate_event(msg, netdev);
 		break;
+	case NL80211_CMD_ROAM:
+		if (!netdev_roam_event(msg, netdev))
+			return;
+		/* fall through */
 	case NL80211_CMD_CONNECT:
 		netdev_connect_event(msg, netdev);
 		break;
diff --git a/src/netdev.h b/src/netdev.h
index d5adcf09..c2c43290 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -41,6 +41,8 @@ enum netdev_result {
 enum netdev_event {
 	NETDEV_EVENT_AUTHENTICATING,
 	NETDEV_EVENT_ASSOCIATING,
+	NETDEV_EVENT_ROAMING,
+	NETDEV_EVENT_ROAMED,
 	NETDEV_EVENT_DISCONNECT_BY_AP,
 	NETDEV_EVENT_DISCONNECT_BY_SME,
 	NETDEV_EVENT_RSSI_THRESHOLD_LOW,
diff --git a/src/station.c b/src/station.c
index 6496be10..1a829fae 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2291,6 +2291,23 @@ static void station_ok_rssi(struct station *station)
 	station->roam_min_time.tv_sec =3D 0;
 }
 =

+static void station_event_roamed(struct station *station, struct scan_bss =
*new)
+{
+	struct scan_bss *stale;
+
+	/* Remove new BSS if it exists in past scan results */
+	stale =3D l_queue_remove_if(station->bss_list, bss_match_bssid,
+					new->addr);
+	if (stale)
+		scan_bss_free(stale);
+
+	station->connected_bss =3D new;
+
+	l_queue_insert(station->bss_list, new, scan_bss_rank_compare, NULL);
+
+	station_enter_state(station, STATION_STATE_CONNECTED);
+}
+
 static void station_rssi_level_changed(struct station *station,
 					uint8_t level_idx);
 =

@@ -2319,6 +2336,12 @@ static void station_netdev_event(struct netdev *netd=
ev, enum netdev_event event,
 	case NETDEV_EVENT_RSSI_LEVEL_NOTIFY:
 		station_rssi_level_changed(station, l_get_u8(event_data));
 		break;
+	case NETDEV_EVENT_ROAMING:
+		station_enter_state(station, STATION_STATE_ROAMING);
+		break;
+	case NETDEV_EVENT_ROAMED:
+		station_event_roamed(station, (struct scan_bss *) event_data);
+		break;
 	}
 }
 =

-- =

2.26.2

--===============6665108594162675293==--

