Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A402135A1
	for <iwd@lists.linux.dev>; Wed, 12 Feb 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377450; cv=none; b=BJItTxtian0uwL+woEFOAK3WvYeaIHqYzJzqqeQQXrvb5H81msmUeyvUrWhSWA9GbVr5g1dSxvfsThClUxFeSkjcn3vZnkMVGOyrR1bNCxdy2ZMbXRoSeVQ+rhGhBxJe8fpZtJ1Ka83MoHI9cKqlTaiHmsmkf08u0Ryv68SiSoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377450; c=relaxed/simple;
	bh=SmDp/AtwyZaX+QYNLJpfT8SgFvWBptq86hr4LPtCP6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZLrhEKTPHr+UAArkt60mz9HBiHjUf85Ycgjvy6V981Z2VyS0ANgQSPm9Qxv+l2B1+0g2aTQwJxQsSf/g4ilAuH2QFUtrqMlVUdn/M2ymdH9jN+HcgLfn2exqFhnyp7ck+1ngqhYEAswZHJBQQU6R5neaR0EFewTgSC0GakPGTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWBYZxjB; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWBYZxjB"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be8efa231aso716508385a.2
        for <iwd@lists.linux.dev>; Wed, 12 Feb 2025 08:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739377447; x=1739982247; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2J5CivVdq8MUSEFFn1kXe7VS21AwQII0bR9xpTJfhY=;
        b=XWBYZxjBnQg4CVNVQ8SXjWYhABwkRf6Pg+5GgSdlFVI7+xcW0fVfuWQT1Pvn69ZEqV
         fhi4XQ4kWt6uDWldK//x4AgOI0nnJJ6Y6vJcasbijiHkYHmUke0E+bd4lZuxJrEhhCpN
         n9Fvr2dCeBgv20kmB7brIlf1JtaoT3tQLTsCIcnVOznGto4C4v5IAjI5ev4HTrt4vbVj
         ZGbtZ1RAD3wNj3X1kM8P8+MLtRHkhnHdmD/vQx7967RvVOYZKF50/Jqeok2vzP+uByGr
         vpXkA5LO15lW/4fY5kG1crQ0jm8mWvbOEFkqfqxznpXIDFyiInYF+5wwmAQIJ9Vb5pB1
         /qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739377447; x=1739982247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2J5CivVdq8MUSEFFn1kXe7VS21AwQII0bR9xpTJfhY=;
        b=qHjUoVr09YFd7arEK+y/uIwBxRAcBCHYODYtKMURAJ/DKO9RFdlGjrIl0rUJFzHPqJ
         LDin1MHiFZfUTEV0qPZy4fsTquZqjOfGfoOfLAhfsewLU+e5dM0AVQPpXBSk4C/tk7mz
         6WifX9Lj37cboAKIlwQipqeH8eKIsaybcFAutdFbKBIKwR978+/rZAbxd/OK4XCYLckr
         e5jwrzOgq00MDN5DeD/z50FLSFzdkcIElPxWoua1sIvPPaux2565SPpMbrMReONlIEui
         zyJ8FciyrkPIWizNxjH+zeLjykuSMksNYUBUOjDmQoKxtMiHm8OqhsdqTE8zSqrxihfN
         W6Cg==
X-Gm-Message-State: AOJu0YxMMerKl+KYqa2W6lsCXhmyrxJ6tSxpFmlWZYDZEoE4fGh+Clgl
	dwJ8lUZTttClyn0Wl5KhUK0khYyOjqhrA9QECggo26RFjEOPEjkesV5irA==
X-Gm-Gg: ASbGnctk7C0FkXl9SToHA8Ft3Pq++kkSViCmVeURAF1uU+at+CqOfEXYKLpRqVzi+tG
	E+O6aUmY6aVVIBm/Cf7zrCqBIyXclYCtw1KMwKUthCI4eibb/oWsH/yBqEQv1em3zqNDyhjfmcH
	/7P7YEvHfwlHq9dr+5LEu8LpjXIe6isHxGelx2wu7FPz9aMagLD14MyZRq9/Y+sWq92GkRVgTPn
	q99sXt3T8Zn3XuFJTZgtb/cs8IKu8R0QjdaoMir0tov7TatLuayLsl3180HpebicYAcJZrmJ4AL
	vOxAWWcAZdpSuM6YZNO46g0oxIjuk8wKk/n1g0w7MyyeMRDIzA==
X-Google-Smtp-Source: AGHT+IE2eF7a0XKQCQNJEWmferPOUQZpPAYCgzszD2s8Ll+X3Y6BXnA2hqCbQgXjRaPWdI1fg1j4MA==
X-Received: by 2002:a05:620a:4612:b0:7b6:d28b:42a4 with SMTP id af79cd13be357-7c06fc69b03mr600049685a.19.1739377447583;
        Wed, 12 Feb 2025 08:24:07 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0768e23casm73272685a.44.2025.02.12.08.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:24:07 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] netdev: remove/update some iwd_notice logs
Date: Wed, 12 Feb 2025 08:23:59 -0800
Message-Id: <20250212162401.130792-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212162401.130792-1-prestwoj@gmail.com>
References: <20250212162401.130792-1-prestwoj@gmail.com>
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

