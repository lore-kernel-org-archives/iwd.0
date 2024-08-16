Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D69156F34
	for <iwd@lists.linux.dev>; Fri, 16 Aug 2024 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812741; cv=none; b=GKamqYOs5Vv2XBwBGptZtLP4lUp0UxurW8XP+dsJIJBYV+lciVvu4N28Y6+lJBu+lxddZGtHQ0FvhWIOXOLfBvePORFhOCvQ7DTxwoLPGAAC+Llo9Zj16UoYOx8SYB7M+GwclWtb+wfIqqao2jIaEx4mg18X8Kwr2ROwj0TWQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812741; c=relaxed/simple;
	bh=Xo0jQKN0L3cPu7vcQ9s1yXgfKSMGdhZqcDWEIRz2Tbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SptjNe+TXNhxV/hH2nDTnMFxnHjaawaG0p//PmBGyAsftFBxqu8NRb9EZ52jDkZevo6BDMyLHjWtz15hcpPoKnzCJSLPyrbpTWIf3pFOZ4CPGEI8LYmVz3DFOKdoAEbLAKf94fiz+oPLVmCNxUS/6YvgIbROHYmm8R5h1QX/FQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzn6V455; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzn6V455"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fdcd7a622so11337281cf.0
        for <iwd@lists.linux.dev>; Fri, 16 Aug 2024 05:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723812738; x=1724417538; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qBTWjnhGFVMdytmi/xL+pxTD5kCqfJksEi160IRlQa0=;
        b=Jzn6V45569mQ0MLUTlMsrOhGvnAf1khuCtQK4CzU2D/6uArYScZqtUi1wuUchrpgxk
         zikRiuRJ1/b2Q1uDUZAwnyiASfcZ3jRDrxkvH1Rp6On5GIiSnRwdlbKvUH25Dl78KwAy
         3atcn/7teYH+sjxZ2xFM63829BV6/mtDSjePQTUGPZtPA7yn9i5lPFV9NU1wLPGKniAA
         onjPgMZ+AAniDjwDLSv3ZsLUQeu24dlGjgRWGrre7sof0CN3ADVzwpqF5mRC/Lg1gLHe
         W0jxzZPo1U4kAyKe1g4JZKmAoQ+JJKyUp5j+P0r9oOPDloCN7vXM4+kgjlCLUjD9VKHJ
         H4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723812738; x=1724417538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBTWjnhGFVMdytmi/xL+pxTD5kCqfJksEi160IRlQa0=;
        b=qZQPf4V4vFxGKqiW6tcD+vD628SS2nS9+624AJR0BK33VmVV4fD6LEDaAqd2UqAcB+
         FL3JkAdOwzCGmoQ4gaY5ytgFkcujSbMi6omAWxCxd4OKmI2a1iZ89ZjoiciUn7dJssbD
         saUH1ItVO0VGzmRGQzpH64VVD23Tf3aLDHKhphr9X+5cwTF9oBcC4LaR6HU5GjEWEnfn
         t9kPlzXUuDgCImBugRXtVm96CZXyFU9K/wY3/EniQg9k4LV4uq5I2u/e6I6K1KHB9Ooi
         4hSuoCxD5uXWVaa7Nrii7iJPVw4+2TKzjw7qJdtYdL9TmI/sJ5QuPuRdICZA2ItGTli5
         xfaw==
X-Gm-Message-State: AOJu0YyFqCaDC8vi8kkTKkl+/mB1HNgiihuT7ygNYlQEezqHJ5CN+JmN
	o33TRz/RSshxkqz/1Rw5QTaAzahXqC+hFQdaO98tVr8krCB5zwSXD0qlLA==
X-Google-Smtp-Source: AGHT+IHtd0kYQnbp67gMm6YoHkQD5JDQzUMogS+NxLtPIdAYN/NMwSNrBiERdfX7TurgmV/uX3vGNg==
X-Received: by 2002:ac8:7418:0:b0:453:74a5:3a3f with SMTP id d75a77b69052e-45374a53ad2mr22504801cf.0.1723812738064;
        Fri, 16 Aug 2024 05:52:18 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff54ffsm15921931cf.36.2024.08.16.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:52:17 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] network: add __network_path_append_bss
Date: Fri, 16 Aug 2024 05:52:09 -0700
Message-Id: <20240816125214.1162415-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To reduce code duplication and prepare for moving the BSS interface
to station, add a new API so station can create a BSS path without
a network object directly.
---
 src/network.c | 12 +++++++++---
 src/network.h |  3 +++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/network.c b/src/network.c
index 85d2a983..a8e61d48 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1130,17 +1130,23 @@ bool network_update_known_frequencies(struct network *network)
 	return true;
 }
 
-const char *network_bss_get_path(const struct network *network,
-						const struct scan_bss *bss)
+const char *__network_path_append_bss(const char *network_path,
+					const struct scan_bss *bss)
 {
 	static char path[256];
 
 	snprintf(path, sizeof(path), "%s/%02x%02x%02x%02x%02x%02x",
-			network->object_path, MAC_STR(bss->addr));
+			network_path, MAC_STR(bss->addr));
 
 	return path;
 }
 
+const char *network_bss_get_path(const struct network *network,
+						const struct scan_bss *bss)
+{
+	return __network_path_append_bss(network->object_path, bss);
+}
+
 static bool network_unregister_bss(void *a, void *user_data)
 {
 	struct scan_bss *bss = a;
diff --git a/src/network.h b/src/network.h
index 78ced99d..c9f73200 100644
--- a/src/network.h
+++ b/src/network.h
@@ -77,6 +77,9 @@ const char *network_bss_get_path(const struct network *network,
 						const struct scan_bss *bss);
 bool network_bss_list_isempty(struct network *network);
 
+const char *__network_path_append_bss(const char *network_path,
+					const struct scan_bss *bss);
+
 struct scan_bss *network_bss_list_pop(struct network *network);
 struct scan_bss *network_bss_find_by_addr(struct network *network,
 							const uint8_t *addr);
-- 
2.34.1

