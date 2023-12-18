Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A531D144
	for <iwd@lists.linux.dev>; Mon, 18 Dec 2023 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkJB0esE"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-425a76bb53fso32613441cf.1
        for <iwd@lists.linux.dev>; Mon, 18 Dec 2023 06:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702908775; x=1703513575; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik0TpLbzBGGyA9CN4Lx6Q7/i/gSeXuVLaDc4xi3xR0A=;
        b=mkJB0esEqw59Rphl6WHondqhG2z+KfqR3gaj2Gjxvq+DU9xfdTNLkBNmiyMhkC0rFr
         ofO5rXOhIUe2S43BpLvE0+FVNbokaWF7JwhZcP8RvJ1PC9ODT50y9Z5z1PZoChVfuona
         NGlJxVK8kadBGNr/cp177ct+gquk3zHx0xDxCVPgkzSieXRzWAz3rkVN5PwtvQDrQuR2
         yzOGg2+eK+EXVVMQ420pm/6EDDjomCJl4OrSJC41Rk7RLw9MrTVoo6geG6JXz4+PAIeG
         4EmDsv8l/SrcDhQPQT96zE1IcsNF2vrks4Z38P4Zp6xa6zFXJZB9yiZ6BTSpd9xWrvEC
         3WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908775; x=1703513575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ik0TpLbzBGGyA9CN4Lx6Q7/i/gSeXuVLaDc4xi3xR0A=;
        b=OSVF0DeDlRePWxg5u5aytGaA+ABDTl4i2oKW52j8W61yGszl5ubVrA1e1Ape5djKeg
         GiS/18IxMKz1GdVDJlc52hPpqJ/c4L4NrAnk5y5nMORqDsCG7YRUk9zyr6UbHHb4bF0H
         ACSikoVSPS04cX/Ucczi6jtYup13ieiGEJknJ7vs0/yUKNyDN5q5Lw2dBS3hscjLd0Yy
         mSIyAHW6OdURyGfzEvzYQPk0Sedo82w/3YEuNVG/uYyxGCcCmZLSecuHbu8aCUwZfTY9
         bJ9xVxEhn6K+eNsvW4gdY65T8agucYsVr/Ac6qcmTH1geewChkHzsct5vKgpsnObGWMp
         4y3g==
X-Gm-Message-State: AOJu0YwffisgkXyn7rY1XsggX00XnXpvvBUH7HN93mhkhQh173ujl2tK
	jopn6otagbn6Jb6nNYXOMBWKXNccyWE=
X-Google-Smtp-Source: AGHT+IFSMLGxbJYvm2NoIo7VFvRxwHD80P8zZyEA+aTrM6XBnUFt4HVLFWiB9cx5M9Om15zfnx3SgA==
X-Received: by 2002:a05:6214:411b:b0:67a:a721:721c with SMTP id kc27-20020a056214411b00b0067aa721721cmr25144821qvb.57.1702908775605;
        Mon, 18 Dec 2023 06:12:55 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id b2-20020a0cbf42000000b0067ec8702d1dsm7816355qvj.137.2023.12.18.06.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:12:55 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] auto-t: add DPP tests to check extra settings are applied
Date: Mon, 18 Dec 2023 06:12:49 -0800
Message-Id: <20231218141250.202157-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218141250.202157-1-prestwoj@gmail.com>
References: <20231218141250.202157-1-prestwoj@gmail.com>
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

