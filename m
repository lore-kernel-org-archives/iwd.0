Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5578E3CCEC
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRd1MkQP"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c9b1e3a809so10773465ad.2
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140927; x=1697745727; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fw/NcNRV6vAOGwpBsCKSuZrYjj3NrsDksb1f31yp7A0=;
        b=LRd1MkQPetq5ewcM7JwdaZhovIfUbs4QeCgp4V8+kYwP/nXph+fJhjaaz0SZpKtiv3
         2SbztDdaA7biJbNiIXV3TY4UynZIIuNV1sU7ulWLUKV4/vsnx6HIvc6059Oyz6/36ZD+
         4Vvw5aZj1WoWvgdH2mWAOU0XLBFd2lDcDx334XWyxCKn0WW+HXC6N+9pNae459hbfm+I
         SsH6OU7plRsrX7zCjNbr2OrymbYh9Bn5EDpGgUp0Km921yajTm+lRl9srPLEbYnO01Xh
         lqiJdyf0g8yJoNqCcoSjMRlJZN2KnU/eeMZo/yBi10C14waC+PvUYL/BWw6oxKOS2MsA
         n7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140927; x=1697745727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fw/NcNRV6vAOGwpBsCKSuZrYjj3NrsDksb1f31yp7A0=;
        b=XuK/ko38zFB02SajLezinRBoGZYfGJRhey4Ojn9H4mt3TOq5lyzsjoUPIWuEAb3ZCj
         tyaeKKNC87a2Z30J/BPniF+5cRwmsd8MM4V308d4qECQdel0ALCiX8WvfcBF78MxxWnP
         KywtWFOqNAhSuwPRrilLBQlYIxRxp5veWaDQP1E0TUkXoNzDper51pyUvQXT56BaYAtA
         jEmYL7RHBBXumSNDFuYO+lTBA1rbIiveOYpEbmWd9+3JSf9CSpAwG8CyjJAHqryZvRJN
         9dLF571wlgx1bJHrP8ZIvq+uFQm0DuiGic4wFSwj3lTMf7yIhgXBulZiMcrKqfFEmYwu
         2Iig==
X-Gm-Message-State: AOJu0YzpK3aWdduv3dq7HrXE+ocqsu9VS9SGVHVAThLnyWIOiAdRQ3C0
	yqkZuiyzdEdAdC8sFMThd6P8ibqhQuk=
X-Google-Smtp-Source: AGHT+IHrAs9SC6jJmTA1pO4zoELKGScf/qryJkigEx6obWzFBMwOLupmP0EDjEbWVAJC1E1vHIWaEA==
X-Received: by 2002:a17:902:f68b:b0:1c8:a68e:7f1 with SMTP id l11-20020a170902f68b00b001c8a68e07f1mr14420343plg.66.1697140927538;
        Thu, 12 Oct 2023 13:02:07 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 13/21] dpp-util: add __DPP_STATUS_MAX
Date: Thu, 12 Oct 2023 13:01:42 -0700
Message-Id: <20231012200150.338401-14-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012200150.338401-1-prestwoj@gmail.com>
References: <20231012200150.338401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nice for setting as an invalid status since STATUS_OK is
already zero.
---
 src/dpp-util.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/dpp-util.h b/src/dpp-util.h
index 6b00796e..61f1c859 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -71,6 +71,7 @@ enum dpp_status {
 	DPP_STATUS_CSR_NEEDED,
 	DPP_STATUS_CSR_BAD,
 	DPP_STATUS_NEW_KEY_NEEDED,
+	__DPP_STATUS_MAX,
 };
 
 enum dpp_attribute_type {
-- 
2.25.1

