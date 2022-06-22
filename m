Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A71C27
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 23:04:31 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id z14so17467797pgh.0
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 16:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNeLgntYaA2ssQXSnyc+kF9/TZ40oOtB16wIkzybGBQ=;
        b=bskzExuLoZPcXtfviFBFx1dSb4q2bq8AfkADw6m89eKA9q3jN0127lRWilpaUW7WbC
         UWxmV7iaD6rsQ1g6rl8ZQt1nWaceWhgOtyXL4gse7Rc3Bf4uxCLkAZiqsPuK58iObWRW
         z2D9UB/EzdkNxT+dddJlgib1r+GJ7yt6j3aMFDx6/vfdi3psXR1gtaqAvWlR+wc24Y//
         sidtThsaFmfq8tp2FAGrACM4KUmipuEqOTXXhPOhr6EtRBG+3bvH67u3awzGpC7+PT7N
         guG2z9rCXRv6FjjMGbEyrVpjC2Q5uaKJ8ubyWzLkvTepLANUb7G5RoSq9ni1rknh5VI7
         t80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNeLgntYaA2ssQXSnyc+kF9/TZ40oOtB16wIkzybGBQ=;
        b=ea6GnWPOBzIVsEpJf5+ka0Ff7BYMxBPsIDJ4u9kFf88R7cQmgGfcfiLpvnlPfsyGbW
         Lj2s7QvfMTy6kzIaRZ8HPDrBTPJ1BBIXRRQnhvqwS5Xp9kvGcnsS/CKGvpz6IXAVwSy5
         pP/f2vMSrH7xgJ0uDZ/hh/PoxncEhS3G1BEYB+uTwKDKh1TJQd8/2EUXzbiK7toVyAYN
         lMFjItaFKbOrHRiT/7yM4DJf0GqO7cxLKlgFZHPbZfpdvRLPTxhh9sJCw/itI7EiMaaU
         Tjr4nLXR+UPa84O9UsLvwP+1UdZtDCPEVgjjxg1llYCrc6qARLzNDolASX2lglxSMfDJ
         I6bg==
X-Gm-Message-State: AJIora95ovDzPz1E1u3MpExjHaSdyGdAvxr4Xlz/5PbbVX5xEgzPg6GB
	Jinf6wIvUJxqdTjtX+VZla5LQOQ3GY4=
X-Google-Smtp-Source: AGRyM1sks/y+dMOndU61WTtAJ0m+HMBACz1yDTl8Ih4cNlKkFej6ka6VKOJUTXyEsyaTP3rcKkP09w==
X-Received: by 2002:a05:6a00:1acd:b0:51c:795b:860c with SMTP id f13-20020a056a001acd00b0051c795b860cmr38281437pfv.16.1655939070627;
        Wed, 22 Jun 2022 16:04:30 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id jb6-20020a170903258600b0016a12571537sm9107052plb.299.2022.06.22.16.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 16:04:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] auto-t: rename testHiddenNetwork's test class
Date: Wed, 22 Jun 2022 16:02:18 -0700
Message-Id: <20220622230219.1557695-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220622230219.1557695-1-prestwoj@gmail.com>
References: <20220622230219.1557695-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was copy pasted from the autoconnect test, and depending on
how the python module cache is ordered can incorrectly use the
wrong test class. This should nothappen because we insert
the paths to the head of the list but for consistency the class
should be named something that reflects what the test is doing.
---
 autotests/testHiddenNetworks/exceptions_test.py   | 4 ++--
 autotests/testHiddenNetworks/open_network_test.py | 4 ++--
 autotests/testHiddenNetworks/validation.py        | 2 +-
 autotests/testHiddenNetworks/wpa_network_test.py  | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/autotests/testHiddenNetworks/exceptions_test.py b/autotests/testHiddenNetworks/exceptions_test.py
index 0c151fcb..1c4722a6 100644
--- a/autotests/testHiddenNetworks/exceptions_test.py
+++ b/autotests/testHiddenNetworks/exceptions_test.py
@@ -6,7 +6,7 @@ import sys
 sys.path.append('../util')
 import iwd
 import validation
-from validation import TestConnectAutoConnect
+from validation import TestHiddenNetworks
 from iwd import IWD
 
 class TestWpaNetwork(unittest.TestCase):
@@ -23,7 +23,7 @@ class TestWpaNetwork(unittest.TestCase):
     '''
 
     def test_wpa(self):
-        tca = TestConnectAutoConnect()
+        tca = TestHiddenNetworks()
 
         tca.validate('UnExistingNetwork', False, iwd.NotFoundEx)
         tca.validate('ssidOverlap', False, iwd.ServiceSetOverlapEx)
diff --git a/autotests/testHiddenNetworks/open_network_test.py b/autotests/testHiddenNetworks/open_network_test.py
index 2cc0f75b..8645fdad 100644
--- a/autotests/testHiddenNetworks/open_network_test.py
+++ b/autotests/testHiddenNetworks/open_network_test.py
@@ -6,7 +6,7 @@ import sys
 sys.path.append('../util')
 import iwd
 import validation
-from validation import TestConnectAutoConnect
+from validation import TestHiddenNetworks
 from iwd import IWD
 
 class TestOpenNetwork(unittest.TestCase):
@@ -20,7 +20,7 @@ class TestOpenNetwork(unittest.TestCase):
     True                              True          Connection succeeds
     '''
     def test_open(self):
-        tca = TestConnectAutoConnect()
+        tca = TestHiddenNetworks()
         tca.validate('ssidHiddenOpen', False)
         tca.validate('ssidHiddenOpen', True)
 
diff --git a/autotests/testHiddenNetworks/validation.py b/autotests/testHiddenNetworks/validation.py
index 793b459f..2c005331 100644
--- a/autotests/testHiddenNetworks/validation.py
+++ b/autotests/testHiddenNetworks/validation.py
@@ -9,7 +9,7 @@ from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
 
-class TestConnectAutoConnect(unittest.TestCase):
+class TestHiddenNetworks(unittest.TestCase):
 
     def check_connect_hidden_network(self, wd, device, ssid, throws):
         if not throws is None:
diff --git a/autotests/testHiddenNetworks/wpa_network_test.py b/autotests/testHiddenNetworks/wpa_network_test.py
index d8166b1b..a65fe1af 100644
--- a/autotests/testHiddenNetworks/wpa_network_test.py
+++ b/autotests/testHiddenNetworks/wpa_network_test.py
@@ -6,7 +6,7 @@ import sys
 sys.path.append('../util')
 import iwd
 import validation
-from validation import TestConnectAutoConnect
+from validation import TestHiddenNetworks
 from iwd import IWD
 
 class TestWpaNetwork(unittest.TestCase):
@@ -21,7 +21,7 @@ class TestWpaNetwork(unittest.TestCase):
     '''
 
     def test_wpa(self):
-        tca = TestConnectAutoConnect()
+        tca = TestHiddenNetworks()
         tca.validate('ssidHiddenWPA', False, None, True)
         tca.validate('ssidHiddenWPA', True, None, True)
 
-- 
2.34.1

