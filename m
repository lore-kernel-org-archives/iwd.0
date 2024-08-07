Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD18286A
	for <iwd@lists.linux.dev>; Wed,  7 Aug 2024 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054477; cv=none; b=AoCXZKqx5ExN7QtAzWqu4nSx/xtB6V+SQ3e8zmZWqYVJa0AWZ6wFWpmPdp4fv0jOQ8upKZBygc9OqtfOK5prg43lyBVRiuujbXTyZE0/ia/wQm9PG4baAVvS40ORD2CxYvMmzHMQiXMYSGjo7I764R8V/djB9pTFcA8NHzw40/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054477; c=relaxed/simple;
	bh=FMJZ4MVV3MeRyAGLLPl3fbhEdU3KPFl4ckpiqCNdzjo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tlhkojgHHe7WnqBlkpepZT2x3NbBi0iVcInqbfJsSHb9qD3djvy/DmRQEr+tIhBtvHAE2F6TlyFvde2tlSmA6QPYcvJxyBwZaqrrT/uA6wY5C14pkeSg6tZIpyRhKOVYL0wCfO8qdFn0gnonO0S5kww70Jf8cZtDTNj8kP0ukwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPJdxoAf; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPJdxoAf"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1d6f4714bso11753385a.1
        for <iwd@lists.linux.dev>; Wed, 07 Aug 2024 11:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054474; x=1723659274; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5WfHtyfFvWdBzXQxfvCPRPK4dSsTpYb/cz+sdUWNRlM=;
        b=aPJdxoAf245YqMynXmdlSxxo2npYaP/3NDI9KKs89uRhaRDfn+f10jSZYNXM34V+5P
         c+Egm6GvpSU2O+2J4QIZlae40fQ08l8IckK3bQmziD2olkri9Q3c0ukLUf3JZkvdqxex
         xMD9KVcdX56qh8v2vsvs4nC6BZSloeyR8nnBPvqlpjkfDaBQ9n+dxvcOYH0kcVX+rrsD
         q3vWWs3Liz4KpbzEJhPottSL9f9VZ/MbRxQ1wcsrbg8fZ9BwBSPmLEGiR3+03EX8z1s9
         BNwOJ6exHORrxZ5HpUXh9wsuG+hNBfi8SzciKaQ0mwYhaJcVrfTb4SDd/bqaiyOtHiPw
         h19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054474; x=1723659274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WfHtyfFvWdBzXQxfvCPRPK4dSsTpYb/cz+sdUWNRlM=;
        b=Ykc4ZPKkmAi+XaNHwUWnQ27K/+lOtlFqH4t+UY3csXYk34rymPHzUgEZNpnGDYOu0C
         1FGdgd20GpMayNmyMyeOdtCpZrKshjVwVdxyEu9hu8d8BUGnFSRpmDIqrGJ5lWFNrTkx
         01eow/wreiHpkhnBarQ2fLq3q2s6yNukqHON/J5kdgylG+dtZ/n8s9kzrGunNIy1acTZ
         s9qJ+THdas/Pg3uegYOqVWkop19j7CgrmfPQpmJBhlqI9T9Dt90dpD67PxSkH+3+RQPO
         0uaR7GqrlAVEE2ocD8p9fDiuXebw/Qo1UwUqQgGRS5B655N89GwRgFrSIcREX5dad/w+
         HNJQ==
X-Gm-Message-State: AOJu0YyDi8zOH74ljZyMd0RgFC7Y8uA5HUl3B/hARE7Z5mujoHbNaB/F
	L07mxbb/Cx1zWns2gdRtpKQIZ3G2iZl+iAp22ksP6xjXUWsCohdiSSvFrg==
X-Google-Smtp-Source: AGHT+IEhIHTsRp0Q4R+o5ZhYAl0Fg3JQYEU6sJYJZlTSWc2RjTgptO2m9/iax4r48EDDMO0aI9egdQ==
X-Received: by 2002:a05:620a:410e:b0:79f:e0d:e052 with SMTP id af79cd13be357-7a377ba35b6mr627661385a.9.1723054474025;
        Wed, 07 Aug 2024 11:14:34 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0db4sm82194685a.7.2024.08.07.11.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:14:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/14] network: add network_bss_list_prune
Date: Wed,  7 Aug 2024 11:14:14 -0700
Message-Id: <20240807181427.170515-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a new API meant to replace network_bss_list_clear. Instead
of clearing the entirely network->bss_list on each scan we can
instead just prune out entries that didn't show up in the scan.
The network_bss_add API was also updated to prepare for
network_bss_list_prune by removing existing entries, as now even
"new" entries may exist in the list still and need to be removed.
---
 src/network.c | 43 ++++++++++++++++++++++++++++++++++++-------
 src/network.h |  2 ++
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/src/network.c b/src/network.c
index 09099fac..6d7e5ec4 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1129,8 +1129,17 @@ bool network_update_known_frequencies(struct network *network)
 	return true;
 }
 
+static bool match_addr(const void *a, const void *b)
+{
+	const struct scan_bss *bss = a;
+
+	return memcmp(bss->addr, b, 6) == 0;
+}
+
 bool network_bss_add(struct network *network, struct scan_bss *bss)
 {
+	l_queue_remove_if(network->bss_list, match_addr, bss->addr);
+
 	if (!l_queue_insert(network->bss_list, bss, scan_bss_rank_compare,
 									NULL))
 		return false;
@@ -1150,13 +1159,6 @@ bool network_bss_add(struct network *network, struct scan_bss *bss)
 	return true;
 }
 
-static bool match_addr(const void *a, const void *b)
-{
-	const struct scan_bss *bss = a;
-
-	return memcmp(bss->addr, b, 6) == 0;
-}
-
 /*
  * Replaces an old scan_bss (if exists) in the bss list with a new bss object.
  * Note this BSS is *not* freed and must be by the caller. scan_bss objects are
@@ -1188,6 +1190,33 @@ void network_bss_list_clear(struct network *network)
 	network->bss_list = l_queue_new();
 }
 
+struct network_prune_data {
+	struct network *network;
+	struct l_queue *new_list;
+};
+
+static bool scan_bss_prune_missing(void *a, void *user_data)
+{
+	struct scan_bss *bss = a;
+	struct network_prune_data *data = user_data;
+
+	if (!l_queue_find(data->new_list, match_addr, bss->addr))
+		return true;
+
+	return false;
+}
+
+void network_bss_list_prune(struct network *network, struct l_queue *new_list)
+{
+	struct network_prune_data data;
+
+	data.network = network;
+	data.new_list = new_list;
+
+	l_queue_foreach_remove(network->bss_list,
+				scan_bss_prune_missing, &data);
+}
+
 struct scan_bss *network_bss_list_pop(struct network *network)
 {
 	return l_queue_pop_head(network->bss_list);
diff --git a/src/network.h b/src/network.h
index 17dfcca8..be81c150 100644
--- a/src/network.h
+++ b/src/network.h
@@ -71,6 +71,8 @@ bool network_bss_add(struct network *network, struct scan_bss *bss);
 bool network_bss_update(struct network *network, struct scan_bss *bss);
 bool network_bss_list_isempty(struct network *network);
 void network_bss_list_clear(struct network *network);
+void network_bss_list_prune(struct network *network, struct l_queue *new_list);
+
 struct scan_bss *network_bss_list_pop(struct network *network);
 struct scan_bss *network_bss_find_by_addr(struct network *network,
 							const uint8_t *addr);
-- 
2.34.1

