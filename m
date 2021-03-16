Content-Type: multipart/mixed; boundary="===============8638757580587843447=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] diagnostic: include AverageRSSI in GetDiagnostics
Date: Tue, 16 Mar 2021 08:38:34 -0700
Message-ID: <20210316153836.218175-2-prestwoj@gmail.com>
In-Reply-To: <20210316153836.218175-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8638757580587843447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/diagnostic.c | 4 ++++
 src/diagnostic.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/src/diagnostic.c b/src/diagnostic.c
index 034229a7..d690cf3a 100644
--- a/src/diagnostic.c
+++ b/src/diagnostic.c
@@ -39,10 +39,14 @@ bool diagnostic_info_to_dict(const struct diagnostic_st=
ation_info *info,
 				struct l_dbus_message_builder *builder)
 {
 	int16_t rssi =3D (int16_t)info->cur_rssi;
+	int16_t avg_rssi =3D (int16_t)info->avg_rssi;
 =

 	if (info->have_cur_rssi)
 		dbus_append_dict_basic(builder, "RSSI", 'n', &rssi);
 =

+	if (info->have_avg_rssi)
+		dbus_append_dict_basic(builder, "AverageRSSI", 'n', &avg_rssi);
+
 	if (info->have_rx_mcs) {
 		switch (info->rx_mcs_type) {
 		case DIAGNOSTIC_MCS_TYPE_HT:
diff --git a/src/diagnostic.h b/src/diagnostic.h
index cd23bb61..dab45c0b 100644
--- a/src/diagnostic.h
+++ b/src/diagnostic.h
@@ -30,6 +30,7 @@ enum diagnostic_mcs_type {
 struct diagnostic_station_info {
 	uint8_t addr[6];
 	int8_t cur_rssi;
+	int8_t avg_rssi;
 =

 	enum diagnostic_mcs_type rx_mcs_type;
 	uint32_t rx_bitrate;
@@ -41,6 +42,7 @@ struct diagnostic_station_info {
 	uint32_t expected_throughput;
 =

 	bool have_cur_rssi : 1;
+	bool have_avg_rssi : 1;
 	bool have_rx_mcs : 1;
 	bool have_tx_mcs : 1;
 	bool have_rx_bitrate : 1;
-- =

2.26.2

--===============8638757580587843447==--

