Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF38A56
	for <iwd@lists.linux.dev>; Mon, 18 Apr 2022 21:56:08 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so477508pjn.3
        for <iwd@lists.linux.dev>; Mon, 18 Apr 2022 14:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXqeLluNEVl1LXzP3NXQQCt99HmaMQDOCQAADwyW90o=;
        b=hDVhMFo8PrNmazQG89/Xmr87vtNyWZ3c1ryTNUzEYmZG1BWFED/UNFs2hr/aGwlJcV
         9zm8+aYfMsjKYKt9AmpOO+DmbyeiaV1tCNRjmDpsPGr59T18b/3Jb7KemFz5g2Xe9m0B
         Q7kUN4Gbw2DC8h/zyypT6/hrh6qmg8Xi9ay1WAV0zbOf7+5lZerbJrXYHHqWdL1LGfHl
         nBZPwxcb4XTGkWMm37jCIPMY+RBD8DOq+Tq57aOheZFiTrWO51gKimhVmkdhpKY7W2PY
         A8z3WcP0s02GJQMfWGcTpc+NgGDswKHixvCYfJ19eTDuwBCpLS+/CDBoRg7bfTvjYKL2
         EVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXqeLluNEVl1LXzP3NXQQCt99HmaMQDOCQAADwyW90o=;
        b=TY9325k58TASOZR1vHT0SkTKA1OFQNiqWtRgJmobZ+wQ0oPIkikYmrTLyhmmFEF79r
         jQT0M4yGvnmmbpIMNpKc7e02dVv8mptvuJYx+9Gn1p5Q99LuLr+Cx20Cb73ZUKBLH3+Q
         aME1UpOoYmn7GrLq9z4nUeG9WcX6Hy/e4Dr3YfCrvwLYVnAklZSRO/4Tfw6Hnin7Qpg+
         3g0iFigL8lRatCn6mbG1/vTjDglHrcseAPCz7f1RiYZQL22PRWYYQ0f6dC194cAy5Pu7
         66KZhWRs0LIHd//d/pxhWL6rua0nWUqNbztWf7XskHdcgFG7WaHzs0wX9bASVVpMY9yj
         ht+g==
X-Gm-Message-State: AOAM531TGKhHEMpD5va08MDwuMDjaMOOLuRselM3GF+K+1ORVkWut/oo
	ZC+A88XajWHz0Su4FTwZtzbyD13BC90=
X-Google-Smtp-Source: ABdhPJx+qfZpHyQb7s/B5ZcTrC+PRpwxgOvVn8L2GYb48d2DN2IlFWpPgX91DvJQUmn6vs/OD2CUwg==
X-Received: by 2002:a17:903:41c7:b0:158:eb28:cb64 with SMTP id u7-20020a17090341c700b00158eb28cb64mr11875154ple.150.1650318968289;
        Mon, 18 Apr 2022 14:56:08 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id fv7-20020a17090b0e8700b001ce18c551dcsm13383699pjb.19.2022.04.18.14.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 14:56:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] README: Updated the readme
Date: Mon, 18 Apr 2022 14:53:56 -0700
Message-Id: <20220418215356.174098-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updated for testing on patchwork
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index 29e59a0c..051345f4 100644
--- a/README
+++ b/README
@@ -1,3 +1,5 @@
+A change to the readme
+
 Wireless daemon for Linux
 *************************
 
-- 
2.34.1

