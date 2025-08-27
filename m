Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A676302742
	for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299307; cv=none; b=qNuDsM62c7pY2Rvv3S9COS+cPFsH5cZ9hM3hB+IJj7VaK63IWDYCPxyVklSDcy6gFkOVrjeLCjVpffOOF5M1LWJ3vUp5ZkDvKFa+yXsBVZC8xt/BBtAEtKjqNZhtff1BwYjOAkv67RW6b4qxRGCOhk8WLPPHtU5NDJiAAPM8YF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299307; c=relaxed/simple;
	bh=BmsT7V0ew5B8UoJSRSObISUk4Ywnmlr+UHQ9KbHVdWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lUdzEzNL+xiqSfAarYFLE2Z0ArbBhj/VnwoZNB1ycdrBjhd0KFwldpWG6/ZrTl6nOO7krJ2sDIK0zIScoTdgYs1dESKtEKUnNBgiaUuCmVYAZ6gQHP5Ta+trOY6iO+JfsuZitNU718fBSmKbe9hDUgESmgOH0kXjp3Nn1URe1aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1VD6l57; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1VD6l57"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445805aa2eso60264475ad.1
        for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 05:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756299305; x=1756904105; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jeosB8KZlXV9Gbemw2wCf0uZJ8psCnA3/pa1F/pGeU=;
        b=M1VD6l57F/Y+AXLH4/rm0fbr7OhjDwsrbdp4/zCOc2/B9nEiQOp2J4J43R/tVItXaR
         h+W3rKH0BvLj9TZX1Y8ZMTEU/YSjuO/cV75IpKg9QAkLTc1tKTBWhfuNuKTLhBxFh2Ou
         C+Us9+yRNecwbzHdzB1ulvm2f9pU6hCvdIZykzZ3DDlmHf48QAnJYDUAubW908eyV06t
         Gz6FiTCrTMnwJDna2jWNZe8QAGkzjTAEWzcCFXhqY7ZrpVOcrvGFWvb4/RvAEIyGnYT3
         ukwHdgzeQ8/oYl1P6bl2fA9fBDelL72hVe3fuFLDMrFolJUtK6Tdpbn7zWeBMci6T3SY
         7+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299305; x=1756904105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jeosB8KZlXV9Gbemw2wCf0uZJ8psCnA3/pa1F/pGeU=;
        b=DudtCvSed76Ed8kEmjSuj+sMalJXR0NNEUIj+np+lZ3uEmyvNDd/n0jw5GJmMWGZKR
         BrZZodwRxQakQqxxdB66bV8WeFDC81C9OzSRpskLpzySYJuq2TzY5g84K1fvQATBCD8K
         wZnXMSfYDw/PGBXQowxZoiC3hN7iFw6jCrp1RlPGpSLlHVNovIG6zjwgwAJYqWipgpmN
         MJ4fzS9MLE97jM25amcgDKKP7br5+TxUYfMYLMf7iglitMEBr7G5y8QutvY43D4Rxvnh
         GBYahEWar61NnfNPQBHEo4LZrmlbqU67Dlkltusw7gUFSvQPEAcBKvje/TkzpIyJu6Y7
         tGWg==
X-Gm-Message-State: AOJu0YyVb66o7PgSF4yuYGuUNtqTwUY6FU7ch/IjgSa0ZyRDeMjNnEtI
	9UO1Z2gM3jrRNeuX1/MG86fWi3bYqBF8QifFZb9izJJarDcQGW6iPA8gdj6DKA==
X-Gm-Gg: ASbGncuGaRTrRepKvfxfMOB+eDdI1j0XoBJ+L2SnGrv/M1k9eQ0zKVeNswdx34J/cSp
	ZwXJpM4btPeFY7iYTguMHbMPMFM4f7VhnLaKEJFewmM9wE88u8/BSevD8UhDqPNn2KuDoamJSmi
	TEuvoyovTi2GKjGtgY+VnGjFD4LNhpYLt3taoIl7L5KsMYA53e76qkxvu03d8FXLCscDH8E1nH5
	Uh4vI/NdvLJ2+BMdkwmCVX6r7uMNg5s/S3ksht9DVSxZQsNPv5RTld0mm8xTZmwfSQ925hllEG8
	sXCUcyKtxL99cbhIJbSubbUrWh9xMHBU+Ru4yatv02xihmXcRHIfwCAvJMKhXcojVsJx+RE6HTm
	YM1rsypOBnbFrDYD6zPSFRoiBuQs/chdLDpBnETd7hOI0fP9OV5sUT698q60QXpG+66L6l4N09T
	x00XIJRM+Q
X-Google-Smtp-Source: AGHT+IHMZP2YR38ge2bHTT3w16vh9JrXUSjPSD4CWgjTiwDQ7YHLkma3HI2uPt0Wo4fm3NLKApMKIQ==
X-Received: by 2002:a17:902:db0c:b0:240:887c:7b95 with SMTP id d9443c01a7336-2462edec14emr247383955ad.5.1756299304861;
        Wed, 27 Aug 2025 05:55:04 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687c75b5sm121650955ad.66.2025.08.27.05.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:55:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 02/11] vendor_quirks: implement two vendor quirks
Date: Wed, 27 Aug 2025 05:54:52 -0700
Message-Id: <20250827125501.477908-2-prestwoj@gmail.com>
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

ignore_bss_tm_candidates:
  When a BSS requests a station roam it can optionally include a
  list of BSS's that can be roamed to. IWD uses this list and only
  scans on those frequencies. In some cases though the AP's list
  contains very poor options and it would be better for IWD to
  request a full neighbor report.

replay_counter_mismatch:
  On some Aruba APs there is a mismatch in the replay counters
  between what is seen in scans versus authentications/associations.
  This difference is not allowed in the spec, therefore IWD will
  not connect. This quirk is intended to relax that check.
---
 src/vendor_quirks.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/src/vendor_quirks.c b/src/vendor_quirks.c
index 18a9ba7a..4fba0c33 100644
--- a/src/vendor_quirks.c
+++ b/src/vendor_quirks.c
@@ -25,6 +25,7 @@
 #endif
 
 #include <string.h>
+#include <stdio.h>
 
 #include <ell/ell.h>
 
@@ -34,7 +35,16 @@ static const struct {
 	uint8_t oui[3];
 	struct vendor_quirk quirks;
 } oui_quirk_db[] = {
-	{ }
+	{
+		/* Cisco Meraki */
+		{ 0x00, 0x18, 0x0a },
+		{ .ignore_bss_tm_candidates = true },
+	},
+	{
+		/* Hewlett Packard, owns Aruba */
+		{ 0x00, 0x0b, 0x86 },
+		{ .replay_counter_mismatch = true },
+	},
 };
 
 void vendor_quirks_append_for_oui(const uint8_t *oui,
@@ -58,8 +68,15 @@ void vendor_quirks_append_for_oui(const uint8_t *oui,
 const char *vendor_quirks_to_string(struct vendor_quirk quirks)
 {
 	static char out[1024];
+	char *pos = out;
 	size_t s = 0;
 
+	if (quirks.ignore_bss_tm_candidates)
+		s += snprintf(pos, sizeof(out) - s, "IgnoreBssTmCandidateList");
+
+	if (quirks.replay_counter_mismatch)
+		s += snprintf(pos, sizeof(out) - s, "ReplayCounterMismatch");
+
 	if (!s)
 		return NULL;
 
-- 
2.34.1

