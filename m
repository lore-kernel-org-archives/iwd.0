Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017337D00
	for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3kdcKJM"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3b9d8bfe845so3845749b6e.0
        for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 10:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703009311; x=1703614111; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktMfj5r61bwoR24AusaRFVdEJJxbR0slS7FZOpl5xPo=;
        b=e3kdcKJMJABd0ILvT70yJ63bhFAovcZ/Y3oDacgVXBVW1ciytnUgA5Y9AodNvTASE7
         40jLIz+shxG4AQLmMtECnmkSQF8yga2bCejFY1Q0ajFK9DBIEKKeQVZDTNgXZIzLLSY9
         JnFwiw7XA0jkl1ioFqXvtLcJFisjx9j15uAwGfYz7bDEa7t016HRHq3jePnRbzug9MOF
         gQU/c4Ca9HZcBv/u6hQFiNVj0nXLDjZsO4EFdXyJx8uYeoOJEWDhiDspd7gBm9tutHRA
         m3qvhC7DNr0CAT64yLSphnAJIniLGzkpHriVXaCCkbEPCIcM+wC48iuivhYdCgwMRH9M
         0KZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009311; x=1703614111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktMfj5r61bwoR24AusaRFVdEJJxbR0slS7FZOpl5xPo=;
        b=h67uFYzAdTsxNbl/qkznseWL1tOTC8bxyuXJKQtv1+1DyBtsoEo+2qvSeWcNxCO4TI
         GaSfRGWqjSoG/yjg22DZK7MU9gdjKp/63eMCEXz0yVu3O69dUZmPgaEmRuOps6DCJLkU
         CLPKjQQR2R2bAd4agNgnoJHQT9jIqFBL+kpvZ0patJ63p0rLXzR4YQYVh+T2uR87y8SV
         j44LLEUF7p54bB6QsO9lNRyI0uSLue7gatPPSVu6fsw9N0MbZLxfwzmlYR25kN4K8Uxd
         Akbj3xFlSIw0L+7Q3LS9IkpGaJFw90umwHkEGEfADYfNpzGM1ecPayBsceEPOX/23Rof
         mTXA==
X-Gm-Message-State: AOJu0YyWKZ6hSK5HwM1UmFoHdvJ4F9R3A/eQ6h2rZbFM0ZJ8iGj64nQ5
	iRW11yLgNx8AshTjjk/3ao9lqlYB+Ak=
X-Google-Smtp-Source: AGHT+IGr/Z3w+SBoi1sBvaLajXjviBI8t3j7jDWTfW+sbLWAFQh1fh0BMGHhX0h78t4kfF9QF0q0bw==
X-Received: by 2002:a05:6808:189d:b0:3bb:6abf:a522 with SMTP id bi29-20020a056808189d00b003bb6abfa522mr390835oib.72.1703009311001;
        Tue, 19 Dec 2023 10:08:31 -0800 (PST)
Received: from LOCLAP699.barrett-olive-branch.locus ([50.222.209.222])
        by smtp.gmail.com with ESMTPSA id z25-20020a056808049900b003ba322fa9a8sm2095130oid.43.2023.12.19.10.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:08:30 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/4] auto-t: add DPP tests to check extra settings are applied
Date: Tue, 19 Dec 2023 10:08:25 -0800
Message-Id: <20231219180826.201540-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219180826.201540-1-prestwoj@gmail.com>
References: <20231219180826.201540-1-prestwoj@gmail.com>
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
 autotests/testDPP/existingProfile.psk |  2 +
 autotests/testDPP/hw.conf             |  5 +-
 autotests/testDPP/pkex_test.py        | 72 ++++++++++++++++++++++++++-
 autotests/testDPP/ssidHidden.conf     |  9 ++++
 autotests/testDPP/ssidHidden.psk      |  5 ++
 5 files changed, 89 insertions(+), 4 deletions(-)
 create mode 100644 autotests/testDPP/existingProfile.psk
 create mode 100644 autotests/testDPP/ssidHidden.conf
 create mode 100644 autotests/testDPP/ssidHidden.psk

diff --git a/autotests/testDPP/existingProfile.psk b/autotests/testDPP/existingProfile.psk
new file mode 100644
index 00000000..d0689078
--- /dev/null
+++ b/autotests/testDPP/existingProfile.psk
@@ -0,0 +1,2 @@
+[Security]
+Passphrase=IncorrectPassphrase
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
index 9e0b5dd8..db355225 100644
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
+        self.device[1].autoconnect = False
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
+        self.device[1].autoconnect = False
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
+        self.device[1].autoconnect = False
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

