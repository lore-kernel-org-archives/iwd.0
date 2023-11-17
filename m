Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A4B3589F
	for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xnn1a8Qd"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6bd73395bceso1559004b3a.0
        for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 06:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700230354; x=1700835154; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TIbmc3qi2diqB6wEOamgw2jycsqy3NdYwPTYKpMHmo=;
        b=Xnn1a8QdrvpYCdaUuexIXlYU/9T2f6+DhGFfYSUGfyDbLBPuf8pk/qM2INz+NtlXeG
         sf0/AeF/KlVnwfOvu85FNqhNrPaT7RlH4qxPojnHaEDufum/Ygj6OmaSWXh+H7Ygvh1F
         6CtXNbmpyiOyHaAmfGvzDLbuV7a8YhyOl0QOjsRcbvPk1z9RD8DH1+CC+EwgHqEos8C6
         20mS8dZIJkm+o0gGjENI1Obg9njXtxB35Sq/s8POd7UoMp6A253GZ9u1bR6C0C5qMOuL
         SkSwLopuuYASsP6/A62JGILR0T5VdmGhQukKLSQJPUXFsD+wJethH2Dbl3tNdIm/1QzY
         DUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700230354; x=1700835154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TIbmc3qi2diqB6wEOamgw2jycsqy3NdYwPTYKpMHmo=;
        b=cn/QsXKe2X52TtT2Ku7GV2Zz3Nk/Nn7TsCNtBuIc1Fsr97GrECM30BH6sDGsm2kXz9
         W2SKmaShLrwBvaiY51qV6WvANY8cb/2HuPqh+E563RV2eQqEnJLCxl9kz5lAa8YY5vJZ
         hJTQRZIuCwKlPxAlv2tNzIm1uO+JxiNSqjpXtCQ99psGHrUhAoppQOzJaiPPYiUaN45E
         qbeIvhndfJobGoXfpm3/eb1cxfZDraCCdzL6BHDeWpYTQ22B4IaeoSr90ae5TZ7P/m20
         W6qdyTcGydyhHMbwAViAbVeyVIpuOCqZCXGH+PzT0cN0T4CFahXH2eo1mUcjIKDH3rGu
         PHuQ==
X-Gm-Message-State: AOJu0YydiGl5Iq7+QYYq3s0szYt9nEVsLoLLEDpHINEgRk0adkOWT7pd
	ls0WxaQFtYJKjifKK3BXk246gyZDxaaYyg==
X-Google-Smtp-Source: AGHT+IEBquh1muETuKrDw5rqHhHeiq3JNx5PmuOEn6Qu1RkdHQ4p1GEAMZxRFBf9rVf/kWbGnpo/fA==
X-Received: by 2002:a05:6a20:9389:b0:13f:13cb:bc50 with SMTP id x9-20020a056a20938900b0013f13cbbc50mr7568424pzh.25.1700230353150;
        Fri, 17 Nov 2023 06:12:33 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id t24-20020aa79398000000b006c4db182074sm1447897pfe.196.2023.11.17.06.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 06:12:32 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] json: fix comment typo, "json_object_is_valid"
Date: Fri, 17 Nov 2023 06:12:27 -0800
Message-Id: <20231117141227.60722-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117141227.60722-1-prestwoj@gmail.com>
References: <20231117141227.60722-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This should be json_iter_is_valid.
---
 src/json.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/json.h b/src/json.h
index 713ab56f..feb85d67 100644
--- a/src/json.h
+++ b/src/json.h
@@ -85,7 +85,7 @@ void json_iter_init(struct json_iter *iter, struct json_contents *c);
  * other types are encountered.
  *
  * JSON_OPTIONAL string values will point to NULL if not found
- * JSON_OPTIONAL objects/primitives can be checked with json_object_is_valid.
+ * JSON_OPTIONAL objects/primitives can be checked with json_iter_is_valid.
  */
 bool json_iter_parse(struct json_iter *iter, enum json_type type, ...);
 
-- 
2.34.1

