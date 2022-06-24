Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE96946B7
	for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 23:09:54 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so4148001pjz.1
        for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 16:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZzlOpSGZ27RBtGg/CurunhAG1/LCTLedRPaMpLqxQ0=;
        b=WZtsIpTcfK0/8rKAjPEsq81lMPxYDoBUTLs3w/nMvoDOjAG/GlvZECHcYz85sroXFW
         sPOC9Wm/hQ9GQxgt29E4PH4iHoBs6r9COmudBjAIZzzJg5K47FhXULcdBteCLI0M0kxr
         10AAJUzVw4wKsCtV7DGkM3Y50jQ6iWEBxl2SvzB4g0uY7CAhjhZL2w0n2nU1oaHZDuN9
         TsEvmuZIJHt+a3FvlcdUOL2/tHzwPJgDqHE3TNsggbkQxiH4ic314qIYJEI9AkvzvRC7
         Xc9JI1qvZWN9Vslk2vrM9I5TaUwnMa3vuHFf8ggBo0xLJ+0JbJW7Vn00P2fy3z9Q5suA
         5Wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZzlOpSGZ27RBtGg/CurunhAG1/LCTLedRPaMpLqxQ0=;
        b=OA4V8AKJDTp+9gjQiX7Bh0JsU9/DG7nmahgz9foB6h5wedq/lA/pSTGxPq+3Ua+gVV
         zeykRr/UP147BRkDuKS7Z3a4heN5aPzOHdT+zPIK4lW6aiVlkdbCfg0XK1S1DEe+Ve9W
         uabrfw4Ncim04mCZxGjHOWfBcF0uFOtb52vPEjJsVxhFxzeiKjXKm0nKRrQl51R0eT1h
         kQUdWVRfWZsH6XSjA8pBmCRGthJaSFf+BKSmq4/SgdfKKVwDfy8XK7qhThJAjjESz3LY
         wy36ZsUvCoBNwtIvQUmwBjFcR0uyR1dXFZzEpI7xSPCCfbvLNQIXIfiFKglxQ1YAoiwT
         pPrA==
X-Gm-Message-State: AJIora/3Np/VwAQ0P2QFIs7Baf2EE7LrFpnP6vjMj+cPQDErS3yiSPWo
	eexoMMEy3kKnHOkvTgXMG5dCR6jBBXo=
X-Google-Smtp-Source: AGRyM1soJyv235pT6mso+P9xCC8E5Obd/wR72CtFH7AJhnTGGncTLrJ2uooNaxT9E8FTUD8zQz4xeg==
X-Received: by 2002:a17:90b:3b41:b0:1ed:25b1:e53a with SMTP id ot1-20020a17090b3b4100b001ed25b1e53amr6274810pjb.71.1656112193827;
        Fri, 24 Jun 2022 16:09:53 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id 64-20020a17090a09c600b001ec9ae91e30sm4449767pjo.12.2022.06.24.16.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:09:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/8] test-runner: remove reference to missing class member
Date: Fri, 24 Jun 2022 16:07:34 -0700
Message-Id: <20220624230741.1957863-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The print statement was referencing self.name, which doesn't exist. Use
self.args[0] instead.
---
 tools/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/utils.py b/tools/utils.py
index 66002f77..857aa1eb 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -259,7 +259,7 @@ class Process(subprocess.Popen):
 		try:
 			self.wait(timeout=15)
 		except:
-			print("Process %s did not complete in 15 seconds!" % self.name)
+			print("Process %s did not complete in 15 seconds!" % self.args[0])
 			super().kill()
 
 		self._cleanup()
-- 
2.34.1

