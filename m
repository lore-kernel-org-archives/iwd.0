Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5AE1BBBE5
	for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172986; cv=none; b=Sc7CKKmAzMKXk57ZR0cJr5jPlZGEEbb8GH1vr53lKleZxAJ+zBAQATCdlRYM1X/RxTfse3yETwKw/4oqySevnNK7StV/fizjHZXtXQoeSj6vSRXDbEfGugqoy/bPWqyIH19T5rvB1wc3DVzqUPhF0osjZKq+KIuBzN1cdCkGHcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172986; c=relaxed/simple;
	bh=RuQY+rH5cxO4piN6+5wH8ICIX8e/hooGS/Quj3DEKgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfSjPMDbA5uN4rbhWA0k/LZIu7+fTlvtLzksntaQ3hLBPXJ4yCGqGpuMKCl1fDYpTGCSySN5h4v/xmoV5cuawGcXwJK43j+2e5XiVioRmEA25HPi+qfGs6+twtreNYIyGk3HoRKDCKc2TEWmstFw0lddTZA5wjFQXefmBzzkGbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORe3XQZb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORe3XQZb"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22548a28d0cso63363305ad.3
        for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743172984; x=1743777784; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y8J2vmE79n+rammSb68Vx/t2JXWMbDjn+1OH9GUK8w=;
        b=ORe3XQZbVgG0dPvMmbhPFi4lxezwOVPuVbRRVGZ8fxde1bMl8SJ0/7mdIwEI9kC2Wt
         grkKcz/4TeklRck6LbveT9/CNx9ymqYy8STB81RTwQr1O/GRY0Wjp5OU4phtbYleFD16
         P7sFCWk0U0mHvSm+R/QD2ucAvOnWc4G10cEFgspP7tlIU3yDD9n4pU9SI3eejWLUs8nY
         CPJGCSroyq/KrAYKURTdtGYJjncuacFiGi1iZtpGwRRRlQLT/VD1HiEnCl12nQyuPR/O
         viUKsh4cLCsWFvYSdLVcCTESmufSPDqrPaWGsUr9IsKjE2E86wyq62xcD9MqVNo/c7sz
         3tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743172984; x=1743777784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Y8J2vmE79n+rammSb68Vx/t2JXWMbDjn+1OH9GUK8w=;
        b=WE/egkEScjx4+9dCg/Bc/1jwY64oI3boU0kzJnnt7FFLvWcxZkRbGKMu+wjMiTU43a
         A8L3ZDJoRtReERujlYVRkIDFxK9dmcgVaNIN/TFfj20dwseNPIZ1NnbtRzOZk2ZazoIm
         rIoriksRRrVwiz73fYNJ5jmBYnFpTrOPmomv1I/Js3gjU/J7twtjhDteIjORasVPYIQo
         nDJijjCDhw0hQt9v28p8TibCijzQvof6ikmUno12AJEUzM0a7P2ev/JANZ5xtehcpe1B
         bIu/9d8biv4DDuFCZCXuJlv8oFUx2iIgtN7BIiJZ98v1LyHpT2uZ1ybwWwB51bHzOJ6z
         OL7g==
X-Gm-Message-State: AOJu0YxJO0OXIEGDLXzQIHkaXV/Mb9pTAGj+h6TLNwSFQrZ2dT2pFsoF
	GO4G5LcwUGw7ssZ+OsF828K2iyg2p+zcNcdaq2+OoFwbL4fYKQLkYbu97A==
X-Gm-Gg: ASbGncuDf6tNfZ4R/hYZwRM5xuskJCrHzFrwQ1/RmlSGnstMPb9245K3PsfJQE6TLk/
	G/bLQoSwy6iKpo36nXlAF8/qVMSzoK0odFwWqGxnS58CTyFAZt2ialj54triZeUE3OkMn5hR6Xl
	8q8+ynzRiRFbKhCmovrnGJst1n6FxpcEbWdAvrE3jkUEsVKDJHY1IWdeg2BIWeDc4E2RwD/m9fd
	LWvwuLN946b+TmkQD5sResjyu2ElF9HIhkMmRfICT8BmGRRCT7PbbmEXnP4STn4SV69LGstxy/r
	JXMX6C54iSVp1WJmrric6aQtxoAdPeRirv9e2fMYlozCOIETmBaV1LvHjwPl0njHMr65wLqvXoA
	=
X-Google-Smtp-Source: AGHT+IF8e5Q/SF6u5IrEAR6LXj5wOREhbH17jpyQGJs/UmUALOcrJCUswgSYr1lYY5WjpUgDh0B1kA==
X-Received: by 2002:a17:903:184:b0:224:fa0:36da with SMTP id d9443c01a7336-22804845131mr112945665ad.18.1743172983462;
        Fri, 28 Mar 2025 07:43:03 -0700 (PDT)
Received: from LOCLAP699.locus-demo-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee2288sm18885515ad.87.2025.03.28.07.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:43:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 02/11] auto-t: add test for disabling the timeout blacklist
Date: Fri, 28 Mar 2025 07:42:44 -0700
Message-Id: <20250328144253.421425-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328144253.421425-1-prestwoj@gmail.com>
References: <20250328144253.421425-1-prestwoj@gmail.com>
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

