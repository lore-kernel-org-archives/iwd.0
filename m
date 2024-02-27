Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391114DFF5
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066566; cv=none; b=Npz5Do7QUpGdZQof8Q9CEVgD2xcZUhEr9+XraW8eylUg0Ly7bMkiM3u2edcfs3IymSH7YtaX6C40Wq6EuHLcERulA7qyMA4MqchtIPvuisQx50n4Mf5lxMIyU56PnIU0VZl+3HGR1Fug/rGHiTEh8J4HubL7RVQmzdXzrTqpypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066566; c=relaxed/simple;
	bh=E5utlXOBREBPb5wc25IYOHJ3XrMIdC4pKt+uyS2MjdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IgY8bK/wLX0Lrwroc7OzMeD3TB5AAy9J1zFG7QV4xNwpIhd6Gy7j0tFR5oLbRljC7S6Uro7QqHuiboWyRAJspeO8QrRJAs9qR/vH5VBVKhrQv9Td+iA/NzctQJlltwKV5LmfL8Pru41E3JboQGmDoZDoBfaDnAID2AbUsq8eg7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHRoEdQ7; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHRoEdQ7"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dc8b280155so3417932a34.0
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 12:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709066564; x=1709671364; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VWqOiEy2+iljaGc9yTAL55ll09C+g/5kEKyQRFVvpl4=;
        b=OHRoEdQ7mYFtAmn8ieSNMhv5ddd5COGBQNv1tJ67Hq1FvafD5N3KKcn5HUCdQYoQRw
         Enfb7snHH4n/mXCeSmFbr1KsKFJ5llGZY9FESrW+KXy7od+jTiuG9DrbRgbb/qJi651B
         4yqWVdrNJqaqKHJg/u9I8KSQpTDu8ZVTu0gLtz94fgP6s3e4JuSV6rLYoyr5FgO74Efw
         P/J36sFKDE3wVVpPvQGq6gOATajTu+NNHwgqetag8xxNYdLXUmEGxwo9GP82dEPCWRJt
         yYdvbVy8YWmjUpYUkQVvKo56uWctWU6FaPEKKcifr1efolsFeUhnoTF4qC4M8zRUyIjr
         nAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066564; x=1709671364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWqOiEy2+iljaGc9yTAL55ll09C+g/5kEKyQRFVvpl4=;
        b=ezmFuHHecmOlhuewDhYmMQg1WtXcJHLTpEUO3t/ddF86YG6gE1vkYvfAP1lNGjpv13
         abd+reuU04AwGqGnnN24ZHF+kgJHZVismBJj6TLKwBFEWPh2qghzbTB6C7uTFw4k0LvR
         n9VPo3/DD/3+Fi37nbU+xZ1VX7nQF3aqbsjQ36dey56OS/XbB+AhxKTMcz1gV5CYkCTq
         FNvk7AnRagpkcSztG7d1+f20hVhfOQzUH7XXnw8rI0rW7cMholFnn3Ze8E+Lo3rHJrSp
         f0Bp83/LP8gzoL25hONQZB8TIR6nL4GVml4P5iKyJD+u1wLIr2zzPEsHsdbGAFt0vPuk
         ZIQQ==
X-Gm-Message-State: AOJu0YyAxRbZjru52yHZcuhQUh0MkHEHTGiiOkNGvVYW2hQUrLzqzrN9
	HTM3u2nGJUS21eGIEm6EkW1yW0fFUNpXFr3HAgXyZ8cWtFCDz4sEYVXmDAnF
X-Google-Smtp-Source: AGHT+IEE9Jewn4tEOVpYtj/XgxSyLa8aKGGL3WNuAC7phxuFeRRjSvgQasU/ku3YqQTuDZpjydrvew==
X-Received: by 2002:a05:6830:1155:b0:6e4:b1a5:6568 with SMTP id x21-20020a056830115500b006e4b1a56568mr2015317otq.14.1709066564130;
        Tue, 27 Feb 2024 12:42:44 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id dp10-20020a0568300e8a00b006e497bf81e2sm113421otb.59.2024.02.27.12.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:42:43 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] netconfig: Fix copy-paste error
Date: Tue, 27 Feb 2024 14:42:25 -0600
Message-ID: <20240227204242.1509980-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netconfig_domains_update() was setting dns_list instead of the domains
member.
---
 src/netconfig-commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netconfig-commit.c b/src/netconfig-commit.c
index 50dd6f3304de..d7fcfaba76dd 100644
--- a/src/netconfig-commit.c
+++ b/src/netconfig-commit.c
@@ -311,7 +311,7 @@ static void netconfig_domains_update(struct netconfig *netconfig)
 		resolve_set_domains(netconfig->resolve, domains);
 
 	l_strv_free(netconfig->domains);
-	netconfig->dns_list = l_steal_ptr(domains);
+	netconfig->domains = l_steal_ptr(domains);
 }
 
 static void netconfig_rtnl_commit(struct netconfig *netconfig, uint8_t family,
-- 
2.43.0

