Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB56944C
	for <iwd@lists.linux.dev>; Thu, 31 Aug 2023 12:39:36 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5920efd91c7so9189667b3.2
        for <iwd@lists.linux.dev>; Thu, 31 Aug 2023 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693485575; x=1694090375; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YrdJUz6l/nAOWO+Ihzy3wI1VRGwz/0unEX6r/TnntQ=;
        b=B69aZsokhSem+Q7U4wiRp4IMcGncTsBXjhq5WxZ9xulshHhDXC5S9rMLLsX7wI1WY3
         BDL4vKYRljz41rSJDEHm9t/okdjHxKfZCY9ezHgoxyS1E7QhUULUl8PX5vdh44nUYSPa
         eitM/comd5GTn15B51WmHB1npis/i2Mq0q9Iz/LVw5DbCYpw+/sm4pq6SflGo8Gra2qD
         M0SNLOvYi82EhWsb/UjmtbmAwtUNBxiONBMxErGWtXJ8tdRgYC+VZQUGqxT+53pGErVe
         +yCumAa7nzCxNVQlkIbO24OTNKNdx5ix7OSfOavVhQ0iTtA71E5cbMj46agbTFJi53Hf
         cHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693485575; x=1694090375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YrdJUz6l/nAOWO+Ihzy3wI1VRGwz/0unEX6r/TnntQ=;
        b=k6hpwEXx4X2tupsrakyVNkmgzU2ry+u3H9DKi1pqEsa/HaqxCQMF7qDag/h0XWUk3f
         SH1eLwKz241uLKs4NaWGfRBxkccG7tOlMCva3D84d/EfURSvbrqYLRwMt5LVb4T1opIa
         AfFJAp766922kW5bHDKCaVqtfLEipfF3Dh4h9ZC/AbvhDM917h85ZhVIkBJwXYTSsKsm
         ZevNFDu6EvMbdbOI9KJaI3dg+jJ1S8WxNXUJVc4GwSMGEiECKg1XAbQZ5HyrrEhPWPqY
         O83hsYNJVJKoC16M103QitShm/4kRaV7uOIdBKN9dIpqpgIVZNs4n6YWj6FyHvcxQbuN
         ZD+w==
X-Gm-Message-State: AOJu0YyHOY1ZVTjOoCh2hvAbmVO/DOzQFoV67YWL2q6wTBc9v8MOPtz1
	2HXRq9/KxI9TwQ8v1CtfjHGBEUAeaPY=
X-Google-Smtp-Source: AGHT+IG9sHCYAhR5yNnBSAX2XCTeFeZbvMUK4G1dNtOlfBC1JNz+M/H9dUDizwo0Qpa5UewfM2/tYQ==
X-Received: by 2002:a0d:f206:0:b0:583:d60c:c17c with SMTP id b6-20020a0df206000000b00583d60cc17cmr5002475ywf.20.1693485575344;
        Thu, 31 Aug 2023 05:39:35 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id p5-20020a0dcd05000000b0057a44e20fb8sm380308ywd.73.2023.08.31.05.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:39:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/3] auto-t: add fallback to reassociate test
Date: Thu, 31 Aug 2023 05:39:24 -0700
Message-Id: <20230831123924.531560-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831123924.531560-1-prestwoj@gmail.com>
References: <20230831123924.531560-1-prestwoj@gmail.com>
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
index 8a3db662..90f07f6b 100644
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
+        # fail and cause the rank to be re-computed. This should then put
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

