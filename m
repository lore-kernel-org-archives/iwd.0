Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78596FB1
	for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 21:44:09 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id z7so5817474pfq.13
        for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 13:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTCFbtB+G9v6IanqL7UgbwBT4nA3xa5g0mbbLYZcgHU=;
        b=ZjmEcnf9v7yr793/LZHbfoVV9q9betvDp8eZ8Vuqr/84exj88FfOsEwepQggO1WAtD
         cc6ZEFuQugQEp/dGL9tYrBVff8awzkyLzaV/T8ZyJ6wPRfZ+Qx5GZzpjLISITjZz+mIR
         wtEhI0RmlysHK3TNYF+xCxgOOwW5u+QC0h5po+sseJxF59NDF/J/CORclLC4siMPmJ65
         ROUVtKVFFMuggSFfpoj7J1ngm3TaJe+NwmG/NBKCb3XA5vmtS3JSHrJ7YsJdT+YgsbIX
         jAMFekbPLXyegFuo72KKAD4FXUI9Ff9CH7gWNd6C7MX36cwFFrlLNZtIboUVfU8taf0I
         8akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTCFbtB+G9v6IanqL7UgbwBT4nA3xa5g0mbbLYZcgHU=;
        b=g0455OG53y7jGz0B6DA7ZXkAuwc5yRIIegYzQ0aK8YDAsw52GZO2MMjk35pV66C1LO
         MNQOUdLILh3lgyP/Y9qEJJHaBHfRtavPzkdMAU0NqNZncssQh9iQiVfFYe6EPFPQYLxS
         8hHp3jLGt1L5+ONkEpzSjWNKDnMRc377e7jj5NSs9Fd5kSDHRJRL9C34HBTyvhxRXni2
         wcC/DRXfeTmbseIYvf7qopuJLlB2dDr0gkB97BaRL6xhfJekFK+Vn9FSJM9tSKVyi2VS
         JYtYr1c2wq2HuXXYMHoqAO3boKUA1HOpsNvv/uFYxPdR16PadDBCrzpCuNvkEsIZfuzo
         vfLw==
X-Gm-Message-State: AFqh2krmSxz9iyIhPHOljgI04PSRtM5N264oCZyPZlazwC66OElGLyxM
	sHYSpxvCNBpdhhMCUgbVDh0GLjfQ/KM=
X-Google-Smtp-Source: AMrXdXtxCAI8kB4zbFnKRIaf1H8c45+8zEHUZR4xShwvocI8OUFChNL/+hx+hXrpPkxSC0Td0EjeGQ==
X-Received: by 2002:a05:6a00:1d03:b0:573:a0a0:c5d2 with SMTP id a3-20020a056a001d0300b00573a0a0c5d2mr31346716pfx.7.1672263849205;
        Wed, 28 Dec 2022 13:44:09 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id o3-20020aa79783000000b0057726bd7335sm5360103pfp.121.2022.12.28.13.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 13:44:08 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] ap: include WMM parameter IE
Date: Wed, 28 Dec 2022 13:44:01 -0800
Message-Id: <20221228214403.2682418-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221228214403.2682418-1-prestwoj@gmail.com>
References: <20221228214403.2682418-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WMM parameter IE is expected by the linux kernel for any AP
supporting HT/VHT etc. IWD won't actually use WMM and its not
clear exactly why the kernel uses this restriction, but regardless
it must be included to support HT.
---
 src/ap.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

v2:
 * Added big endian block to packed structure.

diff --git a/src/ap.c b/src/ap.c
index 595c71c9..b505499d 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -111,6 +111,7 @@ struct ap_state {
 	bool in_event : 1;
 	bool free_pending : 1;
 	bool scanning : 1;
+	bool supports_ht : 1;
 };
 
 struct sta_state {
@@ -834,6 +835,9 @@ static size_t ap_get_extra_ies_len(struct ap_state *ap,
 
 	len += ap_get_wsc_ie_len(ap, type, client_frame, client_frame_len);
 
+	if (ap->supports_ht)
+		len += 26;
+
 	if (ap->ops->get_extra_ies_len)
 		len += ap->ops->get_extra_ies_len(type, client_frame,
 							client_frame_len,
@@ -842,6 +846,67 @@ static size_t ap_get_extra_ies_len(struct ap_state *ap,
 	return len;
 }
 
+/* WMM Specification 2.2.2 WMM Parameter Element */
+struct ap_wmm_ac_record {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	uint8_t aifsn : 4;
+	uint8_t acm : 1;
+	uint8_t aci : 2;
+	uint8_t reserved : 1;
+	uint8_t ecw_min : 4;
+	uint8_t ecw_max : 4;
+#elif defined (__BIG_ENDIAN_BITFIELD)
+	uint8_t reserved : 1;
+	uint8_t aci : 2;
+	uint8_t acm : 1;
+	uint8_t aifsn : 4;
+	uint8_t acw_max : 4;
+	uint8_t acw_min : 4;
+#else
+#error "Please fix <asm/byteorder.h"
+#endif
+	__le16 txop_limit;
+} __attribute__((packed));
+
+static size_t ap_write_wmm_ies(struct ap_state *ap, uint8_t *out_buf)
+{
+	unsigned int i;
+	struct wiphy *wiphy = netdev_get_wiphy(ap->netdev);
+
+	/*
+	 * Linux kernel requires APs include WMM Information element if
+	 * supporting HT/VHT/etc.
+	 *
+	 * The only value we can actually get from the kernel is UAPSD. The
+	 * remaining values (AC parameter records) are made up or defaults
+	 * defined in the WMM spec are used.
+	 */
+	*out_buf++ = IE_TYPE_VENDOR_SPECIFIC;
+	*out_buf++ = 24;
+	memcpy(out_buf, microsoft_oui, sizeof(microsoft_oui));
+	out_buf += sizeof(microsoft_oui);
+	*out_buf++ = 2; /* WMM OUI Type */
+	*out_buf++ = 1; /* WMM Parameter subtype */
+	*out_buf++ = 1; /* WMM Version */
+	*out_buf++ = wiphy_supports_uapsd(wiphy) ? 1 << 7 : 0;
+	*out_buf++ = 0; /* reserved */
+
+	for (i = 0; i < 4; i++) {
+		struct ap_wmm_ac_record ac = { 0 };
+
+		ac.aifsn = 2;
+		ac.acm = 0;
+		ac.aci = i;
+		ac.ecw_min = 1;
+		ac.ecw_max = 15;
+		l_put_le16(0, &ac.txop_limit);
+
+		memcpy(out_buf + (i * 4), &ac, sizeof(struct ap_wmm_ac_record));
+	}
+
+	return 26;
+}
+
 static size_t ap_write_extra_ies(struct ap_state *ap,
 					enum mpdu_management_subtype type,
 					const struct mmpdu_header *client_frame,
@@ -853,6 +918,9 @@ static size_t ap_write_extra_ies(struct ap_state *ap,
 	len += ap_write_wsc_ie(ap, type, client_frame, client_frame_len,
 				out_buf + len);
 
+	if (ap->supports_ht)
+		len += ap_write_wmm_ies(ap, out_buf + len);
+
 	if (ap->ops->write_extra_ies)
 		len += ap->ops->write_extra_ies(type,
 						client_frame, client_frame_len,
@@ -3255,6 +3323,9 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 		ap->band = BAND_FREQ_2_4_GHZ;
 	}
 
+	ap->supports_ht = wiphy_get_ht_capabilities(wiphy, ap->band,
+							NULL) != NULL;
+
 	if (!ap_validate_band_channel(ap)) {
 		l_error("AP Band and Channel combination invalid");
 		return -EINVAL;
-- 
2.34.3

