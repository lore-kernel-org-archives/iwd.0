Content-Type: multipart/mixed; boundary="===============0994933136316901443=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 2/5] netdev: parse expected throughput in netdev_get_station
Date: Thu, 14 Jan 2021 10:58:30 -0800
Message-ID: <20210114185833.76477-2-prestwoj@gmail.com>
In-Reply-To: <20210114185833.76477-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0994933136316901443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 9 +++++++++
 src/netdev.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index b69945c0..a0220c13 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -471,6 +471,15 @@ static bool netdev_parse_sta_info(struct l_genl_attr *=
attr,
 =

 			info->have_tx_bitrate =3D true;
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
index d1c11af6..d22c94ff 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -132,9 +132,12 @@ struct netdev_station_info {
 	uint32_t tx_bitrate;
 	uint8_t tx_mcs;
 =

+	uint32_t expected_throughput;
+
 	bool have_cur_rssi : 1;
 	bool have_rx_bitrate : 1;
 	bool have_tx_bitrate : 1;
+	bool have_expected_throughput : 1;
 };
 =

 typedef void (*netdev_get_station_cb_t)(const struct netdev_station_info *=
info,
-- =

2.26.2

--===============0994933136316901443==--

