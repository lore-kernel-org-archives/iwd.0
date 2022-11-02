Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9027708
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:53:44 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id d24so15666pls.4
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJXjzU7LwKU1HEcx49dj6B57EO2Z9OrcgO31E4f6+XY=;
        b=kbbtQDqOqJ+vZEoSV1wbx0howDxxoT+ooeiGdhoIwzX4ONnvGEddRlqQAKUzfljSwS
         UHxj9AAVYJXTvaoG3PADeH5sEgyXQC601bPfA7ueMy3NT/R6nnC3iZFdCur5eueuQE+w
         aztFvKsb9uPdYE1ZoYE8w+SjAvhon2IUbix/vurbLu/bNPqL2bkHAMRVguQRJPYD/cim
         aX+R9J/8gZhmUt/c0yroFw47/tJo59EausOWGx0P3pxmHHbQiSvKEnyUVZPz2zuvJpZc
         hfFl0oXCrLllJx3cwezaU179/gu0UVgKCL9agvJ0ndG5LpfQpV4p67dpPdVhkN7wLRHm
         lJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJXjzU7LwKU1HEcx49dj6B57EO2Z9OrcgO31E4f6+XY=;
        b=hfFvXzHAYea42Y6U4uzsSyX4RGIPR932YZWYKY8G6C7DIv5ivT6j7eO+VLmjim51MD
         hxb9qbpEYN7cIlTkWlpFIxOG5W/oOOeLJxCOXY11nRQn1DCQHYWFfrK2Wx70KEkA9dJG
         GlBT6qTUJWFxVHWrvQlQ7cLXprx66K8Gke2S1bbLAouEy/m6qHeYgFU2DrdxAg7xenjp
         6kfBYJU2fKRJ7FTgT0gxYpEomQOt3iiEZI319sOSh/HpWUzAmqG7yYGlQig2ulT9EwgD
         PoYsggr+0MX78RnAGxxBk3s1ff7XnIOxBD2A8GYV7ii649+wE8oNlnjBx5sgX/QNDyOS
         dgRA==
X-Gm-Message-State: ACrzQf3ItfedwED+YHttu+hNnQHxeH+7aAqTk6k8xeLyp0YQdJtSAKZH
	/C9udL7l4l3CJGASc4qpcjYLjG33wIc=
X-Google-Smtp-Source: AMsMyM4BjrBex43FjkSPgRZk+809aVy9reWfCtZHnCyhI5132daMQhgFfzMTPpTXid7SY2mEA2qxug==
X-Received: by 2002:a17:90b:268d:b0:214:220:ecfd with SMTP id pl13-20020a17090b268d00b002140220ecfdmr13102324pjb.63.1667422423589;
        Wed, 02 Nov 2022 13:53:43 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm8730755plb.26.2022.11.02.13.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:53:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 10/10] auto-t: add AP test for all pairwise/group cipher combos
Date: Wed,  2 Nov 2022 13:53:27 -0700
Message-Id: <20221102205327.268693-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102205327.268693-1-prestwoj@gmail.com>
References: <20221102205327.268693-1-prestwoj@gmail.com>
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

