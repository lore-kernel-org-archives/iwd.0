Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F7B6A33A
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esvr7piR"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67ad277a06bso10521256d6.1
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 09:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701798730; x=1702403530; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVHMO7Otc6oGvuT5BowEFRQ4zTPllN713Scz6cm8/k0=;
        b=esvr7piRCUXk6hX18KTUs5TY0EPNrXA4Bcsvxist2OiUZ+mvEJo+abvEHMWXsInA8E
         Okm1nozYHGlZ0EbSecLPNPgwiq35QMQ7eoD+GqEPE92YlR3JH307SNBrFcvbMe8fFkyI
         UV/laRKMeIWx76kxkvvMgM4NU9ahCzPltzSMrWRpvr0w3jOg/QXtqhoSyuxwdY8nZ+N3
         +IGMuq+WNyu1uap+AoEsPnoE9Ewh6s+jh/jRODeSjgxMoHLGbkPgmq1++2YF8Nld1CTi
         jcUXYPSR3wXLhebOwJ0q6+GcEoqI4+/BexCdWftGwTP9dBZGyJoXDMksgGvHV0yi5UGH
         UR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701798730; x=1702403530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVHMO7Otc6oGvuT5BowEFRQ4zTPllN713Scz6cm8/k0=;
        b=eT8lpGefKkmY7Y8kXrFShRQYR1GSzHf2rkjV8gR4AdKN6HHZY3iCoRkm9qrG2NoIRI
         OKiyggdMYp8H3VFgPO+lL1pb44+e2j0u+sZQf971qDXUweECOh9QYr6p0mOAyJ/RHSmB
         cMHZbVge9xrusMBRG7VoaXWMZb5k0iPzdQFCqF3jBXvhJ9DmLYE5Nexe7aWMcM9Rt0g+
         b+NSbw8TZO58lTxvJ/b2EolfDTdrgSeg++ijPTuMovp8Ir+MZsk+0GMqZVrdx+zTAO76
         bkRX05tD7bJUpbm2fRLhg7o774ueWtQg0lWLbvGtJ28NdxKIIilX7q6kb5QtzI4dE9au
         Oq+w==
X-Gm-Message-State: AOJu0YzHYHP7gTcIazkjNxsD255qbfcP/AlxCwGF5zw6HkgrfpIdyMhW
	jCisyFhkPvxNDF/ZUDjI6eZKwhe+l+g=
X-Google-Smtp-Source: AGHT+IHmjhYGL4UkUllI/9sYgWQvDDkh+BigLtbzdP36VcbwggY9ES2QI5M81h/gKtm3HlXHvJPJRQ==
X-Received: by 2002:a0c:ef85:0:b0:67a:b5de:1dff with SMTP id w5-20020a0cef85000000b0067ab5de1dffmr1682794qvr.74.1701798730268;
        Tue, 05 Dec 2023 09:52:10 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c7-20020a0ce147000000b0067ae01ab283sm192599qvl.36.2023.12.05.09.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 09:52:10 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] auto-t: add association timeout test
Date: Tue,  5 Dec 2023 09:52:02 -0800
Message-Id: <20231205175203.1935692-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205175203.1935692-1-prestwoj@gmail.com>
References: <20231205175203.1935692-1-prestwoj@gmail.com>
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

