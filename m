Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438A29A8
	for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 22:32:35 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso7667003pjc.2
        for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 14:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ea9dtO9zu4IZZ60x5SgQ+4HmDnxFTaVZ4B6VOF67QwA=;
        b=c36xFZHtMRJ8T3nz94k8QXB1MTJ3evLqighV2wcYNdHIexs6nA2YWvldeg7vMgLG6B
         ZVcWjtTZ42Z8emeHeqD1u+i/W+nuyKXgIov5QxpVZaAT9rhgYXpq3F8s5TWFNfrYhknc
         n/cghjNi1PZuj55Itqbt7qjhmJpadZX2vZNHOdkzuOuhmpdczynaEYHNfXrtpJ6mMp7b
         p8WHyLTociFRhJrYRAkS1Q3kN/QWIfRLeEpMyZZzj8ciJxUHnmw7BUuJR57BGZ6q2W8X
         7yRZLAG8SNwCcrHLHM2agWcvzKGEptdGAXGjFC+JdoFArbdewxL8oTj/cWAmNDdxB/Sy
         Es4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ea9dtO9zu4IZZ60x5SgQ+4HmDnxFTaVZ4B6VOF67QwA=;
        b=D4xrsfW54Im8SrnZ/rwkG53sqO3PY9i2ZfgZzIGcUC6++nLNkwipiF+jBksi8TdTrG
         CYjmp+2YrB+XK88cWwpto9YGESNnuIGUJi7NK5ovAl0Kc0R8KqzScx/QZPD6us9ab+UK
         teyLFMG6BFBTlcdgwlY1+RqieM2gDb3IkkxDT25iS4cgSMdZTxmvqIuPaAB0UqNFR3m8
         naFRS93OAE93Zc8JC4cLePk6esGW/yWNZWzcBUGdeV5ZgqdoW0cGTW7tXkodMXReEf86
         FFGXMc27fW+AxY5/ESQU1yxGtKrTENtoHU/OwdIk5zS3sWRP1Zup6qCVwqPCRb7bcDoa
         8flA==
X-Gm-Message-State: AFqh2kp6OtU293JKfOi+JgXaNCsZfp4EoNe+xpbL3MNZNO+7XoklATqj
	K8iYl5omNYqtFdwxjDJcAK/96RW/75E=
X-Google-Smtp-Source: AMrXdXugFA7FcM9rI3IMQQ0q7x4TawAComyehS4vy6pfIh1mHB58Z4X6cN6QkkTIEO7HP2v81iyPiw==
X-Received: by 2002:a17:902:9a0b:b0:189:d3dc:a9c4 with SMTP id v11-20020a1709029a0b00b00189d3dca9c4mr25313511plp.36.1672266754394;
        Wed, 28 Dec 2022 14:32:34 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b0017849a2b56asm11549544plg.46.2022.12.28.14.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 14:32:33 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/4] ap: include WMM parameter IE
Date: Wed, 28 Dec 2022 14:32:29 -0800
Message-Id: <20221228223231.2686276-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221228223231.2686276-1-prestwoj@gmail.com>
References: <20221228223231.2686276-1-prestwoj@gmail.com>
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

