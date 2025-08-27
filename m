Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2E34DCE8
	for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299318; cv=none; b=Y7L7DPXdK9ppiT9gRI7Jv1ynQ/DxGZvwTKNqDbtWZ+QsDweDKy83HvkCyMtG0WM2VTaKhHuhc1BE3GU6RhktQymabY5iHBxyu0/7O7WBzNcwrRmDfrgFTnPVkHSahom4Xsywec97kODDHLGd4QQ/g9S/SJn3CAX/mKwHjL8duj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299318; c=relaxed/simple;
	bh=KlDzZ3r2AZQqAMakGYUgLstHX3705nzlHFMMM99Bylw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sFeV8tddwMhw9gJZZvuHU5bGrleWJGW6auw4Fp2GqfPw2+OgaCpLA9uPB+DPKZb9RbxhCoiPciXpFyjDiMO/LauVrWvlh3jJkASGqxVzEeBX8omowKKWTv96HoRAH1oQ/nVFRpbrmyUMWUbuJsvwokKYeOfdZjiKc81gwiVarTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOPCAzLG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOPCAzLG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445806df50so52979965ad.1
        for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756299313; x=1756904113; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/0Jhm6loQKgRjcOwH2IDQxbnSWEEWn7F0PefyymLlA=;
        b=JOPCAzLGHzh/kAhgI6AK8X+Rh7qfHLx07yxQ5KHvYuTEt71J2V4AVXWGxpunvDgOdD
         BjyZtU6hSKOHotPjvnJm16rj+Wy1C3+AsstObzw840F2eCpxCwZGw5LGriUGpAusGhFg
         81CppbcSkG5LvUejq7xgVzh8qr6CcXEL/OgEwPz0RprhOQzLP/oeEq4FQ9Uk74/4CBkX
         DM6vh0flJQuHk8loYUUaHbxc24u1C8Zt9nJo+nWyrhnJJrR/TkaW4NMFDWvgLvb8FTQ/
         xYDSZDNbzCl/UEPeNOsFxuAfs66QqTtiqC7t/l9/UppSz59IudjlC2yaHUp+M+KQQOnZ
         Ezng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299313; x=1756904113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/0Jhm6loQKgRjcOwH2IDQxbnSWEEWn7F0PefyymLlA=;
        b=H4f3tJAzxPa8omZK84Bs2dTGU8dSbvEJtr+9PsgCGSiSMOYBzOWfxRHpr1TAujB3IC
         BikjfHMFXKMDrQ5+PyHla7VB+wyqObuN+q7dqXYf5U5Zv/ntCLAzXJZU7UNE2ZbudH5F
         +F0rish3T8k1vYCRt91KX+4sV7V/lneaznYa15tdQxbgiCWWyp3DPMJnlhbE0vZUW8+2
         v4zZE9DyE0RoLI31zgQtl2MmVQ3nhrUPdrHrQspS9Cu97yZEkcR7bNxA3G9L/dwnyZaR
         5woIzH3BhoB+OcjWukfGSSzQ8sw/LOE/MbuvaJj92YjsjkLXgOL8F5tm5N/bQuj1H2qR
         aSPg==
X-Gm-Message-State: AOJu0YxQrBW4S/7O98gqIk44eSDDGJM1Hw5rTHv1qupw5uZzdVuyxS/S
	LOtTDz+edOHkaD+4A0hIpQLy3DAelVL9LJhZHfDT5j+JI/heRN2GXBm14F+S8Q==
X-Gm-Gg: ASbGnctq5N8E3VECs4mYmMzsTHE1mkQ5Xo9B1TyUNe7NUn5CUJE86H612LjkFZNZa+g
	DQ1PyTgqgovzgPImxoSPx55La0L99bJU/fA0JDp1T/5CuSEBU79k0HjYaZelFLFtNDADvRRgaOi
	yH2jmVt6BUcfOq+ho6gNEjFr0jBVrYElhST1gVPh8+aDOn2UecHmYv0xVBIQz33OZQkAevXKfP+
	7BfTPfCe5Aedrcxard8FY4qO5uKjpXdZsVm1bTu34ris6BAZ/1M9XnQPL+Oxii5rITmW3T8Wvjk
	2UYmypppD7r27CF8iUJ5ixiY1pfyCDjfMxwpZi8p/VTePxv0yQhJNiqJhDozp4C8S5SLZ6L8JNr
	d5naaBEn9QVMjqHL1fxI2XGFUkX7q186Qd+mbAnQTRWU78jPLqVAJDQRQ9nDm/ImaDdLf6OACo0
	HuMHbD7N/f+e0mzYp7DJA=
X-Google-Smtp-Source: AGHT+IGrD+ha/fGOucYMPNWKARy8Z2j8xb+UfGYO+VuBUBIMpcerSaZhUXh/9fKuvhQ+Invk+Ng+5g==
X-Received: by 2002:a17:902:db0e:b0:246:edc9:3a80 with SMTP id d9443c01a7336-246edc93d95mr136510415ad.5.1756299313444;
        Wed, 27 Aug 2025 05:55:13 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687c75b5sm121650955ad.66.2025.08.27.05.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:55:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 10/11] auto-t: add AP roam test for bad neighbor reports/candidate lists
Date: Wed, 27 Aug 2025 05:55:00 -0700
Message-Id: <20250827125501.477908-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827125501.477908-1-prestwoj@gmail.com>
References: <20250827125501.477908-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 .../testAPRoam/bad_neighbor_report_test.py    | 156 ++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100644 autotests/testAPRoam/bad_neighbor_report_test.py

v2:
 * Added test that uses ignore BSS TM vendor quirk

diff --git a/autotests/testAPRoam/bad_neighbor_report_test.py b/autotests/testAPRoam/bad_neighbor_report_test.py
new file mode 100644
index 00000000..c1ec7e26
--- /dev/null
+++ b/autotests/testAPRoam/bad_neighbor_report_test.py
@@ -0,0 +1,156 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import NetworkType
+
+from hostapd import HostapdCLI
+
+class Test(unittest.TestCase):
+    def initial_connection(self):
+        ordered_network = self.device.get_ordered_network('TestAPRoam')
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition = 'not obj.connected'
+        self.wd.wait_for_object_condition(ordered_network.network_object, condition)
+
+        self.device.connect_bssid(self.bss_hostapd[0].bssid)
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device, condition)
+
+        self.bss_hostapd[0].wait_for_event('AP-STA-CONNECTED')
+
+        self.assertFalse(self.bss_hostapd[1].list_sta())
+
+    def test_full_scan(self):
+        """
+            Tests that IWD first tries a limited scan, then a full scan after
+            an AP directed roam. After the full scan yields no results IWD
+            should stop trying to roam.
+        """
+        self.initial_connection()
+
+        # Disable other APs, so the scans come up empty
+        self.bss_hostapd[1].disable()
+        self.bss_hostapd[2].disable()
+
+        # Send a bad candidate list with the BSS TM request which contains a
+        # channel with no AP operating on it.
+        self.bss_hostapd[0].send_bss_transition(
+            self.device.address,
+            [(self.bss_hostapd[1].bssid, "8f0000005105060603000000")]
+        )
+        self.device.wait_for_event("roam-scan-triggered")
+        self.device.wait_for_event("no-roam-candidates")
+        # IWD should then trigger a full scan
+        self.device.wait_for_event("full-roam-scan")
+        self.device.wait_for_event("no-roam-candidates", timeout=30)
+
+        # IWD should not trigger a roam again after the above 2 failures.
+        with self.assertRaises(TimeoutError):
+            self.device.wait_for_event("roam-scan-triggered", timeout=60)
+
+    def test_bad_candidate_list(self):
+        """
+            Tests behavior when the AP sends a candidate list but the scan
+            finds no BSS's. IWD should fall back to a full scan after.
+        """
+        self.initial_connection()
+
+        # Send a bad candidate list with the BSS TM request which contains a
+        # channel with no AP operating on it.
+        self.bss_hostapd[0].send_bss_transition(
+            self.device.address,
+            [(self.bss_hostapd[1].bssid, "8f0000005105060603000000")]
+        )
+        self.device.wait_for_event("roam-scan-triggered")
+        self.device.wait_for_event("no-roam-candidates")
+        # IWD should then trigger a full scan
+        self.device.wait_for_event("full-roam-scan")
+        self.device.wait_for_event("roaming", timeout=30)
+        self.device.wait_for_event("connected")
+
+    def test_bad_neighbor_report(self):
+        """
+            Tests behavior when the AP sends no candidate list. IWD should
+            request a neighbor report. If the limited scan yields no BSS's IWD
+            should fall back to a full scan.
+        """
+
+        # Set a bad neighbor (channel that no AP is on) to force the limited
+        # roam scan to fail
+        self.bss_hostapd[0].set_neighbor(
+            self.bss_hostapd[1].bssid,
+            "TestAPRoam",
+            '%s8f000000%s%s060603000000' % (self.bss_hostapd[1].bssid.replace(':', ''), "51", "0b")
+        )
+
+        self.initial_connection()
+
+        self.bss_hostapd[0].send_bss_transition(self.device.address, [])
+        self.device.wait_for_event("roam-scan-triggered")
+        # The AP will have sent a neighbor report with a single BSS but on
+        # channel 11 which no AP is on. This should result in a limited scan
+        # picking up no candidates.
+        self.device.wait_for_event("no-roam-candidates", timeout=30)
+        # IWD should then trigger a full scan
+        self.device.wait_for_event("full-roam-scan")
+        self.device.wait_for_event("roaming", timeout=30)
+        self.device.wait_for_event("connected")
+
+    def test_ignore_candidate_list_quirk(self):
+        """
+            Tests that IWD ignores the candidate list sent by the AP since its
+            OUI indicates it should be ignored.
+        """
+
+        # Set the OUI so the candidate list should be ignored
+        for hapd in self.bss_hostapd:
+            hapd.set_value('vendor_elements', 'dd0400180a01')
+
+        self.initial_connection()
+
+        # Send with a candidate list (should be ignored)
+        self.bss_hostapd[0].send_bss_transition(
+            self.device.address,
+            [(self.bss_hostapd[1].bssid, "8f0000005105060603000000")]
+        )
+        # IWD should ignore the list and trigger a full scan since we have not
+        # set any neighbors
+        self.device.wait_for_event("full-roam-scan")
+        self.device.wait_for_event("roaming", timeout=30)
+        self.device.wait_for_event("connected")
+
+    def setUp(self):
+        self.wd = IWD(True)
+
+        devices = self.wd.list_devices(1)
+        self.device = devices[0]
+
+    def tearDown(self):
+        self.wd = None
+        self.device = None
+
+        for hapd in self.bss_hostapd:
+            hapd.reload()
+
+    @classmethod
+    def setUpClass(cls):
+        IWD.copy_to_storage('TestAPRoam.psk')
+
+        cls.bss_hostapd = [ HostapdCLI(config='ssid1.conf'),
+                            HostapdCLI(config='ssid2.conf'),
+                            HostapdCLI(config='ssid3.conf') ]
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
-- 
2.34.1

