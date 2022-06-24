Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BAD46B7
	for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 23:09:56 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id 128so3733762pfv.12
        for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 16:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vL0Nb2ytaedeC/42KgKCrIPvf7+iIShRCjksTpLYMcM=;
        b=lE3+uZuVFKTphC59VdL2xpuecI6lWpDffKmGLlZ+5KE9fXGkVtruwHRtMIGclptlcL
         mh4PKgJKAtv8XozDRVgaRF2vOFX8oa6DXiqMlzaD30H37cjhHYtbsU/km4heknZ08U1i
         FQVAIWEVOn9ukMFL3mGwUt+ZX5mAUhwWSsmqcl1FrCBO+qNVKb+639Nd6yA1RFy23Qru
         Nx78kLHg3qHUXk0rdxJzqW6LfD9x/u/Sc60QvL6SNUAgy7HXwL0cYAG48GEcjrG33Hn5
         2+03SAxkRO6La3NDb3KQ08nwnLXzaLyiYdX3Q7v12VKbVmPHEOQPMUS6xhG78sd9mvrF
         VL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vL0Nb2ytaedeC/42KgKCrIPvf7+iIShRCjksTpLYMcM=;
        b=pEeWI7A8XPqL6DYRQkIgH+Z7gMSUmD7/81xN2qLPSoavqa2ETt1yej2GA4AeCKAX0f
         LLJ0j/nbD2mAKY/ZZZeJbSZFd3DYSBhagAlJCUJwu65OgF1nJNM0c3qPaJeJ/Iigj6It
         2AaXdidIltG100dT/nf6NnbxEnTyB5FtbqIeVPt4uf0SSsnt7N5+7t/yXH8GMizPGxAv
         OnGinn15pkxLAOJbFvwkr70/ti+mNhDEFlNM5qDpNkhkC1GCkwDqKYUR57qbBs5txob6
         TCLRxnUJwH/VoFg0OjlmvJKc+xdZku9LZitpZIUUCMLtmb/1oG27VTeD0OndcFCATcPs
         1QRw==
X-Gm-Message-State: AJIora8191bNlfNb7hlucK6Zr37zuTxKJf2718XlqW+CZnTQMu/Jf7XG
	oPw3jJnaU2964CNO7KXFXV3BXN6c+7w=
X-Google-Smtp-Source: AGRyM1tHeJEc80AuFMk+DtwPOnNbjS1RInCbdBKiR1z63lWrARCNcAiyg4r9VZUcgCCGfmKXb2xA8A==
X-Received: by 2002:a05:6a00:17a8:b0:525:537a:b0df with SMTP id s40-20020a056a0017a800b00525537ab0dfmr1473977pfg.71.1656112195607;
        Fri, 24 Jun 2022 16:09:55 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id 64-20020a17090a09c600b001ec9ae91e30sm4449767pjo.12.2022.06.24.16.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:09:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/8] test-runner: fix UML blocking on wait_for_socket/service
Date: Fri, 24 Jun 2022 16:07:36 -0700
Message-Id: <20220624230741.1957863-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624230741.1957863-1-prestwoj@gmail.com>
References: <20220624230741.1957863-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In UML if any process dies while test-runner is waiting for the DBus
service or some socket to be available it will block forever. This
is due to the way the non_block_wait works.

Its not optimal but it essentially polls over some input function
until the conditions are met. And, depending on the input function,
this can cause UML to hang since it never has a chance to go idle
and advance the time clock.

This can be fixed, at least for services/sockets, by sleeping in
the input function allowing time to pass. This will then allow
test-runner to bail out with an exception.

This patch adds a new wait_for_service function which handles this
automatically, and wait_for_socket was refactored to behave
similarly.
---
 autotests/util/iwd.py |  3 ---
 tools/run-tests       |  5 ++---
 tools/utils.py        | 26 ++++++++++++++++++++++++--
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index f609e37e..aae57733 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1097,9 +1097,6 @@ class IWD(AsyncOpAbstract):
             self._iwd_proc = self.namespace.start_iwd(iwd_config_dir,
                                                         iwd_storage_dir)
 
-        ctx.non_block_wait(self._bus.name_has_owner, 20, IWD_SERVICE,
-                                exception=TimeoutError('IWD has failed to start'))
-
         self._devices = DeviceList(self)
 
         # Weak to make sure the test's reference to @self is the only counted
diff --git a/tools/run-tests b/tools/run-tests
index 2b3b1f2e..565847df 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -326,9 +326,8 @@ class TestContext(Namespace):
 			# register hwsim as medium
 			args.extend(['--no-register'])
 
-		self.start_process(args)
-		self.non_block_wait(self._bus.name_has_owner, 20, 'net.connman.hwsim',
-					exception=TimeoutError('net.connman.hwsim did not appear'))
+		proc = self.start_process(args)
+		proc.wait_for_service(self, 'net.connman.hwsim', 20)
 
 		for i in range(nradios):
 			name = 'rad%u' % i
diff --git a/tools/utils.py b/tools/utils.py
index 7272c1f9..f3e12a85 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -9,6 +9,7 @@ import dbus
 from gi.repository import GLib
 from weakref import WeakValueDictionary
 from re import fullmatch
+from time import sleep
 
 from runner import RunnerCoreArgParse
 
@@ -213,7 +214,24 @@ class Process(subprocess.Popen):
 		self.write_fds.append(f)
 
 	def wait_for_socket(self, socket, wait):
-		Namespace.non_block_wait(os.path.exists, wait, socket)
+		def _wait(socket):
+			if not os.path.exists(socket):
+				sleep(0.1)
+				return False
+			return True
+
+		Namespace.non_block_wait(_wait, wait, socket,
+				exception=Exception("Timed out waiting for %s" % socket))
+
+	def wait_for_service(self, ns, service, wait):
+		def _wait(ns, service):
+			if not ns._bus.name_has_owner(service):
+				sleep(0.1)
+				return False
+			return True
+
+		Namespace.non_block_wait(_wait, wait, ns, service,
+				exception=Exception("Timed out waiting for %s" % service))
 
 	# Wait for both process termination and HUP signal
 	def __wait(self, timeout):
@@ -423,7 +441,11 @@ class Namespace:
 		if Process.is_verbose('iwd-rtnl'):
 			env['IWD_RTNL_DEBUG'] = '1'
 
-		return self.start_process(args, env=env)
+		proc = self.start_process(args, env=env)
+
+		proc.wait_for_service(self, 'net.connman.iwd', 20)
+
+		return proc
 
 	@staticmethod
 	def non_block_wait(func, timeout, *args, exception=True):
-- 
2.34.1

