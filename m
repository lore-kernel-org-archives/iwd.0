Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924093321A7
	for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253708; cv=none; b=SwwUYln5SCSAQBlrBK6bHseM8M939lTHQUXJFkwqLtQ9NLNuHSxFfshikh1ZbgZqX9+SR5nVxzz9FR7tGle191QdwULqrkx4wwMr4kKe4KwztkqXdr1emwi0vvC5KwaInlSv+K5Oz2al2cYY3jVaTBvdixrcN5N79NaMmnM2G94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253708; c=relaxed/simple;
	bh=m3bviwwPGBWEdJx14W8bJJ0tlRze8clrOo7bc+beIrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJeVp1Wo1/EYA8BJIvQqng4cERLGXOyQUZtQTC/bYMNGXYgA7zIXQ+qCUzl0UlDPKBSAjG2B0fg5CfW2xH1zK6Pd/QN4qHWFO64q1ff1NgGvhHJsIO55wGWO6AvMQ8YyEoMU0XvOG2f6ikAbJWknyCf6wP50mm2HMmSsuJfSwzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFdxbqTe; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFdxbqTe"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c8dbf4f38so35210591fa.3
        for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 08:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253705; x=1785858505; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e6O0usYfx74OBPETPs/Da8oXCUVp6EEkzuKls32TT6I=;
        b=FFdxbqTeC91HSZ3NYkMp3gr7u9RH2UjloH/7juVyhZMSV6/Luo/E5kBHU89Hd1Z32c
         E0xiH6wGc+QGHjw0G0OzsLdRCgA7vTDhQ/rRpqBvNJtN17jIp5BAs4NbAhZSL7I9gyCi
         5bgHCKKX/AFRNRyGK1YY04XGmmeDTo7scmDjzKX+xcxlYecwlYVAOMEQYa+dz3JbAptN
         vod+1RSkIZykUyeIE5B0b538asaUtujvO9+us93Kl0mBygmRqaypZXt8LswQru0dIHYP
         +G9irG5DYqi2YN2MUoWY/Waq/9DFiUi0JNF27Ve02UmsKXFjUbnwtN5GGR1SMd+Kmt9V
         K8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253705; x=1785858505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e6O0usYfx74OBPETPs/Da8oXCUVp6EEkzuKls32TT6I=;
        b=OytIU8qMRXKJDwa7tBGPWrYyfpwYeEUsYVaJtAk0o+mCLYZboWY7JZn5lH/JymtPwJ
         NOkZ2NWui1oAPyTL4jS/rBFMFkCHpA8DhIXOCXFUuDRAdumYfxNa0L6UM2i7/aZ6URuZ
         jsA468SuC/fpeSb8nPUhOcAa3fWGY+wWCQcogM7I8RVkeUPP9MsbbgX7M4Sg4LbpNSJ2
         nbbD7Vbk4D7AXTCaGnoErbyHYQM0PgCK+eFnoivW6KXQQT19FPhMWKh+m9Y4l85a8tpE
         fIuSbyRZ2FH9iva9UofySmiSUHvTH5waFrUTqQQVuOdfh8y7XPW0Ev5FdSO+KyifHZ+U
         CkZw==
X-Gm-Message-State: AOJu0Yys7w18B8nxIdbcziOtGS9TN31WtdDn9JPIJ0eBkv8Y+nwtv3kV
	mT/VEzvfU0Gf4H6YYchLLx4EttmQp+DcfZi3cU93E+0e2TatjnRD7yIfsQsmlXgvauF67Q==
X-Gm-Gg: AR+sD11ygllOzAjnCjuuTYTJCvBq1/aL2swiwVHSOXNY6BKdQof//JoxaaS0M/VUPtS
	KfEMqorDJhRlwEIA7rsia35swIa8NVK7XfaDQy+i7+FpkMFM4denE9novYGsWqI+E14oLM0CjkQ
	RHnV+Lbd2T+VujGP9Kk5HxOVoaMH5CN17Eyjy1LVXwzt3i/34e94fgv9br9qWfr3ctnCZ/szzzo
	s7Q7A38NLFExixzO3BRj7T0VtDbvLdwn6iEwnNqb9NM76eXFdmeEBNnT0HUYDys1wDLdGhbnJsX
	6+jtxTloMt44KluyUd4zDvNoseNhGg3S0qbL70e8maN952CHAIYnOE/X9PHbXpqH5UOhpvGu8R0
	fDS0DHBXJ3T8KRaIMmtfDZkcTHe+S3M5Pya2Wgzpa8ZONMI6x4yIUVMGJ3CLO7E5hmks40xJV5H
	NIWtHC3/U=
X-Received: by 2002:a2e:a9a0:0:b0:39d:560a:f87 with SMTP id 38308e7fff4ca-39f51ee580fmr5342431fa.36.1785253704449;
        Tue, 28 Jul 2026 08:48:24 -0700 (PDT)
Received: from ultra-pc (s3.2dsites.ru. [188.187.190.12])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f22187e5csm19807431fa.16.2026.07.28.08.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:48:23 -0700 (PDT)
From: Aleksman4o <aleksman4o@gmail.com>
To: iwd@lists.linux.dev
Cc: Aleks Man <aleksman4o@gmail.com>,
	prestwoj@gmail.com,
	denkenz@gmail.com
Subject: [PATCH v4 3/5] auto-t: test BasicServiceSet RSN property
Date: Tue, 28 Jul 2026 18:46:42 +0300
Message-ID: <20260728154729.3485557-4-aleksman4o@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154729.3485557-1-aleksman4o@gmail.com>
References: <cover.1784069194.git.aleksman4o@gmail.com> <f9cb0ba9-da64-48b1-a8a9-3fe5c463b568@gmail.com>
 <20260728154729.3485557-1-aleksman4o@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleks Man <aleksman4o@gmail.com>

Verify the exact D-Bus key management and cipher capabilities for
WPA2-PSK, SAE, and transition BSSes.
---
 .../testBasicServiceSetRSN/bss_rsn_test.py    | 70 +++++++++++++++++++
 autotests/testBasicServiceSetRSN/hw.conf      |  9 +++
 autotests/testBasicServiceSetRSN/ssidSAE.conf | 11 +++
 .../ssidTransition.conf                       | 12 ++++
 .../testBasicServiceSetRSN/ssidWPA2.conf      |  8 +++
 5 files changed, 110 insertions(+)
 create mode 100644 autotests/testBasicServiceSetRSN/bss_rsn_test.py
 create mode 100644 autotests/testBasicServiceSetRSN/hw.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidSAE.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidTransition.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidWPA2.conf

diff --git a/autotests/testBasicServiceSetRSN/bss_rsn_test.py b/autotests/testBasicServiceSetRSN/bss_rsn_test.py
new file mode 100644
index 00000000..20e0b62c
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/bss_rsn_test.py
@@ -0,0 +1,70 @@
+#! /usr/bin/python3
+
+import unittest
+import sys
+
+import dbus
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from hwsim import Hwsim
+from hostapd import HostapdCLI
+
+BSS_INTERFACE = 'net.connman.iwd.BasicServiceSet'
+
+
+class Test(unittest.TestCase):
+    def _get_rsn(self, device, ssid):
+        ordered_network = device.get_ordered_network(ssid, full_scan=True)
+        network = ordered_network.network_object
+        self.assertEqual(len(network.extended_service_set), 1)
+
+        path = network.extended_service_set[0]
+        proxy = self.wd._bus.get_object(iwd.IWD_SERVICE, path)
+        properties = dbus.Interface(proxy, iwd.DBUS_PROPERTIES)
+
+        return properties.GetAll(BSS_INTERFACE)['RSN']
+
+    def test_rsn(self):
+        device = self.wd.list_devices(1)[0]
+
+        rsn = self._get_rsn(device, 'ssidWPA2')
+        self.assertEqual(set(map(str, rsn['KeyMgmt'])), {'wpa-psk'})
+        self.assertEqual(set(map(str, rsn['Pairwise'])), {'ccmp'})
+        self.assertEqual(str(rsn['Group']), 'ccmp')
+
+        rsn = self._get_rsn(device, 'ssidSAE')
+        self.assertEqual(set(map(str, rsn['KeyMgmt'])), {'sae'})
+        self.assertEqual(set(map(str, rsn['Pairwise'])), {'ccmp'})
+        self.assertEqual(str(rsn['Group']), 'ccmp')
+
+        rsn = self._get_rsn(device, 'ssidTransition')
+        self.assertEqual(set(map(str, rsn['KeyMgmt'])),
+                         {'wpa-psk', 'sae'})
+        self.assertEqual(set(map(str, rsn['Pairwise'])), {'ccmp'})
+        self.assertEqual(str(rsn['Group']), 'ccmp')
+
+    def setUp(self):
+        self.wd = IWD(True)
+
+    def tearDown(self):
+        self.wd.stop()
+        self.wd = None
+
+    @classmethod
+    def setUpClass(cls):
+        Hwsim()
+        cls.hostapd = [
+            HostapdCLI(config='ssidWPA2.conf'),
+            HostapdCLI(config='ssidSAE.conf'),
+            HostapdCLI(config='ssidTransition.conf'),
+        ]
+
+    @classmethod
+    def tearDownClass(cls):
+        cls.hostapd = None
+
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
diff --git a/autotests/testBasicServiceSetRSN/hw.conf b/autotests/testBasicServiceSetRSN/hw.conf
new file mode 100644
index 00000000..a43062d9
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/hw.conf
@@ -0,0 +1,9 @@
+[SETUP]
+num_radios=4
+hwsim_medium=yes
+start_iwd=no
+
+[HOSTAPD]
+rad0=ssidWPA2.conf
+rad1=ssidSAE.conf
+rad2=ssidTransition.conf
diff --git a/autotests/testBasicServiceSetRSN/ssidSAE.conf b/autotests/testBasicServiceSetRSN/ssidSAE.conf
new file mode 100644
index 00000000..2ec9ae61
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/ssidSAE.conf
@@ -0,0 +1,11 @@
+hw_mode=g
+channel=2
+ssid=ssidSAE
+
+wpa=2
+wpa_key_mgmt=SAE
+wpa_pairwise=CCMP
+sae_password=secret123
+sae_groups=19
+ieee80211w=2
+sae_pwe=0
diff --git a/autotests/testBasicServiceSetRSN/ssidTransition.conf b/autotests/testBasicServiceSetRSN/ssidTransition.conf
new file mode 100644
index 00000000..00170772
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/ssidTransition.conf
@@ -0,0 +1,12 @@
+hw_mode=g
+channel=3
+ssid=ssidTransition
+
+wpa=2
+wpa_key_mgmt=WPA-PSK SAE
+wpa_pairwise=CCMP
+wpa_passphrase=secret123
+sae_password=secret123
+sae_groups=19
+ieee80211w=1
+sae_pwe=0
diff --git a/autotests/testBasicServiceSetRSN/ssidWPA2.conf b/autotests/testBasicServiceSetRSN/ssidWPA2.conf
new file mode 100644
index 00000000..d706142b
--- /dev/null
+++ b/autotests/testBasicServiceSetRSN/ssidWPA2.conf
@@ -0,0 +1,8 @@
+hw_mode=g
+channel=1
+ssid=ssidWPA2
+
+wpa=2
+wpa_key_mgmt=WPA-PSK
+wpa_pairwise=CCMP
+wpa_passphrase=secret123
-- 
2.55.0

