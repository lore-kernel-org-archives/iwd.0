Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F323120695
	for <iwd@lists.linux.dev>; Thu, 11 May 2023 18:48:23 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6216a09ec38so3825986d6.3
        for <iwd@lists.linux.dev>; Thu, 11 May 2023 11:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683830903; x=1686422903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rnhgRBE5xJVkIA66kNsmeXUPbGsBqmnfqD644fIaZT4=;
        b=RnFbVrSs151yA5uWEoG+Z2F+dQpTy24TbxMwZoanxakZgbsThlMuuaRzkJT60GlL74
         XJtMkYNrg5UijonOkgEBhxWX4aWNEpSDFJmv4EB0uiwvccl1QrEtx5lkIvAFr/VRBQu3
         m1M5Lo3BHwmynDRDPk6yiAli7wDO1N0iv/IW6Ct5X94zGrcTVlbw32MjvwO3YkpRp9hL
         fMyr5qdf+9nBFl5dZ4t7zYJZUH2sU76CdhMo4R6AaqsNo91+ZYfNm/CGSne0sv5lLzEj
         jNCs8cAzPxmcrtVTCvx+jvJdHN0oQ2CR3XGrodnF9T1rrtV2WIy7kdQOJ7jc/9RKWyCv
         EaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683830903; x=1686422903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnhgRBE5xJVkIA66kNsmeXUPbGsBqmnfqD644fIaZT4=;
        b=T8DPiH4dA8z6F10JWYXxv0ntff36ZpVh9tCmeH6/Xwe0dAVpDvd8wexGFrqB1Hg5Vc
         bvjY41HIgZHl17ThvF7IGfX0BjgH1KigGBedUVpVnnh+J75WrljjFrNqRtVO77pizJ9J
         YEiTePMqcGc1PxOBKhZOx0P6M/7J8C+V4c36t/38nGdGrDn6XfMx6ZVKeC1V/sIXG/J1
         VUpm55WRfIpeioakrkHqkz+u8c39FC7slzg8nZtV317v64auxM85pmMEVDzeWt5xCFUP
         m3FFMsXetlXKKFMkUtgJSxEr4BE8AjYquKDNKmO0OjavPxRv6QXZ0N0ELR8DkafcfzRf
         8m9g==
X-Gm-Message-State: AC+VfDxJAUGEq43RqOn8k19sZElNPsy7l6xnhOpJ4Ywqk/OBPO1IKuEj
	zg90PJpzPhiEjQu6MCuJWS/x1adoctQ=
X-Google-Smtp-Source: ACHHUZ4JTi9lIz4k63wUZAdIJwOBK8oX91CkL05W+7LQhRcNrs/qYodoqjS9W7quhO6L2GXVDLa8LQ==
X-Received: by 2002:a05:6214:401c:b0:5f1:5ed3:dd82 with SMTP id kd28-20020a056214401c00b005f15ed3dd82mr30226480qvb.48.1683830902582;
        Thu, 11 May 2023 11:48:22 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id s17-20020a0cdc11000000b005ef42af7eb7sm2447221qvk.25.2023.05.11.11.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:48:22 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] wiphy: make wiphy work queue reentrant
Date: Thu, 11 May 2023 11:48:15 -0700
Message-Id: <20230511184817.79203-1-prestwoj@gmail.com>
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

