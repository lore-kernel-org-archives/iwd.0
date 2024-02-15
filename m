Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D226132C20
	for <iwd@lists.linux.dev>; Thu, 15 Feb 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005210; cv=none; b=uv/ONP8ndVLNOpESvCszQFwvfYL9rnMR/Xu8aYKeTrJpLEiYAzRv/Opt3+kg6FVm2SxMxjb+rXeqxBqDtRL7/I9tq+FGkj8hAMxaebBZ7MMDXb42FVb8KA7QIZXYqS9b0fVUxKB+gWxefozKkcnGTcuyzYcGF3tUtqHilgarRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005210; c=relaxed/simple;
	bh=Z61jTqYf3mrqIoBl4vwh0fodGPv+kblLyeNMBdac2vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=egWrkdIFRo6W+/+W3PxmOQYstrPodtZXghfK23vuo3q56v0TsA7Acn9z+OMAw4poGYOaFwG8jrBSUq/+UeoJf1GaJPyn6IJlt3ht8NjUaRBQHcTMJkqlOp7Tto7quA6bP3z85P8wNiPt7EuhrLKiQFoPSvEZRWLosB+kIEUfOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRwjpcFt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRwjpcFt"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d73066880eso7729275ad.3
        for <iwd@lists.linux.dev>; Thu, 15 Feb 2024 05:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708005208; x=1708610008; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RxDxZNcWgZxObjqXsUDIT4GiaFdU7jw+jB2BudVupQ=;
        b=jRwjpcFt6PQ5FEEw5YXCO1i85x2eAojlugmN/Uw1ChDYhs5f6VfOCtBmH1MkcJmRtU
         XafMXA2QYHi3m3Su9++Z0C8IJZTEQ7WhTgyUYQTObt0Y7JFRsK/Bv+1HaASFHQzbpolo
         DA0wlayO3Q1u/pyaoImM6yfmKj23sexjCwWZwYoncRtxuslBGc1klcNjkVkT/YnbiHiK
         4I8WFeFYlsBQWVrrAiw2U3G8f/BX9cII6rW6O5Iw4AI8MO4JrwrC8snOLne/OgN4/hjL
         iKDBpw7pc9SM7oUqSBTzFYiSnTtFupLfz3QOUyIvhRcKhd8ewx05WvsZDMcl67g4tRm6
         mXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708005208; x=1708610008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RxDxZNcWgZxObjqXsUDIT4GiaFdU7jw+jB2BudVupQ=;
        b=K79vwpkKo72nTd3f0QDuHve7R0kTuyTXcR4LKOCAc7pLAjNj5Trrb34/DZkiZDyYQL
         2jf9BwIuDRDVAPP476KFbUZqDwznW/BCPpkvfwuMd/p4Dsog1GsCq/41dNfNU3BcoNgb
         JVJizl5RGQFn9tj45XiPbyRCMrQTys/OQNBwAyH97PDAMf9FPXlY5BDzCM4zwJFKdXMk
         EaAjbxcq4tZM5/lvQIcH3AFucp/mKMHnyu2efSMo3/JZPVngBd0STnMKPZPge6R2pZd5
         nT36CR3hzRxaegM2ESOKL97ojTGnz3WA7SCE47aI0URqtjMy4tHgZ7IifMyyzdVn7ITT
         i8yw==
X-Gm-Message-State: AOJu0YxBfB5JvBRUPDTABXSMry2lEv5YegGauC+RENeAymGRGKYxPcTK
	qs3Li/7cl4HlKkjnPxYm0rCVHH0jaGHPYXdvlGV8Q01fhLW+fHi1DzUffTq/d68=
X-Google-Smtp-Source: AGHT+IFX1LOnHz6D4VlNPGsecsDTB1ahkj86YUOBPJlIRBEsHrS5IKD3BnkHapaKXnGayBhb/QGAyA==
X-Received: by 2002:a17:902:c402:b0:1db:28bd:2949 with SMTP id k2-20020a170902c40200b001db28bd2949mr2401254plk.0.1708005208166;
        Thu, 15 Feb 2024 05:53:28 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001db55d2e1e1sm1284787plq.63.2024.02.15.05.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:53:27 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFCv2 3/5] doc: document use of l_log APIs
Date: Thu, 15 Feb 2024 05:53:12 -0800
Message-Id: <20240215135314.1017081-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215135314.1017081-1-prestwoj@gmail.com>
References: <20240215135314.1017081-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of l_notice in IWD some guidelines need to be
set for l_info, l_warn, l_error, l_debug and l_notice.
---
 doc/coding-style.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index bf0535c5..882de026 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -317,6 +317,21 @@ Functions that are static should not be forward-declared.  The only exception
 to this rule is if a circular dependency condition exists, and the forward
 declaration cannot be avoided.
 
+M18: Use appropriate logging levels
+===================================
+An appropriate log level should be used depending on the type of message
+being logged. Logging is done using the l_log APIs in ELL:
+
+l_error   An unexpected condition ocurred. These are generally fatal to the
+          current connection/protocol that is running but not generally to IWD's
+          overall operation.
+l_warn    An unexpected, but non-fatal condition ocurred
+l_notice  Should not be used directly. This log level is reserved for special
+          event type notifications which is handled by iwd_notice().
+l_info    Information that is expected during normal operation. l_info's use
+          should be very limited so non-debug logs are concise
+l_debug   General debugging. These can be used relatively freely but should
+          provide some piece of useful information.
 
 O1: Shorten the name
 ====================
-- 
2.34.1

