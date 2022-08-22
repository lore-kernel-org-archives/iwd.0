Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9A2597
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 15:58:08 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id y15so6766668pfr.9
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=oaytClLNVcMoG5g/aV/h9Xp5KhfN+snUxmprD+oOSJ4=;
        b=N4ZbToQMj+pNwqelTENzDISWX6yCScl6CI78s0Vs9EAoVJEDs9zulAd79FhV17eD6c
         cqIp51wd4fN9k13ncHJAJVd8bxGtuuiWALgTLoGT2Sku7c77qENrH7fhhLhWv60kuVVx
         1XTvRyR0RaKsVIq8OsvSKHSDm1B/thq0JLVwqnP1HOL0itPf41/7rkuOIehnRAP8fneB
         SnSZ+0mSUf+bIk1JrA3PyEiImH1R+2DxsK1WrxaGpLXhVVQlScVJkWzPDURyj9C2b7LT
         4anNn98kHBI2TJtGocInaiZXpfWFt/I9ruXXGXOQ+DSajsXGw8qH2BG2Y8+LYnLhDBBi
         ho4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=oaytClLNVcMoG5g/aV/h9Xp5KhfN+snUxmprD+oOSJ4=;
        b=a58Yth3UjO88jxouKwiTa4FNnu9LkOWhRe+bOIqkRJOMqNcRxDD61Br5l9eqOz9BMN
         jx8FJv0wedcd+3+1fwOAC54RcDtVilZ1su1vfl8uovmj/WCw/dqHXDEi1Vhy4wuLC7y0
         m6oCKGvHjtMgXb1yp99fv+eYM3qMg/0+ivq7bn7SjN+W29b87P6tQdVPQHcExue+hOd6
         2pAk+wF9NufyS4PXzre0cLfTkq6se9I6j98LqzLX5By7IZVxo9mKkyLTlehci+1+GErY
         NomKHnFo3KoNFPaJqi0sOSdnas1T0JVEzkKUYtWRPJcufljIq/wxUZLX16WuoSgMymmZ
         OYVw==
X-Gm-Message-State: ACgBeo19fxOROalmpp783xgg3BrqYguIhYwN4XH23ih4bN48F5cUN0nN
	Ewn3A4adrUmIiXKEQjnETv0IjP7NnlQ=
X-Google-Smtp-Source: AA6agR7p93LXAv2jmhSEYGnfKYGaci2++2utKp124ZhYYeVpVfsTGsmQj293aGnt+XIwGOtwaRzoSg==
X-Received: by 2002:a05:6a00:4393:b0:52f:3603:e62f with SMTP id bt19-20020a056a00439300b0052f3603e62fmr21309583pfb.23.1661183888232;
        Mon, 22 Aug 2022 08:58:08 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id x64-20020a628643000000b005368192372fsm3216440pfd.200.2022.08.22.08.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:58:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/5] auto-t: remove bringing up lo interface
Date: Mon, 22 Aug 2022 08:58:03 -0700
Message-Id: <20220822155804.2006566-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220822155804.2006566-1-prestwoj@gmail.com>
References: <20220822155804.2006566-1-prestwoj@gmail.com>
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

