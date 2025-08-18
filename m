Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A59B23AB9C
	for <iwd@lists.linux.dev>; Mon, 18 Aug 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527452; cv=none; b=uuyFv0cy3QEy2wLu0zmAgK/8sJY0cmc45viN7DS/LggrpgWbQoIFL+zhIIsod3CvpuHcQcf5x/uNJXQ9tAMwOJu7EUd1Qcw6w69zhJLQRVD8iNlLQ2pdgACUtsnDq4dTtIDk06in7PPHClSw3GLkBwHR6v6GoWxA2sgSPNjU2oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527452; c=relaxed/simple;
	bh=mboWUDA+zvrbGxqGt0SRYna/Rm/nKM3DzQaqo/0R6Nw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CxXyWccbJLW/FMySgqIodSmFhGkKHN6FCiB4LYkzwRvHqlAZcHQaKgwnqL8Is9GWpeZXWlBwK704Sd+/bqJ/Tnc7RmDDBevDlnQGJPRDFqTD51BkUkEkcW7KwNXUfxG+HA+Ux4PC2yXPO6iTINPw1TRyiBHpr4fM7PkKsjguMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gz4MJ8/f; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gz4MJ8/f"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b28184a8b3so2160101cf.1
        for <iwd@lists.linux.dev>; Mon, 18 Aug 2025 07:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755527450; x=1756132250; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwekLZwr1/4RyZAu+VaE/klf2//gTYcLMwryfFF8aKE=;
        b=Gz4MJ8/fity9B6bqpYsivg2eKppUzx2lkkiON4L+PZKdD1X+gyWddHxAZODfqb4fh8
         s6ONi8giAAFVX27B/sgvdHolAj7972Wh8MGvQ1DZfw0HMO5hu6SSxo3vXfbeHpGblyhr
         E8GRZEaXqHn7c4zxNWTB3LFsuAXVa/bPwH8xpjdiBGcyY8+foTWF0EaGJ/YTQnHJp8X9
         qj78uzwNJgVK593ML3kzcG25gevH/Yvnhz8DMXL9gv3+7HgExnWaBnCQjJNzCqNr9eZt
         tIAb8fDnCqz9gX2EcbW//rmGPRgXZ3kAWJ34W4hxCLF+ADXFBO9XvBRmgyVqFl7DnDQq
         kUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527450; x=1756132250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwekLZwr1/4RyZAu+VaE/klf2//gTYcLMwryfFF8aKE=;
        b=ltXxsnC+PeI5EGXog2TYJn+9JwJnT2TkUoymqZXZcmREXfCOc91ZzBNaLD79gTFFkO
         rFkvaf3dCjvaYTit8xj8KJ8i0WDHjd9V16pA66a8pD6HV/JJB/ZFL7nrJ/R6o2Tx/OTA
         eAnTRyNnF9xYTAgRhm4XUfpGXD642NRYxQV313l2isN3CazQI0/fwxBXX4LdxMYrCiik
         1pPLIvPvaDhFQWBQcB4HgdXmpdcVrQbLAjXgSCGgS4wF5Jw4A+BdqIcc11CRofMMU1JC
         +1sqx6EeX5OabJsxD+xuIZRMkvKCaGbwH5Bm5lPNlcrPLxMKlwTxznNZO26emr1J70HT
         AoAA==
X-Gm-Message-State: AOJu0YxLHHcbMI5wkCDFghVfwaFeKIHXWrAYt2xpxogrgNj63VpoTrr1
	I9QC6NqKef5iSt2izkfomdxQeAFgpukWBXLKQX9wGC7Xvj0ZW4SyoWzPtbBEwA==
X-Gm-Gg: ASbGncviHx06bBGy/OGbyN8DpsGtyrtc+igXf9dnOsVM6FEOIVcYyjOEDu0SUVe4RDi
	QznyAN4HBR7+zKaFcgTgdn8mygebkSVCkrQ9Vd+Km/ezSmbbDYo8nV9HYH4jzd1+djh53aJds+X
	NZ2uegWiqnv+uOsCjan4Qsunj3f9twrIWB5AQ1WZKM2dBx9q1Nhs8OggvTSZogValEumPzw+dPB
	VNtNQMvlj4i1lX1zvBTzzT8ofu10787ffYC06dqtpoQ0l5bUhZG5DIrEhykmPry+uUiRfbx9ax9
	Xvrf0RW2pdE6J8ozEvQHnlcZiwGV+1LmLke+kxHhVRUjATCySYkyfMasewxV0DvioARTUvPJE7+
	Rfy963P/C2VgWwchPzl5l4S/hGMeO0ACUQe9+jV3G1WY=
X-Google-Smtp-Source: AGHT+IEVNnLQ2jmk65CTce9P//eRvAIQmDDRiRTyagNAErcaPZiz2Wexo6LbS4++siKVRx5l/ZJC5A==
X-Received: by 2002:a05:622a:a0f:b0:4aa:9393:7b5b with SMTP id d75a77b69052e-4b11e28044cmr182328521cf.41.1755527449421;
        Mon, 18 Aug 2025 07:30:49 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc5aeaasm52781531cf.19.2025.08.18.07.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:30:48 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] auto-t: add test for channel switch during roam
Date: Mon, 18 Aug 2025 07:30:41 -0700
Message-Id: <20250818143041.283887-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818143041.283887-1-prestwoj@gmail.com>
References: <20250818143041.283887-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In kernel 6.8 a new CMD_ASSOCIATE failure path was added which checks
if the AP has a channel switch in progress. Eariler patches update
IWD into handling this case better, and this new test exercises that.
---
 autotests/testPSK-roam/chan_switch_test.py | 114 +++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 autotests/testPSK-roam/chan_switch_test.py

diff --git a/autotests/testPSK-roam/chan_switch_test.py b/autotests/testPSK-roam/chan_switch_test.py
new file mode 100644
index 00000000..2e2154cf
--- /dev/null
+++ b/autotests/testPSK-roam/chan_switch_test.py
@@ -0,0 +1,114 @@
+#! /usr/bin/python3
+
+import unittest
+import sys, os
+
+sys.path.append('../util')
+from iwd import IWD
+from iwd import NetworkType
+from hostapd import HostapdCLI
+from packaging import version
+from subprocess import run
+import re
+import testutil
+
+#
+# The CSA handling was added in kernel 6.8, so for any earlier kernel this test
+# won't pass.
+#
+def kernel_is_newer(min_version="6.8"):
+    proc = run(["uname",  "-r"], capture_output=True)
+
+    version_str = proc.stdout.decode("utf-8")
+    match = re.match(r"(\d+\.\d+)", version_str)
+    if not match:
+        return False
+
+    return version.parse(match.group(1)) >= version.parse(min_version)
+
+class Test(unittest.TestCase):
+    def test_channel_switch_during_roam(self):
+        wd = self.wd
+
+        device = wd.list_devices(1)[0]
+
+        ordered_network = device.get_ordered_network('TestFT', full_scan=True)
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition = 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condition)
+
+        self.assertFalse(self.bss_hostapd[0].list_sta())
+        self.assertFalse(self.bss_hostapd[1].list_sta())
+
+        device.connect_bssid(self.bss_hostapd[0].bssid)
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        self.bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.address)
+
+        testutil.test_iface_operstate(device.name)
+        testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.name)
+        self.assertRaises(Exception, testutil.test_ifaces_connected,
+                          (self.bss_hostapd[1].ifname, device.name, True, True))
+
+        # Start a channel switch and wait for it to begin
+        self.bss_hostapd[1].chan_switch(6, wait=False)
+        self.bss_hostapd[1].wait_for_event("CTRL-EVENT-STARTED-CHANNEL-SWITCH")
+        # Initiate a roam immediately which should get rejected by the kernel
+        device.roam(self.bss_hostapd[1].bssid)
+
+        # IWD should authenticate, then proceed to association
+        device.wait_for_event("ft-authenticating")
+        device.wait_for_event("ft-roaming")
+
+        # The kernel should reject the association, which should trigger a
+        # disconnect
+        condition = 'obj.state == DeviceState.disconnected'
+        wd.wait_for_object_condition(device, condition)
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+
+    def tearDown(self):
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
+        os.system('ip link set "' + self.bss_hostapd[0].ifname + '" up')
+        os.system('ip link set "' + self.bss_hostapd[1].ifname + '" up')
+
+        for hapd in self.bss_hostapd:
+            hapd.default()
+
+        self.wd.stop()
+        self.wd = None
+
+    def setUp(self):
+        self.wd = IWD(True)
+
+    @classmethod
+    def setUpClass(cls):
+        if not kernel_is_newer():
+            raise unittest.SkipTest()
+
+        IWD.copy_to_storage('TestFT.psk')
+
+        cls.bss_hostapd = [ HostapdCLI(config='ft-psk-ccmp-1.conf'),
+                            HostapdCLI(config='ft-psk-ccmp-2.conf'),
+                            HostapdCLI(config='ft-psk-ccmp-3.conf') ]
+
+        unused = HostapdCLI(config='ft-psk-ccmp-3.conf')
+        unused.disable()
+
+        cls.bss_hostapd[0].set_address('12:00:00:00:00:01')
+        cls.bss_hostapd[1].set_address('12:00:00:00:00:02')
+        cls.bss_hostapd[2].set_address('12:00:00:00:00:03')
+
+        HostapdCLI.group_neighbors(*cls.bss_hostapd)
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+        cls.bss_hostapd = None
-- 
2.34.1

