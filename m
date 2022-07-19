Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB004C89
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:58:02 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id o18so1466426pjs.2
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uiNJZzZAPizkJbge1xg7QH1qDml9OrtVPxorwt6rKQY=;
        b=K9N02N3qr7036BwLVYSlxO85g/mkKHYbTOuGfPMHyGtjG06w7mjcHHTRDi0Jfo0aYK
         w9+E706GZlMtGOolagmylBIc8iZ2noLpD9je7lYfhEcepKynMp1CKzeDS+PY/Hy5/0Gj
         kQyQTZhMAJhsLAYvw8AaEgf63PLlIYOH8w7z4OPLNrE2qjDbm/dmkND5mhJrVw8zwe80
         nV6kQ+fbegK8adtQensZ0V1sktBnoUk2tvDuJSOj8UgD/usBZH7wxD8hCT4yI/WKfbhC
         QNIuoUSql5/U18on6HCxjUdlOJMCI9S6o84HShnqmk/lYyQx5WBCLs6k7A7QAiw9xvfy
         ls4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uiNJZzZAPizkJbge1xg7QH1qDml9OrtVPxorwt6rKQY=;
        b=dXHSANmdIz5c2jYa1JN3YUDxRwT2SXF93PEX5Uus1p/DYiyERd6CefKVTc8yBD7PwR
         1PE1EhLmuxK6GHo4Ja5xDIXhkOpGiQZ7IQOREZpf1LXKmKGS7tCAOv69gio7AbCznFEz
         uWFHqj8anlbXTu6lwcWi6lA88o4vkgf61Et8I7/Q/o3iQUkEMQ+i3Z7j8Xe1jVzdKdBU
         1g7ntVOqa9ejuY6iNWTh6tMMzXaOpydTqjWDy3dYxHdmBxnqig9b9rMHc9rNH8Q6MV8S
         LWtFX0zvBrviClYQ/yriMbODYgctCDDaJSwIwSXjg8L8g2bWUyitt91A63pqk2+HcqOO
         JSKA==
X-Gm-Message-State: AJIora8ABwiXoQFYxvyyvvRqxE9SMYIbbOnd/YZLTpNV7086QUYkHkFk
	9ItHdy97TvvkW0Pn+HlWKnp1AAQGAiI=
X-Google-Smtp-Source: AGRyM1u60quBmdvHcz7W0CV+GxBwAgEukIvlK7WKU4WfSbB01Pdk2LUGh+upKLTdmO8OqExnzxfu5Q==
X-Received: by 2002:a17:90b:4a41:b0:1f0:6928:2363 with SMTP id lb1-20020a17090b4a4100b001f069282363mr851247pjb.161.1658257082159;
        Tue, 19 Jul 2022 11:58:02 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0016c68b56be7sm11937785plg.158.2022.07.19.11.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:58:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/12] wiphy: parse HE capabilities from band info
Date: Tue, 19 Jul 2022 11:55:40 -0700
Message-Id: <20220719185544.456727-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719185544.456727-1-prestwoj@gmail.com>
References: <20220719185544.456727-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HE capabilities information is contained in NL80211_BAND_ATTR_IFTYPE_DATA
where each entry is a set of attributes which define the rules for one or
more interface types. This patch specifically parses the HE PHY and HE MCS
data which will be used for data rate estimation.

Since the set of info is per-iftype(s) the data is stored in a queue where
each entry contains the PHY/MCS info, and a uint32 bit mask where each bit
index signifies an interface type.
---
 src/wiphy.c | 180 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 3 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 88a0fff8..f83353ed 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -936,6 +936,74 @@ static void wiphy_print_mcs_info(const uint8_t *mcs_map,
 	}
 }
 
+static void wiphy_print_he_capabilities(struct band *band,
+				const struct band_he_capabilities *he_cap)
+{
+	int i;
+	char type_buf[128];
+	char *s = type_buf;
+	uint8_t width_set = bit_field(he_cap->he_phy_capa[0], 1, 7);
+
+	for (i = 0; i < 32; i++) {
+		if (!(he_cap->iftypes & (1 << i)))
+			continue;
+
+		if (L_WARN_ON(s >= type_buf + sizeof(type_buf)))
+			return;
+
+		switch (i) {
+		case NETDEV_IFTYPE_ADHOC:
+			s += sprintf(s, "%s ", "Ad-Hoc");
+			break;
+		case NETDEV_IFTYPE_STATION:
+			s += sprintf(s, "%s ", "Station");
+			break;
+		case NETDEV_IFTYPE_AP:
+			s += sprintf(s, "%s ", "AP");
+			break;
+		case NETDEV_IFTYPE_P2P_CLIENT:
+			s += sprintf(s, "%s ", "P2P Client");
+			break;
+		case NETDEV_IFTYPE_P2P_GO:
+			s += sprintf(s, "%s ", "P2P GO");
+			break;
+		}
+	}
+
+	l_info("\t\t\tInterface Types: %s", type_buf);
+
+	switch (band->freq) {
+	case BAND_FREQ_2_4_GHZ:
+		wiphy_print_mcs_info(he_cap->he_mcs_set,
+					"HE RX <= 80MHz", 7, 9, 11);
+		wiphy_print_mcs_info(he_cap->he_mcs_set + 2,
+					"HE TX <= 80MHz", 7, 9, 11);
+		break;
+	case BAND_FREQ_5_GHZ:
+	case BAND_FREQ_6_GHZ:
+		wiphy_print_mcs_info(he_cap->he_mcs_set,
+					"HE RX <= 80MHz", 7, 9, 11);
+		wiphy_print_mcs_info(he_cap->he_mcs_set + 2,
+					"HE TX <= 80MHz", 7, 9, 11);
+
+		if (test_bit(&width_set, 2)) {
+			wiphy_print_mcs_info(he_cap->he_mcs_set + 4,
+					"HE RX <= 160MHz", 7, 9, 11);
+			wiphy_print_mcs_info(he_cap->he_mcs_set + 6,
+					"HE TX <= 160MHz", 7, 9, 11);
+		}
+
+		if (test_bit(&width_set, 3)) {
+			wiphy_print_mcs_info(he_cap->he_mcs_set + 8,
+					"HE RX <= 80+80MHz", 7, 9, 11);
+			wiphy_print_mcs_info(he_cap->he_mcs_set + 10,
+					"HE TX <= 80+80MHz", 7, 9, 11);
+		}
+
+		break;
+	}
+}
+
 static void wiphy_print_band_info(struct band *band, const char *name)
 {
 	int i;
@@ -995,6 +1063,20 @@ static void wiphy_print_band_info(struct band *band, const char *name)
 		wiphy_print_mcs_info(band->vht_mcs_set, "RX", 7, 8, 9);
 		wiphy_print_mcs_info(band->vht_mcs_set + 4, "TX", 7, 8, 9);
 	}
+
+	if (band->he_capabilities) {
+		const struct l_queue_entry *entry;
+
+		l_info("\t\tHE Capabilities");
+
+		for (entry = l_queue_get_entries(band->he_capabilities);
+						entry; entry = entry->next) {
+			const struct band_he_capabilities *he_cap = entry->data;
+
+			wiphy_print_he_capabilities(band, he_cap);
+		}
+
+	}
 }
 
 static void wiphy_print_basic_info(struct wiphy *wiphy)
@@ -1208,6 +1290,90 @@ static struct band *band_new_from_message(struct l_genl_attr *band)
 	return ret;
 }
 
+static uint32_t get_iftypes(struct l_genl_attr *iftypes)
+{
+	uint16_t type;
+	uint16_t len;
+	uint32_t types = 0;
+
+	while (l_genl_attr_next(iftypes, &type, &len, NULL)) {
+		if (len != 0)
+			continue;
+
+		types |= (1 << type);
+	}
+
+	return types;
+}
+
+static void parse_iftype_attrs(struct band *band, struct l_genl_attr *types)
+{
+	uint16_t type;
+	uint16_t len;
+	const void *data;
+	unsigned int count = 0;
+	struct band_he_capabilities *he_cap =
+					l_new(struct band_he_capabilities, 1);
+
+	while (l_genl_attr_next(types, &type, &len, &data)) {
+		struct l_genl_attr iftypes;
+
+		switch (type) {
+		case NL80211_BAND_IFTYPE_ATTR_IFTYPES:
+			if (!l_genl_attr_recurse(types, &iftypes))
+				goto parse_error;
+
+			he_cap->iftypes = get_iftypes(&iftypes);
+			break;
+		case NL80211_BAND_IFTYPE_ATTR_HE_CAP_PHY:
+			if (len > sizeof(he_cap->he_phy_capa))
+				continue;
+
+			memcpy(he_cap->he_phy_capa, data, len);
+			count++;
+			break;
+		case NL80211_BAND_IFTYPE_ATTR_HE_CAP_MCS_SET:
+			if (len > sizeof(he_cap->he_mcs_set))
+				continue;
+
+			memcpy(he_cap->he_mcs_set, data, len);
+			count++;
+			break;
+		default:
+			break;
+		}
+	}
+
+	/*
+	 * Since the capabilities element indicates what values are present in
+	 * the MCS set ensure both values are parsed
+	 */
+	if (count != 2 || !he_cap->iftypes)
+		goto parse_error;
+
+	if (!band->he_capabilities)
+		band->he_capabilities = l_queue_new();
+
+	l_queue_push_head(band->he_capabilities, he_cap);
+
+	return;
+
+parse_error:
+	l_free(he_cap);
+}
+
+static void parse_band_iftype_data(struct band *band, struct l_genl_attr *ifdata)
+{
+	while (l_genl_attr_next(ifdata, NULL, NULL, NULL)) {
+		struct l_genl_attr types;
+
+		if (!l_genl_attr_recurse(ifdata, &types))
+			continue;
+
+		parse_iftype_attrs(band, &types);
+	}
+}
+
 static void parse_supported_bands(struct wiphy *wiphy,
 						struct l_genl_attr *bands)
 {
@@ -1256,15 +1422,17 @@ static void parse_supported_bands(struct wiphy *wiphy,
 		} else
 			band = *bandp;
 
+
+
 		while (l_genl_attr_next(&attr, &type, &len, &data)) {
-			struct l_genl_attr freqs;
+			struct l_genl_attr nested;
 
 			switch (type) {
 			case NL80211_BAND_ATTR_FREQS:
-				if (!l_genl_attr_recurse(&attr, &freqs))
+				if (!l_genl_attr_recurse(&attr, &nested))
 					continue;
 
-				parse_supported_frequencies(wiphy, &freqs);
+				parse_supported_frequencies(wiphy, &nested);
 				break;
 
 			case NL80211_BAND_ATTR_RATES:
@@ -1304,6 +1472,12 @@ static void parse_supported_bands(struct wiphy *wiphy,
 				memcpy(band->ht_capabilities, data, len);
 				band->ht_supported = true;
 				break;
+			case NL80211_BAND_ATTR_IFTYPE_DATA:
+				if (!l_genl_attr_recurse(&attr, &nested))
+					continue;
+
+				parse_band_iftype_data(band, &nested);
+				break;
 			}
 		}
 
-- 
2.34.1

