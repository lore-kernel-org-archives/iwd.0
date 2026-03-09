Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5BC3DA7C6
	for <iwd@lists.linux.dev>; Mon,  9 Mar 2026 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070597; cv=none; b=cWqZTlxg6XVEB4tuqgs/S3kRgbcCg6g1aV7AFG8f8HIaASetddbHO8X9XkXASeq94yZFJM6ABHGvycgqyXc7lCPkqlVtf0pMQZrvI+C1+zNzgBpGqHmzZLM+WOYYljfq/M6/9Mdq/r+OYcehVjwfDdKvO7hP1dDvdM7REvYcff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070597; c=relaxed/simple;
	bh=IJWYjndnFpC5xnGpiKbjGewK3DfIZlXvSp5pbn+GJCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jw34PLu6jAcVwcKadMx2zA3+zLBQ5/TFFm+sSjQR0vhPDutDxV/ckjUiG6bYBgHZN6bRtkk2CZcy/rbrU0S/EQ/CtqOuLJXH7w4rG/y2PlPF1NTL07u3nV5CjRI/xnDiPlyn+d6r01Yl2WN8wTagXxxkcKArKK+F0q7gt6iZuA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjRL+Rs5; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjRL+Rs5"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899e87b04d8so146468866d6.3
        for <iwd@lists.linux.dev>; Mon, 09 Mar 2026 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773070595; x=1773675395; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAir6ICMzOQe+c8trwfnfdNCYgeTK9hOaTEI2J6X9TM=;
        b=LjRL+Rs5smEyZeJ72AOiMYx8svbUSZ8qw9wpcAdWzH9UoXQIHRcQDpcpibUTQ+o4ek
         ILXyt4wpzzYnqYIB5wVLt7dw84qBvPXr3TkQImjz1Z4GY/qX8/3QNK9R157SE7c8SBe7
         bURhEePixtkWSHOeVI0iZ5+QvWPsthd9Ol9cBoDM+4qDuUlwY6qRzJCUU/8dWtDPnM4Y
         xWaxJ1g/r9NNle5PtFN5UA+OpmatR0op0wUSQYzxfoqdd9L8A0zTBkCUrokdS6aayWYv
         jTVuCJ+ge6XySY2K8hfmUOFn5Tq/4v2cx7ZZrpKzu/DL2l/Jutm038QEmkI/aT5PTC2a
         tPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070595; x=1773675395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAir6ICMzOQe+c8trwfnfdNCYgeTK9hOaTEI2J6X9TM=;
        b=UkxshLlhXll2YweOBn09KmS8rKSKDVN721gTjfLbNi9MchUleQd0m2X4pn60StocsR
         n3GNvm5BJ6oGuXyOTruTLZ7KQys4zDsIxuvPp86WWKRAMXAghkrZDbUmEd05tLH3Lzcd
         r2/ROiKSw2s4vaWGgi4Nl/pes635zpuH1QzDlAJgUiW67PrWOBroebRVP6h0+wr/gXJR
         DpK4VqwUm0oJc2MANK5A5I5BLXxwbdK/doqind7evTRa6EwkEfSwqe9CFjvWp430B+AX
         hi9bxnHvO+/tR9tbDPil9gzWodKHgZS7cL4kNiwBndHWnpoQLxbazlsF9C2Rd8d/2BBo
         /T5g==
X-Gm-Message-State: AOJu0YzF2XSrecHOPVTnP+G/58bRDvKbiUvCM6sp3nS1mW2C9kiqGZUr
	0gApuUFmLEXVvDnArAJhjEcHQESYGJw1kD7UgXbwfBFtOWyY/Pg6IBW+RcMg+w==
X-Gm-Gg: ATEYQzyeB1oS/LuRW42iOLRhbTTl9jvvZO872uazqbd1jMof8+cBizHl+Q7snZ29u1l
	6VpqSCe4OCjy/cXFmoM9c1cD61bGhh9XzJO1OB4lLB2L5umEHhQ85N1y5LqKcRSN1cex9a6KnSK
	ysdwgNpi7RU/4DcJX/aVlW9lQDkMlUmnxQCFqhwYk7TQCYu3aAxyd8I32xDvca6dffj6QzqMlya
	XHiMs8OHheknzuCTay77Jtv94MdLaP34VTSTHQ9n8/2U1jg10v+ItzCPcz1R1fjr9Yte5Fbzn50
	CCUhCu1pcFOsZ2CgGwwIfKUkjXj5CjrZeVizDHNqlkR2AfXgvi+lVWN8OVpqV8poHfhrXxYHdUD
	BKMpYEFs4+EUXsf5yMUCXip/yOHboy/hflYIo9qUgzQ5CKLW9a9ahT9R5IyxHlAKaytCXCIEZfi
	ZuLDPHsjmhmnM5dRWPl92h+jAHvsHIQfXT/SjlMc6tARyET/JSmDupzKUL5mJI2CeS
X-Received: by 2002:a05:6214:5292:b0:899:fa7f:7155 with SMTP id 6a1803df08f44-89a30a2f357mr171529646d6.5.1773070595106;
        Mon, 09 Mar 2026 08:36:35 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c21650sm151716d6.39.2026.03.09.08.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:36:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] auto-t: refactor testSAE-roam into connect/roam functions
Date: Mon,  9 Mar 2026 08:36:27 -0700
Message-Id: <20260309153629.2012710-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309153629.2012710-1-prestwoj@gmail.com>
References: <20260309153629.2012710-1-prestwoj@gmail.com>
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

