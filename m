Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB7F156CC
	for <iwd@lists.linux.dev>; Tue, 29 Aug 2023 14:40:04 +0000 (UTC)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d77b9d574f8so3944479276.2
        for <iwd@lists.linux.dev>; Tue, 29 Aug 2023 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693320003; x=1693924803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN5Z3UdNi+RuL7ziEMvT387DrQiZSASula+9/k9uG30=;
        b=SB5tzz1qA1krrAtz/e1wFR5Ep6jOuOvFIci7nXhW2hAYSJIChqpNKPMOOn6X7WSV4v
         5ZrARLW43w9C8M6B3e6u5nSATzITS5p1XtAamBA31wNmU54mnVQT0P45gGOSgDI/9rUi
         XptfJ8YzAhQdrskPcnnBPZvogaSRE4Rz26s3FXWmgb7V3srsEXD3Kg4f0b6yVeptqnWF
         gQ0JART4FSkVPVuFnKLZ0tQoyrP9pLXz6tcurU7+WA8bgL0GjepffSAzFjHp0GfJdYax
         kYUjgdhNeupPeII+csGtZaqKmvwj5qjpodJtKTowx0skqMMy2fOtkUgilKkN5cbTj0/S
         KGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693320003; x=1693924803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nN5Z3UdNi+RuL7ziEMvT387DrQiZSASula+9/k9uG30=;
        b=IAoT2/7KUmGjZiewXcs4SKVXS2QGFd6xoEY8RxxuIZ8fFJIn9VDQLmkGS5fF1L2vvD
         S3rjLY4QaHCNobmvn8+lgnFoBbTQmJKRE8r2zHZv7bDaiapRcIFTiLL81Pw/m6+VYMWl
         7xVG53kA2lBriS6h1b4+3wxSV4+s65ylmpPsQ6j6+WLMPYnQMbywMyYHOwEmwdbxfqQj
         6mXyvvihrrnnknWnoUXXeKBLWzo01Y4BwrC64ew81tkLpfEeyvMW8wkqvuHG4546Zd1P
         ETaEkSbnxqLWzzvdl1k+MtFyv5XpHJvJUzfb9oLiCoyjGgiNjaejhNQMKyY7433tOLnn
         2FOg==
X-Gm-Message-State: AOJu0Yz8DjRUonG2mglPEQdmgAJhomSAz+n45mlaMD+ZDDX3yqztsdxw
	vAtYjbEPzNVmr5+yGc8yLDgNFBCG/BI=
X-Google-Smtp-Source: AGHT+IGRCGJeGpVICQA5J4MGckBNvcSNMtH1sr+xeNdwFHQvV7HaEMT1HrkgFPdJB1wALA/3+emyTg==
X-Received: by 2002:a25:c547:0:b0:d77:f518:ff59 with SMTP id v68-20020a25c547000000b00d77f518ff59mr15400920ybe.11.1693320003506;
        Tue, 29 Aug 2023 07:40:03 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id v124-20020a252f82000000b00d7465a90f0csm2217817ybv.22.2023.08.29.07.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 07:40:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: Update tests to use hostapd.default()
Date: Tue, 29 Aug 2023 07:39:55 -0700
Message-Id: <20230829143955.267742-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829143955.267742-1-prestwoj@gmail.com>
References: <20230829143955.267742-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 .../testOWE-transition/connection_test.py     | 51 ++-----------------
 autotests/testOWE-transition/ssidOWE-2.conf   |  2 +
 autotests/testOWE-transition/ssidOWE.conf     |  1 +
 autotests/testOWE-transition/ssidOpen-2.conf  |  1 +
 autotests/testOWE-transition/ssidOpen.conf    |  1 +
 autotests/testPSK-roam/connection_test.py     | 33 ++----------
 autotests/testPSK-roam/failed_roam_test.py    | 13 ++---
 autotests/testPSK-roam/ft-psk-ccmp-1.conf     |  1 +
 autotests/testPSK-roam/ft-psk-ccmp-2.conf     |  1 +
 autotests/testPSK-roam/ft-psk-ccmp-3.conf     |  1 +
 .../testSAE-AntiClogging/clogging_test.py     |  7 ++-
 .../ssidSAE-Clogging.conf                     |  2 +
 autotests/testSAE/autoconnect_test.py         |  6 +--
 autotests/testSAE/connection_test.py          |  9 +---
 autotests/testSAE/failure_test.py             |  9 ++--
 autotests/testSAE/ssidSAE.conf                |  1 +
 autotests/testSAE/timeout_test.py             | 16 +++---
 autotests/testWPA2/connection_test.py         |  4 +-
 autotests/testWPA2/ssidWPA2.conf              |  1 +
 autotests/testWPA2withMFP/connection_test.py  |  4 +-
 autotests/testWPA2withMFP/ssidWPA2.conf       |  1 +
 21 files changed, 46 insertions(+), 119 deletions(-)

diff --git a/autotests/testOWE-transition/connection_test.py b/autotests/testOWE-transition/connection_test.py
index 89f97338..427e90a6 100644
--- a/autotests/testOWE-transition/connection_test.py
+++ b/autotests/testOWE-transition/connection_test.py
@@ -47,11 +47,6 @@ class Test(unittest.TestCase):
 
     # Normal success case
     def test_owe_transition(self):
-        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f1000a6f77652d68696464656e')
-        self.hapd_open.reload()
-        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0000a7472616e736974696f6e')
-        self.hapd_owe.reload()
-
         self.hapd_owe2.disable()
         self.hapd_open2.disable()
 
@@ -59,15 +54,8 @@ class Test(unittest.TestCase):
 
     # Normal success case
     def test_owe_transition_multi_network(self):
-        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f1000a6f77652d68696464656e')
-        self.hapd_open.reload()
-        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0000a7472616e736974696f6e')
-        self.hapd_owe.reload()
-
-        self.hapd_open2.set_value('vendor_elements', 'dd17506f9a1c02000000f1000c6f77652d68696464656e2d32')
         self.hapd_open2.set_value('ssid', 'transition-2')
         self.hapd_open2.reload()
-        self.hapd_owe2.set_value('vendor_elements', 'dd17506f9a1c02000000f0000c7472616e736974696f6e2d32')
         self.hapd_owe2.set_value('ssid', 'owe-hidden-2')
         self.hapd_owe2.reload()
 
@@ -75,11 +63,6 @@ class Test(unittest.TestCase):
 
     # Two pairs of open/OWE BSS's (OWE BSS's have different SSIDs) */
     def test_owe_transition_multi_bss(self):
-        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f1000a6f77652d68696464656e')
-        self.hapd_open.reload()
-        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0000a7472616e736974696f6e')
-        self.hapd_owe.reload()
-
         self.hapd_open2.set_value('vendor_elements', 'dd17506f9a1c02000000f3000c6f77652d68696464656e2d32')
         self.hapd_open2.set_value('ssid', 'transition')
         self.hapd_open2.reload()
@@ -91,11 +74,6 @@ class Test(unittest.TestCase):
 
     # Two pairs of open/OWE BSS's (OWE BSS's have same SSID) */
     def test_owe_transition_multi_bss_same_ssid(self):
-        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f1000a6f77652d68696464656e')
-        self.hapd_open.reload()
-        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0000a7472616e736974696f6e')
-        self.hapd_owe.reload()
-
         self.hapd_open2.set_value('vendor_elements', 'dd15506f9a1c02000000f3000a6f77652d68696464656e')
         self.hapd_open2.set_value('ssid', 'transition')
         self.hapd_open2.reload()
@@ -107,11 +85,6 @@ class Test(unittest.TestCase):
 
     # Normal success autoconnect case
     def test_owe_transition_autoconnect(self):
-        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f1000a6f77652d68696464656e')
-        self.hapd_open.reload()
-        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0000a7472616e736974696f6e')
-        self.hapd_owe.reload()
-
         self.hapd_owe2.disable()
         self.hapd_open2.disable()
 
@@ -124,8 +97,6 @@ class Test(unittest.TestCase):
     def test_owe_transition_invalid_open_bssid(self):
         self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000ff000a6f77652d68696464656e')
         self.hapd_open.reload()
-        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0000a7472616e736974696f6e')
-        self.hapd_owe.reload()
 
         self.hapd_owe2.disable()
         self.hapd_open2.disable()
@@ -135,8 +106,6 @@ class Test(unittest.TestCase):
     # OWE BSS has invalid BSSID in OWE transition element
     # Expected connection to Open BSS
     def test_owe_transition_invalid_owe_bssid(self):
-        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f1000a6f77652d68696464656e')
-        self.hapd_open.reload()
         self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000ff000a7472616e736974696f6e')
         self.hapd_owe.reload()
 
@@ -148,8 +117,6 @@ class Test(unittest.TestCase):
     # No OWE hidden network exists
     # Expected connection to Open BSS
     def test_owe_transition_no_hidden_found(self):
-        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f1000a6f77652d68696464656e')
-        self.hapd_open.reload()
         self.hapd_owe.disable()
 
         self.hapd_owe2.disable()
@@ -160,11 +127,6 @@ class Test(unittest.TestCase):
     # Directly connect to valid OWE hidden network
     # Expected connection failure
     def test_owe_transition_connect_hidden_valid(self):
-        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f1000a6f77652d68696464656e')
-        self.hapd_open.reload()
-        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0000a7472616e736974696f6e')
-        self.hapd_owe.reload()
-
         self.hapd_owe2.disable()
         self.hapd_open2.disable()
 
@@ -189,7 +151,6 @@ class Test(unittest.TestCase):
     def test_owe_transition_band_info(self):
         self.hapd_open.set_value('vendor_elements', 'dd17506f9a1c02000000f1000a6f77652d68696464656e5103')
         self.hapd_open.reload()
-        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0000a7472616e736974696f6e')
         self.hapd_owe.set_value('channel', '3')
         self.hapd_owe.reload()
 
@@ -201,7 +162,6 @@ class Test(unittest.TestCase):
     def test_owe_transition_wrong_band_info(self):
         self.hapd_open.set_value('vendor_elements', 'dd17506f9a1c02000000f1000a6f77652d68696464656e5102')
         self.hapd_open.reload()
-        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0000a7472616e736974696f6e')
         self.hapd_owe.set_value('channel', '3')
         self.hapd_owe.reload()
 
@@ -212,11 +172,6 @@ class Test(unittest.TestCase):
 
     # OWE Transition pair + additional open network with the same SSID
     def test_owe_transition_extra_open(self):
-        self.hapd_open.set_value('vendor_elements', 'dd15506f9a1c02000000f1000a6f77652d68696464656e')
-        self.hapd_open.reload()
-        self.hapd_owe.set_value('vendor_elements', 'dd15506f9a1c02000000f0000a7472616e736974696f6e')
-        self.hapd_owe.reload()
-
         self.hapd_open2.set_value('ssid', 'transition')
         self.hapd_open2.reload()
 
@@ -235,17 +190,19 @@ class Test(unittest.TestCase):
     def setUp(self):
         self.wd = IWD(True)
         self.hapd_owe = HostapdCLI(config='ssidOWE.conf')
+        self.hapd_owe.default()
         self.hapd_open = HostapdCLI(config='ssidOpen.conf')
+        self.hapd_open.default()
         self.hapd_owe2 = HostapdCLI(config='ssidOWE-2.conf')
+        self.hapd_owe2.default()
         self.hapd_open2 = HostapdCLI(config='ssidOpen-2.conf')
+        self.hapd_open2.default()
 
         self.hwsim = Hwsim()
 
     def tearDown(self):
         IWD.clear_storage()
 
-        self.hapd_owe.set_value('channel', '1')
-
         self.wd = None
         self.hapd_open = None
         self.hapd_owe = None
diff --git a/autotests/testOWE-transition/ssidOWE-2.conf b/autotests/testOWE-transition/ssidOWE-2.conf
index a8a9023c..85c51470 100644
--- a/autotests/testOWE-transition/ssidOWE-2.conf
+++ b/autotests/testOWE-transition/ssidOWE-2.conf
@@ -7,3 +7,5 @@ ieee80211w=1
 wpa=2
 wpa_key_mgmt=OWE
 rsn_pairwise=CCMP
+
+vendor_elements=dd17506f9a1c02000000f0000c7472616e736974696f6e2d32
diff --git a/autotests/testOWE-transition/ssidOWE.conf b/autotests/testOWE-transition/ssidOWE.conf
index c54309ae..72809fa6 100644
--- a/autotests/testOWE-transition/ssidOWE.conf
+++ b/autotests/testOWE-transition/ssidOWE.conf
@@ -7,6 +7,7 @@ ieee80211w=1
 wpa=2
 wpa_key_mgmt=OWE
 rsn_pairwise=CCMP
+vendor_elements=dd15506f9a1c02000000f0000a7472616e736974696f6e
 
 # You would conventionally use these options but hostapd does not include an
 # IE for the OWE network, hence vendor_elements must be used directly
diff --git a/autotests/testOWE-transition/ssidOpen-2.conf b/autotests/testOWE-transition/ssidOpen-2.conf
index 0a9f7628..5721d155 100644
--- a/autotests/testOWE-transition/ssidOpen-2.conf
+++ b/autotests/testOWE-transition/ssidOpen-2.conf
@@ -1,3 +1,4 @@
 channel=1
 ssid=transition-2
 bssid=02:00:00:00:f2:00
+vendor_elements=dd17506f9a1c02000000f1000c6f77652d68696464656e2d32
diff --git a/autotests/testOWE-transition/ssidOpen.conf b/autotests/testOWE-transition/ssidOpen.conf
index 4fc68430..096b52c4 100644
--- a/autotests/testOWE-transition/ssidOpen.conf
+++ b/autotests/testOWE-transition/ssidOpen.conf
@@ -1,6 +1,7 @@
 channel=1
 ssid=transition
 bssid=02:00:00:00:f0:00
+vendor_elements=dd15506f9a1c02000000f1000a6f77652d68696464656e
 
 # You would conventionally use these options but hostapd does not include an
 # IE for the OWE network, hence vendor_elements must be used directly
diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-roam/connection_test.py
index 459c25cf..8db4e4cb 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -93,32 +93,16 @@ class Test(unittest.TestCase):
     def test_ft_psk(self):
         wd = IWD(True)
 
-        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-PSK')
-        self.bss_hostapd[0].set_value('ft_over_ds', '0')
-        self.bss_hostapd[0].set_value('ocv', '1')
-        self.bss_hostapd[0].reload()
-        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
-
-        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-PSK')
-        self.bss_hostapd[1].set_value('ft_over_ds', '0')
-        self.bss_hostapd[0].set_value('ocv', '1')
-        self.bss_hostapd[1].reload()
-        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
-
         self.validate_connection(wd)
 
     def test_ft_psk_over_ds(self):
         wd = IWD(True)
 
-        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-PSK')
         self.bss_hostapd[0].set_value('ft_over_ds', '1')
-        self.bss_hostapd[0].set_value('ocv', '1')
         self.bss_hostapd[0].reload()
         self.bss_hostapd[0].wait_for_event("AP-ENABLED")
 
-        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-PSK')
         self.bss_hostapd[1].set_value('ft_over_ds', '1')
-        self.bss_hostapd[1].set_value('ocv', '1')
         self.bss_hostapd[1].reload()
         self.bss_hostapd[1].wait_for_event("AP-ENABLED")
 
@@ -128,12 +112,10 @@ class Test(unittest.TestCase):
         wd = IWD(True)
 
         self.bss_hostapd[0].set_value('wpa_key_mgmt', 'WPA-PSK')
-        self.bss_hostapd[0].set_value('ft_over_ds', '0')
         self.bss_hostapd[0].reload()
         self.bss_hostapd[0].wait_for_event("AP-ENABLED")
 
         self.bss_hostapd[1].set_value('wpa_key_mgmt', 'WPA-PSK')
-        self.bss_hostapd[1].set_value('ft_over_ds', '0')
         self.bss_hostapd[1].reload()
         self.bss_hostapd[1].wait_for_event("AP-ENABLED")
 
@@ -142,18 +124,6 @@ class Test(unittest.TestCase):
     def test_roam_packet_loss(self):
         wd = IWD(True)
 
-        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-PSK')
-        self.bss_hostapd[0].set_value('ft_over_ds', '0')
-        self.bss_hostapd[0].set_value('ocv', '1')
-        self.bss_hostapd[0].reload()
-        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
-
-        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-PSK')
-        self.bss_hostapd[1].set_value('ft_over_ds', '0')
-        self.bss_hostapd[0].set_value('ocv', '1')
-        self.bss_hostapd[1].reload()
-        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
-
         self.validate_connection(wd, pkt_loss=True)
 
     def tearDown(self):
@@ -166,6 +136,9 @@ class Test(unittest.TestCase):
         self.rule1.enabled = False
         self.rule2.enabled = False
 
+        for hapd in self.bss_hostapd:
+            hapd.default()
+
     @classmethod
     def setUpClass(cls):
         hwsim = Hwsim()
diff --git a/autotests/testPSK-roam/failed_roam_test.py b/autotests/testPSK-roam/failed_roam_test.py
index eda2b4e2..8a3db662 100644
--- a/autotests/testPSK-roam/failed_roam_test.py
+++ b/autotests/testPSK-roam/failed_roam_test.py
@@ -44,16 +44,6 @@ class Test(unittest.TestCase):
 
     # FT-over-Air failure, should stay connected
     def test_ft_over_air_failure(self):
-        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-PSK')
-        self.bss_hostapd[0].set_value('ft_over_ds', '0')
-        self.bss_hostapd[0].reload()
-        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
-
-        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-PSK')
-        self.bss_hostapd[1].set_value('ft_over_ds', '0')
-        self.bss_hostapd[1].reload()
-        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
-
         wd = IWD(True)
 
         device = wd.list_devices(1)[0]
@@ -86,6 +76,9 @@ class Test(unittest.TestCase):
         self.rule1.enabled = False
         self.rule2.enabled = False
 
+        for hapd in self.bss_hostapd:
+            hapd.default()
+
     @classmethod
     def setUpClass(cls):
         hwsim = Hwsim()
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-1.conf b/autotests/testPSK-roam/ft-psk-ccmp-1.conf
index 4a2ceba5..eec8805f 100644
--- a/autotests/testPSK-roam/ft-psk-ccmp-1.conf
+++ b/autotests/testPSK-roam/ft-psk-ccmp-1.conf
@@ -37,3 +37,4 @@ ft_over_ds=0
 ap_table_expiration_time=36000
 ap_table_max_size=10
 rrm_neighbor_report=1
+ocv=1
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-2.conf b/autotests/testPSK-roam/ft-psk-ccmp-2.conf
index a42e175d..5992461f 100644
--- a/autotests/testPSK-roam/ft-psk-ccmp-2.conf
+++ b/autotests/testPSK-roam/ft-psk-ccmp-2.conf
@@ -37,3 +37,4 @@ ft_over_ds=0
 ap_table_expiration_time=36000
 ap_table_max_size=10
 rrm_neighbor_report=1
+ocv=1
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-3.conf b/autotests/testPSK-roam/ft-psk-ccmp-3.conf
index a42e175d..5992461f 100644
--- a/autotests/testPSK-roam/ft-psk-ccmp-3.conf
+++ b/autotests/testPSK-roam/ft-psk-ccmp-3.conf
@@ -37,3 +37,4 @@ ft_over_ds=0
 ap_table_expiration_time=36000
 ap_table_max_size=10
 rrm_neighbor_report=1
+ocv=1
diff --git a/autotests/testSAE-AntiClogging/clogging_test.py b/autotests/testSAE-AntiClogging/clogging_test.py
index 172dfecf..be98ef18 100644
--- a/autotests/testSAE-AntiClogging/clogging_test.py
+++ b/autotests/testSAE-AntiClogging/clogging_test.py
@@ -55,14 +55,13 @@ class Test(unittest.TestCase):
         wd.clear_storage()
 
     def test_SAE(self):
-        self.hostapd.set_value('sae_pwe', '0');
-        self.hostapd.set_value('sae_groups', '19');
-        self.hostapd.reload()
-        self.hostapd.wait_for_event("AP-ENABLED")
         wd = IWD(True)
         self.validate_connection(wd)
         wd.clear_storage()
 
+    def setUp(self):
+        self.hostapd.default()
+
     @classmethod
     def setUpClass(cls):
         cls.hostapd = HostapdCLI(config='ssidSAE-Clogging.conf')
diff --git a/autotests/testSAE-AntiClogging/ssidSAE-Clogging.conf b/autotests/testSAE-AntiClogging/ssidSAE-Clogging.conf
index 1a96d152..b058f25b 100644
--- a/autotests/testSAE-AntiClogging/ssidSAE-Clogging.conf
+++ b/autotests/testSAE-AntiClogging/ssidSAE-Clogging.conf
@@ -8,3 +8,5 @@ wpa_pairwise=CCMP
 sae_password=secret123|mac=ff:ff:ff:ff:ff:ff
 sae_anti_clogging_threshold=2
 ieee80211w=2
+sae_pwe=0
+sae_groups=19
\ No newline at end of file
diff --git a/autotests/testSAE/autoconnect_test.py b/autotests/testSAE/autoconnect_test.py
index 64a60e7c..cba59274 100644
--- a/autotests/testSAE/autoconnect_test.py
+++ b/autotests/testSAE/autoconnect_test.py
@@ -35,9 +35,6 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(ordered_network.network_object, condition)
 
     def test_SAE(self):
-        self.hostapd.set_value('sae_pwe', '0')
-        self.hostapd.set_value('sae_groups', '19')
-        self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
 
         wd = IWD(True)
@@ -51,6 +48,9 @@ class Test(unittest.TestCase):
         wd = IWD(True)
         self.validate_connection(wd)
 
+    def setUp(self):
+        self.hostapd.default()
+
     @classmethod
     def setUpClass(cls):
         cls.hostapd = HostapdCLI(config='ssidSAE.conf')
diff --git a/autotests/testSAE/connection_test.py b/autotests/testSAE/connection_test.py
index c67f8c83..ecb464e2 100644
--- a/autotests/testSAE/connection_test.py
+++ b/autotests/testSAE/connection_test.py
@@ -45,16 +45,10 @@ class Test(unittest.TestCase):
         wd.unregister_psk_agent(psk_agent)
 
     def test_SAE(self):
-        self.hostapd.set_value('sae_pwe', '0')
-        self.hostapd.set_value('sae_groups', '19')
-        self.hostapd.set_value('vendor_elements', '')
-        self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
         self.validate_connection(self.wd)
 
     def test_SAE_force_group_19(self):
-        self.hostapd.set_value('sae_pwe', '0')
-        self.hostapd.set_value('sae_groups', '19')
         # Vendor data from APs which require group 19 be used first
         # TODO: (for all tests) verify the expected group was used
         self.hostapd.set_value('vendor_elements', 'dd0cf4f5e8050500000000000000')
@@ -63,7 +57,6 @@ class Test(unittest.TestCase):
         self.validate_connection(self.wd)
 
     def test_SAE_Group20(self):
-        self.hostapd.set_value('sae_pwe', '0')
         self.hostapd.set_value('sae_groups', '20')
         self.hostapd.set_value('vendor_elements', '')
         self.hostapd.reload()
@@ -72,7 +65,6 @@ class Test(unittest.TestCase):
 
     def test_SAE_H2E(self):
         self.hostapd.set_value('sae_pwe', '1')
-        self.hostapd.set_value('sae_groups', '19')
         self.hostapd.set_value('vendor_elements', '')
         self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
@@ -87,6 +79,7 @@ class Test(unittest.TestCase):
         self.validate_connection(self.wd)
 
     def setUp(self):
+        self.hostapd.default()
         self.wd = IWD(True)
 
     def tearDown(self):
diff --git a/autotests/testSAE/failure_test.py b/autotests/testSAE/failure_test.py
index e61bf585..2aac3a07 100644
--- a/autotests/testSAE/failure_test.py
+++ b/autotests/testSAE/failure_test.py
@@ -37,13 +37,16 @@ class Test(unittest.TestCase):
         self.validate_connection(wd, 'InvalidSecret')
 
     def test_no_supported_groups(self):
-        hostapd = HostapdCLI(config='ssidSAE.conf')
-        hostapd.set_value('sae_groups', '1')
-        hostapd.reload()
+        self.hostapd.set_value('sae_groups', '1')
+        self.hostapd.reload()
 
         wd = IWD(True)
         self.validate_connection(wd, 'secret123')
 
+    def setUp(self):
+        self.hostapd = HostapdCLI(config='ssidSAE.conf')
+        self.hostapd.default()
+
     @classmethod
     def setUpClass(cls):
         pass
diff --git a/autotests/testSAE/ssidSAE.conf b/autotests/testSAE/ssidSAE.conf
index 0c6be3e3..41f46cad 100644
--- a/autotests/testSAE/ssidSAE.conf
+++ b/autotests/testSAE/ssidSAE.conf
@@ -8,3 +8,4 @@ wpa_pairwise=CCMP
 sae_password=secret123|mac=ff:ff:ff:ff:ff:ff
 sae_groups=19
 ieee80211w=2
+sae_pwe=0
diff --git a/autotests/testSAE/timeout_test.py b/autotests/testSAE/timeout_test.py
index 1413bb4a..369d5b4b 100644
--- a/autotests/testSAE/timeout_test.py
+++ b/autotests/testSAE/timeout_test.py
@@ -40,10 +40,8 @@ class Test(unittest.TestCase):
         # needed because the hwsim rule only matches once and must be matched
         # on the first commit, not during group negotiation.
         #
-        hostapd = HostapdCLI(config='ssidSAE.conf')
-        hostapd.set_value('vendor_elements', 'dd0cf4f5e8050500000000000000')
-        hostapd.set_value('sae_groups', '19')
-        hostapd.reload()
+        self.hostapd.set_value('vendor_elements', 'dd0cf4f5e8050500000000000000')
+        self.hostapd.reload()
 
         hwsim = Hwsim()
         bss_radio = hwsim.get_radio('rad0')
@@ -64,10 +62,8 @@ class Test(unittest.TestCase):
         rule0.remove()
 
     def test_sta_confirm_not_acked(self):
-        hostapd = HostapdCLI(config='ssidSAE.conf')
-        hostapd.set_value('vendor_elements', 'dd0cf4f5e8050500000000000000')
-        hostapd.set_value('sae_groups', '19')
-        hostapd.reload()
+        self.hostapd.set_value('vendor_elements', 'dd0cf4f5e8050500000000000000')
+        self.hostapd.reload()
 
         hwsim = Hwsim()
         bss_radio = hwsim.get_radio('rad0')
@@ -87,6 +83,10 @@ class Test(unittest.TestCase):
 
         rule0.remove()
 
+    def setUp(self):
+        self.hostapd = HostapdCLI(config='ssidSAE.conf')
+        self.hostapd.default()
+
     @classmethod
     def setUpClass(cls):
         pass
diff --git a/autotests/testWPA2/connection_test.py b/autotests/testWPA2/connection_test.py
index a5a655f5..900f0b46 100644
--- a/autotests/testWPA2/connection_test.py
+++ b/autotests/testWPA2/connection_test.py
@@ -43,9 +43,6 @@ class Test(unittest.TestCase):
         wd.unregister_psk_agent(psk_agent)
 
     def test_ccmp(self):
-        self.hostapd.set_value('rsn_pairwise', 'CCMP')
-        self.hostapd.reload()
-        self.hostapd.wait_for_event("AP-ENABLED")
         self.validate_connection_success(self.wd)
 
     def test_gcmp(self):
@@ -67,6 +64,7 @@ class Test(unittest.TestCase):
         self.validate_connection_success(self.wd)
 
     def setUp(self):
+        self.hostapd.default()
         self.wd = IWD(True)
 
     def tearDown(self):
diff --git a/autotests/testWPA2/ssidWPA2.conf b/autotests/testWPA2/ssidWPA2.conf
index 64fd7796..b1400df3 100644
--- a/autotests/testWPA2/ssidWPA2.conf
+++ b/autotests/testWPA2/ssidWPA2.conf
@@ -5,3 +5,4 @@ ssid=ssidWPA2
 wpa=2
 wpa_pairwise=CCMP
 wpa_passphrase=secret123
+rsn_pairwise=CCMP
diff --git a/autotests/testWPA2withMFP/connection_test.py b/autotests/testWPA2withMFP/connection_test.py
index bdc9e96a..5de6e6ee 100644
--- a/autotests/testWPA2withMFP/connection_test.py
+++ b/autotests/testWPA2withMFP/connection_test.py
@@ -39,9 +39,6 @@ class Test(unittest.TestCase):
         wd.unregister_psk_agent(psk_agent)
 
     def test_cmac(self):
-        self.hostapd.set_value('group_mgmt_cipher', 'AES-128-CMAC')
-        self.hostapd.reload()
-        self.hostapd.wait_for_event("AP-ENABLED")
         self.validate_connection_success(self.wd)
 
     def test_gmac(self):
@@ -63,6 +60,7 @@ class Test(unittest.TestCase):
         self.validate_connection_success(self.wd)
 
     def setUp(self):
+        self.hostapd.default()
         self.wd = IWD(True)
 
     def tearDown(self):
diff --git a/autotests/testWPA2withMFP/ssidWPA2.conf b/autotests/testWPA2withMFP/ssidWPA2.conf
index 908915d7..6881e5aa 100644
--- a/autotests/testWPA2withMFP/ssidWPA2.conf
+++ b/autotests/testWPA2withMFP/ssidWPA2.conf
@@ -8,3 +8,4 @@ wpa_passphrase=secret123
 
 ieee80211w=2
 wpa_key_mgmt=WPA-PSK-SHA256
+group_mgmt_cipher=AES-128-CMAC
-- 
2.25.1

