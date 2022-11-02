Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5380924F3C
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 18:46:03 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so2968635pjk.2
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 11:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SbdavCn4mKZ9d3dOCUfESTcUHVsXD0i06Ai5cxuhq1Y=;
        b=PJXuzq3GnWsOAx3Qy76tax8kGRUaNyI96BDz0romqfWZHZH0nLZrG50WpJKEQbriLu
         ydWUbNGG3GsJJMoROiYSqsek8XPHyjN6cXj10NStATEkj/2Q/qwAU05S9+D2G1Ql1CE8
         2nH6+2fNmxXTrvHO2OnN4hj5FXIZLgU6A2c0cS9gc6rObvDG+VYgcoex2hKDWOFM8mCH
         jptH/k+H/lMTgDIYLn2nlvwfoQNLJdn1l+m2hLQGNMCzH/zROca31j7W24BGWVhMMRFT
         b81o6esAP9OcmUFCLBqQ565fKtCSMGZYIerTstRlZUB44O1f83pcrgsVoj/0KnI47zcQ
         F67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbdavCn4mKZ9d3dOCUfESTcUHVsXD0i06Ai5cxuhq1Y=;
        b=qTckp/dkC0T0eq6pBRDg/cbih/AQ+drZs3mIQo3dJ9DbZNmzSTmrzqkNswMESNJJ/8
         nOH2lquiXxvJBMIYnaNJOLtne1calRVmgsNh2lhs3m0jR2SIrHQyH7VpYcRSCUhrbOTN
         KxLEIPtDABn+Uj6lwRbNsblm6wIqaws8GTc88h1YC2TViFvH9QnHXFpHzPzhU5tQQGZB
         fjqJSbU6X5JTk0tk8okWHFBjlMKe+hbpR5JfDLCjUh5NFM25vIzKb+VNmFuotW6VJh1g
         oKEUl1l8ByQSR60SgLSk+KvZMV7Fc9tegF9jl5sfGjceyj38/J+/7zLYT6jYEsbVxL1Z
         nUAQ==
X-Gm-Message-State: ACrzQf2r9ryrI5yTrpsLJfb2R/Jld0+gwNx/lIppsLNitKsaVNAZpFXi
	5H+xkuj8u89TpdoDEEKzNHvKvx8l+YA=
X-Google-Smtp-Source: AMsMyM60k/WsozhVhZITzgKVA2RuSbn+uAblDI8XnPnIXN8SuO9KjRwI8aw/+Yv445m4ZeaPINcjBg==
X-Received: by 2002:a17:902:d48a:b0:187:2b1d:10e2 with SMTP id c10-20020a170902d48a00b001872b1d10e2mr13907673plg.86.1667414762466;
        Wed, 02 Nov 2022 11:46:02 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id r10-20020aa79eca000000b0056b6a22d6c9sm8781569pfq.212.2022.11.02.11.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:46:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] json: update internal type definition to match JSMN
Date: Wed,  2 Nov 2022 11:46:00 -0700
Message-Id: <20221102184600.230988-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: ceda955ba7 ("shared: Update JSMN to latest version")
---
 src/json.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/json.h b/src/json.h
index c6220667..8cf2ba03 100644
--- a/src/json.h
+++ b/src/json.h
@@ -27,10 +27,10 @@ struct json_iter;
  */
 enum json_type {
 	JSON_UNDEFINED = 0,
-	JSON_OBJECT = 1,
-	JSON_ARRAY = 2,
-	JSON_STRING = 3,
-	JSON_PRIMITIVE = 4
+	JSON_OBJECT = 1 << 0,
+	JSON_ARRAY = 1 << 1,
+	JSON_STRING = 1 << 2,
+	JSON_PRIMITIVE = 1 << 4,
 };
 
 enum json_flag {
-- 
2.34.3

