Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0AF17C64
	for <iwd@lists.linux.dev>; Mon,  5 Aug 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866851; cv=none; b=Y+tBeU5y82SxfZ8ScGSdgGx4fTnTS6CNB1cU+eJXvJ60WBERZ/7NV1vDFrQl1PxNV4yCJZJg4Ju/2AeRDqrr6YEFZe/f66261C9YrBmpobP8RJ2puZ+lqCCQ6XBAOjR6KA4l2hCMnR/p6KMMvPXL8k5QWD96AGEQLswEi70KYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866851; c=relaxed/simple;
	bh=W/rohdQsP4mnfhtpZXf+x07LZ5SCvwFToxTbKpiTwAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDF6i9cDGdf7vVDsyZm7zj2l9nWD3HrWKzLSm5NmBaADGHWRVezI2driCbI4XAZgNG9CyGeE6xbpvR3cW1ZFKhVOuDA3ulMO/A2gFPPfCm9fYhBxaKcknerV4NjG6ZZFtvQ7+yVARvdvFTaTgHfBo7pRPVra2SazjdSeCHxqGJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYWDBC8r; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYWDBC8r"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db1270da60so7436756b6e.2
        for <iwd@lists.linux.dev>; Mon, 05 Aug 2024 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722866849; x=1723471649; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDGPEknDCSEMiAEXT3w71++JkOVTA745cTtkDfXqG0Y=;
        b=kYWDBC8rZRGwugXnEwXmIJuk4gafFwK5IRjR2FBFtQy+BNy/oi/wfzkAt1h7QOhNp2
         BZRaAF9M1K4Vu0D6D0unxSjBO4P7krm87R67NmtHND3sS9PFLUHG+DPMsRiDxRHImSHq
         cZ7JFjTDpmaPceGS5LYrR7+Kqhe/Z6iTffkfOT9hKc+jxUYMMjPp29IqD6CbX869e/fV
         m3ummUU6ara51CltR4QMIUtpTAK5F2oLS18ma/2cgkVd3HGnmqtUzm1YsLZeKYZbF7Of
         rvY5dLuaZd1IahF9HjQM+uFIMinCvIpT5Xbz8VtQLnr6Mti8Riz7DxKQYiEhKRZ+vmja
         OCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722866849; x=1723471649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDGPEknDCSEMiAEXT3w71++JkOVTA745cTtkDfXqG0Y=;
        b=FtnhV9Qd/3YnHTcxH82MqFpKqBp8+vpUzm/v/AAtfRvlgCWFxl86Wl9vZCKy5GdWJt
         b+zV2e3DSzOmYOLdzwwfKxW0VXU7tyKmMooBjTlKChsys4QMjfITu/QxyAvUOHk9LNgs
         UkQ4MO13IFgSArW88NzzOIomJMhvma1MJ70MylNX+1Jf64+gKIbIvbY05OS7mNscWstm
         LDrb0D1Qy6aCvcFE3y81H/PUJ3XViiqVpqVB9HmGDj9dO6A3geWcifrr7sZJt9f2ITbb
         gIL1NK/DODSnjWB6fjt7KZ2LslJlUnJrglmXotWu8xYfN+RkueYP0olx1AKdoIEmHA85
         uWfg==
X-Gm-Message-State: AOJu0YyqM81ysDQ6wsuLglrkz2wevb2xyMJYSLkjC40rMWj/YrCqIutj
	h+iuXvD5GHS6fjR/F1Dmr+rUwp0xXA+AaZqUJRR5TmxgmXCWnAf/AoKtBQ==
X-Google-Smtp-Source: AGHT+IFehnW90Tc/7AWbP5P6Eym9bypuFBPtW7s2dIx8a0P3PyYGD2ljNlR9A6i7lH7rbrSyfSH1Sw==
X-Received: by 2002:a05:6808:1384:b0:3d9:3b17:f752 with SMTP id 5614622812f47-3db5581636emr16749201b6e.26.1722866849278;
        Mon, 05 Aug 2024 07:07:29 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db56361a88sm2654172b6e.4.2024.08.05.07.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:07:28 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 7/7] netdev: Simplify FILS handling in netdev_connect_common
Date: Mon,  5 Aug 2024 09:07:14 -0500
Message-ID: <20240805140721.57518-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805140721.57518-1-denkenz@gmail.com>
References: <20240805140721.57518-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/netdev.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index fb095fdca561..494e46a59de2 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3833,6 +3833,14 @@ static void netdev_connect_common(struct netdev *netdev,
 		goto build_cmd_connect;
 	}
 
+	if (IE_AKM_IS_FILS(hs->akm_suite)) {
+		netdev->ap = fils_sm_new(hs, netdev_fils_tx_authenticate,
+						netdev_fils_tx_associate,
+						netdev_get_oci,
+						netdev);
+		goto done;
+	}
+
 	if (nhs->type != CONNECTION_TYPE_SOFTMAC)
 		goto build_cmd_connect;
 
@@ -3855,15 +3863,6 @@ static void netdev_connect_common(struct netdev *netdev,
 		}
 
 		break;
-	case IE_RSN_AKM_SUITE_FILS_SHA256:
-	case IE_RSN_AKM_SUITE_FILS_SHA384:
-	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
-	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
-		netdev->ap = fils_sm_new(hs, netdev_fils_tx_authenticate,
-						netdev_fils_tx_associate,
-						netdev_get_oci,
-						netdev);
-		break;
 	default:
 build_cmd_connect:
 		cmd_connect = netdev_build_cmd_connect(netdev, hs, prev_bssid);
@@ -3876,6 +3875,7 @@ build_cmd_connect:
 		}
 	}
 
+done:
 	netdev->connect_cmd = cmd_connect;
 	netdev->event_filter = event_filter;
 	netdev->connect_cb = cb;
-- 
2.45.2

