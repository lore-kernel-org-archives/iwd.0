Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0516629AC
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 17:26:23 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id fy4so3197225pjb.0
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 09:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuPBJi48/NXmWMwJ7cSQ2UAaxfRxFhYvrJvv52ilXIk=;
        b=TNdYI3aRRyT47KCvlZCJTOMeGaNmBKbxCDfqp+BemV3h0DfrheoNgOj3R3gqcffrXu
         n9HYKCQWOSXFEh3vxZd2oMBrJpxB+9WWKuuijRv3HoTzMy/lYG+8aZa0FyvpX1CNOdDA
         j7gmOdy1Z8CHXtfdZfAHPCsf8eVJJIj1moWkfIzGFzvr9IYmoaz/3Kv9N33Qs6PqQ+ME
         9yR3p+4uXzW5RLOQETsQA0W2JYKAiQz/a+ttB+Ny6VbhJyCW109fFeCh/+zNGZXar/qE
         8wr1enKiV7EoICzsGO8rNVWtLJeG6aKIqH6fMp/HdCF0QstsblWlqE5OJyULwzK5kM+K
         bf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuPBJi48/NXmWMwJ7cSQ2UAaxfRxFhYvrJvv52ilXIk=;
        b=o49M9Y2perMsaWLL3FKD0zASjMJEYxQMcTzmNhW3R8+jTeJA7casx64f6bYhEsU4e4
         EVWcGFOjhnSIfDosnIPHKNU3PPBVC2nItlPDJF8+mtanlHyYF6aZPa66crttIIocIied
         MRkiKbnGm0DTfZ8Ngi+/5QwBh6xXVwGw01GWfIxRC9iQJiSYQjsd3jqPXFIbsBMJpJ+p
         SH/eWFwXch2X90fzv/qyC0qa7L/uC+1LJ9LGrqEWo0ALpj2o2Ujop/CCeBbtrK5TLGVG
         Sq52hhWQqW74d+yv6k3oKmAe3Wv8AJqtZdhD2lib9OBcpqEqgWMvHw1XBSugTuzxw1iE
         QT8w==
X-Gm-Message-State: ANoB5pmLscuKiAQWnUArIRX9oc5O8yqrHN/UWYjiQcOABewdVadxQqSR
	O/zE4OXbVH4X5B9jgcFMP6dfgoZJdwY=
X-Google-Smtp-Source: AA0mqf6hJwCT9kA3T3j2tfIOr0mTSdiGHXuRIz6fZAyhuU7xeDzkKHVMToBnv1L4NIzGvYw/RhU46Q==
X-Received: by 2002:a05:6a21:32a8:b0:9d:efbf:813b with SMTP id yt40-20020a056a2132a800b0009defbf813bmr50587360pzb.4.1671211583293;
        Fri, 16 Dec 2022 09:26:23 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b00188fdae6e0esm1913636plx.44.2022.12.16.09.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:26:22 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/8] station: use wiphy_get_frequency_info
Date: Fri, 16 Dec 2022 09:26:04 -0800
Message-Id: <20221216172606.1799396-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221216172606.1799396-1-prestwoj@gmail.com>
References: <20221216172606.1799396-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove uses of supported/disabled scan_freq_set's and replace
with the equivalent calls to wiphy_get_frequency_info() and
wiphy_band_is_disabled().
---
 src/station.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/src/station.c b/src/station.c
index 9a646934..28d6793a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1407,8 +1407,6 @@ static int station_quick_scan_trigger(struct station *station)
 {
 	_auto_(scan_freq_set_free) struct scan_freq_set *known_freq_set = NULL;
 	bool known_6ghz;
-	const struct scan_freq_set *disabled = wiphy_get_disabled_freqs(
-								station->wiphy);
 
 	if (wiphy_regdom_is_updating(station->wiphy)) {
 		l_debug("regdom is updating, delaying quick scan");
@@ -1430,9 +1428,11 @@ static int station_quick_scan_trigger(struct station *station)
 	 * this since its so limited, so return an error which will fall back to
 	 * full autoconnect.
 	 */
-	if ((scan_freq_set_get_bands(disabled) & BAND_FREQ_6_GHZ) &&
-				wiphy_country_is_unknown(station->wiphy) &&
-				known_6ghz)
+	if (wiphy_get_supported_bands(station->wiphy) & BAND_FREQ_6_GHZ &&
+			wiphy_band_is_disabled(station->wiphy,
+						BAND_FREQ_6_GHZ) &&
+			wiphy_country_is_unknown(station->wiphy) &&
+			known_6ghz)
 		return -ENOTSUP;
 
 	if (!wiphy_constrain_freq_set(station->wiphy, known_freq_set)) {
@@ -1812,10 +1812,6 @@ static void parse_neighbor_report(struct station *station,
 	struct scan_freq_set *freq_set_md, *freq_set_no_md;
 	uint32_t current_freq = 0;
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
-	const struct scan_freq_set *supported =
-				wiphy_get_supported_freqs(station->wiphy);
-	const struct scan_freq_set *disabled =
-				wiphy_get_disabled_freqs(station->wiphy);
 
 	freq_set_md = scan_freq_set_new();
 	freq_set_no_md = scan_freq_set_new();
@@ -1828,6 +1824,7 @@ static void parse_neighbor_report(struct station *station,
 		uint32_t freq;
 		enum band_freq band;
 		const uint8_t *cc = NULL;
+		struct band_freq_attrs attr;
 
 		if (ie_tlv_iter_get_tag(&iter) != IE_TYPE_NEIGHBOR_REPORT)
 			continue;
@@ -1853,8 +1850,8 @@ static void parse_neighbor_report(struct station *station,
 			continue;
 
 		/* Skip if frequency is not supported or disabled */
-		if (!scan_freq_set_contains(supported, freq) ||
-				scan_freq_set_contains(disabled, freq))
+		if (!wiphy_get_frequency_info(station->wiphy, freq, &attr) ||
+				attr.disabled)
 			continue;
 
 		if (!memcmp(info.addr,
-- 
2.34.3

