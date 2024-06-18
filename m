Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4867132492
	for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729943; cv=none; b=jxpjx52DrO7S/YypE2O/6oGeDbhYW1a+zG5DcKcpSM66F4FNFco8432aNH9MCOfseB6+fK4TEGBeAejnXPiQIaQgVOEaHRxpFxc2eRowQxIu4/6UiHllPSqil0wL6CmaUg5bIHTiF37x+V9JaboFg8epnC1wMF2FX1hRarVp6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729943; c=relaxed/simple;
	bh=pgbCuaJSS9JWFrQpAd/Ot034FCwNFC+fNRkYN6kwFPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LBThrI/IniWBZFmaSBSMg1pcUixTcws6t5jBUTCkMs4YcZ4nWa22lfinwIgVIpoDtS2E686Fasievc0hCrnhI48dSJdvnhu6EidMcUIml1YbYqreCj3u7eCUwfdgyLnDMHj6Ct4xGk/IKdqvpLJ0+QBbQWGHab1MsgExLi8DxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/61B+2F; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/61B+2F"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4ed083c2874so1270849e0c.2
        for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 09:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718729940; x=1719334740; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQCG5OoDiAsKEOEh7vmRafPWObVvz/Xdd+/fPbFqSVc=;
        b=a/61B+2FRsJVy07LTBjpaugxi7lEWY/5hvchmmn/qlP/6Xj51EgqxIbu+i73dRjpXk
         kaLci5aRyL0WRFSwT0k0lPehmeteWjSsshkIosPuJfgbu5hAE5/MbMtJ/a4RXddTVR7h
         VVqFfPN/olCUCtTOzGpNZhhDHk3fw9nKnbQZLDLYLtU4mbI5emt7Hxnt9sTTzE8mgDKL
         QVOvpFj3bwCDISwazfl+VV1E9lkERMFH7ik2ZLMP1EFeU52toZWEjgd8AMX+HFtVFnGy
         BiMZpsKJ+jgTHEAzBK4jw7i1i0nohmijsiO3rw5z8LHaQu2sqqWe5glkKrijCbXOZjto
         ojAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718729940; x=1719334740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQCG5OoDiAsKEOEh7vmRafPWObVvz/Xdd+/fPbFqSVc=;
        b=R2EgC5nX6uOVUN9Fvn3VLkeB0HDp14IbRE/LhpDD6locu8Btcqo8yAaeyY0HBspCN/
         ENvefRdT7m/IpJcuAniMYr/rGodTD0sfTvu4ynotCUXFVJk7VuCGPIbhIMrlf4Kxsugv
         I7dIRJx7Ecxr2UFg0tpgmLz5VgyyYP6XuR1HfocZ/73gA9Lh9yPwV0CtFaRKRX6EYxNW
         2HFO7mVHbdNmfjj4YWAKuRsCg5F1JixvAGMj9cZjelg7kZwyoKx5YhxRSrliymS+gyfJ
         jiqe5eC8i1v+Vr0xReuAXAh/HLKXL86DYNeiGSX6/hOHYHVaDZk4xOi0NX6lpZeYzQkf
         C6dQ==
X-Gm-Message-State: AOJu0YwYRNle0zPfFxyCCvWn6msZ7fG7pHrYVqLB+CVyUtOfvXVZMhvF
	2XGPTSj1wvEo95mXWzZCVuKn+9zefuadXoT+nG9/bcAng7zZIvhMfnh70Q==
X-Google-Smtp-Source: AGHT+IH2erd/v5EHOClMZ4a4waSbQPBYygcBx6AqevSd/WJ/JFReOY2BABy9zVTdzsmYl/OVXu6zWA==
X-Received: by 2002:a05:6122:2008:b0:4ec:f43a:ab8f with SMTP id 71dfb90a1353d-4ef2770b526mr515320e0c.7.1718729940398;
        Tue, 18 Jun 2024 09:59:00 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798b49e4c82sm533688785a.88.2024.06.18.09.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:59:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/10] nl80211util: add ATTR_SURVEY_INFO to parse_attrs
Date: Tue, 18 Jun 2024 09:58:46 -0700
Message-Id: <20240618165854.113598-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618165854.113598-1-prestwoj@gmail.com>
References: <20240618165854.113598-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/nl80211util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index 3f9a43ac..15968d7d 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -181,6 +181,7 @@ static attr_handler handler_for_type(enum nl80211_attrs type)
 	case NL80211_ATTR_FRAME:
 		return extract_iovec;
 	case NL80211_ATTR_WIPHY_BANDS:
+	case NL80211_ATTR_SURVEY_INFO:
 		return extract_nested;
 	case NL80211_ATTR_KEY_IDX:
 		return extract_u8;
-- 
2.34.1

