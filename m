Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92029A3
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 00:02:45 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id c21so17347574wrb.1
        for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 17:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MSWzVlDker448CV4TWfee9AAFefOasVI4lEZAi8V5Vw=;
        b=n56u5IFkYCiEjNH2lqJ2zQU+Q4r4lxKo6Mr0wH3d4jPThd/iEMtZe3i6sCA/cPU7pI
         X8YqSox1fTr7qMWJSElnlwcrlYxSkz1xHvUBgVuacX3I5cJyqKpCygJY9ctnZRWH0nTe
         LR/8j0WVsyWWkF7CD729MiJRJT/ZelfgesAVq7QiN9NjYbZyQyFMakjhSaGQzuOF/PYi
         CmlyPqizNOzzkxszD9RNwwwBM6g2ZPRP1ZK1va8kot9lFOMQLe1Dpdzjc1aPAL1S3HDd
         mGeUSmOI6HqIC0kY9i6LywMY3GJEDUBqCGbxGm0VC8xXbwPKtSk6qLt+dUHdxH4fmNOJ
         sgwg==
X-Gm-Message-State: AJIora9GJQtyANEotwMKAum4TCdzJQr6MaGEbZS15vROyuA4Az7Xx8k5
	M1kXaPiTt9iGigjk2RN9PKk4O8BX/O0=
X-Google-Smtp-Source: AGRyM1tdJLzvFlWAFLaXYM+jhNW2+xEt7LF/C1rslH9OZlyxwnyV9uWZJfC2A8dN5n8hSQXUCopLig==
X-Received: by 2002:a5d:6348:0:b0:213:3a8e:e75d with SMTP id b8-20020a5d6348000000b002133a8ee75dmr2002729wrw.55.1655337764426;
        Wed, 15 Jun 2022 17:02:44 -0700 (PDT)
Received: from iss.Home ([82.213.231.20])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm337452wrb.45.2022.06.15.17.02.43
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:02:43 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 06/15] test-runner: Support iwd-rtnl as a --verbose value
Date: Thu, 16 Jun 2022 02:02:22 +0200
Message-Id: <20220616000231.1966008-6-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 tools/utils.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/utils.py b/tools/utils.py
index d16f221f..3cee9a22 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -405,6 +405,9 @@ class Namespace:
 		if Process.is_verbose('iwd-acd'):
 			env['IWD_ACD_DEBUG'] = '1'
 
+		if Process.is_verbose('iwd-rtnl'):
+			env['IWD_RTNL_DEBUG'] = '1'
+
 		return self.start_process(args, env=env)
 
 	@staticmethod
-- 
2.34.1

