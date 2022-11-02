Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B051A7ED
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 09:22:29 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso1522362pjg.5
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgaQN7Cfo7j5jRPCYaAYePbsrefvonlcQ60+F5gfXgM=;
        b=QEXfvHNAWJkmrflcLdc7hyKKWGi4xKQxWVlhHUMOsFwb8wQXWCQhVcYCyRLQI2UzJr
         nI7g2/+lHU5Kmad3EXVMvxjPL/FJiPUjJsX5WV/YRjczL2CIwYKoKj0aTlTnGoAx7UNQ
         y8ZRV6Ee5p5Zb4ElbpAxOhBjZUdfwwzSuEAL/+0kWDvpMaL119Al+4amgUwcoA6O9BGb
         JlkeOWeumM/ga2GVc6QGumhsyzk74vQc4SwUAyiUL5lDOM5m/Yb3tOAYnI4aBJ2SE6XX
         xdbiBNzDShZ7XXkBd9DxNqhiLs9lvyamD32eQkuZnZ/azE/aa2e5elycvqnqUgG89hNW
         foeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgaQN7Cfo7j5jRPCYaAYePbsrefvonlcQ60+F5gfXgM=;
        b=VDc57FM7JsXTItXo+efAuzCKkGQMyo79HFjn9j+or3e6gro+3ofKDa72VfA/ApDIt+
         Bg/U5l7GGY8A5pt9dcrNpafp4N7vfp+6U0fHjMYVKdtXo1b/kBSiE1K9Lx2r7Bv6oeP7
         wujxhogfPAIigiXZSQGldri7Y8Jz4xB7WHNRWf5qxSekbOp3ZchdfmT5tUMV3/TfjUe/
         85Nzg9E8VWt5kdll0hH+jxPWbmJneZU1r/mqW0GTNlVVWHoY9MdFc4H45UGuVThcmXEI
         7vZpaE+Nr2ZFi9fH//Ir65NezsVsULewMEMRyk/QSkr2Lrz0ie2gkmg3u9Z4hv1G82ue
         lq5g==
X-Gm-Message-State: ACrzQf3uoRan4Y2i4GdkTmhOxa9tuNOg0//rAdI3yMEY5tr17uRuEBcc
	qFEpV56o9z+vfHHRTTVoj8kaRDnOFVerxQ==
X-Google-Smtp-Source: AMsMyM5/LFTib8ED89T0XrDuD9eWOlWcq+E/XvFTfrL1mmaS329iAEAFjEsJypJ+rMtNFPCXVUbomw==
X-Received: by 2002:a17:902:edc3:b0:172:8ae3:9778 with SMTP id q3-20020a170902edc300b001728ae39778mr23607832plk.72.1667380949054;
        Wed, 02 Nov 2022 02:22:29 -0700 (PDT)
Received: from pvlnv.. ([2a09:bac1:36c0:80::1c5:63])
        by smtp.gmail.com with ESMTPSA id r10-20020aa79eca000000b0056b6a22d6c9sm7992827pfq.212.2022.11.02.02.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:22:28 -0700 (PDT)
From: eNV25 <env252525@gmail.com>
To: iwd@lists.linux.dev
Cc: eNV25 <env252525@gmail.com>
Subject: [PATCH 2/2] gitignore: add .cache
Date: Wed,  2 Nov 2022 14:51:56 +0530
Message-Id: <20221102092156.71357-2-env252525@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102092156.71357-1-env252525@gmail.com>
References: <20221102092156.71357-1-env252525@gmail.com>
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

