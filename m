Content-Type: multipart/mixed; boundary="===============8708279007308834290=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 1/5] netdev: parse rates in netdev_get_station
Date: Thu, 14 Jan 2021 12:54:38 -0800
Message-ID: <20210114205442.84552-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8708279007308834290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/netdev.h | 18 ++++++++++
 2 files changed, 112 insertions(+)

v5:
 * Renamed some station_info members

diff --git a/src/netdev.c b/src/netdev.c
index 2c88e648..7d36eb77 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -368,11 +368,74 @@ int netdev_set_powered(struct netdev *netdev, bool po=
wered,
 	return 0;
 }
 =

+static bool netdev_parse_bitrate(struct l_genl_attr *attr,
+					enum netdev_mcs_type *type_out,
+					uint32_t *rate_out,
+					uint8_t *mcs_out)
+{
+	uint16_t type, len;
+	const void *data;
+	uint32_t rate =3D 0;
+	uint8_t mcs =3D 0;
+	enum netdev_mcs_type mcs_type =3D NETDEV_MCS_TYPE_NONE;
+
+	while (l_genl_attr_next(attr, &type, &len, &data)) {
+		switch (type) {
+		case NL80211_RATE_INFO_BITRATE32:
+			if (len !=3D 4)
+				return false;
+
+			rate =3D l_get_u32(data);
+
+			break;
+
+		case NL80211_RATE_INFO_MCS:
+			if (len !=3D 1)
+				return false;
+
+			mcs =3D l_get_u8(data);
+			mcs_type =3D NETDEV_MCS_TYPE_HT;
+
+			break;
+
+		case NL80211_RATE_INFO_VHT_MCS:
+			if (len !=3D 1)
+				return false;
+
+			mcs =3D l_get_u8(data);
+			mcs_type =3D NETDEV_MCS_TYPE_VHT;
+
+			break;
+
+		case NL80211_RATE_INFO_HE_MCS:
+			if (len !=3D 1)
+				return false;
+
+			mcs =3D l_get_u8(data);
+			mcs_type =3D NETDEV_MCS_TYPE_HE;
+
+			break;
+		}
+	}
+
+	if (!rate)
+		return false;
+
+	*type_out =3D mcs_type;
+	*rate_out =3D rate;
+
+	if (mcs_type !=3D NETDEV_MCS_TYPE_NONE)
+		*mcs_out =3D mcs;
+
+	return true;
+}
+
 static bool netdev_parse_sta_info(struct l_genl_attr *attr,
 					struct netdev_station_info *info)
 {
 	uint16_t type, len;
 	const void *data;
+	struct l_genl_attr nested;
 =

 	while (l_genl_attr_next(attr, &type, &len, &data)) {
 		switch (type) {
@@ -383,6 +446,37 @@ static bool netdev_parse_sta_info(struct l_genl_attr *=
attr,
 			info->cur_rssi =3D *(const int8_t *) data;
 			info->have_cur_rssi =3D true;
 =

+			break;
+		case NL80211_STA_INFO_RX_BITRATE:
+			if (!l_genl_attr_recurse(attr, &nested))
+				return false;
+
+			if (!netdev_parse_bitrate(&nested, &info->rx_mcs_type,
+							&info->rx_bitrate,
+							&info->rx_mcs))
+				return false;
+
+			info->have_rx_bitrate =3D true;
+
+			if (info->rx_mcs_type !=3D NETDEV_MCS_TYPE_NONE)
+				info->have_rx_mcs =3D true;
+
+			break;
+
+		case NL80211_STA_INFO_TX_BITRATE:
+			if (!l_genl_attr_recurse(attr, &nested))
+				return false;
+
+			if (!netdev_parse_bitrate(&nested, &info->tx_mcs_type,
+							&info->tx_bitrate,
+							&info->tx_mcs))
+				return false;
+
+			info->have_tx_bitrate =3D true;
+
+			if (info->tx_mcs_type !=3D NETDEV_MCS_TYPE_NONE)
+				info->have_tx_mcs =3D true;
+
 			break;
 		}
 	}
diff --git a/src/netdev.h b/src/netdev.h
index 8c2dfee3..daf10bb6 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -114,11 +114,29 @@ typedef void (*netdev_station_watch_func_t)(struct ne=
tdev *netdev,
 					const uint8_t *mac, bool added,
 					void *user_data);
 =

+enum netdev_mcs_type {
+	NETDEV_MCS_TYPE_NONE,
+	NETDEV_MCS_TYPE_HT,
+	NETDEV_MCS_TYPE_VHT,
+	NETDEV_MCS_TYPE_HE,
+};
+
 struct netdev_station_info {
 	uint8_t addr[6];
 	int8_t cur_rssi;
 =

+	enum netdev_mcs_type rx_mcs_type;
+	uint32_t rx_bitrate;
+	uint8_t rx_mcs;
+	enum netdev_mcs_type tx_mcs_type;
+	uint32_t tx_bitrate;
+	uint8_t tx_mcs;
+
 	bool have_cur_rssi : 1;
+	bool have_rx_mcs : 1;
+	bool have_tx_mcs : 1;
+	bool have_rx_bitrate : 1;
+	bool have_tx_bitrate : 1;
 };
 =

 typedef void (*netdev_get_station_cb_t)(const struct netdev_station_info *=
info,
-- =

2.26.2

--===============8708279007308834290==--

