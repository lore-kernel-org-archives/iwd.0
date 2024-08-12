Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4328121B
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477582; cv=none; b=k+EMRkRpFNXzkAb/SB+fzCLGb77RL7yHvGcbT+q6bCWFhjezqga7pwk3IURn56E6JwoTuTbsmajjetUFYPLY4Kg6MRsJpjkQevYPh0luQfVXlEn78gvyfwr9qvre20JKjvKvISuDCmaRgFoD9GHvexmxaxyS5u4Kn1fhjw4hc4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477582; c=relaxed/simple;
	bh=N5ktHp55FAxev4Fe93AiflrA9E2h1tg4Y823bSvYpR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yb5/K7oU1yhl4TyV8+VxJLnoX/VPnE+IMX5wxoM1BgCn+dugHJiAh3R4m3PI7jNkHN7ZRX/gTDO2YA4c9eZjVyf3nCuHtVXKujdpNn/MzT6nQeDdaDvjbWLmTO8GuMB+SJVruEw2+1Oag4yWmfNTnMFokd/ZSr9fwi5HjZRSJio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT2rVbg5; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT2rVbg5"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so5116299a12.2
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 08:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477579; x=1724082379; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCM7mUQWtupCxt63H0cxJM+Qx+Ka5rFi9XYM48vSNfw=;
        b=UT2rVbg54191PDDcSzPxsPGSwCveF3d4xD5GgV5uQzaK4FwfSviMSGGrPvX2JAYHRV
         GzFvgVi004fGcaNHgqIoJzqEKw4bkj5/3Y398KfMP7Xqh+JldzUdfwYovpn/3I7hXbxn
         jFZRGHGB5VPPbC+oG7zcrCfR+2gqYNxG4KobYX3VIRa4MiNL24IZ8u0zerm1HQhcwUxp
         fAbQ5ifa28Kea78AgFifk0Y4LpZlSsMKhIwFUugQIdPpDTL2bxhgiMeup8o5VRwEGvmh
         B4WTYu1fugDDVmUURmjdsju46m4kCurNnl541PorYzFWL7FjJj14xBobWYFAMuP1U4k7
         sCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477579; x=1724082379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCM7mUQWtupCxt63H0cxJM+Qx+Ka5rFi9XYM48vSNfw=;
        b=gFCCtWZodJg96rn64quzNE3JteCX7isix8IE1Q/y8x4w/UxBg2Vyj/rLJpeOHK1s4M
         oxQob/AMCZMDLmcDc3WPIOuPtsLSPj0mVn7wdCz7AXC6oeeP8vSR4J+yRDc6xtKAPA14
         8GfeIMnA49V2VXLyZbDXcfJfFYPFEe/X+MmfpQFcmuVucmXrIN7J9NKDJ1c1g0QOTkfU
         SMAMAlAB6gR6G8LoQfbCIbq1TyB4V2zD7zwIHWpHwV6Bf8ke+O/5z4cLsv9OmEvJ1fbY
         YPz+dTk8vPrtnIOWYPyteVNI7BOsyTMrFOtPU52Q6wvRszinpRLS4FQADvBE/S96JhF4
         XBgg==
X-Gm-Message-State: AOJu0Yx8oTARY1ZqoWnkury1v5ot432ptyTGdqUO39sTomZg8f809BjA
	bDJd3zk6fQp/KNQ/lCSXET+VpS0J2eNfqAm4hdvUqTezexhuitD+0Kijwg==
X-Google-Smtp-Source: AGHT+IGxoYI72WfASQkCYd7kn/PpWzhTUMJVEhwB7PfoyE8UdkKhXh7ZvyrPKXgCIZLQjQvKz6otQA==
X-Received: by 2002:a05:6402:35d6:b0:5af:51d6:d8e with SMTP id 4fb4d7f45d1cf-5bd44c44291mr639487a12.20.1723477579039;
        Mon, 12 Aug 2024 08:46:19 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190adb45sm2224931a12.32.2024.08.12.08.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:46:18 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 01/13] dbus: Add net.connman.iwd.BasicServiceSet interface
Date: Mon, 12 Aug 2024 08:46:01 -0700
Message-Id: <20240812154613.126522-1-prestwoj@gmail.com>
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

