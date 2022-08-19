Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17C87490
	for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 20:26:27 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id p9so4169671pfq.13
        for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 13:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=SH1p/Jy6irmmdOftxiYsMTxal98HxDHfz5eD8xlfrZQ=;
        b=IDOdEzdDvFaRmO1BKl1A67ERVBvTP8MsEUO6PeXEl9R+rziyhMVcb64do00ONS0fPZ
         K7jzbFAsazWcnPjNwhgWeNyyRN+IVmGkMMv638Y9ZC1TThpihKiaJdATuEFkGuTq8rMw
         fQmJDNA5WZ45xNlLju+NESX6YitTJnR73ozPIWiTqWlujRfzKDm3aVhGRGmjqnHGs8e+
         3e0rd68n640R/q3RkMLKlEDs6ZpJZyAeAWUPMILzejN6TTpTnp0CzdiwESPB2Un/Pb4v
         OeKRrBujmtGPalW1sXADBURWobReIqEOJAJIcsLOgrBvtV9FoMDTXvPVSLPRsKobk3Kd
         tgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=SH1p/Jy6irmmdOftxiYsMTxal98HxDHfz5eD8xlfrZQ=;
        b=Avnnh2PfOjsgMLizK031kKYbZw0trkBM2wR3GjBoBSkjIcb8zpTyqpH3NA0jO8/7/s
         woelaK4PAUivnLbGbR0hDaY6d4v5s4kSN7fY4jDNVi/v74YblMFEgkKzUBosd+vByBa/
         Cuewhd89ogo0k4sROTozRn32gGGkNodq1WxrUfk69AF/MA705c+GP/Q93WJmNiL9BEjg
         y+aPhBDG+RnQ4GbtZcfUxpigzD1riSvApLgzr0pNj0rT6HFydFanXTuoKdKjHuxujDXq
         ccDAlD+RQ39JBOdmFau2O3XgjEBNWcubP56UPUL63HM20a8oZWgyffyBpE8P6EeuPAPr
         2gxg==
X-Gm-Message-State: ACgBeo2ysLUruq+4IDWI6zfL0UpK/yhYrxnknK3TY5rbShXDFb5hqQ2T
	I6GF5A68Stt9BqAlF0epaAiwXHJEuV4=
X-Google-Smtp-Source: AA6agR6mvGzRu0BT1eqPce90lXG1q09wfFWIWHEanT9HQmFyO5BhufmxNQi+6EaYbqN/+FGPDao5Sw==
X-Received: by 2002:a63:1203:0:b0:429:c80d:1d17 with SMTP id h3-20020a631203000000b00429c80d1d17mr7426346pgl.24.1660940787101;
        Fri, 19 Aug 2022 13:26:27 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090340cf00b0016dbce87aecsm22206pld.182.2022.08.19.13.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:26:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/5] auto-t: update tests to use set_address/group_neighbors
Date: Fri, 19 Aug 2022 13:26:22 -0700
Message-Id: <20220819202624.1681246-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220819202624.1681246-1-prestwoj@gmail.com>
References: <20220819202624.1681246-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reduces the big blocks of copied code with a few function calls.
---
 .../testFT-8021x-roam/connection_test.py      | 26 ++----------
 autotests/testFT-FILS/connection_test.py      | 24 ++---------
 autotests/testPSK-roam/connection_test.py     | 24 ++---------
 .../testPSK-roam/roam_ap_disconnect_test.py   | 12 ++----
 autotests/testPreauth-roam/connection_test.py | 13 +-----
 autotests/testRoamRetry/fast_retry_test.py    | 15 +------
 autotests/testRoamRetry/stop_retry_test.py    | 15 +------
 autotests/testSAE-roam/connection_test.py     | 42 +++----------------
 8 files changed, 23 insertions(+), 148 deletions(-)

v2:
 * Rebased to upstream

diff --git a/autotests/testFT-8021x-roam/connection_test.py b/autotests/testFT-8021x-roam/connection_test.py
index 6853bdb0..d3f8e2c6 100644
--- a/autotests/testFT-8021x-roam/connection_test.py
+++ b/autotests/testFT-8021x-roam/connection_test.py
@@ -66,28 +66,10 @@ class Test(unittest.TestCase):
         cls.bss_hostapd = [ HostapdCLI(config='ft-eap-ccmp-1.conf'),
                             HostapdCLI(config='ft-eap-ccmp-2.conf') ]
 
-        # Set interface addresses to those expected by hostapd config files
-        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" down')
-        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + \
-                  '" address 12:00:00:00:00:01 up')
-        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + '" down')
-        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + \
-                  '" address 12:00:00:00:00:02 up')
-
-        cls.bss_hostapd[0].reload()
-        cls.bss_hostapd[0].wait_for_event("AP-ENABLED")
-        cls.bss_hostapd[1].reload()
-        cls.bss_hostapd[1].wait_for_event("AP-ENABLED")
-
-        # Fill in the neighbor AP tables in both BSSes.  By default each
-        # instance knows only about current BSS, even inside one hostapd
-        # process.
-        # FT still works without the neighbor AP table but neighbor reports
-        # have to be disabled in the .conf files
-        cls.bss_hostapd[0].set_neighbor('12:00:00:00:00:02', 'TestFT',
-                '1200000000028f0000005102060603000000')
-        cls.bss_hostapd[1].set_neighbor('12:00:00:00:00:01', 'TestFT',
-                '1200000000018f0000005101060603000000')
+        cls.bss_hostapd[0].set_address('12:00:00:00:00:01')
+        cls.bss_hostapd[1].set_address('12:00:00:00:00:02')
+
+        HostapdCLI.group_neighbors(*cls.bss_hostapd)
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testFT-FILS/connection_test.py b/autotests/testFT-FILS/connection_test.py
index c1deb77c..b1ec42e0 100644
--- a/autotests/testFT-FILS/connection_test.py
+++ b/autotests/testFT-FILS/connection_test.py
@@ -128,26 +128,10 @@ class Test(unittest.TestCase):
         cls.bss_hostapd = [ HostapdCLI(config='ft-eap-ccmp-1.conf'),
                             HostapdCLI(config='ft-eap-ccmp-2.conf') ]
 
-        # Set interface addresses to those expected by hostapd config files
-        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" down')
-        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" addr 12:00:00:00:00:01 up')
-        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + '" down')
-        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + '" addr 12:00:00:00:00:02 up')
-
-        cls.bss_hostapd[0].reload()
-        cls.bss_hostapd[0].wait_for_event("AP-ENABLED")
-        cls.bss_hostapd[1].reload()
-        cls.bss_hostapd[1].wait_for_event("AP-ENABLED")
-
-        # Fill in the neighbor AP tables in both BSSes.  By default each
-        # instance knows only about current BSS, even inside one hostapd
-        # process.
-        # FT still works without the neighbor AP table but neighbor reports
-        # have to be disabled in the .conf files
-        cls.bss_hostapd[0].set_neighbor('12:00:00:00:00:02', 'TestFT',
-                '1200000000028f0000005102060603000000')
-        cls.bss_hostapd[1].set_neighbor('12:00:00:00:00:01', 'TestFT',
-                '1200000000018f0000005101060603000000')
+        cls.bss_hostapd[0].set_address('12:00:00:00:00:01')
+        cls.bss_hostapd[1].set_address('12:00:00:00:00:02')
+
+        HostapdCLI.group_neighbors(*cls.bss_hostapd)
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-roam/connection_test.py
index c926e255..1b80d65b 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -199,26 +199,10 @@ class Test(unittest.TestCase):
         cls.rule2.source = rad0.addresses[0]
         cls.rule2.signal = -4000
 
-        # Set interface addresses to those expected by hostapd config files
-        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" down')
-        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" addr 12:00:00:00:00:01 up')
-        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + '" down')
-        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + '" addr 12:00:00:00:00:02 up')
-
-        cls.bss_hostapd[0].reload()
-        cls.bss_hostapd[0].wait_for_event("AP-ENABLED")
-        cls.bss_hostapd[1].reload()
-        cls.bss_hostapd[1].wait_for_event("AP-ENABLED")
-
-        # Fill in the neighbor AP tables in both BSSes.  By default each
-        # instance knows only about current BSS, even inside one hostapd
-        # process.
-        # FT still works without the neighbor AP table but neighbor reports
-        # have to be disabled in the .conf files
-        cls.bss_hostapd[0].set_neighbor('12:00:00:00:00:02', 'TestFT',
-                '1200000000028f0000005102060603000000')
-        cls.bss_hostapd[1].set_neighbor('12:00:00:00:00:01', 'TestFT',
-                '1200000000018f0000005101060603000000')
+        cls.bss_hostapd[0].set_address('12:00:00:00:00:01')
+        cls.bss_hostapd[1].set_address('12:00:00:00:00:02')
+
+        HostapdCLI.group_neighbors(*cls.bss_hostapd)
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testPSK-roam/roam_ap_disconnect_test.py b/autotests/testPSK-roam/roam_ap_disconnect_test.py
index 760c25fa..416541ce 100644
--- a/autotests/testPSK-roam/roam_ap_disconnect_test.py
+++ b/autotests/testPSK-roam/roam_ap_disconnect_test.py
@@ -46,10 +46,7 @@ class Test(unittest.TestCase):
         self.validate()
 
     def test_ap_disconnect_neighbors(self):
-        self.bss_hostapd[0].set_neighbor('12:00:00:00:00:02', 'TestFT',
-                '1200000000028f0000005102060603000000')
-        self.bss_hostapd[1].set_neighbor('12:00:00:00:00:01', 'TestFT',
-                '1200000000018f0000005101060603000000')
+        HostapdCLI.group_neighbors(*self.bss_hostapd)
 
         self.validate()
 
@@ -85,11 +82,8 @@ class Test(unittest.TestCase):
         cls.rule0.signal = -8000
         cls.rule0.enabled = True
 
-        # Set interface addresses to those expected by hostapd config files
-        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" down')
-        os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" addr 12:00:00:00:00:01 up')
-        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + '" down')
-        os.system('ip link set dev "' + cls.bss_hostapd[1].ifname + '" addr 12:00:00:00:00:02 up')
+        cls.bss_hostapd[0].set_address('12:00:00:00:00:01')
+        cls.bss_hostapd[1].set_address('12:00:00:00:00:02')
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testPreauth-roam/connection_test.py b/autotests/testPreauth-roam/connection_test.py
index 26475698..3c8fa0bb 100644
--- a/autotests/testPreauth-roam/connection_test.py
+++ b/autotests/testPreauth-roam/connection_test.py
@@ -17,18 +17,7 @@ class Test(unittest.TestCase):
         bss0_addr = bss_hostapd[0].bssid
         bss1_addr = bss_hostapd[1].bssid
 
-        # Fill in the neighbor AP tables in both BSSes.  By default each
-        # instance knows only about current BSS, even inside one hostapd
-        # process.
-        # Roaming still works without the neighbor AP table but neighbor
-        # reports have to be disabled in the .conf files
-        bss0_nr = ''.join(bss0_addr.split(':')) + \
-                '8f0000005101060603000000'
-        bss1_nr = ''.join(bss1_addr.split(':')) + \
-                '8f0000005102060603000000'
-
-        bss_hostapd[0].set_neighbor(bss1_addr, 'TestPreauth', bss1_nr)
-        bss_hostapd[1].set_neighbor(bss0_addr, 'TestPreauth', bss0_nr)
+        HostapdCLI.group_neighbors(*bss_hostapd)
 
         wd = IWD(True)
 
diff --git a/autotests/testRoamRetry/fast_retry_test.py b/autotests/testRoamRetry/fast_retry_test.py
index b45daada..373f3d45 100644
--- a/autotests/testRoamRetry/fast_retry_test.py
+++ b/autotests/testRoamRetry/fast_retry_test.py
@@ -36,20 +36,7 @@ class Test(unittest.TestCase):
         rule1.bidirectional = True
         rule1.enabled = True
 
-        # Fill in the neighbor AP tables in both BSSes.  By default each
-        # instance knows only about current BSS, even inside one hostapd
-        # process.
-        # Roaming still works without the neighbor AP table but neighbor
-        # reports have to be disabled in the .conf files
-        bss0_nr = ''.join(bss_radio[0].addresses[0].split(':')) + \
-                '8f0000005101060603000000'
-        bss1_nr = ''.join(bss_radio[1].addresses[0].split(':')) + \
-                '8f0000005102060603000000'
-
-        bss_hostapd[0].set_neighbor(bss_radio[1].addresses[0], 'TestRoamRetry',
-                bss1_nr)
-        bss_hostapd[1].set_neighbor(bss_radio[0].addresses[0], 'TestRoamRetry',
-                bss0_nr)
+        HostapdCLI.group_neighbors(*bss_hostapd)
 
         # Start in the vicinity of BSS 0, check that iwd connects to BSS 0
         rule0.signal = -2000
diff --git a/autotests/testRoamRetry/stop_retry_test.py b/autotests/testRoamRetry/stop_retry_test.py
index 3957d12d..b5eb6f77 100644
--- a/autotests/testRoamRetry/stop_retry_test.py
+++ b/autotests/testRoamRetry/stop_retry_test.py
@@ -35,20 +35,7 @@ class Test(unittest.TestCase):
         rule1.bidirectional = True
         rule1.enabled = True
 
-        # Fill in the neighbor AP tables in both BSSes.  By default each
-        # instance knows only about current BSS, even inside one hostapd
-        # process.
-        # Roaming still works without the neighbor AP table but neighbor
-        # reports have to be disabled in the .conf files
-        bss0_nr = ''.join(bss_radio[0].addresses[0].split(':')) + \
-                '8f0000005101060603000000'
-        bss1_nr = ''.join(bss_radio[1].addresses[0].split(':')) + \
-                '8f0000005102060603000000'
-
-        bss_hostapd[0].set_neighbor(bss_radio[1].addresses[0], 'TestRoamRetry',
-                bss1_nr)
-        bss_hostapd[1].set_neighbor(bss_radio[0].addresses[0], 'TestRoamRetry',
-                bss0_nr)
+        HostapdCLI.group_neighbors(*bss_hostapd)
 
         # Start in the vicinity of BSS 0, check that iwd connects to BSS 0
         rule0.signal = -2000
diff --git a/autotests/testSAE-roam/connection_test.py b/autotests/testSAE-roam/connection_test.py
index 2c8cd799..ac44b4b2 100644
--- a/autotests/testSAE-roam/connection_test.py
+++ b/autotests/testSAE-roam/connection_test.py
@@ -120,43 +120,11 @@ class Test(unittest.TestCase):
                             HostapdCLI(config='ft-sae-2.conf'),
                             HostapdCLI(config='ft-psk-3.conf') ]
 
-        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[0].ifname, 'down']).wait()
-        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[0].ifname, \
-                           'addr', '12:00:00:00:00:01', 'up']).wait()
-        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[1].ifname, 'down']).wait()
-        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[1].ifname, \
-                           'addr', '12:00:00:00:00:02', 'up']).wait()
-        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[2].ifname, 'down']).wait()
-        ctx.start_process(['ip', 'link', 'set', 'dev', cls.bss_hostapd[2].ifname, \
-                           'addr', '12:00:00:00:00:03', 'up']).wait()
-
-        # Set interface addresses to those expected by hostapd config files
-        cls.bss_hostapd[0].reload()
-        cls.bss_hostapd[0].wait_for_event("AP-ENABLED")
-        cls.bss_hostapd[1].reload()
-        cls.bss_hostapd[1].wait_for_event("AP-ENABLED")
-        cls.bss_hostapd[2].reload()
-        cls.bss_hostapd[2].wait_for_event("AP-ENABLED")
-
-        # Fill in the neighbor AP tables in both BSSes.  By default each
-        # instance knows only about current BSS, even inside one hostapd
-        # process.
-        # FT still works without the neighbor AP table but neighbor reports
-        # have to be disabled in the .conf files
-        cls.bss_hostapd[0].set_neighbor('12:00:00:00:00:02', 'TestFT',
-                '1200000000028f0000005102060603000000')
-        cls.bss_hostapd[0].set_neighbor('12:00:00:00:00:03', 'TestFT',
-                '1200000000038f0000005102060603000000')
-
-        cls.bss_hostapd[1].set_neighbor('12:00:00:00:00:01', 'TestFT',
-                '1200000000018f0000005101060603000000')
-        cls.bss_hostapd[1].set_neighbor('12:00:00:00:00:03', 'TestFT',
-                '1200000000038f0000005101060603000000')
-
-        cls.bss_hostapd[2].set_neighbor('12:00:00:00:00:01', 'TestFT',
-                '1200000000018f0000005101060603000000')
-        cls.bss_hostapd[2].set_neighbor('12:00:00:00:00:02', 'TestFT',
-                '1200000000028f0000005101060603000000')
+        cls.bss_hostapd[0].set_address('12:00:00:00:00:01')
+        cls.bss_hostapd[1].set_address('12:00:00:00:00:02')
+        cls.bss_hostapd[2].set_address('12:00:00:00:00:03')
+
+        HostapdCLI.group_neighbors(*cls.bss_hostapd)
 
         IWD.copy_to_storage('TestFT.psk')
 
-- 
2.34.3

