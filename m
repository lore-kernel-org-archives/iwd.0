Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E9383BB
	for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226464; cv=none; b=AaVFt75KimVa9E4O4gEufYhjeZakPYyK80uF+tfgQPDYVLndTifILfTudfjUi2akmi95KboidYR5eCZZ6bZhlEJOpNMyGHfXI3xgMmztQ9SJZ1Zj+DKo0yqFMauG9L8OmHO3mFdInkwrq6/igeXFXAkMHHqBFQGPtXhJhJkPSCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226464; c=relaxed/simple;
	bh=h+bX4uGDutM1ahDxTS9DW1x27pFEZGjaq+PUwrVQmpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wm1QGio8cj+O5UPo0A09yhm2JIS5XUyKVZKUsZ+FGg6nv/9dAYGWjtz8RMdMVy5k/cO1mUrkxC/cqHC9RjuWdDwTbnl23EuykjXjoSxPCOD494bbOz3ERny9nFRu4Ktkt5uUZYzPWPWFhTbpqt8V7aZd9ZONtWg0JPy7WgWj6y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K65Fmppt; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K65Fmppt"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-787a8430006so75961285a.3
        for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 09:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709226461; x=1709831261; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6EMShpKJ/FoFa0YaCkbQ7zfmuuUiOmt9NCtAM7SPes=;
        b=K65FmpptUGdm0bmo+xQv531kDb5TQSLiOYy7Vtgl4jLbPPccOTES3FH38Ave4IXcfd
         xNJhw7hs15/7GKXwGEFIlyQ3qN9fnoBO0TTGKx5q4W4CsI4OXKO+hStOw8HZofM+HxBJ
         068IO3Q5s2skchnPQUEDVqrvJIM1w3eUxBBXWXptjt9eGx9Od359yfeyB/eJd35ZoEF6
         CXim1exyUL04nK9KWvrrSWH1smUQhyiay6gm4Kbmwuy4fVir71goczKPjizMDGpwXbBk
         wXORawoTDq5ixawBA5SKF013ug5CY0ALOB7+PpvbnzsOneeieAZz87tij0lfXY/3vf0d
         eFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226461; x=1709831261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6EMShpKJ/FoFa0YaCkbQ7zfmuuUiOmt9NCtAM7SPes=;
        b=HU9cpZcJVnEa2VxLudT98Gy/BSAOgu34/aAbYOWig7xec77OxrvjoiB/UnGA43ztSM
         maeAyhq+6CWbMhqOzP3V/vZN5y0fO3NsOfT6wySxFUBuw1PFRSkEJNbCN+hm0jlK+goP
         HuOsvMcOCwmxMzRz8zF/AwYUorx3OQH5FoTiryVaWvbIIIjKD84Z8foAwlie3nEcUEar
         svfvD8UKwgSFRvDJmNV+BeWs7DEgS41fdaM/QCdq5FKEzEXnBEgzoH/cZvDaDDMWAneb
         0C2bq8qGgzKW/CXNIO8r/pKj+nRNuf5zxzDSZp5K/naKTGMRv7nadPZ5aWx6TYPUlgwd
         b8Tg==
X-Gm-Message-State: AOJu0YwgCOy/2RD/dFQT7NwQ0hvxTy2Blmo6Url++UVvUfPO6AIvhZqS
	9BkzbmkfteOV3UFQcbnYUnbuKRcP+xHjrOyvY9dX0jZjXonAqivnCxtXwZLT
X-Google-Smtp-Source: AGHT+IEjoo6tzZ80FkwGAyj5736gpsk3qjvfRslcZ7e/5IUIy39RALEvl6W85sGxfqUe3I3WfH2QEg==
X-Received: by 2002:a05:620a:1367:b0:787:e5e8:84d0 with SMTP id d7-20020a05620a136700b00787e5e884d0mr2730677qkl.36.1709226461472;
        Thu, 29 Feb 2024 09:07:41 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id pj36-20020a05620a1da400b00787fd080d28sm697415qkn.74.2024.02.29.09.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:07:40 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>,
	Alex Radocea <alex@supernetworks.org>
Subject: [PATCH 2/5] auto-t: Add frame fuzzing test
Date: Thu, 29 Feb 2024 09:07:31 -0800
Message-Id: <20240229170734.1498918-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229170734.1498918-1-prestwoj@gmail.com>
References: <20240229170734.1498918-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to validate a crash found by Alex Radocea when sending
a fuzzed beacon frame.

Co-authored-by: Alex Radocea <alex@supernetworks.org>
---
 autotests/testFrameFuzzing/fake_ap.py         | 72 +++++++++++++++++++
 autotests/testFrameFuzzing/hw.conf            |  7 ++
 .../testFrameFuzzing/test_frame_fuzzing.py    | 37 ++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 autotests/testFrameFuzzing/fake_ap.py
 create mode 100644 autotests/testFrameFuzzing/hw.conf
 create mode 100644 autotests/testFrameFuzzing/test_frame_fuzzing.py

diff --git a/autotests/testFrameFuzzing/fake_ap.py b/autotests/testFrameFuzzing/fake_ap.py
new file mode 100644
index 00000000..8ee369de
--- /dev/null
+++ b/autotests/testFrameFuzzing/fake_ap.py
@@ -0,0 +1,72 @@
+import unittest
+import sys
+import sys
+import os
+from scapy.layers.dot11 import *
+from scapy.arch import str2mac, get_if_raw_hwaddr
+from time import time, sleep
+from threading import Thread
+
+def if_hwaddr(iff):
+    return str2mac(get_if_raw_hwaddr(iff)[1])
+
+def config_mon(iface, channel):
+  """set the interface in monitor mode and then change channel using iw"""
+  os.system("ip link set dev %s down" % iface)
+  os.system("iw dev %s set type monitor" % iface)
+  os.system("ip link set dev %s up" % iface)
+  os.system("iw dev %s set channel %d" % (iface, channel))
+
+class AP:
+    def __init__(self, ssid, psk, mac=None, mode="stdio", iface="wlan0", channel=1):
+        self.channel = channel
+        self.iface = iface
+        self.mode = mode
+        if self.mode == "iface":
+            if not mac:
+              mac = if_hwaddr(iface)
+            config_mon(iface, channel)
+        if not mac:
+          raise Exception("Need a mac")
+        else:
+          self.mac = mac
+        self.boottime = time()
+
+    def get_radiotap_header(self):
+        return RadioTap()
+
+    def dot11_beacon(self, contents):
+        evil_packet = (
+            self.get_radiotap_header()
+            / Dot11(
+                subtype=8, addr1="ff:ff:ff:ff:ff:ff", addr2=self.mac, addr3=self.mac
+            )
+            / Dot11Beacon(cap=0x3101)
+            / contents
+        )
+        self.sendp(evil_packet)
+
+    def run(self, contents):
+        interval = 0.05
+        num_beacons = 100
+
+        while num_beacons:
+            self.dot11_beacon(contents)
+            sleep(interval)
+            num_beacons -= 1
+
+    def start(self, contents):
+       self.thread = Thread(target=self.run, args=(contents,))
+       self.thread.start()
+
+    def stop(self):
+       self.thread.join()
+
+    def sendp(self, packet, verbose=False):
+        if self.mode == "stdio":
+            x = packet.build()
+            sys.stdout.buffer.write(struct.pack("<L", len(x)) + x)
+            sys.stdout.buffer.flush()
+            return
+        assert self.mode == "iface"
+        sendp(packet, iface=self.iface, verbose=False)
diff --git a/autotests/testFrameFuzzing/hw.conf b/autotests/testFrameFuzzing/hw.conf
new file mode 100644
index 00000000..0500b51d
--- /dev/null
+++ b/autotests/testFrameFuzzing/hw.conf
@@ -0,0 +1,7 @@
+[SETUP]
+num_radios=2
+start_iwd=0
+hwsim_medium=yes
+
+[rad1]
+reserve=true
diff --git a/autotests/testFrameFuzzing/test_frame_fuzzing.py b/autotests/testFrameFuzzing/test_frame_fuzzing.py
new file mode 100644
index 00000000..9def7684
--- /dev/null
+++ b/autotests/testFrameFuzzing/test_frame_fuzzing.py
@@ -0,0 +1,37 @@
+#! /usr/bin/python3
+
+import unittest
+import sys
+import sys
+import os
+from fake_ap import AP
+
+sys.path.append('../util')
+from iwd import IWD
+
+# Probe frame that causes IWD to crash
+beacon=b'\xdd\nPo\x9a\t\x0e\x00\x00\x19\x10\x00\xdd/Po\x9a\t\x0c\x02\x00\x00\xdd\x05\x03\x03\x03Po\x9a\x10\x00\x0b\x05\x0e\x00\x00\x00\x00\x0b\x05\x00\x00\x00\xdd\x05\x00\x03\x03\x03\x03\x00\x00\x00\xdd\x05\x03\x03\x03\x03\x03'
+
+class Test(unittest.TestCase):
+    def test_beacon_crash(self):
+        wd = IWD(True)
+
+        devs = wd.list_devices()
+
+        self.assertEqual(len(devs), 1)
+
+        devs[0].autoconnect = True
+
+        os.system("iw phy rad1 interface add wlan1 type managed")
+
+        ap = AP("evilAP", "password1234", mode="iface", iface="wlan1", channel=4)
+        ap.start(beacon)
+
+        condition = "obj.scanning == True"
+        wd.wait_for_object_condition(devs[0], condition)
+
+        condition = "obj.scanning == False"
+        wd.wait_for_object_condition(devs[0], condition)
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
-- 
2.34.1

