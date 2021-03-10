Content-Type: multipart/mixed; boundary="===============8412263914051571112=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/6] netdev: station: support full mac roaming
Date: Wed, 10 Mar 2021 12:27:44 -0800
Message-ID: <20210310202746.28475-4-prestwoj@gmail.com>
In-Reply-To: <20210310202746.28475-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8412263914051571112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Roaming on a full mac card is quite different than soft mac
and needs to be specially handled. The process starts with
the CMD_ROAM event, which tells us the driver is already
roamed and associated with a new AP. After this it expects
the 4-way handshake to be initiated. This in itself is quite
simple, the complexity comes with how this is piped into IWD.

There are a few issues:

1. station->connected_bss needs to be set to the new BSS
2. IWD has no past scan results to populate connected_bss
3. Full mac roaming has to be driven from netdev, and this
   is normally driven by station.

There is no way to *fully* populate a scan_bss with the new
BSS the driver roamed to, but we can get close enough to
at least rank it and provide basic info. Using GET_INTERFACE
and GET_STATION the frequency and signal strength can be
obtained respectively. This allows for ranking the new BSS
in stations bss_list. All the IE's are parsed using existing
code in netdev_connect_event.

For consistency station must also transition to a roaming state.
Since this roam is all handled by netdev two new events were
added, NETDEV_EVENT_ROAMING and NETDEV_EVENT_ROAMED. Both allow
station to transition between roaming/connected states, and ROAMED
provides station with the new (faked) scan_bss to replace
connected_bss.
---
 src/netdev.c  | 169 +++++++++++++++++++++++++++++++++++++++++++++++++-
 src/netdev.h  |   2 +
 src/station.c |  23 +++++++
 3 files changed, 191 insertions(+), 3 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index e0779de5..b87e3f2c 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -111,6 +111,7 @@ struct netdev {
 	uint32_t rekey_offload_cmd_id;
 	uint32_t qos_map_cmd_id;
 	uint32_t mac_change_cmd_id;
+	uint32_t get_iface_cmd_id;
 	enum netdev_result result;
 	uint16_t last_code; /* reason or status, depending on result */
 	struct l_timeout *neighbor_report_timeout;
@@ -128,6 +129,8 @@ struct netdev {
 	uint32_t rssi_poll_cmd_id;
 	uint8_t set_mac_once[6];
 =

+	struct scan_bss *fmac_roam_bss;
+
 	uint32_t set_powered_cmd_id;
 	netdev_command_cb_t set_powered_cb;
 	void *set_powered_user_data;
@@ -652,6 +655,11 @@ static void netdev_connect_free(struct netdev *netdev)
 		netdev->group_handshake_timeout =3D NULL;
 	}
 =

+	if (netdev->fmac_roam_bss) {
+		scan_bss_free(netdev->fmac_roam_bss);
+		netdev->fmac_roam_bss =3D NULL;
+	}
+
 	netdev->associated =3D false;
 	netdev->operational =3D false;
 	netdev->connected =3D false;
@@ -770,6 +778,11 @@ static void netdev_free(void *data)
 		netdev->get_station_cmd_id =3D 0;
 	}
 =

+	if (netdev->get_iface_cmd_id) {
+		l_genl_family_cancel(nl80211, netdev->get_iface_cmd_id);
+		netdev->get_iface_cmd_id =3D 0;
+	}
+
 	if (netdev->events_ready)
 		WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
 					netdev, NETDEV_WATCH_EVENT_DEL);
@@ -1179,6 +1192,25 @@ static void netdev_operstate_cb(int error, uint16_t =
type,
 							strerror(-error));
 }
 =

+static void try_roam_complete(struct netdev *netdev)
+{
+	/*
+	 * No guarantee that GET_IFACE/GET_STATION/eapol will complete in the
+	 * same order they were started.
+	 */
+	if (netdev->get_iface_cmd_id ||
+			netdev->fmac_roam_bss->signal_strength =3D=3D 0 ||
+			!netdev->operational)
+		return;
+
+	if (netdev->event_filter)
+		netdev->event_filter(netdev, NETDEV_EVENT_ROAMED,
+					netdev->fmac_roam_bss,
+					netdev->user_data);
+	/* station will take ownership of fmac_roam_bss */
+	netdev->fmac_roam_bss =3D NULL;
+}
+
 static void netdev_connect_ok(struct netdev *netdev)
 {
 	l_rtnl_set_linkmode_and_operstate(rtnl, netdev->index,
@@ -1188,6 +1220,11 @@ static void netdev_connect_ok(struct netdev *netdev)
 =

 	netdev->operational =3D true;
 =

+	if (netdev->fmac_roam_bss) {
+		try_roam_complete(netdev);
+		return;
+	}
+
 	if (netdev->connect_cb) {
 		netdev->connect_cb(netdev, NETDEV_RESULT_OK, NULL,
 					netdev->user_data);
@@ -1807,6 +1844,7 @@ static void netdev_connect_event(struct l_genl_msg *m=
sg, struct netdev *netdev)
 	struct ie_tlv_iter iter;
 	const uint8_t *resp_ies =3D NULL;
 	size_t resp_ies_len;
+	uint8_t cmd =3D l_genl_msg_get_command(msg);
 =

 	l_debug("");
 =

@@ -1860,9 +1898,16 @@ static void netdev_connect_event(struct l_genl_msg *=
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
@@ -1948,6 +1993,13 @@ process_resp_ies:
 	}
 =

 	if (netdev->sm) {
+		/*
+		 * Let station know about the roam so a state change can occur.
+		 */
+		if (cmd =3D=3D NL80211_CMD_ROAM && netdev->event_filter)
+			netdev->event_filter(netdev, NETDEV_EVENT_ROAMING,
+						NULL, netdev->user_data);
+
 		/*
 		 * Start processing EAPoL frames now that the state machine
 		 * has all the input data even in FT mode.
@@ -3905,6 +3957,113 @@ static void netdev_scan_notify(struct l_genl_msg *m=
sg, void *user_data)
 	}
 }
 =

+static void netdev_get_interface_cb(struct l_genl_msg *msg, void *user_dat=
a)
+{
+	struct netdev *netdev =3D user_data;
+
+	netdev->get_iface_cmd_id =3D 0;
+
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_WIPHY_FREQ,
+				&netdev->fmac_roam_bss->frequency,
+				NL80211_ATTR_UNSPEC) < 0)
+		return;
+
+	netdev->prev_frequency =3D netdev->frequency;
+	netdev->frequency =3D netdev->fmac_roam_bss->frequency;
+
+	try_roam_complete(netdev);
+}
+
+static void netdev_roamed_station_cb(const struct diagnostic_station_info =
*info,
+					void *user_data)
+{
+	struct netdev *netdev =3D user_data;
+
+	netdev->fmac_roam_bss->signal_strength =3D info->cur_rssi * 1000;
+
+	try_roam_complete(netdev);
+}
+
+/*
+ * CMD_ROAM indicates that the driver has already roamed/associated with a=
 new
+ * AP. This event is nearly identical to the CMD_CONNECT event which is why
+ * netdev_connect_event will handle all the parsing of IE's just as it does
+ * normally.
+ *
+ * One piece that is not included is the roamed BSS channel/frequency. Sin=
ce the
+ * driver roamed by itself we do not have a recent scan to obtain this fro=
m so
+ * GET_INTERFACE is used so we can build as complete of a scan_bss object =
as
+ * possible to provide to station. The scan_bss object will not have much =
of
+ * the normal information as it should, but this is the best we can do on a
+ * fullmac roam.
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
+	/* create this now so its known that netdev is roaming */
+	netdev->fmac_roam_bss =3D l_new(struct scan_bss, 1);
+	netdev->fmac_roam_bss->source_frame =3D SCAN_BSS_NONE;
+	memcpy(netdev->fmac_roam_bss->addr, mac, 6);
+
+	/* Reset handshake state */
+	nhs->complete =3D false;
+	nhs->ptk_installed =3D false;
+	nhs->gtk_installed =3D true;
+	nhs->igtk_installed =3D true;
+	handshake_state_set_authenticator_address(netdev->handshake, mac);
+	netdev->handshake->ptk_complete =3D false;
+
+	msg =3D l_genl_msg_new(NL80211_CMD_GET_INTERFACE);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
+
+	netdev->get_iface_cmd_id =3D l_genl_family_send(nl80211, msg,
+							netdev_get_interface_cb,
+							netdev, NULL);
+	if (!netdev->get_iface_cmd_id) {
+		l_error("Failed to GET_INTERFACE after roam");
+		l_genl_msg_unref(msg);
+		goto failed;
+	}
+
+	/*
+	 * We can safely do this now since station is not in a connected state,
+	 * meaning the diagnostics interface is not up
+	 */
+	if (netdev_get_station(netdev, mac, netdev_roamed_station_cb,
+				netdev, NULL) < 0) {
+		l_error("failed to GET_STATION after roam");
+		goto failed;
+	}
+
+	return true;
+
+failed:
+	l_error("Failed to roam");
+	netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+					MMPDU_REASON_CODE_UNSPECIFIED);
+
+	return false;
+}
+
 static void netdev_mlme_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev *netdev =3D NULL;
@@ -3946,6 +4105,10 @@ static void netdev_mlme_notify(struct l_genl_msg *ms=
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
index 6496be10..f9fa0d71 100644
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
+	stale =3D l_queue_remove_if(station->bss_list, scan_bss_addr_eq, new);
+	if (stale)
+		scan_bss_free(stale);
+
+	station->connected_bss =3D new;
+
+	scan_bss_compute_rank(new);
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

--===============8412263914051571112==--

