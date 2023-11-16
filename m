Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4330F91
	for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU02AJfp"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-778999c5ecfso52502485a.2
        for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 07:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700149485; x=1700754285; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Aa+S0TO4HGBK9r3mrfT3swPS7QARrsdwwih50hBHio=;
        b=MU02AJfpvhNLTqzVv+DWsBE+Tl+NFanJZcRg8fuV44awGGeR8s02sTsNhA0h9eYi52
         Yi1cJrVxC2HiI99puS7dJVo/SCq2yyp7r3V3+zvk16EKtytc3VWaXf4aSkDs66U2CTWu
         RVjvvg4BJwptQPg7hUI7XidFoOM5W4CCRP/6mocxyJzEHNvFiJiNDkoJ87eWUvFNWqN2
         95Wu6XnSxSUX8j0P74kPvCyOnyekvH2MfYugHFSU+0h2jACZmhdhI2vNvjFT6OZYac+B
         FJujTXgtOdovjlMci6p92xgnjfT0eF7SY9VJzUjCZNZBKBoz4Qpm3akPkd9mSweyhJqp
         HSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700149485; x=1700754285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Aa+S0TO4HGBK9r3mrfT3swPS7QARrsdwwih50hBHio=;
        b=HxclcKs+okqZOxT2vbjL+5wHYOTnfqFHsAqiPyXJ/+E8aQOUzh20LnBEGS5W/4MC1B
         /PqlRMtsOfPpsWr8FhV/RPl3TRWsyRgENxAH+5c8p9QuarBwyYSwEOvpq488Cw7G7Ft0
         XbbOx1eBltWGiTUwJe3aftIeC+8DPLFy+L+oQM6JEvR1beZlCaLmrAE5ZB9obcJtBqsq
         K5l0o9FjLfGK96tcmyhfh0DX9nFrmA+fpgWOMqSLTG0jYaCVjtQ6i70LZIjakuOXnyGQ
         WOAmKS6kBaMYCRBnQa1ItgiXRWIur1mHuclpQPntUPyi/ZalCtg3Lq070UlO2YWIakcF
         A4MA==
X-Gm-Message-State: AOJu0YwqKr6rW6zwYsOZUMtuf1eHxnDHZTmwDG9bAo9MblZbKxHppQD1
	eTqlaJuM8eCt2u3BcifuGBz5HKsFvFU=
X-Google-Smtp-Source: AGHT+IE9zs7Gk/AdYM62K8wTQmTVvwRhLTowmy0UP6x/cA5pJ0ZqZ34nysAsHOLKx0kx5vrxNKrPRA==
X-Received: by 2002:a05:620a:4452:b0:76f:14fc:6d2f with SMTP id w18-20020a05620a445200b0076f14fc6d2fmr9939697qkp.1.1700149484854;
        Thu, 16 Nov 2023 07:44:44 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id b23-20020a05620a271700b007759a81d88esm4338300qkp.50.2023.11.16.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 07:44:44 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] dpp: check that DPP is running in station watch
Date: Thu, 16 Nov 2023 07:44:38 -0800
Message-Id: <20231116154439.33880-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was causing unneeded WARNING prints because the DPP state
was never checked. Fix this and bail out if DPP isn't running.
---
 src/dpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index 5cf9ca23..18b2a7c6 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -3686,6 +3686,9 @@ static void dpp_station_state_watch(enum station_state state, void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
 
+	if (dpp->state == DPP_STATE_NOTHING)
+		return;
+
 	switch (state) {
 	case STATION_STATE_DISCONNECTED:
 	case STATION_STATE_DISCONNECTING:
-- 
2.34.1

