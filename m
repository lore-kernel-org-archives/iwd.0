Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7D6AA4
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:14:08 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-13af2d12469so4698011fac.13
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1FbxXAJPHzCn5v6mwheNTG8PW972DaO5UUUnm8tB1I=;
        b=o+Ib2vtSF77AXWRXkGyyjEZjC7/VjDcPg4v8BJycnZvH6ky8hH8N9zEp72COlf4tgj
         /8GcwZzv64ajLCQz1VOGKxHWkuqhO8FY4CrRr/gyO64IltItOCKNHsL6Fahs5fVbvMjZ
         R+CoabI8rgbOB64dGMoFXXECd+2f5S5cR4ERqiN1DLinpSc4T3gFydgp2ZMP/zsxwaU0
         Ff4Nii1pdtcYz/EinoACJVT3PGMxR4pOJRQaLCHic8GDs3D+rYcV/5G1fOYMKCS0V0Jx
         Ib0cmVuoSXLPthwOaoa+Z7Hcznw3ZWzfBWpoLK2lozz4JGCtHlVzOpYDmkYneBcciOZ+
         lA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1FbxXAJPHzCn5v6mwheNTG8PW972DaO5UUUnm8tB1I=;
        b=29ba6w6wM4l5Sv7UzNRY+TCes164CgzDKPPdgoAdFb2eWNbZgczv/nx0/SLoXc6VRn
         CkIrkfm3BiRGk4TmVa4NrzSO5Hn2tXf8XbAHdpzH9dzgncDKNJTNJSguaS/72l6rJ7xl
         3i4jSpI7X8G1oXOPAB6ziA+5wO3fJqaNBtVlgQTqKA408bvayaq2c5wcFrlST+WX/GKe
         yfxaUZ2PLK8eAnDiEyJtcD6c2KtXkR+enZ105h2c/z3Jz8FlBtH+upB9EnkXhf0+jSNm
         HAkGhlWCjIqnMNB6wONTMcx0ncjd19O0oZ8UFn6gPmJ3YdPKkee1c4Pqlq96Aq5GsSvr
         oVOQ==
X-Gm-Message-State: ACrzQf2OzR0Ez2anSrwtctHgYg0DkbXNPyMst9xWPLvCuQNQTA3ZQO2O
	A0kG1SNKpcs1wMzcntobuOewVE5717E=
X-Google-Smtp-Source: AMsMyM4OS7EMThF7ko/nAZh8IY58i6obgo+qX/hz59V072ae31+pgi4ni+7/MavUO8oaHn1GaA8cUw==
X-Received: by 2002:a05:6870:1795:b0:136:88c4:8c8f with SMTP id r21-20020a056870179500b0013688c48c8fmr30807705oae.191.1666379647982;
        Fri, 21 Oct 2022 12:14:07 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:14:07 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 26/26] auto-t: Add tests for GMAC/GMAC-256/CMAC-256
Date: Fri, 21 Oct 2022 14:13:07 -0500
Message-Id: <20221021191307.31492-26-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021191307.31492-1-denkenz@gmail.com>
References: <20221021191307.31492-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testWPA2withMFP/connection_test.py  | 42 ++++++++++++++++---
 autotests/testWPA2withMFP/hw.conf             |  4 +-
 .../{ssidCCMP.conf => ssidWPA2.conf}          |  2 +-
 3 files changed, 40 insertions(+), 8 deletions(-)
 rename autotests/testWPA2withMFP/{ssidCCMP.conf => ssidWPA2.conf} (88%)

diff --git a/autotests/testWPA2withMFP/connection_test.py b/autotests/testWPA2withMFP/connection_test.py
index 982b69e265d7..bdc9e96ac536 100644
--- a/autotests/testWPA2withMFP/connection_test.py
+++ b/autotests/testWPA2withMFP/connection_test.py
@@ -8,19 +8,18 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
+from hostapd import HostapdCLI
 
 class Test(unittest.TestCase):
 
-    def test_connection_success(self):
-        wd = IWD()
-
+    def validate_connection_success(self, wd):
         psk_agent = PSKAgent("secret123")
         wd.register_psk_agent(psk_agent)
 
         devices = wd.list_devices(1)
         device = devices[0]
 
-        ordered_network = device.get_ordered_network('ssidCCMP')
+        ordered_network = device.get_ordered_network('ssidWPA2')
 
         self.assertEqual(ordered_network.type, NetworkType.psk)
 
@@ -39,13 +38,44 @@ class Test(unittest.TestCase):
 
         wd.unregister_psk_agent(psk_agent)
 
+    def test_cmac(self):
+        self.hostapd.set_value('group_mgmt_cipher', 'AES-128-CMAC')
+        self.hostapd.reload()
+        self.hostapd.wait_for_event("AP-ENABLED")
+        self.validate_connection_success(self.wd)
+
+    def test_gmac(self):
+        self.hostapd.set_value('group_mgmt_cipher', 'BIP-128-GMAC')
+        self.hostapd.reload()
+        self.hostapd.wait_for_event("AP-ENABLED")
+        self.validate_connection_success(self.wd)
+
+    def test_gmac_256(self):
+        self.hostapd.set_value('group_mgmt_cipher', 'BIP-256-GMAC')
+        self.hostapd.reload()
+        self.hostapd.wait_for_event("AP-ENABLED")
+        self.validate_connection_success(self.wd)
+
+    def test_cmac_256(self):
+        self.hostapd.set_value('group_mgmt_cipher', 'BIP-256-CMAC')
+        self.hostapd.reload()
+        self.hostapd.wait_for_event("AP-ENABLED")
+        self.validate_connection_success(self.wd)
+
+    def setUp(self):
+        self.wd = IWD(True)
+
+    def tearDown(self):
+        self.wd.clear_storage()
+        self.wd = None
+
     @classmethod
     def setUpClass(cls):
-        pass
+        cls.hostapd = HostapdCLI(config='ssidWPA2.conf')
 
     @classmethod
     def tearDownClass(cls):
-        IWD.clear_storage()
+        pass
 
 if __name__ == '__main__':
     unittest.main(exit=True)
diff --git a/autotests/testWPA2withMFP/hw.conf b/autotests/testWPA2withMFP/hw.conf
index fad15b8823a3..edfe03f97e25 100644
--- a/autotests/testWPA2withMFP/hw.conf
+++ b/autotests/testWPA2withMFP/hw.conf
@@ -1,5 +1,7 @@
 [SETUP]
 num_radios=2
+start_iwd=0
 
 [HOSTAPD]
-rad0=ssidCCMP.conf
+rad0=ssidWPA2.conf
+
diff --git a/autotests/testWPA2withMFP/ssidCCMP.conf b/autotests/testWPA2withMFP/ssidWPA2.conf
similarity index 88%
rename from autotests/testWPA2withMFP/ssidCCMP.conf
rename to autotests/testWPA2withMFP/ssidWPA2.conf
index c79f5e558021..908915d7cb02 100644
--- a/autotests/testWPA2withMFP/ssidCCMP.conf
+++ b/autotests/testWPA2withMFP/ssidWPA2.conf
@@ -1,6 +1,6 @@
 hw_mode=g
 channel=1
-ssid=ssidCCMP
+ssid=ssidWPA2
 
 wpa=2
 wpa_pairwise=CCMP
-- 
2.35.1

