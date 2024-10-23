Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7FE6F2F2
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704192; cv=none; b=t+O8oNkExqYkMlum4183JrPMb9JnitZKqgDP4ETdAbsQbEeT/pQEDF3UbGdn01GWv9sVLTO3qj2jDMR8GS9Mo9mSxFwNuwUqq0lBIyPMpWPBF/wIcsNGn4yZY9eUauflIxvOkjlKUHDftyns/hC1e4lYT1sDiKaGQ89SIEkiuMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704192; c=relaxed/simple;
	bh=fy9saxEeOdAc2Inw7MDy0DT5tM/z2T3Vhe4JotQlYac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J160ACYxHqV4AkU+MfoQcC0pWCHE2hHxpPWB+xpVhe/jSX15Emo9QWApFtPSW14KybHnldPT39eqRMMr4tj4Lxzr5RLXdbndNaZWaOw4KeXT74crXjeTpDC7iD/B0IjmE0g/QUL8AGeHv7HHBLp2qsSQR2puD7jW6pfsXMo1Wtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2BmmJDL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2BmmJDL"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so842909b3a.1
        for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729704190; x=1730308990; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cleyCgLZFebwLrA8Z5Cn7hfeGHhF6AVUO0c6mbLoWI=;
        b=D2BmmJDL45oeriV/hENlcyIGuXjOd6TRqRdTQOCPwjFMF703HYomdVv8hSYGGYkmPy
         8zhrEfUWyIKlavRezSk0AJOmW42trodd+PZi23kTVWKvaBgffs6v6DpAxZJD1nm/IW79
         3C48667ui8QhRXdJhpPz3jbE1tBjW3mtvOHXC2Ohf17Bd1TViShq87BMvEl6yMO4wYeV
         tpi5I6fFzYQGLWCEHleKC13wfS0LtwUSTNXHCDJVIWBtsOBtZ6tZeYLVtfsRELHtaLHv
         K7yb85ky2KMeRLJ8F2+xWZe6FkY6nMrvQqXh3zSk16v/jN65k6SVaCIzaZBZa3lgQK0L
         eo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704190; x=1730308990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cleyCgLZFebwLrA8Z5Cn7hfeGHhF6AVUO0c6mbLoWI=;
        b=cpplHC/b2D7m09+vdxCfCTzJ8v4VN5U3ZgyGPYSRzFzMTELf+/xZCj3RceZRoAUdr6
         eDjt4bR9TsUdynNVy0NXWjSA82SFpH8ungACaQ7urwU9ncdoLh08za2b4ELgRrUyQGIq
         st0TVD8p72gmsIcSDpHHvjbgn45c8j1bAWFvR5vbfJSTNX0hWAH4+YepI+5Wkzxxlzg5
         3xkEw9bAklNX95jlrS9OqHiqs60IlrqT7FpR7vPWdvdILQpBhibbabc/YegD97dNdcpX
         FZRNHJxWjMDFFXwZKSf93tbfQiX1zpKpJCM9LxfHHSI7pXO1BjbbiHUPRGraGOTzge74
         wbEA==
X-Gm-Message-State: AOJu0YwS0VxDVz4nvMeLUGyDKxWiSI+/x9bYGFRWgHgYosIAUCcR/y7s
	XJMOz3NWFDAKca7nPwv6bVkMaC8LXZ4uMZ3zxCnCKzEG9qifF0ndYVhF7Olu
X-Google-Smtp-Source: AGHT+IGmIO3fFFU0UujOs+igjvRutQFA6Upury9LZTYCcTee70oKABePCLsId01NJbmQe9CbFvfZZA==
X-Received: by 2002:a05:6a00:1912:b0:71e:6a57:7288 with SMTP id d2e1a72fcca58-72030f7aed9mr4989394b3a.5.1729704189877;
        Wed, 23 Oct 2024 10:23:09 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1407ed7sm6551923b3a.214.2024.10.23.10.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:23:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] network: don't allow connection to OWE AKM if disabled
Date: Wed, 23 Oct 2024 10:22:55 -0700
Message-Id: <20241023172257.112771-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023172257.112771-1-prestwoj@gmail.com>
References: <20241023172257.112771-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/network.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/network.c b/src/network.c
index 20d9a3dd..5a856fb4 100644
--- a/src/network.c
+++ b/src/network.c
@@ -911,6 +911,9 @@ int network_can_connect_bss(struct network *network, const struct scan_bss *bss)
 		return ret;
 	}
 
+	if (IE_AKM_IS_OWE(rsn.akm_suites) && wiphy_owe_disabled(wiphy))
+		return -EPERM;
+
 	if (!config || !config->have_transition_disable) {
 		if (band == BAND_FREQ_6_GHZ)
 			goto mfp_no_tkip;
-- 
2.34.1

