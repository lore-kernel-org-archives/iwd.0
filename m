Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521BF612B
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:52 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1322d768ba7so4752321fac.5
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0kWoZfFdjNHSq4gma9SU+0+HgA3ePJmbsrTgnIa8KA=;
        b=PuHct5Vp7LhM8uMkflRdFM8X+ow9XyO2MngU5zaxQ9oL9wZ4zqcK9YNpZL+9sNKrRZ
         40lr82bNJi71UFjgUDUHj+iT5Jb8kvI94tmEroa/AybghuVBWElvG15vu2EJ3lnlVsW+
         LNY26MFD0wLew9WGeWjsXf0RIFgn1QHpe/voNwx6ThFUN5E2Zg4f5vExo9EeJZfPZyeH
         jDmabBrtlUiWCeNapdMrb2J/O9YHPj2HTtXVlXkw4ttkONLtoEkEZPa+F8lYifR/+HFY
         SVMpTN4O7450Cssrhtj2TTkFvtaOG+uLiJZ4nNri2uKWOBhVGktj+etJvPmcQLfCs+uj
         QUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0kWoZfFdjNHSq4gma9SU+0+HgA3ePJmbsrTgnIa8KA=;
        b=qHhFZR0M4pDcXrmQIcXXXb2w9EY61catCZFIYpDW/fFavPKRWMtlhGfPfXs7hJkV3z
         RRHVW+qnNQ2NgFE4JjWi+RKi5czUBVi8OXHooqxnAVLkwZGLhTeZ52pzl6AIh6UlItyH
         abS75b68mQ9DCWwnYfde8xDI8gOgeNtQHul6fYrhofKNno7sj9XcYyfEapf7apdPSORY
         96ruLPP0CKEF5i6cFMs9G9LTCca7O6/Nwp13GaHtHynQ+lRA7jEMO2jDZ+MRi8rVWI/w
         FI8LW4+0ZDBPdAuEeVmfiPun0PpocGx5i2yU4amUYIBDhMbI6py+I4PDnEuKKEk1XmPH
         itSw==
X-Gm-Message-State: ACrzQf2gh0ou7vP1SFWqMKfDuq+t4nRKSpM4OWTVdfm4KTGwU7gqhg/L
	l6KWTTbJXr7rUrcgayLEws7E9NipgzA=
X-Google-Smtp-Source: AMsMyM5V3Omf8N0NEGbk2tAVtOUtkgsfGtCKvZSfONHJAMUQXEfwg7IjRK4OyySpywXXgzdA+tSNFA==
X-Received: by 2002:a05:6870:c08a:b0:132:dc3a:ecdf with SMTP id c10-20020a056870c08a00b00132dc3aecdfmr14895316oad.299.1666379630881;
        Fri, 21 Oct 2022 12:13:50 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:50 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 15/26] auto-t: Support multiple pairwise ciphers in WPA2
Date: Fri, 21 Oct 2022 14:12:56 -0500
Message-Id: <20221021191307.31492-15-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021191307.31492-1-denkenz@gmail.com>
References: <20221021191307.31492-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testWPA2/connection_test.py         | 30 +++++++++++++++----
 autotests/testWPA2/failure_test.py            |  4 +--
 autotests/testWPA2/hw.conf                    |  3 +-
 autotests/testWPA2/password_test.py           |  4 +--
 .../testWPA2/{ssidCCMP.conf => ssidWPA2.conf} |  2 +-
 5 files changed, 31 insertions(+), 12 deletions(-)
 rename autotests/testWPA2/{ssidCCMP.conf => ssidWPA2.conf} (83%)

diff --git a/autotests/testWPA2/connection_test.py b/autotests/testWPA2/connection_test.py
index bf8831ea81db..2cbdf8e1b788 100644
--- a/autotests/testWPA2/connection_test.py
+++ b/autotests/testWPA2/connection_test.py
@@ -8,20 +8,19 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
+from hostapd import HostapdCLI
 import testutil
 
 class Test(unittest.TestCase):
 
-    def test_connection_success(self):
-        wd = IWD()
-
+    def validate_connection_success(self, wd):
         psk_agent = PSKAgent("secret123")
         wd.register_psk_agent(psk_agent)
 
         devices = wd.list_devices(1)
         device = devices[0]
 
-        ordered_network = device.get_ordered_network('ssidCCMP')
+        ordered_network = device.get_ordered_network('ssidWPA2')
 
         self.assertEqual(ordered_network.type, NetworkType.psk)
 
@@ -43,13 +42,32 @@ class Test(unittest.TestCase):
 
         wd.unregister_psk_agent(psk_agent)
 
+    def test_ccmp(self):
+        self.hostapd.set_value('rsn_pairwise', 'CCMP')
+        self.hostapd.reload()
+        self.hostapd.wait_for_event("AP-ENABLED")
+        self.validate_connection_success(self.wd)
+
+    def test_gcmp(self):
+        self.hostapd.set_value('rsn_pairwise', 'GCMP')
+        self.hostapd.reload()
+        self.hostapd.wait_for_event("AP-ENABLED")
+        self.validate_connection_success(self.wd)
+
+    def setUp(self):
+        self.wd = IWD(True)
+
+    def tearDown(self):
+        self.wd.clear_storage()
+        self.wd = None
+
     @classmethod
     def setUpClass(cls):
-        pass
+        cls.hostapd = HostapdCLI(config='ssidWPA2.conf')
 
     @classmethod
     def tearDownClass(cls):
-        IWD.clear_storage()
+        pass
 
 if __name__ == '__main__':
     unittest.main(exit=True)
diff --git a/autotests/testWPA2/failure_test.py b/autotests/testWPA2/failure_test.py
index 605ee5dddc59..61cf6ade87b0 100644
--- a/autotests/testWPA2/failure_test.py
+++ b/autotests/testWPA2/failure_test.py
@@ -13,7 +13,7 @@ import testutil
 class Test(unittest.TestCase):
 
     def test_connection_success(self):
-        wd = IWD()
+        wd = IWD(True)
 
         psk_agent = PSKAgent("InvalidPassword")
         wd.register_psk_agent(psk_agent)
@@ -22,7 +22,7 @@ class Test(unittest.TestCase):
         self.assertIsNotNone(devices)
         device = devices[0]
 
-        ordered_network = device.get_ordered_network('ssidCCMP')
+        ordered_network = device.get_ordered_network('ssidWPA2')
 
         self.assertEqual(ordered_network.type, NetworkType.psk)
 
diff --git a/autotests/testWPA2/hw.conf b/autotests/testWPA2/hw.conf
index fad15b8823a3..51350f989552 100644
--- a/autotests/testWPA2/hw.conf
+++ b/autotests/testWPA2/hw.conf
@@ -1,5 +1,6 @@
 [SETUP]
 num_radios=2
+start_iwd=0
 
 [HOSTAPD]
-rad0=ssidCCMP.conf
+rad0=ssidWPA2.conf
diff --git a/autotests/testWPA2/password_test.py b/autotests/testWPA2/password_test.py
index d937d5c04cd8..1dbfce004c2e 100644
--- a/autotests/testWPA2/password_test.py
+++ b/autotests/testWPA2/password_test.py
@@ -13,7 +13,7 @@ import testutil
 class Test(unittest.TestCase):
 
     def test_connection_success(self):
-        wd = IWD()
+        wd = IWD(True)
 
         devices = wd.list_devices(1)
         device = devices[0]
@@ -22,7 +22,7 @@ class Test(unittest.TestCase):
         condition = 'obj.state == DeviceState.disconnected'
         wd.wait_for_object_condition(device, condition)
 
-        ordered_network = device.get_ordered_network("ssidCCMP")
+        ordered_network = device.get_ordered_network("ssidWPA2")
         self.assertEqual(ordered_network.type, NetworkType.psk)
         network = ordered_network.network_object
 
diff --git a/autotests/testWPA2/ssidCCMP.conf b/autotests/testWPA2/ssidWPA2.conf
similarity index 83%
rename from autotests/testWPA2/ssidCCMP.conf
rename to autotests/testWPA2/ssidWPA2.conf
index 074e82283e23..64fd77961f2c 100644
--- a/autotests/testWPA2/ssidCCMP.conf
+++ b/autotests/testWPA2/ssidWPA2.conf
@@ -1,6 +1,6 @@
 hw_mode=g
 channel=1
-ssid=ssidCCMP
+ssid=ssidWPA2
 
 wpa=2
 wpa_pairwise=CCMP
-- 
2.35.1

