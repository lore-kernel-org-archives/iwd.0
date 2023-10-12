Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEEF3C6B1
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe6vQyB0"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c9bca1d96cso11655435ad.3
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140925; x=1697745725; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRAryhIyB2TW+isH4eRZQPeCxi6k0E1U6/E2eLVn3Jw=;
        b=Fe6vQyB0VvRdUgIP6hPQ/tgqnzHPhg7ZcNCjnwGdhDMeKpv5fWB/58L2z3twNTGgH7
         BRNrOBr1bX7SKfjGhmuEagtJRb1fcWrjIMBNYovQxiTETA8OOvljn4pkSRCLQkH4uXiE
         BtJp49VfzM5bluYnQz5Vbrbbzt5USm+sg7Q2jyeyq41EENfsrR/1SwGT0nGGVwDND8T5
         NQEf7Hn2Y2rwv7e7xzzsBGz4h+rlDXkUDZi0vp5Wmjl0TnQ/SxwTbCjJ6pgl0GqOzoUJ
         EHlOCmLyVIyb5cgkgclGp9gN5XUKNVaxcfRQt1seoo1rjXWz7Yqr3yjMnpmeTJYnKLid
         xUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140925; x=1697745725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRAryhIyB2TW+isH4eRZQPeCxi6k0E1U6/E2eLVn3Jw=;
        b=xKtnoUmG2eBO8GdXJ+yU0wsRUDAK1gW0Rl/hqJ75jgr1YvNy3ysyAAk/iEa3vFKZFQ
         BWkymkyNr9zRwnIuxKIkyiFdxjW+ddn7Mdfy0Dg7GKMN2VQoxwSjL073w97xuWkwuohn
         91+8Kd8+pXyXICepNY/RTbt4JHZomtixYOnZgqcyz+z5v0Owdql5U5TkQIK+2JBtmzI/
         7cfmzN2F+Sk7S+OdI45tI+GicTJbjfR3hmOuI7CaXPpxplhoPceacRPJ8gKSq9GQN3fU
         TyV7v8Cu3ppWO2n1him314KXTLwkitJGlIRJEHP5r+adUiAMArLWwh9EoOJF4ytwY0E+
         vlXA==
X-Gm-Message-State: AOJu0YwUKOyZgHiMcDQk7fYiS1pAicPntH7ai2G928qS6k+MOcH08jVH
	8dwyr4o3xfyInle+Jv3iBJ+/O3e/tRA=
X-Google-Smtp-Source: AGHT+IH9pBQnX5YxdmPzS5r2ud3dJvd1LPBOSIclBStSOE8kSrZeX+2kXhnP56xibMYKsGh/T0BAqA==
X-Received: by 2002:a17:902:9b8e:b0:1c6:2780:3adc with SMTP id y14-20020a1709029b8e00b001c627803adcmr19702037plp.24.1697140925238;
        Thu, 12 Oct 2023 13:02:05 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/21] offchannel: add support to issue multiple offchannel requests
Date: Thu, 12 Oct 2023 13:01:39 -0700
Message-Id: <20231012200150.338401-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012200150.338401-1-prestwoj@gmail.com>
References: <20231012200150.338401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was nothing which prevented this, but due to the behavior of
some drivers multiple offchannel requests on the same channel
resulted in the second request never starting and eventually timing
out. This is because some drivers combine offchannel requests if
they are on the same channel and this ultimately results in the
netlink ACK coming after the ROC started event. This patch fixes
some logic to allow for this case.

The motivation to support this is so modules can start offchannel
work items for short durations and wait for a response, if a frame
is received the offchannel request can be canceled/restarted for
a longer duration.

This could also be done instead by using a long duration initially
and an extra timer to cancel, but its more convenient if offchannel
supports this natively. In addition, this driver quirk should be
supported regardless (e.g. if two IWD modules happen to issue ROC's
on the same channel).

Furthermore, the offchannel module was only looking up requests by
wdev_id which could result in the wrong request being found.
Instead the request should be looked up by both wdev_id and cookie
(when possible), or the ID in the case of canceling.
---
 src/offchannel.c | 55 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/src/offchannel.c b/src/offchannel.c
index b9cdc117..6a705092 100644
--- a/src/offchannel.c
+++ b/src/offchannel.c
@@ -54,15 +54,34 @@ struct offchannel_info {
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
+{
+	const struct match_data *match = user_data;
+	const struct offchannel_info *info = a;
+
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
 {
+	const uint32_t *id = user_data;
 	const struct offchannel_info *info = a;
-	const uint64_t *wdev_id = user_data;
 
-	return info->wdev_id == *wdev_id;
+	return *id == info->work.id;
 }
 
 static void offchannel_cancel_roc(struct offchannel_info *info)
@@ -191,7 +210,8 @@ void offchannel_cancel(uint64_t wdev_id, uint32_t id)
 	else if (ret == false)
 		goto work_done;
 
-	info = l_queue_find(offchannel_list, match_wdev, &wdev_id);
+
+	info = l_queue_find(offchannel_list, match_id, &id);
 	if (!info)
 		return;
 
@@ -246,6 +266,7 @@ work_done:
 static void offchannel_mlme_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct offchannel_info *info;
+	struct match_data match = {0};
 	uint64_t wdev_id;
 	uint64_t cookie;
 	uint8_t cmd;
@@ -261,12 +282,32 @@ static void offchannel_mlme_notify(struct l_genl_msg *msg, void *user_data)
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
+	 * If the cookie is zero this could be from the ACK callback coming out
+	 * of order which can happen when there is an ongoing offchannel request
+	 * that is canceled (but no ROC_CANCEL event yet) and another is issued
+	 * on the same frequency. Some drivers will combine these two requests
+	 * and the ACK ends up coming after the ROC started event.
+	 *
+	 * If the cookie is set but does not match, this ROC request came from
+	 * outside IWD.
+	 */
+	if (!info->roc_cookie) {
+		info->roc_cookie = cookie;
+	} else if (info->roc_cookie != cookie)
 		return;
 
 	switch (cmd) {
-- 
2.25.1

