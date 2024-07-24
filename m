Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA90155740
	for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721823290; cv=none; b=mmXB95FLqJJZL9gXSMtrzscjC4wreQ1tInd/K2Ojw8CO3H9bnKA7I7GSvTGOZKkojOQ1So83ThXqP8KLZsgnmNIVHZsi/5mBxjN2j9OlTZKwwnUYP/I9FMeR/KyvpfVDHy7ID1xA/K4pRhpu76VT0AxZiEkNAJDrKOx6ZQzp28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721823290; c=relaxed/simple;
	bh=QscksZrWtNwkqYvetujkj8DD6WRPE3G8o808yipbcr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K5GYI5VbNzOBAnh76M1F+ZuuGyHDw0RLmF1FnzUwGKxMngNo/cMx97CS0GoHG4caGjHbQTZZLlAEygtiYHznoCqQW0j4eR4rbzT08eQkIRpH8dVGD1umUKxl53umgiptfBnCujP4UAJMNUuiuQ4YeqZw6TfZ9J/gFz59Ugs4bxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6bZobWg; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6bZobWg"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e05f2adab8bso6356946276.1
        for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721823288; x=1722428088; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9cLU4jdlthlIn6p1Ko430yfyJxacM7dBmOKgJ5BhD+U=;
        b=S6bZobWgsERmq0nFVBCY11j1Jrq2u0sll2dqEy5v5wxJUwpEFHu3cmmzK0cp4Fe0tz
         +Krw2lRiYs8eWhqcrwNyr5gltr9n1djiRVXVQepn6X2vPsnZX/uMIRO1QxoJfS/Shtit
         KP0+egVo/uXS8iUrZ9w/J/A+XpGM72YwZbwkQCObVeqiLIHtaqEaz2pE8hrutttuiUKz
         kVyyXGTxzyqR03iAOagvkQFPAGfsCrcNHaoUr1w+rqooSJJ82KCE8XcdQtNy7xbu3u04
         qRxi68hg8rEFOIO6aKipQE9oiweYFAVD3KmLWxt5HHp3mfTqvIHicPszTK3ncOoouHrr
         aong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721823288; x=1722428088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cLU4jdlthlIn6p1Ko430yfyJxacM7dBmOKgJ5BhD+U=;
        b=AyYnkjbhSykCbnOjTLXKz1hS/WQ+pbpQiKTZnSTQQiTGFx53K/2LfDGhLrFMuRIkch
         Sf7/rtf/L/xZ42PmtDJwKy0E+NZl3XJn0aE78TabSvFtyd+5pEbpOVlubXghVNDg7w/9
         Y4tdc1qYKh2FbasLL/fKVOqseQqlH7hu+71bhHGheHY9n3fCwKGlZSqr91p4UsRUePOm
         bHW2/IqisIrpdGveJeXQNWJv3MazSJCErSvqkmDSwmC+2tWkH78cJ6gabBsR8m5rrjsM
         u0xn37H2qzhRu4qXJUcYNQIDJOmwWDdGbbvy5oRUkePQBPChZMOnlEe6+nMs2MTWqC2L
         doBg==
X-Gm-Message-State: AOJu0Yx2WZU8diglpOT0TQb1O56TYDGISuH0pwpY2sRP0lVCUXCcVirQ
	cxw0Ui40FAPjefYWA3e42cbu7F9dQSvEc5gqrSQIXxylM6Pzv+eTqzl2jg==
X-Google-Smtp-Source: AGHT+IHWbDAlAQoyxUwlq3TRwMm058aK0VHoDCf787x5Hv7lrGwaeikULRkcDkCGQlqdpLZUlxqfPA==
X-Received: by 2002:a05:6902:2844:b0:e08:6bb2:ed1f with SMTP id 3f1490d57ef6-e0b0e3deb24mr2071326276.19.1721823287728;
        Wed, 24 Jul 2024 05:14:47 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cdbd9b6sm52652171cf.88.2024.07.24.05.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 05:14:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] scan: fix invalid read when canceling an ongoing scan
Date: Wed, 24 Jul 2024 05:14:42 -0700
Message-Id: <20240724121443.1425256-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the survey code was added it neglected to add the same
cancelation logic that existed for the GET_SCAN call, i.e. if
a scan was canceled and there was a pending GET_SURVEY to the
kernel that needs to be canceled, and the request cleaned up.

Fixes: 35808debae ("scan: use GET_SURVEY for SNR calculation in ranking")
---
 src/scan.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 1982cf74..30b3361e 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -948,7 +948,7 @@ bool scan_cancel(uint64_t wdev_id, uint32_t id)
 	 * Takes care of the following cases:
 	 * 1. If TRIGGER_SCAN is in flight
 	 * 2. TRIGGER_SCAN sent but bounced with -EBUSY
-	 * 3. Scan request is done but GET_SCAN is still pending
+	 * 3. Scan request is done but GET_SCAN/GET_SURVEY is still pending
 	 *
 	 * For case 3, we can easily cancel the command and proceed with the
 	 * other pending requests.  For case 1 & 2, the subsequent pending
@@ -963,6 +963,9 @@ bool scan_cancel(uint64_t wdev_id, uint32_t id)
 		if (sc->start_cmd_id)
 			l_genl_family_cancel(nl80211, sc->start_cmd_id);
 
+		if (sc->get_survey_cmd_id)
+			l_genl_family_cancel(nl80211, sc->get_survey_cmd_id);
+
 		if (sc->get_scan_cmd_id)
 			l_genl_family_cancel(nl80211, sc->get_scan_cmd_id);
 
@@ -2105,7 +2108,10 @@ static void get_survey_done(void *user_data)
 
 	sc->get_survey_cmd_id = 0;
 
-	get_results(results);
+	if (!results->sr->canceled)
+		get_results(results);
+	else
+		get_scan_done(user_data);
 }
 
 static bool scan_survey(struct scan_results *results)
-- 
2.34.1

