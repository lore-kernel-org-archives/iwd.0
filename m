Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68052D61E
	for <iwd@lists.linux.dev>; Wed, 25 Oct 2023 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRCDbLwv"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7789a4c01easo4888385a.0
        for <iwd@lists.linux.dev>; Wed, 25 Oct 2023 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698256606; x=1698861406; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIaeV+8B5F+71OMiPNCeQF0VDI3OPzMEG45OQr+aXQ0=;
        b=gRCDbLwvjUOJPOKSJjbaEOY9/51iGXZrWXhTyjLoCqNdRlbtNhFIarKkAa7tUkACBb
         7uJuAJsGfT7+o+2KZ10fAS5Vm3MHwt5857Md7CMFxYdiX7r5t2RvGlxj3bgU0d1FwdNR
         uoJy2iejUTV146Sy00g3gmdpI6qEnFiUCOKjFU2eSkxbH+xOm4ROABbmXfllllAPBEe2
         w/bYnALBPRb/Fmqfz1PnDg+qzMWD6KdZzbm50GQcE2DL/HTu40donTa6yMsGHdUMYQlT
         mO2nwTTw4Eo+JOImBZx05e04pXAKhE5SRsziFc2xjZyB5v9VFAWHGAb6sKRuzjrbXjfh
         yBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698256606; x=1698861406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIaeV+8B5F+71OMiPNCeQF0VDI3OPzMEG45OQr+aXQ0=;
        b=r51CkMQaDMTwLXOoqLxo5/7HfTH0bDnyx4brhyv/5cwjYVsQAmLubsx8tHLOm6xspG
         raF9NmqrOZLCcm53JsFj512tndBz30jfvxwgCdBO49b1chguVsYdi+JPVi22p5iUWX56
         RgdEBAOLVNRK41X0cOMoNHLEt/zZouD3y8f1x3rrPItExSe1T5MzROVt/YmlJ62/TTOx
         +OQ2GYlm3/OO7S2OqsXZnPBeEA09dnZ3QK8hzeD6oQ80Ntwnqca84l12WuGjNPvPaV84
         vf1jLIvQWSdVmfrJSRsbTCILjx/mpsBCGc4SXw5J3AC4Eqvx8D3ONntOTdBl36VChl7L
         1/XQ==
X-Gm-Message-State: AOJu0YyHuuXmK+SEj9ZRDJLtqpFr2oz04YMXjnVj+AAJQ5rGYb+elaN8
	5FECycGXr46Sd4rp44tv9m9123oZItA=
X-Google-Smtp-Source: AGHT+IHMRzciFtA9a8Qh1KXaYsXT0ZGpTipzJO1n3H60IjYXcnNSnU+nxrUmq9zags2u8Pvj+SA9Sg==
X-Received: by 2002:a05:6214:d0e:b0:66d:f94:522d with SMTP id 14-20020a0562140d0e00b0066d0f94522dmr17775882qvh.47.1698256606446;
        Wed, 25 Oct 2023 10:56:46 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id e20-20020ad442b4000000b0063c71b62239sm4605185qvr.42.2023.10.25.10.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 10:56:46 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3] offchannel: handle out of order ACKs/events
Date: Wed, 25 Oct 2023 10:56:39 -0700
Message-Id: <20231025175639.262390-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its been seen (so far only in mac80211_hwsim + UML) where an
offchannel requests ACK comes after the ROC started event. This
causes the ROC started event to never call back to notify since
info->roc_cookie is unset and it appears to be coming from an
external process.

We can detect this situation in the ROC notify event by checking
if there is a pending ROC command and if info->roc_cookie does
not match. This can also be true for an external event so we just
set a new "early_cookie" member and return.

Then, when the ACK comes in for the ROC request, we can validate
if the prior event was associated with IWD or some external
process. If it was from IWD call the started callback, otherwise
the ROC notify event should come later and handled under the
normal logic where the cookies match.
---
 src/offchannel.c | 58 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 15 deletions(-)

v3:
 * Handle the various cases in a for loop rather than two separate
   lookups
 * Fix incorrect comment about the request not hitting the kernel
 * For the "normal" case I didn't bother checking
   info->roc_cmd_id == 0 as you suggested since this _should_ always
   be true if the cookies matched. Adding that check shouldn't cause
   any issues but it just looked wrong:

   if (i->roc_cookie == cookie && i->roc_cmd_id == 0) {
       info = i;
       break;
   }

   // It would _appear_  we could reach this point with the cookies
   // matching but have not found the info object (which is
   // impossible, I know). Its up to you and doesn't functionally
   // matter either way, but this makes more sense when visually
   // inspecting the code IMO.

diff --git a/src/offchannel.c b/src/offchannel.c
index 77d27636..77a0625f 100644
--- a/src/offchannel.c
+++ b/src/offchannel.c
@@ -43,6 +43,7 @@ struct offchannel_info {
 
 	uint32_t roc_cmd_id;
 	uint64_t roc_cookie;
+	uint64_t early_cookie;
 
 	offchannel_started_cb_t started;
 	offchannel_destroy_cb_t destroy;
@@ -57,14 +58,6 @@ struct offchannel_info {
 static struct l_genl_family *nl80211;
 static struct l_queue *offchannel_list;
 
-static bool match_wdev(const void *a, const void *user_data)
-{
-	const struct offchannel_info *info = a;
-	const uint64_t *wdev_id = user_data;
-
-	return info->wdev_id == *wdev_id;
-}
-
 static bool match_id(const void *a, const void *user_data)
 {
 	const struct offchannel_info *info = a;
@@ -106,9 +99,20 @@ static void offchannel_roc_cb(struct l_genl_msg *msg, void *user_data)
 		goto work_done;
 	}
 
-	/* This request was cancelled, and ROC needs to be cancelled */
+	/*
+	 * If the request was cancelled prior to kernel sending the ACK,
+	 * cancel now.
+	 *
+	 * If the ROC event came before the ACK, call back now since the
+	 * callback was skipped in the notify event. There is the potential that
+	 * an external process issued the ROC, but if the cookies don't match
+	 * here we can be sure it wasn't for us. In this case the notify event
+	 * will behave as normal and call started().
+	 */
 	if (info->needs_cancel)
 		offchannel_cancel_roc(info);
+	else if (info->early_cookie == info->roc_cookie && info->started)
+		info->started(info->user_data);
 
 	return;
 
@@ -254,7 +258,8 @@ work_done:
 
 static void offchannel_mlme_notify(struct l_genl_msg *msg, void *user_data)
 {
-	struct offchannel_info *info;
+	struct offchannel_info *info = NULL;
+	const struct l_queue_entry *e;
 	uint64_t wdev_id;
 	uint64_t cookie;
 	uint8_t cmd;
@@ -270,12 +275,35 @@ static void offchannel_mlme_notify(struct l_genl_msg *msg, void *user_data)
 					NL80211_ATTR_UNSPEC) < 0)
 		return;
 
-	info = l_queue_find(offchannel_list, match_wdev, &wdev_id);
-	if (!info)
-		return;
+	for (e = l_queue_get_entries(offchannel_list); e; e = e->next) {
+		struct offchannel_info *i = e->data;
 
-	/* ROC must have been started elsewhere, not by IWD */
-	if (info->roc_cookie != cookie)
+		if (i->wdev_id != wdev_id)
+			continue;
+
+		/* Normal case, kernel has ACK'ed */
+		if (i->roc_cookie == cookie) {
+			info = i;
+			break;
+		}
+
+		/*
+		 * If there is a pending request and no ACK yet this could be:
+		 *  - an early event coming prior to the ACK
+		 *  - an event coming from an external ROC request (we just
+		 *    happened to have also sent an ROC request).
+		 *
+		 * We can't tell where the event originated until we recieve our
+		 * ACK so set early_cookie to track it.
+		 */
+		if (i->roc_cmd_id != 0 && l_genl_family_request_sent(nl80211,
+							i->roc_cmd_id)) {
+			i->early_cookie = cookie;
+			return;
+		}
+	}
+
+	if (!info)
 		return;
 
 	switch (cmd) {
-- 
2.25.1

