Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5667B747D
	for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 19:24:39 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id c2so4932270plo.3
        for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=oaytClLNVcMoG5g/aV/h9Xp5KhfN+snUxmprD+oOSJ4=;
        b=psBxpOzP0Bb0cj01TH18yvRzUnfqVOpGIIv59XQFSccyrztaAH5hCxvv2GK/XMFJjx
         m24g/FTt8jPSCIG5HdL96T0z9ih5vf3XgSvI13fu0ckvUnO6XPVIqhfdYioHCSkRBIuP
         bZhjcWB5W82yAYkvtdvfdLcAI60dfJFiB5sFdnTZnKkA2CgN77Ia0pzb53oDnbYYPCyc
         ajp95D9Pebst1tI+OzOWQMVGXeLmpfpqF4SCBgA8WcsBssYgNMNEurcdMcL9rlaYzCZF
         DddHrI7IrFn5/4eHSsbI4t9zJC6lJ8LWrO6w79HVDDmfol6+ewrBomZQZQkDbFx08bek
         WGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=oaytClLNVcMoG5g/aV/h9Xp5KhfN+snUxmprD+oOSJ4=;
        b=4Wy2qgDdrgn1umBNo13ZhuEPeU93wBKVGVqYCgL+wG796zef6QVc/TnrPedr/MJCbm
         K92DCAghnfMR21MHnEI/1+SEvqSHmWYqyRezw8a7gC/FNqXhJmTN/MmLhbaesdTMppVC
         +xEKHvFMDe7W05eIQjVgLwghqrj8to4V1eWzCOOvPifrb6bVPCfP5eOoQLp8gsIFj2Ig
         jrrOdegbADBkPn0cNHy8yqwhqsdd7CwQL36Wmdiv5y9Ev4RkL9zruJMrMqzl0W9rP9rV
         uZ6Izqa0LvhOLo+MrzCt6RvfK8SL/xn3XOK6SzUL3AdlhJDOlQ87lzELphxw2sh1YdHY
         4Q5w==
X-Gm-Message-State: ACgBeo3yNppfEPBrHm1xY/bdVYwC5r3sLTaLOdvnGt/+SrbjQdDca2X0
	4sIq2L0cyC56ldXdKs/Vj4LeLbrjogg=
X-Google-Smtp-Source: AA6agR7IQUpZ02b9Z6BQ1eUFmTge/cR3kpFogExr41yG7Gu1yNg3h+WtbbcwDI6b07G11aQ6w2IKHA==
X-Received: by 2002:a17:90b:4b0d:b0:1fa:e712:dd53 with SMTP id lx13-20020a17090b4b0d00b001fae712dd53mr4366541pjb.10.1660937078673;
        Fri, 19 Aug 2022 12:24:38 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902d14200b0016dbe37cebdsm3472982plt.246.2022.08.19.12.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:24:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] auto-t: remove bringing up lo interface
Date: Fri, 19 Aug 2022 12:24:30 -0700
Message-Id: <20220819192431.1605386-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220819192431.1605386-1-prestwoj@gmail.com>
References: <20220819192431.1605386-1-prestwoj@gmail.com>
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

