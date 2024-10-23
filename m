Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD91D0946
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708163; cv=none; b=f2jUEaqc1vda4T8R2jfYsJFGvG+6UGA78PGcg3780PMLhjCIQ6r/4qUAJs5e4r7xq88FBJZRreyRqJgt8ltiXROyeXeNW5/AAzWXyi+wyPcZ5G17w1gkhte4WF29f6cEChmaiTv+qr88hEGhZiSG75rJ4sRfN1CnixWo3RWWtws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708163; c=relaxed/simple;
	bh=fy9saxEeOdAc2Inw7MDy0DT5tM/z2T3Vhe4JotQlYac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BfxEtoYHxGrKp6nFpSq9gU9oeKuySgDHct6hRPfo1F7RS9/VU9RbQCPtO7ebbC84kCC0dqLWeH/lw3+LEooPNM4rG6VNAIg8EZe+ee3xw/5aYpTRyWz37NhUsOYsd8azZe9Vvu9P1IhZGsv0WqDFh9CwLMCDurAIq3mS+oaqc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcQEVNBE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcQEVNBE"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e4e481692so96343b3a.1
        for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 11:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729708161; x=1730312961; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cleyCgLZFebwLrA8Z5Cn7hfeGHhF6AVUO0c6mbLoWI=;
        b=kcQEVNBE90o0CEETj292C1piNgkogdQBy+QlX8OAPzdn4NLvAt1OIC1ESCEuWglQc5
         HoNQTDjIm3i4pLC261L2McgO8tZQwovpMBtsPfNFski0FgX90EKLN2chKEmifon84rlM
         8Hmn22P4jA+xxYjM1RblkYZO/HRZqottY0++7Syi3EAQ4GIWWTYXO0ubRJ5OHTRbI8Qp
         x8FSNeVevdkY1EWk2Qp/aCHbC326MvXe32n07vhoJQKk6E1gkzis8BwePbHPthYsTYkf
         IgofmgxHt3KaZ86Y9MucmwVzJBfPTKKoe1hMKDbjf2Qg6f7rXUCJGWBMxJ3THgecpkI8
         vduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729708161; x=1730312961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cleyCgLZFebwLrA8Z5Cn7hfeGHhF6AVUO0c6mbLoWI=;
        b=I1d8YE5bColCtiYAsn5F0dxxoix1MSxPmcrlhGg8p37kb1nya/lL4uBSs1wUlCzmJL
         2v+IxVYh4tXt8rupZZgd4X93Xi/S+6hmissBZAIImQjVUBHuw5xamRTRGrONojLDUJJJ
         UOJtXPdgc1YgNbiCIT4SHWihuO0DkzGqx4r4Lok0mb5OBaSeYEioBQ0+Vf0nWulzZae5
         Yu4nroaKlIIkzw7ULbUZm2qGYnDq9OMeDSQBMRh5UFKqbIE50V+Kb5QHKS92j3/Q/yB/
         LKR7XyXiNgYQpoeiLobXfNss6nMq/efs2XWBM63j0v7o3/9YlNS6DH1l1P6MwKIh7SBT
         m2zg==
X-Gm-Message-State: AOJu0Yx7uFSoEewzivSyNRgeaPpe65FzK3Pvov0h7BiyDio+emeyRkK2
	QN8imLLeAIpfO06Qk9NaBCLU96/7LCSDZVzHIN63SSuKeY/U+SKi9tZAt6Id
X-Google-Smtp-Source: AGHT+IGntKMqC8HFW5ciB37GbJ/Xi0You4dPy3FOSk08ORFQVtaCFc52olL9m/jSeNipF2bdTPZryw==
X-Received: by 2002:a05:6a00:b89:b0:71e:452:13dc with SMTP id d2e1a72fcca58-72030bcce48mr4930516b3a.13.1729708160825;
        Wed, 23 Oct 2024 11:29:20 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabc11a7sm7024871a12.60.2024.10.23.11.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:29:20 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] network: don't allow connection to OWE AKM if disabled
Date: Wed, 23 Oct 2024 11:29:10 -0700
Message-Id: <20241023182912.128388-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023182912.128388-1-prestwoj@gmail.com>
References: <20241023182912.128388-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/network.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/network.c b/src/network.c
index 20d9a3dd..5a856fb4 100644
--- a/src/network.c
+++ b/src/network.c
@@ -911,6 +911,9 @@ int network_can_connect_bss(struct network *network, const struct scan_bss *bss)
 		return ret;
 	}
 
+	if (IE_AKM_IS_OWE(rsn.akm_suites) && wiphy_owe_disabled(wiphy))
+		return -EPERM;
+
 	if (!config || !config->have_transition_disable) {
 		if (band == BAND_FREQ_6_GHZ)
 			goto mfp_no_tkip;
-- 
2.34.1

