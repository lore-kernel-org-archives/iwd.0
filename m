Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4362A3F0771
	for <iwd@lists.linux.dev>; Thu, 19 Mar 2026 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943537; cv=none; b=EUMbHBby1MYMFpyynzFJmVsIQ1eWc6z7v8YYLf6VeReuItkd0D4c/JuuUazSEH0S6gi69LsPg+k9sW5zK8qfj49PS2JyBcGhEzGvbXl3b2vV+v5YYw3tvnyOSHfq72wYwVoK4bSSuY14ZWO8OSZmcR7CZyzM0Q6wUmu+ZU/X+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943537; c=relaxed/simple;
	bh=Z0oQkqdeqkp682C2EheEjb+RA93bazu+Mq+s2Y3CYjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rPu2gHHDMIf0JQeNyK32HgAE8S0LtSnlFkXoj2BhtXjlr7kn/exiZbZqA0dIh/M0IxugL0ab1KU3ot9YEiwI4cVahKe4EjONhD8sCcApJVWtamfcb5NIXZUQyWiX+w7hOL05S/oeQq9b6vwLJ7nFkk8B9WFD+4t5nzlVVVhVqwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0hLh3/L; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0hLh3/L"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-829ac8d56c5so912848b3a.3
        for <iwd@lists.linux.dev>; Thu, 19 Mar 2026 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773943535; x=1774548335; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+BzHiosC8MlQkNtan9G5RRGwQLBh4nCq5z9uZ/Hdpk=;
        b=P0hLh3/L6kcA/zsNHHDJbQLPYQAfV9pUOpktI5EHYeroAp6EANijLzxOoykuIC5Qi7
         WYMQ8qMAocokPazal57U5Qc2LEQ5AXu/GSYTjcImE6dx3rVhm/eLNFBE30U5WSvPAs+Y
         kqxyLCOmWQHQURDL+GtqtZ85E+vZ6BEbHQstzDyq7gECcnugWrt+ChCzNPgBwkSZBCx2
         um8zRyHDx6FJdCWlxaCF/j441/5swvaRRTDygASXgOFympJu0863lUMl8Q4F1Rt45yi0
         pGwgpcQb3f6j1H8XUWgoT5DrmFQsqF0m/qITqLWb3Z4Ow/aoFkJSY1R8g9DrVn3gILJC
         mdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773943535; x=1774548335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7+BzHiosC8MlQkNtan9G5RRGwQLBh4nCq5z9uZ/Hdpk=;
        b=cD8a+7asU5DksSHxdoAfwQhWdp8UUKPY2w1T/JQklVR6Kn0WSD1+Q3nNDqkc3FPnQS
         a9mHmqYVHdrSmhNuUyuLNrk9I5z1SE9y0boIghHkv6wfj0EXp0LG2FqcWVbNs4eIAV2B
         UOh+ils1BJ5fmgLOova9ucGeb6JB6KyS4VdDyP3E/JKq75NqsNBDNoZF0+r/J5kr7Y6R
         GP8LynoaoPtqynSfameohXVwHAi5AcXr0cco0OUsFf0VrsGkkqg6w3JdJWMUqMEHFMe7
         piJuknXrBU6Pw/n6D6MtVlfpRhdZ2xtCn6KPi6keYuAoEYX/3RKxgItU3ixzSaHRL79c
         epcg==
X-Gm-Message-State: AOJu0YzcCq0EfLHlYuKVbhAgchBHaNlrf3zIp3//Z2Nou/zPlejXITIl
	ZHN6GvN5Fed9FYlxJDtPugYMXegr5zBXzptfaEktMS0iy8YE6UYFaSvjbjP6hg==
X-Gm-Gg: ATEYQzwb2DG4EogA+MHMqwNhPfhYQ/PhJdJtGsgfkTaNBTOuasYulgrr+XkIxoWPMl2
	5NjBQFbaZcoW4z1bNth8nJqcPYWbxXxPJrYQCPn7SDrNrHRATRYgmVY4obRC2H4JeWT3mmpG/uy
	GwTlbeDlvDNNmYDy1l3n/ZCSmPVvAiqi/KpWvs5ajoZmLLlngoW2lIdrS/Vr4xzgymofGfbfvLS
	3PCn4IyIJYWzbf3C/jqhiu0eaWuAJvvhehL81CoPJmP1/7nAs/b7nZ/Y9ds/szIqswiwrBlJrZd
	B9glRjKtb+3rFmkKwy39eNOYD1jUw+ZbPpCR94rGJDa8aIMdSLut5vLR/VDQo5Ix6CrbUkR7aMm
	6n0KTR5fxMA90QcF14ibaEoJ5mcHgFGKkQjSnUn9DU9XTKjeavLGEbfAA5KZVA6kDIkNZ90yJ2S
	Jz6NLAjPVMMrjoaPuNJb41VtgaTg3CQZDUOuMpvzZRMUhp3tdwW/6vvzTvTJZqPTHr7JuEgI5QE
	AA=
X-Received: by 2002:a05:6a00:3e16:b0:81e:e09d:2687 with SMTP id d2e1a72fcca58-82a8c206f60mr185028b3a.1.1773943535277;
        Thu, 19 Mar 2026 11:05:35 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b541cafsm6699251b3a.12.2026.03.19.11.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:05:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] auto-t: add test for known network removal of a PMKSA network
Date: Thu, 19 Mar 2026 11:05:25 -0700
Message-Id: <20260319180525.136095-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319180525.136095-1-prestwoj@gmail.com>
References: <20260319180525.136095-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests that IWD cannot connect to the network once the profile has
been removed (after a PMKSA cache has been established).
---
 autotests/testPMKSA-SAE/connection_test.py | 32 +++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/autotests/testPMKSA-SAE/connection_test.py b/autotests/testPMKSA-SAE/connection_test.py
index 5bab3ff8..749ebd44 100644
--- a/autotests/testPMKSA-SAE/connection_test.py
+++ b/autotests/testPMKSA-SAE/connection_test.py
@@ -4,7 +4,7 @@ import unittest
 import sys
 
 sys.path.append('../util')
-from iwd import IWD
+from iwd import IWD, FailedEx
 from iwd import PSKAgent
 from iwd import NetworkType
 from hostapd import HostapdCLI
@@ -94,6 +94,36 @@ class Test(unittest.TestCase):
         self.hostapd.wait_for_event("AP-ENABLED")
         self.validate_connection(self.wd, "ssidSAE", self.hostapd, 19)
 
+    def test_pmksa_forget_network(self):
+        psk_agent = PSKAgent(["secret123", "wrong_password"])
+        self.wd.register_psk_agent(psk_agent)
+
+        devices = self.wd.list_devices(1)
+        self.assertIsNotNone(devices)
+        device = devices[0]
+
+        device.disconnect()
+
+        network = device.get_ordered_network("ssidSAE", full_scan=True)
+
+        self.assertEqual(network.type, NetworkType.psk)
+
+        network.network_object.connect()
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(device, condition)
+
+        self.wd.wait(2)
+
+        testutil.test_iface_operstate(intf=device.name)
+        testutil.test_ifaces_connected(if0=device.name, if1=self.hostapd.ifname)
+
+        known_network = self.wd.list_known_networks()[0]
+        known_network.forget()
+
+        with self.assertRaises(FailedEx):
+            network.network_object.connect()
+
     def setUp(self):
         self.hostapd.default()
         self.wd = IWD(True)
-- 
2.34.1

