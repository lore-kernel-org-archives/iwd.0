Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87391CA14
	for <iwd@lists.linux.dev>; Tue, 22 Aug 2023 15:29:41 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3a7d4030621so2795915b6e.3
        for <iwd@lists.linux.dev>; Tue, 22 Aug 2023 08:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692718180; x=1693322980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaiQCf6vJ3cdWRNVf/xbx1j3AbvhsgUXvbvVHiZDFV0=;
        b=rVzJNJyUOrAbCTJSdfnfI7DwQjSFSDStEtfiFFXb7POJOpYn8IaOLYCYUchvw0GdGP
         oP2XLqKmIKcdZUmZ+WFuB8iEqQDH9+XrO0PAX4NtcyEHA2529jEPr84eCFiA4Mald2al
         ey5slNrRTWgr0pA1cARwR62XMm0CpgNbtspsfhGOyclfJuhl6zKVzq+5UCIUgssNCZro
         JTpb7BcFmdMMiabHUwPjLPTGK8tZgG2TAZazvXwRccVy7eZZ/Zeb2MAtJgJlJCQ+D0CA
         KXNPyYQ76bJIef+Pe7IfbwSD/PJl5TEsMsiJCY8vStKIS3giJDXfbY5wCXuJfnvluKVb
         jLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718180; x=1693322980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaiQCf6vJ3cdWRNVf/xbx1j3AbvhsgUXvbvVHiZDFV0=;
        b=ko5rs6FGMXBADeIe23KnlJU35CMW9Dv7VPVaICpRoVOPjrqaZs8tmFi2vxWa1gXOn9
         hvBFFmJUhx2fwQADlugCwAfBpnNYaDd9a5WQRzt99FNrpi31K6Mpo4CsFbuvPk3I3o5t
         pjJwZCfHs18xS82TkoAKmfr8obPkWe6hw8GLw9qs/Rcw75ENdmzjY5PxeReD6Swp5p1c
         oMBKt2K1S+CD9+HbEuGdL7koavLsajErxXldFKCDwpl2Jsrv8HcdJ+KZY83L5ljD2+5b
         SSgXY1mRhlbSH9Id9n5OKws2RuKAbMUX4VM9Yq8/kZvv594bxMxx6DJvgoLz3aF9B7DL
         dB5Q==
X-Gm-Message-State: AOJu0YwZGd/m5EWJgeXeEMi/ToPAQcxN2UeAMRFXLMhDwufZLfdIoJlj
	Klrz2s1AUZBOy/MtwWe55zPFZWTV1JQ=
X-Google-Smtp-Source: AGHT+IG2BlxHD/huoJxx5ZNQCHljQUlX9aQAtaW9l+WlA7r6i4HCh/AnE9mG4bPg590pcd0rG4azKg==
X-Received: by 2002:a05:6358:c1d:b0:135:4c43:f4df with SMTP id f29-20020a0563580c1d00b001354c43f4dfmr5751935rwj.3.1692718180248;
        Tue, 22 Aug 2023 08:29:40 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id j189-20020a816ec6000000b0058fafe95f98sm2108796ywc.114.2023.08.22.08.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:29:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] auto-t: add fallback to reassociate test
Date: Tue, 22 Aug 2023 08:29:31 -0700
Message-Id: <20230822152931.276136-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822152931.276136-1-prestwoj@gmail.com>
References: <20230822152931.276136-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests that IWD falls back to reassociation if FT fails with
status 53.
---
 autotests/testPSK-roam/failed_roam_test.py | 70 +++++++++++++++++++++-
 autotests/testPSK-roam/ft-psk-ccmp-1.conf  |  1 +
 autotests/testPSK-roam/ft-psk-ccmp-2.conf  |  1 +
 autotests/testPSK-roam/ft-psk-ccmp-3.conf  |  1 +
 4 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/autotests/testPSK-roam/failed_roam_test.py b/autotests/testPSK-roam/failed_roam_test.py
index eda2b4e2..74c10ffc 100644
--- a/autotests/testPSK-roam/failed_roam_test.py
+++ b/autotests/testPSK-roam/failed_roam_test.py
@@ -41,18 +41,22 @@ class Test(unittest.TestCase):
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                           (prev.ifname, device.name, True, True))
 
-
     # FT-over-Air failure, should stay connected
     def test_ft_over_air_failure(self):
+        self.rule2.enabled = True
+        self.rule3.enabled = True
+
         self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-PSK')
         self.bss_hostapd[0].set_value('ft_over_ds', '0')
         self.bss_hostapd[0].reload()
         self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[0].set_value('ft_psk_generate_local', '1')
 
         self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-PSK')
         self.bss_hostapd[1].set_value('ft_over_ds', '0')
         self.bss_hostapd[1].reload()
         self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[1].set_value('ft_psk_generate_local', '1')
 
         wd = IWD(True)
 
@@ -70,9 +74,60 @@ class Test(unittest.TestCase):
         self.rule0.enabled = False
 
         # IWD should then try BSS 2, and succeed
+        device.wait_for_event('ft-roam', timeout=60)
         self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[2])
 
         self.bss_hostapd[2].deauthenticate(device.address)
+
+    # FT-over-Air failure, should stay connected
+    def test_ft_over_air_fallback(self):
+        self.rule_bss0.signal = -8000
+        self.rule_bss0.enabled = True
+        self.rule_bss1.signal = -7500
+        self.rule_bss1.enabled = True
+        self.rule_bss2.signal = -6000
+        self.rule_bss2.enabled = True
+
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[0].set_value('ft_over_ds', '0')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[0].set_value('ft_psk_generate_local', '1')
+
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[1].set_value('ft_over_ds', '0')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+        self.bss_hostapd[1].set_value('ft_psk_generate_local', '1')
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
+
+        self.assertTrue(device.state == DeviceState.connected)
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
 
@@ -85,6 +140,10 @@ class Test(unittest.TestCase):
         self.rule0.enabled = False
         self.rule1.enabled = False
         self.rule2.enabled = False
+        self.rule3.enabled = False
+        self.rule_bss0.enabled = False
+        self.rule_bss1.enabled = False
+        self.rule_bss2.enabled = False
 
     @classmethod
     def setUpClass(cls):
@@ -116,13 +175,18 @@ class Test(unittest.TestCase):
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
index 4a2ceba5..5647c49f 100644
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
index a42e175d..7d4ad221 100644
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
index a42e175d..7d4ad221 100644
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

