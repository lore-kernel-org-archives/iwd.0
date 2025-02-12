Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D85F24C679
	for <iwd@lists.linux.dev>; Wed, 12 Feb 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377453; cv=none; b=hBx/kG5/0ERFkW4YtfM9bKwTzra+4cU4wpSRYIURcB6+vM7bMFu/lfiu1UsCDlSqiu0m4GYKfZWHxlk6gNz/fN7UKba6kvIOCOm7kpI+fefzuJzwvJiA00OMI9Gq7kfVDm6jor1/PLgQzd23d1P2uX6nZFxenWUMBdPu5pkzMLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377453; c=relaxed/simple;
	bh=nv298Z4vCnD231+r++rWcrLd/T5SxsLNs2kNNpQPnYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eb3Q2i7CsDEW0vceehWIBH+/rzxPy0cP8yZhWQl8eVAG/PdIMof6eWkFOipmSR0KjCCYc5o/5bMNq8HTxuv08uSt1SV80DMFND5iFtBLACTQ/YRMgg1/BkNv5Ovk1CJM+2nzNeOfJvKqjBk+RlZMB2Pv7lw6Ix7BITCjlqPNvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJ6SOf/W; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ6SOf/W"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c077c9cbb9so40431985a.1
        for <iwd@lists.linux.dev>; Wed, 12 Feb 2025 08:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739377450; x=1739982250; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gSawnzKv+M75QpHih4EnqDB47zGSwAjjOsQ0HZS99s=;
        b=VJ6SOf/W0yM9IAYnkDadoOBpQD4RSUSZsFQnF5fU4CUDBm6i6YEdnqIV68ne+dIEDC
         eOpyrF7eaW4qLNsmyECkluTWF0JtBd1dw7hIQvjksX+wsw5VauVkmXqnxbU96QTCOzed
         BDVUbkvp3+mgcwZfzeXTJL1XaXIt3QmQofXyChhvall2Kezl9+ZUpcpCwqx19VNqKC1H
         ARYg4q7FpIO1fhQz3EtUdCC9COHMYEr9924dzwn7lrOgswfI0WM4XC0f6eemBz1hkD19
         9BGCfypze7CptcMF6AsMmwKdL5FJtqSgLNfl9t5FdakuUcBaGaOkgFzaoFxqmo1H8M5X
         aJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739377450; x=1739982250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gSawnzKv+M75QpHih4EnqDB47zGSwAjjOsQ0HZS99s=;
        b=p2Pb3pkFuicHJUgZu45mjSsbTTTJEGlpVo3VBkN90r+/UJOd/CQUX10wBiMa0eGxAL
         x1DYWh/BHJoqRQBHeEbLEsuYi+mQbY1hNAMZUvozSJHHuwcx/2wM3Dejw5+pooAxau0r
         Yl29QyFfw+dLgpBEi9Q5qvb4Fh2km/3SJ1fsvSTMo4Qpur4yiuSK5FbEF0JS/T6JjoA0
         QPC4Lb2GPhTi7chPeFgIN5NXL6Fx5C/LouEEhm0Ws+7eF4SqIfWl6+dnf0cEZ9ZJFceP
         SQIvS5rjTtKM1E1uSHb0iQQqhEdyoPvcimfEFTlVV1xgGvZpzJpPpPOZZNw8ffvMxo91
         WOqg==
X-Gm-Message-State: AOJu0Yxhdz8O2LIrq19uKEgRrDUO8t+qXib4rFFVAPh/Yp/7PRAiXc7l
	0aTwUnNBjtlYX17WvYEDQUlUG3u9C58HL6rqOfdEedx3wyeGjuvajpaOoA==
X-Gm-Gg: ASbGncv0FnfuXUBjIu4efQzWpw7IQXMetD6BHq+QEvQq8fNjRcSigSGVHginBW0RM/6
	CRkZVep7RkNsq8/e6UW17h5Vdgf/XRrPTnyiyG3nIIXEpeqV7QQX5wnYp2ezC9Zy/oR+sk6Qf/8
	qTiKtsuvfPcrlPYreS6uxuWzafJL96zS89LlaJInzWv9egD/WiBM78s1ExDzIdqGGYErsnNFaG+
	s9VuzIaS22DllrwKgMXjYm7YwI2R4Ria4o5jJ/B3x9VO80wsWlSQEQUQD3LEwNRw+wpmuIBeSWc
	t6Cx4HqzUWPYToRCM+u0/4+CD6FhoQPJKQGFEc7RSWSsAapCOw==
X-Google-Smtp-Source: AGHT+IHiQzguFWRcAgq8RoJZiFXEeYexTDDnK/azykbYSua9mlmGmBmUld6cHAanjwP5JHz9RXmfcg==
X-Received: by 2002:a05:620a:8903:b0:7b6:d0be:ca31 with SMTP id af79cd13be357-7c0704e6302mr567225685a.25.1739377449964;
        Wed, 12 Feb 2025 08:24:09 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0768e23casm73272685a.44.2025.02.12.08.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:24:09 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] station: use netdev_remove_pmksa
Date: Wed, 12 Feb 2025 08:24:01 -0800
Message-Id: <20250212162401.130792-5-prestwoj@gmail.com>
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

---
 src/station.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index bb6debb9..37f98179 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3432,7 +3432,7 @@ static bool station_pmksa_fallback(struct station *station, uint16_t status)
 	 * Remove the PMKSA from the handshake and return true to re-try the
 	 * same BSS without PMKSA.
 	 */
-	handshake_state_remove_pmksa(station->hs);
+	netdev_remove_pmksa(station->netdev);
 
 	station_debug_event(station, "pmksa-invalid-pmkid");
 
-- 
2.34.1

