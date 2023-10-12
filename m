Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD58E3CCFA
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrCK5tzt"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1c888b3a25aso11423395ad.0
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140934; x=1697745734; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI6vQkbm1YleX32UbYwJAFA+9rTPUOIkcO9JSVeDk70=;
        b=mrCK5tztqlkFhWXYdx4lBM3l4/YD/69CTB+BN1HbnAs4TWtvuUl0u7J10/YRJYPeB3
         +Ho/PBIOYWOK1VwtVUFxdUjzzk4ko6XlFJUj6aUj6qeB1AUE6RRli1deCdCPi+n9n5X2
         Fbo17rkjF2+IMTMIGet7RbGJdReifqLtTFmXGB2huDfqcyK441KRjJGyCsu1GoWGlzGi
         s3c82bCzUa3tKF4g8gmLaXuqI1G/72An71q5mND03c4hFmmz/lqukEt5oV01KfYeP/bV
         xLru3jhXd6kL56QV0vGxGicPTBfe9TxJOoBtwN5gjGj9S5LXOn2/PUoLXdKgm5TjwhTd
         gGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140934; x=1697745734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FI6vQkbm1YleX32UbYwJAFA+9rTPUOIkcO9JSVeDk70=;
        b=uzS8RBGkSvZTYY4iQr29IGv/kl0vEdWNIXClfT8MFmcbZCDcniC/Aq2e9kX3N4hcDa
         4ogR48biQWDywGFKSgq3k1NzLsBxQCf5LnP2emk7+9N2JLUJcXuqvb81fq3+pPoJdjsk
         mHyt9y/JUW44hOlgJuXlzUM81FAxVapuManle305ciUO8w1BQiZH0hfvmNJoVPcygmT5
         bs2zvwoYHB/ThblYs62iWJ4+uO87g7uxFDWctwHBpGNuwKiLBbRFfmG2ngCKjMCn3n0v
         kiFKi/hI41QfIe1Om0VdaNQk9NvYHKWmWaasAx/h0PoNarBYqbuZY4nmPKgsbxjLJoGe
         dIwg==
X-Gm-Message-State: AOJu0YxYAGGj5Vp0EFFwjiTEVb2bC+2arsx4kMvbMRWz6ZuZrGs6fzFz
	qeBeYx99pZYtAVQGBRo4b8wl8ctt1Q0=
X-Google-Smtp-Source: AGHT+IFOFEb5R0oz/IlviQQhHxBbPAhs2cd1wM4gkF5GJTtgWyNC4H2E8QsvqZMXIvx+mmbzFS0PWQ==
X-Received: by 2002:a17:902:8544:b0:1b9:e972:134d with SMTP id d4-20020a170902854400b001b9e972134dmr18552602plo.3.1697140933706;
        Thu, 12 Oct 2023 13:02:13 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:13 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 21/21] auto-t: add DPP PKEX tests
Date: Thu, 12 Oct 2023 13:01:50 -0700
Message-Id: <20231012200150.338401-22-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012200150.338401-1-prestwoj@gmail.com>
References: <20231012200150.338401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testDPP/hostapd.conf |   2 +-
 autotests/testDPP/pkex_test.py | 150 +++++++++++++++++++++++++++++++++
 autotests/testDPP/ssidCCMP.psk |   2 +
 3 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 autotests/testDPP/pkex_test.py

diff --git a/autotests/testDPP/hostapd.conf b/autotests/testDPP/hostapd.conf
index 074e8228..3611933c 100644
--- a/autotests/testDPP/hostapd.conf
+++ b/autotests/testDPP/hostapd.conf
@@ -1,5 +1,5 @@
 hw_mode=g
-channel=1
+channel=6
 ssid=ssidCCMP
 
 wpa=2
diff --git a/autotests/testDPP/pkex_test.py b/autotests/testDPP/pkex_test.py
new file mode 100644
index 00000000..e7f7ddb4
--- /dev/null
+++ b/autotests/testDPP/pkex_test.py
@@ -0,0 +1,150 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+from iwd import IWD
+from iwd import DeviceProvisioning
+from wpas import Wpas
+from hostapd import HostapdCLI
+from hwsim import Hwsim
+from config import ctx
+
+class Test(unittest.TestCase):
+    def start_wpas_pkex(self, code, curve=None, **kwargs):
+        self.wpas.dpp_bootstrap_gen(type='pkex', curve=curve)
+        self.wpas.dpp_pkex_add(code=code, **kwargs)
+        if kwargs.get('role', 'configurator') == 'configurator':
+            self.wpas.dpp_configurator_create()
+            self.wpas.dpp_listen(2437)
+
+    def test_pkex_iwd_as_enrollee(self):
+        self.start_wpas_pkex('secret123', identifier="test")
+
+        self.device.dpp_pkex_enroll(key='secret123', identifier="test")
+
+        self.wpas.wait_for_event("DPP-AUTH-SUCCESS")
+
+    def test_pkex_iwd_as_enrollee_retransmit(self):
+        self.rule_reveal_req.enabled = True
+
+        self.start_wpas_pkex('secret123', identifier="test")
+
+        self.device.dpp_pkex_enroll(key='secret123', identifier="test")
+
+        self.wpas.wait_for_event("DPP-AUTH-SUCCESS")
+
+    def test_pkex_unsupported_version(self):
+        self.start_wpas_pkex('secret123', identifier="test", version=2)
+
+        self.device.dpp_pkex_enroll(key='secret123', identifier="test")
+
+        with self.assertRaises(TimeoutError):
+            self.wpas.wait_for_event("DPP-AUTH-SUCCESS")
+
+    def test_pkex_iwd_as_configurator(self):
+        self.hapd.reload()
+        self.hapd.wait_for_event('AP-ENABLED')
+
+        IWD.copy_to_storage('ssidCCMP.psk')
+        self.device.autoconnect = True
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device, condition)
+
+        self.start_wpas_pkex('secret123', identifier="test", initiator=True, role='enrollee')
+
+        self.device.dpp_pkex_configure()
+
+        self.wpas.wait_for_event("DPP-AUTH-SUCCESS")
+        self.wpas.wait_for_event("DPP-CONF-RECEIVED")
+
+    def test_pkex_iwd_as_configurator_retransmit(self):
+        self.rule_xchg_resp.enabled = True
+        self.rule_reveal_resp.enabled = True
+        self.hapd.reload()
+        self.hapd.wait_for_event('AP-ENABLED')
+
+        IWD.copy_to_storage('ssidCCMP.psk')
+        self.device.autoconnect = True
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device, condition)
+
+        self.start_wpas_pkex('secret123', identifier="test", initiator=True, role='enrollee')
+
+        self.device.dpp_pkex_configure()
+
+        self.wpas.wait_for_event("DPP-AUTH-SUCCESS")
+        self.wpas.wait_for_event("DPP-CONF-RECEIVED")
+
+    def test_pkex_iwd_as_configurator_bad_group(self):
+        self.hapd.reload()
+        self.hapd.wait_for_event('AP-ENABLED')
+
+        IWD.copy_to_storage('ssidCCMP.psk')
+        self.device.autoconnect = True
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device, condition)
+
+        self.start_wpas_pkex('secret123', identifier="test", initiator=True, role='enrollee', curve='P-384')
+
+        self.device.dpp_pkex_configure()
+
+        self.wpas.wait_for_event(f"DPP-RX src={self.device.address} freq=2437 type=8")
+        self.wpas.wait_for_event("DPP-FAIL")
+
+    def setUp(self):
+        self.wpas = Wpas('wpas.conf')
+        self.wd = IWD(True)
+        self.device = self.wd.list_devices(1)[0]
+        self.hapd = HostapdCLI('hostapd.conf')
+        self.hapd.disable()
+        self.hwsim = Hwsim()
+
+        self.rule_xchg_resp = self.hwsim.rules.create()
+        self.rule_xchg_resp.prefix = 'd0'
+        self.rule_xchg_resp.match_offset = 24
+        self.rule_xchg_resp.match = '04 09 50 6f 9a 1a 01 08'
+        self.rule_xchg_resp.match_times = 1
+        self.rule_xchg_resp.drop = True
+
+        self.rule_reveal_resp = self.hwsim.rules.create()
+        self.rule_reveal_resp.prefix = 'd0'
+        self.rule_reveal_resp.match_offset = 24
+        self.rule_reveal_resp.match = '04 09 50 6f 9a 1a 01 0a'
+        self.rule_reveal_resp.match_times = 1
+        self.rule_reveal_resp.drop = True
+
+        self.rule_reveal_req = self.hwsim.rules.create()
+        self.rule_reveal_req.prefix = 'd0'
+        self.rule_reveal_req.match_offset = 24
+        self.rule_reveal_req.match = '04 09 50 6f 9a 1a 01 09'
+        self.rule_reveal_req.match_times = 1
+        self.rule_reveal_req.drop = True
+
+    def tearDown(self):
+        self.device.disconnect()
+        self.device.dpp_stop()
+        self.wpas.dpp_configurator_remove()
+        self.wpas.clean_up()
+
+        self.wd = None
+        self.device = None
+        self.wpas = None
+        self.hapd = None
+        self.rule_xchg_resp = None
+        IWD.clear_storage()
+
+    @classmethod
+    def setUpClass(cls):
+        pass
+
+    @classmethod
+    def tearDownClass(cls):
+        pass
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
\ No newline at end of file
diff --git a/autotests/testDPP/ssidCCMP.psk b/autotests/testDPP/ssidCCMP.psk
index abafdb66..156cbec6 100644
--- a/autotests/testDPP/ssidCCMP.psk
+++ b/autotests/testDPP/ssidCCMP.psk
@@ -1,2 +1,4 @@
 [Security]
 Passphrase=secret123
+DeviceProvisioningSharedCode=secret123
+DeviceProvisioningIdentifier=test
-- 
2.25.1

