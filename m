Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAD621A453
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748463038; cv=none; b=tDF9NhxHvNVPiNc1gDrVgNfrcr5GBLXHOIdJzw8BOykEmX3BIERsHozXpcTymvq5zNgF9Xv71pn5q2c1mhaoRC9iKMJXRaYFJR5OiClJ5AQQKFC+UdRwC16Z8ngZ3tWnvHBTlLYvh9vVnr6vtGiLVUVdC4mgl7NxJf5Gy/wOo30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748463038; c=relaxed/simple;
	bh=GNMGGzrDxVW3GPwKwi773GDH80bySs3ALU/wsrKuYeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W56h0pyPpAxNaNQ1qXiOa6ndQ1MBir0E8ZVtbL1KLEvhZPU0pdsNSBclZqh7JvJyh+4LnkInl80oYxkSI1d8hJ/IcBT3CQlMo8Wd7xtM3VM9Ekz4CuhuAsa7x/8mqLulRg+ghgI0dpflP5MRaYU8V3rx/mZzB4FER9fmo1IKPDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Za1oysMY; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za1oysMY"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so2184316d6.2
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 13:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748463035; x=1749067835; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS2BQKhuG6jYRBEu99JYJUYEECWKu0sPiGKTu3xKqEI=;
        b=Za1oysMYlnId0vrlvKQS9l77lUp9zwkQ6tToBsftGJwLdjxAxjkk7OsGU0O1WMvsHz
         F0f0OogPUh3w1HHm2BEnGF9zQop8H5y/uNzO5rx9J6sYWOEQ1Ar8LF8FlPEJycpPBfx8
         9oKiXZh+RuH/QV1EUpJVRkRdKkW+mEg5X20nNM66IULUI9EE5wW5S8WvFWXG0jThiEEh
         v6IxwiriYPPryLhtd275kLZHJ60ez77LUfFQBRt3sXj1FFR++uMbTtSbemb1soc/UAIY
         w/o7f3F3demrAjCrMgJfSLBH81gHzKALo54SUz8RNYpmV3GYQL/KlSXKgH08yX6nKjGH
         4sdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748463035; x=1749067835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kS2BQKhuG6jYRBEu99JYJUYEECWKu0sPiGKTu3xKqEI=;
        b=rBxnDnyh0waEkPSu60Xpf2DXpb19kpTrfhUPNj9Exb3N53Tqc0uZ6Tw8sP+1A/k25R
         ADBy8Tc2PFk4DmxciTLruxH4QoTswrWq6UOvpAZNRwaisEJvCstJE1KvNK7yCSttTFHm
         DIUD8OhRlswzY9KpneoVTOI4zd/k8Hgkw7P5JLmCVX2bu9McYKFZKsp1A6q14r8PMQ3x
         CamJsri4xiPXoTEtde9uNda+uVyy93KDi5KQilMvCwP3iwYATOeaxpn7FvOfszp8fPgs
         YLwsDc2yoKr6eHVV/dxKTgAseTsBqI+ltw61n9MFsNq00RXTXj2x/tI4GlTBzQBpnyiL
         lzlQ==
X-Gm-Message-State: AOJu0Ywdkid5RZdOAw2GhZXMwaX0oQn5+P2qKTW2t4dpGmYN8A8a+x9F
	8Aocj32+eAeLRQqHYDK1x/VsaxE8VejiT9blSutuRWleswX2uhran9EHbc6iuQ==
X-Gm-Gg: ASbGncswZjkorQAKvjvHGW8JfGLOfnHc7v7r7HbCc1NIC40Ild5A4b+uYWz1Yyle4pf
	Y4/zQOW5X+l7BeAL3XsaRDpPf1uI3zJ6b6qxml+l4GL/uxt1aQhXigVPip4RPBSeUYfGYdgyIvF
	xKDAYuHgWFyBU7wU5O2cwXz5lrhM03Ox0U6QP5s1e2fJ6dVwzojxyTQgiZ809K1FefePutfVj5j
	Pa6IUwGpCf2ujDdqlwxwUKgCjMq1786XK0Ubs++S+MeWR5KFngriWUx1I821tkmA/VjrGOaStF/
	wdFAB9JiPt1423Jpz2KS55riQGXFHQKRhj7dC+dW8ohqpnEHWIHrwZX+AECMrjoPefOdDk/L
X-Google-Smtp-Source: AGHT+IECJZJriZgl/6I03rpWLFvV/AJw3ZtQ8iCetcfheG5Cgrq3guJZhPrOeHGCwT2aMQbTNDwOlQ==
X-Received: by 2002:a05:6214:b6a:b0:6fa:b968:f022 with SMTP id 6a1803df08f44-6fab968f725mr94307206d6.8.1748463035118;
        Wed, 28 May 2025 13:10:35 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0b2888asm10408126d6.45.2025.05.28.13.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 13:10:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/6] auto-t: update several tests to work with netconfig refactor
Date: Wed, 28 May 2025 13:10:25 -0700
Message-Id: <20250528201026.598221-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528201026.598221-1-prestwoj@gmail.com>
References: <20250528201026.598221-1-prestwoj@gmail.com>
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

