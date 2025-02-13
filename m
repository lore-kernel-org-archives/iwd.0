Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD41724BBFF
	for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477906; cv=none; b=jmvoPJ7IOgGdkfPERxDgpE31/Hsa7bqEwxdkadUWtrSuqU7bF1up7NC65pzZ+zTH7CGjqUjcFwwT22r03zFnuSAdzGeLcNOUk56QHhwqXolwvut0Le36tQDfExq0zZaR9GuiVSF/6q6eIru9DVb8xP80LTPO9c9537hXOKPPmto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477906; c=relaxed/simple;
	bh=ykejZzXyXZzTxqDjHa5U7M2vXkmVWua+9D+cVByWsOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d58ZNNGeN8LqOEJmNWyccJ0p6Mqimjm1tiJnGn/w8InGKY+gwDTVxXc06j4K2xrz+nr9vctxXdiWiUm3woFO4jotMH+HE7Z0wckzycJ3GEjdCsAbqbjjrvCRSxUMlkOIxavqYvpiDfJQwKsU7NCa+932ZL29fZAa/AB2wLU70z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUTYsD5Z; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUTYsD5Z"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220c92c857aso20930985ad.0
        for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 12:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739477904; x=1740082704; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pCkHdx9LiuuyEfXsXgtMCMDq8bWGJ7vMMayCSWHOZo=;
        b=lUTYsD5Z9ycIoOAMBZiay3RPQO8GBODq/ZwsEFMF3AmTyGVtPT7A6UF5gxVgoqxLvQ
         JV45P6y/SWdShGaTYybh1mc/rAg1QqP4M/99TgmDnOieEbx7A/ZrCtG9Tn7xdNsfCUx4
         HwbtjibABlMLytEkeHuNxmY7L3RMBaQuSTB//FjBLHNJo5LgxdWpeLube5suBVFEFT7t
         eo3uUf7EZNBq3q8OWUCpNRMjPuXtiW6T2czz6iW2Hqv02o2E3YiFUgK/xDot3kPjb63m
         w8VyBh8waDJZaDl2+svPZr1Rk+F2/GFumPWhUFYJws9/XGH0FemUZ34B4dnc9AsWueMx
         +heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739477904; x=1740082704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pCkHdx9LiuuyEfXsXgtMCMDq8bWGJ7vMMayCSWHOZo=;
        b=rD8Cx20WgHz6ETVN/cx0niS9RALDwI+P35YYPa45wucEXDgbIXrp3V8COq0DQ/npk0
         mFiZanprlmtDU0Ujd4nRU/4BzHUAfW8HlYkMRi7F4X3ghCK0sGrmeuLDgqKTr/5QRkcs
         o9L7c4cu7h9ZGKcJUD0ar/UKkmYG4ajiO+RHWR6c0aTBIxvt3GKATO2jo+c5ul28woYX
         Ch4yaW+Txljq8hHzNDlteqZIDpdF+6iP7mfYOAKdP4wspm+4aJA1C9LAW219hRCpL7v5
         hhmSaY2ami8S8Ul5w4QxcsTRMPiVgVcGDZar+jDU8k6ou9MkB9+sCEKuZM2zEntZ1glq
         VMMQ==
X-Gm-Message-State: AOJu0Yx9KA5KcctLK/EvYxNVvbDNW5AOZmEnNrLUIsgXv9Q9AV1eUSFB
	EeL3AeFpXaEPhJ+44/ljCGfYx7hk9TcXeogfy+/XxeMup7WPjsbEXtHoJA==
X-Gm-Gg: ASbGncuNJ9o6tZeP3P7peXivy6JKvEEzK/0CBCA7Z9gJBh4xIhbMfAlNdu54mU/qkNp
	Vn/9aCRpCeDr9sIMB+Wt3Q7asfoqqQA7ZluOdq6fY0GUWP5ekg0Qn82nAkBLr5qHQXGNv++sFOz
	twtdYcYLdN12tYp5cH+CoZpiPkNQ1ZIxobSkVvfwL3LWHelSnN4qREjC6Ks95wB80AfuHYyeBaK
	p7W35QEth1UC8cs5CzCfNYjObDoVQW4Bb8Ix9ZvDFphlrDeiAqZYjN18+imK6j/8zBN4ULFoJ5Q
	GzNJ8hvF+yj82B/fbBZacPL7kQ==
X-Google-Smtp-Source: AGHT+IHsjl8uMk0C9lvqh7mCfrA/excGmmwbh0SrMKcpfjC5nJR26vmsJZlZKAnsup89jHCh8NwezQ==
X-Received: by 2002:a17:902:ef4c:b0:215:8847:4377 with SMTP id d9443c01a7336-220d37151e7mr62312595ad.15.1739477903782;
        Thu, 13 Feb 2025 12:18:23 -0800 (PST)
Received: from localhost.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c814sm16419455ad.148.2025.02.13.12.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:18:23 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/5] netdev: don't set CQM thresholds for fullmac cards
Date: Thu, 13 Feb 2025 12:18:12 -0800
Message-Id: <20250213201816.230112-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213201816.230112-1-prestwoj@gmail.com>
References: <20250213201816.230112-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since roaming is handled by the firmware setting CQM thresholds for
roaming is pointless.
---
 src/netdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index ecf61823..e0a39851 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3827,6 +3827,15 @@ static void netdev_cmd_set_cqm_cb(struct l_genl_msg *msg, void *user_data)
 static int netdev_cqm_rssi_update(struct netdev *netdev)
 {
 	struct l_genl_msg *msg;
+	struct netdev_handshake_state *nhs = l_container_of(netdev->handshake,
+				struct netdev_handshake_state, super);
+
+	/*
+	 * Fullmac cards handle roaming in firmware, there is no need to set
+	 * CQM thresholds
+	 */
+	if (nhs->type == CONNECTION_TYPE_FULLMAC)
+		return 0;
 
 	l_debug("");
 
-- 
2.34.1

