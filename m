Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF448CFA
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo+zauh3"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ce72730548so218736b3a.1
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 12:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893888; x=1702498688; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVHMO7Otc6oGvuT5BowEFRQ4zTPllN713Scz6cm8/k0=;
        b=Yo+zauh3q/P09g8cY99MrTWimcUx9JoLgUExP/tuvEBqMQwEl50E2WPXOn4aNXV3Ki
         rQZviBHEE43Ln9wvs/C4Sd8vNtVts5SVrHujf76cEEJxyssx8WyzXjrQi1FiGuMnqtxk
         eHp/TIyLOYworVETvLJkOquVh+z3+LSkxtqK3lA1uIxLB54u+dujxfPv4yYvfkdeUZJP
         SzC12RbSU1fX+9Li4U7beoeR008U2gi7z28MtqT1jOLTYPCxELr2u9ar8nh734l/wlGH
         FF4LrMi4d/zMJn/vY59wzoE/3FoB/bBygJ/zsF16zZG8CQVo/pk7YiEULiyoXIaVO2nU
         pEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893888; x=1702498688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVHMO7Otc6oGvuT5BowEFRQ4zTPllN713Scz6cm8/k0=;
        b=WCYtyunVmaQQbcE0TyVNbDI2kWpdGjrW2d3c/aKbjfIT78x+xrKh4CaGUvGJmUeaYN
         XNXgNYNpSpWsE9qEWczVXUepgJn9+TFlN026Ua52V8TjfpWW/YXpzRmMvIt5zhpzdSSl
         AzL+3/ASEzxE7beqxUyXhg7uAqRD+3e8+yiwYiH6+wvEIf/rtYVy8tBClKycGlMXKehH
         8WBMq2yKpkBlxqbc0F9MU0OekOBp2eA75LeJhbox5XY8zWjzc2p9oY2PpcfnMLsxMA3B
         0u+YdH67cuB90BnqWJItqOaTRes5WMy9ur3/yDTbiXJzRAnZm1PWJ2gcm0ZsiWcNQZWg
         ndyA==
X-Gm-Message-State: AOJu0YyZOLci3v4LOwtDuOdUZQy9Qwbr2JR3FePusLAuHpn5mow788Qo
	V1PLK3EXSO4Km9cHyp9IXqtEpi/sQPId5A==
X-Google-Smtp-Source: AGHT+IEEuLaKa/BCPR5OnELRfXMX5CPm9ECsMwPS9AmAxq6s5hoYbNDW9KSxVc7eB4k46fxUbv65qA==
X-Received: by 2002:a05:6a00:4396:b0:6be:314c:16cb with SMTP id bt22-20020a056a00439600b006be314c16cbmr1699557pfb.10.1701893887793;
        Wed, 06 Dec 2023 12:18:07 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id by40-20020a056a0205a800b005c2185be2basm243168pgb.54.2023.12.06.12.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:18:07 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 02/13] auto-t: add association timeout test
Date: Wed,  6 Dec 2023 12:17:51 -0800
Message-Id: <20231206201802.2139649-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206201802.2139649-1-prestwoj@gmail.com>
References: <20231206201802.2139649-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tests ensures IWD disconnects after receiving an association
timeout event. This exposes a current bug where IWD does not
transition to disconnected after an association timeout when
FT-roaming.
---
 autotests/testPSK-roam/failed_roam_test.py | 56 +++++++++++++++-------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/autotests/testPSK-roam/failed_roam_test.py b/autotests/testPSK-roam/failed_roam_test.py
index 90f07f6b..d42002d4 100644
--- a/autotests/testPSK-roam/failed_roam_test.py
+++ b/autotests/testPSK-roam/failed_roam_test.py
@@ -46,11 +46,9 @@ class Test(unittest.TestCase):
         self.rule2.enabled = True
         self.rule3.enabled = True
 
-        wd = IWD(True)
+        device = self.wd.list_devices(1)[0]
 
-        device = wd.list_devices(1)[0]
-
-        self.connect(wd, device, self.bss_hostapd[0])
+        self.connect(self.wd, device, self.bss_hostapd[0])
 
         self.rule0.enabled = True
 
@@ -63,10 +61,25 @@ class Test(unittest.TestCase):
 
         # IWD should then try BSS 2, and succeed
         device.wait_for_event('ft-roam', timeout=60)
-        self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[2])
+        self.verify_roam(self.wd, device, self.bss_hostapd[0], self.bss_hostapd[2])
 
         self.bss_hostapd[2].deauthenticate(device.address)
 
+    # Tests that an associate even should cause a disconnect
+    def test_ft_over_air_assoc_timeout(self):
+        self.rule2.enabled = True
+        self.rule3.enabled = True
+        self.assoc_rule.enabled = True
+
+        device = self.wd.list_devices(1)[0]
+
+        self.connect(self.wd, device, self.bss_hostapd[0])
+
+        device.wait_for_event('ft-roam', timeout=60)
+
+        condition = 'obj.state == DeviceState.disconnected'
+        self.wd.wait_for_object_condition(device, condition)
+
     # FT-over-Air failure with Invalid PMKID, should reassociate
     def test_ft_over_air_fallback(self):
         self.rule_bss0.signal = -8000
@@ -81,18 +94,16 @@ class Test(unittest.TestCase):
         self.bss_hostapd[2].set_value('ft_psk_generate_local', '0')
         self.bss_hostapd[2].reload()
 
-        wd = IWD(True)
+        device = self.wd.list_devices(1)[0]
 
-        device = wd.list_devices(1)[0]
-
-        self.connect(wd, device, self.bss_hostapd[0])
+        self.connect(self.wd, device, self.bss_hostapd[0])
 
         # IWD should connect, then attempt a roam to BSS 1, which should
         # fail and cause a fallback to reassociation
         device.wait_for_event('ft-fallback-to-reassoc', timeout=60)
         device.wait_for_event('reassoc-roam', timeout=60)
 
-        self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[2])
+        self.verify_roam(self.wd, device, self.bss_hostapd[0], self.bss_hostapd[2])
 
         # Trigger another roam
         self.rule_bss2.signal = -8000
@@ -100,11 +111,11 @@ class Test(unittest.TestCase):
         device.wait_for_event('ft-roam', timeout=60)
 
         # Ensure an FT roam back to a properly configured AP works.
-        self.verify_roam(wd, device, self.bss_hostapd[2], self.bss_hostapd[1])
+        self.verify_roam(self.wd, device, self.bss_hostapd[2], self.bss_hostapd[1])
 
         self.bss_hostapd[1].deauthenticate(device.address)
         condition = 'obj.state == DeviceState.disconnected'
-        wd.wait_for_object_condition(device, condition)
+        self.wd.wait_for_object_condition(device, condition)
 
     # FT-over-Air failure with Invalid PMKID. The ranking is such that other
     # FT candidates are available so it should FT elsewhere rather than
@@ -122,11 +133,9 @@ class Test(unittest.TestCase):
         self.bss_hostapd[2].set_value('ft_psk_generate_local', '0')
         self.bss_hostapd[2].reload()
 
-        wd = IWD(True)
+        device = self.wd.list_devices(1)[0]
 
-        device = wd.list_devices(1)[0]
-
-        self.connect(wd, device, self.bss_hostapd[0])
+        self.connect(self.wd, device, self.bss_hostapd[0])
 
         # IWD should connect, then attempt a roam to BSS 1, which should
         # fail and cause the rank to be re-computed. This should then put
@@ -134,12 +143,14 @@ class Test(unittest.TestCase):
         device.wait_for_event('ft-fallback-to-reassoc', timeout=60)
         device.wait_for_event('ft-roam', timeout=60)
 
-        self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[1])
+        self.verify_roam(self.wd, device, self.bss_hostapd[0], self.bss_hostapd[1])
 
         self.bss_hostapd[1].deauthenticate(device.address)
         condition = 'obj.state == DeviceState.disconnected'
-        wd.wait_for_object_condition(device, condition)
+        self.wd.wait_for_object_condition(device, condition)
 
+    def setUp(self):
+        self.wd = IWD(True)
 
     def tearDown(self):
         os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
@@ -154,10 +165,14 @@ class Test(unittest.TestCase):
         self.rule_bss0.enabled = False
         self.rule_bss1.enabled = False
         self.rule_bss2.enabled = False
+        self.assoc_rule.enabled = False
 
         for hapd in self.bss_hostapd:
             hapd.default()
 
+        self.wd.stop()
+        self.wd = None
+
     @classmethod
     def setUpClass(cls):
         hwsim = Hwsim()
@@ -178,6 +193,11 @@ class Test(unittest.TestCase):
         cls.rule0.prefix = 'b0'
         cls.rule0.drop = True
 
+        # Drop Associate frames
+        cls.assoc_rule = hwsim.rules.create()
+        cls.assoc_rule.prefix = '20'
+        cls.assoc_rule.drop = True
+
         # Drop Action frames
         cls.rule1 = hwsim.rules.create()
         cls.rule1.bidirectional = True
-- 
2.34.1

