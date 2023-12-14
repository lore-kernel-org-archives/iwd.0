Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C592A4AF7D
	for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGiK+FsZ"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2031ebf11d9so690615fac.3
        for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 04:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702557246; x=1703162046; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MchMnUEFHg8V+CfcUQwkcGFR/Y4dtyM6OUBpfJFWAUs=;
        b=iGiK+FsZlb6wUMVpZIE+4666gZXmIjrEiTUxRjRtb1Z7Saa90/tv8YgEbCoqcTUlgp
         R/PX5OmsmdBDLup+ua80YVE9NNH2AJt8OUXah6cl4lHvl/6GEWyqjNIwUAVTjAfiZHUW
         svtLVO/rlVmdD7TiJixeGcKM5u4hNOppJaM3+ioJnfFTs6IMebliYYwcE5/RUuUALz1/
         SjN7XqiDFMamtO3BC/DZJ0UsebIeAvM7LuWkzkz8NjZcFdb+1FVCBIOb6tEZFcERP2nN
         DfdOkpRe9h0Bq76Qqv+bDnzzL04b3uJDo4G1QbGfkhtRW4MxxunN3rxTYg2fEy1PYcBf
         vbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557246; x=1703162046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MchMnUEFHg8V+CfcUQwkcGFR/Y4dtyM6OUBpfJFWAUs=;
        b=jtYam1ertusZBjYKBRpxKyywCHXoF/WEgkJ/6JvFjVKuHoTJ20yF204qaSVA5BaT//
         e3T0AQ/WG09BFXLjaDPEuQnJX6a55mFGV074bVmLHpLNAFtuKKOhnqZOGRo8d47BdoWl
         FzSWYTpcJgJSANks05bZqA8F+WLB4gQztdhdp8e1zpBDWt+B0HgjSc8o2Vycu0qLLLfB
         RuPtN7d1hPPc3v4Aa4YFVGIkIJ3i4lZFpr/oHNbnZjCCujxOhKFz3wgG8F3YUqszbtjJ
         dFqgx3tPjfxDRefM3mN356MNlxLtII56yZ/CLH0NdP6nNJ7en27AZUUuqjJiOqLRIUbG
         qQlg==
X-Gm-Message-State: AOJu0Yy2KUUcTw6fyNKkgeECEWqdxDAzwxfVQ1ufjxyD8DaAGP8vG4xT
	mXddpDl3Dx+C+1gv5UR/4GFDfcPybIQ=
X-Google-Smtp-Source: AGHT+IGc0v2tzk5aqsM++O1isAU2YEttfxbOZWkAJDi/39QfGPv8U5exSI9gPWhlAgsM1hTnXWgCDw==
X-Received: by 2002:a05:6870:ef06:b0:1fb:75b:2ba9 with SMTP id qq6-20020a056870ef0600b001fb075b2ba9mr6017905oab.101.1702557245613;
        Thu, 14 Dec 2023 04:34:05 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id x3-20020ac87303000000b0042551dce749sm5745883qto.46.2023.12.14.04.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:34:05 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 3/4] auto-t: add H2E password identifier test
Date: Thu, 14 Dec 2023 04:33:59 -0800
Message-Id: <20231214123400.12924-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214123400.12924-1-prestwoj@gmail.com>
References: <20231214123400.12924-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support identifiers the test profiles needed to be
reworked due to hostapd allowing multiple password entires. You
cannot just call set_value() with a new entry as the old ones
still exist. Instead use a unique password for the identifier and
non-identifier use cases.

After adding this test the failure_test started failing due to
hostapd not starting up. This was due to the group being unsupported
but oddly only when hostapd was reloaded (running the test
individually worked). To fix this the group number was changed to 21
which hostapd does support but IWD does not.
---
 autotests/testSAE/autoconnect_test.py         | 20 +++++++++++++------
 autotests/testSAE/failure_test.py             |  2 +-
 autotests/testSAE/ssidSAE.conf                |  3 ++-
 .../{ssidSAE.psk => ssidSAE.psk.default}      |  0
 autotests/testSAE/ssidSAE.psk.identifier      |  3 +++
 5 files changed, 20 insertions(+), 8 deletions(-)
 rename autotests/testSAE/{ssidSAE.psk => ssidSAE.psk.default} (100%)
 create mode 100644 autotests/testSAE/ssidSAE.psk.identifier

diff --git a/autotests/testSAE/autoconnect_test.py b/autotests/testSAE/autoconnect_test.py
index cba59274..4ce3b845 100644
--- a/autotests/testSAE/autoconnect_test.py
+++ b/autotests/testSAE/autoconnect_test.py
@@ -35,12 +35,23 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(ordered_network.network_object, condition)
 
     def test_SAE(self):
+        IWD.copy_to_storage("ssidSAE.psk.default", name="ssidSAE.psk")
         self.hostapd.wait_for_event("AP-ENABLED")
 
         wd = IWD(True)
         self.validate_connection(wd)
 
     def test_SAE_H2E(self):
+        IWD.copy_to_storage("ssidSAE.psk.default", name="ssidSAE.psk")
+        self.hostapd.set_value('sae_pwe', '1')
+        self.hostapd.set_value('sae_groups', '20')
+        self.hostapd.reload()
+        self.hostapd.wait_for_event("AP-ENABLED")
+        wd = IWD(True)
+        self.validate_connection(wd)
+
+    def test_SAE_H2E_password_identifier(self):
+        IWD.copy_to_storage("ssidSAE.psk.identifier", name="ssidSAE.psk")
         self.hostapd.set_value('sae_pwe', '1')
         self.hostapd.set_value('sae_groups', '20')
         self.hostapd.reload()
@@ -51,15 +62,12 @@ class Test(unittest.TestCase):
     def setUp(self):
         self.hostapd.default()
 
+    def tearDown(self):
+        IWD.clear_storage()
+
     @classmethod
     def setUpClass(cls):
         cls.hostapd = HostapdCLI(config='ssidSAE.conf')
-        IWD.copy_to_storage('ssidSAE.psk')
-        pass
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
 
 if __name__ == '__main__':
     unittest.main(exit=True)
diff --git a/autotests/testSAE/failure_test.py b/autotests/testSAE/failure_test.py
index 2aac3a07..aa4d14b9 100644
--- a/autotests/testSAE/failure_test.py
+++ b/autotests/testSAE/failure_test.py
@@ -37,7 +37,7 @@ class Test(unittest.TestCase):
         self.validate_connection(wd, 'InvalidSecret')
 
     def test_no_supported_groups(self):
-        self.hostapd.set_value('sae_groups', '1')
+        self.hostapd.set_value('sae_groups', '21')
         self.hostapd.reload()
 
         wd = IWD(True)
diff --git a/autotests/testSAE/ssidSAE.conf b/autotests/testSAE/ssidSAE.conf
index 41f46cad..f5ce537d 100644
--- a/autotests/testSAE/ssidSAE.conf
+++ b/autotests/testSAE/ssidSAE.conf
@@ -5,7 +5,8 @@ ssid=ssidSAE
 wpa=2
 wpa_key_mgmt=SAE
 wpa_pairwise=CCMP
-sae_password=secret123|mac=ff:ff:ff:ff:ff:ff
+sae_password=secret123
+sae_password=withidentifier|id=myidentifier
 sae_groups=19
 ieee80211w=2
 sae_pwe=0
diff --git a/autotests/testSAE/ssidSAE.psk b/autotests/testSAE/ssidSAE.psk.default
similarity index 100%
rename from autotests/testSAE/ssidSAE.psk
rename to autotests/testSAE/ssidSAE.psk.default
diff --git a/autotests/testSAE/ssidSAE.psk.identifier b/autotests/testSAE/ssidSAE.psk.identifier
new file mode 100644
index 00000000..3664063a
--- /dev/null
+++ b/autotests/testSAE/ssidSAE.psk.identifier
@@ -0,0 +1,3 @@
+[Security]
+Passphrase=withidentifier
+PasswordIdentifier=myidentifier
-- 
2.34.1

