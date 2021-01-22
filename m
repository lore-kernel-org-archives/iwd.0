Content-Type: multipart/mixed; boundary="===============1086253359408176024=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 3/8] station: refactor to use diagnostic_info_to_dict
Date: Fri, 22 Jan 2021 12:38:44 -0800
Message-ID: <20210122203849.679952-3-prestwoj@gmail.com>
In-Reply-To: <20210122203849.679952-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1086253359408176024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 68 +--------------------------------------------------
 1 file changed, 1 insertion(+), 67 deletions(-)

diff --git a/src/station.c b/src/station.c
index 95dea92b..b600f37e 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3467,7 +3467,6 @@ static void station_get_diagnostic_cb(
 	struct station *station =3D user_data;
 	struct l_dbus_message *reply;
 	struct l_dbus_message_builder *builder;
-	int16_t rssi;
 =

 	if (!info) {
 		reply =3D dbus_error_aborted(station->get_station_pending);
@@ -3476,8 +3475,6 @@ static void station_get_diagnostic_cb(
 =

 	reply =3D l_dbus_message_new_method_return(station->get_station_pending);
 =

-	rssi =3D (int16_t)info->cur_rssi;
-
 	builder =3D l_dbus_message_builder_new(reply);
 =

 	l_dbus_message_builder_enter_array(builder, "{sv}");
@@ -3485,70 +3482,7 @@ static void station_get_diagnostic_cb(
 	dbus_append_dict_basic(builder, "ConnectedBss", 's',
 					util_address_to_string(info->addr));
 =

-	if (info->have_cur_rssi)
-		dbus_append_dict_basic(builder, "RSSI", 'n', &rssi);
-
-	if (info->have_rx_mcs) {
-		switch (info->rx_mcs_type) {
-		case DIAGNOSTIC_MCS_TYPE_HT:
-			dbus_append_dict_basic(builder, "RxMode", 's',
-						"802.11n");
-			dbus_append_dict_basic(builder, "RxMCS", 'y',
-						&info->rx_mcs);
-			break;
-		case DIAGNOSTIC_MCS_TYPE_VHT:
-			dbus_append_dict_basic(builder, "RxMode", 's',
-						"802.11ac");
-			dbus_append_dict_basic(builder, "RxMCS", 'y',
-						&info->rx_mcs);
-			break;
-		case DIAGNOSTIC_MCS_TYPE_HE:
-			dbus_append_dict_basic(builder, "RxMode", 's',
-						"802.11ax");
-			dbus_append_dict_basic(builder, "RxMCS", 'y',
-						&info->rx_mcs);
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (info->have_tx_mcs) {
-		switch (info->tx_mcs_type) {
-		case DIAGNOSTIC_MCS_TYPE_HT:
-			dbus_append_dict_basic(builder, "TxMode", 's',
-						"802.11n");
-			dbus_append_dict_basic(builder, "TxMCS", 'y',
-						&info->tx_mcs);
-			break;
-		case DIAGNOSTIC_MCS_TYPE_VHT:
-			dbus_append_dict_basic(builder, "TxMode", 's',
-						"802.11ac");
-			dbus_append_dict_basic(builder, "TxMCS", 'y',
-						&info->tx_mcs);
-			break;
-		case DIAGNOSTIC_MCS_TYPE_HE:
-			dbus_append_dict_basic(builder, "TxMode", 's',
-						"802.11ax");
-			dbus_append_dict_basic(builder, "TxMCS", 'y',
-						&info->tx_mcs);
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (info->have_tx_bitrate)
-		dbus_append_dict_basic(builder, "TxBitrate", 'u',
-					&info->tx_bitrate);
-
-	if (info->have_rx_bitrate)
-		dbus_append_dict_basic(builder, "RxBitrate", 'u',
-					&info->rx_bitrate);
-
-	if (info->have_expected_throughput)
-		dbus_append_dict_basic(builder, "ExpectedThroughput", 'u',
-					&info->expected_throughput);
+	diagnostic_info_to_dict(info, builder);
 =

 	l_dbus_message_builder_leave_array(builder);
 	l_dbus_message_builder_finalize(builder);
-- =

2.26.2

--===============1086253359408176024==--

