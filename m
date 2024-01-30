Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000647AE51
	for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642038; cv=none; b=p7BLCYwJR9hmSpYt9HJ/CQtTOACh+bgAV61+vwd4Bcza9ojdM7XBmgn7TiVYJZT87YeTk9Ovx18QW8lO0doYtQmDOTxInFEbYKMFYHalGOX2IVlTeNFysSbLd8YWx4kegDT1vTNW31WKhI8ee9qfKrjFAihVRX9bMg0KJuRlus8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642038; c=relaxed/simple;
	bh=3IxaLm2u6Z+ocCVTpENV0mujBYA/bNS90YYEOFeSy7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c+XAMbTlVkkDfcdfrs+ZEWf1A18xm80MpAKYU2DE6kZBIcZTOGjxUNCVvIrVw1+dRqwYxBZSsw0SCoMCn89uZq75Vx64QTCN5GKSVUW6S32xwpTBvE/LmmzcdADKoI7G2aF2bUbNC2zKtQlm72hw1SsCNfwsuzpuHktGn9EC4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyL+mTfV; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyL+mTfV"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42a446cb1baso34192661cf.0
        for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 11:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706642035; x=1707246835; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5uVhvahCJ9APPpCmy5D1hXtKdmZPLwpKL/UrI8WUL7s=;
        b=cyL+mTfVk8BKI9FDEMzMx5ebVwJPjE5o3DcpDTbOrtysPd1d+AzxLfpXUZWRplw8z5
         WTFc0ul9g2BQ42nriLWIcqQSe4eLuYLiDZSS3vwtE8XHiAnLhE9LePvcj605Lq2Z5GOW
         yhmkyG4mez1gRkr9bhvLsr/a8bMPzqzHqyyqS/3NtaUSQ13JVFrotxIKLDwbgq3RIyYi
         H9zWX9YDlS3dkiWag19TEsAWBwe5s6f1w7E6D8HR16a5Tpl8WsRmwrZmPm8snByVcNwJ
         vJQIT5byVJwVSnG+6RlRurnBSBPEPsK2f4gRtmKvamxpG20KMs5UYXI9tGZh8EG4RRqN
         TTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706642035; x=1707246835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5uVhvahCJ9APPpCmy5D1hXtKdmZPLwpKL/UrI8WUL7s=;
        b=cY5TW8A/Wc4lVCbmo8No+/oDxjpo/YKY9tP45Vsv8TJZ2u0aWPOpm+pXVBB1CZgd7X
         b+UC3/7cghCJ20Qi5HEvBeuYhzIX6ZHHDrixNfqOxHqXNXKrlHrNSE94bAz6GcM/EKrV
         u5zXndm11qtfg9aRxyQ5EkMbNSaVFcbelJRBBH8CUXu6dzxxklqLkxRmA+mHJO5CXoEy
         6tnqDYSm9JSozWw5AAK6eNDI4fxsJJNXqCbxVcOMiOOoBTYDrsgyUo6Vt4GxIg9LRL9m
         qAwaeQAw1hbk3neXdobXAnYtRMIeyqtgLmU7LFl+W/80y7EYJZoBWmvsgr2cDCABbxqY
         a71A==
X-Gm-Message-State: AOJu0Yx/Gc1vJJA+6OhVNEjtuJO+hC6spX5xmiAYAQyr2G9WUAhyvv4y
	VIB9CrLglDzJAq6REFBPa5rwJF+91ar0InbuQsiKA+ULzTbD/8NrVQKU8gU2Xg4=
X-Google-Smtp-Source: AGHT+IGmgVzLo+EZI90vMiGjn99pv9SRu5/AMH0EueyHHskYgfua+Z5MRNWwXDCNG2BzYmcNbOyI8g==
X-Received: by 2002:a05:622a:1a26:b0:42a:33fa:4365 with SMTP id f38-20020a05622a1a2600b0042a33fa4365mr9922692qtb.28.1706642035518;
        Tue, 30 Jan 2024 11:13:55 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id ie7-20020a05622a698700b00427fabefe3bsm4716110qtb.52.2024.01.30.11.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:13:55 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] netdev: fix setting a uint8_t with l_get_le16
Date: Tue, 30 Jan 2024 11:13:50 -0800
Message-Id: <20240130191352.85852-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 522baf7a..f62a97cf 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4734,7 +4734,7 @@ static void netdev_unprot_disconnect_event(struct l_genl_msg *msg,
 	uint16_t type;
 	uint16_t len;
 	const void *data;
-	uint8_t reason_code;
+	uint16_t reason_code;
 
 	if (!netdev->connected)
 		return;
-- 
2.34.1

