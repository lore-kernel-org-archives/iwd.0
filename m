Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE4B2E739A
	for <iwd@lists.linux.dev>; Thu, 16 Jul 2026 02:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784169386; cv=none; b=jExNhExV4eOx6vdWWFw+/jmAYFTPMptOCJSqno0kpOjtvRdQnPnkxYPyUFjuxxK38Ts9lJ+J/awrvSkbpF7S9AsoIqvaej342QGAAQNb4GDi1ZJWw6Glvtiklwf1mHVnI3ryvSD0Tmld3q6H++eBTK2wexR5N2Csy6j0vS8o8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784169386; c=relaxed/simple;
	bh=rEjGrjqjKfKvT0qh+WkosETg/1I//qN6ua/mjyFibhw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVs/vrlur1xJ34WXlLY9Oi2BlNpL8lBZIIwAY3OLDz+ekgOqr33psPOfLrPAJonTf8l64qJ8g+1n2jUCC0kbbHqbgvTnLweCAXhskY2E/B89dBBOHyd2dWfypKo/8/+2zidh48rhG6QSZ8CPF5R0YZSzEEdYytgBlFEMySnekYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OykRsO64; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OykRsO64"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-382ef647e20so5729233a91.1
        for <iwd@lists.linux.dev>; Wed, 15 Jul 2026 19:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784169384; x=1784774184; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=333KuQCJ9HyiqfbixGLZUQ6FukrmhkNYIUhy60dAABA=;
        b=OykRsO64blHNhZELaAGrEkSc3WRyBYvMD8by650trgwttw5AN78IX/4dvfQVRFmR2O
         OsFon5l7xDmjCRXaXK+KLF0UlBJRZWSnU0HHewR77lgmmhb0VR+RqjhwIprap7bkfQa8
         8nZPqd/Q98gE7aejZowlXwjT32hMAZnCgk8vFZnjZ8hpDA+IIW7EHKkjIzKYdDTmXczq
         /4TJG5Dl058BIl2Lq8BPhszQW3RkVpOtpFmm0HRbJmYm50LFqyFfUIQXy8EPgTZqczBK
         qgji8Zvg4Tnx4dBhbT0DfFYwVDGt7iZw+OpPX4glBri+Osp2iWZxz3gNYn7jDv6IRQe5
         bnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784169384; x=1784774184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=333KuQCJ9HyiqfbixGLZUQ6FukrmhkNYIUhy60dAABA=;
        b=nT5llEAhaJFhCSaZ0TNaiCVA/+Vlz/vPN1eVpGL+wUTtUzDQFVtQQkgI5siAr4LnlH
         ELKvc5X+1vWWZlCBAv4uERoYlRAIniYiv4HyMLVRO1l0d36XCnUigtlLoGIuJrCLRPVS
         1BQnWiLjA+DWIEG+c1F9f3BQiUXgyFyd5R8+GHfnFHjMkvZ3E0Wroo0QMG+Iy8CwOvLH
         yuA504C6MHOzhwItrGa9WUCjhp6qI3ki64JH0cikISShP1Pw+KTEhsnCEOEWm+XsIX2M
         rtyNkS4zkr7Evua0m/BKrsSGVE7zqTEGDNia0b+j+hi0E0K8y2qH0Uj5/4gs/scNsF9u
         9RMQ==
X-Gm-Message-State: AOJu0YxpfyRdNpg5YHIC/Ifq7gBpyX7dfeShq+pwcejVkYjQAFVsVUqi
	FX4LZ08vWbF3ca6Av+Y+ym8r7M5+T8ziIraIC3mkkfAub9d9zHt/cHwXuj6rWiQ=
X-Gm-Gg: AfdE7cmR/aQ4chHcBo+bs2aG47VWiD3LFFXv0/vk6cXIq+xbHeiADJD1Qw3EkaSVSzt
	BQVg10e5CTgHiwVUOhiJjf6sRMMhOygA30ubWFG+GIJTPrGRQkdqXPxpLoG08QjLc5clSj3O0+R
	nRISHrHrL1lQzbmoZWNOKTOsSYKSi4SZ7oPiYVg00XeIOstSDLuXwn24tN9qYr3QxAJ4PiZ9qac
	InlMn/YgqHowA0O1G2GChs0DsMyLzwR6d5vKC5Jt0DsooWN0lMFSnmlggpvl3Fw0WSoY1W2sZ0t
	JgMf5Q7hu8Bsk9hq5nTabxlDup8OpuXWau2jwzeScQNVn7slNaWRMEZhj5a0jaU6iHQeDWzrODB
	7ffE8Js41Y1s3BGubvH5Dk7tLT2fPKE9/9N0/IELdOhNzJPS1RSRagvGUDE6sCD+Xb20pVqdRq0
	4mG3MX5M4+lIRltGYf1l7MNYL6c1zeBQ3CIuToSg==
X-Received: by 2002:a17:90b:2fc4:b0:36a:8240:2477 with SMTP id 98e67ed59e1d1-38e29fb6132mr4702136a91.19.1784169384201;
        Wed, 15 Jul 2026 19:36:24 -0700 (PDT)
Received: from matic1.1020marsh.offices.matician.com ([2600:1700:471:807f:aff0:107f:e34:fd6e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e5306afsm6060595eec.9.2026.07.15.19.36.23
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 19:36:23 -0700 (PDT)
From: Suchir Kavi <suchirkavi@gmail.com>
To: iwd@lists.linux.dev
Subject: [PATCH 2/3] netdev: reject reassociation while connect pending
Date: Wed, 15 Jul 2026 19:34:43 -0700
Message-ID: <20260716023444.3512595-3-suchirkavi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716023444.3512595-1-suchirkavi@gmail.com>
References: <20260716023444.3512595-1-suchirkavi@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_reassociate() replaces netdev->handshake and unrefs the old
handshake without freeing netdev->ap or dequeuing a pending connection
work item. If a reassociation begins while an earlier attempt's radio
work is still queued (reachable since station_cannot_roam() does not
cover the connecting states), the stale auth proto keeps a raw pointer
to the freed handshake. On the PMKSA-cache path netdev_connect_common()
does not replace netdev->ap, and it re-inserts the already-queued
embedded work item; when the work finally runs,
netdev_begin_connection() starts the stale auth proto and sae_start()
dereferences the freed handshake:

  #0  sae_choose_next_group   <- reads handshake->ecc_sae_pts == NULL
  #1  sae_start
  #2  netdev_begin_connection
  #3  netdev_connection_work_ready
  #4  wiphy_radio_work_next
  #5  get_scan_done

Mirror netdev_connect(), which already refuses to start while
netdev->connect_cmd_id or netdev->work.id is set. Both are zero at any
legitimate roam start since netdev_connect_ok() completes the work item,
and the station roam paths handle a negative return by failing the roam
cleanly.

Assisted-by: Claude:claude-fable-5
---
 src/netdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index e639a1f8..dadd90da 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4394,6 +4394,9 @@ int netdev_reassociate(struct netdev *netdev, const struct scan_bss *target_bss,
 	struct handshake_state *old_hs;
 	struct eapol_sm *old_sm;
 
+	if (netdev->connect_cmd_id || netdev->work.id)
+		return -EBUSY;
+
 	old_sm = netdev->sm;
 	old_hs = netdev->handshake;
 
-- 
2.54.0

