Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF844C67
	for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226465; cv=none; b=MJ6rvxtLGlBS3Ra4h+Fmfp1VnwJ24BItMGdgiGR1HkNJyI2VN7jRPNDRivAQ51BjdlZNjNfyuoYlCqwJ+C5JgjE4+nj8hfHXQIxVdbDg3KRgp5Ku3oSMRIQFI2ugGKa+FdmZgOjBrWDpakLAdmcy8daEbHmIMwd7x/0pROUYeRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226465; c=relaxed/simple;
	bh=KVN1bP/yeL4LK1R49P0e73OyCnnnO/vmBbGyJUiLm3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jzPSrO9rxY0IC1AWqLZ6BQyEKp5KxX0LVaTJjJMe1JouLXLxqq1COhti8JiV/McwlBoyfa0zSuX5M9hoH2fb2bWGUOU277JOlDn4vNI1N1v3z4SZbdXxpp1XhzmhpuGJJQwNrUu0QSd0IEVPL+OKx2z2rybekRnPYCeKQuKG724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPptkHFQ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPptkHFQ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7810827e54eso82979985a.2
        for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 09:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709226463; x=1709831263; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kPc538jMHlw80x3kzgQQjRTP1WDceWAn4v2CFdyVm4=;
        b=OPptkHFQhsa4TLGqDBuK9rpimU/XgXe5Sda5fjz/T4Mil2a3DiSN4zc7vWUpbv1jQw
         iGyrxqLN3oZvQs6VYiV8Eub9X8oi9Qz/ArdvRVbIUeE/59V1RFrxXNLIKqkQe4cmEwuI
         O7rvfGQ/uRMx+3dsTJISx4wBL5bzyvTjAEQCV7yxoD2BhRm9tsw99xgr/FPwZeffYVlg
         LjtQe/SuDn1A8Jcz5y+eZLiaYesRnUHGjWWw9S3Bmge1GmbCYl+66duJCr9g24dNtx5C
         3u2yK5wb1ssQPmxcGRvz3C0ln+GrXr3SttGjer7vWsPHLeCBjrI6ecGuYaF3PxOmVHi9
         iDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226463; x=1709831263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kPc538jMHlw80x3kzgQQjRTP1WDceWAn4v2CFdyVm4=;
        b=EGuewKR9f1sJ/Md4yMdUnuv4wiX3I8ODk8WasLNiMI92b9vxG0Y48JSCBJZuJ7jyQU
         yhai9FVu4ruz3incwifZnobmpBPbSzalTQBt0Mz/Wabo640brroRR+Qhm4Gg8lvTaFQK
         eAaPR+0saDpAVV7ww9QgI51lPrIC6TKhgDLu2Pf23rRRoM2wUNs0RibTROF5icBlnyxU
         cqDc564ATQ8VrPmHfIFprtKlXvMBIv/LQYVz4YowKdDFo+vPxrLFsOdfjBZzUgpI+gJV
         7s5MsySlh9ArxExMtD+icljvNiENtWROQmUykddsdbRilaqrYmaJiZ1k/okoL0jJ0xku
         5BJA==
X-Gm-Message-State: AOJu0YzFT8NiPWGReaw6vIv5o/vZ8I/JvLx7aUJ6ezkOyZgeRybAa7c0
	+IMqUZ9biRJfQGCHxjaK3mmhQoIkPTdk97UhI3bD79149u7kTxJyYh5AfQiq
X-Google-Smtp-Source: AGHT+IFZUuCQnOYEbPYickkSD6wqsmfMdKd/bCjbhWNTUoDY/NobLbl4ESTb7j8p6lqiNdl0mtDd/Q==
X-Received: by 2002:a05:620a:228d:b0:787:3769:d747 with SMTP id o13-20020a05620a228d00b007873769d747mr2555320qkh.59.1709226462713;
        Thu, 29 Feb 2024 09:07:42 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id pj36-20020a05620a1da400b00787fd080d28sm697415qkn.74.2024.02.29.09.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:07:42 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>,
	Alex Radocea <alex@supernetworks.org>
Subject: [PATCH 3/5] p2putil: fix crash/remove side effect parsing adv service info
Date: Thu, 29 Feb 2024 09:07:32 -0800
Message-Id: <20240229170734.1498918-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229170734.1498918-1-prestwoj@gmail.com>
References: <20240229170734.1498918-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The input queue pointer was being initialized unconditionally so if
parsing fails the out pointer is still set after the queue is
destroyed. This causes a crash during cleanup.

Instead use a temporary pointer while parsing and only after parsing
has finished do we set the out pointer.

Reported-By: Alex Radocea <alex@supernetworks.org>
---
 src/p2putil.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/p2putil.c b/src/p2putil.c
index 5313b34c..faf151a5 100644
--- a/src/p2putil.c
+++ b/src/p2putil.c
@@ -541,7 +541,8 @@ static void p2p_clear_advertised_service_descriptor(void *data)
 static bool extract_p2p_advertised_service_info(const uint8_t *attr, size_t len,
 						void *data)
 {
-	struct l_queue **out = data;
+	struct l_queue **q = data;
+	struct l_queue *out = NULL;
 
 	while (len) {
 		struct p2p_advertised_service_descriptor *desc;
@@ -557,11 +558,11 @@ static bool extract_p2p_advertised_service_info(const uint8_t *attr, size_t len,
 		if (!l_utf8_validate((const char *) attr + 7, name_len, NULL))
 			goto error;
 
-		if (!*out)
-			*out = l_queue_new();
+		if (!out)
+			out = l_queue_new();
 
 		desc = l_new(struct p2p_advertised_service_descriptor, 1);
-		l_queue_push_tail(*out, desc);
+		l_queue_push_tail(out, desc);
 
 		desc->advertisement_id = l_get_le32(attr + 0);
 		desc->wsc_config_methods = l_get_be16(attr + 4);
@@ -572,10 +573,12 @@ static bool extract_p2p_advertised_service_info(const uint8_t *attr, size_t len,
 		len -= 7 + name_len;
 	}
 
+	*q = out;
+
 	return true;
 
 error:
-	l_queue_destroy(*out, p2p_clear_advertised_service_descriptor);
+	l_queue_destroy(out, p2p_clear_advertised_service_descriptor);
 	return false;
 }
 
-- 
2.34.1

