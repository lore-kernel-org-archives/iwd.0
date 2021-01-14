Content-Type: multipart/mixed; boundary="===============8906206435673882257=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 2/5] netdev: parse expected throughput in netdev_get_station
Date: Thu, 14 Jan 2021 12:54:39 -0800
Message-ID: <20210114205442.84552-2-prestwoj@gmail.com>
In-Reply-To: <20210114205442.84552-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8906206435673882257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 9 +++++++++
 src/netdev.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 7d36eb77..0fc0600a 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -478,6 +478,15 @@ static bool netdev_parse_sta_info(struct l_genl_attr *=
attr,
 				info->have_tx_mcs =3D true;
 =

 			break;
+
+		case NL80211_STA_INFO_EXPECTED_THROUGHPUT:
+			if (len !=3D 4)
+				return false;
+
+			info->expected_throughput =3D l_get_u32(data);
+			info->have_expected_throughput =3D true;
+
+			break;
 		}
 	}
 =

diff --git a/src/netdev.h b/src/netdev.h
index daf10bb6..074dc61f 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -132,11 +132,14 @@ struct netdev_station_info {
 	uint32_t tx_bitrate;
 	uint8_t tx_mcs;
 =

+	uint32_t expected_throughput;
+
 	bool have_cur_rssi : 1;
 	bool have_rx_mcs : 1;
 	bool have_tx_mcs : 1;
 	bool have_rx_bitrate : 1;
 	bool have_tx_bitrate : 1;
+	bool have_expected_throughput : 1;
 };
 =

 typedef void (*netdev_get_station_cb_t)(const struct netdev_station_info *=
info,
-- =

2.26.2

--===============8906206435673882257==--

