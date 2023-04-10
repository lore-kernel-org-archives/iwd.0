Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1128F2F3F
	for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 22:01:46 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id pc4-20020a17090b3b8400b0024676052044so5988605pjb.1
        for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681164105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fftl90G35wQIDMJQzVx8ImcbDkHItMN2E2yrbFBzmRA=;
        b=bnWeecI6X95WtaBUWGazHSRcTNTKy5sWHLGbD4A7tof0tbQO6WAfzIiQ1UAwmWmWCG
         sCQ7L57K6l/DTHzpN7NJKCj0Jo72k7yhvyvRPErxz6j38tDyFYz7IaUDlY4+51b6Awme
         qCHswXsGPtmhh1Qq8jkl11XZtLtI5Fp5AJ6fREyMleSwfEUb2BOkmTVIpJZDh2T6Xvoq
         cX/fg7sKnLGuQ4s39QV8n/ZA/q0nunfaSBuBmTNdzUtqkqGf/Zgn157J61nJwqFHzVoM
         aKrAvRgA+5BLhITc8CvrHsRFsKkJFiWfl3IGblyhpXC8mVxzQcBIcUBZZaKJElpVgh/Y
         kY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681164105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fftl90G35wQIDMJQzVx8ImcbDkHItMN2E2yrbFBzmRA=;
        b=MK2nYO3mfK299RetA5PN0K0wd+9RSUFlCVaUfDfYUq4g4M7hfuz5UjtKQ3C+rixXCJ
         zwbMsnXq/9OdCS+BN2o7N3mWA2ngTsqby+tiWA7I2DXqNpiqZtq2fjdmNmo4xx7RwI5q
         DyLA6Y5dzGZtwc4nrNWHdaZrvUZjyy4DJ0jFJU71B5e7rudpqysCEUb9TWFzIGxnZINZ
         ePnBH6i5t3Jn9Cw6KMypwybFqX3UACNmLY+aQ9eerAK3HE3pWmfcCAPu5nzoeW4Df2WC
         FLArxaPvRBrkfEqd88BK638hRgtH394DNDl5IJm49pY3tY5ZCsmISATXaEm6JT+UR76u
         IlEg==
X-Gm-Message-State: AAQBX9fMldVSOSc3yLssv++D/R48zkwUxRkL4YaTSNzP/HFW1oin70in
	A1+i7xkN6C+TwOowN0yTw5QmRkBhyrmloA==
X-Google-Smtp-Source: AKy350adVRWVURlAQUY4B918gDH4XNQLFtEqiat9EG/J3OJveswUBICDug/tvLoXCkSmzTTqwh4GHg==
X-Received: by 2002:a17:902:dacb:b0:1a5:150f:8558 with SMTP id q11-20020a170902dacb00b001a5150f8558mr16186680plx.17.1681164105474;
        Mon, 10 Apr 2023 15:01:45 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001a2806ae2f7sm8263372plr.83.2023.04.10.15.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:01:45 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/9] common: add FT-8021X-SHA384 to AKM_IS_8021X
Date: Mon, 10 Apr 2023 15:01:33 -0700
Message-Id: <20230410220135.373872-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410220135.373872-1-prestwoj@gmail.com>
References: <20230410220135.373872-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without this the AKM shows up as WEP.
---
 src/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/common.c b/src/common.c
index ea7b0ca0..91979423 100644
--- a/src/common.c
+++ b/src/common.c
@@ -78,6 +78,7 @@ bool security_from_str(const char *str, enum security *security)
 	akm & (IE_RSN_AKM_SUITE_8021X |					\
 		IE_RSN_AKM_SUITE_8021X_SHA256 |				\
 		IE_RSN_AKM_SUITE_FT_OVER_8021X |			\
+		IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384 |			\
 		IE_RSN_AKM_SUITE_FILS_SHA256 |				\
 		IE_RSN_AKM_SUITE_FILS_SHA384 |				\
 		IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |			\
-- 
2.25.1

