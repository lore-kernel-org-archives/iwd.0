Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68F14A14
	for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 20:26:26 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so8532775pjj.4
        for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 13:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ecd4WSKnsxwRkeaxJFCq86kDCaceKAaImv7wkDcSUKY=;
        b=ONAxMwihEDEdQ/KNx7RRB0l/6dW62gm/5KoPGkJM+0ICVAxKfcGIccp06oOh9l+pEV
         3QDeTHH4LRsHYVwyftF5i2qkotWEeJ3EaoH7nYfz27Y0+ySkednMF7iCfw1TPooCs3HB
         mFjV4G8DHL5hXO/BiwtErzeraPvhNt53bgP0Xk6F/sjZ6e3a1/ngxmTtXQOtEnBegnIj
         /O/vlMzDyLbj1ScA+Et+btLnhbrNS6bZJlD4fkPX2+GwwcX6wHKRDcvSX30FP04aW8Ev
         KrGJzR4Tv9uEyj4WBX2KMErdpM8vpc/F6iRTzHLrYYb/TXwxww+ZJKv0qecPQJ24pMET
         OODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ecd4WSKnsxwRkeaxJFCq86kDCaceKAaImv7wkDcSUKY=;
        b=4K5V1VTXS0bDevXBASgQUB/bkDuoE01SDXKbo4ZxvesStTviKWvBoz1uM24mYK4+Uj
         UcuRQy74NyrLJsyngaijVQKiMHO45AJgWCKRZl7M80yfTE2xWrOinyVeGyYHIPgQtVd2
         OyR2QD5LiW9yjVIqhJQrzUN7rdoNQd9806Wu3F0HgijZXmLDIlzY30CmYzd3uhyl7+hX
         6paNtSRq3qdHc/nRbfDamHWR+LkPUzhVnx1wYpVcAvPQNFPGHbbEOx9h+j8+wmChoG0u
         tBawKRARbNoCe93J61lukRk33udqqEhyxbs6xoHfqMZCzbnHJDG/IKfbrBKeuVKn6SSZ
         ticA==
X-Gm-Message-State: ACgBeo3tVWU2auANB+/yyVxxQyZhFNVBarLThSEZL9CTuOl7sc392e5L
	Ojrn9FsGMQpCyWCX8/KXDONEvANYbZU=
X-Google-Smtp-Source: AA6agR6u16yLV778QTBOB+J0a3Q9EHg4nTfggLBYc834vqBfDfgU4E5NRXF5OsfVoqAkyVZnck0HxA==
X-Received: by 2002:a17:90a:55:b0:1f7:4513:8cac with SMTP id 21-20020a17090a005500b001f745138cacmr9954547pjb.93.1660940785973;
        Fri, 19 Aug 2022 13:26:25 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090340cf00b0016dbce87aecsm22206pld.182.2022.08.19.13.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:26:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/5] test-runner: double RAM for --valgrind
Date: Fri, 19 Aug 2022 13:26:20 -0700
Message-Id: <20220819202624.1681246-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems 256MB was right on the edge if valgrind was being used and
sometimes the test would fail with OOM exceptions.
---
 tools/runner.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/runner.py b/tools/runner.py
index a96627de..004bf46d 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -370,6 +370,7 @@ class QemuRunner(RunnerAbstract):
 
 		usb_adapters = None
 		pci_adapters = None
+		ram = 256
 
 		super().__init__(args)
 
@@ -400,11 +401,14 @@ class QemuRunner(RunnerAbstract):
 
 		kern_log = "ignore_loglevel" if "kernel" in args.verbose else "quiet"
 
+		if args.valgrind:
+			ram *= 2
+
 		qemu_cmdline = [
 			'qemu-system-x86_64',
 			'-machine', 'type=q35,accel=kvm:tcg',
 			'-nodefaults', '-no-user-config', '-monitor', 'none',
-			'-display', 'none', '-m', '256M', '-nographic', '-vga',
+			'-display', 'none', '-m', '%dM' % ram, '-nographic', '-vga',
 			'none', '-no-acpi', '-no-hpet',
 			'-no-reboot', '-fsdev',
 			'local,id=fsdev-root,path=/,readonly=on,security_model=none,multidevs=remap',
-- 
2.34.3

