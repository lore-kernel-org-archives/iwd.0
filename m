Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B776D4D11D
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVw3ko34"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b9b90f8708so1223376b6e.2
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 07:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701791221; x=1702396021; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MchMnUEFHg8V+CfcUQwkcGFR/Y4dtyM6OUBpfJFWAUs=;
        b=OVw3ko34P5lyr7hSudCbyPuE0tk1w0SXlXxStHTGcfoh/0ALSzkt/rDYzNSNmDER5x
         DofCFUqKcdBXudFK84PDcdJ30zKoY60f1Xm5nRSrKMUpPDV+7UDrQktpX641crv0CHXO
         2NZyMnSdiUFBqHqEOzzf/e0r6TDYod3FFhjc5OcJoTpons0TDlJoomz0XQN+JjBbjMEL
         CRjbXfK5UNVWo+e5s0M9ShyAjtOC0f4ktf52NLrfW/Vd4tjKhBHUAgJqW61YynBJtl2D
         RZKQjkWEHEKzlk0/x4Jq2dT9HaHtytWXfla29GHUSA8ACHe8w9+Js7abjE3gO3SoJgZi
         DgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791221; x=1702396021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MchMnUEFHg8V+CfcUQwkcGFR/Y4dtyM6OUBpfJFWAUs=;
        b=WgYTh7mYatLLkdr7PrD1xkY/vb1YvZuugzpLEx0ilqwLKGwOxLZBWDvLuA2gBzH2y2
         HWyNRwYgeEVI5g6Dzaqo5/WYRkfHT0HyDFvwPPpu190dqZo0uxyaW68sh/jA2Dt4xSI5
         kVSHspfAN2Xnh3CI0sJ6Ul2go3YQ3HifH5XyjPHFNkcplMvBWn0srg58ZGAD9QzStlUW
         8KW1obO9SXaz6BM9X8reXjIti++R33XFhZXa3UjE/Fp4KH1CO70/FPtlzra2T4IrrfgN
         INFuJlTik4bFW57sghfhZjvyhNY3p05kbcefSZl0ImRu/Vy6vz6AVVblqna8HljRhZnA
         QAXg==
X-Gm-Message-State: AOJu0Yw8JQh468g5mGbAV6CKK1vHtknxRHFfHV8yQqm5AXXQLCZi+/Q0
	Kw9tQt+gm7vBk//Ux1KLlrh5T4yjZhM=
X-Google-Smtp-Source: AGHT+IGd4IObti+m97vzDAVfO5Sy/maHuN6fP2077DMYiSudJh9knzhlSTwil8GFfnoPTpNGdrrLgA==
X-Received: by 2002:a05:6870:1593:b0:1fb:75a:77bb with SMTP id j19-20020a056870159300b001fb075a77bbmr5886552oab.108.1701791221503;
        Tue, 05 Dec 2023 07:47:01 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id kr3-20020a0562142b8300b0067aad395037sm3177567qvb.60.2023.12.05.07.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:47:01 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/10] auto-t: add H2E password identifier test
Date: Tue,  5 Dec 2023 07:46:44 -0800
Message-Id: <20231205154647.1778389-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205154647.1778389-1-prestwoj@gmail.com>
References: <20231205154647.1778389-1-prestwoj@gmail.com>
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

