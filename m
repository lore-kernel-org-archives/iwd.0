Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5547E4A14
	for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 20:26:28 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id y4so5042154plb.2
        for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=oaytClLNVcMoG5g/aV/h9Xp5KhfN+snUxmprD+oOSJ4=;
        b=cPjUj5ODfsyQSttbh+qHInke3K+a7IpHZyHseo+Yu9VCIAjet3gDpM0HXzlw6PLM4L
         UjLTx6w3wj/ECPaCMxHJdppR6KC8+7uw7T4nBcaY0LyBnZ3RUOR5Va8/xszugo70Hy/0
         ur6EqNO5iBcbyVxyR3DoqO+eQZRPQJ/Ixza2wmTqxHiERcVuUhoNTjWcpVxjyzwq4LTX
         uJc5k0qpKnJklaDRNe9qzub7KoNoH5iMu6aGIY1H1RQKDm7TOI34z+YjQ6N6ScdXMYr4
         divZMhwlp0InxK152mwZDejV4VK15UGLKVqe/VtbkwUvPhxi3OVZMeYuTyekDvoypv5n
         VoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=oaytClLNVcMoG5g/aV/h9Xp5KhfN+snUxmprD+oOSJ4=;
        b=NKiyGt0z9wvNwIwJnnike+qYoXKvU3BEsUR+iJb0bn60B/9WAb2/QXil2/8aWuaYvh
         pSYB1fGo0L0WI2fu2TKeBzpsQTpyKDlA7JBMFa6q6AfsfdZDoAXjID0/mw0OlpNTA0K4
         A78Aorpg5So30lC7it2CncG5t0asPpcGqXVUQGQdHFZS3aud7pDw6HR0WGhzbPKzT6Qa
         ACVf8A+LHOSlJ8tOKCdg8muHNU9tEECOMrfMzkHJHQjeSWQrK8Ef0UQeGkUL2t2Wj3cG
         vCH7H37yTvgqB5JGaKtBzeAai2HvVAN79XKZbqLM2FgMI1nkDgG2V06kT9VcfwRStDUy
         AEng==
X-Gm-Message-State: ACgBeo0tHdo0TyCSFVq+LTijSY64xLxNqK3pcwf3H5D7qYB7SeBTyP2f
	YbuvT5/CdlyWtYTlVyvAZ3cTmXustFM=
X-Google-Smtp-Source: AA6agR4mhXjUfhFS6A3A3BGeXFnZdNOzZ4uQrRnQmD+CjXE9e6XmEKOHzpgKGauthKDw+Bo4Ym7cvQ==
X-Received: by 2002:a17:90b:3ec9:b0:1f5:7e38:1fd1 with SMTP id rm9-20020a17090b3ec900b001f57e381fd1mr15620671pjb.101.1660940787641;
        Fri, 19 Aug 2022 13:26:27 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090340cf00b0016dbce87aecsm22206pld.182.2022.08.19.13.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:26:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/5] auto-t: remove bringing up lo interface
Date: Fri, 19 Aug 2022 13:26:23 -0700
Message-Id: <20220819202624.1681246-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220819202624.1681246-1-prestwoj@gmail.com>
References: <20220819202624.1681246-1-prestwoj@gmail.com>
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

