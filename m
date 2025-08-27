Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3779834A319
	for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299310; cv=none; b=o+D2QBgYSRRpF06R84FvOUX8tYnsoSE994QmqLgSAHCLnQ+K/bocwhYmL4V+ud5lQE1CHTNIiPgqiYXiwgxrThwSNaYRHkhgxMtZXFM1s/zRANZWMw/1uYpeeBWQ7oc99rWb1SbUOre83c9vo/AKOFzfy+FQVz7F6VQqCXltRF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299310; c=relaxed/simple;
	bh=DHMNbv9TEniVBPsMXlvG6SsflSF3zlpyFNArDRPfNdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JMvs82o7hilb4rrXRpMpiwrfvDZ3gXTnR9AMP/XzN/LmXPQ8sTsTZ79gnbOAWrM1Mpo7uzjSh5yEGrITQ/eWbaC6RTIzDEJovbaxPioj5hJPCJ0vbdLfquiQ5VO64uWcyCtQmyrcOix/jeu9j6CuSfopJn+lanY3eVDBSsMTZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHVT8ATR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHVT8ATR"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4bafe2e538so3277244a12.3
        for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 05:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756299308; x=1756904108; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iftW+b/vG27GJc1dVPWzdfQ2zFdfUpKvX2Of2W/61eY=;
        b=SHVT8ATRt82bt/2kmatVvrYk4fYzGP0mLRPUkIFNT40Cq4heCP153SNzTp2arJTp7Y
         w59vfIUZ1Pwbjg0JVEleNuecT6R5FNeuxTFkUK7CxaVhK5IIYY6frGNrdZKV93q2MKn/
         9OnUQWvWtK+qgs9YCM0LkMdgmz7EkB/CRTpGQJjJbcDOzBG0RfDwUq+aeqleqN2rRRQh
         YjiZd3Ayubmz9PrUDvh5lVtOgp4UCC8TKu+zfUT9kQEqNvMG/9CfQEI0i+sq0zR8QNa7
         PXG0VxDzn66cNWKnpBWL85GFKuCVvWV6kTM0Oug+kLJOvuHQSMSYAQsbiNyJtgZDUSMk
         ARvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299308; x=1756904108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iftW+b/vG27GJc1dVPWzdfQ2zFdfUpKvX2Of2W/61eY=;
        b=h/+o8CokQeVG3uHz6g6s3aeGaisx8ZAhHmMLmznxz59Di/zrCMwW7BI1iKM3OdI51q
         RHGwmVyq2RIWAd9GZVggi+ordU2VNeWKP9fu3GHk5XJnGJz8FoFZBY5NIqFP2UqrV8vx
         inyBe9Qn2hJBPrLazHZRmVaoI0yY7umk1+2e3kxtv2TTQSIh8qPTor/MrDdiMOYtnJdm
         KNlcw2X7vrFoUncSBECiZLRtY5RD4PV8Zh3fCKe34IJUqk7Jb9jSmE6xariwT23vkxsO
         N4mUfmPTndzeJjgkZLk+Y+I7/0TigVCXVsHAO12H492bvRChEOXoVwOTNl+mg4t/ZapT
         9q4Q==
X-Gm-Message-State: AOJu0Yx5ZT3jtcy34Kw3eu/yoDv4HsLGTXB/8eriT9SKsRKqjB/9vWRb
	N2Sp8Db5Alw6XUJWgMSKzXnPo82YGYgjQnk9/13Fa034zfXRbb/twvUxuLuJMA==
X-Gm-Gg: ASbGncv++T/Rg+f7kYtklu4QyU5Vari7IpJZavl4w5vOuD0NBbVReltUDFhD1PIw3fv
	bF6xwEqYQjaOXd4i0K+ejNfKQy0VLmUUc/SLiZV0PQqp/xmhhxQft2DnwMRqdFbi42sQkfGtOc8
	2e9qrcXdRo6FudxcYGLPpkyEwkF9/tMz30sz6Y8RVewAc+jLVwAfyZxriYwPrCoGsCknHIMt5FG
	nTDSYnjxOv3vWNKMlrmS8sWhUWAF5N27hWPu5zQy8KWAAleMe5eM4/nuGkiSDInLgmo0wsG/GeQ
	WhVW0lfpwY4LkHiTBXzfIYHYtsuQMMTio/tRSzwRNSeoX+IMHZbYQp3bsD7eJFtjs0652WAwiuU
	gmHcOd4whAHXfs/7E9LSbdyZrMe1cb8TIk9WQmAU0ovmsaS/62zvHQSEqzDzj1POuowbRMsp6qm
	0ZXk2z6enF
X-Google-Smtp-Source: AGHT+IHuZwnbl/Qk6GyV6wEhnR4bMNNT/qT7u5wWUkzXAHYziZcCl3LMyUrwknuNRiJgSJQrjFq2bg==
X-Received: by 2002:a17:902:c94a:b0:246:ea62:4928 with SMTP id d9443c01a7336-246ea624faemr141297775ad.43.1756299308056;
        Wed, 27 Aug 2025 05:55:08 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687c75b5sm121650955ad.66.2025.08.27.05.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:55:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 05/11] scan: store vendor quirks in scan_bss
Date: Wed, 27 Aug 2025 05:54:55 -0700
Message-Id: <20250827125501.477908-5-prestwoj@gmail.com>
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

As each vendor IE is parsed lookup if there are any quirks associated
with it, and store these in a bit mask.
---
 src/scan.c | 6 ++++++
 src/scan.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index d9f27c83..46ea79ef 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -51,6 +51,7 @@
 #include "src/mpdu.h"
 #include "src/band.h"
 #include "src/scan.h"
+#include "src/vendor_quirks.h"
 
 /* User configurable options */
 static double RANK_2G_FACTOR;
@@ -1221,6 +1222,11 @@ static void scan_parse_vendor_specific(struct scan_bss *bss, const void *data,
 	uint16_t cost_flags;
 	bool dgaf_disable;
 
+	if (L_WARN_ON(len < 3))
+		return;
+
+	vendor_quirks_append_for_oui(data, &bss->vendor_quirks);
+
 	if (!bss->wpa && is_ie_wpa_ie(data, len)) {
 		bss->wpa = l_memdup(data - 2, len + 2);
 		return;
diff --git a/src/scan.h b/src/scan.h
index 4c1ebc21..ae6a3a79 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -21,6 +21,7 @@
  */
 
 #include "src/defs.h"
+#include "src/vendor_quirks.h"
 
 struct scan_freq_set;
 struct ie_rsn_info;
@@ -79,6 +80,7 @@ struct scan_bss {
 	uint8_t *wfd;		/* Concatenated WFD IEs */
 	ssize_t wfd_size;	/* Size of Concatenated WFD IEs */
 	int8_t snr;
+	struct vendor_quirk vendor_quirks;
 	bool mde_present : 1;
 	bool cc_present : 1;
 	bool cap_rm_neighbor_report : 1;
-- 
2.34.1

