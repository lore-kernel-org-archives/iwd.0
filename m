Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C360746E
	for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 18:06:03 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id jh14so89866plb.1
        for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 11:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6jjr9pRsMf+ATZjr7oXZAwPd0ZnsGdMpclUDg9uHxw=;
        b=HKeUPeEbg2yWkI5pKwN47HTtU+PZUidatjwo/VbQmO//xkDL5/ir3mt765kiO7mfOB
         HPqKQ8C2n24X9+JEWFsAJUGWFMISDtKJbn/63zoOYyPcc9dV7h5V6jPtbzM0QaGoJ1Cl
         VHD8R8u46BR2I5FGeAoZTKd4Tuy+2k7PUm97Pv14GnwZsdgkyMwEDwh9atdC3evr53J8
         PQp9GdZ5w2e2U6mJPfcmquI+6p6m0uOrymJMGYWMwl+KHgdL7+wdtnua5LXmfRXPfMO1
         mP0oh6dPm2kZpCp5Px1G1iNXK7wZui2ifETzvr44Rt+29yShYalQcaHddQyt9nqSzjsM
         LryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6jjr9pRsMf+ATZjr7oXZAwPd0ZnsGdMpclUDg9uHxw=;
        b=OF4nODdgstuaCgMWKIPX0Ryy0lBuzX7f6CCnPnnSVa7A21+HOBkXvkaQ4oI3AaZN7l
         W6xunJPZifl3uSYKQHp9IbySwQLo/IsnkB/ESrp1JuJmU7ulWltsxQ68DdIQPimNrtIg
         EAFZRq6SECqngH7QqjDIhgw/u/y45kPBI6yPkFkd3NlqDA/hxLmI820jd0JtXWaH8JQv
         0DYVCEUQsFzsdPRxh7ckIPEURc5f2RFjKwzzP+yGU7ZFl5DuUiDDbv1HYzfVPMfEn13D
         hP9xcIPQ11SCgjX+t13Pcz1pIeIk2phIBQVtbo2aa+qDese/L1NMH6ck2ONkk/dwIspW
         IaLA==
X-Gm-Message-State: AJIora+nSwUPrN9C/f6QoQoJulxpABOZVdR+1/xdeobFsZaKjV78deK2
	Rolq8V4OFld2rJtj1OL2kd8n4hOXeAM=
X-Google-Smtp-Source: AGRyM1v7rZ3HsA2LScuj+Vz8l0iLz4Qmhl7jR6P7Uoh6tb5nxanayloT1JN0idB5Vdmu9c0G1YojDg==
X-Received: by 2002:a17:90b:17c7:b0:1ed:1a28:8dc6 with SMTP id me7-20020a17090b17c700b001ed1a288dc6mr11744160pjb.224.1656612362681;
        Thu, 30 Jun 2022 11:06:02 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b00163ffe73300sm13777187plk.137.2022.06.30.11.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:06:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/7] auto-t: add client test to testAdHoc
Date: Thu, 30 Jun 2022 11:03:28 -0700
Message-Id: <20220630180331.206419-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630180331.206419-1-prestwoj@gmail.com>
References: <20220630180331.206419-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests iwctl functionality with ad-hoc commands
---
 autotests/testAdHoc/adhoc_test.py | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/autotests/testAdHoc/adhoc_test.py b/autotests/testAdHoc/adhoc_test.py
index 13c0c016..4c5d5023 100644
--- a/autotests/testAdHoc/adhoc_test.py
+++ b/autotests/testAdHoc/adhoc_test.py
@@ -2,16 +2,16 @@
 
 import unittest
 import sys
-import time
 
 sys.path.append('../util')
-import iwd
 from iwd import IWD
+from iwd import AdHocDevice
+from config import ctx
 import testutil
 
 class Test(unittest.TestCase):
 
-    def validate_connection(self, wd):
+    def validate_connection(self, wd, client=False):
         dev1, dev2 = wd.list_devices(2)
 
         self.assertIsNotNone(dev1)
@@ -22,7 +22,14 @@ class Test(unittest.TestCase):
         condition = 'obj.started == True'
         wd.wait_for_object_condition(adhoc1, condition)
 
-        adhoc2 = dev2.start_adhoc("AdHocNetwork", "secret123")
+        if not client:
+            adhoc2 = dev2.start_adhoc("AdHocNetwork", "secret123")
+        else:
+            ctx.start_process(['iwctl', 'device', dev2.name, 'set-property',
+                                'Mode', 'ad-hoc'], check=True)
+            ctx.start_process(['iwctl', 'ad-hoc', dev2.name, 'start',
+                                'AdHocNetwork', 'secret123'], check=True)
+            adhoc2 = AdHocDevice(dev2.device_path)
 
         condition = 'obj.started == True'
         wd.wait_for_object_condition(adhoc1, condition)
@@ -42,6 +49,10 @@ class Test(unittest.TestCase):
 
         self.validate_connection(wd)
 
+    def test_client_adhoc(self):
+        wd = IWD(True)
+        self.validate_connection(wd, client=True)
+
     @classmethod
     def setUpClass(cls):
         pass
-- 
2.34.1

