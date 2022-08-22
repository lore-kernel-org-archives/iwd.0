Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3E2F56
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 17:01:56 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id ds12-20020a17090b08cc00b001fae6343d9fso6197240pjb.0
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=oaytClLNVcMoG5g/aV/h9Xp5KhfN+snUxmprD+oOSJ4=;
        b=Tr0eKbQKNlEr4Kmt0ZWh6sfUgpcoHB5doqY+an+5cDEmj1hueBhJ8FrnoJxAv1uNkB
         99j+HWkQmxWzsDr6+2Uk1hSu60y9yDI82AX2ZdbOJgp2REZYfxV7S0/ApfHV6PxvG3d1
         2tV9GyOl27MUaNI/E/kzN6e8kg+JTFmd3UK+5gkIg+Uv3ZH3WLjwWfMCSoWZT4VI/Zza
         Pt6bawe/Y4vKZZPOAcvEbFK0vyslLOYr3AJLLJsvG3aPT9Idm+sJU64bI3tUtsHa9EEH
         iFJ9qq0gznGTYhOkLgJ/JeXxb7RXTj5KWjCX3heHAC+7k9nwH4F+cTiRTyfJwDEbg2O3
         V8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=oaytClLNVcMoG5g/aV/h9Xp5KhfN+snUxmprD+oOSJ4=;
        b=51eaB2QAcKBDpjJE2XrkXXj0CusZtlkZh+7XWouDkD7hxsJM5xNAGTjIirSoC3qJUQ
         stWHyTDHhIEobEGCWDfzRnG3S2opp8KEaGQADLkhaOYA6BufL21VbRECFY5b6xEipkp6
         CMZKH1Quw2BjCqLdgubOTEDss5aMvh5Yijqg2qYRipbeJhfPAR+tdEEC3L9sMJNXa+By
         0TRC205f4kwrIVc6Svk3XN/K1ks1PoId+sMmQsiXqoMO5pWoq9uZlWu0Pv9PbcTRCryc
         31V7EXIYabibIBYydkk8//KqdzUUe08QpeDDQkp4ah528OrjrMuNXexq4fdb/9vhwHKI
         ebjQ==
X-Gm-Message-State: ACgBeo2qCmZOqZAD+4qEx/XGDVnK6EA8csUPZJoOXJWTH4TkzXMiuVea
	4Ijk/snUR5ReIW0lMuV5x20H8Gset4w=
X-Google-Smtp-Source: AA6agR7sW4VoBL0vzbhXcfrE6umQ7/EJxW3G3nnjr1xhJ6IrfdkywF/ikr/019g4vjL42z2XHfN0Yw==
X-Received: by 2002:a17:902:7d86:b0:170:a752:cbd1 with SMTP id a6-20020a1709027d8600b00170a752cbd1mr21028938plm.17.1661187715559;
        Mon, 22 Aug 2022 10:01:55 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id d1-20020a170903230100b0016ef87334aesm8691002plh.162.2022.08.22.10.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 10:01:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 5/6] auto-t: remove bringing up lo interface
Date: Mon, 22 Aug 2022 10:01:49 -0700
Message-Id: <20220822170150.2049490-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220822170150.2049490-1-prestwoj@gmail.com>
References: <20220822170150.2049490-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several tests were setting lo up which is already done by
test-runner.
---
 autotests/testFILS/fils_256_test.py           | 2 --
 autotests/testFILS/fils_384_test.py           | 2 --
 autotests/testFT-FILS/connection_test.py      | 1 -
 autotests/testPreauth-roam/connection_test.py | 2 --
 tools/run-tests                               | 3 ---
 5 files changed, 10 deletions(-)

diff --git a/autotests/testFILS/fils_256_test.py b/autotests/testFILS/fils_256_test.py
index 5fa371e1..7018f0f2 100644
--- a/autotests/testFILS/fils_256_test.py
+++ b/autotests/testFILS/fils_256_test.py
@@ -62,8 +62,6 @@ class Test(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_storage('ssidFILS-256.8021x')
-        os.system('ip link set lo up')
-        pass
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testFILS/fils_384_test.py b/autotests/testFILS/fils_384_test.py
index b7174418..ce8904df 100644
--- a/autotests/testFILS/fils_384_test.py
+++ b/autotests/testFILS/fils_384_test.py
@@ -62,8 +62,6 @@ class Test(unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_storage('ssidFILS-384.8021x')
-        os.system('ip link set lo up')
-        pass
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testFT-FILS/connection_test.py b/autotests/testFT-FILS/connection_test.py
index b1ec42e0..5d60bf4d 100644
--- a/autotests/testFT-FILS/connection_test.py
+++ b/autotests/testFT-FILS/connection_test.py
@@ -122,7 +122,6 @@ class Test(unittest.TestCase):
 
     @classmethod
     def setUpClass(cls):
-        os.system('ip link set lo up')
         IWD.copy_to_storage('TestFT.8021x')
 
         cls.bss_hostapd = [ HostapdCLI(config='ft-eap-ccmp-1.conf'),
diff --git a/autotests/testPreauth-roam/connection_test.py b/autotests/testPreauth-roam/connection_test.py
index 3c8fa0bb..02d03361 100644
--- a/autotests/testPreauth-roam/connection_test.py
+++ b/autotests/testPreauth-roam/connection_test.py
@@ -75,8 +75,6 @@ class Test(unittest.TestCase):
     def setUpClass(cls):
         IWD.copy_to_storage('TestPreauth.8021x')
 
-        os.system('ip link set lo up')
-
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
diff --git a/tools/run-tests b/tools/run-tests
index e45ffe46..9620ed1f 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -487,8 +487,6 @@ class TestContext(Namespace):
 			print("Ofono or Phonesim not found, skipping test")
 			return
 
-		Process(['ip', 'link', 'set', 'lo', 'up']).wait()
-
 		os.environ['OFONO_PHONESIM_CONFIG'] = '/tmp/phonesim.conf'
 
 		phonesim_args = ['phonesim', '-p', '12345', '/usr/share/phonesim/default.xml']
@@ -889,7 +887,6 @@ def post_test(ctx, to_copy):
 			elif os.path.exists('/tmp/' + f):
 				os.remove('/tmp/' + f)
 
-		Process(['ip', 'link', 'set', 'lo', 'down']).wait()
 	except Exception as e:
 		print("Exception thrown in post_test")
 	finally:
-- 
2.34.3

