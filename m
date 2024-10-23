Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071521D043F
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704195; cv=none; b=mVAJlUWkao/yVrprKRPCqmcGNE3edUh0Ur9WUXo2ny+lUDWs42nQNrcS33kLzsKTOQfcLSnHRaEG09FZtPPyggG0o/dDjqwmsLSbSCXvfQFRI6xLPHGvzDzJ09W6O6TiwGQ9lMlIi12kaHEQcs8K4lIqBp2aD/zu2zp+uMZTfkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704195; c=relaxed/simple;
	bh=NpeRjzndCNRsacZyfxijkggR7qWgKwLo1+H6PAtbo7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OrbQOvuJBhaf6/kSxJlFB9d5l+GJfY62nL6P5MNYEyg7do4UwEh+QLk/Tx8CB+loE6uF3EvBmU8ftZpjkhM5wNlqQ1VKPg/uymkYzC/FO1QN7WEvgNlDK07aCHnWyvxTV0fGzsArfHlZEnjiUKVuWBn0FVsfzhNk3W8oURIdXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiFFaPzW; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiFFaPzW"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db238d07b3so7869a12.2
        for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729704193; x=1730308993; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hRnfiOV1eVShqlKq7FIoA/iABA9JXFy42N4zJaQbbo=;
        b=ZiFFaPzWGzaFzv58G1sO3oz5alvrlk6liw7meUI1pD/eE2y654ip5rNHMRmE7d+y3A
         bucco1XtInMHS1btdVnDJ1TNjBguQfLVJlp4Gn7tWjcjxyFbLn1lTqCTE7evResGyMiQ
         mg5ChaIBRAmSwbLQ2jYNtLSTWrqCPcwkBPJBnpPacOwbmxYcMImqeZOKGn/socEfbtPR
         AaHwTCsfqEgaifHazayTsaN2xucDb0GlZI2TUSASdEME/X7CDDRcyYDxAmTi7M9d3peL
         q610d1QNR+1qmW2ODWArI2fwES8yNzXe/2Nn6gkB4s4OOK72xSwKGsmN3/mDdczDbtrd
         +7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704193; x=1730308993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hRnfiOV1eVShqlKq7FIoA/iABA9JXFy42N4zJaQbbo=;
        b=HzZGJ1kDYc/A9hoiCvRsb6MUvByurhy7V+RIz5n5BlJmEKevL0uG1pM73az5Zv1YvH
         bcw7Wc/nrfAGSojpm/rWehwK+hEneDBYPRc8qbs3yADeI4bfzInTRnuAop61sdMl4zz0
         1OoURfDKF9oLFt1EG2w5FTJp1ixxfN9UM9iUfDd7QNRI3IHvNFcIlwjJJvznIjj0mKCr
         XAJLwLD29CavzSX9Bs4ypMvwMtzkIKo1zOP4Irle4XAfTcNn75jozkaWYmw8fah1Kb4q
         1qyiukHatDEdVWMEyX9EECQdEkMbJ/mF/3XL8XV5Jc81L+i5H8pJTo0BLd20KiakLrov
         porw==
X-Gm-Message-State: AOJu0YzgKs/+xH7eKdbuXqnZR8Wfod352dKl+Vp5+cjfXF60P4Kd05QG
	Cd3QVK2Hg1Fgp0otWAh1sLG09wmkmzlAQxOWFW1WedInFcj6aNQ2KitJky9U
X-Google-Smtp-Source: AGHT+IFIBmuuHKyZUqlSCWTb6lbtt+NpnMdlBA5JER47f8DckM6gewQ7nLl9RiF98LCZ1JP8LabZYg==
X-Received: by 2002:a05:6a21:a4c1:b0:1d9:239b:a125 with SMTP id adf61e73a8af0-1d978b1a121mr3925952637.15.1729704192983;
        Wed, 23 Oct 2024 10:23:12 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1407ed7sm6551923b3a.214.2024.10.23.10.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:23:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] auto-t: add test for the new OweDisable driver quirk
Date: Wed, 23 Oct 2024 10:22:57 -0700
Message-Id: <20241023172257.112771-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023172257.112771-1-prestwoj@gmail.com>
References: <20241023172257.112771-1-prestwoj@gmail.com>
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

