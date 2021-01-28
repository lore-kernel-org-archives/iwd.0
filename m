Content-Type: multipart/mixed; boundary="===============8856200783712474636=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] ap: handle NEW_STATION for fullmac cards
Date: Thu, 28 Jan 2021 10:33:51 -0800
Message-ID: <20210128183352.1004552-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8856200783712474636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since fullmac cards handle auth/assoc in firmware IWD must
react differently while in AP mode just as it does in station.
For fullmac cards a NEW_STATION event is emitted post association
and from here the 4-way handshake can begin. In this NEW_STATION
handler a new sta_state is created and the needed members are
set in order to inject us back into the normal code execution
for softmac post association (i.e. creating group keys and
starting the 4-way handshake). From here everything works the
same as softmac.
---
 src/ap.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index e9c14529..c781ade4 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2189,6 +2189,114 @@ error:
 	ap_start_failed(ap);
 }
 =

+static bool ap_parse_ie(const void *data, uint16_t len, uint8_t **rsn_out,
+				struct l_uintset **rates_out)
+{
+	struct ie_tlv_iter iter;
+	uint8_t *rsn =3D NULL;
+	struct l_uintset *rates =3D NULL;
+
+	ie_tlv_iter_init(&iter, data, len);
+
+	while (ie_tlv_iter_next(&iter)) {
+		switch (ie_tlv_iter_get_tag(&iter)) {
+		case IE_TYPE_RSN:
+			if (ie_parse_rsne(&iter, NULL) < 0)
+				goto parse_error;
+
+			rsn =3D l_memdup(ie_tlv_iter_get_data(&iter) - 2,
+					ie_tlv_iter_get_length(&iter) + 1);
+			break;
+		case IE_TYPE_EXTENDED_SUPPORTED_RATES:
+			if (ap_parse_supported_rates(&iter, &rates) < 0)
+				goto parse_error;
+
+			break;
+		}
+	}
+
+	*rsn_out =3D rsn;
+	*rates_out =3D rates;
+
+	return true;
+
+parse_error:
+	if (rsn)
+		l_free(rsn);
+
+	if (rates)
+		l_uintset_free(rates);
+
+	return false;
+}
+
+static void ap_new_station(struct ap_state *ap, struct l_genl_msg *msg)
+{
+	struct sta_state *sta;
+	struct l_genl_attr attr;
+	uint16_t type;
+	uint16_t len;
+	const void *data;
+	uint8_t mac[6];
+	uint8_t *assoc_rsne =3D NULL;
+	struct l_uintset *rates =3D NULL;
+
+	if (!l_genl_attr_init(&attr, msg))
+		return;
+
+	while (l_genl_attr_next(&attr, &type, &len, &data)) {
+		switch (type) {
+		case NL80211_ATTR_IE:
+			if (!ap_parse_ie(data, len, &assoc_rsne, &rates))
+				return;
+			break;
+		case NL80211_ATTR_MAC:
+			if (len !=3D 6)
+				return;
+
+			memcpy(mac, data, 6);
+			break;
+		}
+	}
+
+	if (!assoc_rsne || !rates)
+		return;
+
+	/*
+	 * Softmac's should already have a station created. The above check
+	 * may also fail for softmac cards.
+	 */
+	sta =3D l_queue_find(ap->sta_states, ap_sta_match_addr, mac);
+	if (sta) {
+		l_free(assoc_rsne);
+		l_uintset_free(rates);
+		return;
+	}
+
+	sta =3D l_new(struct sta_state, 1);
+	memcpy(sta->addr, mac, 6);
+	sta->ap =3D ap;
+	sta->assoc_rsne =3D assoc_rsne;
+	sta->rates =3D rates;
+	sta->aid =3D ++ap->last_aid;
+
+	sta->associated =3D true;
+
+	if (!ap->sta_states)
+		ap->sta_states =3D l_queue_new();
+
+	l_queue_push_tail(ap->sta_states, sta);
+
+	msg =3D nl80211_build_set_station_unauthorized(
+					netdev_get_ifindex(ap->netdev), mac);
+
+	if (!l_genl_family_send(ap->nl80211, msg, ap_associate_sta_cb,
+								sta, NULL)) {
+		l_genl_msg_unref(msg);
+		l_error("Issuing SET_STATION failed");
+		ap_del_station(sta, MMPDU_REASON_CODE_UNSPECIFIED, true);
+	}
+}
 =

 static void ap_mlme_notify(struct l_genl_msg *msg, void *user_data)
 {
@@ -2218,6 +2326,9 @@ static void ap_mlme_notify(struct l_genl_msg *msg, vo=
id *user_data)
 		l_genl_family_free(ap->nl80211);
 		l_free(ap);
 		break;
+	case NL80211_CMD_NEW_STATION:
+		ap_new_station(ap, msg);
+		break;
 	}
 }
 =

-- =

2.26.2

--===============8856200783712474636==--

