Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E947538E
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 16:57:24 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id v16so11470950wrd.13
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 09:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OzTh6igeO54jbl7BgIiqX7fqS3m8ywvuTz5lfA1RBQ8=;
        b=cfmsMWLCBRwPYwuUiQS7FAuYPREh7grHbOnKFvrB8JTHeBjiiMgCBHApTOvrIM9YAm
         7iYHVnGz2pXcimYuOxxkAZQKW9lZJMQyMmWw3/TUplY4NWGLmO/KZbKCaxJtnU9MnH/T
         9tpj1BeRLS4r/4LV7Vzkx0qL8GQa4HRVAu5Jlch0ozcRwcvL6lOdvKNCfJEt9QX30ZX4
         Qsi89LAtnq+71cIIyCl3saUOhBZQXqRINuqX/heCAc8MvyChtWiGaz4zLhIGOioZgoeg
         r9QVewimxCdopV9E7xZWKfUQK0rWiTjWsmppiA/EiE0b2v3H82p1jYX/4FncF1Hc4jsS
         zoQw==
X-Gm-Message-State: AJIora+YHRmyzcowFVKiXvfsuQOGiqLPX/KRAelT/zIlmdySVvgxUK23
	kcMWVKhCDM8uhk8Ab8hCgCRcSMcbI5llr0fW
X-Google-Smtp-Source: AGRyM1tVIlIAKxuRodtoXqDJMvPfUPeX6MXemefJRtyD+HR71VrMEZVyt3QVG2tQMzGePugOuKyKsg==
X-Received: by 2002:a5d:4889:0:b0:21b:293e:9e43 with SMTP id g9-20020a5d4889000000b0021b293e9e43mr38077095wrq.705.1657126643377;
        Wed, 06 Jul 2022 09:57:23 -0700 (PDT)
Received: from localhost.localdomain ([46.222.51.165])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0039c5642e430sm29147856wmq.20.2022.07.06.09.57.21
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:57:22 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 5/5] test-runner: Mark source directory as safe for git
Date: Wed,  6 Jul 2022 18:57:02 +0200
Message-Id: <20220706165702.3241756-5-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706165702.3241756-1-andrew.zaborowski@intel.com>
References: <20220706165702.3241756-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we use git ls-files to produce the list of all tests (without -A), if
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
index f916fba6..c32fbe34 100755
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

