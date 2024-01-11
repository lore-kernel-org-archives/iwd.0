Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC13D18023
	for <iwd@lists.linux.dev>; Thu, 11 Jan 2024 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgWz+FTK"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-67f8d9fe99fso34156616d6.2
        for <iwd@lists.linux.dev>; Thu, 11 Jan 2024 05:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704981102; x=1705585902; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKdq3JmbEzFdUjEX9ihL8iiYEEc02J9KhL7JuxuYVtk=;
        b=JgWz+FTKGFDHTGXNi/xNaWmaNUmZBujKk32hAcZWI9E7DekIvl3bAJN6jyxqcwXY7A
         UirsB8veprpOUfghlOaYO4XEqkZHGUEADjB8bEBYKmsBcHjY+9BYio6Z58/FKeMpNrQs
         7CTFUwHs1Z2Wai2fHKWJckdlEnAis5qw2rqslqbz46tM7dED1cRcROcd6JsSFp7E1Fj1
         L+IqOU2erLT9zqpB199QrW9D9nxvJYgq8oWzP4UokZWyPI7xfIjQ1a93Eea9RdY0QD6Q
         X2JfQCzRXTCe53TBlUHnJkg7P/bS1nETpstrnkzqKNCHGTxfOXCCZ1a3aDgLcpLpE/4v
         xWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704981102; x=1705585902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKdq3JmbEzFdUjEX9ihL8iiYEEc02J9KhL7JuxuYVtk=;
        b=IOS2xFoPhlALhVVac4So/gNGqhld7Wz/5115CIbv3RCxNOlKd/xvZqKVu+wKbsQDHU
         fUv34jgohaNhSHXAh86K8jGPzxTaXCTnLHixagJld1jgYkalGWgyvH0rHnigpJAG7J81
         6wkjRUipRhJOjjA/52ntvGfjhessBL/OvrpWc+grSy2o8DAoHx3YzJWq4lysfbbviESM
         7/av+HsTOkNFdbh8vOHLP7cL5UYa58vZeEbjYWHsw9LzaqW7JlVtCWTK5adv6IHxOhE/
         XeV1x5W53ldiZ67yd3QdRvfMAWco9e0qqXxLAQCSSFEwJXA7nvCfw+arZ3ZlGV6tZF8+
         OU0Q==
X-Gm-Message-State: AOJu0YyuoKY5brq3mASlmq1XepiJNLWrRhgwf1UP98IjBJaoHwYIke1i
	iyN0m4zNz30sDALCxmg/wGgpc5o3kFc=
X-Google-Smtp-Source: AGHT+IH/v74KZG0i3V6vqFuEBKute4nhcToO5NVlKaIj3HEhR9Dnvm5DEhzF68wf+7xn6vRl225tvg==
X-Received: by 2002:ad4:5943:0:b0:681:3157:3cbf with SMTP id eo3-20020ad45943000000b0068131573cbfmr1068191qvb.46.1704981102268;
        Thu, 11 Jan 2024 05:51:42 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id ml18-20020a056214585200b0067f319b1b21sm309470qvb.24.2024.01.11.05.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 05:51:41 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: add netconfig timeout test
Date: Thu, 11 Jan 2024 05:51:37 -0800
Message-Id: <20240111135137.1431023-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests that netconfig eventually times out and that IWD disconnects
---
 autotests/testNetconfig/autoconnect.psk |  2 +
 autotests/testNetconfig/timeout_test.py | 65 +++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 autotests/testNetconfig/autoconnect.psk
 create mode 100644 autotests/testNetconfig/timeout_test.py

Note: this requires a fix in ELL
https://lore.kernel.org/ell/20240111133331.1423853-1-prestwoj@gmail.com/T/#u

diff --git a/autotests/testNetconfig/autoconnect.psk b/autotests/testNetconfig/autoconnect.psk
new file mode 100644
index 00000000..c28936bf
--- /dev/null
+++ b/autotests/testNetconfig/autoconnect.psk
@@ -0,0 +1,2 @@
+[IPv4]
+SendHostname=true
diff --git a/autotests/testNetconfig/timeout_test.py b/autotests/testNetconfig/timeout_test.py
new file mode 100644
index 00000000..099e8597
--- /dev/null
+++ b/autotests/testNetconfig/timeout_test.py
@@ -0,0 +1,65 @@
+import unittest
+import sys
+import os
+
+sys.path.append('../util')
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+
+class Test(unittest.TestCase):
+
+    def test_netconfig_timeout(self):
+        IWD.copy_to_storage('autoconnect.psk', name='ap-ns1.psk')
+
+        wd = IWD(True)
+
+        psk_agent = PSKAgent("secret123")
+        wd.register_psk_agent(psk_agent)
+
+        devices = wd.list_devices(1)
+        device = devices[0]
+
+        ordered_network = device.get_ordered_network('ap-ns1')
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition = 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condition)
+
+        ordered_network.network_object.connect()
+
+        condition = 'obj.state == DeviceState.connecting'
+        wd.wait_for_object_condition(device, condition)
+
+        device.wait_for_event("connecting (netconfig)")
+
+        # Netconfig should fail, and IWD should disconnect
+        from_condition = 'obj.state == DeviceState.connecting'
+        to_condition = 'obj.state == DeviceState.disconnecting'
+        wd.wait_for_object_change(device, from_condition, to_condition, max_wait=150)
+
+        # Autoconnect should then try again
+        condition = 'obj.state == DeviceState.connecting'
+        wd.wait_for_object_condition(device, condition)
+
+        device.wait_for_event("connecting (netconfig)")
+
+        device.disconnect()
+        condition = 'obj.state == DeviceState.disconnected'
+        wd.wait_for_object_condition(device, condition)
+
+    @classmethod
+    def setUpClass(cls):
+        cls.orig_path = os.environ['PATH']
+        os.environ['PATH'] = '/tmp/test-bin:' + os.environ['PATH']
+        IWD.copy_to_storage('resolvconf', '/tmp/test-bin')
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+        os.system('rm -rf /tmp/radvd.conf /tmp/resolvconf.log /tmp/test-bin')
+        os.environ['PATH'] = cls.orig_path
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
\ No newline at end of file
-- 
2.34.1

