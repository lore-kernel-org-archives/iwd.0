Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE13717557C
	for <iwd@lists.linux.dev>; Wed, 29 May 2024 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717023168; cv=none; b=WW5ytMz9PChOOuW4XW0+H/asM0jRwSeRCUTMoa4mwhzftjn6mgtyTG9h+7dbqqE9BmsDrHqsFIKec4tlKzBLyNcuHHJxbztat8f76/qH/2JegjhEhuGxX6QECH7V7WjMNCYYhVa490w6K/6Vo43N6jzftPfJ9G5oMg3NJ43EOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717023168; c=relaxed/simple;
	bh=BGO/slGFZU8LLKE9Jdjy4k+/y7FnyrL1MwuewGLXn/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMzjMtDuaw8ZQ5sNVZMhq9Q1LPZL0G5QWEIeEZowtWJnQT8+v3QIyAlepU0j2Eo4NY6eXnLVM/bTjJyTTI7CQBb3CBSTSZteRLeBNYmA4OWswugmuqCYJs+wnaEsy08YtZsBpaljSVPqxtB5fofIjDQoALO9yswmzBd416Mte90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a10tDqK9; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a10tDqK9"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-24cbb884377so152276fac.0
        for <iwd@lists.linux.dev>; Wed, 29 May 2024 15:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717023166; x=1717627966; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GVsdVcxAYkSQ+ol8w/uzTnZWeEJbqsWwLXtC1fx4RQ8=;
        b=a10tDqK9E2VaraXhyfHAvnxmrHKpouNHTfOR71+wB+GTNXTi8ZVv5K9/cmC7kHWsuL
         jm8FXFEvaTxXiRkVIY96pIowmV1QfTQlELX/lbZofo0Vh+9or+7DrRh0lRm6qzLQaRYj
         jJhjV1pgD5o3R79Bi4AUwoyPvx2UCw5nG2attZcPwwmxUtKfD2fUgTM9FHpjFxBhVI5G
         1HdzEgHH6km3vg1bqZlzAatrFfx0+2faAqrH3gBwjKEK0ZBLJzkI2UIQrgxeW0+tL1YV
         8/1n9qjXIR3Rfi9rHc9bagFkq9PLOwCn9jS8mmnSKkg1toT6SX1DS5UwTk4ERbAreAnL
         lepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717023166; x=1717627966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVsdVcxAYkSQ+ol8w/uzTnZWeEJbqsWwLXtC1fx4RQ8=;
        b=SAezKPmKYg/Y/JSbuqroluuJwERPvFzsW7iYHn0QsB+OTDZt9Dh7NxHfQiQAZCbYek
         3J9j+P5WCkATCBmVZvKCSVAZjufIbYBY5bGTvrD73fBqm09EGj3owB12T8ZU01jpcA+z
         WRUrJo/y2VS44i7v1ACf3EYYLJ/jMJkxlT9XTZ1Zq4NCmOx4iL6DwT9i0pbTYy5Efc0S
         O4JnScb9TDmFCNIAOqgA6yc//ac4IO++siKiuSLusHemqpgT8IsrLrsBFk8O4n3mNBWY
         ACX8m0q5Iep8LYWRQS+UtMBaZFhFOE/NQMNeqS7WFrOPp2f9IkFPdJvS8FqKOvbupovI
         nKUQ==
X-Gm-Message-State: AOJu0YwkHPaAvjSBqBr/yys2ZUFkQkD8N1wPqMMmGohrqLvNAql9Ahnz
	Do+FPAKZPjo2MwPRIYkDW5aTEWR2VO44f/GDftb3lytTcNHPw9CbgjWJuA==
X-Google-Smtp-Source: AGHT+IFy+SjgGgQK8Ox1YYPiYNT0Jm8q0V7+dEq+KDnyhetNQn7pYen4bnIbgOtBNFvwZnwxH4DMmg==
X-Received: by 2002:a05:6870:ec89:b0:23c:34cb:294a with SMTP id 586e51a60fabf-25060e5aa8fmr667959fac.51.1717023165574;
        Wed, 29 May 2024 15:52:45 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-24ff6093ee7sm2033297fac.40.2024.05.29.15.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:52:45 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] watchlist: Remove unused APIs
Date: Wed, 29 May 2024 17:52:30 -0500
Message-ID: <20240529225243.261672-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

watchlist_new and watchlist_free were never used.  Get rid of them.
---
 src/watchlist.c | 17 -----------------
 src/watchlist.h |  2 --
 2 files changed, 19 deletions(-)

diff --git a/src/watchlist.c b/src/watchlist.c
index c73169bc446f..899b983e65fe 100644
--- a/src/watchlist.c
+++ b/src/watchlist.c
@@ -48,16 +48,6 @@ static void watchlist_item_free(struct watchlist *watchlist,
 		l_free(item);
 }
 
-struct watchlist *watchlist_new(const struct watchlist_ops *ops)
-{
-	struct watchlist *watchlist;
-
-	watchlist = l_new(struct watchlist, 1);
-	watchlist->items = l_queue_new();
-	watchlist->ops = ops;
-	return watchlist;
-}
-
 void watchlist_init(struct watchlist *watchlist,
 					const struct watchlist_ops *ops)
 {
@@ -137,13 +127,6 @@ void watchlist_destroy(struct watchlist *watchlist)
 	watchlist->items = NULL;
 }
 
-void watchlist_free(struct watchlist *watchlist)
-{
-	watchlist_clear(watchlist);
-	l_queue_destroy(watchlist->items, NULL);
-	l_free(watchlist);
-}
-
 void __watchlist_prune_stale(struct watchlist *watchlist)
 {
 	struct watchlist_item *item;
diff --git a/src/watchlist.h b/src/watchlist.h
index 7f5f557a2458..8ceedcefe64e 100644
--- a/src/watchlist.h
+++ b/src/watchlist.h
@@ -42,7 +42,6 @@ struct watchlist {
 	const struct watchlist_ops *ops;
 };
 
-struct watchlist *watchlist_new(const struct watchlist_ops *ops);
 void watchlist_init(struct watchlist *watchlist,
 					const struct watchlist_ops *ops);
 unsigned int watchlist_add(struct watchlist *watchlist, void *notify,
@@ -54,7 +53,6 @@ unsigned int watchlist_link(struct watchlist *watchlist,
 					watchlist_item_destroy_func_t destroy);
 bool watchlist_remove(struct watchlist *watchlist, unsigned int id);
 void watchlist_destroy(struct watchlist *watchlist);
-void watchlist_free(struct watchlist *watchlist);
 
 void __watchlist_prune_stale(struct watchlist *watchlist);
 
-- 
2.45.0

