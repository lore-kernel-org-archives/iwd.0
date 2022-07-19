Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871544C77
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:54:33 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id b9so14411484pfp.10
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MrN63qWlC0eGThSaST+KTEZ+HMIG+SOOOEU1SOly46w=;
        b=LN/6J/LJiJercXKa+4ZFHpMvC5ad9Us471zossEyqrNjhkjngdEc1ZNolA5rxVHMsN
         AQKywhyTJFTlGr8j+MBsiQYLpF3axlQFhRLz0Heih3UB2I7a98Yoqebk8I27z1hRBNWD
         SAdo3qll8IR6bNVFm6Wf+RJcdXUfydevv5XQ2Yu0JW/KrfI6mp98FnnUnewwv65+AXnb
         pKpZ9sWJZFClfCnqkarMPRclpZzQxQzu8jgJ+Lhmc1vl3PG1u5CfOe7vaoO62GFcPtir
         EwVnGJrJhVoQ7uQJMBSkEi/3aF4MvIAgowPWkAhnsBeQ4f+qH3JgnhG9gUKhEVvH/maJ
         NWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MrN63qWlC0eGThSaST+KTEZ+HMIG+SOOOEU1SOly46w=;
        b=yxeq2MOOOFlXzqZ02q8ujBfLqPixhQGzFRKNsgM4HHaMSpLikJ3fuQG7HriR+tBncw
         w0ftaXLKrrI5FqgiGUCohkhipa/5LlDjOuvkGL/hEpixhNBOCsKt6Ncbp/ygLqkfKY7r
         NOUKSV1spRxJ+eTYQ6L3Z8GvfN973KmdphZqGqhculdNXYmbLCex03Zx9t9J7GXeu9RJ
         Qh6KO3FLYJl7isnqVt9GGhS5IJLC2r1LpkapuWxgXltNmHhrnG40sBPl77SthHly+3tb
         Oq1iZ8R3yA425koEnwXiFka8e/a5M94Dxq3aZHPWu4VspOyn/kSmWqxJaJFTu+1+FDao
         WDkQ==
X-Gm-Message-State: AJIora+z0HVlZ/s/dUJJo5Jl2sLBmi7+FzL6N1xehY9I2vBN+MEdMc3Y
	GjLNzqe+wwJKjDMCgqP5fo0R4ZnmkSg=
X-Google-Smtp-Source: AGRyM1v+UfjDsgcTBaKRBiQ3ggp2l6cbXg0cGOH5gRLHDeH8ey/C1xJrtSao1q+05v1i1VTkL2c1PA==
X-Received: by 2002:a63:cf18:0:b0:40d:5506:df97 with SMTP id j24-20020a63cf18000000b0040d5506df97mr30225659pgg.43.1658256872778;
        Tue, 19 Jul 2022 11:54:32 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id w24-20020aa79558000000b0052af2e8bba3sm11851616pfq.37.2022.07.19.11.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:54:32 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] test-runner: allow infinite process wait
Date: Tue, 19 Jul 2022 11:52:21 -0700
Message-Id: <20220719185223.456197-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

subprocess.Popen's wait() method was overwritten to be non-blocking but
in certain circumstances you do want to wait forever. Fix this to allow
timeout=None, which calls the parent wait() method directly.
---
 tools/utils.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/utils.py b/tools/utils.py
index bc030230..7a182848 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -246,6 +246,10 @@ class Process(subprocess.Popen):
 
 	# Override wait() so it can do so non-blocking
 	def wait(self, timeout=10):
+		if timeout == None:
+			super().wait()
+			return
+
 		Namespace.non_block_wait(self.__wait, timeout, 1)
 		self._cleanup()
 
-- 
2.34.1

