Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BEF3206
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 17:01:54 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id y141so10921121pfb.7
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ecd4WSKnsxwRkeaxJFCq86kDCaceKAaImv7wkDcSUKY=;
        b=WlJwklgN2OHTGHZvkSY10v+KOdWdxkiCxgMEIqoOc9u2THnF8d9ARY0WoFeXjL0fM+
         jD6c5yKBILXjkNIPFxooihoX/t4/kkUBlHqXyKUjavujkwTw7X9Q/YNXL2VJG2/X2ryZ
         dAyTLQzr5quEMBxnzUeP5MHZN5zWcCYozyMa14rImGH2uVJEwnYuCIltSmneoQG1S7dY
         3kO21BlqSMx9cfS8sMh64RXusJCPNuh6rRS+1BetS9/EKwXG0Bb2SxkzbqMHpRRFlbC3
         Gb77sqxX9VYRbfCE3eUBTpPSVYlzN3tEjA86XkjuehK1YrUQeq6K19V5uD2KY8qYg7NR
         j3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ecd4WSKnsxwRkeaxJFCq86kDCaceKAaImv7wkDcSUKY=;
        b=XAAY6sJf8/p07oEBijW0kkmXJEZzAPRz36wjIqmmqmXx86n5/OyE1pMbq0EHyFrkQN
         x64TmLYcBzqdae0hswZspuYy11cI2bSziBWV8Yo0gxregMv+3X5H31MfKr26jLAkN2ik
         YuhtKC9XJJxGIyweaKsTEcCC2qJmLHdkbVhXvf0xTHaoLl89uDR8fRTS5MxceDfpgle7
         DX3Cwaw440McGQtX7zxOYt5aeh09vB1aT8C6zyhzvAyA+Fb9rrNbCvq7y+EFiH4vzCPp
         zqcCWioMAst/w2sF3OOOWQYgBIovu/Z//D3DmPudd7xcfFaf47ccVvSAFeqEwhiQ48DE
         MonQ==
X-Gm-Message-State: ACgBeo22ORkJ7a4cixZ7flnOsYlHzvHH+ZrL83t0UbDbzH0dtsm5jUiE
	LSbdXk7YUSddRr/+dMQWxUFdqOZgg40=
X-Google-Smtp-Source: AA6agR7OC6gtnxuHzazkFTaSzE83t7clsce+HJlvh+7EK1aRCli/HYENy+10ELYHvmEjI106YLzAfg==
X-Received: by 2002:a05:6a00:21c5:b0:52b:fc9c:295b with SMTP id t5-20020a056a0021c500b0052bfc9c295bmr22074863pfj.56.1661187713407;
        Mon, 22 Aug 2022 10:01:53 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id d1-20020a170903230100b0016ef87334aesm8691002plh.162.2022.08.22.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 10:01:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 2/6] test-runner: double RAM for --valgrind
Date: Mon, 22 Aug 2022 10:01:46 -0700
Message-Id: <20220822170150.2049490-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220822170150.2049490-1-prestwoj@gmail.com>
References: <20220822170150.2049490-1-prestwoj@gmail.com>
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

