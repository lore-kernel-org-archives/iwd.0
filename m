Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5295290E
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 20:03:43 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id i18so32936168lfu.8
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 13:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nyOOMm0vK5q6xmBhyRbvIO8XIBPOZlzCmiVd2ZhFPg=;
        b=TTTqfufRPbcH4fGSKBkcJblHXHTkKXm0OOuHg8xsoq9jPGSuMEZDDL5Xi1RkurLjiu
         JUf05IhcES3aCJlnKcD6imzlyUSPXXYWzquFqlpN1DzlvJVyrX1PVu9LGkHwMrVJGdb4
         rP0OeYXdQpkIqJ30JQlu1Dh7HMC/VGskDS5OkqiN34/Du8NZ3djfX2uWzKNIoH139w+L
         zI/ztMXiFFSTWAPBGk4MuieJA+3gk8NiZuUiodhpF2usxA0xshn9n+XAcI94YN8Q6byG
         YGG/CPOVuTCrrqGXPUfx8R0LCDkH9kiUO6PFEPD3dN2bKQc4D0guwEUDC3ulOZM3GsiR
         uuew==
X-Gm-Message-State: AJIora+B3wzY2zD2Qbq2QpH38x0ItOL1nyXULOPdv24TxIxWZeloKLzT
	hQJqNRhcyLj8xQOcGC1+2svcGpT7JEE3ZeDi
X-Google-Smtp-Source: AGRyM1stXCLcavqhY7YV6NaV61Ve8Rg4WwMSDEZDN9RzPA4M9EcB/4IDgjGrAzYJN+YcBMaoNNHjWg==
X-Received: by 2002:a05:6512:260a:b0:47f:ab30:d624 with SMTP id bt10-20020a056512260a00b0047fab30d624mr32219855lfb.326.1657224221418;
        Thu, 07 Jul 2022 13:03:41 -0700 (PDT)
Received: from localhost.localdomain (public-gprs650242.centertel.pl. [5.184.83.67])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b004791e47c5b8sm6525269lfq.175.2022.07.07.13.03.40
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:03:40 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH v2 4/4] test-runner: Mark source directory as safe for git
Date: Thu,  7 Jul 2022 22:03:09 +0200
Message-Id: <20220707200309.3276163-4-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707200309.3276163-1-andrew.zaborowski@intel.com>
References: <20220707200309.3276163-1-andrew.zaborowski@intel.com>
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
index c0f230cb..f409e134 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -630,8 +630,10 @@ def build_test_list(args):
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

