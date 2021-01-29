Content-Type: multipart/mixed; boundary="===============6136401352195286213=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] ap: add DEL_STATION path to fullmac AP handling
Date: Fri, 29 Jan 2021 09:28:18 -0800
Message-ID: <20210129172818.80132-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6136401352195286213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is how a fullmac card tells userspace that a station has
left. This fixes the issue where the same client cannot re-connect
to the same AP multiple times. ap_new_station was renamed to
ap_handle_new_station for consistency.
---
 src/ap.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 5768233b..7ff15097 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2238,7 +2238,7 @@ parse_error:
 	return false;
 }
 =

-static void ap_new_station(struct ap_state *ap, struct l_genl_msg *msg)
+static void ap_handle_new_station(struct ap_state *ap, struct l_genl_msg *=
msg)
 {
 	struct sta_state *sta;
 	struct l_genl_attr attr;
@@ -2306,6 +2306,43 @@ static void ap_new_station(struct ap_state *ap, stru=
ct l_genl_msg *msg)
 	}
 }
 =

+static void ap_handle_del_station(struct ap_state *ap, struct l_genl_msg *=
msg)
+{
+	struct sta_state *sta;
+	struct l_genl_attr attr;
+	uint16_t type;
+	uint16_t len;
+	const void *data;
+	uint8_t mac[6];
+	uint16_t reason =3D MMPDU_REASON_CODE_UNSPECIFIED;
+
+	if (!l_genl_attr_init(&attr, msg))
+		return;
+
+	while (l_genl_attr_next(&attr, &type, &len, &data)) {
+		switch (type) {
+		case NL80211_ATTR_MAC:
+			if (len !=3D 6)
+				return;
+
+			memcpy(mac, data, 6);
+			break;
+		case NL80211_ATTR_REASON_CODE:
+			if (len !=3D 2)
+				return;
+
+			reason =3D l_get_u16(data);
+		}
+	}
+
+	sta =3D l_queue_find(ap->sta_states, ap_sta_match_addr, mac);
+	if (!sta)
+		return;
+
+	ap_del_station(sta, reason, true);
+	ap_remove_sta(sta);
+}
+
 static void ap_mlme_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct ap_state *ap =3D user_data;
@@ -2335,7 +2372,10 @@ static void ap_mlme_notify(struct l_genl_msg *msg, v=
oid *user_data)
 		l_free(ap);
 		break;
 	case NL80211_CMD_NEW_STATION:
-		ap_new_station(ap, msg);
+		ap_handle_new_station(ap, msg);
+		break;
+	case NL80211_CMD_DEL_STATION:
+		ap_handle_del_station(ap, msg);
 		break;
 	}
 }
-- =

2.26.2

--===============6136401352195286213==--

