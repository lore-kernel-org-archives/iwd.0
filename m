Content-Type: multipart/mixed; boundary="===============2221109914053842826=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/7] netdev: parse expected throughput in netdev_get_station
Date: Mon, 11 Jan 2021 13:35:00 -0800
Message-ID: <20210111213502.551370-5-prestwoj@gmail.com>
In-Reply-To: <20210111213502.551370-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2221109914053842826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 8 ++++++++
 src/netdev.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 51d0da3d..dbcb769a 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4064,6 +4064,14 @@ static bool netdev_parse_sta_info(struct l_genl_attr=
 *attr,
 				return false;
 =

 			break;
+
+		case NL80211_STA_INFO_EXPECTED_THROUGHPUT:
+			if (len !=3D 4)
+				return false;
+
+			info->expected_throughput =3D *(const uint32_t *)data;
+
+			break;
 		}
 	}
 =

diff --git a/src/netdev.h b/src/netdev.h
index f47b2bd8..8524e05e 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -120,6 +120,7 @@ struct netdev_station_info {
 	uint8_t rx_mcs;
 	uint32_t tx_bitrate;
 	uint8_t tx_mcs;
+	uint32_t expected_throughput;
 };
 =

 typedef void (*netdev_get_station_cb_t)(struct netdev_station_info *info,
-- =

2.26.2

--===============2221109914053842826==--

