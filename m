Content-Type: multipart/mixed; boundary="===============5387351874311037848=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/6] netdev: introduce [General].RoamThreshold5G
Date: Fri, 07 May 2021 11:24:21 -0700
Message-ID: <20210507182423.81194-4-prestwoj@gmail.com>
In-Reply-To: <20210507182423.81194-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5387351874311037848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This value sets the roaming threshold on 5GHz networks. The
threshold has been separated from 2.4GHz because in many cases
5GHz can perform much better at low RSSI than 2.4GHz.

In addition the BSS ranking logic was re-worked and now 5GHz is
much more preferred, even at low RSSI. This means we need a
lower floor for RSSI before roaming, otherwise IWD would end
up roaming immediately after connecting due to low RSSI CQM
events.
---
 src/netdev.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 4fbe813a..9e7fc821 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -891,6 +891,7 @@ struct netdev *netdev_find(int ifindex)
 =

 /* Threshold RSSI for roaming to trigger, configurable in main.conf */
 static int LOW_SIGNAL_THRESHOLD;
+static int LOW_SIGNAL_THRESHOLD_5GHZ;
 =

 static void netdev_cqm_event_rssi_threshold(struct netdev *netdev,
 						uint32_t rssi_event)
@@ -925,6 +926,8 @@ static void netdev_cqm_event_rssi_value(struct netdev *=
netdev, int rssi_val)
 {
 	bool new_rssi_low;
 	uint8_t prev_rssi_level_idx =3D netdev->cur_rssi_level_idx;
+	int threshold =3D netdev->frequency > 4000 ? LOW_SIGNAL_THRESHOLD_5GHZ :
+						LOW_SIGNAL_THRESHOLD;
 =

 	if (!netdev->connected)
 		return;
@@ -939,7 +942,7 @@ static void netdev_cqm_event_rssi_value(struct netdev *=
netdev, int rssi_val)
 	if (!netdev->event_filter)
 		return;
 =

-	new_rssi_low =3D rssi_val < LOW_SIGNAL_THRESHOLD;
+	new_rssi_low =3D rssi_val < threshold;
 	if (netdev->cur_rssi_low !=3D new_rssi_low) {
 		int event =3D new_rssi_low ?
 			NETDEV_EVENT_RSSI_THRESHOLD_LOW :
@@ -4806,9 +4809,11 @@ static struct l_genl_msg *netdev_build_cmd_cqm_rssi_=
update(
 	uint32_t hyst =3D 5;
 	int thold_count;
 	int32_t thold_list[levels_num + 2];
+	int threshold =3D netdev->frequency > 4000 ? LOW_SIGNAL_THRESHOLD_5GHZ :
+						LOW_SIGNAL_THRESHOLD;
 =

 	if (levels_num =3D=3D 0) {
-		thold_list[0] =3D LOW_SIGNAL_THRESHOLD;
+		thold_list[0] =3D threshold;
 		thold_count =3D 1;
 	} else {
 		/*
@@ -4827,13 +4832,12 @@ static struct l_genl_msg *netdev_build_cmd_cqm_rssi=
_update(
 			if (i && thold_list[thold_count - 1] >=3D val)
 				return NULL;
 =

-			if (val >=3D LOW_SIGNAL_THRESHOLD && !low_sig_added) {
-				thold_list[thold_count++] =3D
-					LOW_SIGNAL_THRESHOLD;
+			if (val >=3D threshold && !low_sig_added) {
+				thold_list[thold_count++] =3D threshold;
 				low_sig_added =3D true;
 =

 				/* Duplicate values are not allowed */
-				if (val =3D=3D LOW_SIGNAL_THRESHOLD)
+				if (val =3D=3D threshold)
 					continue;
 			}
 =

@@ -5833,6 +5837,10 @@ static int netdev_init(void)
 					&LOW_SIGNAL_THRESHOLD))
 		LOW_SIGNAL_THRESHOLD =3D -70;
 =

+	if (!l_settings_get_int(settings, "General", "RoamThreshold5G",
+					&LOW_SIGNAL_THRESHOLD_5GHZ))
+		LOW_SIGNAL_THRESHOLD_5GHZ =3D -76;
+
 	if (!l_settings_get_bool(settings, "General", "ControlPortOverNL80211",
 					&pae_over_nl80211))
 		pae_over_nl80211 =3D true;
-- =

2.31.1

--===============5387351874311037848==--

