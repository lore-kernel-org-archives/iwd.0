Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B68123C9D
	for <iwd@lists.linux.dev>; Thu, 18 May 2023 16:50:08 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-3f684f20f77so11563741cf.2
        for <iwd@lists.linux.dev>; Thu, 18 May 2023 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684428607; x=1687020607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=136oyQ5+BI/4ee7CPLkprRBSjXplxunh2AE+r12f3/E=;
        b=jKqxDdmbZE+mWWdVqgqeyPlqACXlmOYcX4uptpG8FhQxgdYpbG3Ndke63jdgGrS+lO
         ifDlUaHNsuzWKLAWRgxul2Shm9MDzhppdpKgal9mru9I4oZm6G8aW46+1h5v7+cJYj3t
         WL8RwAQUzsPi++pkaDvLOLDzKKTK0b+4YUzLPh+jAzQbuOmgvYx6H8Z8dl1FxvJpvrsN
         vjkP3AeG1TuwSheBlyk4LdgGt34l9nZLeSowzA3WtvJNEbnc+R5csm6PIuUHdaEM5h4w
         mEpZ0oqjvMUOchNSQMxV60p40RaayftGv4j/LfuilFTB0K6zRPL+pQHBcSbdYMAg7VYQ
         YuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684428607; x=1687020607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=136oyQ5+BI/4ee7CPLkprRBSjXplxunh2AE+r12f3/E=;
        b=UK6dMDT+yIPojKefH/6X2hzeqBuDr0LTBQz/z+Ib62AV3/TInzpwHdExzd5vO2Oizs
         TEFnS/TLmgJ2zV36f0mrB/aagpTyRDfwTPCfjDLrpN5KzdZOfFSbO2IB3HP7/b+eaBZK
         HbKHamI0qbTfrxDei3Dh1E+vQo9k623O+yMxuoy4WZ5LGQfCYUC6bXbBj57AcUzJHTiq
         VuaCMHvyErbpUBUgu3bJn6Oufz9gmjbQ1jw4m8/Htchj9JdTK5WQUatTMBMS/ioYyOkn
         B8zcWQnmV0Yj0Xdx68/p0YjON+Ehb3u/MGvghLkCIfAiqcMdNcUDySrQl0ZwGs9Azf3x
         j5vw==
X-Gm-Message-State: AC+VfDwBMa6fl0HKqs/kq1AbqxcIFAUOwuobDSKJJmMRF4XFqH0ayNgM
	78PdcnQofRrXF1Dv65WGisoktG/HUU8=
X-Google-Smtp-Source: ACHHUZ7vsWAji6g2QQOOvLBtrYm1k6mPcWE2MWGfcFtKxWTxLxQzgP5MNKCg54vz6m2khIA3OT91wA==
X-Received: by 2002:ac8:5d91:0:b0:3f5:3678:f4d8 with SMTP id d17-20020ac85d91000000b003f53678f4d8mr342508qtx.56.1684428606977;
        Thu, 18 May 2023 09:50:06 -0700 (PDT)
Received: from LOCLAP699.cardinalhealth-columbus.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id cn13-20020a05622a248d00b003f3941ba4d9sm626112qtb.32.2023.05.18.09.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:50:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/4] wiphy: make wiphy work queue reentrant
Date: Thu, 18 May 2023 09:49:59 -0700
Message-Id: <20230518165000.275611-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518165000.275611-1-prestwoj@gmail.com>
References: <20230518165000.275611-1-prestwoj@gmail.com>
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

Fix this by introducing wiphy_radio_work_reschedule which is an
explicit API for re-inserting work items from within the do_work
callback.

The wiphy work logic was changed around slightly to remove the item
at the head of the queue prior to starting and note the ID going
into do_work. If do_work signaled done and ID changed we know it
was re-inserted and can skip the destroy logic and move onto the
next item. If the item is not done continue as normal but set the
priority to INT_MIN, as usual, to prevent other items from getting
to the head of the queue.
---
 src/wiphy.c | 45 +++++++++++++++++++++++++++++++++++++--------
 src/wiphy.h |  2 ++
 2 files changed, 39 insertions(+), 8 deletions(-)

v3:
 * Reworked the logic to simplify as well as added an explicit
   API for work rescheduling to make it clear to the caller.

diff --git a/src/wiphy.c b/src/wiphy.c
index 2db2d2cd..d06b2447 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -2574,16 +2574,13 @@ static void wiphy_radio_work_next(struct wiphy *wiphy)
 {
 	struct wiphy_radio_work_item *work;
 	bool done;
+	uint32_t id;
 
-	work = l_queue_peek_head(wiphy->work);
+	work = l_queue_pop_head(wiphy->work);
 	if (!work)
 		return;
 
-	/*
-	 * Ensures no other work item will get inserted before this one while
-	 * the work is being done.
-	 */
-	work->priority = INT_MIN;
+	id = work->id;
 
 	l_debug("Starting work item %u", work->id);
 
@@ -2592,15 +2589,25 @@ static void wiphy_radio_work_next(struct wiphy *wiphy)
 	wiphy->work_in_callback = false;
 
 	if (done) {
-		work->id = 0;
+		/* Item was rescheduled, don't destroy */
+		if (work->id != id)
+			goto next;
 
-		l_queue_remove(wiphy->work, work);
+		work->id = 0;
 
 		wiphy->work_in_callback = true;
 		destroy_work(work);
 		wiphy->work_in_callback = false;
 
+next:
 		wiphy_radio_work_next(wiphy);
+	} else {
+		/*
+		 * Ensures no other work item will get inserted before this one
+		 * while the work is being done.
+		 */
+		work->priority = INT_MIN;
+		l_queue_push_head(wiphy->work, work);
 	}
 }
 
@@ -2684,6 +2691,28 @@ int wiphy_radio_work_is_running(struct wiphy *wiphy, uint32_t id)
 	return item == l_queue_peek_head(wiphy->work) ? 1 : 0;
 }
 
+uint32_t wiphy_radio_work_reschedule(struct wiphy *wiphy,
+					struct wiphy_radio_work_item *item)
+{
+	/*
+	 * This should only be called from within the do_work callback, meaning
+	 * the item should not be in the queue. Any re-insertion on a running
+	 * item after do_work is not allowed.
+	 */
+	if (L_WARN_ON(wiphy_radio_work_is_running(wiphy, item->id) != -ENOENT))
+		return 0;
+
+	work_ids++;
+
+	l_debug("Rescheduling work item %u, new id %u", item->id, work_ids);
+
+	item->id = work_ids;
+
+	l_queue_insert(wiphy->work, item, insert_by_priority, NULL);
+
+	return item->id;
+}
+
 static int wiphy_init(void)
 {
 	struct l_genl *genl = iwd_get_genl();
diff --git a/src/wiphy.h b/src/wiphy.h
index d5d1cc8f..f4f205ad 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -168,3 +168,5 @@ uint32_t wiphy_radio_work_insert(struct wiphy *wiphy,
 				const struct wiphy_radio_work_item_ops *ops);
 void wiphy_radio_work_done(struct wiphy *wiphy, uint32_t id);
 int wiphy_radio_work_is_running(struct wiphy *wiphy, uint32_t id);
+uint32_t wiphy_radio_work_reschedule(struct wiphy *wiphy,
+					struct wiphy_radio_work_item *item);
-- 
2.25.1

