Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5285D1CE6F8
	for <iwd@lists.linux.dev>; Fri,  6 Sep 2024 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635130; cv=none; b=KZ1salowplY2Es/OLJ5BAqzmDwDRI49MWaGYCQP9qGxyLgBTMlo3rup08gCsUWh+j38msauDpTaEzcKHCm52GSYY0UV9vook+L93K9zkstjjTElsoFYqhdd3eEmMQw0pcZbh6qetEUoAgwBvF1uocgY4/TWg7W0bv8S6dAJdii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635130; c=relaxed/simple;
	bh=55ohkASihkijsWrXCx2KdcLU3d4k8UMuSurXSfi/jM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HxjVSkvkU+9QooZaxNIDzaqUwb2DYuS8MVgeFAvHOKTYCsXVM+xvx+qUrhgp7Y4mQC17XNv9x6WteGCztblh+cU/iZ3A8gdL4jOYY6jM87UIvBTVxPLCRglfzKWHey2qrdOLwtr0elS0674885V4Z7knTxhaR3V/oFZe1P9wwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ5KgP9Y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ5KgP9Y"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-717986530ddso1342615b3a.0
        for <iwd@lists.linux.dev>; Fri, 06 Sep 2024 08:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725635128; x=1726239928; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oGlMPmbprHVP8QjHzYesySMm+B1vSQ8B/naVafXT5kI=;
        b=gQ5KgP9YD9p1Z8v1kYpj844q24/W6eOcCMpXJR4SxANti0C0SWRyEWSGuPeQm8rS46
         JTHrYewcLVYmnPXihJFFuge8LdLeue0JHl+420ecFv37emeqWDG4cjdPtvLC8BUNrvPM
         LUMhOFnSLn0TImb8ntV576eNcp60vXi7sqswwu99yWcmr9Xhjyr2cDqTSJoP8821w7vj
         NpnhH83Buw7T8z8aqz7c3xOgx/j4Wk3YtVvPTXxlbo1ral/bVWYdl8MED/ikz6dFMzMT
         XQSHrwwcZW1r7FhLCCzmtHaQDm7mRT4kaHsNxtOL6c4IDvPE8sIl3Tzm2KdSbfX4uAXW
         nPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725635128; x=1726239928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGlMPmbprHVP8QjHzYesySMm+B1vSQ8B/naVafXT5kI=;
        b=i9dTzNocgnxnu7wgIL/Mz5T9322RS7oYO9WljWnyMGSrrMljyoUmkabtath2gtqRMN
         RiGNwBf+I+84iEOINfSs6oADMDsSqTqIqidTo0ejO88vVuD5js/p52IDYipINcZitYGp
         XniLh7kzmoDJPQfG5kwDTrTmuQZ9V4FxRb4/cRuBsJs3LlIJkFtSwtwhQBEEVo2KSwnZ
         ESSovQSpE0YkGK7z5gI1n7z0Ms7oSLE9rl7EFQJCQbfv4JV+6XEr4ERQh77eQbpGQziU
         LLokq4L3HFcHQGg5dJyofAjzfzGHUb1tKtwSLvjlZZQGw3v3M1dbLeMNNwpguGcaNkeo
         Q4TA==
X-Gm-Message-State: AOJu0Yz6HM/L1iA7NxR2ywKNhYbAlk6zC9HgFEOJxh3kAECE6Rvx6x10
	2xheVxUipiu3+U0B6RhB3O/fwAdjv8KCzqF+4x00k67iYtFPV8IMXnvC8g==
X-Google-Smtp-Source: AGHT+IEwm2luIlVED0wp3U6rDbUP+W4shty/DujCMJSGv+V2fO4gbvVas8YDbjpDWpSku8Hriy40tg==
X-Received: by 2002:a05:6a21:398:b0:1ce:d3fc:827d with SMTP id adf61e73a8af0-1ced3fc8862mr25350965637.53.1725635128112;
        Fri, 06 Sep 2024 08:05:28 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd91513sm5044914a12.44.2024.09.06.08.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:05:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] dpp: use peer_addr for pkex exchange request
Date: Fri,  6 Sep 2024 08:05:22 -0700
Message-Id: <20240906150522.586887-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was hard coded to broadcast and missed in the initial changes
to support starting PKEX to a specific peer.
---
 src/dpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dpp.c b/src/dpp.c
index 5d56456d..6f2d45c2 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1840,7 +1840,7 @@ static void dpp_send_pkex_exchange_request(struct dpp_sm *dpp)
 
 	l_put_le16(l_ecc_curve_get_ike_group(dpp->curve), &group);
 
-	iov[0].iov_len = dpp_build_header(own_mac, broadcast,
+	iov[0].iov_len = dpp_build_header(own_mac, dpp->peer_addr,
 				DPP_FRAME_PKEX_VERSION1_XCHG_REQUEST, hdr);
 	iov[0].iov_base = hdr;
 
-- 
2.34.1

