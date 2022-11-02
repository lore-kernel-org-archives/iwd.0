Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF662C9C
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 22:51:48 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id l6so16983pjj.0
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 15:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJXjzU7LwKU1HEcx49dj6B57EO2Z9OrcgO31E4f6+XY=;
        b=P1W5DLeKAvgX3V5YUrypOUNwnWIwAqQSF90kjHzikMMWD4gX/ojlVFBnraCEuZrdpr
         +3oA8ilTKeyHrNvCwxLb2RBbIhuMl0Hhz/Ay7Z8XXOZuAB5rGN6nkeVsp+13qD3y7o8t
         KHOeVECQByGfK8BvkZAYpbfm7R+aKV7R8zWKMwibi8UQ9ll97kMgaoaVGLmhaz1JYa3X
         HeFrrHObk3Qfa4GXnTthsqvAw4992cKlI5K0nkNoliQUK3U5OeEriEJ0WO3y6YSpocFS
         8NaaH1iiK1vcjI/yTtB6slyuCNDMHheX4EFcGzavyOwQWGfM0lLKq2i698NRfqMowpbN
         5YLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJXjzU7LwKU1HEcx49dj6B57EO2Z9OrcgO31E4f6+XY=;
        b=cnZB8q5wvodykR1ZHfw0lHT/lhzIONQkAMUaQgK6yHtvfeGg1dCox6PgmBRIWN0rLc
         iyaNTyaW8iLeD/tr5b2iPpy2IDstGtsN9vV3gKQPB2GXoFIM0+9LCJ8R3nHFq/9JC2Lw
         JWVVCZbioaVie+SYbqcmS10bwebouG59n6K/mWaQ6GS8tQoAVhVTW2WtiUBn+VX4wexT
         BuDGfsJhwNvCBsLMtKRoWDZvO0XBjtDx54XAxaYMaeohi8dh2m+PeTDfvgcnvsnnnJkB
         rO66NAJHkK0U8W0BFpZ26QgfVrIuGVhqVW5HtBIDA7sCG14CUcWFbX05NdMPxSoSnfKK
         eulA==
X-Gm-Message-State: ACrzQf1UUh33pMjwa3Kl4xbP/ddtc7lJ01FK3rxz4TNQkJxxODrpJZEC
	74R3Pjmd/rARsZOJwRbASvr+DXVwCEY=
X-Google-Smtp-Source: AMsMyM4U6gNTxKNGvZfbjEbXq/I6teFWihEqe2P/TlZi6n00x0OBTPJMl58dbwCIvgvsMkcqdSjTFA==
X-Received: by 2002:a17:90a:cb03:b0:214:219:b2b9 with SMTP id z3-20020a17090acb0300b002140219b2b9mr13836674pjt.191.1667429507762;
        Wed, 02 Nov 2022 15:51:47 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b00186b945c0d1sm8920377plh.2.2022.11.02.15.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:51:46 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 11/11] auto-t: add AP test for all pairwise/group cipher combos
Date: Wed,  2 Nov 2022 15:51:16 -0700
Message-Id: <20221102225116.297129-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102225116.297129-1-prestwoj@gmail.com>
References: <20221102225116.297129-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Iterates through every possible cipher combination and verifies the
AP can authenticate the clients.
---
 autotests/testAP/TestAP2.ap         |  2 ++
 autotests/testAP/connection_test.py | 36 +++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 5 deletions(-)
 create mode 100644 autotests/testAP/TestAP2.ap

diff --git a/autotests/testAP/TestAP2.ap b/autotests/testAP/TestAP2.ap
new file mode 100644
index 00000000..27f086cb
--- /dev/null
+++ b/autotests/testAP/TestAP2.ap
@@ -0,0 +1,2 @@
+[Security]
+Passphrase=Password2
diff --git a/autotests/testAP/connection_test.py b/autotests/testAP/connection_test.py
index dff415e7..53dcfaba 100644
--- a/autotests/testAP/connection_test.py
+++ b/autotests/testAP/connection_test.py
@@ -1,6 +1,7 @@
 #! /usr/bin/python3
 
 import unittest
+import os
 
 from iwd import IWD
 from config import ctx
@@ -8,6 +9,8 @@ from validation import validate, client_connect
 
 class Test(unittest.TestCase):
     def test_connection_success(self):
+        IWD.copy_to_storage('TestAP1.psk')
+
         wd = IWD(True)
 
         dev1, dev2 = wd.list_devices(2)
@@ -22,6 +25,8 @@ class Test(unittest.TestCase):
         client_connect(wd, dev1, 'TestAP1')
 
     def test_client_start_ap(self):
+        IWD.copy_to_storage('TestAP1.psk')
+
         wd = IWD(True)
 
         dev1, dev2 = wd.list_devices(2)
@@ -39,12 +44,33 @@ class Test(unittest.TestCase):
 
         validate(wd, dev2, dev1, 'TestAP2', 'Password2')
 
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('TestAP1.psk')
+    def test_valid_ciphers(self):
+        ciphers = ['TKIP', 'CCMP-128', 'GCMP-128', 'CCMP-256', 'GCMP-256']
+
+        for group in ciphers:
+            for pairwise in ciphers:
+                IWD.copy_to_ap('TestAP2.ap')
+                os.system('echo "PairwiseCiphers=%s" >> /tmp/iwd/ap/TestAP2.ap' % pairwise)
+                os.system('echo "GroupCipher=%s" >> /tmp/iwd/ap/TestAP2.ap' % group)
+
+                wd = IWD(True)
+
+                dev1, dev2 = wd.list_devices(2)
+
+                dev1.start_ap('TestAP2')
+
+                self.assertTrue(dev1.group_cipher == group)
+                self.assertTrue(dev1.pairwise_ciphers == pairwise)
+
+                try:
+                    validate(wd, dev2, dev1, 'TestAP2', 'Password2', ip_checks=False)
+                except:
+                    raise Exception("Failed with pairwise=%s group=%s" % (pairwise, group))
+                finally:
+                    IWD.clear_storage()
+                    del wd
 
-    @classmethod
-    def tearDownClass(cls):
+    def tearDown(self):
         IWD.clear_storage()
 
 if __name__ == '__main__':
-- 
2.34.3

