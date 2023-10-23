Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63223F50E
	for <iwd@lists.linux.dev>; Mon, 23 Oct 2023 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbZU1NKg"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5845213c583so816119eaf.0
        for <iwd@lists.linux.dev>; Mon, 23 Oct 2023 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698063660; x=1698668460; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5k3SttIBDvoAWL4N5Z2kdWWlArLtumXFVRt+HiDeg7k=;
        b=NbZU1NKg5j+QcGz4UGA2tHKuCopUahA0TjdgGfuJGcrHRqLd19cWbadzq1XD/H8O74
         F2zVdFqIUUTbpr8AXTfvcknmqV2a8pJaEROnr1YohLN9Td1yb598QDJ78THoSbBZrAzI
         6jy4k5WDAoRZy7U3VUqNgUOLackpaW2tRvwzZ0At3q5cBMx/st5i2Y00L3Y6vPrRPyk3
         6I3CywKLawvAL6PInwmgOFGjm3Kkp0SzdEeLW+GHNKzQ5ZreI8Vj7K4U/6TuMOor17lM
         VHRhU/eAIYEHBD+duXB+j5alUWrA1ZywQV7Qq5DbL2tUhijpDrlNVi/Gb/KjtqX5zZQf
         AG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698063660; x=1698668460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5k3SttIBDvoAWL4N5Z2kdWWlArLtumXFVRt+HiDeg7k=;
        b=hhdl8LWoxIJuY/TxACnxpnn3kubsyZ6KgCLAzAYtC5x+oyv78Vf+1J0m5EWiUtRiD6
         +XdJ4cOcye0FFbXGRBpThYTBuERvom8p2f35tzZ6anAcBJQnaArNDLepv73U9WrDand6
         yOHXr19fEWf9HAqhIsqyC+MqSSJEuquXOvoNAFySop2/zRbjQz+i/LIkp7lI3y8ib0a3
         +P/3tAPlTuUwJoUFS4rnCbYB+02dtsyTNCSfon6eRTuuJAy3GGgqTmQky01fjdXltmha
         VL7CiHS+zDMHwPpX0VG8bsusO8kCDSclFNlBxlby67WXgnp6sPLCcp+RLlXW6Ai/7J9D
         dlWw==
X-Gm-Message-State: AOJu0YzwfKqsGQTCT1vpimHwEaZifXJapniv+m6l0nX2Rj8rL9kdNP2T
	ZG8i9LAMLKBVMgvyeU9Zpu3TeDliiIg=
X-Google-Smtp-Source: AGHT+IEM4q8ckaJOaqJ37vqJImoEFL6gBj7LRQvieWotJ1pLu4Y9AR/ddJPtofDG+Xf/UGzI0fjLxA==
X-Received: by 2002:a05:6359:c1c:b0:168:cd6e:f130 with SMTP id gn28-20020a0563590c1c00b00168cd6ef130mr5679509rwb.1.1698063660155;
        Mon, 23 Oct 2023 05:21:00 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id g24-20020a37e218000000b007671b599cf5sm2665245qki.40.2023.10.23.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:20:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] offchannel: handle out of order ACKs/events
Date: Mon, 23 Oct 2023 05:20:54 -0700
Message-Id: <20231023122054.34100-1-prestwoj@gmail.com>
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

We can detect this situation in a few ways, first by looking up
the offchannel info by both wdev and cookie. If found, continue
as normal. If not lookup by only wdev and if there is still no
roc_cookie set the cookie from the notify callback to a temporary
'early_cookie' placeholder and return. This can be checked in
the ACK and if it matches we know the ACK came out of order and
the started event can be sent.

This also handles external process case. If we got a spurious
notify event before the ACK, the ACK callback will fail to
verify the early cookie, set roc_cookie correctly, and the expected
ROC event will come and issue started. Since there should be at
most one ROC session per wdev we can assume the temporary
early_cookie won't be overwritten.

Another minor change was made to the lookup on the cancel path.
Instead of looking up by wdev, lookup by the ID itself. We
shouldn't ever have more than one info per wdev in the queue but
looking up the _exact_ info structure doesn't hurt in case things
change in the future.
---
 src/offchannel.c | 73 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 8 deletions(-)

v2:
 * Skip started if the event came early, and start in the ACK
 * Add check for roc_cookie && roc_cmd_id in notify event. This
   verifies that we actually have a pending request, if not it
   came externally.
 * Add 'early_cookie' placeholder to guard against the case of an
   external event coming before the ACK. Prior, this would have
   set roc_cookie to an incorrect cookie and called the started
   callback prematurely.

diff --git a/src/offchannel.c b/src/offchannel.c
index b9cdc117..98cbe560 100644
--- a/src/offchannel.c
+++ b/src/offchannel.c
@@ -43,6 +43,7 @@ struct offchannel_info {
 
 	uint32_t roc_cmd_id;
 	uint64_t roc_cookie;
+	uint64_t early_cookie;
 
 	offchannel_started_cb_t started;
 	offchannel_destroy_cb_t destroy;
@@ -54,15 +55,34 @@ struct offchannel_info {
 	bool needs_cancel : 1;
 };
 
+struct match_data {
+	uint64_t wdev_id;
+	uint64_t cookie;
+};
+
 static struct l_genl_family *nl80211;
 static struct l_queue *offchannel_list;
 
-static bool match_wdev(const void *a, const void *user_data)
+static bool match_info(const void *a, const void *user_data)
 {
+	const struct match_data *match = user_data;
 	const struct offchannel_info *info = a;
-	const uint64_t *wdev_id = user_data;
 
-	return info->wdev_id == *wdev_id;
+	if (match->wdev_id != info->wdev_id)
+		return false;
+
+	if (!match->cookie)
+		return true;
+
+	return match->cookie == info->roc_cookie;
+}
+
+static bool match_id(const void *a, const void *user_data)
+{
+	const uint32_t *id = user_data;
+	const struct offchannel_info *info = a;
+
+	return *id == info->work.id;
 }
 
 static void offchannel_cancel_roc(struct offchannel_info *info)
@@ -98,9 +118,19 @@ static void offchannel_roc_cb(struct l_genl_msg *msg, void *user_data)
 		goto work_done;
 	}
 
-	/* This request was cancelled, and ROC needs to be cancelled */
+	/*
+	 * If this request was cancelled prior to the request ever hitting the
+	 * kernel, cancel now.
+	 *
+	 * If the ROC event came before the ACK, call back now since the
+	 * callback was skipped in the notify event. There is the potential that
+	 * an external process issued the ROC, but if the cookies don't match
+	 * here we can be sure it wasn't for us.
+	 */
 	if (info->needs_cancel)
 		offchannel_cancel_roc(info);
+	else if (info->early_cookie == info->roc_cookie && info->started)
+		info->started(info->user_data);
 
 	return;
 
@@ -191,7 +221,8 @@ void offchannel_cancel(uint64_t wdev_id, uint32_t id)
 	else if (ret == false)
 		goto work_done;
 
-	info = l_queue_find(offchannel_list, match_wdev, &wdev_id);
+
+	info = l_queue_find(offchannel_list, match_id, &id);
 	if (!info)
 		return;
 
@@ -246,6 +277,7 @@ work_done:
 static void offchannel_mlme_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct offchannel_info *info;
+	struct match_data match = {0};
 	uint64_t wdev_id;
 	uint64_t cookie;
 	uint8_t cmd;
@@ -261,12 +293,37 @@ static void offchannel_mlme_notify(struct l_genl_msg *msg, void *user_data)
 					NL80211_ATTR_UNSPEC) < 0)
 		return;
 
-	info = l_queue_find(offchannel_list, match_wdev, &wdev_id);
+	match.wdev_id = wdev_id;
+	match.cookie = cookie;
+
+	info = l_queue_find(offchannel_list, match_info, &match);
+	if (!info) {
+		/* Try again without cookie */
+		match.cookie = 0;
+		info = l_queue_find(offchannel_list, match_info, &match);
+	}
+
 	if (!info)
 		return;
 
-	/* ROC must have been started elsewhere, not by IWD */
-	if (info->roc_cookie != cookie)
+	/*
+	 * If the cookie is zero and there is a pending ROC command there are
+	 * two possibilities:
+	 *   - The ACK callback came out of order. This has been seen in UML
+	 *     when an offchannel request is canceled followed by another
+	 *     request on the same channel. To handle this delay the started
+	 *     callback until the ACK comes in when we can check the cookie.
+	 *
+	 *   - Event came from external process doing ROC. Checking the cookie
+	 *     in the ACK lets us verify if this is the case.
+	 *
+	 * If the cookie is set but does not match, this ROC request came from
+	 * outside IWD.
+	 */
+	if (!info->roc_cookie && info->roc_cmd_id) {
+		info->early_cookie = cookie;
+		return;
+	} else if (info->roc_cookie != cookie)
 		return;
 
 	switch (cmd) {
-- 
2.25.1

