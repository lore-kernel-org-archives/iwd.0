Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8FF13D8A3
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138961; cv=none; b=ks3AqJFdLj10pCr1GBBik8Yr7n4Eit4FhtYw+M5a306ALMqjvevpf59roglC7vzBxSATpS+EIBEKyN9Z+Y97cu7FjFH2cLeW/GbwUb8Rp950y3XZOMjr0ifaXLwK0zhJQtRcdMEHfmFXK70X+NrrlS+Snv6fe1yTVsB+8xPVRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138961; c=relaxed/simple;
	bh=N5ktHp55FAxev4Fe93AiflrA9E2h1tg4Y823bSvYpR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fdglYvQ2549Q3xDdSTis842WRRUFvhZ+pULAoNEHwpMYQjS+iW5oqgt2HeqswCGERXE42vx0vbkgYF9tAIzq0xPOYs2dZ4T6hzuWjj6rOvdELC1SuTmIEzCSqJVDhhezz4ZEF7z5Y/UBXyWRsOenyewpbWHrku0NAkNjanTvLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShMmAW4V; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShMmAW4V"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd9e70b592so10727335ad.3
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723138959; x=1723743759; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCM7mUQWtupCxt63H0cxJM+Qx+Ka5rFi9XYM48vSNfw=;
        b=ShMmAW4VEQxWuiW8LSfhVhe2Og7lMETp2XpPdx388rOotHUm70MnEAzzeVSIK4W+Y3
         wImAJxTJZ1tadWnQYRSQUWN5f45deHe3HmBF8fGMsp1WbZWR8A9mHEVD8ShG49SmI9CA
         PVNbow7HGKhLJzsLu6vJ1+E8tFHnNPIlp9ydZuQNa423ixKslaXsX7XAlhVC3q5BF3y2
         q0FOCWx4HbMBw2/YXoqRrqlPZeC96bKwt8a9Vp84T28b6EPq+Hr79qwDOf3R8zZf7jEc
         uc6tbjLlRE5qT4hANYaCClc9xWHcRcH8IxUbW/BCTimI5bp5xC9n3hJggMtOfT1VmCcc
         QzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138959; x=1723743759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCM7mUQWtupCxt63H0cxJM+Qx+Ka5rFi9XYM48vSNfw=;
        b=BB7Zs1tJ8LADp1Nc45MxMj4TWC/pr0IBGgRtAbeD+LOwlGTyCo5O0jhpLYPsEv8lgG
         holj8J1Eq9LvtPlVVgFbakkS8dxZsKQbTXoD4/w9tbP1cZWF8DKFeWRwSwkf/LSwQFQ+
         eWEdYE7mBaqG6U/lBru/H9Stl3mzJLUh5st0zipGQpDdVdWKKOrN0HRMTmOk7Z2HBbzc
         YHpeD9tO2TyYuNR1T+Oxgfm2ddHJSTVdiWeARw9cIUZV/M+PBp/SEGh/LQ/jhHCEkOQd
         8pienPnCsbmdJPaOv7mO8H/o6ylYpt1aQvEEXA1cGIQckYlL+MtMXytjBKvbyc1De1cT
         DmXA==
X-Gm-Message-State: AOJu0YzgOUB+VTks6bRUYLIEhINHxFGZJDoB2hTOxVEIEVECf5CWQNZz
	icvjz9jxVa/wXYWWCMTPTClmol4CrYqWrwrptP2kaZ1QMAGWzUcSXFGaAA==
X-Google-Smtp-Source: AGHT+IHy3FZXNWvKGpdVl7d+UV7r6YPMCyRCJ8GMFND0OOdpE15168BwD3aJXhrMuq+QhPNVLen4zA==
X-Received: by 2002:a17:902:d4c1:b0:1fd:9e88:e4d1 with SMTP id d9443c01a7336-20095391c14mr30425095ad.51.1723138958979;
        Thu, 08 Aug 2024 10:42:38 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53435sm127478355ad.64.2024.08.08.10.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:42:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 01/13] dbus: Add net.connman.iwd.BasicServiceSet interface
Date: Thu,  8 Aug 2024 10:42:24 -0700
Message-Id: <20240808174236.218750-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/dbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/dbus.h b/src/dbus.h
index b43412d7..14814b5d 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -48,6 +48,7 @@
 #define IWD_NETCONFIG_AGENT_INTERFACE \
 	"net.connman.iwd.NetworkConfigurationAgent"
 #define IWD_SHARED_CODE_AGENT_INTERFACE "net.connman.iwd.SharedCodeAgent"
+#define IWD_BSS_INTERFACE "net.connman.iwd.BasicServiceSet"
 
 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
-- 
2.34.1

