Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599704A09
	for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 19:24:37 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso5729709pjr.3
        for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 12:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ecd4WSKnsxwRkeaxJFCq86kDCaceKAaImv7wkDcSUKY=;
        b=ZSCVb0yHhSu5VoWJs9dGYM8YUdiganBGKcc7HI97oqmfc8VSXssWDnyL/9l2HCJY2F
         3N5zqI5Pg63+D4EC4agmtvlW/93GVdU2jZUc6vggTOG04GKbDYJS8CD9FxLJZPDXOlTr
         Y/HY/cWAZylXQonkDXKrqWwg7Z46IzXv/ojyBbMJdbVgaOhakMbUp0FDTA6CXY4MZr3u
         JjDQ/zkuICNwbxOVPg/ripvi+ATZgxxL24hOHR/nmNgNuCfly+pnDUWXLCsELexWgyUl
         TRI9ZoVbzGJE0uaaRGyJa9G134xSEaiISkujHd3XxxSu3uMBxCQZXOUTffLEbq6PNGyT
         yM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ecd4WSKnsxwRkeaxJFCq86kDCaceKAaImv7wkDcSUKY=;
        b=rb0i1vAUr4mWEzKMU5P8upqMBxH/l6N9cCu3zadRUPeWUer8eHo9dpp5gVlcdR8J6X
         EsUX2lrXIj27rttkyQjBNpoAd7DCfHUrPjLGIBlUQ27SGSqhX1XnzK3SD95/GaUX4wTy
         KepMG/IWMHfWhn7l1IgHJUd9mTe1W9Pl6ulILFlWVbDOjl1qxBcCFztePPXpmdor+abu
         imAacACKxqS/OuuwZxm50m5NriUtEr6bPorFJrDJffQxk5I6Rrm1fVwz0bVqpc61Vjwo
         zxAkefFHWdBOh8UUPfyW972rS8aY/DB5fCCQ7DcP4XvqgxqfYzQ0JmWZZoBnS5+QqElp
         Bxkw==
X-Gm-Message-State: ACgBeo1Gn0+bW2qQk5a2Yg+2g5s+7YODcI5lW/j7krhgvrVk3V1xkdh3
	FIZibhIdxEm/8kvxMdSpUP2ecZBFeyw=
X-Google-Smtp-Source: AA6agR7UfD79XdvDgjQ4PaaK4I1xKq+ConT9G+7FgV8OMQl9eWYemuWTiWGIrutIuuq93RkO+P/jYQ==
X-Received: by 2002:a17:902:ba96:b0:170:9f15:b997 with SMTP id k22-20020a170902ba9600b001709f15b997mr8447153pls.34.1660937076521;
        Fri, 19 Aug 2022 12:24:36 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902d14200b0016dbe37cebdsm3472982plt.246.2022.08.19.12.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:24:36 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] test-runner: double RAM for --valgrind
Date: Fri, 19 Aug 2022 12:24:27 -0700
Message-Id: <20220819192431.1605386-1-prestwoj@gmail.com>
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

