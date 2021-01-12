Content-Type: multipart/mixed; boundary="===============4092080415625098111=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/8] netdev: parse expected throughput in netdev_get_station
Date: Tue, 12 Jan 2021 09:17:19 -0800
Message-ID: <20210112171723.3025-4-prestwoj@gmail.com>
In-Reply-To: <20210112171723.3025-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4092080415625098111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 9 +++++++++
 src/netdev.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index be24c999..0618c579 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -446,6 +446,15 @@ static bool netdev_parse_sta_info(struct l_genl_attr *=
attr,
 			info->have_tx_bitrate =3D true;
 			info->have_tx_mcs =3D true;
 =

+			break;
+
+		case NL80211_STA_INFO_EXPECTED_THROUGHPUT:
+			if (len !=3D 4)
+				return false;
+
+			info->expected_throughput =3D *(const uint32_t *)data;
+			info->have_expected_throughput =3D true;
+
 			break;
 		}
 	}
diff --git a/src/netdev.h b/src/netdev.h
index a69cd8ff..b4835f92 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -123,11 +123,14 @@ struct netdev_station_info {
 	uint32_t tx_bitrate;
 	uint8_t tx_mcs;
 =

+	uint32_t expected_throughput;
+
 	bool have_cur_rssi : 1;
 	bool have_rx_bitrate : 1;
 	bool have_rx_mcs : 1;
 	bool have_tx_bitrate : 1;
 	bool have_tx_mcs : 1;
+	bool have_expected_throughput : 1;
 };
 =

 typedef void (*netdev_get_station_cb_t)(struct netdev_station_info *info,
-- =

2.26.2

--===============4092080415625098111==--

