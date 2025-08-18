Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710823FC54
	for <iwd@lists.linux.dev>; Mon, 18 Aug 2025 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527485; cv=none; b=r2FZkJSaQeEituwG+glgPk91Sf4IvUc0RX2ijuWrQdhUze/cdqx9B88ErRUY/+r7jkuy4wbTB6nptNWKqDIbct51vZu6KOyGzUOkeLUHCkklr2rEhq0zJP0Wd/7nw3Dix0sXDI/SJuP8XpvK6uw4IdsaQmWikzDAcdSrIL9JT+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527485; c=relaxed/simple;
	bh=/6wP3ihWMuMPzzAhTk2pJzckLS+bjxnKqgscxfZWDX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ns0iuJ+1sS6WdeuAJOefRLB+JCvnuZ9HZDQhrU8QWXYSTrxtsgnHoisWhhoYL/ONqODqEz32/v6nluNCmSjW9r7dOgwBJjLo131p5aSTad+imIoQ0ypMI37Plx4Xlmb6W/YRjVxFAN+pPWqwYPrJMfey+uMm1IMFGmF2jyp1YnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgT6KBv2; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgT6KBv2"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b134f1c451so16941461cf.1
        for <iwd@lists.linux.dev>; Mon, 18 Aug 2025 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755527483; x=1756132283; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha+y6ZlFXVVPDK+CFCdyAFjVQHHk7LaZkerjVDrRvbc=;
        b=FgT6KBv2i02+nBeGgaU0dJCmOhJntVO7MXOlx18ZfOYNEMbiXoCoc/An9+3ajx3N8v
         fxzFZv7/xg/ul/tGZKP4Lf6CPRhAxnes29rBeKbhlMGjNyLnUeyTE1N03pPUUWkRBcgH
         toHq5W4nRDgQBy/yhlNcClECtHQ0nIoZp9OzY2Auy2HNHpt5ugWOpRLiBBbbAa+/t0pG
         +LK9B2D1RiEauDeHywtswCUxKtb+SEOuTM+WIp6LIHPCLMXhU0cLBjoLILyxCExv3Xfc
         FpsmxdZD1BiM+PQBFj4RtuvvTbTQJ+I2yV5eQMTKsgvkhXJL0Mw9ZEMDcwvrj0kSET+n
         7PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527483; x=1756132283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ha+y6ZlFXVVPDK+CFCdyAFjVQHHk7LaZkerjVDrRvbc=;
        b=r5kBHnfkB335tIvtN2/E2/5Oj58pYUnUZyHUZSTVT5VRD/xGaBPa/H7CZJTqtARmhM
         Yka+VL5khym0g3ozI19fC2QAYfm9a5y2z9MQrAT3RSxQDMQbKAI+wqKiSwryQGlJUsAr
         qeZ6iil9sCMPbeMiTRqsZLxjWQmodU20I2aBW4VfZCi7Ak1ew68+OuBFDOA5Hmbrb30E
         4vhQ2lt8hHZJ22QaGc+o3yKDZxrvv2vxs6yvSv1nlRj1/wX8NujIVWNFlBuOU7weH1Sq
         HzUcYpaUjcrmFlG7dvBkr40zQCrm72zGEBcAeHPVPuro17P4zHgOGKzlRVaDCuiI0T2o
         pcYw==
X-Gm-Message-State: AOJu0YwWFbHJOLIrajEZjHiFLQaUz3afgcgXLklNdm9VRtY+Plk8OiNX
	a2+ViNZF6IOlncjp5JVcDrSZZjWhllH7xSlssSdULzrUVRQy1lW+LmFiq/v0Qw==
X-Gm-Gg: ASbGncs0GnggqziXlnZUpsT99FPBg6ZpQqywvK8H0b3HiFiANqMQLjpGIHZ+7iyBu6R
	2q2FFUekoMYmT8xC4h5GjgRzKNDJYeK9OYasoONP1vaThuuQcu62sq4Z47gxFm5Dd6ynndAMpU8
	dv+1CR8RoqlE8nE12XcS5HF0EiKTqcwAtp/Q2KEZxDzhVAha1X8GObpGTCxXZKSS0cUZlxcZgSF
	0DjZsAajajo9gRJMHGeAgro6n0ZwEjogh1wKdDp3Jq3pv4EliHBpCeZ5y+1E4gDoHbEbBm7QUn/
	9bxBVAr5IW5L4o+oeZkPhH+G87mMJC1MMyAXPDT+Y9jnurU7wIvqcROL/jMF69vOR7Bpgkc9jfV
	H988+CVgllFqqKdkmZxjgAU8TvM2apDjP
X-Google-Smtp-Source: AGHT+IG35jKkU6fDUUfHX1lJOiwGcEwQokrRkkjsveJKIpefFu3dhj7/86LAfFn/HwHssEowPdjCag==
X-Received: by 2002:ac8:7d92:0:b0:4af:f25d:e2b0 with SMTP id d75a77b69052e-4b12a5cde92mr125437841cf.8.1755527445459;
        Mon, 18 Aug 2025 07:30:45 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc5aeaasm52781531cf.19.2025.08.18.07.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:30:44 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] netdev: check connected in channel switch event
Date: Mon, 18 Aug 2025 07:30:38 -0700
Message-Id: <20250818143041.283887-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In an ideal world userspace should never be getting a channel switch
event unless connected to an AP, but alas this has been seen at least
with ath10k hardware. This causes IWD to crash since the logic
assumes netdev->handshake is set.
---
 src/netdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 53a97cbd..ca8bfea0 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -5402,6 +5402,9 @@ static void netdev_channel_switch_event(struct l_genl_msg *msg,
 	if (netdev->type != NL80211_IFTYPE_STATION)
 		return;
 
+	if (L_WARN_ON(!netdev->connected))
+		return;
+
 	chandef = l_new(struct band_chandef, 1);
 
 	if (nl80211_parse_chandef(msg, chandef) < 0) {
-- 
2.34.1

