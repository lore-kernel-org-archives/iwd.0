Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AD021116
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnTRiIYo"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ce28faa92dso7042075ad.2
        for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 06:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699885979; x=1700490779; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HshdV+YMSfhFmt4mGbkArqJLs+jj3+o35weYH0uag8k=;
        b=MnTRiIYoy+IB2a/284nWVa8vWCj4KT9qi2/CzMVX8Xp99aY28MmYN/q5/zpuVe6DxV
         4IDhtk0tpdtNIGnBgzCeh0sAhaXNkwb/ctdZzlPEQ1Hyb0sB9UMMK1AbrOhZiY3t5nbp
         Dm7asr46h+j7mLo2GcHQnsKT7+S78sQnMR1zLDsKWFWTMdG2C4jpvzRPXykpxg3nkToH
         Ud+OrXMBH2A7Axhy+q75DA6hj1QQSL5KCO8hzJCj7gXmnORJZtWFtzT9WfpR+n8ecOD8
         pILtaj1T4n9j9gVBBX0K6dR8zcLy1earvPMx8/17W8+S/pcfCbSQVeohNEJ+8yC9uz2U
         N9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699885979; x=1700490779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HshdV+YMSfhFmt4mGbkArqJLs+jj3+o35weYH0uag8k=;
        b=Hw/5X8RB02ovFm24QsJCWXFAfKo+IwsjBJzbjKNr23FzoFp3yCwN7joWKXIvMzuFNA
         veqDPkNv8+L5mipycPWJeu1hbnnw0PQ8B6uLQWHpRJt4m8NFxlIQHEgK+nueIWgFxen0
         kHsjAYOmWxG5piXCTpkOIrXblzNlAFJrdPHpj9jBPONZyPOA+/l5VCmlmTs+ZmJQQIAw
         67ud8fb/9413NCe5+olb4W9F+eh4ZpwiowbZ5Chpk3Cl6aPuGKwqj0sPU0JYWW8qInHm
         s8md/g6BqZfVVZtijjjWF4vgeoA6jZrjMxkUBGarYLxWOZokxVcan0HfACIMNIvYf7gZ
         QrnQ==
X-Gm-Message-State: AOJu0YwsG0mrqKh0W2GhXN18XWYia+9x4ijOHMjSLB8n6Nc0rUSlbhMi
	1tvomFZUz30I/1hX2e662ZpGiaXAUZM=
X-Google-Smtp-Source: AGHT+IFRP6d9FdCnXJJRPpRnBt2hon3IW9JEMDCeUGs4Wde+Y6NDYJJkzklv4iteLT4DVQyPS+mKOA==
X-Received: by 2002:a17:902:7407:b0:1c5:d8a3:8789 with SMTP id g7-20020a170902740700b001c5d8a38789mr5077055pll.4.1699885978838;
        Mon, 13 Nov 2023 06:32:58 -0800 (PST)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b001cc25cfec58sm4071496plg.226.2023.11.13.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 06:32:58 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] auto-t: make test timeout configurable
Date: Mon, 13 Nov 2023 06:32:53 -0800
Message-Id: <20231113143255.278191-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the addition of DPP PKEX autotests some of the timeouts are
quite long and hit test-runners maximum timeouts. For UML we should
allow this since time-travel lets us skip idle waits. Move the test
timeout out of a global define and into the argument list so QEMU
and UML can define it differently.
---
 tools/run-tests | 12 +++++-------
 tools/runner.py |  7 +++++++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index 32c09723..11ad73c0 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -27,8 +27,6 @@ from utils import Process, Namespace, BarChart
 config = None
 intf_id = 0
 
-TEST_MAX_TIMEOUT = 240
-
 dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 def dbg(*s, **kwargs):
@@ -52,7 +50,7 @@ def exit_vm():
 			p.kill()
 
 		if config.ctx and config.ctx.results:
-			success = print_results(config.ctx.results)
+			success = print_results(config.ctx.results, int(config.ctx.args.timeout))
 
 			if config.ctx.args.result:
 				write_results(config.ctx.args.result, config.ctx.results)
@@ -917,7 +915,7 @@ def post_test(ctx, to_copy):
 		except:
 			pass
 
-def print_results(results):
+def print_results(results, max_timeout):
 	table = PrettyTable(['Test', colored('Passed', 'green'), colored('Failed', 'red'), \
 				colored('Skipped', 'cyan'), colored('Time', 'yellow')])
 
@@ -928,7 +926,7 @@ def print_results(results):
 
 	for test, result in results.items():
 
-		if result.time == TEST_MAX_TIMEOUT:
+		if result.time == max_timeout:
 			failed = "Timed out"
 			passed = "Timed out"
 		elif result.time == 0:
@@ -975,7 +973,7 @@ def run_auto_tests(ctx, args):
 			p.start()
 			# Rather than time each subtest we just time the total but
 			# mutiply the default time by the number of tests being run.
-			p.join(TEST_MAX_TIMEOUT * len(subtests))
+			p.join(int(args.timeout) * len(subtests))
 
 			if p.is_alive():
 				# Timeout
@@ -983,7 +981,7 @@ def run_auto_tests(ctx, args):
 
 				ctx.results[os.path.basename(test)] = SimpleResult(run=0,
 								failures=0, errors=0,
-								skipped=0, time=TEST_MAX_TIMEOUT)
+								skipped=0, time=int(args.timeout))
 			else:
 				ctx.results[os.path.basename(test)] = rqueue.get()
 
diff --git a/tools/runner.py b/tools/runner.py
index 004bf46d..03f44611 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -120,9 +120,12 @@ class RunnerCoreArgParse(ArgumentParser):
 				const=True,
 				action='store',
 				help='Use physical adapters for tests (passthrough)')
+
+		# Hidden options only meant to be passed to the kernel
 		self.add_argument('--testhome', help=SUPPRESS)
 		self.add_argument('--monitor-parent', help=SUPPRESS)
 		self.add_argument('--result-parent', help=SUPPRESS)
+		self.add_argument('--timeout', help=SUPPRESS)
 
 		# Prevent --autotest/--unittest from being used together
 		auto_unit_group = self.add_mutually_exclusive_group()
@@ -385,6 +388,8 @@ class QemuRunner(RunnerAbstract):
 
 		self._prepare_outfiles()
 
+		self.args.timeout = 240
+
 		if args.hw:
 			if os.path.isfile(args.hw):
 				hw_conf = ConfigParser()
@@ -543,6 +548,8 @@ class UmlRunner(RunnerAbstract):
 
 		self._prepare_outfiles()
 
+		self.args.timeout = 1000
+
 		kern_log = "ignore_loglevel" if "kernel" in args.verbose else "quiet"
 
 		cmd = [args.kernel, 'rootfstype=hostfs', 'ro', 'mem=256M', 'mac80211_hwsim.radios=0',
-- 
2.25.1

