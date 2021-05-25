Content-Type: multipart/mixed; boundary="===============8323197520386173081=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH] netdev: station: support channel switch events
Date: Tue, 25 May 2021 15:20:25 +0000
Message-ID: <20210525152020.3304052-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8323197520386173081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the connected BSS announces that it is switching operating channel,
the kernel may emit the NL80211_CMD_CH_SWTICH_NOTIFY event when the
switch is complete. Handle this event in netdev in a way similar to the
NL80211_CMD_ROAM event by getting the new BSS info and passing it to
station. station will then update its current_bss member.

This enables iwd to keep track of the current operating frequency after
a channel switch. Previously iwd would ignore this event and the output
of 'iwctl station wlan0 show' would show the old frequency.
---
 src/netdev.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++++--
 src/netdev.h  |  1 +
 src/station.c | 21 +++++++++++++++
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 9a2afe1d18be..9f185cc1a333 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -145,6 +145,7 @@ struct netdev {
 	uint8_t set_mac_once[6];
 =

 	struct scan_bss *fw_roam_bss;
+	struct scan_bss *channel_switch_bss;
 =

 	uint32_t set_powered_cmd_id;
 	netdev_command_cb_t set_powered_cb;
@@ -1307,6 +1308,17 @@ static void netdev_connect_ok(struct netdev *netdev)
 		netdev->ft_ds_list =3D NULL;
 	}
 =

+	if (netdev->channel_switch_bss) {
+		if (netdev->event_filter)
+			netdev->event_filter(netdev, NETDEV_EVENT_CHANNEL_SWITCHED,
+						netdev->channel_switch_bss,
+						netdev->user_data);
+		else
+			scan_bss_free(netdev->channel_switch_bss);
+
+		netdev->channel_switch_bss =3D NULL;
+	}
+
 	if (netdev->connect_cb) {
 		netdev->connect_cb(netdev, NETDEV_RESULT_OK, NULL,
 					netdev->user_data);
@@ -4407,7 +4419,7 @@ static bool match_addr(const void *a, const void *b)
 	return memcmp(bss->addr, b, 6) =3D=3D 0;
 }
 =

-static bool netdev_get_fw_scan_cb(int err, struct l_queue *bss_list,
+static bool netdev_get_fw_scan_roam_cb(int err, struct l_queue *bss_list,
 					const struct scan_freq_set *freqs,
 					void *user_data)
 {
@@ -4520,7 +4532,7 @@ static void netdev_roam_event(struct l_genl_msg *msg,=
 struct netdev *netdev)
 get_fw_scan:
 	handshake_state_set_authenticator_address(netdev->handshake, mac);
 =

-	if (!scan_get_firmware_scan(netdev->wdev_id, netdev_get_fw_scan_cb,
+	if (!scan_get_firmware_scan(netdev->wdev_id, netdev_get_fw_scan_roam_cb,
 					netdev, NULL))
 		goto failed;
 =

@@ -4536,6 +4548,58 @@ failed:
 =

 }
 =

+static bool netdev_get_fw_scan_channel_switch_cb(int err, struct l_queue *=
bss_list,
+					const struct scan_freq_set *freqs,
+					void *user_data)
+{
+	struct netdev *netdev =3D user_data;
+	struct scan_bss *bss =3D NULL;
+
+	if (!netdev->connected)
+		return false;
+
+	if (err < 0) {
+		l_error("Failed to get scan after channel switch (%d)", err);
+		goto failed;
+	}
+
+	bss =3D l_queue_remove_if(bss_list, match_addr, netdev->handshake->aa);
+
+	if (!bss) {
+		l_error("Channel switch BSS not found in scan results");
+		goto failed;
+	}
+
+	netdev->channel_switch_bss =3D bss;
+
+	netdev_connect_ok(netdev);
+
+	return false;
+
+failed:
+	netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+					MMPDU_REASON_CODE_UNSPECIFIED);
+	return false;
+}
+
+static void netdev_channel_switch_event(struct l_genl_msg *msg,
+					struct netdev *netdev)
+{
+	l_debug("");
+
+	if (!scan_get_firmware_scan(netdev->wdev_id,
+					netdev_get_fw_scan_channel_switch_cb, netdev, NULL))
+		goto failed;
+
+	return;
+
+failed:
+	l_error("Failed to handle channel switch");
+	netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+					MMPDU_REASON_CODE_UNSPECIFIED);
+
+}
+
 static void netdev_mlme_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev *netdev =3D NULL;
@@ -4561,6 +4625,9 @@ static void netdev_mlme_notify(struct l_genl_msg *msg=
, void *user_data)
 	case NL80211_CMD_ROAM:
 		netdev_roam_event(msg, netdev);
 		break;
+	case NL80211_CMD_CH_SWITCH_NOTIFY:
+		netdev_channel_switch_event(msg, netdev);
+		break;
 	case NL80211_CMD_CONNECT:
 		netdev_connect_event(msg, netdev);
 		break;
diff --git a/src/netdev.h b/src/netdev.h
index f625957bb760..ee944bceef8a 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -43,6 +43,7 @@ enum netdev_event {
 	NETDEV_EVENT_ASSOCIATING,
 	NETDEV_EVENT_ROAMING,
 	NETDEV_EVENT_ROAMED,
+	NETDEV_EVENT_CHANNEL_SWITCHED,
 	NETDEV_EVENT_DISCONNECT_BY_AP,
 	NETDEV_EVENT_DISCONNECT_BY_SME,
 	NETDEV_EVENT_RSSI_THRESHOLD_LOW,
diff --git a/src/station.c b/src/station.c
index 5fb3a03d6831..a613aad460eb 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2324,6 +2324,24 @@ static void station_event_roamed(struct station *sta=
tion, struct scan_bss *new)
 	station_roamed(station);
 }
 =

+static void station_event_channel_switched(struct station *station,
+					struct scan_bss *new)
+{
+	struct scan_bss *stale;
+
+	network_bss_update(station->connected_network, new);
+
+	/* Remove new BSS if it exists in past scan results */
+	stale =3D l_queue_remove_if(station->bss_list, bss_match_bssid,
+				new->addr);
+	if (stale)
+		scan_bss_free(stale);
+
+	station->connected_bss =3D new;
+
+	l_queue_insert(station->bss_list, new, scan_bss_rank_compare, NULL);
+}
+
 static void station_rssi_level_changed(struct station *station,
 					uint8_t level_idx);
 =

@@ -2358,6 +2376,9 @@ static void station_netdev_event(struct netdev *netde=
v, enum netdev_event event,
 	case NETDEV_EVENT_ROAMED:
 		station_event_roamed(station, (struct scan_bss *) event_data);
 		break;
+	case NETDEV_EVENT_CHANNEL_SWITCHED:
+		station_event_channel_switched(station, (struct scan_bss *) event_data);
+		break;
 	}
 }
 =

-- =

2.31.1
--===============8323197520386173081==--

