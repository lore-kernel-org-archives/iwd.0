Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CB37E
	for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 21:43:24 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so157211pjd.0
        for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 13:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FDmKdCDStOBJTYeI1fytSDF+/+k8maCR22xXAvqpH7c=;
        b=c2EG602l6nJm0kOah+a73cugjx11b0jEH38jvWtoKh3eYZJUDh4ue6JuvJdlM/5iAh
         noKHaNqz9FTaQqbeI7gxhTvoL3gBiSN5+sfxirDQSBypl9DqLbw8gtb2anVWe9+AjQXv
         CGaIsbkx9xD8OKgVWDG+gM1m5lRB7QAtyKZabI/9OCAQ11GqICw8kHEMeIn4746Z4R7V
         /zkRVNMVe2uDkqZOL6FJzsQ1UXZ+vt1O8NUG4Z1vYbMagBlM7PhV6NMeftqK0uofEMYv
         RrN/LeT8kpnd+6Dw+cmfKHkZdvVVfhirtXNgUXB3A1GdiX01c6HkoVdZJMit1k1gFyqv
         IsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDmKdCDStOBJTYeI1fytSDF+/+k8maCR22xXAvqpH7c=;
        b=5howxhqtXNVnsDTgaGrhefTodLs7PJIo91pXLbMZxmimTzFIE2nxwmhwNbp6e7M7dR
         zLfeIK7iQocn/DsguXeGVBsEcz2IyZPCK36Dxb3wv9gfp54vYdrUbX2RHzxyOYO6Rfch
         LTSw5nxSZ1j1d9n4IDWAfzE4pNYzXg189P4/VX/TqIzQvVHWuel3rS2fT3ZBgOJ7XS42
         Lz4Rpb0tSu4rC6TYFOSGJqa3kGlTpK3p59Y6vHtWBzXHOnkVut7OFRdrHTgXYmSqDkgM
         jL7/11vvzRc/k9vHvXULjKyoZugiV0jIF64qa+9blBi4046IXtaEEw4n7GPp5Z/huzQm
         B5eg==
X-Gm-Message-State: AFqh2krNJVT8V6A8shbnbDq0KvKzn1Z1oTFTX1pnNmC8QnSObq5BbXQw
	eo4CTtWsWYJsK1XMLe/4VmDPhrxu26Q=
X-Google-Smtp-Source: AMrXdXsM6cK4spYCktrMNH2MtK+N9ckj3OFyCrWNYG7Tj1vaWu0nIrXKZuGd7jBMiFOQnh05cy8Bfg==
X-Received: by 2002:a17:90a:f317:b0:219:3a95:5b04 with SMTP id ca23-20020a17090af31700b002193a955b04mr17142253pjb.25.1671572603371;
        Tue, 20 Dec 2022 13:43:23 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e88-20020a17090a6fe100b00219cf5c3829sm8153301pjk.57.2022.12.20.13.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 13:43:22 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/10] ap: make supported rates a common builder.
Date: Tue, 20 Dec 2022 13:43:09 -0800
Message-Id: <20221220214318.2041986-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The supported rates IE was being built in two places. This makes that
code common. Unfortunately it needs to support both an ie builder
and using a pointer directly which is why it only builds the contents
of the IE and the caller must set the type/length.
---
 src/ap.c | 68 +++++++++++++++++++++++++-------------------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index a9027f79..595c71c9 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -802,6 +802,29 @@ static size_t ap_write_wsc_ie(struct ap_state *ap,
 	return len;
 }
 
+static size_t ap_build_supported_rates(struct ap_state *ap,
+					uint8_t *rates)
+{
+	uint32_t minr, maxr, count, r;
+
+	minr = l_uintset_find_min(ap->rates);
+	maxr = l_uintset_find_max(ap->rates);
+	count = 0;
+	for (r = minr; r <= maxr && count < 8; r++)
+		if (l_uintset_contains(ap->rates, r)) {
+			uint8_t flag = 0;
+
+			/* Mark only the lowest rate as Basic Rate */
+			if (count == 0)
+				flag = 0x80;
+
+			*rates++ = r | flag;
+			count++;
+		}
+
+	return count;
+}
+
 static size_t ap_get_extra_ies_len(struct ap_state *ap,
 					enum mpdu_management_subtype type,
 					const struct mmpdu_header *client_frame,
@@ -858,8 +881,7 @@ static size_t ap_build_beacon_pr_head(struct ap_state *ap,
 	struct mmpdu_header *mpdu = (void *) out_buf;
 	uint16_t capability = IE_BSS_CAP_ESS | IE_BSS_CAP_PRIVACY;
 	const uint8_t *bssid = netdev_get_address(ap->netdev);
-	uint32_t minr, maxr, count, r;
-	uint8_t *rates;
+	size_t len;
 	struct ie_tlv_builder builder;
 
 	memset(mpdu, 0, 36); /* Zero out header + non-IE fields */
@@ -884,24 +906,8 @@ static size_t ap_build_beacon_pr_head(struct ap_state *ap,
 
 	/* Supported Rates IE */
 	ie_tlv_builder_next(&builder, IE_TYPE_SUPPORTED_RATES);
-	rates = ie_tlv_builder_get_data(&builder);
-
-	minr = l_uintset_find_min(ap->rates);
-	maxr = l_uintset_find_max(ap->rates);
-	count = 0;
-	for (r = minr; r <= maxr && count < 8; r++)
-		if (l_uintset_contains(ap->rates, r)) {
-			uint8_t flag = 0;
-
-			/* Mark only the lowest rate as Basic Rate */
-			if (count == 0)
-				flag = 0x80;
-
-			*rates++ = r | flag;
-			count++;
-		}
-
-	ie_tlv_builder_set_length(&builder, count);
+	len = ap_build_supported_rates(ap, ie_tlv_builder_get_data(&builder));
+	ie_tlv_builder_set_length(&builder, len);
 
 	/* DSSS Parameter Set IE for DSSS, HR, ERP and HT PHY rates */
 	ie_tlv_builder_next(&builder, IE_TYPE_DSSS_PARAMETER_SET);
@@ -1540,8 +1546,8 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, struct sta_state *sta,
 	struct mmpdu_header *mpdu = (void *) mpdu_buf;
 	struct mmpdu_association_response *resp;
 	size_t ies_len = 0;
+	size_t len;
 	uint16_t capability = IE_BSS_CAP_ESS | IE_BSS_CAP_PRIVACY;
-	uint32_t r, minr, maxr, count;
 
 	memset(mpdu, 0, sizeof(*mpdu));
 
@@ -1561,23 +1567,9 @@ static uint32_t ap_assoc_resp(struct ap_state *ap, struct sta_state *sta,
 
 	/* Supported Rates IE */
 	resp->ies[ies_len++] = IE_TYPE_SUPPORTED_RATES;
-
-	minr = l_uintset_find_min(ap->rates);
-	maxr = l_uintset_find_max(ap->rates);
-	count = 0;
-	for (r = minr; r <= maxr && count < 8; r++)
-		if (l_uintset_contains(ap->rates, r)) {
-			uint8_t flag = 0;
-
-			/* Mark only the lowest rate as Basic Rate */
-			if (count == 0)
-				flag = 0x80;
-
-			resp->ies[ies_len + 1 + count++] = r | flag;
-		}
-
-	resp->ies[ies_len++] = count;
-	ies_len += count;
+	len = ap_build_supported_rates(ap, resp->ies + ies_len + 1);
+	resp->ies[ies_len++] = len;
+	ies_len += len;
 
 	ies_len += ap_write_extra_ies(ap, stype, req, req_len,
 					resp->ies + ies_len);
-- 
2.34.3

