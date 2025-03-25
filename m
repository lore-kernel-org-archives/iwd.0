Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5EC25FA1B
	for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925658; cv=none; b=qNwvEKQ5ZhB2HcHgDW2yZVjHjqKWS4clvSN1khFrOcub8+qwEC9Jqylddh0WeHXi8Us7KRyyoFVRfIbNJsigFHfcUqq9TmQNU/LsoaPxQFbDrRsAs1yV8z/VZwiwdm7Jkr1p8oq3ww/CEW7Y2jWSDCR3ZSD7hdRZ8yoxCVeVX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925658; c=relaxed/simple;
	bh=RuQY+rH5cxO4piN6+5wH8ICIX8e/hooGS/Quj3DEKgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=izONFNe3S6q83iu8JsI2IZ3pJ2PYqjy1MDFgbQ9sAeCBXYKPxG3LTBEONGl/OrOjEnfV048gCG/UKaBpxAVyKuRijhnurVULM80eoMQq0HFgDnBAPJjdiz7evq3Zt5DmjacNqJTpkxeTxF0zKem8hAlEk5b8ExOJVqmgATfubvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0sN7mCN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0sN7mCN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227c7e57da2so44088565ad.0
        for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742925656; x=1743530456; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y8J2vmE79n+rammSb68Vx/t2JXWMbDjn+1OH9GUK8w=;
        b=b0sN7mCNiSXRFvmpQS0rY3VPftKhbDdPh9bN7IcW9ruui7sMQjzsHvb6Dkw91RlZtv
         bWjDpKwIxMFDOSHL3hJ8q1jEk0v+kWYTvay/JYtKiBmdzIwMAbReM5BrHXHucugO1ddS
         sti6GZxXy2lLtUlC9Co1Es6tO59iHXoybGdGxOhkCVchwXRtMSoUv/BXVt/evvZKYr3t
         VDnvknIlWp/7FXau2oCZ3S11Xgz3bjWQU7y+hR6WumhT7RzeCsurg2LHr5WaD8qPOgtz
         9RLBvDThhAYwhAJaTpKa1gjV58VOLJJ2801JSScS4vPrLbuAd8ajvNKP+/KJFSU8cLUb
         LSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925656; x=1743530456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Y8J2vmE79n+rammSb68Vx/t2JXWMbDjn+1OH9GUK8w=;
        b=ba6mvFglyXsMdgoP03CKFvRTnwlEO2/B7TWGmay8BR5nrk9vyaAJJbZ2JU2E55LdIy
         y0uMqFgwNqf5YmaVZF2bQs07NjB0pLtx3ERZtWPSyWHRgrnrWn/vj+oL/iVd3HCJvIE+
         zcaQrnTOPMa1DM9l+RvAJwoB/S+780CE7G66ozlHJxRyme4z9FdTEaMf/RK9rUKU6Rks
         JpyiMdmFu1mjDDzTz1VE4fJy2sW6p1tT62FX2jh1uGR6X5etuQ35F5fHwYTMHigNm3+R
         UTj+T0R23sXwv6R6MkcEceQTn2AdzIE7ArwM4yEsW7Dy+prKwbhhL74VtVQMxo7t9G3j
         E4xg==
X-Gm-Message-State: AOJu0YzPenJpRIhIiKKfkhZXKcci0IKSk+T9J8Bm/Z7YZtpUUITwqnhI
	r1yrklRsk+MYg505R3ohtrMiU8ughb41vNqDZtNThjmdzWPy/FRBBKmdBg==
X-Gm-Gg: ASbGnctt6uex6sBh9MqwrjqrxFAdL7DaFErz/hcQ7dmVBu4KjUn/Hor+A4ZZxxcUdXt
	uR3W/ZKk4fWSMktAwxRnKtOf0XJi8lne5A54LvDG2vK0a+6k8xEVeLia8eR808ydkihqFsYGwYd
	2jM8mu4SjaKk2I59C5myRnmkVK6aiIKQ+cvP07mNv6hwhVWasRTriIw6pcTAMkYZ4+7AMOpCqgd
	OYIjrGdFg6HdTVzrw0D5VIFLvfqXZRWtVZRpjp21UANIGOE68KJDmcs6P2tghTwfTutXSMaTSZK
	xqbLWxcP3ATn+YAmNxAyHMYbUQBhdqYhlELONogwNgb+lNATCosC1F6X6GYngUQdWqgcu0XghCQ
	cdts=
X-Google-Smtp-Source: AGHT+IGcrY3iwnbMfNxpvoyJiSD8hOaWT4Mb5tGJn+rFmzFJjrKO19p2UCumeE9pRMnfsq/FDTUwVA==
X-Received: by 2002:a17:902:da86:b0:223:4341:a994 with SMTP id d9443c01a7336-22780c7ec73mr248722285ad.9.1742925655487;
        Tue, 25 Mar 2025 11:00:55 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bae9asm93770515ad.138.2025.03.25.11.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:00:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 02/10] auto-t: add test for disabling the timeout blacklist
Date: Tue, 25 Mar 2025 11:00:33 -0700
Message-Id: <20250325180041.238676-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325180041.238676-1-prestwoj@gmail.com>
References: <20250325180041.238676-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testBSSBlacklist/TestBlacklist.psk  |  2 +
 autotests/testBSSBlacklist/connection_test.py | 57 +++++++++++++++++++
 .../{main.conf => main.conf.default}          |  0
 autotests/testBSSBlacklist/main.conf.disabled |  2 +
 4 files changed, 61 insertions(+)
 create mode 100644 autotests/testBSSBlacklist/TestBlacklist.psk
 rename autotests/testBSSBlacklist/{main.conf => main.conf.default} (100%)
 create mode 100644 autotests/testBSSBlacklist/main.conf.disabled

diff --git a/autotests/testBSSBlacklist/TestBlacklist.psk b/autotests/testBSSBlacklist/TestBlacklist.psk
new file mode 100644
index 00000000..abafdb66
--- /dev/null
+++ b/autotests/testBSSBlacklist/TestBlacklist.psk
@@ -0,0 +1,2 @@
+[Security]
+Passphrase=secret123
diff --git a/autotests/testBSSBlacklist/connection_test.py b/autotests/testBSSBlacklist/connection_test.py
index 9631a322..ac1cb86d 100644
--- a/autotests/testBSSBlacklist/connection_test.py
+++ b/autotests/testBSSBlacklist/connection_test.py
@@ -260,12 +260,69 @@ class Test(unittest.TestCase):
 
         self.wd.unregister_psk_agent(psk_agent)
 
+    def test_blacklist_disabled(self):
+        wd = self.wd
+        bss_hostapd = self.bss_hostapd
+
+        rule0 = self.rule0
+        rule1 = self.rule1
+        rule2 = self.rule2
+
+        psk_agent = PSKAgent(["secret123", 'secret123'])
+        wd.register_psk_agent(psk_agent)
+
+        devices = wd.list_devices(1)
+        device = devices[0]
+
+        rule0.drop = True
+        rule0.enabled = True
+
+        device.autoconnect = True
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        ordered_network = device.get_ordered_network("TestBlacklist", full_scan=True)
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        # The first BSS should fail, and we should connect to the second. This
+        # should not result in a connection blacklist though since its disabled.
+        bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.address)
+
+        device.disconnect()
+
+        rule0.drop = False
+        device.autoconnect = True
+
+        # Verify the first BSS wasn't blacklisted.
+        bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.address)
+
     def setUp(self):
+        _, _, name = self.id().split(".")
+
+        # TODO: If we have this pattern elsewhere it might be nice to turn this
+        # into a decorator e.g.
+        #
+        # @config("main.conf.disabled")
+        # @profile("TestBlacklist.psk")
+        # def test_blacklist_disabled(self)
+        #    ...
+        #
+        if name == "test_blacklist_disabled":
+            IWD.copy_to_storage("main.conf.disabled", IWD_CONFIG_DIR, "main.conf")
+            IWD.copy_to_storage("TestBlacklist.psk")
+        else:
+            IWD.copy_to_storage("main.conf.default", IWD_CONFIG_DIR, "main.conf")
+
         self.wd = IWD(True)
 
     def tearDown(self):
         IWD.clear_storage()
         self.wd = None
+        self.rule0.drop = False
+        self.rule1.drop = False
+        self.rule2.drop = False
 
     @classmethod
     def setUpClass(cls):
diff --git a/autotests/testBSSBlacklist/main.conf b/autotests/testBSSBlacklist/main.conf.default
similarity index 100%
rename from autotests/testBSSBlacklist/main.conf
rename to autotests/testBSSBlacklist/main.conf.default
diff --git a/autotests/testBSSBlacklist/main.conf.disabled b/autotests/testBSSBlacklist/main.conf.disabled
new file mode 100644
index 00000000..aae6bc12
--- /dev/null
+++ b/autotests/testBSSBlacklist/main.conf.disabled
@@ -0,0 +1,2 @@
+[Blacklist]
+InitialTimeout=0
-- 
2.34.1

