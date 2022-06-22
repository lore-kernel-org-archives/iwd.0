Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9041C26
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 23:04:30 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so839998pjj.5
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 16:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZlE+0kiYyBnWayQKTw22/X9Se/HRLW1FM2DdocyjSOw=;
        b=lsIhwb+pskhYMFzIf592dBRgd3TYmzDbqF3u/pf3HgEFeoknaM93Wztrqq8wRqZPgH
         TYKA4NR3kwfWwrYHbvhCghjYC+0eiVd2m5L+O1zTul5Gauf1EIsPWyB0IWU3VmkV0+BV
         C5BwY0NGm1R5vybfpwqp8WMRYnevM5ls0B8wtsQ0oRBrhGgrTulzaf+JFb8fRvX2y90s
         9v5Gqjtce5r7i/D6HNoDHKmV7sHTWScugzu1OIinno7/B+BpmZ4o5OAgZ5+vGyy4P9AQ
         uNbdJAobwRhk5QRWY5GA3m46XOjEs91OSGgb7ZPglEXQCwEyNaQ1XtmXT8CBGpDeluK6
         LDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZlE+0kiYyBnWayQKTw22/X9Se/HRLW1FM2DdocyjSOw=;
        b=xlQht18+1In7Z0kmhwrMXIKr/vS6snQblvwoH81aui1Kmjipcm3PYRgCKUw7ixoRNW
         FPhmAOZTat6TZLVhMe2r1i+PsPHdmCMWU5GrPdlSXuCSE39qQge+GIXO6U7ZCMn5K9Ru
         fT8VmzvybMdrtW6Vp3qEkizJpMotZ/yw4Nr+5Exhg3IHZpNxEvexGWXzzTwN35Vfe4Or
         TAOuI+rSxOqhe8Jkek8otesh8ZCKf40XAzFSXgxqcUKuebmeOTiHlP0IYiNuol22Eevn
         igNRrxa6TgKwZ8iNZRWGEKSm2iWhJwcbH4aNH/sV8Ize8A+e6C91LENZ8u5W4cQmqT8T
         /Ivg==
X-Gm-Message-State: AJIora+JgUaLBmSS+r5kkWFHpFP4/cs4TwURq/E3zkZKREwqSf1dwwVt
	tIPCQCaAf+eFuzet8BSGFsHVpuue24w=
X-Google-Smtp-Source: AGRyM1vwyjVmRUOMEqsYEkoHh5VkRZs+s8u99/MAKd5L4H/U8bWzE0X19Dq+Qf59Xp7RDV8S7XiAVQ==
X-Received: by 2002:a17:902:cec4:b0:16a:1fc3:b6e6 with SMTP id d4-20020a170902cec400b0016a1fc3b6e6mr19067723plg.129.1655939069957;
        Wed, 22 Jun 2022 16:04:29 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id jb6-20020a170903258600b0016a12571537sm9107052plb.299.2022.06.22.16.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 16:04:29 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] test-runner: exclude 'iwd-rtnl' from being enabled with --log
Date: Wed, 22 Jun 2022 16:02:17 -0700
Message-Id: <20220622230219.1557695-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling this ends up dumping so much logging and, at least with namespaces,
seems to break the logger module and cause really weird behavior, worst of
which is that all processes start dumping to stdout.

This can still be enabled explicitly with --verbose iwd-rtnl, but is turned
off by default when --log is used.
---
 tools/utils.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/utils.py b/tools/utils.py
index fd51b6e8..e424231f 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -142,13 +142,14 @@ class Process(subprocess.Popen):
 
 	@staticmethod
 	def is_verbose(process, log=True):
+		exclude = ['iwd-rtnl']
 		process = os.path.basename(process)
 
 		if Process.testargs is None:
 			return False
 
 		# every process is verbose when logging is enabled
-		if log and Process.testargs.log:
+		if log and Process.testargs.log and process not in exclude:
 			return True
 
 		if process in Process.testargs.verbose:
-- 
2.34.1

