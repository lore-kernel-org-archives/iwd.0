Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E987E
	for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 21:43:29 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id gv5-20020a17090b11c500b00223f01c73c3so1782510pjb.0
        for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 13:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAMCPUCjV5MVgWosG1cUlDAq3SeN3eTOUOxztz5+QA8=;
        b=PFT23oQzQF1pY4CNkJRk/Yd9lB61FbNbW5BCvv8xFgSzp/xJAFQ7tenetA3eNBRihl
         KH6JEIb/pvCLaNd4yEHWsPbFjMvMFnczO+hzEGN9N6F/NgxuBvq+jeGDB6UCKwDbAgPZ
         MpfbBVIarQnw2bxTJkzmTGEjUzpV1flKYlC9lsbiWXBJuCbA8i4fAH4pIl+dYellL51/
         YCLmj7v+P0Aj3RyIG18G5VCmaZB0pnD0aWEKOvGBVQQvg2TOIFl5fRhIWRM6eiNllZNv
         jGOqm3IztIYj0ZGLWDgV390NmB/c5/VbI658mKT45+KAex8qq8OypyJ460RwuXuZI5Yj
         5eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAMCPUCjV5MVgWosG1cUlDAq3SeN3eTOUOxztz5+QA8=;
        b=HpyOT8cR/GPLvNf+6urBEK0MEkOXvGOyfka/U7nob1x9ifP5bVStEIYECVvr7FEusE
         Dx2skI6dpFZM2vEQOsC21QIyqzfjIckgSnbbZx/Pjv3NhAqNoRqESajj+MGJAey99TLr
         K/3vk3/qlQ/Zpcod+aBZ5N7Mn2DPGz/h3vCjVNXAjDiHGxE+cxll1++qPnCTXpm396M5
         IlyxZa8lyXzlXwQmghx4ctpkXQbKky+zFT0ypNIKxYEPJIZdUXFObTleaOvdxfrp6BnB
         5AtEr1w2RDiv5bCaBOVPm2oKOKEUpb5hVSC/VKsIm2028rhpHbEOUaC27hAFPKzM9pYx
         D+Yg==
X-Gm-Message-State: ANoB5pnzZJndFKvQ2tAcGe/Gb9G7krrpqMEeHAB2jDewzAI4tSxTaiFt
	JgNBzcdKT0S/UAtFMMSEpLYfvFzJdPk=
X-Google-Smtp-Source: AA0mqf6y23+2ikUl8aMnWJs7FmkRuBs1fm6+/4rFkfecVgI95906jj9foIT2kMIQgt46dRnPvu3BXw==
X-Received: by 2002:a17:90a:ad47:b0:219:2da4:4168 with SMTP id w7-20020a17090aad4700b002192da44168mr49635181pjv.23.1671572608657;
        Tue, 20 Dec 2022 13:43:28 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e88-20020a17090a6fe100b00219cf5c3829sm8153301pjk.57.2022.12.20.13.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 13:43:28 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/10] ap: include WMM parameter IE
Date: Tue, 20 Dec 2022 13:43:16 -0800
Message-Id: <20221220214318.2041986-8-prestwoj@gmail.com>
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

The WMM parameter IE is expected by the linux kernel for any AP
supporting HT/VHT etc. IWD won't actually use WMM and its not
clear exactly why the kernel uses this restriction, but regardless
it must be included to support HT.
---
 src/ap.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index 595c71c9..d3188d1d 100644
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
@@ -842,6 +846,56 @@ static size_t ap_get_extra_ies_len(struct ap_state *ap,
 	return len;
 }
 
+/* WMM Specification 2.2.2 WMM Parameter Element */
+struct ap_wmm_ac_record {
+	uint8_t aifsn : 4;
+	uint8_t acm : 1;
+	uint8_t aci : 2;
+	uint8_t reserved : 1;
+	uint8_t ecw_min : 4;
+	uint8_t ecw_max : 4;
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
@@ -853,6 +907,9 @@ static size_t ap_write_extra_ies(struct ap_state *ap,
 	len += ap_write_wsc_ie(ap, type, client_frame, client_frame_len,
 				out_buf + len);
 
+	if (ap->supports_ht)
+		len += ap_write_wmm_ies(ap, out_buf + len);
+
 	if (ap->ops->write_extra_ies)
 		len += ap->ops->write_extra_ies(type,
 						client_frame, client_frame_len,
@@ -3255,6 +3312,9 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
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

