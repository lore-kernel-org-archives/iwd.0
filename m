Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA03CF73
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058869; cv=none; b=uRjkodtO5Umee2VTS8qy84BlMpD12nSR8uPUHbgm7KS4HWO1VQLy8s3c6z2T8H8mV2CcgFytJMYzBu0XMV2ich/B0lv+RDWhlYx2GndWphV90D15GhWQd3OecFqEhypm0Tz1zFYLgKAD47iN1VwU0KnHnZt2IyahRMi6jgcj3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058869; c=relaxed/simple;
	bh=LV4M4HAcZdA6HhvR9ceK+6/A9nIt4xmWHOsqGHEyJRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d9Uz+knafAXUhg7u3VzoJ0pyLL4HdLj55CIrZLmnZDoCUIczKBTkagpUPTEuxosDnN5e0nGhduewAcN70ftIe46tWc/gR+1BdwvFJC/qYcoOshNRU0t7GNuObpzIVwOV+j03WdGMzuyqbu95XN26hfROD0X0P0hRiR1wnv46vW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2y7v2sh; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2y7v2sh"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e432514155so2332524a34.1
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 10:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709058866; x=1709663666; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1duKVV3ZbiVOJfU5/FnxOv1snNtcaqSo5TzchCaViw=;
        b=U2y7v2sh5Tq+uJxMMEL+r5mFZa0Qjrvy4U6yAAuUKqFyq98rowDllyTaqBH5uutDKr
         MwPJ0phUicCP3UxRRBdj7pYvCpypyVo1Y1HSvZlli16FwmXZWt0WKJnm5oENeZ0CWHqI
         eo2STzlLT8uEEoPHbCWVATjVeXbZd2vChRXf8OzKcbk/4ZkMR3IYioZ1auntAvCHZFLj
         9lN6dS9i08y3bmYH7m8Kc1AHB0dG8qAgnINBGX8a96H4VsPhpxCJjRf6YECU5+cpLGOj
         o9Ne40HJmQX8dNe+NUFWrNUm7Y/0OOm/oWzhBtFbsqguqfl8SQBLuUZiErvC5TtPaM/c
         /TLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058866; x=1709663666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1duKVV3ZbiVOJfU5/FnxOv1snNtcaqSo5TzchCaViw=;
        b=tDN3/9jd5d0T5XoNzcac0+RTX3QCX+YvY3JUB/MRLO8gWg7UUvS0OdNAS09vlAZM0B
         whEWSRbdoc8YmLMicRz5KiUEKM1QnX/WHDDkaSVDDsZrZ9DL3WA2fMW+Wu900orl+OpY
         jwuuVRpnKG+Ic/+qPS538rv6lrlmJtbCKHVRI3YW24/+0vCl25P1xCKNzD9xD0hZRrWG
         7SYslNke8pzdckxI9Pks/dpPSuYIYInTBDjaYYuCcMVBE9CfvbE7KnIvZaLhW/C1zYPu
         WgLnmVNoG7Nh2OFZ0UoQHWACHrEEJiDubFYNGf1bSp4N2JFHZN58hSpEXy4yjLvp6scH
         o48w==
X-Gm-Message-State: AOJu0YxgbERrpjmOKHVYF8BAKP1V5F3+Od0JNKIbneEVdpHWTROmfj/D
	xklSdllNNpcjC6PQLhazo+wsWLau7WOxQgjYJzMS1H/A5kxWPNtwrX4BSCSe
X-Google-Smtp-Source: AGHT+IE1I/akg6Tcf2KYy9llI2B/BFaFJvA2La1xRkuzoXDbBIWQSXfRZ7ln2RHERKAlIpC5k2+YCw==
X-Received: by 2002:a9d:73d5:0:b0:6e2:bf19:194e with SMTP id m21-20020a9d73d5000000b006e2bf19194emr11734072otk.19.1709058865926;
        Tue, 27 Feb 2024 10:34:25 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jy2-20020a05622a818200b0042e3468a98csm3819617qtb.4.2024.02.27.10.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:34:25 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/11] network: set use default ECC group in handshake setup
Date: Tue, 27 Feb 2024 10:33:58 -0800
Message-Id: <20240227183405.257206-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227183405.257206-1-prestwoj@gmail.com>
References: <20240227183405.257206-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If either the settings specify it, or the scan_bss is flagged, set
the use_default_ecc_group flag in the handshake.

This also renames the flag to cover both OWE and SAE
---
 src/handshake.h | 2 +-
 src/network.c   | 4 ++--
 src/owe.c       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/handshake.h b/src/handshake.h
index 6c58e4d2..62118fe2 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -140,7 +140,7 @@ struct handshake_state {
 	bool authenticator_ocvc : 1;
 	bool supplicant_ocvc : 1;
 	bool ext_key_id_capable : 1;
-	bool force_default_owe_group : 1;
+	bool force_default_ecc_group : 1;
 	uint8_t ssid[32];
 	size_t ssid_len;
 	char *passphrase;
diff --git a/src/network.c b/src/network.c
index a0a89e63..7b996f51 100644
--- a/src/network.c
+++ b/src/network.c
@@ -556,8 +556,8 @@ int network_handshake_setup(struct network *network, struct scan_bss *bss,
 		handshake_state_set_protocol_version(hs, eapol_proto_version);
 	}
 
-	if (hs->akm_suite == IE_RSN_AKM_SUITE_OWE)
-		hs->force_default_owe_group = network->force_default_ecc_group;
+	hs->force_default_ecc_group = network->force_default_ecc_group ||
+						bss->force_default_sae_group;
 
 	/*
 	 * The randomization options in the provisioning file are dependent on
diff --git a/src/owe.c b/src/owe.c
index faa4e17d..da1d643b 100644
--- a/src/owe.c
+++ b/src/owe.c
@@ -45,7 +45,7 @@ struct owe_sm {
 
 static bool owe_reset(struct owe_sm *owe)
 {
-	if (owe->hs->force_default_owe_group) {
+	if (owe->hs->force_default_ecc_group) {
 		if (owe->retry != 0) {
 			l_warn("Forced default OWE group but was rejected!");
 			return false;
-- 
2.34.1

