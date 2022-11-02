Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025242F36
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:23:56 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id q9so2336376pfg.5
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTZZCA8Ui0qkUUtR9q67ZwYvRf9sFDRowNGuIVqgkp8=;
        b=UbKqbVzYBv3eqkLs9Xgg/9NPQjhT2+736FpsQan4SW7hDyPro6W5WKIN57XDRAFGHh
         ZXoGo03OolA+6400xRQ74dzNyrOAURD+KkuTLAR+v9k6GTTX9JIyyzWEZ9beHYlPkjla
         FmgTjWzoUns8ILUHAa9uDe4g544Mhp5AMgqAtB7rj5Ko1qVcNL3i2THSjwCCcRmOH/x9
         BFxrQ8uadbmNVEzQTfyYh6E7EAorcjU2Cacw/zXrcb4kpMY+BR93JZCrQ9fRzTpGWuay
         z0vSkM7xgk3wSdCw1VkYgOvzfkRTBSrVYSsSMrLV8iQAr5iKcfNIz+lI2vR0+WOfIglf
         Ke/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTZZCA8Ui0qkUUtR9q67ZwYvRf9sFDRowNGuIVqgkp8=;
        b=wuKyo7ZuYBRt0JjP9ztV8cWskjJSzZ+gQE9SNVAVy4T7QVkJ37zqK7EuhxfI79xSnv
         kUhRiYYsmiNdhe9r9fzljFXuPCMk8p7YrICH6GUNR+LfmBD4g1AH68L2pExOfKenbPG8
         9m1cxJ4C4cX636zHLDbYLqTidsioVeCpwGyq+/RqcmmVDeeIkwM78UHN54vfSj46/yc8
         WEylFU3VOh9VFFEKxd8Dd3e8qeYJGJyATlkC9H0eM70t/FFMzZ/s7K1a6tXyFlmTAvB+
         BKEx9+48qhga+C9+NgkYXjGlaL2ItODCbOJNkFaPqjbdYENnNiGUUNNFJdl9iaKUmofr
         uThg==
X-Gm-Message-State: ACrzQf0BDZiaZP6SiNKeAYEhQ1VDk83/ft1qFpicG3oS8osAAEI/ArEy
	ogWThqyJROsh5qRPN2RsOdsWDLvA4RmbyA==
X-Google-Smtp-Source: AMsMyM7OY8eUdeanRG1lrF9Wt5a7zsk2+dndb0xmIGMe5iDwIeMgvPU2Mosucq4UvrMqS6thKW2Hog==
X-Received: by 2002:a65:4c0e:0:b0:46a:eeb1:e78a with SMTP id u14-20020a654c0e000000b0046aeeb1e78amr23141550pgq.193.1667420636469;
        Wed, 02 Nov 2022 13:23:56 -0700 (PDT)
Received: from pvlnv.. ([2a09:bac1:36a0:80::242:2a])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902d50900b00174c235e1fdsm8752720plg.199.2022.11.02.13.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:23:56 -0700 (PDT)
From: Neehar Vijay <env252525@gmail.com>
To: iwd@lists.linux.dev
Cc: Neehar Vijay <env252525@gmail.com>
Subject: [PATCH v2 2/2] gitignore: add .cache
Date: Thu,  3 Nov 2022 01:52:58 +0530
Message-Id: <20221102202258.289396-2-env252525@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202258.289396-1-env252525@gmail.com>
References: <20221102202258.289396-1-env252525@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This directory is used by clangd.
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index cde22889..61b3638d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -4,6 +4,7 @@
 .libs
 .deps
 .dirstamp
+.cache
 tags
 cscope.*
 Makefile
-- 
2.38.1

