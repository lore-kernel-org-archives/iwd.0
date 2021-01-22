Content-Type: multipart/mixed; boundary="===============4767100595007496307=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/7] netdev: move netdev_station_info to diagnostic.h
Date: Fri, 22 Jan 2021 10:14:28 -0800
Message-ID: <20210122181434.644707-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4767100595007496307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With AP now getting its own diagnostic interface it made sense
to move the netdev_station_info struct definition into its own
header which eventually can be accompanied by utilities in
diagnostic.c. These utilities can then be shared with AP and
station as needed.
---
 src/diagnostic.h | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/netdev.c     | 23 ++++++++++++-----------
 src/netdev.h     | 34 ++++-----------------------------
 src/station.c    |  6 ++++--
 4 files changed, 69 insertions(+), 43 deletions(-)
 create mode 100644 src/diagnostic.h

diff --git a/src/diagnostic.h b/src/diagnostic.h
new file mode 100644
index 00000000..8292d192
--- /dev/null
+++ b/src/diagnostic.h
@@ -0,0 +1,49 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+enum diagnostic_mcs_type {
+	DIAGNOSTIC_MCS_TYPE_NONE,
+	DIAGNOSTIC_MCS_TYPE_HT,
+	DIAGNOSTIC_MCS_TYPE_VHT,
+	DIAGNOSTIC_MCS_TYPE_HE,
+};
+
+struct diagnostic_station_info {
+	uint8_t addr[6];
+	int8_t cur_rssi;
+
+	enum diagnostic_mcs_type rx_mcs_type;
+	uint32_t rx_bitrate;
+	uint8_t rx_mcs;
+	enum diagnostic_mcs_type tx_mcs_type;
+	uint32_t tx_bitrate;
+	uint8_t tx_mcs;
+
+	uint32_t expected_throughput;
+
+	bool have_cur_rssi : 1;
+	bool have_rx_mcs : 1;
+	bool have_tx_mcs : 1;
+	bool have_rx_bitrate : 1;
+	bool have_tx_bitrate : 1;
+	bool have_expected_throughput : 1;
+};
diff --git a/src/netdev.c b/src/netdev.c
index e3ce270a..a19270c0 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -61,6 +61,7 @@
 #include "src/fils.h"
 #include "src/auth-proto.h"
 #include "src/frame-xchg.h"
+#include "src/diagnostic.h"
 =

 #ifndef ENOTSUPP
 #define ENOTSUPP 524
@@ -369,7 +370,7 @@ int netdev_set_powered(struct netdev *netdev, bool powe=
red,
 }
 =

 static bool netdev_parse_bitrate(struct l_genl_attr *attr,
-					enum netdev_mcs_type *type_out,
+					enum diagnostic_mcs_type *type_out,
 					uint32_t *rate_out,
 					uint8_t *mcs_out)
 {
@@ -377,7 +378,7 @@ static bool netdev_parse_bitrate(struct l_genl_attr *at=
tr,
 	const void *data;
 	uint32_t rate =3D 0;
 	uint8_t mcs =3D 0;
-	enum netdev_mcs_type mcs_type =3D NETDEV_MCS_TYPE_NONE;
+	enum diagnostic_mcs_type mcs_type =3D DIAGNOSTIC_MCS_TYPE_NONE;
 =

 	while (l_genl_attr_next(attr, &type, &len, &data)) {
 		switch (type) {
@@ -394,7 +395,7 @@ static bool netdev_parse_bitrate(struct l_genl_attr *at=
tr,
 				return false;
 =

 			mcs =3D l_get_u8(data);
-			mcs_type =3D NETDEV_MCS_TYPE_HT;
+			mcs_type =3D DIAGNOSTIC_MCS_TYPE_HT;
 =

 			break;
 =

@@ -403,7 +404,7 @@ static bool netdev_parse_bitrate(struct l_genl_attr *at=
tr,
 				return false;
 =

 			mcs =3D l_get_u8(data);
-			mcs_type =3D NETDEV_MCS_TYPE_VHT;
+			mcs_type =3D DIAGNOSTIC_MCS_TYPE_VHT;
 =

 			break;
 =

@@ -412,7 +413,7 @@ static bool netdev_parse_bitrate(struct l_genl_attr *at=
tr,
 				return false;
 =

 			mcs =3D l_get_u8(data);
-			mcs_type =3D NETDEV_MCS_TYPE_HE;
+			mcs_type =3D DIAGNOSTIC_MCS_TYPE_HE;
 =

 			break;
 		}
@@ -424,14 +425,14 @@ static bool netdev_parse_bitrate(struct l_genl_attr *=
attr,
 	*type_out =3D mcs_type;
 	*rate_out =3D rate;
 =

-	if (mcs_type !=3D NETDEV_MCS_TYPE_NONE)
+	if (mcs_type !=3D DIAGNOSTIC_MCS_TYPE_NONE)
 		*mcs_out =3D mcs;
 =

 	return true;
 }
 =

 static bool netdev_parse_sta_info(struct l_genl_attr *attr,
-					struct netdev_station_info *info)
+					struct diagnostic_station_info *info)
 {
 	uint16_t type, len;
 	const void *data;
@@ -458,7 +459,7 @@ static bool netdev_parse_sta_info(struct l_genl_attr *a=
ttr,
 =

 			info->have_rx_bitrate =3D true;
 =

-			if (info->rx_mcs_type !=3D NETDEV_MCS_TYPE_NONE)
+			if (info->rx_mcs_type !=3D DIAGNOSTIC_MCS_TYPE_NONE)
 				info->have_rx_mcs =3D true;
 =

 			break;
@@ -474,7 +475,7 @@ static bool netdev_parse_sta_info(struct l_genl_attr *a=
ttr,
 =

 			info->have_tx_bitrate =3D true;
 =

-			if (info->tx_mcs_type !=3D NETDEV_MCS_TYPE_NONE)
+			if (info->tx_mcs_type !=3D DIAGNOSTIC_MCS_TYPE_NONE)
 				info->have_tx_mcs =3D true;
 =

 			break;
@@ -511,7 +512,7 @@ static void netdev_rssi_poll_cb(struct l_genl_msg *msg,=
 void *user_data)
 	uint16_t type, len;
 	const void *data;
 	bool found;
-	struct netdev_station_info info;
+	struct diagnostic_station_info info;
 	uint8_t prev_rssi_level_idx =3D netdev->cur_rssi_level_idx;
 =

 	netdev->rssi_poll_cmd_id =3D 0;
@@ -4156,7 +4157,7 @@ static void netdev_get_station_cb(struct l_genl_msg *=
msg, void *user_data)
 	struct l_genl_attr attr, nested;
 	uint16_t type, len;
 	const void *data;
-	struct netdev_station_info info;
+	struct diagnostic_station_info info;
 =

 	netdev->get_station_cmd_id =3D 0;
 =

diff --git a/src/netdev.h b/src/netdev.h
index e7a1c060..d5adcf09 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -27,6 +27,7 @@ struct scan_bss;
 struct handshake_state;
 struct eapol_sm;
 struct mmpdu_header;
+struct diagnostic_station_info;
 =

 enum netdev_result {
 	NETDEV_RESULT_OK,
@@ -114,36 +115,9 @@ typedef void (*netdev_station_watch_func_t)(struct net=
dev *netdev,
 					const uint8_t *mac, bool added,
 					void *user_data);
 =

-enum netdev_mcs_type {
-	NETDEV_MCS_TYPE_NONE,
-	NETDEV_MCS_TYPE_HT,
-	NETDEV_MCS_TYPE_VHT,
-	NETDEV_MCS_TYPE_HE,
-};
-
-struct netdev_station_info {
-	uint8_t addr[6];
-	int8_t cur_rssi;
-
-	enum netdev_mcs_type rx_mcs_type;
-	uint32_t rx_bitrate;
-	uint8_t rx_mcs;
-	enum netdev_mcs_type tx_mcs_type;
-	uint32_t tx_bitrate;
-	uint8_t tx_mcs;
-
-	uint32_t expected_throughput;
-
-	bool have_cur_rssi : 1;
-	bool have_rx_mcs : 1;
-	bool have_tx_mcs : 1;
-	bool have_rx_bitrate : 1;
-	bool have_tx_bitrate : 1;
-	bool have_expected_throughput : 1;
-};
-
-typedef void (*netdev_get_station_cb_t)(const struct netdev_station_info *=
info,
-					void *user_data);
+typedef void (*netdev_get_station_cb_t)(
+				const struct diagnostic_station_info *info,
+				void *user_data);
 =

 struct wiphy *netdev_get_wiphy(struct netdev *netdev);
 const uint8_t *netdev_get_address(struct netdev *netdev);
diff --git a/src/station.c b/src/station.c
index c65fc0cc..41f19b09 100644
--- a/src/station.c
+++ b/src/station.c
@@ -53,6 +53,7 @@
 #include "src/netconfig.h"
 #include "src/anqp.h"
 #include "src/anqputil.h"
+#include "src/diagnostic.h"
 =

 static struct l_queue *station_list;
 static uint32_t netdev_watch;
@@ -3455,8 +3456,9 @@ static void station_destroy_interface(void *user_data)
 	station_free(station);
 }
 =

-static void station_get_diagnostic_cb(const struct netdev_station_info *in=
fo,
-					void *user_data)
+static void station_get_diagnostic_cb(
+				const struct diagnostic_station_info *info,
+				void *user_data)
 {
 	struct station *station =3D user_data;
 	struct l_dbus_message *reply;
-- =

2.26.2

--===============4767100595007496307==--

