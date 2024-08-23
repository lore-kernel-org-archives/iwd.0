Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E318BBAE
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429933; cv=none; b=Mk85jNjmjrveqxbYL8er3a81XwuwEX/5jV8Ea8ppT7gj3rytLvRMNxiPo4XD7/fyVqSObj2VEumXjKgWXvGT2iDrLa3dazA48cVP74ILHtsQBSoihYuiR56GRbycE6+0WN+mahYANI/zo7DWAg+1+IttwFXIkuvsoQF53qO2UfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429933; c=relaxed/simple;
	bh=Wt1L3rvUCgGk/Fmd4JyHvdnJtbAnPIzK4M1f0nWIuPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2aqFKdu6HGMmZhGp55k1Uc36RHQVHTI6YZNzVSowfnqBstVNyurbBsUCyr7OOO37FFbXSy0GucEtFHMOaowjUq8stSc2LJcjuozQYkxdzcw7kEhdRUecqgVz10vT1Z5H1PFvW+1GSaZu9l2gqLEjAjmqiM8NkF5mLk1+uMuHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3qukC4r; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3qukC4r"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70949118d26so1949726a34.0
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724429931; x=1725034731; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WebbZ9lHvQZT9Sw6xHXxgzZUXxZibJ2W7RwWkA+K7k=;
        b=F3qukC4r4p6NwdEI5Tplq7vAbHQujTRBnddAHQiarU/Yc6shY/yYYNYzXSSb0l1D4M
         wYFrkTk+WNwCRJuPFPD+FWGEF1sWebzEYt4Do4roXy+2G8XZRWYsFhtMYxHvyWTLUr3F
         +HJF65H39yL5VLY6sNE5pwKFUSapa1xJYUn6tEfET/rk9OVNw6A6viIOCgm5SWHYWIAu
         l9ke8btjmdW4w322lMc1rlPUF8+Qcqgt+aFdM3iAgfuOtjm/RplyWMOF/Z11ZaXDQT0n
         UCfB7iGVhsb3WXmC+xwTUTz92+sj4i2GvYgGf7M6keX7EejsgSMtHWkO75Fe5OFsTRU7
         GuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429931; x=1725034731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WebbZ9lHvQZT9Sw6xHXxgzZUXxZibJ2W7RwWkA+K7k=;
        b=DlGXz9aYKcQxHFeK36nJ/scy9/8PNs10MJtBIRPFjD8mmjxtKPMZ5sdHedTwi9w153
         Trt1tk351FoiyNmVXn8f4AiRY6z8dJsStceJ8p8+V0iT5r9T2XuUvJcynwF1I1qqxBzu
         jVk4NuE4X30CSlESWNvKg3HARq6LHQ1lu10iU2/xrWzjJjIKF7XOGA+kkx/+PQxwsAFc
         yK53HD3KAgkqzLhfqPjSXZ9reaQYDXafCr4Iw8I7uXGTgc+p7UF5Sz2MUYpbODnlnTVJ
         3Nu3DNpOIHP2b1Tbj/aMAz7Bt22A94L9v0xHmfAFIDIP+8N9kILUhwqW6xPvo7rug6+r
         RE+w==
X-Gm-Message-State: AOJu0YzbGKpEGi+5tW2F+j5dMSdumqi/8PpE7CVwXTobl1/oGjGsMuFm
	uqQGAMpcESDcZZ9C/2oc1xdz23kzZiMxVjQvsB1xJHHQ8jPq9TrVPZB5hg==
X-Google-Smtp-Source: AGHT+IHUAAI6weVyJxLZHZ5Pr2q5jerwXEXn8VTD3Q7ijNQAOG6ue/nKyPbA3FEwl8/EhDo/vGeHsg==
X-Received: by 2002:a05:6808:1488:b0:3d9:350b:4159 with SMTP id 5614622812f47-3de2a8b92e1mr2642612b6e.31.1724429931412;
        Fri, 23 Aug 2024 09:18:51 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2256f44asm764507b6e.31.2024.08.23.09.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:18:51 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/5] monitor: Don't dump survey results with noscan
Date: Fri, 23 Aug 2024 11:18:30 -0500
Message-ID: <20240823161848.485685-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823161848.485685-1-denkenz@gmail.com>
References: <20240823161848.485685-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Survey is used after each scan, creating quite a bit of spam.  Silence
survey results if noscan is set.
---
 monitor/nlmon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 214246ea72c2..f0ffff90b1d7 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -7254,8 +7254,10 @@ static void print_message(struct nlmon *nlmon, const struct timeval *tv,
 	if (nlmon->nowiphy && (cmd == NL80211_CMD_NEW_WIPHY))
 		return;
 
-	if (nlmon->noscan && ((cmd == NL80211_CMD_NEW_SCAN_RESULTS) ||
-			(cmd == NL80211_CMD_TRIGGER_SCAN)))
+	if (nlmon->noscan && L_IN_SET(cmd, NL80211_CMD_NEW_SCAN_RESULTS,
+					NL80211_CMD_NEW_SURVEY_RESULTS,
+					NL80211_CMD_TRIGGER_SCAN,
+					NL80211_CMD_GET_SURVEY))
 		return;
 
 	switch (type) {
-- 
2.45.2

