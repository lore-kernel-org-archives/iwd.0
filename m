Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601A30FB9
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5rGVepU"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-77d63b733e4so428417185a.2
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 07:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875235; x=1702480035; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVHMO7Otc6oGvuT5BowEFRQ4zTPllN713Scz6cm8/k0=;
        b=Y5rGVepU5lSXRVXvg/j07Itxw6eTGCJ+x5Fzsz+hS7cLDczxzFQ7lhoHpz9dgq0NP9
         cOy461W1S5DYIZvHqJ4wB00aKTCa7s9Hay6BdKt4GSLiPjfm1HGN3Ru24uDJRLbnbFau
         GojHjdQ2PEDwadZZXO0gKNK59C8KZo/nmiI2yp6AMboL7lQaVIGmMsgUlOROP35GfYPY
         nmaVZQ6TpFJhdFtRTsqUSNra2iYfJwPO8qcQ+SLyEweP8usam2RC9j0Dd0uwMD2xjL+W
         ajiLa4jd+Z22gC8+xGa/iwB9G/NEl0wKOTqsjr6vA9CMuuS1ILlzzqjRisKOG+tfvXOT
         rS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875235; x=1702480035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVHMO7Otc6oGvuT5BowEFRQ4zTPllN713Scz6cm8/k0=;
        b=BOLWy6+dR9W6ddL5qLd13LLyvF85dRWCoY0Idbe5uC2ej5VcCFd6rMh5W4wqqMCZoa
         1bJP3x7QNjt8PawpQlvIMgzK+30IePvzILaPGOMWpGk45knPgLYAwOboz4kQlXoOUDdW
         XKxIiCOU146h83tWvUwuHNeX4mccG2fJu3IKR5gtSeVAGmBltTScg2siFtg2cLvIZdlQ
         yXC5f4KQJK0EcAnPKg6NMpNpUb/kaRrwWnpENObBVgwOZzpMVGZtiBS7O3K7pzxLgHra
         j/PMgdzfNZvWpabk5fxgbVTy1ufy1n0xbrmi9J2OsH6ewgpH907AopBMoR1Edy6V5aKN
         i70g==
X-Gm-Message-State: AOJu0YxWfPs2qQksEZ1j5bayiCi7Ez8p5bCTw0e4gddA9SyHbjMQpCCz
	Uu154ci3cdhpKc+661fQwhMJPN18J3o=
X-Google-Smtp-Source: AGHT+IG97jT1BV8Hp7eAX7uHhkXWK7sdusvQFHTK+eobQXbM2Tye7Jg3xkus8a7wAfoCQ1d5Jr5QqA==
X-Received: by 2002:a05:620a:8e82:b0:77f:38c:f03 with SMTP id rf2-20020a05620a8e8200b0077f038c0f03mr928629qkn.120.1701875235436;
        Wed, 06 Dec 2023 07:07:15 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id vy22-20020a05620a491600b0077d66277e9asm11506qkn.116.2023.12.06.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:07:15 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/9] auto-t: add association timeout test
Date: Wed,  6 Dec 2023 07:07:01 -0800
Message-Id: <20231206150708.2080336-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206150708.2080336-1-prestwoj@gmail.com>
References: <20231206150708.2080336-1-prestwoj@gmail.com>
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

