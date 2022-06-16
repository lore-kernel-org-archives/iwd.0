Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484187E
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 00:02:56 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id i17-20020a7bc951000000b0039c4760ec3fso2788560wml.0
        for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 17:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfIu77EE2skJlGFtHb5T0jhAelHy2rS2ES8KAplz1mg=;
        b=mnSLCc9N1E/M8DzMiRaIPowItFHFOX4lieXiXOOnzdhC4g9VRjPk8f3NYJ6Br7kuVn
         CbZc2h43bm/wFncFqxtxMEEPCN/17u6NFfZXkTlCaTEyRZlyeO063/AbNSX1A03klgxh
         wDetGknzPb1NOz0QCUT+aMUXstgEnoCFz4dow+KsYOmMWe3jHukCSNp5pCZ3S08rP/Up
         JwfIyPllTRAlnv4J9uFGn/4yviXPIJtFuqiv5AGz5eKI8CPXp4MQIX5+ShN9gjjpUjwZ
         oCCmNIvUnVKKVzzZBCycMFGbWyEEgXqBZ5Fog3TGJAB3oN9xv0mjxuq/nAbjdXnvG8UT
         Qr2Q==
X-Gm-Message-State: AOAM530Tmc+5mK65EepbQ+Se5cR4C+NEy3oUs17ZqBfawCY9NIlqdpZu
	X9NcCY5nFSUgz4A1WL/7fY37S20P0Hk=
X-Google-Smtp-Source: ABdhPJzdjUYrr2lGZWY7h3YAAnsgeYuXYhZl6y1nFNTrtEJ9uNMFi0ZRQIwhrc/sHwSlfuWdZt4/7Q==
X-Received: by 2002:a05:600c:4e88:b0:39c:7c53:d7ff with SMTP id f8-20020a05600c4e8800b0039c7c53d7ffmr13029665wmq.176.1655337774166;
        Wed, 15 Jun 2022 17:02:54 -0700 (PDT)
Received: from iss.Home ([82.213.231.20])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm337452wrb.45.2022.06.15.17.02.53
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:02:53 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 14/15] autotests: Add bad netconfig settings scenario
Date: Thu, 16 Jun 2022 02:02:30 +0200
Message-Id: <20220616000231.1966008-14-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testNetconfig/connection_test.py | 30 +++++++++++++++++++++-
 autotests/testNetconfig/mismatch.psk       |  7 +++++
 2 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 autotests/testNetconfig/mismatch.psk

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNetconfig/connection_test.py
index 4b05c745..837b19ec 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -92,6 +92,35 @@ class Test(unittest.TestCase):
 
         wd.unregister_psk_agent(psk_agent)
 
+    def test_addr_type_error(self):
+        IWD.copy_to_storage('mismatch.psk', name='ssidTKIP.psk')
+        wd = IWD(True)
+
+        psk_agent = PSKAgent("secret123")
+        wd.register_psk_agent(psk_agent)
+
+        devices = wd.list_devices(1)
+        device = devices[0]
+
+        ordered_network = device.get_ordered_network('ssidTKIP')
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition = 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condition)
+
+        # Ideally we want to check that this errors out at an early phase, especially
+        # before any radio operations, due to netconfig setting validation, but this is
+        # tricky to ensure.  Also ideally this would happen even before asking the user
+        # for the passphrase which is easier to ensure in the tests, but currently IWD
+        # asks for the PSK before control reaches station.c.
+        self.assertRaises(iwd.InvalidArgumentsEx, ordered_network.network_object.connect)
+
+        wd.unregister_psk_agent(psk_agent)
+
+    def tearDown(self):
+        IWD.clear_storage()
+
     @classmethod
     def setUpClass(cls):
         def remove_lease4():
@@ -147,7 +176,6 @@ class Test(unittest.TestCase):
 
     @classmethod
     def tearDownClass(cls):
-        IWD.clear_storage()
         ctx.stop_process(cls.dhcpd_pid)
         cls.dhcpd_pid = None
         ctx.stop_process(cls.dhcpd6_pid)
diff --git a/autotests/testNetconfig/mismatch.psk b/autotests/testNetconfig/mismatch.psk
new file mode 100644
index 00000000..f8920b7c
--- /dev/null
+++ b/autotests/testNetconfig/mismatch.psk
@@ -0,0 +1,7 @@
+[IPv6]
+# IPv4 addresses where IPv6 are expected
+Address=192.168.1.10
+Gateway=192.168.1.1
+
+[Settings]
+AutoConnect=false
-- 
2.34.1

