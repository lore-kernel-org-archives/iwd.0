Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B463F1C4618
	for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768510; cv=none; b=SI+kiIuSRvOdgSs7sPJGhewtBY9i9wgN4BLBn3vG3DcEPAl96PS7VN2E18en5AUOVOwwT7GdUEvgGx9MpQnos+/ETMCfUeEXSLc3ftD9aS0KCHP4xdotCeQ58MGSz8sRfqnQgrNQHe3LtLwVMtQVCz6SmhXILJW8SxDL2AyrSF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768510; c=relaxed/simple;
	bh=7ajmBEMjj21nVZnR+t/JTbKL9a/iHzaweqdfhRouYRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=drEhHyEWIpORprpCIlhwfh6HPfnc1omhTNLMv0JrpChSmrPFwk2ri0DLAmYwYvB6OjDO76GBPNhbgsIGWa/lsQFh5aoK2kNxcqwMuMngvQyT6e/zFow41NS3LAsy/Qag5SnBLOp7I/spnbimCkuKXvSXJNb6OhAN0EyCmOCKPNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDi6nEjV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDi6nEjV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2021c03c13aso41825545ad.1
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724768508; x=1725373308; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RdC5IqSkOq7x0LS9WJZbQI2kU4B3dkOtPe4g96iqKlY=;
        b=gDi6nEjVoeei56yK1DyMfOwgMmP9eQO1fMSsDsiMF/XyMIWT07jp8QLwUM9Ofcg31C
         TOcn3vEX5mfetMm4bJEuDeEfPyjkl+QOxx5b01mCMb0zlNP3Au+4uyyMKy7CHIKHoIbI
         tmYAHzYhy3g7wm5LDee9zSFrxg0RdDm1/WjXozPrjX6FgkwyMtNxplqHsz53/akfZ9BC
         jQV3mJudyODFjriXiq2+zxw/wcLvcCGRHN+xlhLHhbEYdqYYxpkPOtd9CYkeA6UU5MZL
         sTdJ1IODgswGmQo2QeQg7AmnTdm26G2qpsbDo1cIEhs4sfMdJAUmZSvnVr8QxPmpSyUw
         7Wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768508; x=1725373308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdC5IqSkOq7x0LS9WJZbQI2kU4B3dkOtPe4g96iqKlY=;
        b=iaIredS1lQT6SlIXZjbhJ4Zu7YC9ujEs1e/8uzprmJCxGBluAZILMmlr1e83N+BH21
         hiNPFtlnnXh4gcft/6A7+6s2K+QOp/0OBxWfb+zcqhjf07s7VmgmCLqmZMYh0psQV/G7
         yrGJ0yGM9VmvDCzAbStLZsKnjADlZ77tlcEAiEG7dEn1eA6jaxZE9/+VnDHaAXE2hNQX
         E2iOX59pg/Rb/qlaH0IiVt/4nzV1qmtRCCfcL8yZMErxBEeV20Yq7hR3DWj/dofYViVf
         95K/bUM9bxT2JpHGEyRDFv0u0sVQjcFsXZLaIwqkdBwjUTwrliWqVg7b3mHhoY/SWBKm
         kVBA==
X-Gm-Message-State: AOJu0Yzm1/SblzTSveFBBV9X5GzPxgmm7rw0tzL9g+NG5GcRX6TWZ8vj
	hNv0H35tfJBAyZDNOv6Nl9ufLGgOBSODx6B7t55cwD8a6OiYJKn04u9LLA==
X-Google-Smtp-Source: AGHT+IEGohMGhWqDK1xAtEgtkvNEHQWnjt++H7Jejxj9GAYACtHBErPfdF5pS5OELmWI4nLfSFZ5hQ==
X-Received: by 2002:a17:903:bc3:b0:202:3158:ebdb with SMTP id d9443c01a7336-204ddd33f4bmr30411795ad.19.1724768507630;
        Tue, 27 Aug 2024 07:21:47 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609099sm83635695ad.192.2024.08.27.07.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:21:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] dpp: factor out key derivation and starting PKEX into functions
Date: Tue, 27 Aug 2024 07:21:22 -0700
Message-Id: <20240827142125.751023-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will make things a bit easier in future patches, and reduces
some of the length/complexity of these functions.
---
 src/dpp.c | 92 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 41 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index d89c3056..c1047ca3 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -4280,6 +4280,17 @@ static uint32_t *dpp_default_freqs(struct dpp_sm *dpp, size_t *out_len)
 	return freqs_out;
 }
 
+static void __dpp_pkex_start_enrollee(struct dpp_sm *dpp)
+{
+	dpp->current_freq = dpp->freqs[0];
+
+	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
+
+	l_debug("PKEX start enrollee (id=%s)", dpp->pkex_id ?: "unset");
+
+	dpp_start_offchannel(dpp, dpp->current_freq);
+}
+
 static bool dpp_pkex_scan_notify(int err, struct l_queue *bss_list,
 					const struct scan_freq_set *freqs,
 					void *user_data)
@@ -4314,13 +4325,7 @@ static bool dpp_pkex_scan_notify(int err, struct l_queue *bss_list,
 	dpp->freqs = scan_freq_set_to_fixed_array(freq_set, &dpp->freqs_len);
 
 start:
-	dpp->current_freq = dpp->freqs[0];
-
-	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
-
-	l_debug("PKEX start enrollee (id=%s)", dpp->pkex_id ?: "unset");
-
-	dpp_start_offchannel(dpp, dpp->current_freq);
+	__dpp_pkex_start_enrollee(dpp);
 
 	return false;
 
@@ -4338,40 +4343,6 @@ static void dpp_pkex_scan_destroy(void *user_data)
 
 static bool dpp_start_pkex_enrollee(struct dpp_sm *dpp)
 {
-	_auto_(l_ecc_point_free) struct l_ecc_point *qi = NULL;
-
-	memcpy(dpp->peer_addr, broadcast, 6);
-
-	/*
-	 * In theory a driver could support a lesser duration than 200ms. This
-	 * complicates things since we would need to tack on additional
-	 * offchannel requests to meet the 200ms requirement. This could be done
-	 * but for now use max_roc or 200ms, whichever is less.
-	 */
-	dpp->dwell = (dpp->max_roc < 200) ? dpp->max_roc : 200;
-	/* "DPP R2 devices are expected to use PKEXv1 by default" */
-	dpp->pkex_version = 1;
-
-	if (!l_ecdh_generate_key_pair(dpp->curve, &dpp->pkex_private,
-					&dpp->pkex_public))
-		goto failed;
-
-	/*
-	 * "If Qi is the point-at-infinity, the code shall be deleted and the
-	 * user should be notified to provision a new code"
-	 */
-	qi = dpp_derive_qi(dpp->curve, dpp->pkex_key, dpp->pkex_id,
-				netdev_get_address(dpp->netdev));
-	if (!qi || l_ecc_point_is_infinity(qi)) {
-		l_debug("Cannot derive Qi, provision a new code");
-		goto failed;
-	}
-
-	dpp->pkex_m = l_ecc_point_new(dpp->curve);
-
-	if (!l_ecc_point_add(dpp->pkex_m, dpp->pkex_public, qi))
-		goto failed;
-
 	dpp_property_changed_notify(dpp);
 
 	/*
@@ -4438,6 +4409,40 @@ static bool dpp_parse_pkex_args(struct l_dbus_message *message,
 	return true;
 }
 
+static bool dpp_pkex_derive_keys(struct dpp_sm *dpp)
+{
+	_auto_(l_ecc_point_free) struct l_ecc_point *qi = NULL;
+
+	/*
+	 * In theory a driver could support a lesser duration than 200ms. This
+	 * complicates things since we would need to tack on additional
+	 * offchannel requests to meet the 200ms requirement. This could be done
+	 * but for now use max_roc or 200ms, whichever is less.
+	 */
+	dpp->dwell = (dpp->max_roc < 200) ? dpp->max_roc : 200;
+	/* "DPP R2 devices are expected to use PKEXv1 by default" */
+	dpp->pkex_version = 1;
+
+	if (!l_ecdh_generate_key_pair(dpp->curve, &dpp->pkex_private,
+					&dpp->pkex_public))
+		return false;
+
+	/*
+	 * "If Qi is the point-at-infinity, the code shall be deleted and the
+	 * user should be notified to provision a new code"
+	 */
+	qi = dpp_derive_qi(dpp->curve, dpp->pkex_key, dpp->pkex_id,
+				netdev_get_address(dpp->netdev));
+	if (!qi || l_ecc_point_is_infinity(qi)) {
+		l_debug("Cannot derive Qi, provision a new code");
+		return false;
+	}
+
+	dpp->pkex_m = l_ecc_point_new(dpp->curve);
+
+	return l_ecc_point_add(dpp->pkex_m, dpp->pkex_public, qi);
+}
+
 static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
@@ -4472,6 +4477,11 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 		return dbus_error_from_errno(ret, message);
 	}
 
+	if (!dpp_pkex_derive_keys(dpp)) {
+		dpp_reset(dpp);
+		return dbus_error_failed(message);
+	}
+
 	if (!wait_for_disconnect && !dpp_start_pkex_enrollee(dpp))
 		goto invalid_args;
 
-- 
2.34.1

