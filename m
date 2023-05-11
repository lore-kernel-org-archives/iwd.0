Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319E443A
	for <iwd@lists.linux.dev>; Thu, 11 May 2023 18:48:25 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-61b58779b93so81083916d6.0
        for <iwd@lists.linux.dev>; Thu, 11 May 2023 11:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683830904; x=1686422904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGMoETNnnbroy2zJIG1yKhkGGrMlA93HBJA2uMGJMGQ=;
        b=o42xVBDlWemcqNeS0NdvH/rc+D+vd+4R0Xf5pI9BrUWEnbRVL7aXgITqdnUPQHFMmT
         k39jh8M4eQlEMJfnaTW2ZTjcyk0vSpSEU/OgyZbHGIvldz1x4F8tylftqzSePV74orhu
         7jjb8TYfV1eQq2R/pZRr1HAkJBz3GHsn5y6aktNhq3ufqua2bcg6iSaRC0XaPGsRkxHv
         XFa/GeODl/Z2bIbve/Z+opJqPEMnX1zjiCdI2cGeWU/BaR6b88BE6vameoyrQf3vRlpe
         KHxnpIZCgTtgzl2Gog53dJy4FkEHj3LAO4GhVh36IA0XrM0E2lhItd/SWeo5q14X1kxz
         A16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683830904; x=1686422904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGMoETNnnbroy2zJIG1yKhkGGrMlA93HBJA2uMGJMGQ=;
        b=K1Lxu/YFMnEhEBg1g5drGHpzahOLEka1it7r0wHg53sQKiyYMGZu073SzRaeYe3+6X
         8ewOYpgEK9M01NYEpzyNf3Cp6g+yaxgJldHL3o5CAyosDNnwEWzez2sEBPYPPL57VzU/
         Yvjiwg7d28bDvRp7wasryv5H8LvMedWFbCM9rC9r04f0U8OP7iVMgJa0DaWTlxk9g9jc
         Zu4h29wZb3opjgSvpuF0ESGGeuQLJjavZxjWDV4zkNIAcHmOIan/RmslZKQvBw1gjoMG
         IoEOVuTBNYrPhas4VjAMiLYmynfZnNBXr//M7EaCivp7QAjoLv0WbPIaMbSN7kkHRYk+
         CRtQ==
X-Gm-Message-State: AC+VfDyIOtsAAFb9XUcejxPfcd+G3gQ+qV/Gj5jOTk4dn00kGcn2T9ny
	8MBpLDut/JlC6MjolgOlQTSzGXsDwKo=
X-Google-Smtp-Source: ACHHUZ76HznjVgH8frUlPXfzHpkwXPqrUcXJ0wxaEqd0gT1G3I7B6y1Q0i/Q5BCH4AAGwFnTOV7eLQ==
X-Received: by 2002:a05:6214:4113:b0:5ef:5894:f814 with SMTP id kc19-20020a056214411300b005ef5894f814mr30703415qvb.33.1683830903900;
        Thu, 11 May 2023 11:48:23 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id s17-20020a0cdc11000000b005ef42af7eb7sm2447221qvk.25.2023.05.11.11.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:48:23 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] auto-t: modify PSK-roam test to use FT failure path
Date: Thu, 11 May 2023 11:48:16 -0700
Message-Id: <20230511184817.79203-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230511184817.79203-1-prestwoj@gmail.com>
References: <20230511184817.79203-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds another radio so IWD hits the FT failure path after
authentication to the first BSS fails. This causes a wiphy work
item to be rescheduled which previously was unsafe.
---
 autotests/testPSK-roam/connection_test.py     | 13 +++++---
 autotests/testPSK-roam/failed_roam_test.py    | 33 ++++++++++++-------
 autotests/testPSK-roam/hw.conf                |  3 +-
 .../testPSK-roam/roam_ap_disconnect_test.py   |  4 ++-
 4 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-roam/connection_test.py
index 7a135e95..459c25cf 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -48,7 +48,7 @@ class Test(unittest.TestCase):
             self.rule2.enabled = True
             # Send 100 packets (to be dropped), should trigger beacon loss
             testutil.tx_packets(device.name, self.bss_hostapd[0].ifname, 100)
-            device.wait_for_event('packet-loss-roam', timeout=30)
+            device.wait_for_event('packet-loss-roam', timeout=60)
         else:
             device.roam(self.bss_hostapd[1].bssid)
 
@@ -173,19 +173,22 @@ class Test(unittest.TestCase):
         IWD.copy_to_storage('TestFT.psk')
 
         cls.bss_hostapd = [ HostapdCLI(config='ft-psk-ccmp-1.conf'),
-                            HostapdCLI(config='ft-psk-ccmp-2.conf') ]
+                            HostapdCLI(config='ft-psk-ccmp-2.conf'),
+                            HostapdCLI(config='ft-psk-ccmp-3.conf') ]
+        cls.bss_hostapd[2].disable()
+
         rad0 = hwsim.get_radio('rad0')
-        rad2 = hwsim.get_radio('rad2')
+        rad3 = hwsim.get_radio('rad3')
 
         cls.rule0 = hwsim.rules.create()
-        cls.rule0.source = rad2.addresses[0]
+        cls.rule0.source = rad3.addresses[0]
         cls.rule0.bidirectional = True
         cls.rule0.signal = -2000
         cls.rule0.prefix = 'b0'
         cls.rule0.drop = True
 
         cls.rule1 = hwsim.rules.create()
-        cls.rule1.source = rad2.addresses[0]
+        cls.rule1.source = rad3.addresses[0]
         cls.rule1.prefix = '08'
         cls.rule1.drop = True
 
diff --git a/autotests/testPSK-roam/failed_roam_test.py b/autotests/testPSK-roam/failed_roam_test.py
index 360c1de5..eda2b4e2 100644
--- a/autotests/testPSK-roam/failed_roam_test.py
+++ b/autotests/testPSK-roam/failed_roam_test.py
@@ -62,21 +62,17 @@ class Test(unittest.TestCase):
 
         self.rule0.enabled = True
 
-        device.roam(self.bss_hostapd[1].bssid)
-
-        # Roam should fail...
-        device.wait_for_event('ft-roam-failed')
+        # IWD should connect, then attempt a roam to BSS 1, which should fail...
+        device.wait_for_event('ft-roam-failed', timeout=60)
         # ... but IWD should remain connected
         self.assertTrue(device.state == DeviceState.connected)
 
         self.rule0.enabled = False
 
-        # Try again once more
-        device.roam(self.bss_hostapd[1].bssid)
-
-        self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[1])
+        # IWD should then try BSS 2, and succeed
+        self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[2])
 
-        self.bss_hostapd[1].deauthenticate(device.address)
+        self.bss_hostapd[2].deauthenticate(device.address)
         condition = 'obj.state == DeviceState.disconnected'
         wd.wait_for_object_condition(device, condition)
 
@@ -88,6 +84,7 @@ class Test(unittest.TestCase):
 
         self.rule0.enabled = False
         self.rule1.enabled = False
+        self.rule2.enabled = False
 
     @classmethod
     def setUpClass(cls):
@@ -96,14 +93,16 @@ class Test(unittest.TestCase):
         IWD.copy_to_storage('TestFT.psk')
 
         cls.bss_hostapd = [ HostapdCLI(config='ft-psk-ccmp-1.conf'),
-                            HostapdCLI(config='ft-psk-ccmp-2.conf') ]
+                            HostapdCLI(config='ft-psk-ccmp-2.conf'),
+                            HostapdCLI(config='ft-psk-ccmp-3.conf') ]
 
         cls.bss_hostapd[0].set_address('12:00:00:00:00:01')
         cls.bss_hostapd[1].set_address('12:00:00:00:00:02')
+        cls.bss_hostapd[2].set_address('12:00:00:00:00:03')
 
         # Drop Authenticate frames
         cls.rule0 = hwsim.rules.create()
-        cls.rule0.bidirectional = True
+        cls.rule0.source = hwsim.get_radio('rad1').addresses[0]
         cls.rule0.prefix = 'b0'
         cls.rule0.drop = True
 
@@ -113,6 +112,18 @@ class Test(unittest.TestCase):
         cls.rule1.prefix = 'd0'
         cls.rule1.drop = True
 
+        # Causes IWD to immediately roam away from BSS 0
+        cls.rule2 = hwsim.rules.create()
+        cls.rule2.source = hwsim.get_radio('rad0').addresses[0]
+        cls.rule2.signal = -8000
+        cls.rule2.enabled = True
+
+        # Causes IWD to first prefer BSS 1 to roam, then BSS 2.
+        cls.rule3 = hwsim.rules.create()
+        cls.rule3.source = hwsim.get_radio('rad2').addresses[0]
+        cls.rule3.signal = -7000
+        cls.rule3.enabled = True
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
diff --git a/autotests/testPSK-roam/hw.conf b/autotests/testPSK-roam/hw.conf
index c2b35d6e..da9e385c 100644
--- a/autotests/testPSK-roam/hw.conf
+++ b/autotests/testPSK-roam/hw.conf
@@ -1,8 +1,9 @@
 [SETUP]
-num_radios=3
+num_radios=4
 start_iwd=0
 hwsim_medium=yes
 
 [HOSTAPD]
 rad0=ft-psk-ccmp-1.conf
 rad1=ft-psk-ccmp-2.conf
+rad2=ft-psk-ccmp-3.conf
diff --git a/autotests/testPSK-roam/roam_ap_disconnect_test.py b/autotests/testPSK-roam/roam_ap_disconnect_test.py
index 416541ce..130e1702 100644
--- a/autotests/testPSK-roam/roam_ap_disconnect_test.py
+++ b/autotests/testPSK-roam/roam_ap_disconnect_test.py
@@ -70,8 +70,10 @@ class Test(unittest.TestCase):
         IWD.copy_to_storage('TestFT.psk')
 
         cls.bss_hostapd = [ HostapdCLI(config='ft-psk-ccmp-1.conf'),
-                            HostapdCLI(config='ft-psk-ccmp-2.conf') ]
+                            HostapdCLI(config='ft-psk-ccmp-2.conf'),
+                            HostapdCLI(config='ft-psk-ccmp-3.conf') ]
         cls.bss_hostapd[1].disable()
+        cls.bss_hostapd[2].disable()
 
         cls.bss_hostapd[0].set_value('ocv', '0')
         cls.bss_hostapd[0].set_value('ieee80211w', '0')
-- 
2.25.1

