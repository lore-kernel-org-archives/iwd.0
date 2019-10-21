Content-Type: multipart/mixed; boundary="===============2438612023209107804=="
MIME-Version: 1.0
From: Andrew Zaborowski <balrogg@gmail.com>
Subject: [PATCH 11/11] wiphy: Add wiphy_get_supported_rates
Date: Mon, 21 Oct 2019 15:55:10 +0200
Message-ID: <20191021135510.12657-11-balrogg@gmail.com>
In-Reply-To: <20191021135510.12657-1-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2438612023209107804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

Add code to parse the supported data rates info from the wiphy dumps and
expose it for P2P's use with a getter function.
---
 src/wiphy.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 src/wiphy.h |  2 ++
 2 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 9cb9ae66..12ec5d17 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -76,6 +76,7 @@ struct wiphy {
 	struct watchlist state_watches;
 	uint8_t extended_capabilities[EXT_CAP_LEN + 2]; /* max bitmap size + IE h=
eader */
 	uint8_t *iftype_extended_capabilities[NUM_NL80211_IFTYPES];
+	uint8_t *supported_rates[NUM_NL80211_BANDS];
 	uint8_t rm_enabled_capabilities[7]; /* 5 size max + header */
 =

 	bool support_scheduled_scan:1;
@@ -212,6 +213,9 @@ static void wiphy_free(void *data)
 	for (i =3D 0; i < NUM_NL80211_IFTYPES; i++)
 		l_free(wiphy->iftype_extended_capabilities[i]);
 =

+	for (i =3D 0; i < NUM_NL80211_BANDS; i++)
+		l_free(wiphy->supported_rates[i]);
+
 	scan_freq_set_free(wiphy->supported_freqs);
 	watchlist_destroy(&wiphy->state_watches);
 	l_free(wiphy->model_str);
@@ -478,6 +482,14 @@ bool wiphy_supports_iftype(struct wiphy *wiphy, uint32=
_t iftype)
 	return wiphy->supported_iftypes & (1 << (iftype - 1));
 }
 =

+const uint8_t *wiphy_get_supported_rates(struct wiphy *wiphy, unsigned int=
 band)
+{
+	if (band >=3D L_ARRAY_SIZE(wiphy->supported_rates))
+		return NULL;
+
+	return wiphy->supported_rates[band];
+}
+
 uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
 				wiphy_state_watch_func_t func,
 				void *user_data, wiphy_destroy_func_t destroy)
@@ -622,20 +634,70 @@ static void parse_supported_frequencies(struct wiphy =
*wiphy,
 	}
 }
 =

+static uint8_t *parse_supported_rates(struct l_genl_attr *attr)
+{
+	uint16_t type;
+	uint16_t len;
+	const void *data;
+	struct l_genl_attr nested;
+	int count =3D 0;
+	uint8_t *ret;
+
+	if (!l_genl_attr_recurse(attr, &nested))
+		return NULL;
+
+	while (l_genl_attr_next(&nested, NULL, NULL, NULL))
+		count++;
+
+	if (!l_genl_attr_recurse(attr, &nested))
+		return NULL;
+
+	ret =3D l_malloc(count + 1);
+	ret[count] =3D 0;
+
+	count =3D 0;
+
+	while (l_genl_attr_next(&nested, NULL, NULL, NULL)) {
+		struct l_genl_attr nested2;
+
+		if (!l_genl_attr_recurse(&nested, &nested2)) {
+			l_free(ret);
+			return NULL;
+		}
+
+		while (l_genl_attr_next(&nested2, &type, &len, &data)) {
+			if (type !=3D NL80211_BITRATE_ATTR_RATE || len !=3D 4)
+				continue;
+
+			/*
+			 * Convert from the 100kb/s units reported by the
+			 * kernel to the 500kb/s used in 802.11 IEs.
+			 */
+			ret[count++] =3D *(const uint32_t *) data / 5;
+		}
+	}
+
+	return ret;
+}
+
 static void parse_supported_bands(struct wiphy *wiphy,
 						struct l_genl_attr *bands)
 {
-	uint16_t type, len;
-	const void *data;
+	uint16_t type;
 	struct l_genl_attr attr;
 =

 	l_debug("");
 =

-	while (l_genl_attr_next(bands, NULL, NULL, NULL)) {
+	while (l_genl_attr_next(bands, &type, NULL, NULL)) {
+		enum nl80211_band band =3D type;
+
+		if (band !=3D NL80211_BAND_2GHZ && band !=3D NL80211_BAND_5GHZ)
+			continue;
+
 		if (!l_genl_attr_recurse(bands, &attr))
 			continue;
 =

-		while (l_genl_attr_next(&attr, &type, &len, &data)) {
+		while (l_genl_attr_next(&attr, &type, NULL, NULL)) {
 			struct l_genl_attr freqs;
 =

 			switch (type) {
@@ -645,6 +707,14 @@ static void parse_supported_bands(struct wiphy *wiphy,
 =

 				parse_supported_frequencies(wiphy, &freqs);
 				break;
+
+			case NL80211_BAND_ATTR_RATES:
+				if (wiphy->supported_rates[band])
+					continue;
+
+				wiphy->supported_rates[band] =3D
+					parse_supported_rates(&attr);
+				break;
 			}
 		}
 	}
diff --git a/src/wiphy.h b/src/wiphy.h
index c109f0a8..a5133972 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -66,6 +66,8 @@ bool wiphy_has_ext_feature(struct wiphy *wiphy, uint32_t =
feature);
 uint8_t wiphy_get_max_num_ssids_per_scan(struct wiphy *wiphy);
 uint32_t wiphy_get_max_roc_duration(struct wiphy *wiphy);
 bool wiphy_supports_iftype(struct wiphy *wiphy, uint32_t iftype);
+const uint8_t *wiphy_get_supported_rates(struct wiphy *wiphy,
+						unsigned int band);
 bool wiphy_supports_adhoc_rsn(struct wiphy *wiphy);
 bool wiphy_can_offchannel_tx(struct wiphy *wiphy);
 bool wiphy_supports_qos_set_map(struct wiphy *wiphy);
-- =

2.20.1

--===============2438612023209107804==--

