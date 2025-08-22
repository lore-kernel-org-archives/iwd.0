Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DA02D640D
	for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892299; cv=none; b=s2Q2ywKXBnRjdLbRmwux92oT5cWEXiM/uijxlzZkMnoFp/CzH8VEh//vbOoRBbHUkTVHiY/5GPX//Mf29k1CbE7+ZeUvEJtiEhHoHBz7bPasGCa8AqiUv9H/FnwrMNuidI9gosoew+BQ1q5qjFB26O1ocMBQsbDaS7PzVBh77us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892299; c=relaxed/simple;
	bh=pF+zHHFqlSo70O2dZkXZoy5gZCQ05RtPtJEJDw54Dq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QooXK9hqsyhUrwoyuAvK7U8E4o+pWQJF8OLEZ0xacFbtD/HU8P6PJHMjYW0HfQAjWLQnVhWXph7vINfteznrKWrQZvAef2GnVFj4OYq5PB1YA1D2PRn3YbBl9/MSLb5Vmfe0H3E+qFgheuaGXeiAPRySfkeV4nV1i3Boub39UII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbCBPJIJ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbCBPJIJ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b133b24e69so11173611cf.2
        for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 12:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892296; x=1756497096; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0CjtjNZOlI8o7aEVbB8MfFv0M3GHHwCxN8BUDsOW1c=;
        b=XbCBPJIJmDFPFv9BRo/vM/bM1lbYROjvvr154VPPYyGpCawIAg4Tx3NwI/txYpYmji
         qljWxGfLhtA2F1z2SaWBqmWOrGzULa/aw4Vm8a/wtdtSoTEILWc8Irn+lBydV3XddaPa
         5NYYPzJ8EWYAJxVNaxFeeRGgYyPc5OePLnt525cJ2sV7k1l9ouUGFyxpkqN3fgrETnwF
         8SCLzh+4UKikrK2AoS1rp6M3fDdrI4GCkqzVIhzdw89i1hR2JE7K8/zKiaVW6AzHjEQy
         MAZHab71drxw8lUeqJrdCKtWOX/BmMbjpZ5YJKQ+WwfrrB+aYRbkBZXm953bAneIeMef
         21Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892296; x=1756497096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0CjtjNZOlI8o7aEVbB8MfFv0M3GHHwCxN8BUDsOW1c=;
        b=LJa83fWWIrEvWGRAfiU7FCC3uFXH35/HeZ+dOw+auUwIYny1n0jHVRjMjaYEoX009+
         2r9R16JhCqwMfHmlyfOLf6+gWnKlZHCzXcwgSsvqJxZBQRU6F+0VkBQijK4zjiPxLJzY
         xC9iRR4lpwuvz7GgZCKQjqOyYWCyohUsKTjAbM2f7hJMBNiNSND3gl1fN/mTdZp14ayF
         P911cDyXF867nwV6E/luSKAVcos82Q06PlnjpyXCcsoXw0yIW+zwjDseIiqNefdqZmd6
         ArXNGakAA2vstWIJ1hpHPQNBFLvAN8ehi0mG7SHLVb0I5H4UIUgKv2FPH+63BJ/72Bwe
         +aog==
X-Gm-Message-State: AOJu0YwRhXpWPfzuHbR7328X4deMOo/mLLLY16cRAJEqlYaeijtw+Wso
	NvocN/9T5i1hqkaCSQGkgx2DMWJL6fnqF0fLea5wnanoNrEGe9z/n3JlK4rqEA==
X-Gm-Gg: ASbGncvmXHh/88PrEkRcHCXKlFJ0+CfdqsTVFoAmdZDgApk+RoVLLr4ASE2xkdlzrs7
	NdV/UW08/oZ4L6PiTuPPrghqXoOBnW77m2wrMC/0D1OHfwnj9Res5bYtS2H/u0JXHYB3KSQNPIj
	NdPMY0yZ2owRBaDYJWHnq/CaepXf7JejbT+q5W36crfMQAu7QiH7l8+CV6ENj/GqoxLCSNa5YRO
	Ncc8mIZ5ICx78YhghYKiMDYz1bSRUFOyUZqV574oMI2cNYV7RuxPb1kLo66SFMCj3xtPaFvvUD4
	2o00TBj9kQ7oMaKonIoz+dls+ZoSYSXx8EoaXQ1QbiI4KKDXzFf+IY+7QgZPbStmBWKElcL2luv
	Gz9TfMmVLDIbFTMU0d6yTKmQE1aO5T8ccyAjP+p/Kfn8=
X-Google-Smtp-Source: AGHT+IGvw3ZlD/y1FEoO0jD35tgg/JIgUW57AZYdbxSMqDKqudeWUNBDQL8ueY2TnDdsn+Uslv4vcg==
X-Received: by 2002:ac8:5dc7:0:b0:4b1:22e6:4fbd with SMTP id d75a77b69052e-4b2aaa6e4f9mr59506281cf.27.1755892296263;
        Fri, 22 Aug 2025 12:51:36 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e45c4asm4913221cf.46.2025.08.22.12.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:51:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>,
	Michael Johnson <mjohnson459@gmail.com>
Subject: [PATCH 11/15] handshake: use vendor quirk to disable check of replay counters
Date: Fri, 22 Aug 2025 12:51:14 -0700
Message-Id: <20250822195118.271122-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822195118.271122-1-prestwoj@gmail.com>
References: <20250822195118.271122-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This has been a long standing issue on Aruba APs where the scan
IEs differ from the IEs received during FT. For compatibility we
have been carrying a patch to disable the replay counter check but
this isn't something that was ever acceptable for upstream. Now
with the addition of vendor quirks this check can be disabled only
for the OUI of Aruba APs.

Reported-by: Michael Johnson <mjohnson459@gmail.com>
Co-authored-by: Michael Johnson <<mjohnson459@gmail.com>
---
 src/handshake.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/handshake.c b/src/handshake.c
index 02f0e436..6db897bf 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -44,6 +44,7 @@
 #include "src/erp.h"
 #include "src/band.h"
 #include "src/pmksa.h"
+#include "src/vendor_quirks.h"
 
 static inline unsigned int n_ecc_groups(void)
 {
@@ -914,11 +915,15 @@ bool handshake_util_ap_ie_matches(struct handshake_state *s,
 	if (msg_info->no_pairwise != scan_info.no_pairwise)
 		return false;
 
-	if (msg_info->ptksa_replay_counter != scan_info.ptksa_replay_counter)
-		return false;
+	if (!(s->vendor_quirks & VENDOR_QUIRK_REPLAY_COUNTER_MISMATCH)) {
+		if (msg_info->ptksa_replay_counter !=
+					scan_info.ptksa_replay_counter)
+			return false;
 
-	if (msg_info->gtksa_replay_counter != scan_info.gtksa_replay_counter)
-		return false;
+		if (msg_info->gtksa_replay_counter !=
+					scan_info.gtksa_replay_counter)
+			return false;
+	}
 
 	if (msg_info->mfpr != scan_info.mfpr)
 		return false;
-- 
2.34.1

