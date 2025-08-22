Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32AF2D63F9
	for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892304; cv=none; b=nplD8vp5PHOq/dIUOdbeVUrqEQEuoW9mw8kphqndrJ+14IAbJHAlMZgByq3+dnFWQjZ7i86uFPu0PV1r9CQzYPPYIbkhCRWmtW+sLeil6iS358AoQJ/uCm1FULup+Ws6RzlBjqfKfJzHsLGpx6o082rRaqZkmeZCfcIhPuZwP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892304; c=relaxed/simple;
	bh=cRWwO/Ez+4bjwG463AvUIV5GFyVrbBF42+ECUIt3lYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kguPWGtDpI4Mp/X05hiYvrtBpEdhjZm54BXuIWHakUN8frM/4efuK+eltQVm4R6kDZWuGu1q1GjQgpLx7TEcEvp9fVgHj0zeui7x2GVOgQ1QnOSdpjQrfEFDjhplorzgPKZ83Z/umtFAuNIKS8L2u5hAD1+afGqkSKW7vjRCjlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNFtnjCm; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNFtnjCm"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b132f943a3so23552201cf.1
        for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892301; x=1756497101; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stpmzY2s10fEFKuU7JVSUYeZNk0MfzlXdWEVg1odV34=;
        b=aNFtnjCmRhAhW56aPeXFMBUkYumcSo6aILy3iiNnYVlNKJM69C2/acUZzxLDFnrOea
         OZQMk6gHQpJ4YcmUK1C+tAndJEu+PcZ8VO37JZbeTOxUvkSxpRtet1TzCRsSQd5gNQtI
         8MQcg70470wj8Jbu4g76U1oxXl3CzSCVs1P3pkei2qDPGY90yxO+fSTMZmsVzRD45tx5
         E88dXtzeVPpURWiaxzSFmQWIoGSkkCFfFbT5XFW7s8UuXxv5NvwxFOPXL8KeS3k/VjeK
         AMnzH3UkprSmK3rpdNHKkVS6qKGCM7J1d2wxHvYhtIo5nelMaouu79xNLxHHo55MTovT
         qZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892301; x=1756497101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stpmzY2s10fEFKuU7JVSUYeZNk0MfzlXdWEVg1odV34=;
        b=MjBdEEwOU6TMIKDjS68YFXkmmcUvAxoE3hgeKq9QczKljVlhybrAn0KXH1VzycrXcP
         /5zhVk18itj4mwkUHXWnIJ48feJrNcg+h/ZzO+8Y59JvvEaBv2J3jLv3Nxh6kXXy6cH9
         czG5TVy+LbV3BKChqUZiXK5XELgKyK5HwyQeTKuTdFz8SJZbJzKmOR/PByF/Gcb+L7aW
         X+IE8HVrRkukn8HpQfIFx4Sw5ktCKDeQXsloo7/Bhh2VIZHreTndbkYxSNzHuTXUiBIt
         XgKOFkkxojUGYJDljtVfgomeZtMiIYQ/GsVypehLFDCG3jBNtjNbsaD4h9Ha8rgWtpVm
         LPTA==
X-Gm-Message-State: AOJu0Yzzsr9nNMiQladdtSXe7vcIGTS/niwXcehTs1JwLXMUsafvwY9W
	plvH3i04dYwE5i33zXDQpz8Ki/DxfHKnGoWFuo6L+OJnGPAnBxwIZ+xrEy2R4g==
X-Gm-Gg: ASbGnctu6WMnHVmZN0RfVOys1NaAgUEareq0cT4+Jbq25fu9aedcCq29g6n94xyEqwU
	I6aoZAWnIZnvwPHa2LNTU7rPfCQEgdJLXuI7D2JvFU792J1Si2bAGdFmwozpjgQBSb8xMAX+Dt5
	CxyCwsQmByS0aXQLLJCqmWB1pLFTyCynX/hykGpbgLHIj7K4kfYsjzS6vZjYQPLkxTxUNUm+No/
	EpDoNatL1IPjiebszlMvXK7GKk0oKua0lJTyJzugsHwto/Da0OQkA8UncuzkVp4IhwKOG2CqwKT
	TfVChJIdEJcK5pMiMX7bECJ1U3uigSHa2iwuBZvZLuf3R0TXtmqY5Jhl+3NuU8dVyij9dhYTb/5
	a4QSqk0uFE9TP88fpA9vvgVmpBCOzh4As
X-Google-Smtp-Source: AGHT+IGZ7ju3IQKThZ6uOiyk12PG7cyN4N0K1j3df5bBeK6CNzhE2AP5fQKR8/WFVhe/xTojqpXpkA==
X-Received: by 2002:a05:622a:5e0d:b0:4af:1bc1:781e with SMTP id d75a77b69052e-4b2b692e05bmr18191851cf.0.1755892301243;
        Fri, 22 Aug 2025 12:51:41 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e45c4asm4913221cf.46.2025.08.22.12.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:51:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 15/15] auto-t: add AP roam test for bad neighbor reports/candidate lists
Date: Fri, 22 Aug 2025 12:51:18 -0700
Message-Id: <20250822195118.271122-15-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822195118.271122-1-prestwoj@gmail.com>
References: <20250822195118.271122-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 .../testAPRoam/bad_neighbor_report_test.py    | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 autotests/testAPRoam/bad_neighbor_report_test.py

diff --git a/autotests/testAPRoam/bad_neighbor_report_test.py b/autotests/testAPRoam/bad_neighbor_report_test.py
new file mode 100644
index 00000000..4bf3b63b
--- /dev/null
+++ b/autotests/testAPRoam/bad_neighbor_report_test.py
@@ -0,0 +1,133 @@
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

