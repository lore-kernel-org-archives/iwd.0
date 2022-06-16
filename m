Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D45A29A0
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 00:02:45 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so10813wms.3
        for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 17:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QECsvCHahf32Qu/R/woSAdr0zJ9HCFgUpWMx5sX8YPI=;
        b=IlokYRFa/0lcOUTHq5FjSkhyges3ZbQ5KnDkJVUg/El0opa0+QpZvY7WrFh9pB0m3u
         XvrHtDtpZ9XE/2otBnhi1mblN45YORhV28G4gRljFoF2WhGriccFM/JwANQKu8J9NKz5
         3Gz/h1eiDVzuKlxKSD6pWGpYpEJdeNoD36Uhbb7XRkZ6Xm6o63hgWqbY1WOcDjjSWmE5
         mEP+Rt62B3kKKMOqw/yit3dIS7/ucMynNX28KXRCPCPAQwd5BC+bu+68QWQdzkoa4kba
         DkenNqtjvnsGGDQcZIbI+NLB30wEX/RNwiUhtrUItl8XCOZ+PtY/t/ndGib4lC+8688f
         I80w==
X-Gm-Message-State: AOAM531rBKlzkuYwHYO1OvbrpbgGOJyCcmhlC/Uv1mUTwompXFktMWZe
	xzCciQdUx6XMFqGdYn3FMwN/5Z6c7K8=
X-Google-Smtp-Source: ABdhPJySAPYwNwkmGcH5FD4AOphgCy08T/XA1OCd9jiGnXvmwsgAc7d9LI1GP1/ZSIgpNvyeuabGcA==
X-Received: by 2002:a7b:ce0f:0:b0:39c:8217:1a5d with SMTP id m15-20020a7bce0f000000b0039c82171a5dmr12483267wmc.101.1655337762997;
        Wed, 15 Jun 2022 17:02:42 -0700 (PDT)
Received: from iss.Home ([82.213.231.20])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm337452wrb.45.2022.06.15.17.02.42
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:02:42 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 05/15] testrunner: Fix parsing for some arguments
Date: Thu, 16 Jun 2022 02:02:21 +0200
Message-Id: <20220616000231.1966008-5-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the parameter values reach run-tests by first being parsed by
runner.py's RunnerArgParser, then the resulting object members being
encoded as a commandline string, then as environment variables, then the
environment being converted to a python string list and passed to
RunnerCoreArgParser again.  Where argument names (like --sub-tests) had
dashes, the object members had underscores (.sub_tests), this wasn't
taken into account when building the python string list from environment
variables so convert all underscores to dashes and hope that all the
names match now.

Additionally some arguments used nargs='1' or nargs='*' which resulted
in their python values becoming lists.  They were converted back to command
line arguments such as: --sub_tests ['static_test.py'], and when parsed
by RunnerCoreArgParser again, the values ended up being lists of lists.
In all three cases it seems the actual user of the parsed value actually
expects a single string with comma-separated substrings in it so just drop
the nargs= uses.
---
 tools/runner.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/runner.py b/tools/runner.py
index 2ce26de0..b018a0ad 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -108,7 +108,7 @@ class RunnerCoreArgParse(ArgumentParser):
 				help='Enables iwmon output to file')
 		self.add_argument('--sub-tests', '-S',
 				metavar='<subtests>',
-				type=str, nargs=1, help='List of subtests to run',
+				type=str, help='List of subtests to run',
 				default=None, dest='sub_tests')
 		self.add_argument('--result', '-e',
 				type=os.path.abspath,
@@ -131,8 +131,6 @@ class RunnerCoreArgParse(ArgumentParser):
 		auto_unit_group.add_argument('--unit-tests', '-U',
 				metavar='<tests>',
 				type=str,
-				nargs='?',
-				const='*',
 				help='List of unit tests to run',
 				dest='unit_tests')
 
@@ -141,7 +139,6 @@ class RunnerCoreArgParse(ArgumentParser):
 		valgrind_gdb_group.add_argument('--gdb', '-g',
 				metavar='<exec>',
 				type=str,
-				nargs=1,
 				help='Run gdb on specified executable',
 				dest='gdb')
 		valgrind_gdb_group.add_argument('--valgrind', '-V',
@@ -156,7 +153,7 @@ class RunnerCoreArgParse(ArgumentParser):
 
 		options = []
 		for k, v in os.environ.items():
-			options.append('--' + k)
+			options.append('--' + k.replace('_', '-'))
 			options.append(v)
 
 		return self.parse_known_args(args=options, namespace=RunnerNamespace())[0]
-- 
2.34.1

