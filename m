Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEC93C3E
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 23:53:27 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id p3-20020a17090a428300b001ec865eb4a2so874971pjg.3
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 16:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vp9T7DsuX3lWGqUry2DlP1/Aj7+OeQy7ebehAH7GZsA=;
        b=QLPdZ0kQm52pC8209SkuWaYaLZh6jOEdTtqsNGp1GtzlsNPh+02Qyijk5LDd10Q244
         bPXmiZvzWifs+AZ/pxKDM1Dn83f+M1NqzbZ5SRwd/tmR2uzR36SZA0CHibOhsnExeKD3
         CLv93bVsTsHquG3IjE9q0nA0PTzjnE3sVI1mhPYYH3bX40YJSmB/ZDZjlmEEG59/Wzue
         hsZZ9tLCfe0dVNyvlLnDJKjoknnRgmgSlwEHo6XHMW/hKCucDMjQvoPFyUWHfjTcv5Zb
         2+SO8ZXVyYhb1FzLoU15q3ZquXeC7e74y+xxZIfDmb4AeIRBvjDkOTwFkReC5mFQOoCV
         Yfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vp9T7DsuX3lWGqUry2DlP1/Aj7+OeQy7ebehAH7GZsA=;
        b=6IzNH/xc56zdT2EnV0dX3/lepLy7TXh3ds6XESrzkCp3bljL1UMNWYECBwUOVyUtJ3
         2Puw3jQbf+jptbR5Mbcy4CTfYUCSNGY6QVZcNc0vUR0FLPnv0NXfx6nilSVpPekwWEAD
         r1EbjhITjXi4pSGPwc/Ugu5JK55h04u25VyJs2o2oZVxtj0K22HXl0YYUfz8GuWjHVdR
         y9GCKRWGUuEyiiqkNBr/4O6BGgKBXcJngU8pHItXXVW9OCUtgEAwn2hAOppxD6yZboQn
         YoJthinto5RAp1zkhSvHdLASEzumrZhPniTYCIokO0uR/qCO2Luls8ptxl6z6ScFV7hQ
         r+gw==
X-Gm-Message-State: AJIora9mr+a3AUSEBadNUcCt88dusDqnPOsz1N9DPRL2DV61qKp+xIfF
	Ey5XMR6fELzyG8CD3jweWTivtFLn8b4=
X-Google-Smtp-Source: AGRyM1vHyPsMl6U4AqgoNY3tCLOO9QTQu+zRVxOEvFjNLHTTk9KxTW6YD81aQsBdKj1jKGOMTUrO+w==
X-Received: by 2002:a17:90b:248b:b0:1ec:9869:59a0 with SMTP id nt11-20020a17090b248b00b001ec986959a0mr952504pjb.37.1655942006381;
        Wed, 22 Jun 2022 16:53:26 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id h21-20020a62b415000000b0051bc5f4df1csm14114899pfn.154.2022.06.22.16.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 16:53:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: fix result/monitor options
Date: Wed, 22 Jun 2022 16:51:16 -0700
Message-Id: <20220622235116.1562570-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An earlier commit fixed several options but ended up breaking others. The
result_parent/monitor_parent options are hidden from the user and only meant
to be passed to the kernel but they relied on the fact that the underscore
was present, not a dash. This updates the argument to use a dash:

--result-parent
--monitor-parent

Fixes: 00e41eb0ff ("test-runner: Fix parsing for some arguments")
---
 tools/runner.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/runner.py b/tools/runner.py
index b018a0ad..d39b560f 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -117,8 +117,8 @@ class RunnerCoreArgParse(ArgumentParser):
 				type=str,
 				help='Use physical adapters for tests (passthrough)')
 		self.add_argument('--testhome', help=SUPPRESS)
-		self.add_argument('--monitor_parent', help=SUPPRESS)
-		self.add_argument('--result_parent', help=SUPPRESS)
+		self.add_argument('--monitor-parent', help=SUPPRESS)
+		self.add_argument('--result-parent', help=SUPPRESS)
 
 		# Prevent --autotest/--unittest from being used together
 		auto_unit_group = self.add_mutually_exclusive_group()
-- 
2.34.1

