Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D26418892E
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429934; cv=none; b=crAFNxDgiuB0Bsz0rk8FYi6MSOmpkZL0c1jfX6N+BGdgLE3MElPuIt+ebabvGSFricKRciIOytRqgV39qjYLRXFTdRpppjZKPNGrcbmLOPn+FBZzRP6qhPvcivV68j8iNQZpgxRJyOjKzvyZlZopdhaAKJh4l1uDpM8coQ+Ossk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429934; c=relaxed/simple;
	bh=k+gwELWhCl2tT5Z+M/ozsYvIRtZ3jrG9Nmu1ZtXjmRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8b7ggNgt6VaTwelC4e/14NPZcbRwZiPKeE/GhJHEXs6gMou8WwyjC+un04+IXXYPjeJAtwm+0WN+Wi027dd8UEKqLAvrqd/enu0cQIzIEe/bHJvZztDH0lblCn7+3quaL7qP5Z2eWVHQRva41Ghet/9qnTODCnozXe1fAQUFi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MskGkle/; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MskGkle/"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7095bfd6346so2007126a34.0
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724429932; x=1725034732; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxemUu+2Rm9/aUBJQkgXC98PFHj3e83BRDwwcfPNjMA=;
        b=MskGkle/+6Qbx/YHflQvONpaeB8SxZnL7t5nSv6DQBiZlS6MJ9RlQzo/C5xAD5I1UW
         kLd/Um+wa79zx2uW0udXsFl0PktKZ+xtQYWIvN9EOIjo6UAcRurUHdRODugD3RyAfeJz
         uChDh0prDkuk1C7gV6fy6dkxVu9u4rII0PdtyXFBZtX/Hkv/EaMmirfv0NtCd/KP6Xso
         vzJmI58dBS+Rxm2DSkdqT8x4Y0EpgJwevKvPA/14F8ixCh4QZf/i7pxy9Upa7sRlW76a
         dks/Vajrpqzi/LSzGdXp7aFyqM5ON0wD/nHASz0rzrPuk+hnvUj9Mr+ezDDOY4dBIhrO
         +zXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429932; x=1725034732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxemUu+2Rm9/aUBJQkgXC98PFHj3e83BRDwwcfPNjMA=;
        b=u/tEQI8hB+/18nLF0PLThULnW5P7ICDP+maxxGQSKbXWBYuIRXqLNHmiZt5+fWMf6e
         0cfyvkEIN2UD0s0InzkcyoLyVOCYf+rzTpi4E3BsqUYdgk9gZGyywlMPsYvAhCN0E+V2
         0/gCLwFkSVhTLVs2XILB/lkwXbZFg1b3a1SHjJDv+2YUushxpaanqeyjRbIsWPYjyrbu
         k74mDvCeLc1AyZtQcos6G9oSfeW4EZcZ016dHebIfRvoE99NTLR7gwnaaXN/4G9keXHp
         8GQBj+MxaawLYr2XztxJoffHw35xMlDMDKvPzwaIPmnU0xl7L3F3UiK8Lk9Lurb5Ajcw
         3xcA==
X-Gm-Message-State: AOJu0YyPweZmFVyCJqJKVpFWYNTgwMTsn3phfMsZv+oOZCDp2GxHNcfi
	7AftY3uAmMxXEqt61TjVm/36wYsVKvXRETFNosXSyxl2NCku14EsV0B3xw==
X-Google-Smtp-Source: AGHT+IE2hsCkxxyRMjmiw0CnVfVRkWYK+ZEL5jModQoTbsoAoryrZlJbWEZ/fcLmPCQQ4QUiYXfp/A==
X-Received: by 2002:a05:6808:1914:b0:3d5:65d5:edae with SMTP id 5614622812f47-3de2a8a0828mr3242717b6e.27.1724429932109;
        Fri, 23 Aug 2024 09:18:52 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2256f44asm764507b6e.31.2024.08.23.09.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:18:51 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/5] monitor: Don't skip genl control Done,Error messages
Date: Fri, 23 Aug 2024 11:18:31 -0500
Message-ID: <20240823161848.485685-3-denkenz@gmail.com>
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

---
 monitor/nlmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index f0ffff90b1d7..f7b0f9a14aa6 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -8312,7 +8312,8 @@ void nlmon_print_genl(struct nlmon *nlmon, const struct timeval *tv,
 			continue;
 		}
 
-		if (!nlmon->read && nlmsg->nlmsg_type != nlmon->id)
+		if (nlmsg->nlmsg_type >= NLMSG_MIN_TYPE && !nlmon->read &&
+				nlmsg->nlmsg_type != nlmon->id)
 			continue;
 
 		nlmon_message(nlmon, tv, nlmsg);
-- 
2.45.2

