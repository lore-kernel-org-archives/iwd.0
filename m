Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E90B746A
	for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 18:06:02 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id r1so51594plo.10
        for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WnNhMt2Hzuc0vXrTWH6rZReuZu7TSMyg/rWTjU3eC/k=;
        b=ZLrC/RgWLFpQ+klLpUAgW+uEB6QMCtUDf9ESeith6fqWOKzH7rNg0NYSP6X/ORw0do
         qTPfQUHgfBRLs5Y0NQSovZyzpVirRhdgGBmpyK4muwv7G9LdMKtiC6pdNvFlS55YdB9I
         4eQ/ZivR2JVxbcmMG3X5P/jcxjymh4d+8OZt0MxLASNWBMFeMt8fOXmQXSEVDbcQkh9y
         a0Hj3GqGQSQB77Phn56qC2FJIGMpQTtLL0lleRb61w3MsEavBznBnaGKWI75lIm32bFX
         wuIBUVKOYfGAcvd/W203BknHfdJAjvNH87RYl/cKudKt4cz3I7q+iBm2AKD24jMWeQLD
         +f4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WnNhMt2Hzuc0vXrTWH6rZReuZu7TSMyg/rWTjU3eC/k=;
        b=sjCgzkR/KLj2lT8N3rJgTwNrzuY+SpLYe18gPp0aihzpMWoAZy5qDA4ZBxUlEG/GwI
         SHUxX5gK9N7PtbJuUP9lX6xSnlWEKSFB8ttVkEljL/vq3Dkw3qtKPi0kgUlmYyfRGGJK
         a38tlvvwm7nEd3xIOvo1hThyXl+xcsE4jVa/498g4ynDlmUw4cqcrmY0GTmMiLmNYg5I
         J35fdwEdT6Fz2OF+UwJiWGW9jpJzR9+GNRRn4XCT6XqcTLd9KxHqSF6+UeLPzU0XRAdj
         Z1uK86mJqMHGdeg0sak73OX58uWo5aXq61tmFy+d3OqTpAMnFNsF8y1V5Nr8Vmt/wtYq
         A2LA==
X-Gm-Message-State: AJIora+s4u52tnRZ0XrxmOAegOhhEWiYy41bDBTWoxDJICB+xEXmBa+g
	1J/8Qyti7nn2Z8ISAJ/S84IgFOGDR6A=
X-Google-Smtp-Source: AGRyM1uom0LM2ofiwkGkjXEPQYkw4IBg+VvhSgq45mFNpfZVX6xajGC1jVazjPPXNGruHMev5nqCKw==
X-Received: by 2002:a17:90a:410a:b0:1ef:3ca7:79a5 with SMTP id u10-20020a17090a410a00b001ef3ca779a5mr4437660pjf.154.1656612361495;
        Thu, 30 Jun 2022 11:06:01 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b00163ffe73300sm13777187plk.137.2022.06.30.11.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:06:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/7] auto-t: add client test to testEAP-WPS
Date: Thu, 30 Jun 2022 11:03:27 -0700
Message-Id: <20220630180331.206419-3-prestwoj@gmail.com>
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

Tests iwctl functionality with wsc commands
---
 autotests/testEAP-WPS/four_digit_pin_test.py | 16 +++++++++++-----
 autotests/testEAP-WPS/push_button_test.py    | 17 ++++++++++++-----
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/autotests/testEAP-WPS/four_digit_pin_test.py b/autotests/testEAP-WPS/four_digit_pin_test.py
index 7bdb57cb..d30492fb 100644
--- a/autotests/testEAP-WPS/four_digit_pin_test.py
+++ b/autotests/testEAP-WPS/four_digit_pin_test.py
@@ -4,22 +4,23 @@ import unittest
 import sys
 
 sys.path.append('../util')
-import iwd
 from iwd import IWD
-from iwd import DeviceState
-
 from hostapd import HostapdCLI
+from config import ctx
 
 class Test(unittest.TestCase):
 
-    def four_digit_pin_success(self, wd):
+    def four_digit_pin_success(self, wd, client=False):
 
         devices = wd.list_devices(1)
         device = devices[0]
         pin = '1234'
         self.hostapd.wps_pin(pin)
 
-        device.wps_start_pin(pin)
+        if not client:
+            device.wps_start_pin(pin)
+        else:
+            ctx.start_process(['iwctl', 'wsc', device.name, 'start-user-pin', pin], check=True)
 
         condition = 'obj.state == DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
@@ -36,6 +37,11 @@ class Test(unittest.TestCase):
 
         self.four_digit_pin_success(wd)
 
+    def test_client_four_digit_pin(self):
+        wd = IWD(True)
+
+        self.four_digit_pin_success(wd, client=True)
+
     @classmethod
     def setUpClass(cls):
         cls.hostapd = HostapdCLI(config='ssidWPS.conf')
diff --git a/autotests/testEAP-WPS/push_button_test.py b/autotests/testEAP-WPS/push_button_test.py
index 08463f15..e2b4c2b2 100644
--- a/autotests/testEAP-WPS/push_button_test.py
+++ b/autotests/testEAP-WPS/push_button_test.py
@@ -4,20 +4,22 @@ import unittest
 import sys
 
 sys.path.append('../util')
-import iwd
 from iwd import IWD
-from iwd import DeviceState
-
 from hostapd import HostapdCLI
+from config import ctx
+
 class Test(unittest.TestCase):
 
-    def push_button_success(self, wd):
+    def push_button_success(self, wd, client=False):
         self.hostapd.wps_push_button()
 
         devices = wd.list_devices(1)
         device = devices[0]
 
-        device.wps_push_button()
+        if not client:
+            device.wps_push_button()
+        else:
+            ctx.start_process(['iwctl', 'wsc', device.name, 'push-button'], check=True)
 
         condition = 'obj.state == DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
@@ -34,6 +36,11 @@ class Test(unittest.TestCase):
 
         self.push_button_success(wd)
 
+    def test_client_push_button(self):
+        wd = IWD(True)
+
+        self.push_button_success(wd, client=True)
+
     @classmethod
     def setUpClass(cls):
         cls.hostapd = HostapdCLI(config='ssidWPS.conf')
-- 
2.34.1

