Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5BE14C5B1
	for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615508; cv=none; b=PDfJ8wDfdhVW9XK3L7DspQjs94Uj3vMt4p3eY6vUb6mSlHiqZBPGhWV5Fa9sW+phLimW0g+t7cJ3CuKJzj63GrbDz8uairFvO0UBJBIpE0eLmOU4fP3RIIgFKUh+BGciIh+agpQLhjkig5jI7f6VnPgMY+A+rt5pC9pdWrirMLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615508; c=relaxed/simple;
	bh=Z61jTqYf3mrqIoBl4vwh0fodGPv+kblLyeNMBdac2vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CKfFrHUUjRcL3iYyUKN9+a9As8QxxR13dm9AHJG7v4L1f/qVcqAMibIQlwO5DiqUJdq3/BE0K33xL/2NxJ2CVBPG+zjcngePhdtulBX/sGUuD7XUMy6Y8ZwYNSfE8yD1WZvCaI8jNrkte0zJ3/IV2ERDxvKQRN+cjC04KP0xTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWkJb/cX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWkJb/cX"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dca1efad59so7231548a12.2
        for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 07:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708615506; x=1709220306; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RxDxZNcWgZxObjqXsUDIT4GiaFdU7jw+jB2BudVupQ=;
        b=cWkJb/cXf57O6iP6hY3Gt1nSB97RWNOJe4tWWS/DFJDoozHnNC57w+DAv1JgKs4Ar1
         Sw9hWCwaRYi8ksPetVY8ceoPOFfTwIaizJ3QpzXfQAcAJuOWsDuTSbXcEYvEjRoatba+
         MQgm3o3i/QOMHkNh8ZsZ8iYRszELP9NDNnkm3mgnC/wfDVhwZVZIZzvOVPUqSIQ/xr1e
         O27XPJShj7eeQQRX2f3FQ6WTkL4jgnJ1d/CODtpkGfMizqKAOWXZqGkeWtec0h0xOSSM
         /9IETZVpfg0VQePFq7IEZQOzSrFeRC5omCAGcfcy6BNXmz32ZHysHM1nznke4Hf1WCpN
         szpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615506; x=1709220306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RxDxZNcWgZxObjqXsUDIT4GiaFdU7jw+jB2BudVupQ=;
        b=KyHU9TgWUKEE0DAMxiFkAy44mhhEwdQyFmVx+TS7O5KqgMUbNSLH2lvS79L4TPJ7Vc
         Ho8g657lqh+Pb6rWL24HzEXtlmg3WvRfDdIVvWA9kO9jqmdvNKbpaXxsZsUMR4NOaz23
         zToFWixqK/ntYH1MINrffD41c2r85q23dPjHFt2fB8HJsZQ7ywOgt0BfwSmZLA8af7s8
         5Z/GSwyzGhVEJiFmaxFobFAsLv9lB4b7kRrJfsSf5hxRna3wZQ2MkAUBRca/IM6VztZq
         kSLL6pVHFPg5n5+iyMKtoegi/O9DCfGdvcCIYzAS8zJ9MIMkE4MWVmHD9hDQZutYgKGH
         1Hug==
X-Gm-Message-State: AOJu0YxLryNC9FenG6TaDsBsiO2MvCDP/3+MOB41lp1HMit/BFBYpx7q
	NqKg51EyxEpvq20rVyRbz8e2WTF+ljczGus8vrbjQyEmrHiF3tybL8nfOR2H
X-Google-Smtp-Source: AGHT+IHo1bksQWoljLl3/SrYEuRKS47T0XOeWj8UJ5hubtnyBvr/syezsHAEgZusj3Dd+jY1sDo4bQ==
X-Received: by 2002:a05:6a21:164e:b0:19e:a1a2:4c53 with SMTP id no14-20020a056a21164e00b0019ea1a24c53mr2360557pzb.1.1708615506097;
        Thu, 22 Feb 2024 07:25:06 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jd20-20020a170903261400b001d94a3f3987sm10044873plb.184.2024.02.22.07.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:25:05 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/7] doc: document use of l_log APIs
Date: Thu, 22 Feb 2024 07:24:49 -0800
Message-Id: <20240222152451.1541682-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222152451.1541682-1-prestwoj@gmail.com>
References: <20240222152451.1541682-1-prestwoj@gmail.com>
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

