Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C43236A74
	for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596156; cv=none; b=c7HrRDtbHKU6JcXgHTOB7gR3glbb0c9Ih6A1pUO834kES3dncD6VKMdIiEIVgNCYClfk4ghHQVnKLuwpB9C1NVxzDjW/39UOA/pZfOtXQdFDZtQwMWalU2LCdT8sGxKJMZZRII9r5hbpTlCqSAp1CS4WDE8SCX2rYWqRPsfGyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596156; c=relaxed/simple;
	bh=t1klpInPMh+GPYPuUXk6y25BSCJkIh+hgAHk1MVHGtM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R5qv8zZECrxjs+mBps5GcEDYuPf9uSZQBX0GZnN2JNTtqbHm5pP2G5mgKsXpVz3sKc4H/CUSKVLsP4b96uf9hFwpGsPmNO9x3okGZD8Urie+GvFzCf0GSAs08tc1yhmZPyj68g752NZFfD1d8PhqrqDgMrqD3pg9vtFSupL+VZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfOY3sF7; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfOY3sF7"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0a974d433so112302285a.1
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 10:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740596153; x=1741200953; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIcDlbqrOj1C/RGbYOvvdnR9pdYciDBOi4NL1sBogGo=;
        b=hfOY3sF7aze2plSzfSGiFrKbtHQkzxaITefuFZ0vIHTi6aOCykqAqcjx25A2cQTwEg
         EgX/YdxYbLdfFBqTnLDC4ixaKGy81+pkDgFiDIJXtKZnZxbuTpL21uUkYRTSxMt4rz3M
         qA5pukH3YofxyV7UYxiQTiNcsLB4MqH4PSZUHFCoP0lgc+GAwUEF0RzbSdbRAn98LuCc
         UucBgmvksrnsH/lrnewrK22j8zYTr63BG48ejUhkx+RGPtdpVIrE/ii/3kUMXRFS3gqB
         L0g87CnFadFLNGWsk82smq3XSjMEvHtfbiWimppn5MyjsMz82D2NA50eAyJ/a3oPUkH4
         wt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596153; x=1741200953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIcDlbqrOj1C/RGbYOvvdnR9pdYciDBOi4NL1sBogGo=;
        b=e6bWtnRpE/mA7LK8vwo3yNbyIdDBxmqowsiY9VJZOPPB1yzOQ6MO1zy4EwSuwnet/n
         j4Z/H2EexqFF1gl5dtNThUcLq7CKEOGfNJWlxE9eC7nhLW0v6K3DimQLsIqYThNXnfHA
         Y+o9c2KaCsctcBmJ8pBC2Rh22gMZIo1DYHva+VZnhzTa8hFhgGZPdsnRYBCYuIHUnjOH
         eZLawvnvbrJb3HUYGiixLHqoGl8qVPKKUFUm2CNNIGCW9ROJD7TycGEh5YbtOzx3P1C8
         IK6H8uPX/d9SsTSibOgb1DcLoHj0PYHs9Xfz/DYhBmPURVtvlfLQGgBWE0XaaN/xaKSK
         uvxg==
X-Gm-Message-State: AOJu0YwCW+O35btC3oGtXwVEydBhCkQAtodxMx3gsaDC3+UhaN9yw0Ee
	tvZyaJVAvXPOSyNbYPTPTxWE5qWEnRchAIevT3B3gS5uHIltH/3UPzjkJA==
X-Gm-Gg: ASbGnct+RbsppG15SH8nGqhqp37Bn+mkCmrmLl653iiawB0oYQJ1JYDuBYvMGaFoN9U
	Vz0Q9uqBdFVK/IL72+Rn6ShwLOJcibrZJDATzzmV7B+UpWLHfbz3vVq6aIt9XOVOsH540LBYKrl
	tZntsRfPXzLJ2YzhAEXD0plDr1eeRxxpuX69K60+n2iTrp/LH9zkJRXiSLHEXfG1HxuKnJVWI3X
	UVRRuIbdi0oKH7gx2ieK0yVtYg1tTat8SA0bic26/FT7xQpM/y5rQriLO3tsY3TyQSvm60VK2fw
	SVkMtVlpuMHKEKEe4dZI3ue7jtRkUzl7q8rJ
X-Google-Smtp-Source: AGHT+IGnvqKLKLf1HXB7PT1hsPiTx67CIL3FhSUG5Jgp87QNhJCTnFd5aUVkq+hpkshK2q5XEQGg5w==
X-Received: by 2002:a05:620a:6911:b0:7c0:a1a2:6ce3 with SMTP id af79cd13be357-7c2a1d56cc5mr49655485a.24.1740596153209;
        Wed, 26 Feb 2025 10:55:53 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c33cc1csm279811385a.95.2025.02.26.10.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:55:52 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] blacklist: allow configuration to disable the blacklist
Date: Wed, 26 Feb 2025 10:55:48 -0800
Message-Id: <20250226185548.49127-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain use cases may not need or want this feature so allowing it to
be disabled is a much cleaner way than doing something like setting
the timeouts very low.

Now [Blacklist].InitialTimeout can be set to zero which will prevent
any blacklisting.

In addition some other small changes were added:
 - Warn if the multiplier is 0, and set to 1 if so.
 - Warn if the initial timeout exceeds the maximum timeout.
 - Log if the blacklist is disabled
 - Use L_USEC_PER_SEC instead of magic numbers.
---
 src/blacklist.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/src/blacklist.c b/src/blacklist.c
index 04e4b8e3..21f85a75 100644
--- a/src/blacklist.c
+++ b/src/blacklist.c
@@ -91,6 +91,9 @@ void blacklist_add_bss(const uint8_t *addr)
 {
 	struct blacklist_entry *entry;
 
+	if (!blacklist_initial_timeout)
+		return;
+
 	blacklist_prune();
 
 	entry = l_queue_find(blacklist, match_addr, addr);
@@ -162,19 +165,31 @@ static int blacklist_init(void)
 		blacklist_initial_timeout = BLACKLIST_DEFAULT_TIMEOUT;
 
 	/* For easier user configuration the timeout values are in seconds */
-	blacklist_initial_timeout *= 1000000;
+	blacklist_initial_timeout *= L_USEC_PER_SEC;
 
 	if (!l_settings_get_uint64(config, "Blacklist",
 					"Multiplier",
 					&blacklist_multiplier))
 		blacklist_multiplier = BLACKLIST_DEFAULT_MULTIPLIER;
 
+	if (blacklist_multiplier == 0) {
+		l_warn("[Blacklist].Multiplier cannot be zero, setting to 1");
+		blacklist_multiplier = 1;
+	}
+
 	if (!l_settings_get_uint64(config, "Blacklist",
 					"MaximumTimeout",
 					&blacklist_max_timeout))
 		blacklist_max_timeout = BLACKLIST_DEFAULT_MAX_TIMEOUT;
 
-	blacklist_max_timeout *= 1000000;
+	blacklist_max_timeout *= L_USEC_PER_SEC;
+
+	if (blacklist_initial_timeout > blacklist_max_timeout)
+		l_warn("[Blacklist].InitialTimeout exceeded "
+			"[Blacklist].MaximumTimeout!");
+
+	if (!blacklist_initial_timeout)
+		l_debug("initial timeout was zero, blacklist will be disabled");
 
 	blacklist = l_queue_new();
 
-- 
2.34.1

