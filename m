Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016114C77
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:54:34 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id d10so14407611pfd.9
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HKl1b/ejItKZ5TTLj5Wx8Qae7xzWuFe4b+FguWIrLE4=;
        b=AYA8Q0ibBvHKVha0CjYnQWoX60nVYeqmbg486n65T+JD9W0LnP/lJN8hykYVQnv4G4
         UICweNr2fArJsZJm53iqhoTx/ZjfxFxzZrSDQwZn0K/8eWNRZAUaQPOXC2UvbjWkfYgm
         ZHF2Zulhau3qMy9tk5nMFeJbVtC58omW0NLsquVtjIAdpe16WKgX2rSomEh/xBBN7bCB
         5KRx6KWk+QW8VnitcIUF00YKZpkBTgg+E0c92lXRyhcahKNHHoA2t3NLFuVST5v5TKtp
         JhYLxLZ6609J+xmWxFoP4N4d/eC1e7A2GSWgtA0sK0GK6+ub2KWb2fRaicMqU7P72q2N
         KYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKl1b/ejItKZ5TTLj5Wx8Qae7xzWuFe4b+FguWIrLE4=;
        b=J5nTa0SQ3y+/5AfFZY6sHykTF12IVDW+36BJtoPQwiDl/mwif2AylyyA2qENOBNvjN
         18S7ZK84QPvwdb0j2Xnxhxmde7lTIw1WCFWBIVr4j1lYa04YjBi7QOYZDLt/VXMZYeV5
         +LZIC8gsVdGulGs/vfwBZJ8qrPbh6SDMT37atL4okrrTgHBvh5ffbkILfAv4QRqs25xs
         fkfI687GJbepgyPmYdK6v6PXpMHgRo33ONxC3+6sROvYpCMmY+W4RZPlbFDVR3WpeeHw
         Z+J0gJJeqjskwrwOFsB17VlcorpqPqsGM3k78yyuu3ezlxStYGknx0vOhBdONUQEMuyn
         +5Wg==
X-Gm-Message-State: AJIora8IQYv8afsB3HjkZ6s6XfZS/7Qrh6t+j0XDCoC/Ai++h6xxx/Pc
	iuAGgkDIA3Xhz+/9M850WOyaE7IxBEk=
X-Google-Smtp-Source: AGRyM1vhRbijaagATXdczOfxkWqQEJLjpOOAsU9ptvKEQL57TCxE+xqwVDqsc2sSn7HBt+dUnmzimg==
X-Received: by 2002:a63:2b84:0:b0:412:5277:99dc with SMTP id r126-20020a632b84000000b00412527799dcmr29708263pgr.208.1658256874266;
        Tue, 19 Jul 2022 11:54:34 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id w24-20020aa79558000000b0052af2e8bba3sm11851616pfq.37.2022.07.19.11.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:54:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] test-runner: automatically find PCI passthrough config
Date: Tue, 19 Jul 2022 11:52:23 -0700
Message-Id: <20220719185223.456197-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719185223.456197-1-prestwoj@gmail.com>
References: <20220719185223.456197-1-prestwoj@gmail.com>
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
index f5667959..a96627de 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -116,6 +116,9 @@ class RunnerCoreArgParse(ArgumentParser):
 				help='Writes PASS/FAIL to results file')
 		self.add_argument('--hw', '-w',
 				type=str,
+				nargs='?',
+				const=True,
+				action='store',
 				help='Use physical adapters for tests (passthrough)')
 		self.add_argument('--testhome', help=SUPPRESS)
 		self.add_argument('--monitor-parent', help=SUPPRESS)
@@ -382,18 +385,18 @@ class QemuRunner(RunnerAbstract):
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
 
@@ -473,6 +476,25 @@ class QemuRunner(RunnerAbstract):
 
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

