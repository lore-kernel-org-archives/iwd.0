Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D64681
	for <iwd@lists.linux.dev>; Thu,  6 Oct 2022 17:40:43 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id gf8so2322943pjb.5
        for <iwd@lists.linux.dev>; Thu, 06 Oct 2022 10:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A5ednJFm6bvGk44o3ODFwgwZOuuJlGnV0uttpvZ8Mlo=;
        b=kRRzmtoNZHzHm23sHq+Y/MUd8TujkotIniEIbMFVswpxifsrwKYOBi6JRjlzaqLNjQ
         d/ZcE/ia+j9ZODQ27pMZKgAwlvC/rPg6R1nLFLgEcNG1w+CO2oFYG5xEmHSaFQDmiKWj
         R3ftfV5zM4rzrJrTIPohX7IAm3MdUzX/1S7tJT3GTaUhvZlANYHObXRDkfEcBwOXRnxW
         qshi0Q/4T18Cp6Ky8A+OY4d99UN/LXssn/Hs4ZhCHlYD9ncdASB7zWVQE3hX+Be8kO6R
         xWa0ufNfddtBxkzYW2BtFao4nqzVkYJWtTRXRTSvSuLBjYvjRoeg9jbLKHnEX8q4sU1l
         ZTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5ednJFm6bvGk44o3ODFwgwZOuuJlGnV0uttpvZ8Mlo=;
        b=CJqaISr+y1RIlYrU50UbYYFl9cPUlueV5RjZWgDSXWxRy3Y8ELS4OApdW4M7HNn3hK
         gXhq/YQKpdUdLOZEcu+6jWUjzesJNVmUWYNSLqHQTjvDt/ws3td0DSCc2Lgb+xCZJPoZ
         5TrXRvBbIokc7TX4QF1GaB6vwV4dm4MiidAHfT3Kgqw2Z+RkCBxYz8uzY935CA2MpTxC
         NoyhkBJN2bEncjUpjZkYasiNIHNr/2FSZeILAIX20WTZBuOTV2HoyFV8Q6XrfvbJVB7a
         e4jWvVWTdg+9DbYY1YZ4Tm46/zxwOoREsRhnrk1PhOTqZgUBeuAVHXAux0VEcagmYqEi
         PN/g==
X-Gm-Message-State: ACrzQf2PFXo9mB80rBUwc+MEae6mqThE60EoG/eVrejg0zWVn4WzVZNy
	vrvtiazqtJouBI7g5SuUwuNYzaFCf8k=
X-Google-Smtp-Source: AMsMyM62H8VOZBzO5eHZt9xY4JPWG+jwkDSVH7fdT2GAfm1UbbJzi3m09hnEbOXcelJqCcbM5xLGww==
X-Received: by 2002:a17:902:b210:b0:17d:c3ca:4a4f with SMTP id t16-20020a170902b21000b0017dc3ca4a4fmr553802plr.33.1665078043099;
        Thu, 06 Oct 2022 10:40:43 -0700 (PDT)
Received: from jprestwo-xps.none (h67-204-159-212.bendor.broadband.dynamic.tds.net. [67.204.159.212])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902f38d00b00176a6ba5969sm12479671ple.98.2022.10.06.10.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:40:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] auto-t: speed up testHiddenNetworks
Date: Thu,  6 Oct 2022 10:40:39 -0700
Message-Id: <20221006174040.823577-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CI was sometimes taking ~10-15 minutes to run just this
test. This is likely due to the test having 7 radios and
which is a lot of beacons/probes to process.

Disabling the unused hostapd instances drops the runtime down
to about 1 minute.
---
 .../connect_after_hidden_connect_test.py          | 12 +++++++++++-
 autotests/testHiddenNetworks/exceptions_test.py   | 11 +++++++++++
 autotests/testHiddenNetworks/open_network_test.py | 14 ++++++++++++++
 autotests/testHiddenNetworks/wpa_network_test.py  | 15 +++++++++++++++
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/autotests/testHiddenNetworks/connect_after_hidden_connect_test.py b/autotests/testHiddenNetworks/connect_after_hidden_connect_test.py
index cc36771c..ead532a1 100644
--- a/autotests/testHiddenNetworks/connect_after_hidden_connect_test.py
+++ b/autotests/testHiddenNetworks/connect_after_hidden_connect_test.py
@@ -7,6 +7,7 @@ sys.path.append('../util')
 import iwd
 from iwd import IWD
 from iwd import PSKAgent
+from hostapd import HostapdCLI
 import testutil
 import time
 
@@ -67,11 +68,20 @@ class TestConnectionAfterHiddenNetwork(unittest.TestCase):
 
     @classmethod
     def setUpClass(cls):
-        pass
+        cls.disabled = [HostapdCLI('ssidHiddenOpen.conf'),
+                        HostapdCLI('ssidHiddenWPA.conf'),
+                        HostapdCLI('ssidOverlap1.conf'),
+                        HostapdCLI('ssidOverlap2.conf')]
+
+        for hapd in cls.disabled:
+            hapd.disable()
 
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
 
+        for hapd in cls.disabled:
+            hapd.reload()
+
 if __name__ == '__main__':
     unittest.main(exit=True)
diff --git a/autotests/testHiddenNetworks/exceptions_test.py b/autotests/testHiddenNetworks/exceptions_test.py
index 1c4722a6..55e3c603 100644
--- a/autotests/testHiddenNetworks/exceptions_test.py
+++ b/autotests/testHiddenNetworks/exceptions_test.py
@@ -8,6 +8,7 @@ import iwd
 import validation
 from validation import TestHiddenNetworks
 from iwd import IWD
+from hostapd import HostapdCLI
 
 class TestWpaNetwork(unittest.TestCase):
     '''
@@ -34,9 +35,19 @@ class TestWpaNetwork(unittest.TestCase):
     def setUpClass(cls):
         IWD.copy_to_storage('ssidAlreadyKnown.open')
 
+        cls.disabled = [HostapdCLI('ssidHiddenOpen.conf'),
+                        HostapdCLI('ssidHiddenWPA.conf'),
+                        HostapdCLI('ssidSomeHidden.conf')]
+
+        for hapd in cls.disabled:
+            hapd.disable()
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
 
+        for hapd in cls.disabled:
+            hapd.reload()
+
 if __name__ == '__main__':
     unittest.main(exit=True)
diff --git a/autotests/testHiddenNetworks/open_network_test.py b/autotests/testHiddenNetworks/open_network_test.py
index 8645fdad..e306e8a4 100644
--- a/autotests/testHiddenNetworks/open_network_test.py
+++ b/autotests/testHiddenNetworks/open_network_test.py
@@ -8,6 +8,7 @@ import iwd
 import validation
 from validation import TestHiddenNetworks
 from iwd import IWD
+from hostapd import HostapdCLI
 
 class TestOpenNetwork(unittest.TestCase):
     '''
@@ -24,9 +25,22 @@ class TestOpenNetwork(unittest.TestCase):
         tca.validate('ssidHiddenOpen', False)
         tca.validate('ssidHiddenOpen', True)
 
+    @classmethod
+    def setUpClass(cls):
+        cls.disabled = [HostapdCLI('ssidHiddenWPA.conf'),
+                        HostapdCLI('ssidOpen.conf'),
+                        HostapdCLI('ssidOverlap1.conf'),
+                        HostapdCLI('ssidOverlap2.conf'),
+                        HostapdCLI('ssidSomeHidden.conf')]
+        for hapd in cls.disabled:
+            hapd.disable()
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
 
+        for hapd in cls.disabled:
+            hapd.reload()
+
 if __name__ == '__main__':
     unittest.main(exit=True)
diff --git a/autotests/testHiddenNetworks/wpa_network_test.py b/autotests/testHiddenNetworks/wpa_network_test.py
index a65fe1af..21045539 100644
--- a/autotests/testHiddenNetworks/wpa_network_test.py
+++ b/autotests/testHiddenNetworks/wpa_network_test.py
@@ -8,6 +8,7 @@ import iwd
 import validation
 from validation import TestHiddenNetworks
 from iwd import IWD
+from hostapd import HostapdCLI
 
 class TestWpaNetwork(unittest.TestCase):
     '''
@@ -25,9 +26,23 @@ class TestWpaNetwork(unittest.TestCase):
         tca.validate('ssidHiddenWPA', False, None, True)
         tca.validate('ssidHiddenWPA', True, None, True)
 
+    @classmethod
+    def setUpClass(cls):
+        cls.disabled = [HostapdCLI('ssidHiddenOpen.conf'),
+                        HostapdCLI('ssidOpen.conf'),
+                        HostapdCLI('ssidOverlap1.conf'),
+                        HostapdCLI('ssidOverlap2.conf'),
+                        HostapdCLI('ssidSomeHidden.conf')]
+
+        for hapd in cls.disabled:
+            hapd.disable()
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
 
+        for hapd in cls.disabled:
+            hapd.reload()
+
 if __name__ == '__main__':
     unittest.main(exit=True)
-- 
2.34.3

