Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F912F29
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:18:05 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso28751pjg.5
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zyWsO69TtCZ4q7JEd0HyoJwfnBzszoXMTkRuGBLKzk=;
        b=QiT6NBIEODijUVuRhJi9yNN6QeaiPvERu+F1ENv4rRHlrgO8gzmdeAxQeNw7gGwn+G
         bQ5XENFS2HUga9KUm+5K8nLKKkadnoRiSRsQx6aMYJ+T4545qaWfe+Dk+HsLSB5SmXYp
         +ZjTXWZJSTS8g/99Q1CtEbTIIfCb3dMmB4GGdP2SfEevalj27BahTPccA3tAHuy4qTQ8
         xBdTiIGbMppO0ICeykrdZ+kQQrXlhvTRr0mbyUm1b+w/Qqiv3XWI6HwYfDZCAHWiHLg9
         LAcPqwrfYwZjp8jb3ZZrGWQ3JnqIteqiQnvmyDoivz5VBVXTn3FfBkHFrr6jp8+RYByQ
         Pq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zyWsO69TtCZ4q7JEd0HyoJwfnBzszoXMTkRuGBLKzk=;
        b=0zE8l2KhEIbV+U8U/C6nx2U9Z6v0HBw45dvhn9TAiHXVMHVlezMpymccp+K2CnPWkN
         MXBPgzmWcIQzIn8+4a8DD9leCjRADXP/TNHSfTUHlVMJLQoUkdmoTF0GY1F0LMJAnupJ
         z3NHj7tCElnhDH15S5qli19lBetR4Fe3nXGrqzxbrRkhaJ3WxLscK5oeOj/tbfERZC9L
         lQoKRemz3g7ACmgNQPJCUokNM1s+MedODyjG0TJ+UBIuxclr682enJ1ybpEyclxsXieG
         F9J09m4QalzEMpCQHIiMvlwXZ+D/hXlDVdpoLlg2lg8tzJMRJaK359JoFSEEopzyrLBg
         cIzw==
X-Gm-Message-State: ACrzQf2/U2hWQlvj7AhFSw71wSTrtCyVRnFRZJXDUxMY5HuE7ynsqf8N
	3YYmfIp46j6CxkOez+8ZoX8OOJimkLU=
X-Google-Smtp-Source: AMsMyM55yVM45w4/vrx4JGkmxAJhYdThR6b7LfolGXI4sA8FsjeKiSy7QYKfOVGZBJpfsR53izvoQQ==
X-Received: by 2002:a17:902:7689:b0:187:48d:d9be with SMTP id m9-20020a170902768900b00187048dd9bemr781226pll.102.1667333885069;
        Tue, 01 Nov 2022 13:18:05 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:18:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 17/17] auto-t: add AP test for all pairwise/group cipher combos
Date: Tue,  1 Nov 2022 13:17:47 -0700
Message-Id: <20221101201747.143379-17-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
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
 autotests/testAP/connection_test.py | 33 ++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/autotests/testAP/connection_test.py b/autotests/testAP/connection_test.py
index dff415e7..297a8aa2 100644
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
@@ -39,12 +44,30 @@ class Test(unittest.TestCase):
 
         validate(wd, dev2, dev1, 'TestAP2', 'Password2')
 
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('TestAP1.psk')
+    def test_ciphers(self):
+        ciphers = ['TKIP', 'CCMP', 'GCMP', 'CCMP-256', 'GCMP-256']
+
+        for pairwise in ciphers:
+            for group in ciphers:
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

