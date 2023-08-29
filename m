Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA428E7
	for <iwd@lists.linux.dev>; Tue, 29 Aug 2023 14:51:32 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1bc0d39b52cso27074695ad.2
        for <iwd@lists.linux.dev>; Tue, 29 Aug 2023 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693320692; x=1693925492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SmPT/s2ibH9frOxAvwVFHmqsR0LKIGPMhUHpZAkHwA=;
        b=elkZBE3NmiWmQmb44aPgYrZRFz8SJazLsOpfQPdUEFAs838lXboYUJcXpFvfmxvgX4
         9eQ2ClC2IZTYQc1auz6i1s+Yb1lnwVg3voOOiRxSCwjyYM+ERptEcbF8pQ0t69ywo0hd
         +QkkvXrZYEHWjrSgFQGBnYjQQJWXfvpYDNfHb/Fxlj+ZZ2m4qjHksM2pa15VCU00DuUv
         GfWoZ4jvVVca3zkbrfy6Xds7HQiku8F8JnYrW07Jv48NnYKwZtDCDjJJskEoa5e/p7Ef
         UUIG72MEz/O+EMyQkOH/5wQt0Y6htufaAD2IQoEuFOewh1MGFi4Jdd2m2yegKHUeSBN/
         vjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693320692; x=1693925492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SmPT/s2ibH9frOxAvwVFHmqsR0LKIGPMhUHpZAkHwA=;
        b=lxm2VmUvSs3CoPWUY7E0HzDop+kWKVxJs798oeUbfpAe5gUYbpONKyOR+qbcQ12Nge
         Px+kbta+I30HFDi1taauTTpIX9Y/eRaF9CpRa0sEM9pZBQFxUjM+K+fN9g94WQdYC1IJ
         MI8wA8WeGQl5GvMYOTAOLXzoWE7ZK/zMTuOPhZmJLcGE/6T1JtyFcM4MA9rfeKSoUZW7
         lrVcVtNqy1uJv9ptfb9X8VHZ4DMzo0tNUtanxHlPGOAVX1Ngms/FIx8b3UXpjOTy44EO
         3ZiwG2S1Eqm069Ktqlyq1dVls8j7aNxnlIPVsmN5DVVPbRxGIpf9QICYIP/N4VlRWS/F
         2KLw==
X-Gm-Message-State: AOJu0Ywm3sMs5ssPdT1Y+fKnrRVyJbMgOBpDd3lN9lA2AbLK6EvQQQa+
	xEbgG0L6KVIaYi4wX40pE9bqZr8bsjA=
X-Google-Smtp-Source: AGHT+IGx3L2XfCU3Ip0MylPQsS9TcFMe5Ut/8SSqp1opsv4ZkkYpdnhts7JeVw8BKnxru0SktaOgWA==
X-Received: by 2002:a17:903:244a:b0:1b5:561a:5ca9 with SMTP id l10-20020a170903244a00b001b5561a5ca9mr26265138pls.50.1693320692173;
        Tue, 29 Aug 2023 07:51:32 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b001bc445e249asm9661283pln.124.2023.08.29.07.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 07:51:31 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] auto-t: add fallback to reassociate test
Date: Tue, 29 Aug 2023 07:51:16 -0700
Message-Id: <20230829145116.279949-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829145116.279949-1-prestwoj@gmail.com>
References: <20230829145116.279949-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testPSK-roam/failed_roam_test.py | 90 +++++++++++++++++++++-
 autotests/testPSK-roam/ft-psk-ccmp-1.conf  |  1 +
 autotests/testPSK-roam/ft-psk-ccmp-2.conf  |  1 +
 autotests/testPSK-roam/ft-psk-ccmp-3.conf  |  1 +
 4 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/autotests/testPSK-roam/failed_roam_test.py b/autotests/testPSK-roam/failed_roam_test.py
index 8a3db662..09947705 100644
--- a/autotests/testPSK-roam/failed_roam_test.py
+++ b/autotests/testPSK-roam/failed_roam_test.py
@@ -41,9 +41,11 @@ class Test(unittest.TestCase):
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                           (prev.ifname, device.name, True, True))
 
-
     # FT-over-Air failure, should stay connected
     def test_ft_over_air_failure(self):
+        self.rule2.enabled = True
+        self.rule3.enabled = True
+
         wd = IWD(True)
 
         device = wd.list_devices(1)[0]
@@ -60,12 +62,85 @@ class Test(unittest.TestCase):
         self.rule0.enabled = False
 
         # IWD should then try BSS 2, and succeed
+        device.wait_for_event('ft-roam', timeout=60)
         self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[2])
 
         self.bss_hostapd[2].deauthenticate(device.address)
+
+    # FT-over-Air failure with Invalid PMKID, should reassociate
+    def test_ft_over_air_fallback(self):
+        self.rule_bss0.signal = -8000
+        self.rule_bss0.enabled = True
+        self.rule_bss1.signal = -7500
+        self.rule_bss1.enabled = True
+        self.rule_bss2.signal = -6000
+        self.rule_bss2.enabled = True
+
+        # This will cause this BSS to reject any FT roams as its unable to
+        # get keys from other APs
+        self.bss_hostapd[2].set_value('ft_psk_generate_local', '0')
+        self.bss_hostapd[2].reload()
+
+        wd = IWD(True)
+
+        device = wd.list_devices(1)[0]
+
+        self.connect(wd, device, self.bss_hostapd[0])
+
+        # IWD should connect, then attempt a roam to BSS 1, which should
+        # fail and cause a fallback to reassociation
+        device.wait_for_event('ft-fallback-to-reassoc', timeout=60)
+        device.wait_for_event('reassoc-roam', timeout=60)
+
+        self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[2])
+
+        # Trigger another roam
+        self.rule_bss2.signal = -8000
+
+        device.wait_for_event('ft-roam', timeout=60)
+
+        # Ensure an FT roam back to a properly configured AP works.
+        self.verify_roam(wd, device, self.bss_hostapd[2], self.bss_hostapd[1])
+
+        self.bss_hostapd[1].deauthenticate(device.address)
         condition = 'obj.state == DeviceState.disconnected'
         wd.wait_for_object_condition(device, condition)
 
+    # FT-over-Air failure with Invalid PMKID. The ranking is such that other
+    # FT candidates are available so it should FT elsewhere rather than
+    # retry with reassociation
+    def test_ft_over_air_fallback_retry_ft(self):
+        self.rule_bss0.signal = -8000
+        self.rule_bss0.enabled = True
+        self.rule_bss1.signal = -7300
+        self.rule_bss1.enabled = True
+        self.rule_bss2.signal = -7100
+        self.rule_bss2.enabled = True
+
+        # This will cause this BSS to reject any FT roams as its unable to
+        # get keys from other APs
+        self.bss_hostapd[2].set_value('ft_psk_generate_local', '0')
+        self.bss_hostapd[2].reload()
+
+        wd = IWD(True)
+
+        device = wd.list_devices(1)[0]
+
+        self.connect(wd, device, self.bss_hostapd[0])
+
+        # IWD should connect, then attempt a roam to BSS 1, which should
+        # fail and cause the rank to be re-computed. This shoudl then put
+        # bss 1 as the next candidate (since the FT factor is removed)
+        device.wait_for_event('ft-fallback-to-reassoc', timeout=60)
+        device.wait_for_event('ft-roam', timeout=60)
+
+        self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[1])
+
+        self.bss_hostapd[1].deauthenticate(device.address)
+        condition = 'obj.state == DeviceState.disconnected'
+        wd.wait_for_object_condition(device, condition)
+
+
     def tearDown(self):
         os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
         os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
@@ -75,6 +150,10 @@ class Test(unittest.TestCase):
         self.rule0.enabled = False
         self.rule1.enabled = False
         self.rule2.enabled = False
+        self.rule3.enabled = False
+        self.rule_bss0.enabled = False
+        self.rule_bss1.enabled = False
+        self.rule_bss2.enabled = False
 
         for hapd in self.bss_hostapd:
             hapd.default()
@@ -109,13 +188,18 @@ class Test(unittest.TestCase):
         cls.rule2 = hwsim.rules.create()
         cls.rule2.source = hwsim.get_radio('rad0').addresses[0]
         cls.rule2.signal = -8000
-        cls.rule2.enabled = True
 
         # Causes IWD to first prefer BSS 1 to roam, then BSS 2.
         cls.rule3 = hwsim.rules.create()
         cls.rule3.source = hwsim.get_radio('rad2').addresses[0]
         cls.rule3.signal = -7000
-        cls.rule3.enabled = True
+
+        cls.rule_bss0 = hwsim.rules.create()
+        cls.rule_bss0.source = hwsim.get_radio('rad0').addresses[0]
+        cls.rule_bss1 = hwsim.rules.create()
+        cls.rule_bss1.source = hwsim.get_radio('rad1').addresses[0]
+        cls.rule_bss2 = hwsim.rules.create()
+        cls.rule_bss2.source = hwsim.get_radio('rad2').addresses[0]
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-1.conf b/autotests/testPSK-roam/ft-psk-ccmp-1.conf
index eec8805f..b46d1f27 100644
--- a/autotests/testPSK-roam/ft-psk-ccmp-1.conf
+++ b/autotests/testPSK-roam/ft-psk-ccmp-1.conf
@@ -33,6 +33,7 @@ pmk_r1_push=0
 # case.  Only works with FT-PSK, otherwise brctl needs to be installed and
 # CONFIG_BRIDGE enabled in the kernel.
 ft_psk_generate_local=1
+rkh_pull_timeout=50
 ft_over_ds=0
 ap_table_expiration_time=36000
 ap_table_max_size=10
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-2.conf b/autotests/testPSK-roam/ft-psk-ccmp-2.conf
index 5992461f..3e215457 100644
--- a/autotests/testPSK-roam/ft-psk-ccmp-2.conf
+++ b/autotests/testPSK-roam/ft-psk-ccmp-2.conf
@@ -33,6 +33,7 @@ pmk_r1_push=0
 # case.  Only works with FT-PSK, otherwise brctl needs to be installed and
 # CONFIG_BRIDGE enabled in the kernel.
 ft_psk_generate_local=1
+rkh_pull_timeout=50
 ft_over_ds=0
 ap_table_expiration_time=36000
 ap_table_max_size=10
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-3.conf b/autotests/testPSK-roam/ft-psk-ccmp-3.conf
index 5992461f..3e215457 100644
--- a/autotests/testPSK-roam/ft-psk-ccmp-3.conf
+++ b/autotests/testPSK-roam/ft-psk-ccmp-3.conf
@@ -33,6 +33,7 @@ pmk_r1_push=0
 # case.  Only works with FT-PSK, otherwise brctl needs to be installed and
 # CONFIG_BRIDGE enabled in the kernel.
 ft_psk_generate_local=1
+rkh_pull_timeout=50
 ft_over_ds=0
 ap_table_expiration_time=36000
 ap_table_max_size=10
-- 
2.25.1

