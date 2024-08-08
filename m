Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CA1190072
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138965; cv=none; b=aw21oqHwVfvMCs7gNJSJr+E4gvDJif+FNHHfeeiHZvbM2H5ROgJzDKbyFD2kW0Ma6YOZxnh3APXQLE0YriuMYd6nucmoZKJ0qCVIagUoU2fgRZFE69JechrccMNHxIE4Zi2kelKFoybgnQMPNScoDyeh0BrsZwNX60Pd2IZUVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138965; c=relaxed/simple;
	bh=R4aAhncRrSkyQxsQU2XAHhX+tZrBlWjUxlrvPLYVHLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gBmubWeHpUgRJvh7L29LPeMHRjYB3PSa54tTpTL3s1YFfGP+kmNYPE6zIW72qc/4h2yXXwFy48PNJPB93xC1zXnjMC//Wjk1dqNrccT1kdcYeMf2YLrx75JzfEdxFIksih/zV0GmBN7Dfx8MDWJjCBkCOaUMR5QeV0SuKzCbf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ozp496SX; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ozp496SX"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so926051a12.1
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723138963; x=1723743763; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJyEjmxTPA1YiN3VAH9YSjeEhOFyYL1J/hgxQhYQn7k=;
        b=Ozp496SXTIIkFvLwY4UtsLYQS5IyomBb4mVpNDMSqSss5zy2i9xiNUbDdpvOYUXw0z
         7ydkdAwlRIzjloiZNUyVFikfgBZjh2GxkNyE25mYLe+OnUFjaaNTxsimTomsrMZDIwv0
         6t9sog30l1eBXZQGTbsZvXEJTi9xUfZX7O5yALbnngCnPztDVqloC3qaVi/0mBxfY8VA
         8kQ50GLaFIwH3PmDhOHJvmT5jExMSNN4wYE6kF6mT+rovpSIUkaVzzAlB47vfGeSze4b
         dKLY1gweJYCZxRprQXAFLo3uWiO0SXzmMi0P+t/J9UdHNr6OROsZLZqjDokHmt0LM6Ja
         0ovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138963; x=1723743763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJyEjmxTPA1YiN3VAH9YSjeEhOFyYL1J/hgxQhYQn7k=;
        b=Y+T3SQ7KCjEliusSwtKz77e/hjEjhPyiezqSu1LqrPujkXaVSdz8tX2VRK7XnNAmoO
         GI9pvxgXrxoCo3vIstwrtQtRu4nXz1KL5OYMd7hUSh0O8/tIU+cES5Fk8t1jb4DgEzIg
         hWhqjgdwZ7/yqf0MfJ/QuuT6ILh16tFH7ZUrcbmF2NAOtMatt7AaAaNcdyjhnU7PqvT+
         Gz0+1Dym6cdrTvUAxhZnPmp0X7IE8+7TX12yOPEJzWxa8ByyvYUcFth2/8xMnjN1eA/2
         dvq3UgWYs0quhtLPz+lpPQw+fAnKXGDldJSvx0EzKpcUk02wk7aXaZmFPv3s/ZEunkdX
         RCeA==
X-Gm-Message-State: AOJu0Yx+u3kbPXztvYHE+/X7qEUVC6gXm1HXnQ9BVsHrgMCR1ygT75oC
	9X5dPcOKyrtVs1pZ5EZs1LeTtgnfDbFxGflNi68w1fssXLBgrF5TNJQv/A==
X-Google-Smtp-Source: AGHT+IHjtOz/tewa/0UgyykCqFYmTqC2iwvCxOK4qqgebNpdFMtLmQwUf4zqJ6p1VyghfX6DUz7D8A==
X-Received: by 2002:a17:903:32ce:b0:1fd:a412:5e05 with SMTP id d9443c01a7336-200952cdeabmr30301645ad.52.1723138962700;
        Thu, 08 Aug 2024 10:42:42 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53435sm127478355ad.64.2024.08.08.10.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:42:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 05/13] network: remove network_bss_list_clear
Date: Thu,  8 Aug 2024 10:42:28 -0700
Message-Id: <20240808174236.218750-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808174236.218750-1-prestwoj@gmail.com>
References: <20240808174236.218750-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/network.c | 6 ------
 src/network.h | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/src/network.c b/src/network.c
index 35e7ba4a..eff4117a 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1276,12 +1276,6 @@ bool network_bss_list_isempty(struct network *network)
 	return l_queue_isempty(network->bss_list);
 }
 
-void network_bss_list_clear(struct network *network)
-{
-	l_queue_destroy(network->bss_list, NULL);
-	network->bss_list = l_queue_new();
-}
-
 struct scan_bss *network_bss_list_pop(struct network *network)
 {
 	struct scan_bss *bss = l_queue_pop_head(network->bss_list);
diff --git a/src/network.h b/src/network.h
index f27329a9..121404ef 100644
--- a/src/network.h
+++ b/src/network.h
@@ -74,7 +74,7 @@ bool network_bss_update(struct network *network, struct scan_bss *bss);
 const char *network_bss_get_path(const struct network *network,
 						const struct scan_bss *bss);
 bool network_bss_list_isempty(struct network *network);
-void network_bss_list_clear(struct network *network);
+
 struct scan_bss *network_bss_list_pop(struct network *network);
 struct scan_bss *network_bss_find_by_addr(struct network *network,
 							const uint8_t *addr);
-- 
2.34.1

