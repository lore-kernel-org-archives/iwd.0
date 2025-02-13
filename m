Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210524BC11
	for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477907; cv=none; b=Ivl36NJkc36YeOT4hvad7LyCubv+f7g81WGTBW/Gk+6yXtgb2P4O5x1VYjULaU4P3NU4+DmjIxlReMRwnbjxPCSQBwjP/ws1yPd0j+jH4WeKQXfg5olEwZdCifr/aoWq81zRmBrdOoZZcqvBVb1SJN1bBwUQCbML6vqkRTZgyc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477907; c=relaxed/simple;
	bh=SmDp/AtwyZaX+QYNLJpfT8SgFvWBptq86hr4LPtCP6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=txBb9vNO1cQmFxmhdHupBZITGaz2nzKNcr2ZisJnUJTnmAWxhpNo9bbIVq3ABulj+2gnY+Zv05v2aikRqHdp/NxJKCFFEXu2r0dfTNLQWzwFn17uiVzmZTx1rZgMLb/oUejSOlnyTz1K9wLCMrHA2QZlwE/Api+UE3/yifC1edI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsKrZ9i9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsKrZ9i9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f3c119fe6so31514865ad.0
        for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 12:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739477905; x=1740082705; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2J5CivVdq8MUSEFFn1kXe7VS21AwQII0bR9xpTJfhY=;
        b=RsKrZ9i9OvYnHvpZI6TsCnbk03ZH25seYYcZuR2fqM/tLrQSRktCg7sdPjn+1vVz9R
         bm7EjdHie8Bjo9B9/EW/0fKlsFbEQuRY3Hdtkyz0BSqrwxth2CaLAxCzkj6VyFi3aM+O
         xvUTyHb0bPVdOJjekvri68DET2v8tb51F4G3IaxcdbxNz9S22vsr613//30ZSUmdjRFP
         KMIKHPAm39XhNFnNDnUe+o8o54x3yZqsEfu/LxyGVJBus0B364+d2ETAcXHdyaOkceRe
         jH3LtOnW9saKNJbMVY90C0W+Nj6GGeRIKBjgmZ7eXABN3Qw97mYrhmGkieaQ4nURJwbF
         52Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739477905; x=1740082705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2J5CivVdq8MUSEFFn1kXe7VS21AwQII0bR9xpTJfhY=;
        b=kqKYNCzYkgxb8r/nizavekYEAJlu5bvCY9Tzf96C0OtTSVkD6rxtJm2BKOhpZ33/an
         xLFEc+/QQJA2vRwrJHGULzmjomPFd3zoJQp0JQKFpvFEaW/b3rsR2xI6OfQUy1fuNEbj
         MnRb4ieP0nO3MnzRltlySUxqAwMyW24YcTjQ7EZtKnX43fmvyX/89l0ieh9hzxdtl/8b
         uHJF+6wTLvE/vU/DM324UIGOVon1tcRcF8oZ6HomHMKoJ2LbQKTzafLzH4NjogO5634l
         rjwPUqGprlwA9GIxjVR5AiHS1IgIk1JIFK7WmJhITASgpwrGhsjMoWGH+xjvq6w1noTb
         UvNw==
X-Gm-Message-State: AOJu0Yzzlml8W1D4WO2MPifa9+bsiFz83OuSmGIC1RPVCVkDK/oyrDVz
	42IlytUAut11NpmEUFdHUTsXZUyI7hT3xJWu8JBNmbGlYMOEWduwkUT3ig==
X-Gm-Gg: ASbGnctJsAZJKQjC6/qbkEZdB09wOigFF1N6v56pOZ3Ye2JlntPzLVXYiVtx/OpHHI5
	CwmymnBJBhEUHnhgXEjy/fdd45fS5+XOrejq0ZGWGrtAXo+TIqgMyw2BgmHmzrKzq5NbCEDSDVM
	gGxI2OdXrY9IwGz/6CqJBsNXPxEWwe+8zvoRFY0m2NsxJ2/Ou0bWZ+OgPznJBTEebrb9r5iVn9q
	ti1MCiuX4DxL9hgF/VqnkpR6ta1ErZBZ4z99NpAaZIXuhRkNuC47fR+klqBmDuguXVQwWHwVrFh
	R5Au9uLrW5UBN0efb5jgmpWYRw==
X-Google-Smtp-Source: AGHT+IEJddIckqQp8MkIhn4XXN409YTdzjEMSYma+YY6mWaWrVAI+lsmqkGgE7WOJoH2sWRUDRWXEw==
X-Received: by 2002:a17:902:e54a:b0:216:32ea:c84b with SMTP id d9443c01a7336-220bbcc265bmr117285365ad.37.1739477905382;
        Thu, 13 Feb 2025 12:18:25 -0800 (PST)
Received: from localhost.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c814sm16419455ad.148.2025.02.13.12.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:18:24 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/5] netdev: remove/update some iwd_notice logs
Date: Thu, 13 Feb 2025 12:18:13 -0800
Message-Id: <20250213201816.230112-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213201816.230112-1-prestwoj@gmail.com>
References: <20250213201816.230112-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iwd_notice function was more meant for special purpose events
not general debug prints. For these error conditions we should be
using l_warn. For the informational "External Auth to SSID" log
we already print this information when connecting from station. In
addition there are logs when performing external auth so it should
be very obvious external auth is being used without this log.
---
 src/netdev.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index e0a39851..06282c2a 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -5524,23 +5524,18 @@ static void netdev_external_auth_event(struct l_genl_msg *msg,
 	}
 
 	if (action == NL80211_EXTERNAL_AUTH_ABORT) {
-		iwd_notice(IWD_NOTICE_CONNECT_INFO, "External Auth Aborted");
+		l_warn("External Auth Aborted");
 		goto error;
 	}
 
-	iwd_notice(IWD_NOTICE_CONNECT_INFO,
-			"External Auth to SSID: %s, bssid: "MAC,
-			util_ssid_to_utf8(ssid.iov_len, ssid.iov_base),
-			MAC_STR(bssid));
-
 	if (hs->ssid_len != ssid.iov_len ||
 			memcmp(hs->ssid, ssid.iov_base, hs->ssid_len)) {
-		iwd_notice(IWD_NOTICE_CONNECT_INFO, "Target SSID mismatch");
+		l_warn("Target SSID mismatch");
 		goto error;
 	}
 
 	if (memcmp(hs->aa, bssid, ETH_ALEN)) {
-		iwd_notice(IWD_NOTICE_CONNECT_INFO, "Target BSSID mismatch");
+		l_warn("Target BSSID mismatch");
 		goto error;
 	}
 
-- 
2.34.1

