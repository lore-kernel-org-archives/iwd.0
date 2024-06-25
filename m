Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FFE1DFC5
	for <iwd@lists.linux.dev>; Tue, 25 Jun 2024 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320808; cv=none; b=C7PcKxw9j9lQpJhZK8ZV1bEYZ7ZFaKqC/TcuJCu9rOF/dXiXXBYFcsb+xIR7L712LiShRX+Ldq38kCAETclid2cWxhALl7Es9J/lJNReUQKXPBsTOaaRNc4TekefbtItt615/qk1kJB2iBOs801P1NdzXNdATerQT7UIbjAcpPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320808; c=relaxed/simple;
	bh=RNJXjzn7dfvacAcjbQC8RuzQ87USHkYfXo8CCOV5pPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M4hHGRdbANQJmUzH4SBI8mnpgWbxF90GJIsZ3I9zGC7VM1X50IFcpWpe1tVY82rB+w27GoY65rg5fFDf1gV6zK5SI06+oWLxB/hC1SDKYpFPWLhmt0d5QDRzhrE12DysIfkyRtYh13vSW+y4ri+fCYMS0f9y/+Lob/JbFpEBc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUS524SS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUS524SS"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fa75f53f42so3333795ad.0
        for <iwd@lists.linux.dev>; Tue, 25 Jun 2024 06:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719320806; x=1719925606; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=polICqSFyqeZxpJiwecS0KeD3RJtwMewp3OOYZGgrSg=;
        b=hUS524SSMyZ9oIg6cJj75h6orSLHcQcR6lJKVSonP/4A6PdF7aYeNIpoPpoFb99G5F
         rr+Z8eBVVB2/ZEHxroXJ39atQIc3j7vjKtJqFNjKLoo/+SZlDPo6KfDar5/N/HC/r27F
         g4Hob5qIhhMIAPfKZBiB2RHeWSucZTJCmdQ2rzOAUDFRPwM3vw/QMOmDDtfGUcT/PzIo
         SEOdo6UOZ+s440TqzvPIprnFYBY8On5XnztzMx286+5iIvAuBbTw3Ut8JxUF1WH2AXa5
         KNn3YXWzNma1jCpfPYiqxOwQOjBKy+e3MV173iGIltgWd8WX8VuqZltq8arp9rjvEvwa
         VelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719320806; x=1719925606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=polICqSFyqeZxpJiwecS0KeD3RJtwMewp3OOYZGgrSg=;
        b=Sdy5QCevQY0opsToTM6+1mSob5fwiSuZ6T3rp7vlz3kbZk9N0wGPqynDKXxDxe9K6A
         eG0YacPzU42iVDcP+Gx+8Sql5jBY0FIzsaB8T9wCJCVU+d91SvtX+uDxAs/9Lw9UWY0M
         BQHBrCX+/nP+20gim3LFOGdzrX8Vxwd04BGGFhpbMlgwNxWAWLGCpqE7a6o2Sh3YpQ3V
         6nqK8Px69GpHRVRgUYHriJxhvzTv7HuYGZo81k+nxmua/mX4TWFizV+FhtoZepfbouft
         XqNWtMoCV7kPyuuke+rN2mLNaDTg5nmaRFlC0B/Aw9gXnDIkzgByBvaJAZGuf7AkFixr
         1QyA==
X-Gm-Message-State: AOJu0Yyb0af9ZI5RmEosuNr/cPuvEyVFlQIf+o3AFBjlt78kvBNdNOFs
	uRcBxKweqAIsmB5zmZb/Ex3FWzUdjJtFtxSCBSiCnccprqKuZdH1LHeWvg==
X-Google-Smtp-Source: AGHT+IGZBbIEP5mVQakchNe4tzonQ54IymCwdUnMFiSW+Fp43bpgHgJEcedF92oCtemx15Olw6jplQ==
X-Received: by 2002:a17:903:2342:b0:1f6:ff48:1cdb with SMTP id d9443c01a7336-1fa2408231emr80828165ad.52.1719320806291;
        Tue, 25 Jun 2024 06:06:46 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5bf2sm80778305ad.189.2024.06.25.06.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 06:06:45 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/7] auto-t: add test for deauth after authentication
Date: Tue, 25 Jun 2024 06:06:22 -0700
Message-Id: <20240625130624.385553-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625130624.385553-1-prestwoj@gmail.com>
References: <20240625130624.385553-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This code path is not exercised in the autotest but commonly does
happen in the real world. There is no associated bug with this, but
its helpful to have this event triggered in case something got
introduced in the future.
---
 autotests/testWPA2/failure_test.py | 32 +++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/autotests/testWPA2/failure_test.py b/autotests/testWPA2/failure_test.py
index 61cf6ade..c8ecb33c 100644
--- a/autotests/testWPA2/failure_test.py
+++ b/autotests/testWPA2/failure_test.py
@@ -8,11 +8,12 @@ import iwd
 from iwd import IWD
 from iwd import PSKAgent
 from iwd import NetworkType
+from hostapd import HostapdCLI
 import testutil
 
 class Test(unittest.TestCase):
 
-    def test_connection_success(self):
+    def test_incorrect_password(self):
         wd = IWD(True)
 
         psk_agent = PSKAgent("InvalidPassword")
@@ -34,6 +35,35 @@ class Test(unittest.TestCase):
 
         wd.unregister_psk_agent(psk_agent)
 
+    def test_deauth_after_connection(self):
+        wd = IWD(True)
+        hostapd = HostapdCLI(config="ssidWPA2.conf")
+
+        psk_agent = PSKAgent("secret123")
+        wd.register_psk_agent(psk_agent)
+
+        devices = wd.list_devices(1)
+        self.assertIsNotNone(devices)
+        device = devices[0]
+
+        ordered_network = device.get_ordered_network('ssidWPA2')
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition = 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condition)
+
+        ordered_network.network_object.connect(wait=False)
+
+        device.wait_for_event("authenticating")
+
+        # Trigger a deauth just after authenticating
+        hostapd.deauthenticate(device.address)
+
+        device.wait_for_event("disconnected")
+
+        wd.unregister_psk_agent(psk_agent)
+
     @classmethod
     def setUpClass(cls):
         pass
-- 
2.34.1

