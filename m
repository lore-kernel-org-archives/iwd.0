Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954E14C6D
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:19:00 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id s18-20020a17090aa11200b001f1e9e2438cso3828423pjp.2
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ek4+0xhkCQg7JmisIChHW3JfHeFzcT8R9pu89k7ig2A=;
        b=RytMHRJGKYWKrK+m6aC8gfBkpzACdjJlRjYmN9gVKpln4S80C728WtbHaIFqQ4s0Ag
         TjaMbIt3iz7vbUmM8KayeRc5lTuuxiELCGMbfCdaR3Ln8GRxMmDUC9b5ja8yyl6C7jvY
         kHZ/2IrECvwoFr+QgdUbNA7qc0fuF277p2E9xltxQ4HmZnxFt2QoXpxffygND6dtLMHe
         KRmYavuqjxjL99b0R8qwtjyln+4iFOznfGmpmS1zRi8xKw0CzLqCNXdJI2n2Ukh/r1cL
         KhJPQbRyO8pyn2/xeX1Di99AOfDFX9QlpR5ZfZ1L20m7Fg2EoYcyuBTVyy6RAaQOZkBl
         OT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ek4+0xhkCQg7JmisIChHW3JfHeFzcT8R9pu89k7ig2A=;
        b=AHNf+QEulL/ah/HIppB6qfoLvncUFDCfL76mbXNU9fwakCUny1YphzjnSqEpO+/xow
         MCPblgFBHXwsKoNLNloR/xmG3uEDADEnVFZkHSK30vPDykqPKGbwwEeU+dBe4/RjCFWD
         bNx/jCKAFgqmbvuSDSRjZYMHJy6rrefrl/UWuSiORY2ImOAWoHnRgst1NUfITMIwNY7z
         0/Zc8yaGnnBa50tul5sat4pjEXbuJN6Wy5SZ/T7cB9yYXT//puKGzs5ceVAefvV+kIEh
         XjPc/MtWK1B6N4JzFjRajQQ6yxVXR6oyOw6Kf0VGy/f0l+b9drBtQcxl0MoP6GDegWjt
         VkYw==
X-Gm-Message-State: AJIora8vcRhFxxQx/pEwIy6A5EHQpuHu2g0xQSOGvFMz5eElCEHuBOdH
	p5jAJwAzDYV6d6iKv4TudOOX4Qtq4nE=
X-Google-Smtp-Source: AGRyM1uzjYhlbNl+1sv3pNqw3PwaRPGuG5uI02YMbYb/KLJlzSWmZTpph25EGrIZVGKAtzy7UVJpeA==
X-Received: by 2002:a17:90a:fe0d:b0:1ef:b025:cc7b with SMTP id ck13-20020a17090afe0d00b001efb025cc7bmr678865pjb.71.1658254739742;
        Tue, 19 Jul 2022 11:18:59 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902c94b00b0016cdfcdcff2sm7658467pla.19.2022.07.19.11.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:18:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] test-runner: automatically find PCI passthrough config
Date: Tue, 19 Jul 2022 11:16:47 -0700
Message-Id: <20220719181647.452178-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719181647.452178-1-prestwoj@gmail.com>
References: <20220719181647.452178-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When PCI adapters are properly configured they should exist in the
vfio-pci system tree. It is assumed any devices configured as such
are used for test-runner.

This removes the need for a hw.conf file to be supplied, but still
is required for USB adapters. Because of this the --hw option was
updated to allow no value, or a file path.
---
 tools/runner.py | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/runner.py b/tools/runner.py
index cf904412..4f1b64c7 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -115,6 +115,9 @@ class RunnerCoreArgParse(ArgumentParser):
 				help='Writes PASS/FAIL to results file')
 		self.add_argument('--hw', '-w',
 				type=str,
+				nargs='?',
+				const=True,
+				action='store',
 				help='Use physical adapters for tests (passthrough)')
 		self.add_argument('--testhome', help=SUPPRESS)
 		self.add_argument('--monitor-parent', help=SUPPRESS)
@@ -381,18 +384,18 @@ class QemuRunner(RunnerAbstract):
 		self._prepare_outfiles()
 
 		if args.hw:
-			hw_conf = ConfigParser()
-			hw_conf.read(args.hw)
+			if os.path.isfile(args.hw):
+				hw_conf = ConfigParser()
+				hw_conf.read(args.hw)
 
-			if hw_conf.has_section('USBAdapters'):
-				# The actual key name of the adapter
-				# doesn't matter since all we need is the
-				# bus/address. This gets named by the kernel
-				# anyways once in the VM.
-				usb_adapters = [v for v in hw_conf['USBAdapters'].values()]
+				if hw_conf.has_section('USBAdapters'):
+					# The actual key name of the adapter
+					# doesn't matter since all we need is the
+					# bus/address. This gets named by the kernel
+					# anyways once in the VM.
+					usb_adapters = [v for v in hw_conf['USBAdapters'].values()]
 
-			if hw_conf.has_section('PCIAdapters'):
-				pci_adapters = [v for v in hw_conf['PCIAdapters'].values()]
+			pci_adapters = self._find_pci_adapters()
 
 		kern_log = "ignore_loglevel" if "kernel" in args.verbose else "quiet"
 
@@ -472,6 +475,25 @@ class QemuRunner(RunnerAbstract):
 
 		self.cmdline = qemu_cmdline
 
+	def _find_pci_adapters(self):
+		adapters = []
+
+		try:
+			files = os.listdir('/sys/module/vfio_pci/drivers/pci:vfio-pci')
+		except:
+			return None
+
+		for bus_addr in files:
+			if not bus_addr.startswith('0000:'):
+				continue
+
+			adapters.append(bus_addr.replace('0000:', ''))
+
+		if len(adapters) == 0:
+			return None
+
+		return adapters
+
 	def prepare_environment(self):
 		mounts = [ MountInfo('debugfs', 'debugfs', '/sys/kernel/debug', '', 0) ]
 
-- 
2.34.1

