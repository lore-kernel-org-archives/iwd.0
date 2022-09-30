Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761915C85
	for <iwd@lists.linux.dev>; Fri, 30 Sep 2022 23:28:14 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id n7so5189605plp.1
        for <iwd@lists.linux.dev>; Fri, 30 Sep 2022 16:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=DpFnhWCfsEj1q/S7UiJdV0ZemoICfY9pwIoCaPjmWpU=;
        b=jzqe7ag1qBTyLK6P+69NFtBzI8M0BSTE8CfSwR1iWvqv9ywHn3CwcWBQcJzTRvcKwx
         JRbKWQ19sGOZdV9soIE/EVlZ12YAxqCAqDoPUCVvD8bjZXo19Sm2gBumL7Ybw4yDwYKV
         iNMdmCJ/svSO7pIrBdyDtOcvxU3EJo4K2QudrcBO5GmFCSVwrsJF8S4phec/ITkav0DE
         ygLl8aV78xN2MuvGTmOZjLACYK0xIj1INRBdgI1yNogOgLxOsKfd5WkaBWRBTrnyL8T4
         4HhHI6cPLOH2BcPvaeTf+lTnDeCU8r141oO1wvh7Ul2ksKvrLYPoEN4B6DjGG6xPtYl0
         LcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=DpFnhWCfsEj1q/S7UiJdV0ZemoICfY9pwIoCaPjmWpU=;
        b=WYeF8x26FNfAkI0777Tyed0e/nY+lIUIdXGGKrP/KcCqpP47eiGDldTYTpZx0wF7Hx
         leJOjTOHU3RWUv8HDsUH0tJvZVYYdDN2v/TR2cJ9UtrEBhuidBBCD0vANmuPYCUbl7N/
         w5ON0DCRxFKCCihSfmeNKGYcovHcMlSd6zG+tvJjpm19+0Qzeo1uVcbjnChCAG1MJMud
         UuCHgJ7hzlHgudMrtDWyaIYQmPDceq6Rsv1QPomIzJreeNAj91smbgRb/5mqLvjQjvz0
         T3mEhZh45ZxDZmO/JuAysb3eTaKXXzw5DLIpeKZm7ggPYyQm+3pCoq47XKXx4t4194tq
         e/lA==
X-Gm-Message-State: ACrzQf0/hKQtxPYobS71up4GUgi7jyaSz9NGfWC8Nig99eHgOUdDVvWU
	bGB/4IuAzpI0uUWwLnoyKGiCE+QCQy4=
X-Google-Smtp-Source: AMsMyM521LYFZ7LAgE6XfoEiOOIGZMKq7YNLJWHW/y8IRWJ1FqhHS8UBSu+RAL9IfdI82N/X9GJ/Aw==
X-Received: by 2002:a17:902:8ec5:b0:179:d8f4:cb64 with SMTP id x5-20020a1709028ec500b00179d8f4cb64mr11195072plo.16.1664580493631;
        Fri, 30 Sep 2022 16:28:13 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e5c200b001767f6f04efsm2467893plf.242.2022.09.30.16.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 16:28:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] test-runner: write out individual test results
Date: Fri, 30 Sep 2022 16:28:08 -0700
Message-Id: <20220930232809.810726-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --results option only wrote PASS/FAIL for the entire run.
Instead write out each individual test result.
---
 tools/run-tests | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index 9620ed1f..32c09723 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -37,6 +37,14 @@ def dbg(*s, **kwargs):
 	'''
 	print(*s, **kwargs, file=sys.__stdout__)
 
+def write_results(file, results):
+	with open(file, 'w') as f:
+		for test, results in results.items():
+			if results.failures != 0 or results.errors != 0:
+				f.write('%s:FAIL\n' % test)
+			else:
+				f.write('%s:PASS\n' % test)
+
 def exit_vm():
 	if config:
 		for p in Process.get_all():
@@ -45,13 +53,9 @@ def exit_vm():
 
 		if config.ctx and config.ctx.results:
 			success = print_results(config.ctx.results)
-		else:
-			success = False
 
-		if config.ctx.args.result:
-			result = 'PASS' if success else 'FAIL'
-			with open(config.ctx.args.result, 'w') as f:
-				f.write(result)
+			if config.ctx.args.result:
+				write_results(config.ctx.args.result, config.ctx.results)
 
 	os.sync()
 
-- 
2.34.3

