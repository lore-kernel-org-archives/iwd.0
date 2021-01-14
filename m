Content-Type: multipart/mixed; boundary="===============1802437240349642077=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 1/5] netdev: parse rates in netdev_get_station
Date: Thu, 14 Jan 2021 10:58:29 -0800
Message-ID: <20210114185833.76477-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1802437240349642077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/netdev.h | 16 ++++++++++
 2 files changed, 104 insertions(+)

v4:
 * Added rate types for Legacy, HT, VHT, HE which we need to make
   any sense of the MCS index.

diff --git a/src/netdev.c b/src/netdev.c
index 2c88e648..b69945c0 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -368,11 +368,74 @@ int netdev_set_powered(struct netdev *netdev, bool po=
wered,
 	return 0;
 }
 =

+static bool netdev_parse_bitrate(struct l_genl_attr *attr,
+					enum netdev_rate_type *type_out,
+					uint32_t *rate_out,
+					uint8_t *mcs_out)
+{
+	uint16_t type, len;
+	const void *data;
+	uint32_t rate =3D 0;
+	uint8_t mcs =3D 0;
+	enum netdev_rate_type rate_type =3D NETDEV_RATE_TYPE_LEGACY;
+
+	while (l_genl_attr_next(attr, &type, &len, &data)) {
+		switch (type) {
+		case NL80211_RATE_INFO_BITRATE32:
+			if (len !=3D 4)
+				return false;
+
+			rate =3D *(const uint32_t *) data;
+
+			break;
+
+		case NL80211_RATE_INFO_MCS:
+			if (len !=3D 1)
+				return false;
+
+			mcs =3D *(const uint8_t *) data;
+			rate_type =3D NETDEV_RATE_TYPE_HT;
+
+			break;
+
+		case NL80211_RATE_INFO_VHT_MCS:
+			if (len !=3D 1)
+				return false;
+
+			mcs =3D *(const uint8_t *) data;
+			rate_type =3D NETDEV_RATE_TYPE_VHT;
+
+			break;
+
+		case NL80211_RATE_INFO_HE_MCS:
+			if (len !=3D 1)
+				return false;
+
+			mcs =3D *(const uint8_t *) data;
+			rate_type =3D NETDEV_RATE_TYPE_HT;
+
+			break;
+		}
+	}
+
+	if (!rate)
+		return false;
+
+	*type_out =3D rate_type;
+	*rate_out =3D rate;
+
+	if (rate_type !=3D NETDEV_RATE_TYPE_LEGACY)
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
@@ -383,6 +446,31 @@ static bool netdev_parse_sta_info(struct l_genl_attr *=
attr,
 			info->cur_rssi =3D *(const int8_t *) data;
 			info->have_cur_rssi =3D true;
 =

+			break;
+		case NL80211_STA_INFO_RX_BITRATE:
+			if (!l_genl_attr_recurse(attr, &nested))
+				return false;
+
+			if (!netdev_parse_bitrate(&nested, &info->rx_rate_type,
+							&info->rx_bitrate,
+							&info->rx_mcs))
+				return false;
+
+			info->have_rx_bitrate =3D true;
+
+			break;
+
+		case NL80211_STA_INFO_TX_BITRATE:
+			if (!l_genl_attr_recurse(attr, &nested))
+				return false;
+
+			if (!netdev_parse_bitrate(&nested, &info->tx_rate_type,
+							&info->tx_bitrate,
+							&info->tx_mcs))
+				return false;
+
+			info->have_tx_bitrate =3D true;
+
 			break;
 		}
 	}
diff --git a/src/netdev.h b/src/netdev.h
index 8c2dfee3..d1c11af6 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -114,11 +114,27 @@ typedef void (*netdev_station_watch_func_t)(struct ne=
tdev *netdev,
 					const uint8_t *mac, bool added,
 					void *user_data);
 =

+enum netdev_rate_type {
+	NETDEV_RATE_TYPE_LEGACY,
+	NETDEV_RATE_TYPE_HT,
+	NETDEV_RATE_TYPE_VHT,
+	NETDEV_RATE_TYPE_HE,
+};
+
 struct netdev_station_info {
 	uint8_t addr[6];
 	int8_t cur_rssi;
 =

+	enum netdev_rate_type rx_rate_type;
+	uint32_t rx_bitrate;
+	uint8_t rx_mcs;
+	enum netdev_rate_type tx_rate_type;
+	uint32_t tx_bitrate;
+	uint8_t tx_mcs;
+
 	bool have_cur_rssi : 1;
+	bool have_rx_bitrate : 1;
+	bool have_tx_bitrate : 1;
 };
 =

 typedef void (*netdev_get_station_cb_t)(const struct netdev_station_info *=
info,
-- =

2.26.2

--===============1802437240349642077==--

