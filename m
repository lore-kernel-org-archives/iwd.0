Content-Type: multipart/mixed; boundary="===============3212255647200101113=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/8] netdev: parse rates in netdev_get_station
Date: Tue, 12 Jan 2021 09:17:18 -0800
Message-ID: <20210112171723.3025-3-prestwoj@gmail.com>
In-Reply-To: <20210112171723.3025-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3212255647200101113==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/netdev.h |  9 ++++++++
 2 files changed, 72 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 879bd275..be24c999 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -368,11 +368,49 @@ int netdev_set_powered(struct netdev *netdev, bool po=
wered,
 	return 0;
 }
 =

+static bool netdev_parse_bitrate(struct l_genl_attr *attr, uint32_t *rate_=
out,
+					uint8_t *mcs_out)
+{
+	uint16_t type, len;
+	const void *data;
+	uint32_t rate =3D 0;
+	uint8_t mcs =3D 0;
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
+
+			break;
+		}
+	}
+
+	if (!rate || !mcs)
+		return false;
+
+	*rate_out =3D rate;
+	*mcs_out =3D mcs;
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
@@ -383,6 +421,31 @@ static bool netdev_parse_sta_info(struct l_genl_attr *=
attr,
 			info->cur_rssi =3D *(const int8_t *) data;
 			info->have_cur_rssi =3D true;
 =

+			break;
+		case NL80211_STA_INFO_RX_BITRATE:
+			if (!l_genl_attr_recurse(attr, &nested))
+				return false;
+
+			if (!netdev_parse_bitrate(&nested, &info->rx_bitrate,
+							&info->rx_mcs))
+				return false;
+
+			info->have_rx_bitrate =3D true;
+			info->have_rx_mcs =3D true;
+
+			break;
+
+		case NL80211_STA_INFO_TX_BITRATE:
+			if (!l_genl_attr_recurse(attr, &nested))
+				return false;
+
+			if (!netdev_parse_bitrate(&nested, &info->tx_bitrate,
+							&info->tx_mcs))
+				return false;
+
+			info->have_tx_bitrate =3D true;
+			info->have_tx_mcs =3D true;
+
 			break;
 		}
 	}
diff --git a/src/netdev.h b/src/netdev.h
index e4a6eee3..a69cd8ff 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -118,7 +118,16 @@ struct netdev_station_info {
 	uint8_t addr[6];
 	int8_t cur_rssi;
 =

+	uint32_t rx_bitrate;
+	uint8_t rx_mcs;
+	uint32_t tx_bitrate;
+	uint8_t tx_mcs;
+
 	bool have_cur_rssi : 1;
+	bool have_rx_bitrate : 1;
+	bool have_rx_mcs : 1;
+	bool have_tx_bitrate : 1;
+	bool have_tx_mcs : 1;
 };
 =

 typedef void (*netdev_get_station_cb_t)(struct netdev_station_info *info,
-- =

2.26.2

--===============3212255647200101113==--

