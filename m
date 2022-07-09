Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4F07B
	for <iwd@lists.linux.dev>; Sat,  9 Jul 2022 00:23:52 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id m16so230049ljh.10
        for <iwd@lists.linux.dev>; Fri, 08 Jul 2022 17:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRmMEsrRniIsb2xUYwyLJFwnA82Rgbm9gFYmQA5BYdE=;
        b=h8+21wDNgNgrq9feR5/Udy6/5RcxQDlvgu19V7xOQQ2+hwev9OVriEKTi+YU43MREr
         TK+uqgvk2Dby/GOKbS0+dO39E1gCu9ww96ZjOfergd2/uET/+gGvXjdhnL2W9nOXFJGf
         +8btGiWN+r1Ow7bPobkGDd3+ii3dr9iyv+Q4rTB2FNeBgVysWKzPAn1PfB4MoCNgDUmk
         FtIK1My/mv9GmqMRz+FQQyS8mFYf7qyEayXPPqjRt1mFuZx20NJj4KgF15QMh6ZVmMHT
         9UEK4VmuVqGdotehyF+wqPVqB3LFVo1X4dWyPyrzY3+FUIqxVa/RTBVjAXhr+oYjWWVN
         XWFQ==
X-Gm-Message-State: AJIora/tL2iCdP+30Lj9xIT6BH3h1tagtGAa0P9PMnH+AqZ5sHAGR7Bz
	FrcZi8dkmrIcgYyjNKqS08a8V3SSkfApks7x
X-Google-Smtp-Source: AGRyM1smvJT/4MUiP1qPtkv00t41LtbZTi9jHfqpLVf7x6KxEiEPl+2mGYEAPm32NGd6nSrN6ryOAQ==
X-Received: by 2002:a2e:a371:0:b0:25d:1f18:2c6b with SMTP id i17-20020a2ea371000000b0025d1f182c6bmr3247434ljn.250.1657326230301;
        Fri, 08 Jul 2022 17:23:50 -0700 (PDT)
Received: from localhost.localdomain (public-gprs650242.centertel.pl. [5.184.83.67])
        by smtp.gmail.com with ESMTPSA id f19-20020ac25333000000b00478fe690207sm75603lfh.286.2022.07.08.17.23.48
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 17:23:49 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH v3 4/4] test-runner: Mark source directory as safe for git
Date: Sat,  9 Jul 2022 02:23:34 +0200
Message-Id: <20220709002334.3329502-4-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220709002334.3329502-1-andrew.zaborowski@intel.com>
References: <20220709002334.3329502-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we use git ls-files to produce the list of all tests for -A, if
the source directory is owned by somebody other than root one might get:

fatal: unsafe repository ('/home/balrog/repos/iwd' is owned by someone else)
To add an exception for this directory, call:

	git config --global --add safe.directory /home/balrog/repos/iwd

Starting
/home/balrog/repos/iwd/tools/..//autotests/ threw an uncaught exception
Traceback (most recent call last):
  File "/home/balrog/repos/iwd/tools/run-tests", line 966, in run_auto_tests
    subtests = pre_test(ctx, test, copied)
  File "/home/balrog/repos/iwd/tools/run-tests", line 814, in pre_test
    raise Exception("No hw.conf found for %s" % test)
Exception: No hw.conf found for /home/balrog/repos/iwd/tools/..//autotests/

Mark args.testhome as a safe directory on every run.
---
 tools/run-tests | 4 +++-
 tools/runner.py | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/run-tests b/tools/run-tests
index 76784aa3..5617552a 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -628,8 +628,10 @@ def build_test_list(args):
 	# Run all tests
 	if not args.autotests:
 		# Get list of all autotests (committed in git)
+		Process(['git', 'config', '--system', '--add', 'safe.directory',
+					os.path.normpath(args.testhome)]).wait()
 		tests = os.popen('git -C %s ls-files autotests/ | cut -f2 -d"/" \
-					| grep "test*" | uniq' % args.testhome).read() \
+					| grep "^test" | uniq' % args.testhome).read() \
 					.strip().split('\n')
 		tests = [test_root + '/' + t for t in tests]
 	else:
diff --git a/tools/runner.py b/tools/runner.py
index d39b560f..164bc881 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -36,6 +36,7 @@ mounts_common = [
 	MountInfo('tmpfs', 'tmpfs', '/run', 'mode=0755',
 					MS_NOSUID|MS_NODEV|MS_STRICTATIME),
 	MountInfo('tmpfs', 'tmpfs', '/tmp', '', 0),
+	MountInfo('tmpfs', 'tmpfs', '/etc', '', 0),
 	MountInfo('tmpfs', 'tmpfs', '/usr/share/dbus-1', 'mode=0755',
 					MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_STRICTATIME),
 ]
-- 
2.34.1

