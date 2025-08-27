Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11C34A319
	for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299308; cv=none; b=TCE9Tg4GP1cN+DICRJ4HR0cwfsO4gEi+KiinF3y38KXOpa5+gP5Cz2urkmAdw+7WDt9iYvZUHMZNPt2LhN3AC63htfkURoqBFnO2Dqa7yN++T72/b6J+d59HIUhlaZWbhNVDIWqW5Y7GelMRg9OBoRGIE2DgOFinuUDNDpwJGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299308; c=relaxed/simple;
	bh=LrSgY8sOr3kKqOJLuSm+TeIA7CYhRSdAVmXGINoh9LU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fwVbUmYnKmDfBjquvcGU/39oHGTqgikfBXW12EdCUj2rI1I62A+6Ujl+aFbjcnsrkzOpToU3zrvFdSp3O8BWWbH7blTiMYTsiOMW4p7STydJWD1n9ECweC1sBEFn4Dn/Y1fndu6jzbKxfUbuejcfAJIO5kfXMkNdD3xn7AmGHMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M56EYtf5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M56EYtf5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2467de5160eso37813665ad.0
        for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 05:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756299306; x=1756904106; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRJqIhXFuK13gkU+BfSsuPdeFTVOKoEHKVHH9qXUtYk=;
        b=M56EYtf5wC7Ss0xfQ3AxOR8JnW4bDXIhctKAla+Y8S41CTjsJYsaF9mHsUIiJxBHzl
         NZkFXpFjH7IY0FHT/Z2UuumtpN6wyOS7v/cDUiGSSyGXfTubvk7FhBVVMJMwchwrbk0/
         oFgFJKcQY4/pdoLQ+ZpQF67VV3uTwmBVmr71Z946GqigSiKURvajNjSz4ihUQMDzZbN5
         qukGFZG5TfI4rNN3vblOtCK0WP81T8WmqoiiMbLlyWjO3RbT980uii0c7fGA/YhmgL0U
         Xjgg+l5Vf6y9yf2FUdOt738qPWM23j6nFWpp2Ug5spoPPuNmGZj/vMEW/hTS6VB+EvZM
         6Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299306; x=1756904106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRJqIhXFuK13gkU+BfSsuPdeFTVOKoEHKVHH9qXUtYk=;
        b=G6ZjQRhAxgSrFwgGNrjbcUKwnBdo+fB+OUHIn7RuKUTuClZYIV1TjGgl6rJgXowvwZ
         RUrOt6KvNqEvRC3jDrzXAmr3/SASGPR7/JP6AVvKFDvnWi7YZJ6WpGvnnrq4Nft+zAC7
         SalhQCdaT2UaS+bvIzYe9gRJmW/HVxw58Gh7eaFxwddRzyVa2A2ePkdAhH6EHnhqLpjx
         y0ETg2kkyv21bnN42zBCP8RyaruJsTiUlKG4v5pJU9w/bQJTvULwtIarY9QmaDMqlH8/
         1DWhhP5k6GQD8sFiMC9sDDKbd8cXLJ89av5+GzsiwueJNrQU1uc34EInsZ7ItkE7FwpP
         RsCA==
X-Gm-Message-State: AOJu0Yy6adXqOsCYumdfqFZPoQBTibYuLz3YtwCdjq2UZUBsGbuFsM+S
	LZxyVJzUGDr4Qn/PnPDDnuwuuw3v1avao/TK0gnTD11mlPXwjk+dxvB9J6TMVw==
X-Gm-Gg: ASbGncvKDcSkuyneAzOLKuTZPUmxWOeaUlGvITLDmi3iVCoVyyKmkVQWL5FkXEv6UKL
	Y0p04g5h35wCPrCPpz6x+4N3FAGmlpgnPQ7ZC934dk/1EVumEZ/oQ/dOoOzajKaboN+wR0uRf+D
	nntV5PzkiO3rQwHtDt24q6zZK1TWzuVAqTmi5+cLy3sWmIvig1b64K2q7sCPWK23+D3qtr56X8u
	VWPwPcfNRKel00JpK0tTSEPNycLmYxGtJ9sAYfp9mc7OdK/HCt/SjxAGLzQpj6ZCXFe1OQRnWKh
	blVVvp/iklFMMxZFP8B62omkOkFKD0PMVNdBfGNZvGGR+IVLWgK+PrrgPXSMI32hFmSO/yNHoV1
	ogZ4NyvcepM/wI9Oqa3U3KpO6ptpZF+/PD2cmKIjWdq7C/nGEt7gYWDz5l0ERuAEDXGZ6YuEHfB
	YXjr8UZzp3
X-Google-Smtp-Source: AGHT+IEp4NqkhDivCD/YOqlV4Az6PJzrMzoS5j2hHKOVL9pSYCx6ZscreDmjkPDGVCmtOG8qUJk/XQ==
X-Received: by 2002:a17:902:e841:b0:240:3c62:6194 with SMTP id d9443c01a7336-2462ee52164mr270741915ad.20.1756299305975;
        Wed, 27 Aug 2025 05:55:05 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687c75b5sm121650955ad.66.2025.08.27.05.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:55:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 03/11] handshake: pass object to handshake_util_ap_ie_matches
Date: Wed, 27 Aug 2025 05:54:53 -0700
Message-Id: <20250827125501.477908-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827125501.477908-1-prestwoj@gmail.com>
References: <20250827125501.477908-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to prepare for supporting a vendor quirk, where we'll need
the handshake to lookup if the quirk to disable a specific check.
---
 src/eapol.c     |  2 +-
 src/ft.c        | 10 ++++++----
 src/handshake.c |  3 ++-
 src/handshake.h |  3 ++-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 6e37a54a..ab77746f 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1810,7 +1810,7 @@ static void eapol_handle_ptk_3_of_4(struct eapol_sm *sm,
 
 	if ((rsne[1] != hs->authenticator_ie[1] ||
 			memcmp(rsne + 2, hs->authenticator_ie + 2, rsne[1])) &&
-			!handshake_util_ap_ie_matches(&rsn_info,
+			!handshake_util_ap_ie_matches(hs, &rsn_info,
 							hs->authenticator_ie,
 							hs->wpa_ie))
 		goto error_ie_different;
diff --git a/src/ft.c b/src/ft.c
index d8bee74c..0d6be4d4 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -223,7 +223,8 @@ static bool ft_parse_associate_resp_frame(const uint8_t *frame, size_t frame_len
 	return true;
 }
 
-static bool ft_verify_rsne(const uint8_t *rsne, const uint8_t *pmk_r0_name,
+static bool ft_verify_rsne(struct handshake_state *hs,
+				const uint8_t *rsne, const uint8_t *pmk_r0_name,
 				const uint8_t *authenticator_ie)
 {
 	/*
@@ -253,7 +254,7 @@ static bool ft_verify_rsne(const uint8_t *rsne, const uint8_t *pmk_r0_name,
 				memcmp(msg2_rsne.pmkids, pmk_r0_name, 16))
 		return false;
 
-	if (!handshake_util_ap_ie_matches(&msg2_rsne, authenticator_ie, false))
+	if (!handshake_util_ap_ie_matches(hs, &msg2_rsne, authenticator_ie, false))
 		return false;
 
 	return true;
@@ -301,7 +302,8 @@ static int parse_ies(struct handshake_state *hs,
 	is_rsn = hs->supplicant_ie != NULL;
 
 	if (is_rsn) {
-		if (!ft_verify_rsne(rsne, hs->pmk_r0_name, authenticator_ie))
+		if (!ft_verify_rsne(hs, rsne, hs->pmk_r0_name,
+					authenticator_ie))
 			goto ft_error;
 	} else if (rsne)
 		goto ft_error;
@@ -480,7 +482,7 @@ int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
 				memcmp(msg4_rsne.pmkids, hs->pmk_r1_name, 16))
 			return -EBADMSG;
 
-		if (!handshake_util_ap_ie_matches(&msg4_rsne,
+		if (!handshake_util_ap_ie_matches(hs, &msg4_rsne,
 							hs->authenticator_ie,
 							false))
 			return -EBADMSG;
diff --git a/src/handshake.c b/src/handshake.c
index c469e6fa..92edac30 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -877,7 +877,8 @@ void handshake_state_set_igtk(struct handshake_state *s, const uint8_t *key,
  * results vs the RSN/WPA IE obtained as part of the 4-way handshake.  If they
  * don't match, the EAPoL packet must be silently discarded.
  */
-bool handshake_util_ap_ie_matches(const struct ie_rsn_info *msg_info,
+bool handshake_util_ap_ie_matches(struct handshake_state *s,
+					const struct ie_rsn_info *msg_info,
 					const uint8_t *scan_ie, bool is_wpa)
 {
 	struct ie_rsn_info scan_info;
diff --git a/src/handshake.h b/src/handshake.h
index c6e3c10b..b8891490 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -312,7 +312,8 @@ bool handshake_state_set_pmksa(struct handshake_state *s, struct pmksa *pmksa);
 void handshake_state_cache_pmksa(struct handshake_state *s);
 bool handshake_state_remove_pmksa(struct handshake_state *s);
 
-bool handshake_util_ap_ie_matches(const struct ie_rsn_info *msg_info,
+bool handshake_util_ap_ie_matches(struct handshake_state *s,
+					const struct ie_rsn_info *msg_info,
 					const uint8_t *scan_ie, bool is_wpa);
 
 const uint8_t *handshake_util_find_kde(enum handshake_kde selector,
-- 
2.34.1

