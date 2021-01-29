Content-Type: multipart/mixed; boundary="===============9073776350504060161=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/5] ap: Fix cleanup on ap_parse_new_station_ies errors
Date: Sat, 30 Jan 2021 00:27:37 +0100
Message-ID: <20210129232740.27393-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210129232740.27393-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9073776350504060161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index c4715696..1e028122 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2211,14 +2211,15 @@ static bool ap_parse_new_station_ies(const void *da=
ta, uint16_t len,
 	while (ie_tlv_iter_next(&iter)) {
 		switch (ie_tlv_iter_get_tag(&iter)) {
 		case IE_TYPE_RSN:
-			if (ie_parse_rsne(&iter, NULL) < 0)
+			if (rsn || ie_parse_rsne(&iter, NULL) < 0)
 				goto parse_error;
 =

 			rsn =3D l_memdup(ie_tlv_iter_get_data(&iter) - 2,
 					ie_tlv_iter_get_length(&iter) + 2);
 			break;
 		case IE_TYPE_EXTENDED_SUPPORTED_RATES:
-			if (ap_parse_supported_rates(&iter, &rates) < 0)
+			if (rates || ap_parse_supported_rates(&iter, &rates) <
+					0)
 				goto parse_error;
 =

 			break;
@@ -2257,13 +2258,16 @@ static void ap_handle_new_station(struct ap_state *=
ap, struct l_genl_msg *msg)
 	while (l_genl_attr_next(&attr, &type, &len, &data)) {
 		switch (type) {
 		case NL80211_ATTR_IE:
+			if (assoc_rsne || rates)
+				goto cleanup;
+
 			if (!ap_parse_new_station_ies(data, len, &assoc_rsne,
 							&rates))
 				return;
 			break;
 		case NL80211_ATTR_MAC:
 			if (len !=3D 6)
-				return;
+				goto cleanup;
 =

 			memcpy(mac, data, 6);
 			break;
@@ -2271,18 +2275,15 @@ static void ap_handle_new_station(struct ap_state *=
ap, struct l_genl_msg *msg)
 	}
 =

 	if (!assoc_rsne || !rates)
-		return;
+		goto cleanup;
 =

 	/*
 	 * Softmac's should already have a station created. The above check
 	 * may also fail for softmac cards.
 	 */
 	sta =3D l_queue_find(ap->sta_states, ap_sta_match_addr, mac);
-	if (sta) {
-		l_free(assoc_rsne);
-		l_uintset_free(rates);
-		return;
-	}
+	if (sta)
+		goto cleanup;
 =

 	sta =3D l_new(struct sta_state, 1);
 	memcpy(sta->addr, mac, 6);
@@ -2307,6 +2308,12 @@ static void ap_handle_new_station(struct ap_state *a=
p, struct l_genl_msg *msg)
 		l_error("Issuing SET_STATION failed");
 		ap_del_station(sta, MMPDU_REASON_CODE_UNSPECIFIED, true);
 	}
+
+	return;
+
+cleanup:
+	l_free(assoc_rsne);
+	l_uintset_free(rates);
 }
 =

 static void ap_handle_del_station(struct ap_state *ap, struct l_genl_msg *=
msg)
-- =

2.20.1

--===============9073776350504060161==--

