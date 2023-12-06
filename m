Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5D6EB72
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyhoGaPj"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c673b01eeeso116980a12.1
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 12:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893891; x=1702498691; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxevXmoqhhI+4l2MBFxPbJOmSHW4RYnLU/7XtVoHaTE=;
        b=NyhoGaPjy7JttIhTZgRAbcvBtPw2lLx6WS5tIM4hnwAjXeo8FsGrkLl/enNgGv+tIc
         L9KWwrSe+oCDtdRsRTzPs6T6U1feXuTdDr7JxbrY2sCDkcm5tVZeUVAu63YJvN+hDWYV
         U2punW7yAcMfRvjOfYPmOp7vtwAl9tBtefWLbJNYK0nHx2cKdeyn70tINu+N7WJN9E4R
         eYDZpRZC2yXL7t7Cd+6/+lKnU/qW/ThG59R9KIpRvtDuNQOsjLCVGCpPkSGCkp+LgtXy
         pVjP2B3w4jBOGYlqZMOJWzMeRhJ4QKvoNgh/8pvYSHZ0v0ZUw9G9b9FEtveLPeGJ1pUY
         0nUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893891; x=1702498691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxevXmoqhhI+4l2MBFxPbJOmSHW4RYnLU/7XtVoHaTE=;
        b=WyL6EnF4mmtHDCU/+Nl7Cs6PpNJxqe/dNnmMw7Tuw1KZyqguVppDoN3L1cpR1R+/Ci
         at9A8qFxwwBs5n73bT3cDCnut/hwK3FGI/gKVd2m9/0UuiAAB54bDKUZwygjPPNyh5bl
         aEegNIuH2RNwqtuvHxkj4G0rdpFxBujzXbDnMpONS7qDc6XLHxc5vKZRcZiodlRlalSa
         dzHD1D3aLonf8YAk7/zCRUCSX+XL8Kv/DXRReNrNi/K9oEul+gErejDFROURwGCsaSQq
         uMAbV94Vx6Tm1epc87ZIlY2ANTbmJXETZvEkZFelz1LTiu56iJTBA/KKTdtVkMgb9ds6
         MMvg==
X-Gm-Message-State: AOJu0Yyo9J1Ovz4BoJnQggjMJFy+rl3TaxyiYIzoMSRb5cl0I8mn1Mmh
	WkBjDJ3pfZzlq+LqVHvi2inohhsarHaV8g==
X-Google-Smtp-Source: AGHT+IGgrMxyxsEk67QTx2nItbs0NWXrUnsfReyOh7PZQJL0OVkhejStkkvSzcTGzUF2bWGdzL379w==
X-Received: by 2002:a05:6a20:428e:b0:18a:181b:1439 with SMTP id o14-20020a056a20428e00b0018a181b1439mr1568602pzj.6.1701893891321;
        Wed, 06 Dec 2023 12:18:11 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id by40-20020a056a0205a800b005c2185be2basm243168pgb.54.2023.12.06.12.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:18:11 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 08/13] ft: add FTE/RSNE building to ft_prepare_handshake
Date: Wed,  6 Dec 2023 12:17:57 -0800
Message-Id: <20231206201802.2139649-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206201802.2139649-1-prestwoj@gmail.com>
References: <20231206201802.2139649-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation to remove ft_associate build the FTE/RSNE in
ft_prepare_handshake and set into the handshake object directly.
---
 src/ft.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 43399828..d3b9234a 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -904,9 +904,15 @@ static void ft_info_destroy(void *data)
 	l_free(info);
 }
 
-static void ft_prepare_handshake(struct ft_info *info,
+static bool ft_prepare_handshake(struct ft_info *info,
 					struct handshake_state *hs)
 {
+	uint32_t kck_len = handshake_state_get_kck_len(hs);
+	struct ie_rsn_info rsn_info;
+	struct ie_ft_info ft_info;
+	uint8_t *fte;
+	uint8_t *rsne;
+
 	handshake_state_set_authenticator_address(hs, info->aa);
 
 	memcpy(hs->mde + 2, info->mde, 3);
@@ -914,7 +920,7 @@ static void ft_prepare_handshake(struct ft_info *info,
 	handshake_state_set_chandef(hs, NULL);
 
 	if (!hs->supplicant_ie)
-		return;
+		return true;
 
 	if (info->authenticator_ie)
 		handshake_state_set_authenticator_ie(hs,
@@ -931,6 +937,80 @@ static void ft_prepare_handshake(struct ft_info *info,
 						info->ft_info.r1khid);
 
 	handshake_state_derive_ptk(hs);
+
+	/*
+	 * Rebuild the RSNE to include the PMKR1Name and append
+	 * MDE + FTE.
+	 *
+	 * 12.8.4: "If present, the RSNE shall be set as follows:
+	 * - Version field shall be set to 1.
+	 * - PMKID Count field shall be set to 1.
+	 * - PMKID field shall contain the PMKR1Name.
+	 * - All other fields shall be as specified in 8.4.2.27
+	 *   and 11.5.3."
+	 */
+	if (ie_parse_rsne_from_data(hs->supplicant_ie,
+					hs->supplicant_ie[1] + 2,
+					&rsn_info) < 0)
+		return false;
+
+	rsn_info.num_pmkids = 1;
+	rsn_info.pmkids = hs->pmk_r1_name;
+	/* Always set OCVC false for FT for now */
+	rsn_info.ocvc = false;
+	rsne = alloca(256);
+
+	ie_build_rsne(&rsn_info, rsne);
+	handshake_state_set_supplicant_ie(hs, rsne);
+
+	/*
+	 * 12.8.4: "If present, the FTE shall be set as follows:
+	 * - ANonce, SNonce, R0KH-ID, and R1KH-ID shall be set to
+	 *   the values contained in the second message of this
+	 *   sequence.
+	 * - The Element Count field of the MIC Control field shall
+	 *   be set to the number of elements protected in this
+	 *   frame (variable).
+	 * [...]
+	 * - All other fields shall be set to 0."
+	 */
+	memset(&ft_info, 0, sizeof(ft_info));
+	ft_info.mic_element_count = 3;
+	memcpy(ft_info.r0khid, hs->r0khid, hs->r0khid_len);
+	ft_info.r0khid_len = hs->r0khid_len;
+	memcpy(ft_info.r1khid, hs->r1khid, 6);
+	ft_info.r1khid_present = true;
+	memcpy(ft_info.anonce, hs->anonce, 32);
+	memcpy(ft_info.snonce, hs->snonce, 32);
+
+	/*
+	 * IEEE 802.11-2020 Section 13.7.1 FT reassociation in an RSN
+	 *
+	 * "If dot11RSNAOperatingChannelValidationActivated is true and
+	 *  the FTO indicates OCVC capability, the target AP shall
+	 *  ensure that OCI subelement of the FTE matches by ensuring
+	 *  that all of the following are true:
+	 *      - OCI subelement is present
+	 *      - Channel information in the OCI matches current
+	 *        operating channel parameters (see 12.2.9)"
+	 */
+	if (hs->supplicant_ocvc && hs->chandef) {
+		oci_from_chandef(hs->chandef, ft_info.oci);
+		ft_info.oci_present = true;
+	}
+
+	fte = alloca(256);
+	ie_build_fast_bss_transition(&ft_info, kck_len, fte);
+
+	if (!ft_calculate_fte_mic(hs, 5, rsne, fte, NULL, ft_info.mic))
+		return false;
+
+	/* Rebuild the FT IE now with the MIC included */
+	ie_build_fast_bss_transition(&ft_info, kck_len, fte);
+
+	handshake_state_set_supplicant_fte(hs, fte);
+
+	return true;
 }
 
 static bool ft_send_action(struct wiphy_radio_work_item *work)
-- 
2.34.1

