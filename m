Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28776256C
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 15:58:07 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id m2so10329463pls.4
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 08:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ecd4WSKnsxwRkeaxJFCq86kDCaceKAaImv7wkDcSUKY=;
        b=LizSFMGJIbrVMh8vs5Y5t/ub1TV+fTZbhI/Ob+NxYlABDcDiDY1Jl8T/f4QD/ZrL+F
         ZfjZf3lSybneOZ4KOkDlJYZjyqGkBZKR0iEJOVMDemWu8B+t09YGPS75fZy7eaV7+WEI
         t9+zY6QfVfNk99CvXLqPf5wYx6j0CmDt3oWl+ro8RBTbj820LplwGCjolwicSCmPqK7V
         qw/9kAS4dhNBKdywfyYGWVGJSy+2gVtnOXJtwsFb/lec/oCwbl023FxB4BqykyLjsrU9
         LUnCyIdvagVXuYttHTzr1YQRI2SxaX41YxmR0KZk1yv6hiM/HLYuL3zE3rgfzCK8Uofy
         ltlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ecd4WSKnsxwRkeaxJFCq86kDCaceKAaImv7wkDcSUKY=;
        b=Au5ik4mLq7z/xgpNS2dp0qt7ikyO/AcIU/4uT2Ge02/gupljHeulT27+Sl+QeM7enJ
         6j5i0yHDeeo/UlvWhIBucGftyIoVqh8LCzaBEdDpipxbioaKwYRWK1O/hwuMIVOt1kWy
         EHLy2PwRQOpKX7ctokNoNZX7SnD4HtFVTNp5xFEzsmR1XbYgnHpOm2swpAHcATE/SX2o
         Yh4HsTVWAe3WyHX47wup4ripRT1f5vfB8Bvmo/t9kOAAc74r2Sgq9iEY7k1cAQMjeWRu
         q00a4tNF9Nl+Oz3nVIV42fu8Gm9dXVbmpMoESXDr3lOZmcAUn0EGPoL1Bzchb26NeflT
         Trtg==
X-Gm-Message-State: ACgBeo0t0S63hTa45al/RyZcqItZgPZCW99VhuyXHcsSK8XAYqz5mkyP
	kBdNWqC/n1euYU72DFF3DVIjr60dK2k=
X-Google-Smtp-Source: AA6agR5DNro9VDC/KQYGi5S9GpJtf84GY//XK4PgyiFKiyPj2R7vHCUuShuXdseSZACzbnZktxQ1AA==
X-Received: by 2002:a17:903:1209:b0:16b:81f6:e952 with SMTP id l9-20020a170903120900b0016b81f6e952mr21368195plh.48.1661183886320;
        Mon, 22 Aug 2022 08:58:06 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id x64-20020a628643000000b005368192372fsm3216440pfd.200.2022.08.22.08.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:58:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/5] test-runner: double RAM for --valgrind
Date: Mon, 22 Aug 2022 08:58:00 -0700
Message-Id: <20220822155804.2006566-1-prestwoj@gmail.com>
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

