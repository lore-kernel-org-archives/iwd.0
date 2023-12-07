Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B1740BFE
	for <iwd@lists.linux.dev>; Thu,  7 Dec 2023 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMKDvyn3"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-67ad277a06bso5399706d6.1
        for <iwd@lists.linux.dev>; Thu, 07 Dec 2023 05:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701956910; x=1702561710; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MchMnUEFHg8V+CfcUQwkcGFR/Y4dtyM6OUBpfJFWAUs=;
        b=kMKDvyn3VNSqJXEiPc+2mDs2B7i6qqvlkg+ivcK+7FZYQyyjc5eqeGKPKqQB5LULfV
         lhCliV+UOJoIyfTEzQd9oNPNhu5hA2ct+9ulvLxkVpA5A7zJJvhcdQhqTF4AWw7XEDXA
         K9dQstYbdweiiHHCz0AmHcwGOg26rj9NALzTpz5kUUeWgI/Apa4nEdjP0tmmMKQR9jch
         Ga+V2aU9vBaj51oToTOFApEVY6y+lanw4+fe93GM6zaWyI6ETYbIQSB4Rkl5y4F9HtR9
         tcOicxdTkywxTL4PoY3xRUsXbzjAFDxtTiS28xz5gVLPnmJe6guGpaqcIxLBpAwJBkvJ
         gSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701956910; x=1702561710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MchMnUEFHg8V+CfcUQwkcGFR/Y4dtyM6OUBpfJFWAUs=;
        b=ggd3v21E70q7RRkdMC+vVdM8aSH0NXuuf1PPIiGMJfDJ4fmNLUFO4pxm/NwBNApSH5
         RDwBedtTeXySVCbpc7kAm+Xtt5EpnaH6UvSCi8jCxoDtgGTlpd2HNYL15OmBz1VxfEqS
         JQ5PlqODboNmfnEAOY+eJHqvEvhvYsMoj7o8S9uPnEpZmHaWuzBZMEIOEgnzAuPIWuej
         zdMur3KevAN3Pt41wWPCECdaUPffK3D303Zj9Og0dANiD2RZwIb4s0IAb/H4A5kYrOG8
         CAIGRGTH/FD6whsL23Uli7wywTZ13AE5CsFIm0+Mp7CEYxZ+yliTXwoGxL8uJrnpJClg
         gxgw==
X-Gm-Message-State: AOJu0YydXNbhM5bo75xqmN2Ywj3BcQis+TRr1Ks3qItIgssdfSJEbGWy
	gQJUcpeDbuEMIOXcJ/9dUmUHl97I0Kw=
X-Google-Smtp-Source: AGHT+IGI/nbByczHuEe9ueHEqm49gSoF3fgu4ybsmfif45hCEFj9L3BRPb5ZAS0omLRZ5V6wqOzUPA==
X-Received: by 2002:a05:6214:5482:b0:67c:1818:7966 with SMTP id lg2-20020a056214548200b0067c18187966mr2282647qvb.46.1701956910555;
        Thu, 07 Dec 2023 05:48:30 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id w18-20020a0cef92000000b0067a27108513sm496494qvr.67.2023.12.07.05.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:48:30 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] auto-t: add H2E password identifier test
Date: Thu,  7 Dec 2023 05:48:21 -0800
Message-Id: <20231207134822.2458827-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207134822.2458827-1-prestwoj@gmail.com>
References: <20231207134822.2458827-1-prestwoj@gmail.com>
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

