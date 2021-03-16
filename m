Content-Type: multipart/mixed; boundary="===============8908662721375810650=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] netdev: parse SIGNAL_AVG when building diagnostics object
Date: Tue, 16 Mar 2021 08:38:35 -0700
Message-ID: <20210316153836.218175-3-prestwoj@gmail.com>
In-Reply-To: <20210316153836.218175-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8908662721375810650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 0a603fc1..66a781bc 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -452,6 +452,14 @@ static bool netdev_parse_sta_info(struct l_genl_attr *=
attr,
 			info->cur_rssi =3D *(const int8_t *) data;
 			info->have_cur_rssi =3D true;
 =

+			break;
+		case NL80211_STA_INFO_SIGNAL_AVG:
+			if (len !=3D 1)
+				return false;
+
+			info->avg_rssi =3D *(const int8_t *) data;
+			info->have_avg_rssi =3D true;
+
 			break;
 		case NL80211_STA_INFO_RX_BITRATE:
 			if (!l_genl_attr_recurse(attr, &nested))
-- =

2.26.2

--===============8908662721375810650==--

