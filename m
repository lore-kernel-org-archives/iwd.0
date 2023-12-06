Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D436F3F8FE
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFoiNmUO"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77dc733b25cso417979885a.1
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 07:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875238; x=1702480038; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2VZUxX7utKd63GQ/iRjK0VbmkJFuijbHNmVwrfWouU=;
        b=IFoiNmUOOOHRiXLPesPD9ZvwyoV9gsx3uc6PMPoEmCkFqvq6eWRZGaftILvMuGTcvQ
         MOJThWAAgMRceInsWJyyywrTvacAQ8ci9DqZeI1VkFC7YeFam0fJFVSeXIufI/d/shQr
         wv3ZHYNJL4YvCPwIwswBTGRlSB+U1t2Kj+WCb/1VMeZOnR/K0sTrtMCt6XHyYFKjR/we
         llmLdQnDZN9BZPXVBeBLraGvNKGRBrrpa5eEXdAu4ETFNiLfmVqKgX0Yty5Mjw8XeQFP
         cHI0rD4rIAsd5rYyPV7+JMtzjkdev92pmWoYgoWcZqSTk+jPaCN21p6Evn314wTKd6qJ
         F2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875238; x=1702480038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2VZUxX7utKd63GQ/iRjK0VbmkJFuijbHNmVwrfWouU=;
        b=r/7X+lJRPNZI1IUAqi9dwo++53/3dkF3kpYRqpWmNnAFZFwI3NXCigu0MgbWVm734e
         0GBcRDIUzOIdkt5hXXHkBFXZe20l/NmuMEeVcq8ZcqsmrOeet/JiUpnxEE23tEzKvcag
         HDCxjACjajuK21iYMwUgKpzHdVvQ/vjTKCYMTv99VZ1WYhutEs1tt2g/gEdVJS/p2+6C
         kzYaAjElKzkYmhH0obkZl7P6fADH/nE7FzJ+aj9VB5x3j6RWPJaVOcycJnwXKDrTflyl
         nBJoZMgXwxSKcv8jrr6kT93gCJkJU2aGDpNh82a8CBemLIwXeO57G2X03j1wPlVSJsL3
         pxOQ==
X-Gm-Message-State: AOJu0Yw666tA3SyfxgT7CAlxjc+mvrf4kRF2zgRjHqfyR7Ogsjj3JFr/
	4dWjmvDhHUdTJii4S65IPy5wZwXY0K4=
X-Google-Smtp-Source: AGHT+IH6d218raNDSoM6fOzBnBgdeGzgnzxQpG/xAgT2lCsNETTz+lgAvJdydUK14qL5vVZoYI45FA==
X-Received: by 2002:a05:620a:46a3:b0:77f:14f:9988 with SMTP id bq35-20020a05620a46a300b0077f014f9988mr1301106qkb.101.1701875238448;
        Wed, 06 Dec 2023 07:07:18 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id vy22-20020a05620a491600b0077d66277e9asm11506qkn.116.2023.12.06.07.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:07:17 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/9] ft: add FTE/RSNE building to ft_prepare_handshake
Date: Wed,  6 Dec 2023 07:07:03 -0800
Message-Id: <20231206150708.2080336-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206150708.2080336-1-prestwoj@gmail.com>
References: <20231206150708.2080336-1-prestwoj@gmail.com>
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
index 2cc611b8..358a4594 100644
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
+	handshake_state_set_fte(hs, fte);
+
+	return true;
 }
 
 static bool ft_send_action(struct wiphy_radio_work_item *work)
-- 
2.34.1

