Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A12C7A
	for <iwd@lists.linux.dev>; Fri,  8 Jul 2022 19:03:04 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id i190so10478493pge.7
        for <iwd@lists.linux.dev>; Fri, 08 Jul 2022 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4TX7DF+LSXN3nmESKjhaVPjLIuO7S1w/eytvXP8aCnI=;
        b=MJduSd+PurM4f3ozfDqqBXcPIfYBLEhHVyygwSrNlJskpyTCI+MT6p2XLJCIdM4221
         sH/tAHhncSmndK8fGHwTIhG9PhJ6V5ik8GtMIevWLBHShjKDtYBla2SAn0JydOl+qIrn
         YsaM5hYX/82IOvop8hZxnehByxiwVrS5htXgy34/AOG7YuSvzWDGctMjXYT633AfnwIu
         b5yDKEWIIMvM7Eq0P8cnkwy60qEETWkFvnwHDrLVkYTzfGd0HbvkCY2F3liJEvUH7JWF
         LD7HMNfn4cWEfz/hqEtNr4xTzSBZZeqwblGWbLP41MNRG+GUiGVJW7Y9nQH4qZbqhXtz
         wfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4TX7DF+LSXN3nmESKjhaVPjLIuO7S1w/eytvXP8aCnI=;
        b=pnMgMiQkXrs/m2jxpWUPkUaP2qPsxQMvs1wGudXS9D9I6R45zWbPBA6B4bLYOYcNDh
         XHpTM+s0I3pA2bHoK9L7G72w6/SMgUr6EZ/sDrLA/IM9klWU5w2kFySxHInhUKzhz85x
         A4RpERaexFKGkLOCyZy36nj4Jnj9RnzUZvehaj2H857pdOh8LEv2vuiqMAEKjSQU7qH5
         Qt1VYxDvagyvrHLoR1Q1FHBjbghwgUVcqr9uF7qXUuCf32S7YyOIduz85WRBlU7ZujVX
         zieLmfiZeWF1X7tlSYgI+Xrb0q7jrJsRaWHv3/qBnJIRL0SpWTka37p0Kio6i8ZC2JbE
         RuVA==
X-Gm-Message-State: AJIora8FwGzGMpoBPvM95uX4hD8/DDVJ8zOwbIh6ZK2btpETn+ToGFZm
	Wu+OcRK9wbPh6mhLwTkp+noFTFkGdsU=
X-Google-Smtp-Source: AGRyM1vIocm8XkCG0PGUIKsHaPIgUVrjJvMokhtcTBaBnAAqv6Uadpy+tgvws5yG274a0HiOG8LkPQ==
X-Received: by 2002:a65:5b44:0:b0:412:b6dc:7076 with SMTP id y4-20020a655b44000000b00412b6dc7076mr4354406pgr.601.1657306983233;
        Fri, 08 Jul 2022 12:03:03 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id d16-20020a170902b71000b0016a7b9558f7sm27751500pls.136.2022.07.08.12.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 12:03:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] test-runner: run prepare_environment with --start
Date: Fri,  8 Jul 2022 12:00:54 -0700
Message-Id: <20220708190054.299224-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
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
and execute that binary/script once inside the environment.
---
 tools/run-tests |  7 ++++++-
 tools/runner.py | 24 ++++++++++++++----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index 565847df..8724877e 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -1011,5 +1011,10 @@ runner = Runner()
 
 atexit.register(exit_vm)
 runner.prepare_environment()
-run_tests(runner.args)
+
+if runner.args.start:
+	os.system(runner.args.start)
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

