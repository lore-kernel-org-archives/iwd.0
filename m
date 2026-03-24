Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084F62D8793
	for <iwd@lists.linux.dev>; Tue, 24 Mar 2026 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380064; cv=none; b=hl4YpLYNBPG3z3ALwAHGrfYDPdLDYZOCWEXDRXZ/07Q1k3FNe8CjQiJXjcfjIPuQZ/+Hh+hShbWNHneex9dBSHn7p0RugwB1BE2hRtCTjt6G7Dwgknse1sQ3WnUnuPoMu1uaIL8CyuLMIIT4eos9vpvPxM5yIgWr+rqYH0jVb/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380064; c=relaxed/simple;
	bh=Z0oQkqdeqkp682C2EheEjb+RA93bazu+Mq+s2Y3CYjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9aHMgnAEVp7f7YCqu5Z9qi+2NtrUu3yuH3bO5Ug5+cpIAOIZ3QVMPldkUtkd5PRlxH4ioUQ6kkdrG/E1X0mJNoLQjUCxt5Nl64PapBn09AX06tDPW2+bRtwIawWkflYhgO1elRLO2Jhggu8Flh65tQYN+WzrMUqz132RkWD2JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=husgP2CZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="husgP2CZ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b07069e2efso10850025ad.3
        for <iwd@lists.linux.dev>; Tue, 24 Mar 2026 12:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774380062; x=1774984862; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+BzHiosC8MlQkNtan9G5RRGwQLBh4nCq5z9uZ/Hdpk=;
        b=husgP2CZZdbJNwdw8nODLBCKB0nUYgbj5RDGarMyMQq+J0UpoKbYPfoFpplKxQ9Sq2
         57uFkfJf1r+8g1aQ90ZHb3kOII4zM9TE1Duz/Qg2XdhsNyvZ8yaTroPqhVnT83G5jwWj
         vydDXDObSR+bn6sUXux5nvLWnEnxIIzsnL8NrzjZmo6vBvlVpQ+DweluHYiGd6PUmrpI
         /suxkL6ZD12++znB3MSu0tPwIDkMZC6WWiO6d2uSoC78XLq4L/DsTgcy/hZxMp7VRzg9
         FJpmMAKERqoZu/auEP4/qP6rD7MeFW4u3eGXs8G2e4rNjOuzVmud8ygVcLZkWqMPURRK
         KyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774380062; x=1774984862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7+BzHiosC8MlQkNtan9G5RRGwQLBh4nCq5z9uZ/Hdpk=;
        b=VJKynWaVcW8zPrdhIpXZAl8US59g5UW1RjpFX8ZlcoEWGqoLUh/BXRkuDxiOUDdtV1
         6p5EONSfZJ1SDnwvil7JUOhqfSM8phdOlxIkjqmJ1p5IbTmKY8qJ7F/Ktvi+17SHSWEc
         oIHPSIRUZBQ1cCr6vTOoBLE/hRDFK7QrCbRMtMTcfzS/a95DUkCDHVsSQjcu+21WKVlp
         2wVsdDJPf7WmAHZLLup4SVWZ4GqWQDen1wNBOnebQjF50QFaVbn2W0N+Ugpa5gIu9fui
         FcfvtF2CxWKjlD7/7APVw0OQvPJT/QjQ+VFiNlBv0aTdZ7RUqbI2DZpEMXtAkPDeHNIM
         aXDQ==
X-Gm-Message-State: AOJu0YxwsDHYcodrDmb/Hj/WNSTh0DWkUCVDBqNk2ISGYf52KT2F02h7
	ge4JnAV1o622thEK7d3xkK5zQflNerIjJG0bYVwhGxjQvVFIHeiphzO+TwRr8w==
X-Gm-Gg: ATEYQzwaPREA0spKBbgtnIcsiLRtBczUp1+CNfSxfUT38A/LjxZUBTzDAlCW3s7PA3A
	Mf9ip038qq5CHTS9Ba2mV1haXwOolgdxkWG3ZlvMq2b0R8l2uQY1Gtf7PnxFiQvErF9YBGyRDcX
	/zeGe3+pYQiYpajnPkuZP4xJVsikVji+LOoAodA89pKL2FMbRRWoFXEy5XwrSv3jccq+GZZlRvd
	m/B3w+tL3qTJFKAGECYHDnbY36bkKTE3QQ/nwkR1X9veJmdnbpl4qBGnfIBLZl6DQHApe1W/IiJ
	/dJZqOYrMjpqnWg/8AR5NCHAAS5S8KNKcVxqcKidCk1ridlnzgBrgRdrGRDuvWoyd3KC7KtY1Tb
	g1CXiajg6W7V4P3BgI2pkdyATByuAg2kCfdXP0ZHOgy0mMJ6v9AEz3Ywa9WG2NbRJ8q44zXfKkX
	nkpFe5h29EPLW7Pv/k7kUS5i4k4UnMGgn3RIzSK4p93WqdhfANiqUQaU/QOXCmmafJ0LAEirn2F
	bM=
X-Received: by 2002:a17:903:1b24:b0:2ae:4150:3118 with SMTP id d9443c01a7336-2b0b09a9a40mr7599325ad.12.1774380062000;
        Tue, 24 Mar 2026 12:21:02 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a938743sm10311125a12.19.2026.03.24.12.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:21:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] auto-t: add test for known network removal of a PMKSA network
Date: Tue, 24 Mar 2026 12:20:51 -0700
Message-Id: <20260324192051.801196-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324192051.801196-1-prestwoj@gmail.com>
References: <20260324192051.801196-1-prestwoj@gmail.com>
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

