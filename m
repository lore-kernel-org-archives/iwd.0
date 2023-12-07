Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223D741212
	for <iwd@lists.linux.dev>; Thu,  7 Dec 2023 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af5VIlox"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59064bca27dso376112eaf.0
        for <iwd@lists.linux.dev>; Thu, 07 Dec 2023 06:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701957655; x=1702562455; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MchMnUEFHg8V+CfcUQwkcGFR/Y4dtyM6OUBpfJFWAUs=;
        b=Af5VIloxHNugf9WBiR4uTyPrUtBr5MqDR3dhutZECwxvQG9MgkLYKsGH0b7jjQuczn
         qpvsPO3oXJTtRMB5oroxX5dAZ4vC1Dbv6MaecdytUn1jGSvMs7Su2ET/srYq+eeN5OtC
         YfiG3eIl0jvxzmC+mxHQVaapHQnpiug4kM313Ao+MgYRgqmC2clkPtQ5F+axtG6IA+C/
         p5P3tbyUGQhEgJEJl8Tc5KOsxawmCGKOgvOPCdoj9GfoQWyl+pfrGN/4GL6FQvO/wqJ1
         k4CSkZYHaxqkMd/DDKRRw/c3LN+qiU5oG19uUxSjeSAKPCiQdAV0SO+lc6wcIG+gOOKY
         966Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957655; x=1702562455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MchMnUEFHg8V+CfcUQwkcGFR/Y4dtyM6OUBpfJFWAUs=;
        b=N+RLVZ8VWEAj4AzTyV/X99f6gvuee2TgtvwV5YzBRIN+/4Bqlb47BnwuTVFW4OveAB
         9CDjOmc9LZr+8pM2EFkwKl6wz56cdpg0XpMF02eY/ohHVjnehz94t3dJrf73KlLD1fdf
         t4WqhysqFXkesnNBnUpIER1F0sUJ5QwAbr9Qf9wLHMI6kZKE43KtYeBxjd0Jr8uj5y6z
         ODXF/pX17yzHTyKFoxAXwRqjksvlch7XqQoGQW4thsqbla9GcQXhinB030rQ7/o3g2W0
         fCrPIWMF2PashVva9WTkcLpppdSskQVFyecitnjwKAcAorP9AJX9/LuE02kYyKWsMFKn
         ZVkg==
X-Gm-Message-State: AOJu0Yz2sQNt1uiEgvUurmeqOpJ1oIViIzVug3GPlMzWlpgGZyCAwXJ+
	a12AvXNexJjQUehllFJNkcHyeU0EgWE=
X-Google-Smtp-Source: AGHT+IGNq9z1+DIw4hKJYTG6FvwEVbJKLVDWDFzfZxfPqwv06EMRV3DasUvkOriE/HjJp5djxtLs2A==
X-Received: by 2002:a05:6358:2917:b0:170:87d:f307 with SMTP id y23-20020a056358291700b00170087df307mr2755404rwb.19.1701957654772;
        Thu, 07 Dec 2023 06:00:54 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id px24-20020a05620a871800b0077dc1476413sm407699qkn.131.2023.12.07.06.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:00:54 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/4] auto-t: add H2E password identifier test
Date: Thu,  7 Dec 2023 06:00:48 -0800
Message-Id: <20231207140049.2614514-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207140049.2614514-1-prestwoj@gmail.com>
References: <20231207140049.2614514-1-prestwoj@gmail.com>
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

