Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C0517C64
	for <iwd@lists.linux.dev>; Mon,  5 Aug 2024 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866850; cv=none; b=Uy0H3Xhg0SCr2xNkevN3iAFYbDhhSBcRaFNvTb3igexx5oGdrUp/GKpkkN/Uy8rumMyIPLbHCqN6sJyDLDu7vCB8Vay4bp65gRJVidWEw9dOMrS2rtvLSvKHbj+tHFoHEZRNV/F/Bfh1v0VMYjN8AVPt98mGZMAeFFbk2Zdx5dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866850; c=relaxed/simple;
	bh=08NwWIRugipPWTC5orVbxFhQoTv/7mN/D42Srsxas7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBEMqhYPjSHJCT3UCAZouBvH4mdqeidD5gkzhDK5qeCWYamUTaBDJxjK5jehUwFTfExofmdYktXWlAdBVBwzoEinmu0aqIWMnm7dcX2NTTbO725GTsrX1Y3aKLyAECHnHoSN8f1xSy08Z7dHR/DQZ5OTWpG7Degr0gaGCm8/hJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyn2/V50; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyn2/V50"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db1eb76702so7047352b6e.0
        for <iwd@lists.linux.dev>; Mon, 05 Aug 2024 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722866847; x=1723471647; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYMeZRUnyBdT7UTunKDwAKh/1AFWOuXxNAZnCugPvbk=;
        b=eyn2/V50XJGKfDboKUuISHIfe/MMmHWPsKDzHXWDeyNotDD6X6pzIY9C1T9KNdahfY
         z+zcR4DPBfrP9MwDyt5coqMqzKM0lTBd83HOgEaEvZxIcki+3sZEN8qMHFm8KacIEj36
         kBKbdf6FooucVA2xH528cx+X1WQF/9/w4J1k9x2PfOCfeFtYx86JxQ5+sHhcVb21wX30
         tNr/OlGqBcgtW/rkRUjj8l8Wi53fr1+YARZGUafVPtomIHCkJkXtpscbOMbOyOuVgs6c
         u2aTPZ181MuTpbrZWVi+41EGRPKJYBMa0GCAiS+uky90Rti95OivBP0VD82u0vSU0etI
         dSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722866847; x=1723471647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYMeZRUnyBdT7UTunKDwAKh/1AFWOuXxNAZnCugPvbk=;
        b=uQQGUon5YC45acIAWEy1a4W0sn8mDmauR+vhWy7E9hhiAiXH3+13uvKW6Kd1vIXpMs
         Xw5xTD28SCl1OOuG53JJ5Typ/9T9GFc3V9mSCXShHCzX/iLquhUq2nei0Jm4N0n4RLpo
         zy6xggFLyap555czqT1f29ufBInbkLM1P863cRDf4WxgVMtVKscrjLFEUJbUJqQwIQ4T
         7TUNoJvzrKPdc2Mt6E+/gUKUnju9Z8sN5tkNrmpT6i6scV24gqRbcLKOqQLzZBZSmLCr
         0Y8wtfTSK5k/H6wZ2bimisdzyvFyeRVNS2DqtTPnM94t1lHXlz6DyGsHjVFBzk9Eqk/x
         eGsQ==
X-Gm-Message-State: AOJu0Yx5V+a+vgqxmotdyEMTyoZOjKiIVgz1VZBtJOdxL+Bk2ygzOuM5
	q2WLIVCsDokgah7pk4VpgSFM2kUryNyXCkXF97jBc2pwepyD9gV/+aSbIw==
X-Google-Smtp-Source: AGHT+IGJ6JF6iU++AlQ4oVZSQKQhGyNIWFc9TUf6gVftQOupIvQ6wPPK4vTds+YZf8tHHYDEYSgPqA==
X-Received: by 2002:a05:6808:1801:b0:3da:a793:f0d4 with SMTP id 5614622812f47-3db557fdfe5mr15784369b6e.4.1722866847346;
        Mon, 05 Aug 2024 07:07:27 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db56361a88sm2654172b6e.4.2024.08.05.07.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:07:27 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/7] netdev: Create owe_sm for fullmac connections
Date: Mon,  5 Aug 2024 09:07:12 -0500
Message-ID: <20240805140721.57518-5-denkenz@gmail.com>
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

Somehow this ability was lost in the refactoring.  OWE was intended to
be used on fullmac cards, but the state machine is only actually created
if the connection type ends up being softmac.

Fixes: 8b6ad5d3b9ec ("owe: netdev: refactor to remove OWE as an auth-proto")
---
 src/netdev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index e27a0019b7ea..50e60c5d0c98 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3826,6 +3826,12 @@ static void netdev_connect_common(struct netdev *netdev,
 	if (!is_rsn)
 		goto build_cmd_connect;
 
+	/* For OWE, always use the CMD_CONNECT path */
+	if (IE_AKM_IS_OWE(hs->akm_suite)) {
+		netdev->owe_sm = owe_sm_new(hs);
+		goto build_cmd_connect;
+	}
+
 	if (nhs->type != CONNECTION_TYPE_SOFTMAC)
 		goto build_cmd_connect;
 
@@ -3848,10 +3854,6 @@ static void netdev_connect_common(struct netdev *netdev,
 		}
 
 		break;
-	case IE_RSN_AKM_SUITE_OWE:
-		netdev->owe_sm = owe_sm_new(hs);
-
-		goto build_cmd_connect;
 	case IE_RSN_AKM_SUITE_FILS_SHA256:
 	case IE_RSN_AKM_SUITE_FILS_SHA384:
 	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
-- 
2.45.2

