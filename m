Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F881CEAAD
	for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026286; cv=none; b=St9XktzWOT0kkJMuOhCDLEbYMVQBOD/DZXjFPSDYsdL0HqRoILpS5k/CGDg8VM9yZWGbeMfsEIu9TAVC6m9i/2jBtiLjWuPiUdxfyFxnzFTNa7SERaIcjjzvvk/hMpY9OEvP7651HsKzQByfmkvCVXI+AiE0RnvNm3Su3rNbI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026286; c=relaxed/simple;
	bh=LwEVLfS2Zgtl3T0c0/6s6OUulpDSBn/Ul29Tao/WAYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjnMyT3ES+XBNHjTCO8i0PKwxobv/YPgR79gLgr6gKFK01qJmNRr0rqSgJdnXdJtGLAvp5k9ZJb6XUiLO1NVpwq9vinaoR200bLkRsHSUl17jGYhhLkoo/FNPE2NIwSMkrs2NUeyU2ESiPlkD/pua76UYlOecx9mpMwfAXAsdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fD1nM2zI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD1nM2zI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21210fe8775so17845885ad.1
        for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 06:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732026284; x=1732631084; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnHGTCf84UiDJjUmmi/RmJj8DCbIN3s3GUZzCblpgyU=;
        b=fD1nM2zIkCwY/KNl+s3g1VIapjTcn/aDWH/RcvAPhmjTjgwJdWyGeZ4h4Nit9Oznai
         CCJY4p8ForTzABj7DcKKYDycSP9RBm+WlG7tys/oc4/DZhnLvzh9xiTDPdEkx8QPjDEZ
         P5kQ4RzGefFjsEyNCNIyG3eYjhJUpXTk6nK6aSEiz22HAMrxjhflT/m/6SpxeYoTnco0
         baxfLzbRNiiZVTZ76fN67Yu4ZVU1y6sHXuG/KWqegGrdzJ0LG7PgVvP4UQYI6rPY9YFY
         meR2uRJch5LzWtmwf2ccZXj56Xnv1swGwFOPDN4+Q8Ellf0VflpnG4+Id0mDX5OZbuLQ
         dkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026284; x=1732631084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnHGTCf84UiDJjUmmi/RmJj8DCbIN3s3GUZzCblpgyU=;
        b=fuweWWXgQGQ/o4aFA2TkwXJpOVWEpSYgJdAAltZbuQCQu7aB5vFyvWBoh8lWAleUPC
         JnaiI2DD8BjBHjL4mF4TD967IykZrHecCQZiFsLnsr9XSK+52zilttC0c08lIxJnemxA
         nBDrVirKiGN0OrdpyJpO9tP7CiwO6yVfl9DCKBni/+REBd268PTZglyU8ugH9zzJQN9p
         xHVwS3pMWRzYHu8+bvUZgghWfkDvC7xJ9HMES+/ULyx7QiG4SPFYiodk9jwbpdgVwC2G
         UDaTJgeRz1u9BrwuBPg44GCrIB0VRBgoVyl3syehN61fAs+dqCPKtiDDJ+ZPrpsfmodh
         6rNQ==
X-Gm-Message-State: AOJu0YxyWWkuFIJRqvV2S9vQ88WcfxsVQlYZB5YcWbcv0egvtVo3t5vk
	YLZwEaZtWUcwGUlkKxNFM1BT0ma2pmukkOypc5Z9ue4JL3qefPgXBAeRyg==
X-Google-Smtp-Source: AGHT+IEjy1TWN8RrY8IFLr7gWu2H8uSQWxO4l9iw+nKYuPfDR4nbuU/svEv5JS4eQ+8yT0WNJs/2cg==
X-Received: by 2002:a17:902:e948:b0:212:10ea:a4a1 with SMTP id d9443c01a7336-2124d465ac2mr49236515ad.15.1732026283767;
        Tue, 19 Nov 2024 06:24:43 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212389529b6sm29219115ad.236.2024.11.19.06.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:24:43 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/8] scan: parse station count from BSS load IE
Date: Tue, 19 Nov 2024 06:24:27 -0800
Message-Id: <20241119142430.323074-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142430.323074-1-prestwoj@gmail.com>
References: <20241119142430.323074-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used in BSS ranking
---
 src/scan.c | 4 ++--
 src/scan.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 2ffbef6d..64de57d2 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1343,8 +1343,8 @@ static bool scan_parse_bss_information_elements(struct scan_bss *bss,
 								iter.len + 2);
 			break;
 		case IE_TYPE_BSS_LOAD:
-			if (ie_parse_bss_load(&iter, NULL, &bss->utilization,
-						NULL) < 0)
+			if (ie_parse_bss_load(&iter, &bss->sta_count,
+						&bss->utilization, NULL) < 0)
 				l_warn("Unable to parse BSS Load IE for "
 					MAC, MAC_STR(bss->addr));
 			else
diff --git a/src/scan.h b/src/scan.h
index 50adca7c..4c1ebc21 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -67,6 +67,7 @@ struct scan_bss {
 	uint8_t ssid[SSID_MAX_SIZE];
 	uint8_t ssid_len;
 	uint8_t utilization;
+	uint16_t sta_count;
 	uint8_t cc[3];
 	uint16_t rank;
 	uint64_t time_stamp;
-- 
2.34.1

