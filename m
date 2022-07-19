Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8574C67
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:18:59 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id f11so12705689plr.4
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQNE1ia2VUIM3+zj5hueqNZxabr1Ll8cgUbflC1qpT8=;
        b=JDiyRCRrYSTPjIbRsANs81g+R75gcW07iICApytr2/XthOqmh8LaHgmEfac4Eh6i8o
         /Z5U/UY8CHe+IIk8L2K5duhD12aerI6rNhpO8yG3M0/bij9dbT8PfxWoA1tS2VtdyuXS
         ioa+JSK5cbh322rdeAj6ylcYZKgT8lCeirz7vB0mCFGavBRH2CwyJHcQS4lnG1/XfpBA
         N+dPWd732uRj8Ex+hqWi/qLsC7AY2s425ZNIpsfe8mRSH2UgqIAY7uRTp2h6H3EvEQJB
         +jrQUiQk3tD+KyNj61k2qE8qRjOJkWdHtySTXZ5kdocJQA1WMafEY1hQn7svTOc7UGHJ
         bCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQNE1ia2VUIM3+zj5hueqNZxabr1Ll8cgUbflC1qpT8=;
        b=FUpkfSQBdc7qscGTLqQ5d9bdF2qzNBprGOWJgc1BsEvPxW1IqsXdP2lKuYPkyexugX
         LhruQ/duSlir0gdb/69briv80S7QjUs4L1wllM3QuohLea83hpbdiCriqxj48tINzq15
         QILTEs0OOod26MZ7aRS9+u33/ii0buqZsNIzga8q4NyeieotKkNmCZnuqPHohUzFMc2S
         AGBP9WA8QYrpStmdlEA4Jokp/nbKi53gQ2vZpBPfooRurSsyVctXQ5e22eKlSCPpiCgg
         hCTi/ovjYKR93Pnv2Th+GGX7wDQ32u1FUYVMxjuQo3rsYKyA4+l151KZeBNmnwRhcn9d
         JcpA==
X-Gm-Message-State: AJIora8OpkE0AbGfgGSEBs2KV17VPhHcQ/KMzURsAhtqVqvPy/g9EgaT
	hy0GCysQ+dcfUMgMEIbiy5nJisRb7xQ=
X-Google-Smtp-Source: AGRyM1v9iuavBLMZlRKKQBcrKea7VcCjG26TDZN9M0uVSm6IkuASTDsFdGssuki+LEK+dvuH8NLNvg==
X-Received: by 2002:a17:902:d2c8:b0:16c:4746:90e9 with SMTP id n8-20020a170902d2c800b0016c474690e9mr34227434plc.98.1658254739074;
        Tue, 19 Jul 2022 11:18:59 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902c94b00b0016cdfcdcff2sm7658467pla.19.2022.07.19.11.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:18:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] test-runner: set up environment with --start
Date: Tue, 19 Jul 2022 11:16:46 -0700
Message-Id: <20220719181647.452178-2-prestwoj@gmail.com>
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

The --start option was directly passed to the kernel init parameter,
preventing any environment setup from happening.

Intead always use 'run-tests' as the init process but detect --start
and execute that binary/script once inside the environment. This also
starts dbus, and sets the right dbus address for any processes started
by the --start script.
---
 tools/run-tests | 12 +++++++++++-
 tools/runner.py | 24 ++++++++++++++----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index 565847df..f59c71fe 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -1011,5 +1011,15 @@ runner = Runner()
 
 atexit.register(exit_vm)
 runner.prepare_environment()
-run_tests(runner.args)
+
+if runner.args.start:
+	ctx = TestContext(runner.args)
+	ctx.start_dbus()
+	os.chdir(runner.args.testhome)
+	os.environ['DBUS_SYSTEM_BUS_ADDRESS'] = ctx.dbus_address
+
+	subprocess.run([runner.args.start])
+else:
+	run_tests(runner.args)
+
 runner.cleanup_environment()
diff --git a/tools/runner.py b/tools/runner.py
index d39b560f..cf904412 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -197,14 +197,6 @@ class Runner:
 			else:
 				args.testhome = os.getcwd()
 
-		if args.start is None:
-			if os.path.exists('run-tests'):
-				args.start = os.path.abspath('run-tests')
-			elif os.path.exists('tools/run-tests'):
-				args.start = os.path.abspath('tools/run-tests')
-			else:
-				raise Exception("Cannot locate run-tests binary")
-
 		# If no runner is specified but we have a kernel image assume
 		# if the kernel is executable its UML, otherwise qemu
 		if not args.runner:
@@ -231,6 +223,16 @@ class RunnerAbstract:
 	def __init__(self, args):
 		self.args = args
 
+		if len(sys.argv) <= 1:
+			return
+
+		if os.path.exists('run-tests'):
+			self.init = os.path.abspath('run-tests')
+		elif os.path.exists('tools/run-tests'):
+			self.init = os.path.abspath('tools/run-tests')
+		else:
+			raise Exception("Cannot locate run-tests binary")
+
 	def start(self):
 		print("Starting %s" % self.name)
 		os.execlpe(self.cmdline[0], *self.cmdline, self.env)
@@ -279,6 +281,8 @@ class RunnerAbstract:
 
 		fcntl.ioctl(STDIN_FILENO, TIOCSTTY, 1)
 
+		os.system('ip link set dev lo up')
+
 	def cleanup_environment(self):
 		rmtree('/tmp/iwd')
 		rmtree('/tmp/certs')
@@ -413,7 +417,7 @@ class QemuRunner(RunnerAbstract):
 				rootflags=trans=virtio \
 				acpi=off pci=noacpi %s ro \
 				mac80211_hwsim.radios=0 init=%s %s' %
-						(kern_log, args.start, args.to_cmd()),
+						(kern_log, self.init, args.to_cmd()),
 		]
 
 		# Add two ethernet devices for testing EAD
@@ -516,7 +520,7 @@ class UmlRunner(RunnerAbstract):
 
 		cmd = [args.kernel, 'rootfstype=hostfs', 'ro', 'mem=256M', 'mac80211_hwsim.radios=0',
 				'time-travel=inf-cpu', 'eth0=mcast', 'eth1=mcast',
-				'%s '% kern_log, 'init=%s' % args.start]
+				'%s' % kern_log, 'init=%s' % self.init]
 		cmd.extend(args.to_cmd().split(' '))
 
 		self.cmdline = cmd
-- 
2.34.1

