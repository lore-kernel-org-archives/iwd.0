Content-Type: multipart/mixed; boundary="===============6381642846294203017=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 7/8] netdev: update RSSI polling to use station info parser
Date: Tue, 12 Jan 2021 09:17:22 -0800
Message-ID: <20210112171723.3025-7-prestwoj@gmail.com>
In-Reply-To: <20210112171723.3025-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6381642846294203017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 0618c579..a5e21cb0 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -480,6 +480,7 @@ static void netdev_rssi_poll_cb(struct l_genl_msg *msg,=
 void *user_data)
 	uint16_t type, len;
 	const void *data;
 	bool found;
+	struct netdev_station_info info;
 	uint8_t prev_rssi_level_idx =3D netdev->cur_rssi_level_idx;
 =

 	netdev->rssi_poll_cmd_id =3D 0;
@@ -492,29 +493,21 @@ static void netdev_rssi_poll_cb(struct l_genl_msg *ms=
g, void *user_data)
 		if (type !=3D NL80211_ATTR_STA_INFO)
 			continue;
 =

-		found =3D true;
-		break;
-	}
-
-	if (!found || !l_genl_attr_recurse(&attr, &nested))
-		goto done;
-
-	found =3D false;
-	while (l_genl_attr_next(&nested, &type, &len, &data)) {
-		if (type !=3D NL80211_STA_INFO_SIGNAL_AVG)
-			continue;
+		if (!l_genl_attr_recurse(&attr, &nested))
+			goto done;
 =

-		if (len !=3D 1)
-			continue;
+		if (!netdev_parse_sta_info(&nested, &info))
+			goto done;
 =

 		found =3D true;
-		netdev->cur_rssi =3D *(const int8_t *) data;
 		break;
 	}
 =

-	if (!found)
+	if (!found || !info.have_cur_rssi)
 		goto done;
 =

+	netdev->cur_rssi =3D info.cur_rssi;
+
 	/*
 	 * Note we don't have to handle LOW_SIGNAL_THRESHOLD here.  The
 	 * CQM single threshold RSSI monitoring should work even if the
-- =

2.26.2

--===============6381642846294203017==--

