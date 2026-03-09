Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EC93E9F6D
	for <iwd@lists.linux.dev>; Mon,  9 Mar 2026 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075477; cv=none; b=FMTjMooqgoaX+2Lmi+4YNw/GW1iG61j1vOjP2bCQyAjDP023+6tcfDogcsGejZBCFguJbEV/1XAFWtGiVkASqQdASHVVu69rDETQMt9bC3ZLe3i9n0VGzyqnh4Qypm2fruXibPo4/8t5AOzB6BV3LtmGsM2uqNP0WnPRtYIBUmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075477; c=relaxed/simple;
	bh=IJWYjndnFpC5xnGpiKbjGewK3DfIZlXvSp5pbn+GJCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2Fo4M2UYhTreV4JWp8wo7ASstEXBqpma3/ahqv1YgkOC1zgbOPtdfkeW2fw2YQY8KzW5n/wwYAW9Sg/ImIW21BeJ8dCTskM7yu/a2/MYFKFLki+IoW4vTe+2F9p/ffUNY4T2Qs3fCG+nStGWmNxVT0m4lWlBKyS6yYJDqLVsbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kx5eXV9R; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx5eXV9R"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899fb2b94c1so106625586d6.3
        for <iwd@lists.linux.dev>; Mon, 09 Mar 2026 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773075473; x=1773680273; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAir6ICMzOQe+c8trwfnfdNCYgeTK9hOaTEI2J6X9TM=;
        b=Kx5eXV9Rql8z0lYIx4G5Il6R4DLWJ3NECUTkquHJiLKfL2G+H5XhC9UaTyJzGthOuA
         ntYWOSPOW07FJwDFvXASPSdqxnfcTOk8UcZOLpZezFnkEEGsjiX/xcz3KGdQDkJNdb9d
         MvO++toTkAZ3UVFPe7ZeWYWdL0aY+6A3kXZHdfFraMXGUjLPtFJEsR3u2wIg7oYOppc1
         /mQBKYHHPfYGd6jQyfpvoD6g77cfN18hm//UBBnww9uaZEC97WwirHWe/XP1OtNp37Zr
         fMR5EeajSAMA/8MIiO63YsbQDNDNQFCyIn/MPumr3gjBdktEiy5G06slFjfv2LdscI2Y
         FudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075473; x=1773680273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAir6ICMzOQe+c8trwfnfdNCYgeTK9hOaTEI2J6X9TM=;
        b=cIq3dSJ3W69yUeTx+zDVlRr79TMXzkgpkvwSS4qQmODE1faVouuh9aIrM7DDykHbsk
         fPM0vYd0bLq8Fu9Ej9W8OULbSoH3DhW/iNzYsOCzIFDaT+dybPLMyPHnoeyUyyP2ULgf
         AJZwbw82neqZcGwjjAaUMpiYY1IYQH8LXQZ185nnKsLClNKzy9oxDevCcoTHcpElEoFX
         6jUW+kAVgNPUV4WhaHb19Fd6iTAXF4vSOPDEY5PZ4hjfJ4wZ80BiOy++8MxIe2JCneK3
         f41qLNCGTuJMK3IBtLAzRcUTNGobmgYmhR9CN2qf76LDHfVAY2PDP4Pu+2/ZlpmPs28t
         wmZw==
X-Gm-Message-State: AOJu0Yw5123eGwSOuRhiZCROg1cf8LOXLVcvJUa1sYiIjV+3OG+XUBuk
	6ESyLzNVXM+WOzgPtWXBURHj3xkAOTnJQMTslD3vcsOuT1RbE3E+gtVcYngpSw==
X-Gm-Gg: ATEYQzw4+Y5BdtVhm4k5JMgkuoOw8DCxFkYs8Ekz/txa896nW4uYLjx6qW2+MALNpVp
	QHLJD7m4RKBe066Z8waw3YWGuRAVDaJXnS0fX02EkCN0SByLNW8qXlhJojatmUd4FnRH+PqLU9b
	Yr8QbgNdG5oGYe/Zs7KbcfdAwfDSlNt9oyS7JZ0v/ficnQRHRAlHP8LFPsrVI9lfot0e+ATaeFV
	79qThbCWQp+Ky1fFbQp0BPJKgFvj/lt5sv/eYGbaTfaT8F1z30wmKAr7Y7l+3ddNPfcFUVS+xsH
	6Y2gCNfnZGI9QUuEi8ANdxkzGzFitJTDqp1vmNXgXogBdMR59/V2a2YwDu3mCJ2VWreKplgi3rB
	DTzkvhJB+eWMVDk4HeeoF2WHDH9oNi/njVEKIBtd9G6xODwtKnN1HewXcRxYMYgTwKOCsB0gsLi
	LIWHv3+PQJNaW8IlDZ0iz7eUT5Yyj4+q4E1oapQXl33c9Ezq0Y2YgKzFD2ZnuctWZM
X-Received: by 2002:a05:6214:2261:b0:899:f2ba:9d7c with SMTP id 6a1803df08f44-89a30a2b06emr174367386d6.10.1773075473413;
        Mon, 09 Mar 2026 09:57:53 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57a4b079sm1704576d6.20.2026.03.09.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:57:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/4] auto-t: refactor testSAE-roam into connect/roam functions
Date: Mon,  9 Mar 2026 09:57:44 -0700
Message-Id: <20260309165746.2073055-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309165746.2073055-1-prestwoj@gmail.com>
References: <20260309165746.2073055-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes adding roaming tests easier if they don't strictly conform
to the existing test structure. By adding connect/roam helpers future
tests will have a bit more control on whats being tested.
---
 autotests/testSAE-roam/connection_test.py | 62 +++++++++--------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/autotests/testSAE-roam/connection_test.py b/autotests/testSAE-roam/connection_test.py
index 718bfd77..c813f00f 100644
--- a/autotests/testSAE-roam/connection_test.py
+++ b/autotests/testSAE-roam/connection_test.py
@@ -13,73 +13,61 @@ import testutil
 from config import ctx
 
 class Test(unittest.TestCase):
-    def validate_connection(self, wd, ft=True, check_used_pmksa=False):
-        device = wd.list_devices(1)[0]
-
+    def connect(self, wd, device, hapd):
         # This won't guarantee all BSS's are found, but at least ensures that
         # at least one will be.
         device.get_ordered_network('TestFT', full_scan=True)
 
-        self.assertFalse(self.bss_hostapd[0].list_sta())
-        self.assertFalse(self.bss_hostapd[1].list_sta())
+        self.assertFalse(hapd.list_sta())
 
-        device.connect_bssid(self.bss_hostapd[0].bssid)
+        device.connect_bssid(hapd.bssid)
 
         condition = 'obj.state == DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 
-        self.bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.address)
+        hapd.wait_for_event('AP-STA-CONNECTED %s' % device.address)
 
         self.assertFalse(self.bss_hostapd[1].list_sta())
 
         testutil.test_iface_operstate(device.name)
-        testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.name)
-        self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[1].ifname, device.name, True, True))
+        testutil.test_ifaces_connected(hapd.ifname, device.name)
 
-        # If PMKSA was used, hostapd should not include the sae_group key in
-        # its status for the station.
-        sta_status = self.bss_hostapd[0].sta_status(device.address)
-        if check_used_pmksa:
-            self.assertNotIn("sae_group", sta_status.keys())
-        else:
-            self.assertIn("sae_group", sta_status.keys())
+    def roam(self, wd, device, hapd_from, hapd_to):
+        device.roam(hapd_to.bssid)
 
-        device.roam(self.bss_hostapd[1].bssid)
-
-        # Check that iwd is on BSS 1 once out of roaming state and doesn't
+        # Check that iwd is on hapd_to once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         from_condition = 'obj.state == DeviceState.roaming'
         to_condition = 'obj.state == DeviceState.connected'
         wd.wait_for_object_change(device, from_condition, to_condition)
 
-        self.bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.address)
+        hapd_to.wait_for_event('AP-STA-CONNECTED %s' % device.address)
 
         testutil.test_iface_operstate(device.name)
-        testutil.test_ifaces_connected(self.bss_hostapd[1].ifname, device.name)
+        testutil.test_ifaces_connected(hapd_to.ifname, device.name)
         self.assertRaises(Exception, testutil.test_ifaces_connected,
-                          (self.bss_hostapd[0].ifname, device.name, True, True))
+                          (hapd_from.ifname, device.name, True, True))
 
-        if not ft:
-                return
 
-        device.roam(self.bss_hostapd[2].bssid)
+    def validate_connection(self, wd, ft=True, check_used_pmksa=False):
+        device = wd.list_devices(1)[0]
 
-        condition = 'obj.state == DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
+        self.connect(wd, device, self.bss_hostapd[0])
 
-        condition = 'obj.state != DeviceState.roaming'
-        wd.wait_for_object_condition(device, condition)
+        # If PMKSA was used, hostapd should not include the sae_group key in
+        # its status for the station.
+        sta_status = self.bss_hostapd[0].sta_status(device.address)
+        if check_used_pmksa:
+            self.assertNotIn("sae_group", sta_status.keys())
+        else:
+            self.assertIn("sae_group", sta_status.keys())
 
-        condition = 'obj.state == DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
+        self.roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[1])
 
-        self.bss_hostapd[2].wait_for_event('AP-STA-CONNECTED %s' % device.address)
+        if not ft:
+            return
 
-        testutil.test_iface_operstate(device.name)
-        testutil.test_ifaces_connected(self.bss_hostapd[2].ifname, device.name)
-        self.assertRaises(Exception, testutil.test_ifaces_connected,
-                            (self.bss_hostapd[1].ifname, device.name, True, True))
+        self.roam(wd, device, self.bss_hostapd[1], self.bss_hostapd[2])
 
     def test_ft_roam_success(self):
         wd = IWD(True)
-- 
2.34.1

