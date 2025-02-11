Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C287F2690EF
	for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302026; cv=none; b=RZONl593NRZmENWn92sHp1mT5ldBtIlVj1vw0ok/KTCEPF/NxI3XWZVGBxaeQ8VUamJnqsPID1RsmYAp77K5uqDrUh/k/ffxO4ZAjqtuWzCQOv0tc3WRSKHVdNUqq/bJrn68lnRa973jBcDMMC81jMDZ5NLblrDuxtnDq/DTlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302026; c=relaxed/simple;
	bh=tyVE9taFYqikiaPZ7fH2nz5+5vd7oB5zUaT5744pTvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jL9MYp5OnJdVj+lVhNQkzd2S/7qbPyl0sxmMC1Qzk2d7vxeGca5SYjm0v1YEv7j/Hw+dTbhjGWVAIVHzxhD+3b4akcNflR9/EecwJJSwjIz66XuC2S8L4PGHTYe0a7w98/KsiOb/+RhEyYwBTuRpLPhu3BPg75KZV7PzrRwU8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODJ/k4KK; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODJ/k4KK"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47196e33b43so21081381cf.1
        for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 11:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739302023; x=1739906823; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUaluhXfXv173xJ8vOsAbie1/7Iai/mBhv3CsyBmGzI=;
        b=ODJ/k4KKXKZk4Be2NWfj0SZwrO1+0U0z6HFh4JCtYRCdJUhM4OM0IDeiowGkZRepgW
         IpPl0daYXyKRiC8Ned5KuyQ+rPcMhFQlQD6nOqOuhJMtRTv5prtETNQDKeA3QU/S0bNq
         fdVvF6jpq/CIwcZcFqXMEwZGefRqfrWdWvdtRR3re6QQvTF5MH/nUZTmKhoIAy8cuuIJ
         ePV/W+mncAkSTOW0iKYtgR+2yuJVqQGOriP6Ldw7yINMuSSQ1z4zhDB5kAhaw1kVNx0T
         OTI0+jdBe3vypUvk9tbXtIDmiRfl5ZshiimHVlhk3mcE++y8MKXAV/9is4fdLSdgMkgg
         aK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739302023; x=1739906823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUaluhXfXv173xJ8vOsAbie1/7Iai/mBhv3CsyBmGzI=;
        b=kykFHbHUmbxngxSs60yl8YvfiM3tqZdOFCvpZmZQQrbBJmCCsRWQHuuFWJhdUzsU05
         XFh79qKrzqgb0vpEYM113+WXDHFzzhjyZNPcwtCJNnOb6iPjpfqbdqRU82gr90NDz2yC
         vZCTML4rLx/iwKq93QI2iIGavbZxJqJuPDGcO5AAvo9BXEYMN+CI7lbxAJbQvQiWkJxm
         UNJvkxkTsfI+ad8sg+iDkQKCpikIhyjGuLEQ8wF9kmTRcxlgeW7Ye3/f2RsbJwMM81q1
         Cy8kI8F7ix5Co1bCuXiATW9fSQvoXI/zPXWWU9MFctB9paRL2NAA+uNl4GLYNrDmzj+Q
         tLBg==
X-Gm-Message-State: AOJu0YzS7gFeLbhjYhEvmpUxvutexs3qc+2tRzL0EHPxDOGyoxspwnf7
	W+C4QMWhHZKb6Olro+m3sJMmcwgS4zo1j41ew1vUhqA0ZtqTO8Crw8a+8w==
X-Gm-Gg: ASbGncsbHF8Q/MaMr/+/Vee+wl9zqSWP+5gxWB7kJlfm6RrjQ1pmEKRNVY01enLEw2Y
	xKVLB13e+wvKTZ1wJBT/q0+hAPpeQlyBYOWkJRKiJ21NCwJbwBkd9Mek0AUCj3nyImBvAxDLdcV
	OyuuDWsmEmBNgSWTtWODpaR2iTgc7yXZpZsA4YVZ8SYe1fBKA98e5jKp1G+UmEgcZ5hFXoI193z
	u05Ys2DTG2jhhCUTuy+f7S6jvrErA2KSKa4BqdDL47plpQZNkM4nzPaozyNuc7P/EE+kN1QKlkn
	ZzvqJzcBVZV9BGEuty87/JB1J/lcP/14CEvkmH+NHJPvCLioyA==
X-Google-Smtp-Source: AGHT+IGzok8jSrmxXnhfBfp3jTHhmOx89bWZxE4oUloNquQYiwO+I4m7j3DSZnqPgx88z4o41sYMbA==
X-Received: by 2002:ac8:7f10:0:b0:471:9c86:2948 with SMTP id d75a77b69052e-471afecd206mr3358121cf.42.1739302023429;
        Tue, 11 Feb 2025 11:27:03 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4719dab7aadsm18681601cf.51.2025.02.11.11.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:27:03 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] netdev: fail the connection if sending external auth fails
Date: Tue, 11 Feb 2025 11:26:54 -0800
Message-Id: <20250211192656.83157-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211192656.83157-1-prestwoj@gmail.com>
References: <20250211192656.83157-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This prevents IWD from hanging after external auth fails. In addition
(as described in the comment) unless IWD actually issues a disconnect
the driver/kernel gets into a state where it no longer accepts any
commands, for example:

Received error during CMD_TRIGGER_SCAN: Resource temporarily unavailable (11)
---
 src/netdev.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 7af3c39a..611fb597 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3468,11 +3468,22 @@ static void netdev_external_auth_sae_tx_authenticate(const uint8_t *body,
 
 static void netdev_external_auth_cb(struct l_genl_msg *msg, void *user_data)
 {
+	struct netdev *netdev = user_data;
 	int error = l_genl_msg_get_error(msg);
 
-	if (error < 0)
+	if (error < 0) {
 		l_debug("Failed to send External Auth: %s(%d)",
 				strerror(-error), -error);
+
+		/*
+		 * Without an explicit disconnect here brcmfmac gets into a
+		 * broken state and returns "Resource temporarily unavailable
+		 * for any subsequent scans/commands
+		 */
+		netdev_disconnect_and_fail_connection(netdev,
+					NETDEV_RESULT_AUTHENTICATION_FAILED,
+					MMPDU_REASON_CODE_UNSPECIFIED);
+	}
 }
 
 static void netdev_send_external_auth(struct netdev *netdev,
-- 
2.34.1

