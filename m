Content-Type: multipart/mixed; boundary="===============5895494731467613554=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/7] netdev: parse rates in netdev_get_station
Date: Mon, 11 Jan 2021 13:34:59 -0800
Message-ID: <20210111213502.551370-4-prestwoj@gmail.com>
In-Reply-To: <20210111213502.551370-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5895494731467613554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/netdev.h |  4 ++++
 2 files changed, 62 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index fa31b06a..51d0da3d 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3991,11 +3991,50 @@ done:
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
+			l_debug("parsing bitrate");
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
@@ -4005,6 +4044,25 @@ static bool netdev_parse_sta_info(struct l_genl_attr=
 *attr,
 =

 			info->cur_rssi =3D *(const int8_t *) data;
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
 			break;
 		}
 	}
diff --git a/src/netdev.h b/src/netdev.h
index a12a26ff..f47b2bd8 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -116,6 +116,10 @@ typedef void (*netdev_station_watch_func_t)(struct net=
dev *netdev,
 =

 struct netdev_station_info {
 	int8_t cur_rssi;
+	uint32_t rx_bitrate;
+	uint8_t rx_mcs;
+	uint32_t tx_bitrate;
+	uint8_t tx_mcs;
 };
 =

 typedef void (*netdev_get_station_cb_t)(struct netdev_station_info *info,
-- =

2.26.2

--===============5895494731467613554==--

