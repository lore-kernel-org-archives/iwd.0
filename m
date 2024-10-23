Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11EF1D0E2B
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708166; cv=none; b=LWzJwc2GPRUFk3qPLr+1Uxqpqv8LJM+ie2JTx4SwYSK2QiH0B9aiXrRBZOl1+5GNeV9t/3/wLcBlg7m7X6nK3GEsI2/pI2qC1z2EI04f6hlzPTZl43ISER5kycpN2wt5bysrKNzXU9QrQ/oW0+qHzlNvj1PFc69IpxQ3I6uIDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708166; c=relaxed/simple;
	bh=NpeRjzndCNRsacZyfxijkggR7qWgKwLo1+H6PAtbo7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JDkhqNNKinSWctOyqKBW2PedH7805/tX11SIMlwAfWCW1qNMl3nPDmCFDLihF81THsBYBLs3Zx1H9VQfyZQAFJpwwL6M58MUyX2UhuXSGgqcnoZkRnvyZ7KiV66Br7FLhQJjqnXy4bP0hhJz4Z9hVnP2u7xkxCjYAmPbCIUT5fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjhjkgAA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjhjkgAA"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e6cec7227so110931b3a.0
        for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729708164; x=1730312964; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hRnfiOV1eVShqlKq7FIoA/iABA9JXFy42N4zJaQbbo=;
        b=WjhjkgAAEvBPMpZ7oeN13Uu5zY92dGLDhQzT2hd1VXOy5e6DGDdYAXlBJQ5Y1NOmWB
         6LH6BuPotZuxO/uHWZoVwFq/Y2qZxkQdr0/hQ6CwWDv5e2105UFD1pxFLAiyqS8VzD3F
         mi/sPmT9iExjX9dla1WOO7s3o9kKtQ5fCBxC8fYafj+4lQ2XSVchpzIml+7gF1SPok8S
         SblmN6NkrQsoGjwryNjhHaaaZpmv8DcbKSvEvoO92GgjPkixPepK/tvpK6d8joxzAL+t
         KSQxp4QmrsjQNq4bv+s8kmKufdSVljIgfh6NJH4Hkjm2wRw4Csjf+QW9kpJu5k37biEm
         w3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729708164; x=1730312964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hRnfiOV1eVShqlKq7FIoA/iABA9JXFy42N4zJaQbbo=;
        b=a74tnFywjhTFsFDv1l2Uwx9Lc/OwKSrYWQX7NVviRpOBCl8cc1rGyJY5fvZB2BfhgR
         FJktG5tJ7g7iYvyaj0HBFIMMvpkWzSdv90jBPf2A7PuHS1YQGp35B84M7sqbUC/z1A5z
         17bNxhHVOjo0iFnJbK34ooo/+rB14366xNn1w9UZ5ufF7RMLsudXdPkpZt+dz1pPiwKF
         AUu9MajDvnpRI9BuOuK37AgqcxBSimICk2MW0HV2n2AFMQ0qIUTYiHZ/g1QKYPszn8Ig
         fBkDG70rES4kHsBmpgqNvCNc388XBUPP2+kwmqJVuMohaB5eaKQz2tIJlCLvdC2sJCGv
         nzjQ==
X-Gm-Message-State: AOJu0Yy0WaWsefprQ4JD81i7ZYynOqP46DFZaGH6TT1NHGrDDuOCuCkw
	ly3d8RjbK15hWLzUPNQ6hfWkA8XN8iAE/D0DrbCXIXVVyROWJYJbcaYpcy+6
X-Google-Smtp-Source: AGHT+IEQancsDBv5RSVB1vKQnB/M+UvodXi0CNsJw/MlC1wuIwub5LfUmR5qdMPhTu4GK/BiON03bg==
X-Received: by 2002:aa7:88cb:0:b0:71e:1722:d02c with SMTP id d2e1a72fcca58-72030a79c21mr4997211b3a.3.1729708163967;
        Wed, 23 Oct 2024 11:29:23 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabc11a7sm7024871a12.60.2024.10.23.11.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:29:23 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] auto-t: add test for the new OweDisable driver quirk
Date: Wed, 23 Oct 2024 11:29:12 -0700
Message-Id: <20241023182912.128388-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023182912.128388-1-prestwoj@gmail.com>
References: <20241023182912.128388-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests that when OWE is disabled IWD will still connect to the legacy
open network.
---
 autotests/testOWE-disabled/connection_test.py | 51 +++++++++++++++++++
 autotests/testOWE-disabled/hw.conf            |  7 +++
 autotests/testOWE-disabled/main.conf          |  2 +
 autotests/testOWE-disabled/ssidOWE.conf       | 15 ++++++
 autotests/testOWE-disabled/ssidOpen.conf      |  9 ++++
 autotests/testOWE-disabled/transition.open    |  0
 6 files changed, 84 insertions(+)
 create mode 100644 autotests/testOWE-disabled/connection_test.py
 create mode 100644 autotests/testOWE-disabled/hw.conf
 create mode 100644 autotests/testOWE-disabled/main.conf
 create mode 100644 autotests/testOWE-disabled/ssidOWE.conf
 create mode 100644 autotests/testOWE-disabled/ssidOpen.conf
 create mode 100644 autotests/testOWE-disabled/transition.open

diff --git a/autotests/testOWE-disabled/connection_test.py b/autotests/testOWE-disabled/connection_test.py
new file mode 100644
index 00000000..849cb58a
--- /dev/null
+++ b/autotests/testOWE-disabled/connection_test.py
@@ -0,0 +1,51 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+from iwd import IWD, Network
+from hostapd import HostapdCLI
+import testutil
+
+class Test(unittest.TestCase):
+    def test_autoconnect_to_open(self):
+        IWD.copy_to_storage("transition.open")
+
+        wd = IWD(True)
+
+        devices = wd.list_devices(1)
+        device = devices[0]
+        device.autoconnect = True
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        testutil.test_iface_operstate()
+
+        network = Network(device.connected_network)
+
+        self.assertEqual(network.name, "transition")
+        self.assertIn(device.address, self.hapd.list_sta())
+
+        device.disconnect()
+
+    def setUp(self):
+        self.hapd = HostapdCLI(config="ssidOpen.conf")
+        pass
+
+    def tearDown(self):
+        IWD.clear_storage()
+
+        self.wd = None
+
+    @classmethod
+    def setUpClass(cls):
+        pass
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
diff --git a/autotests/testOWE-disabled/hw.conf b/autotests/testOWE-disabled/hw.conf
new file mode 100644
index 00000000..42b12d59
--- /dev/null
+++ b/autotests/testOWE-disabled/hw.conf
@@ -0,0 +1,7 @@
+[SETUP]
+num_radios=3
+start_iwd=0
+
+[HOSTAPD]
+rad0=ssidOpen.conf
+rad1=ssidOWE.conf
diff --git a/autotests/testOWE-disabled/main.conf b/autotests/testOWE-disabled/main.conf
new file mode 100644
index 00000000..2554c011
--- /dev/null
+++ b/autotests/testOWE-disabled/main.conf
@@ -0,0 +1,2 @@
+[DriverQuirks]
+OweDisable=mac80211_hwsim
\ No newline at end of file
diff --git a/autotests/testOWE-disabled/ssidOWE.conf b/autotests/testOWE-disabled/ssidOWE.conf
new file mode 100644
index 00000000..72809fa6
--- /dev/null
+++ b/autotests/testOWE-disabled/ssidOWE.conf
@@ -0,0 +1,15 @@
+ssid=owe-hidden
+bssid=02:00:00:00:f1:00
+channel=1
+ignore_broadcast_ssid=1
+ieee80211w=1
+
+wpa=2
+wpa_key_mgmt=OWE
+rsn_pairwise=CCMP
+vendor_elements=dd15506f9a1c02000000f0000a7472616e736974696f6e
+
+# You would conventionally use these options but hostapd does not include an
+# IE for the OWE network, hence vendor_elements must be used directly
+#owe_transition_ssid="transition"
+#owe_transition_bssid=02:00:00:00:f0:00
diff --git a/autotests/testOWE-disabled/ssidOpen.conf b/autotests/testOWE-disabled/ssidOpen.conf
new file mode 100644
index 00000000..096b52c4
--- /dev/null
+++ b/autotests/testOWE-disabled/ssidOpen.conf
@@ -0,0 +1,9 @@
+channel=1
+ssid=transition
+bssid=02:00:00:00:f0:00
+vendor_elements=dd15506f9a1c02000000f1000a6f77652d68696464656e
+
+# You would conventionally use these options but hostapd does not include an
+# IE for the OWE network, hence vendor_elements must be used directly
+#owe_transition_ssid="owe-hidden"
+#owe_transition_bssid=02:00:00:00:f1:00
diff --git a/autotests/testOWE-disabled/transition.open b/autotests/testOWE-disabled/transition.open
new file mode 100644
index 00000000..e69de29b
-- 
2.34.1

