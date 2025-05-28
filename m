Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2900247285
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442479; cv=none; b=qCKqPxoAV3dVY/UeVGFpLLOSC+lZNCEKI1H4pmOzS22dK7//wQDjAlvES5dO/Xhf31FwNKH9eS/q9Dx2PxLAPfmQqfh3VnOLC6KuMKiot1HdtWn7NcS/uESFa8D+MdhMGrfbWP+d4KVHqQgG8sMYmeIFOCFAN+vK0S36wR2NxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442479; c=relaxed/simple;
	bh=GNMGGzrDxVW3GPwKwi773GDH80bySs3ALU/wsrKuYeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=anWyhg5EpgREfumvDsjiwBKrtkoSXJNxObk4ky58loAmsl75sJj2nMule6ZokoBdinyPBogg87j8YGT0evMXSNs9uOLp79A4n1lZBoEmGNuKA6AVJAezlpIx/2rniN6fKIgP5TwvJObncfPTQQAOW5oUrP32jt8sJyPhNYgu0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFObz5AJ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFObz5AJ"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fabb948e5aso11817456d6.1
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748442476; x=1749047276; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS2BQKhuG6jYRBEu99JYJUYEECWKu0sPiGKTu3xKqEI=;
        b=lFObz5AJKFpdlhz4+tMct42Sht8F3pZGs+c+9RDCoqFaQHdBSpNMVmDabbVGH2/DFf
         xU3nYm51xmwr7mmwO+l1jCVdEekJJJpTg0Ihxz6xd5pNR0LFASKSrzHd4NLT6ibVA9hq
         fNbS8ZvAzoB0992yDUjcNHRE5J8w4VXUKcfZDs+QCfBTb24/3ethgfDgr+NRNRZ+bRQQ
         lRDlMAKInTXZXYBfTprDfJUUst6rJz1lYst/yTAeNacjMLjvQa65+vkHBSQCy+UOIgKL
         qPDGzIwla3LtEWuPcEEvwWivmVvmLWpHY7brgSwECp37IZ0BfPBa+zLx+WIt1AI+9VZn
         E0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748442476; x=1749047276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kS2BQKhuG6jYRBEu99JYJUYEECWKu0sPiGKTu3xKqEI=;
        b=YdEzyQjXT8Zzvq/NK4u6wmKXM9QLF9GS0L7/KvHpqNejvid/Nk3q5STrfZfmIdPg0w
         wUsi3kJ126hmSQdEVlv5Ezar21KftcmAvlJBFrMyVmZs9YpNrlFf9TQQjCAvabq2PB2j
         hXJjtmLbErdeKraMP8ugz2qO5+h1Hu9d2lZvcEYvMvBumpEPor3zBkSDRwU+s8dRArIX
         154SDpNzYj94V3TjnYpDQkoni8FRQEUKKajcg01lt65OyjVfiU9m1nEdYz8UxRO4awml
         ynedCXZx7jx9p7BlmmLAulZzpJQZfVr343nTaasUfoxiJkj9nSI/cWtCNDN8o2os6HGh
         U66w==
X-Gm-Message-State: AOJu0YxCjDjTUSPeK8mV3iqJa/yohLbS/xLqUQxEZcM5bqQ4pNlZHbzX
	UbmsGb4VQNIks9rd3LBA8eBUpYqHwmeQxsApbRUiJc3vqovpFoaaa6B1mvrKQA==
X-Gm-Gg: ASbGncuoaF/nzS734Bl1w7E9NNZsieYcce2aaCHHzEzXmjRgp5FMRfsX0QHzmje2x20
	l1N2VqZf89gI+UwAXtl5xKZXQmNu5VzzQCZ7IZxd6pt9KDFmQ16CU0Yb6bCgMG4VZh+qm5dKj/j
	hW/XwAaYF4rHqWA9HAGV7MrDFVuaPUwcO2JSXoAnVjh41Ww2jXNq9nqFuDxPEG7U7vmS8KRnun3
	SF4u7ZgIZPSyFQvXOZ+dS99plRlpEcncMTv90nSTGEZK7FunpucrsUXxax0SMj6kM/rEwYGwk4U
	RubiCnLpxb71WnolJ9Flgn4Lbez7MVWS851M/kUrtjRNDtMMlm/RqBapIdmiZw==
X-Google-Smtp-Source: AGHT+IGSu4+yDgBBrgFuRcUW1g7LIMYVyqTDDUUvUK1D0IPtbKObUC8LXqE6ffbt3i8OmGGFNK2h6Q==
X-Received: by 2002:a05:6214:401b:b0:6e8:9e9c:d20f with SMTP id 6a1803df08f44-6fa9d15997fmr313294596d6.21.1748442476219;
        Wed, 28 May 2025 07:27:56 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0b2244fsm6960526d6.17.2025.05.28.07.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 07:27:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] auto-t: update serveral tests to work with netconfig refactor
Date: Wed, 28 May 2025 07:27:49 -0700
Message-Id: <20250528142750.498252-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528142750.498252-1-prestwoj@gmail.com>
References: <20250528142750.498252-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the method return to Connect() and ConnectBssid() come after
netconfig some tests needed to be updated since they were waiting
for the method return before continuing. For timeout-based tests
specifically this caused them to fail since before they expected
the return to come before the connection was actually completed.
---
 autotests/testNetconfig/static_test.py        | 15 +++-----
 autotests/testNetconfig/timeout_test.py       | 35 +++++++++++++------
 .../testNetconfigRoam/netconfig_roam_test.py  |  2 +-
 3 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconfig/static_test.py
index 94307a8c..61037e0e 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -91,16 +91,11 @@ class Test(unittest.TestCase):
         # using the same static config.  The new client's ACD client should
         # detect an IP conflict and not allow the device to reach the
         # "connected" state although the DBus .Connect call will succeed.
-        ordered_network.network_object.connect()
-        self.assertEqual(dev2.state, iwd.DeviceState.connecting)
-        try:
-            # We should either stay in "connecting" indefinitely or move to
-            # "disconnecting"
-            condition = 'obj.state != DeviceState.connecting'
-            iwd_ns0_1.wait_for_object_condition(dev2, condition, max_wait=21)
-            self.assertEqual(dev2.state, iwd.DeviceState.disconnecting)
-        except TimeoutError:
-            dev2.disconnect()
+        with self.assertRaises(iwd.FailedEx):
+            ordered_network.network_object.connect(timeout=500)
+
+        condition = 'obj.state == DeviceState.disconnected'
+        iwd_ns0_1.wait_for_object_condition(dev2, condition, max_wait=21)
 
         iwd_ns0_1.unregister_psk_agent(psk_agent_ns0_1)
         del dev2
diff --git a/autotests/testNetconfig/timeout_test.py b/autotests/testNetconfig/timeout_test.py
index a15706e3..00b03df4 100644
--- a/autotests/testNetconfig/timeout_test.py
+++ b/autotests/testNetconfig/timeout_test.py
@@ -8,6 +8,8 @@ from iwd import PSKAgent
 from iwd import NetworkType
 
 class Test(unittest.TestCase):
+    def connect_failure(self, ex):
+        self.failure_triggered = True
 
     def test_netconfig_timeout(self):
         IWD.copy_to_storage('autoconnect.psk', name='ap-ns1.psk')
@@ -27,23 +29,34 @@ class Test(unittest.TestCase):
         condition = 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condition)
 
-        ordered_network.network_object.connect()
+        self.failure_triggered = False
 
-        condition = 'obj.state == DeviceState.connecting'
-        wd.wait_for_object_condition(device, condition)
+        # Set our error handler here so we can check if it fails
+        ordered_network.network_object.connect(
+            wait=False,
+            timeout=1000,
+            error_handler=self.connect_failure
+        )
+
+        # IWD should attempt to try both BSS's with both failing netconfig.
+        # Then the autoconnect list should be exhausted, and IWD should
+        # transition to a disconnected state, then proceed to full autoconnect.
+        device.wait_for_event("netconfig-failed", timeout=1000)
+        device.wait_for_event("netconfig-failed", timeout=1000)
+        device.wait_for_event("disconnected")
 
-        device.wait_for_event("connecting (netconfig)")
+        device.wait_for_event("autoconnect_full")
 
-        # Netconfig should fail, and IWD should disconnect
-        from_condition = 'obj.state == DeviceState.connecting'
-        to_condition = 'obj.state == DeviceState.disconnecting'
-        wd.wait_for_object_change(device, from_condition, to_condition, max_wait=60)
+        # The connect call should have failed
+        self.assertTrue(self.failure_triggered)
 
-        # Autoconnect should then try again
-        condition = 'obj.state == DeviceState.connecting'
+        condition = "obj.scanning"
+        wd.wait_for_object_condition(device, condition)
+        condition = "not obj.scanning"
         wd.wait_for_object_condition(device, condition)
 
-        device.wait_for_event("connecting (netconfig)")
+        # IWD should attempt to connect, but it will of course fail again.
+        device.wait_for_event("netconfig-failed", timeout=1000)
 
         device.disconnect()
         condition = 'obj.state == DeviceState.disconnected'
diff --git a/autotests/testNetconfigRoam/netconfig_roam_test.py b/autotests/testNetconfigRoam/netconfig_roam_test.py
index 63e5eabf..b7a7012f 100644
--- a/autotests/testNetconfigRoam/netconfig_roam_test.py
+++ b/autotests/testNetconfigRoam/netconfig_roam_test.py
@@ -19,7 +19,7 @@ class Test(unittest.TestCase):
 
         device = wd.list_devices(1)[0]
         device.get_ordered_network('TestFT', full_scan=True)
-        device.connect_bssid(self.bss_hostapd[1].bssid)
+        device.connect_bssid(self.bss_hostapd[1].bssid, wait=False)
 
         self.bss_hostapd[1].wait_for_event(f'AP-STA-CONNECTED {device.address}')
         device.wait_for_event("connecting (netconfig)")
-- 
2.34.1

