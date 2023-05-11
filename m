Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC39363
	for <iwd@lists.linux.dev>; Thu, 11 May 2023 18:52:55 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-61b72fd8cc0so42288116d6.3
        for <iwd@lists.linux.dev>; Thu, 11 May 2023 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683831175; x=1686423175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rnhgRBE5xJVkIA66kNsmeXUPbGsBqmnfqD644fIaZT4=;
        b=idAu+H8iUBzRLp5tI0R/2yyAo9CzfMUBvkdxTKuyajyckZLlGC91KWOjBFcBRZArmx
         utd41BqxTz8dgcVF8+m1aAH1KK5YjlRjdMilfbJeb/mhGJwP5smNqm+5J6krG7suwk66
         AP178IKhUGAPXvDvuiuyzSGxGYoWscGTsFoP/SCp6lmEaln4QS3clvuzeIQ8pqzpsH5x
         gIgrFWX0WJy0i9g5iURqR6vkexiAhN2uv3RVGkljoDvrDcqDPFfrspuhspQr/wKVjpO8
         +VuZRToRcx4SbbieQXprD8aZTwApVqZZwmeP5PUXz5V45Q+v14qKezhcrIJjtR1QG3eI
         76CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683831175; x=1686423175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnhgRBE5xJVkIA66kNsmeXUPbGsBqmnfqD644fIaZT4=;
        b=FweYKMGFCVPVC7WY8ALiajNpaohylZ9Nbe8VnNkfU8r/vaKUr4Ep6YQrHeNp4NUekJ
         kyGCVUiJx8BsSJIlUJDhrq/J8Hrl8a6j7A8wGG8mORVz8fQMTvC7s8oaB8ydw/ZUrWuO
         1W7+KlRWtKZX3I0Puo/xz/CrP3Is2tCXRgsw2IXJuhqAjTtLGLURrq5SsvIiQzSfC3P1
         T0duMY4eERru7bFPGaJ24QOrTu0blOIDZQRA/glV5/mxF44t45SzgfunjJYqB3W7G/nU
         TB3Ztz3+svRWxhii4Fy5/5UAfKNpr+to/0OpQ7sZ8VnKkUneM/jPOP+nEynnsZXM5qUW
         9JUA==
X-Gm-Message-State: AC+VfDyQnYkJAaKOILx6Yak31PgzAyXNLAIRlpZKAP1hawXF+iDu8BP8
	P1+3G5dxQqZuNeA0MxGt893/e1tD328=
X-Google-Smtp-Source: ACHHUZ5Dderd/vMB6nhbO1chzmfmh39ibgk57Jp9tBpjIO5eaeLfIqUNpkV0YuYkqzDVUp82gFrTGQ==
X-Received: by 2002:a05:6214:21aa:b0:600:5dbc:c31a with SMTP id t10-20020a05621421aa00b006005dbcc31amr32909610qvc.7.1683831174719;
        Thu, 11 May 2023 11:52:54 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c16-20020a0ca9d0000000b005ef6b124d39sm2484017qvb.5.2023.05.11.11.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:52:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] wiphy: make wiphy work queue reentrant
Date: Thu, 11 May 2023 11:52:49 -0700
Message-Id: <20230511185251.79563-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some situations its convenient for the same work item to be
inserted (rescheduled) while its in progress. FT for example does
this now if a roam fails. The same ft_work item gets re-inserted
which, currently, is not safe to do since the item is modified
and removed once completed.

Currently FT reschedules the same work item in the 'do_work'
callback but this patch actually allows for rescheduling as long
as the item is currently running, even if do_work has returned and
waiting for wiphy_radio_work_done.

A few new flags were added to the radio work item. One which is
set when the item is running which prevents other items from being
inserted ahead (previously done with priority=INT_MIN). This is
needed since we cannot modify the priority anymore in case the item
is being rescheduled.

The another flag is set when the item was rescheduled. Once the
item is finished the 'rescheduled' flag is checked and the item
will be removed and re-inserted into the queue if needed.
---
 src/wiphy.c | 69 ++++++++++++++++++++++++++++++++++++++++++-----------
 src/wiphy.h |  2 ++
 2 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 2db2d2cd..e6ca3b76 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -2570,6 +2570,17 @@ static void wiphy_reg_notify(struct l_genl_msg *msg, void *user_data)
 	wiphy_dump_after_regdom(wiphy);
 }
 
+static int insert_by_priority(const void *a, const void *b, void *user_data)
+{
+	const struct wiphy_radio_work_item *new = a;
+	const struct wiphy_radio_work_item *work = b;
+
+	if (work->running || work->priority <= new->priority)
+		return 1;
+
+	return -1;
+}
+
 static void wiphy_radio_work_next(struct wiphy *wiphy)
 {
 	struct wiphy_radio_work_item *work;
@@ -2583,7 +2594,7 @@ static void wiphy_radio_work_next(struct wiphy *wiphy)
 	 * Ensures no other work item will get inserted before this one while
 	 * the work is being done.
 	 */
-	work->priority = INT_MIN;
+	work->running = true;
 
 	l_debug("Starting work item %u", work->id);
 
@@ -2592,7 +2603,12 @@ static void wiphy_radio_work_next(struct wiphy *wiphy)
 	wiphy->work_in_callback = false;
 
 	if (done) {
-		work->id = 0;
+		bool rescheduled = work->rescheduled;
+
+		work->running = false;
+
+		if (!rescheduled)
+			work->id = 0;
 
 		l_queue_remove(wiphy->work, work);
 
@@ -2600,26 +2616,49 @@ static void wiphy_radio_work_next(struct wiphy *wiphy)
 		destroy_work(work);
 		wiphy->work_in_callback = false;
 
+		/*
+		 * If the item was rescheduled inside do_work() we can safely
+		 * insert it here, otherwise destroy_work() could have freed it.
+		 * The item could have been re-inserted inside destroy_work()
+		 * but this is safe since the item was removed from the queue.
+		 */
+		if (rescheduled) {
+			work->rescheduled = false;
+			l_queue_insert(wiphy->work, work,
+					insert_by_priority, NULL);
+		}
+
 		wiphy_radio_work_next(wiphy);
 	}
 }
 
-static int insert_by_priority(const void *a, const void *b, void *user_data)
-{
-	const struct wiphy_radio_work_item *new = a;
-	const struct wiphy_radio_work_item *work = b;
-
-	if (work->priority <= new->priority)
-		return 1;
-
-	return -1;
-}
-
 uint32_t wiphy_radio_work_insert(struct wiphy *wiphy,
 				struct wiphy_radio_work_item *item,
 				int priority,
 				const struct wiphy_radio_work_item_ops *ops)
 {
+	/*
+	 * Handling the case of re-inserting the same work item that is in
+	 * progress. A non-started work item should never be re-inserted
+	 * into the queue. Keep the same ID, priority, and ops. If these somehow
+	 * are different the caller should really be using a separate work item.
+	 * Once the item is finished it will be removed and re-inserted based
+	 * on the rescheduled flag.
+	 */
+	if (item == l_queue_peek_head(wiphy->work)) {
+		/*
+		 * Shouldn't cause problems, but at least warn the caller they
+		 * should really be using a separate item
+		 */
+		L_WARN_ON(item->rescheduled || item->priority != priority ||
+				ops != item->ops);
+
+		item->rescheduled = true;
+		l_debug("Rescheduled work item %u", item->id);
+
+		return item->id;
+	}
+
 	item->priority = priority;
 	item->ops = ops;
 	item->id = ++work_ids;
@@ -2656,6 +2695,7 @@ void wiphy_radio_work_done(struct wiphy *wiphy, uint32_t id)
 	if (item->id == id) {
 		next = true;
 		l_queue_pop_head(wiphy->work);
+		item->running = false;
 	} else
 		item = l_queue_remove_if(wiphy->work, match_id,
 						L_UINT_TO_PTR(id));
@@ -2664,7 +2704,8 @@ void wiphy_radio_work_done(struct wiphy *wiphy, uint32_t id)
 
 	l_debug("Work item %u done", id);
 
-	item->id = 0;
+	if (!item->rescheduled)
+		item->id = 0;
 
 	wiphy->work_in_callback = true;
 	destroy_work(item);
diff --git a/src/wiphy.h b/src/wiphy.h
index d5d1cc8f..b6861f5f 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -45,6 +45,8 @@ struct wiphy_radio_work_item {
 	uint32_t id;
 	int priority;
 	const struct wiphy_radio_work_item_ops *ops;
+	bool rescheduled : 1;
+	bool running : 1;
 };
 
 enum {
-- 
2.25.1

