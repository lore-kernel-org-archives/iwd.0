Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8067E74
	for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkOQlq/c"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-425ff068d02so5344981cf.1
        for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 10:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702576889; x=1703181689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik0TpLbzBGGyA9CN4Lx6Q7/i/gSeXuVLaDc4xi3xR0A=;
        b=DkOQlq/cb/efEz77357Z03NDDiZQqz+/J4PisS8UGrwm8OIzxE/VL/rG53X0XWnXrA
         5b/PR2RulQkri39YCvr5xC/DwvbzeXoM75dqx9kJ/76flg22FP454qtxhzMhyk5elSt7
         R2yk/e5Pq6FesvyrvHqI91KZnysYnlDELaCxbH7MEK98TSDq2pjEgZ96ytew17g0Ozk2
         5QDcKgeMHVO+6K1dZDKgF1eksyK3mitRG8gy5PP4yEqLPcmfdojiI0SDKGcyHkcPz8my
         xf8jMHW0HDuzM3aXrx0RHDTWEnb3hHI6nhlGtF7NeEvyssRJn2P3z15UvR2hdfKwpO60
         8TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576889; x=1703181689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ik0TpLbzBGGyA9CN4Lx6Q7/i/gSeXuVLaDc4xi3xR0A=;
        b=t/KpXABm2t+wDR/9wSyzt9HbI6sbwBbwpRsFBguekEU3nqiH0Hh/yknel8yZPYDsPo
         jkXu92rZWz/hrPEFJxs41tOZGbghwKNAcNPEIcARvuRZ3bCzx8vN0Cs3nGTglNX586j5
         T61A5FGQDpNPQLkEELO8+zpRzfzBOfdhDF9YbQzvGj4VTN3P9x7K5xG0r4XAWq9wzGtX
         jTlPL3Mo6Mzp0bCxsK5p4Q3MezhDZY9C5v/FhHNaHjJ43xXrLLhNQ9Noy3DhLPJWzyfZ
         rfpViRYosrk59zJlBHQQmYZhGCvzeKgcY8wuXVIfm08YNL4vNQ9hpnFXqwgdv/g5c6Sq
         IWeA==
X-Gm-Message-State: AOJu0YxycdG+pfj2hgCvAaHpgRr/oue4l1Kc+IK2NC0DUoguU4E40Wp4
	wjFprbyEQFldJZ9ZE8suzT9KTMP3oiQ=
X-Google-Smtp-Source: AGHT+IHhMMBL/GD4ZiyRMWMNy6ep/h5s41252p0aHC0sOT8H4Pr1HDRh60Lo5ULIpyxGXxO7IEL8Tw==
X-Received: by 2002:a05:622a:148f:b0:425:4043:8d5a with SMTP id t15-20020a05622a148f00b0042540438d5amr9281404qtx.117.1702576888583;
        Thu, 14 Dec 2023 10:01:28 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id o8-20020ac85548000000b004257bf9a394sm5949511qtr.14.2023.12.14.10.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:01:28 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] auto-t: add DPP tests to check extra settings are applied
Date: Thu, 14 Dec 2023 10:01:09 -0800
Message-Id: <20231214180110.130991-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214180110.130991-1-prestwoj@gmail.com>
References: <20231214180110.130991-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to test that extra settings are applied prior to connecting
two tests were added for hidden networks as well as one testing if
there is already an existing profile after DPP.

The reason hidden networks were used was due to the requirement of
the "Hidden" settings in the profile. If this setting doesn't get
sync'ed to disk the connection will fail.
---
 autotests/testDPP/hw.conf         |  5 ++-
 autotests/testDPP/pkex_test.py    | 72 ++++++++++++++++++++++++++++++-
 autotests/testDPP/ssidHidden.conf |  9 ++++
 autotests/testDPP/ssidHidden.psk  |  5 +++
 4 files changed, 87 insertions(+), 4 deletions(-)
 create mode 100644 autotests/testDPP/ssidHidden.conf
 create mode 100644 autotests/testDPP/ssidHidden.psk

diff --git a/autotests/testDPP/hw.conf b/autotests/testDPP/hw.conf
index a2b1470e..85f33777 100644
--- a/autotests/testDPP/hw.conf
+++ b/autotests/testDPP/hw.conf
@@ -1,5 +1,5 @@
 [SETUP]
-num_radios=4
+num_radios=5
 start_iwd=0
 hwsim_medium=yes
 
@@ -8,6 +8,7 @@ rad0=wpas.conf
 
 [HOSTAPD]
 rad1=hostapd.conf
+rad2=ssidHidden.conf
 
 [NameSpaces]
-ns0=rad2
+ns0=rad3
diff --git a/autotests/testDPP/pkex_test.py b/autotests/testDPP/pkex_test.py
index 9e0b5dd8..5df6c47d 100644
--- a/autotests/testDPP/pkex_test.py
+++ b/autotests/testDPP/pkex_test.py
@@ -26,11 +26,11 @@ class Test(unittest.TestCase):
         self.wpas.dpp_stop_listen()
         self.wpas.dpp_configurator_remove()
 
-    def start_iwd_pkex_configurator(self, device, agent=False):
+    def start_iwd_pkex_configurator(self, device, agent=False, profile='ssidCCMP.psk'):
         self.hapd.reload()
         self.hapd.wait_for_event('AP-ENABLED')
 
-        IWD.copy_to_storage('ssidCCMP.psk')
+        IWD.copy_to_storage(profile)
         device.autoconnect = True
 
         condition = 'obj.state == DeviceState.connected'
@@ -186,6 +186,71 @@ class Test(unittest.TestCase):
 
         self.agent = None
 
+    def test_existing_network(self):
+        self.hapd.reload()
+        self.hapd.wait_for_event('AP-ENABLED')
+        IWD.copy_to_storage("existingProfile.psk", "/tmp/ns0/", "ssidCCMP.psk")
+
+        # Scan first so a network object exists, and its a known network
+        self.device[1].scan()
+        self.wd.wait_for_object_condition(self.device[1], 'obj.scanning == True')
+        self.wd.wait_for_object_condition(self.device[1], 'obj.scanning == False')
+
+        self.start_iwd_pkex_configurator(self.device[0])
+
+        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
+        self.device[1].autoconnect = True
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device[1], condition)
+
+        # Check additional settings were carried over
+        with open('/tmp/ns0/ssidCCMP.psk', 'r') as f:
+            settings = f.read()
+
+        self.assertIn("SendHostname=true", settings)
+
+    def test_existing_hidden_network(self):
+        self.hapd_hidden.reload()
+        self.hapd_hidden.wait_for_event('AP-ENABLED')
+        IWD.copy_to_storage("existingProfile.psk", "/tmp/ns0/", "ssidHidden.psk")
+
+        # Scan first so a network object exists, and its a known network
+        self.device[1].scan()
+        self.wd.wait_for_object_condition(self.device[1], 'obj.scanning == True')
+        self.wd.wait_for_object_condition(self.device[1], 'obj.scanning == False')
+
+        self.start_iwd_pkex_configurator(self.device[0], profile='ssidHidden.psk')
+
+        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
+        self.device[1].autoconnect = True
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device[1], condition)
+
+        # Check additional settings were carried over
+        with open('/tmp/ns0/ssidHidden.psk', 'r') as f:
+            settings = f.read()
+
+        self.assertIn("Hidden=true", settings)
+
+    def test_hidden_network(self):
+        self.hapd_hidden.reload()
+        self.hapd_hidden.wait_for_event('AP-ENABLED')
+        self.start_iwd_pkex_configurator(self.device[0], profile='ssidHidden.psk')
+
+        self.device[1].dpp_pkex_enroll('secret123', identifier="test")
+        self.device[1].autoconnect = True
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device[1], condition)
+
+        # Check additional settings were carried over
+        with open('/tmp/ns0/ssidHidden.psk', 'r') as f:
+            settings = f.read()
+
+        self.assertIn("Hidden=true", settings)
+
     def setUp(self):
         ns0 = ctx.get_namespace('ns0')
         self.wpas = Wpas('wpas.conf')
@@ -197,6 +262,8 @@ class Test(unittest.TestCase):
         self.device.append(self.wd_ns0.list_devices(1)[0])
         self.hapd = HostapdCLI('hostapd.conf')
         self.hapd.disable()
+        self.hapd_hidden = HostapdCLI('ssidHidden.conf')
+        self.hapd_hidden.disable()
         self.hwsim = Hwsim()
 
         self.rule_xchg_resp = self.hwsim.rules.create()
@@ -240,6 +307,7 @@ class Test(unittest.TestCase):
         self.hapd = None
         self.rule_xchg_resp = None
         IWD.clear_storage()
+        IWD.clear_storage('/tmp/ns0')
 
     @classmethod
     def setUpClass(cls):
diff --git a/autotests/testDPP/ssidHidden.conf b/autotests/testDPP/ssidHidden.conf
new file mode 100644
index 00000000..1055fb9c
--- /dev/null
+++ b/autotests/testDPP/ssidHidden.conf
@@ -0,0 +1,9 @@
+hw_mode=g
+channel=6
+ssid=ssidHidden
+
+wpa=1
+wpa_pairwise=TKIP
+wpa_passphrase=secret123
+
+ignore_broadcast_ssid=1
diff --git a/autotests/testDPP/ssidHidden.psk b/autotests/testDPP/ssidHidden.psk
new file mode 100644
index 00000000..9917294e
--- /dev/null
+++ b/autotests/testDPP/ssidHidden.psk
@@ -0,0 +1,5 @@
+[Security]
+Passphrase=secret123
+
+[Settings]
+Hidden=true
-- 
2.34.1

