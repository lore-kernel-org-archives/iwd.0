Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17D7E
	for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 21:43:26 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id n4so13641260plp.1
        for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 13:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEaqBAJs8KZVx6xGYybMYXUTMKboq4SR+aoTKzl27iY=;
        b=ijr/dBmGu04WZVHRtMfZWvtKHRRnrzaW9rLZmWSa+B3bjh4jEZDqQXCNlih/kTYVwt
         XHoQAG4WpH1qo8SslOom30s+EB2yq17YI23Ge1CFgEB0XAgb/wByLYqgGWtHQQMaNvgO
         IE/ynErfgl4TRUS8NwzlrhzxDqg3abEwpc0Vt8i7isS+3Ivc/MJjOaJgQgXNwTokQcVe
         XK0zpZF9AJCzXWpgPBIRf1sFVXpQu7lnSFFJFqAvWESpgnihFyz4vuJX/M/D+BVJw6X+
         OoxTrurXtV5tqp95K9LDKibrDgKW9DTKLg5r+23RZThwjWrjga0JdVVEexXSVOIbk5dI
         Fa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEaqBAJs8KZVx6xGYybMYXUTMKboq4SR+aoTKzl27iY=;
        b=tjPuWwCQqKbF5hWVd2DLFEnZmZ/5JTN5A1nv94XJLXXANVkeDS9Oggn330ATg/2qam
         4+VkypgejEZ68rnfhHtFEAJNHgNBYZrppr1K7ciNAH4AVT585RBfFfbYI5vh2tJVOBff
         mj+KEzQnJX+juJE/7nplWAIfBCS/v0YdvRwhBdVd+lBboKyDgbEd8e0/yHpMnIqCN4GL
         /0TWMRqSA0pwQIaBwRqehYnZ1y0bDVJGoHEaLnEFbR7/myG8PbgkrAzhhfZbYpoEe5+E
         8eDG0wsMpwPrkBgz9eU/ijVywDdC+cU8c/wdpDRp0lc4zFQmBAaj7RuITjLHdMGpXAI2
         TAdQ==
X-Gm-Message-State: AFqh2kpfbs3nCMJp/OLKCNkHSWn3qyIwbCXPq5aiMFlSWDaChNUmjpYm
	4W+cFZ0btLGgTRRZzCfa2vQV+zj+eVM=
X-Google-Smtp-Source: AMrXdXsr5/jcPzCJM9A4Pj2hVayDZ311NPmMV0tDp8a53hrZ6iCVfsAsqVqHMxLIqyJiB5HwQhpEPQ==
X-Received: by 2002:a17:90a:cc2:b0:219:9973:2746 with SMTP id 2-20020a17090a0cc200b0021999732746mr14938110pjt.0.1671572605631;
        Tue, 20 Dec 2022 13:43:25 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e88-20020a17090a6fe100b00219cf5c3829sm8153301pjk.57.2022.12.20.13.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 13:43:25 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/10] wiphy: add getter for HT capabilities
Date: Tue, 20 Dec 2022 13:43:12 -0800
Message-Id: <20221220214318.2041986-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221220214318.2041986-1-prestwoj@gmail.com>
References: <20221220214318.2041986-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds some additional parsing to obtain the AMPDU parameter
byte as well as wiphy_get_ht_capabilities() which returns the
complete IE (combining the 3 separate kernel attributes).
---
 src/wiphy.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/wiphy.h |  3 +++
 2 files changed, 56 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 4ea7c3f8..ab8aa6c0 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -910,6 +910,42 @@ bool wiphy_country_is_unknown(struct wiphy *wiphy)
 			(cc[0] == 'X' && cc[1] == 'X'));
 }
 
+const uint8_t *wiphy_get_ht_capabilities(const struct wiphy *wiphy,
+						enum band_freq band,
+						size_t *size)
+{
+	static uint8_t ht_capa[26];
+	const struct band *bandp = wiphy_get_band(wiphy, band);
+
+	if (!bandp)
+		return NULL;
+
+	if (!bandp->ht_supported)
+		return NULL;
+
+	memset(ht_capa, 0, sizeof(ht_capa));
+
+	/*
+	 * The kernel segments the HT capabilities element into multiple
+	 * attributes. For convenience on the caller just combine them and
+	 * return the full IE rather than adding 3 separate getters. This also
+	 * provides a way to check if HT is supported.
+	 */
+	memcpy(ht_capa, bandp->ht_capabilities, 2);
+	ht_capa[2] = bandp->ht_ampdu_params;
+	memcpy(ht_capa + 3, bandp->ht_mcs_set, 16);
+
+	/*
+	 * TODO: HT Extended capabilities, beamforming, and ASEL capabilities
+	 * are not available to get from the kernel, leave as zero.
+	 */
+
+	if (size)
+		*size = sizeof(ht_capa);
+
+	return ht_capa;
+}
+
 int wiphy_estimate_data_rate(struct wiphy *wiphy,
 				const void *ies, uint16_t ies_len,
 				const struct scan_bss *bss,
@@ -1617,6 +1653,23 @@ static void parse_supported_bands(struct wiphy *wiphy,
 				memcpy(band->ht_capabilities, data, len);
 				band->ht_supported = true;
 				break;
+			/*
+			 * AMPDU factor/density are part of A-MPDU Parameters,
+			 * 802.11-2020 Section 9.4.2.55.3.
+			 */
+			case NL80211_BAND_ATTR_HT_AMPDU_FACTOR:
+				if (L_WARN_ON(len != 1))
+					continue;
+
+				band->ht_ampdu_params |= l_get_u8(data) & 0x3;
+				break;
+			case NL80211_BAND_ATTR_HT_AMPDU_DENSITY:
+				if (L_WARN_ON(len != 1))
+					continue;
+
+				band->ht_ampdu_params |=
+						(l_get_u8(data) & 0x7) >> 2;
+				break;
 			case NL80211_BAND_ATTR_IFTYPE_DATA:
 				if (!l_genl_attr_recurse(&attr, &nested))
 					continue;
diff --git a/src/wiphy.h b/src/wiphy.h
index 6616da61..5cf22537 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -138,6 +138,9 @@ bool wiphy_get_rsnxe(const struct wiphy *wiphy, uint8_t *buf, size_t len);
 void wiphy_get_reg_domain_country(struct wiphy *wiphy, char *out);
 bool wiphy_country_is_unknown(struct wiphy *wiphy);
 
+const uint8_t *wiphy_get_ht_capabilities(const struct wiphy *wiphy,
+						enum band_freq band,
+						size_t *size);
 void wiphy_generate_random_address(struct wiphy *wiphy, uint8_t addr[static 6]);
 void wiphy_generate_address_from_ssid(struct wiphy *wiphy, const char *ssid,
 					uint8_t addr[static 6]);
-- 
2.34.3

