Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469AB4A30
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 16:36:44 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id a29so13007478pfk.5
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 09:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iH+4Jo+fCew/LPaJAoClJ2OUSvozaWEqbypNDM9tiRc=;
        b=YCCucu+9QYUUyrdpcPt887b3Mnxocf0hkRZcYxrbAoSwwrBaedP5F7BgBWNYr56RsZ
         20e5JXMsD7ax0QZ5yUtyD/6R+jnrnmLet8jBIFrpG+z8BYuTGUDt1prXM5p7H7B5iZVQ
         hC6vEacTx5FAXYuikPCKEwDpYDLyjK2UcAPiJzPWe/YcAfFaMEGCHGpJ538VKpFHsVJd
         1L3AKmU6jKLjpopAh7rp5POpSaXLAj1eY0zmTuRV2SQNyN8bOMQ3jDD4E/4989xLn/8q
         uoMRS4HffBXsxO7rl/Gc8ZvXPq/o6WJiSUGm8jAuokDbvFMYkr4xYvtxqsCidiRF39x6
         HD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iH+4Jo+fCew/LPaJAoClJ2OUSvozaWEqbypNDM9tiRc=;
        b=hp/9cEnPejEidHYBeHuuA1zcKguvFt9KkmmchIL9CBGsW9QBjpDrNcNa5Qhxiv0vW5
         7d60t8aDUpYIxfcGho8EwguOEfOUR8VlnkLUzs7/QIm4xqYwwUKEIZfSfsjc8T4MlSgR
         Web/A3xsM/HEhPCSYIAvx8iekwbriC2NUD3Z9RR7fw+72iFFcisuURm+TNOSnzJ0UWxN
         wfcY7XqMNaBJDfEc9AA10IsQo1H3b47F7stbt+hAuLkctpdtPAgHnMus7afGzlggO0jO
         RGF/ftDHIcM07ks5I2cYy25Zfd6gsrbgU79v7ESe9H+cJDDhY6tpaZYZ4ikKr0MWHQBL
         g47w==
X-Gm-Message-State: ACrzQf1rjdiAnRw9zVb6+wxKBnU9YeAOaGqCZh2LiDz2B+PsAXMg7nHL
	pmYGk75kysNO8CormT+hvSJAAM1Ux10=
X-Google-Smtp-Source: AMsMyM5r6krDfRfzktYa9u5BcWRNGaQMJgo+54ArD+IuNObDJ/uUZCGZrGfQCemJ4JwzZMVIXaP0/w==
X-Received: by 2002:a05:6a00:2316:b0:548:58b6:b17c with SMTP id h22-20020a056a00231600b0054858b6b17cmr35340150pfh.53.1664383003640;
        Wed, 28 Sep 2022 09:36:43 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id lb12-20020a17090b4a4c00b00205fafa6768sm661184pjb.6.2022.09.28.09.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 09:36:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] auto-t: add a no candidate test to testAPRoam
Date: Wed, 28 Sep 2022 09:36:37 -0700
Message-Id: <20220928163637.344656-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220928163637.344656-1-prestwoj@gmail.com>
References: <20220928163637.344656-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tests the new behavior where the roam request does not
indicate disassociation is imminent. In this case if no
candidates are found IWD should not roam.
---
 autotests/testAPRoam/connection_test.py | 43 ++++++++++++++-----------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/autotests/testAPRoam/connection_test.py b/autotests/testAPRoam/connection_test.py
index 41d70f3a..a419f4aa 100644
--- a/autotests/testAPRoam/connection_test.py
+++ b/autotests/testAPRoam/connection_test.py
@@ -12,11 +12,7 @@ from hostapd import HostapdCLI
 
 class Test(unittest.TestCase):
 
-    def test_connection_success(self):
-        bss_hostapd = [ HostapdCLI(config='ssid1.conf'),
-                        HostapdCLI(config='ssid2.conf'),
-                        HostapdCLI(config='ssid3.conf') ]
-
+    def validate(self, expect_roam=True):
         wd = IWD()
 
         devices = wd.list_devices(1)
@@ -29,38 +25,47 @@ class Test(unittest.TestCase):
         condition = 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condition)
 
-        device.connect_bssid(bss_hostapd[0].bssid)
+        device.connect_bssid(self.bss_hostapd[0].bssid)
 
         condition = 'obj.state == DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 
-        bss_hostapd[0].wait_for_event('AP-STA-CONNECTED')
-
-        self.assertFalse(bss_hostapd[1].list_sta())
+        self.bss_hostapd[0].wait_for_event('AP-STA-CONNECTED')
 
-        bss_hostapd[0].send_bss_transition(device.address,
-                [(bss_hostapd[1].bssid, '8f0000005102060603000000')])
+        self.assertFalse(self.bss_hostapd[1].list_sta())
 
-        condition = 'obj.state == DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
-
-        condition = 'obj.state != DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
+        self.bss_hostapd[0].send_bss_transition(device.address,
+                [(self.bss_hostapd[1].bssid, '8f0000005102060603000000')],
+                disassoc_imminent=expect_roam)
 
-        condition = 'obj.state == DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
+        if expect_roam:
+            from_condition = 'obj.state == DeviceState.roaming'
+            to_condition = 'obj.state == DeviceState.connected'
+            wd.wait_for_object_change(device, from_condition, to_condition)
 
-        bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.address)
+            self.bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.address)
+        else:
+            device.wait_for_event("no-roam-candidates")
 
         device.disconnect()
 
         condition = 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condition)
 
+    def test_disassoc_imminent(self):
+        self.validate(expect_roam=True)
+
+    def test_no_candidates(self):
+        self.validate(expect_roam=False)
+
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_storage('TestAPRoam.psk')
 
+        cls.bss_hostapd = [ HostapdCLI(config='ssid1.conf'),
+                            HostapdCLI(config='ssid2.conf'),
+                            HostapdCLI(config='ssid3.conf') ]
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
-- 
2.34.3

