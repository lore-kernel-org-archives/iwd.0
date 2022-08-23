Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FCA2F4D
	for <iwd@lists.linux.dev>; Tue, 23 Aug 2022 16:36:41 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id u14so17663302wrq.9
        for <iwd@lists.linux.dev>; Tue, 23 Aug 2022 09:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=il+yj7XDg0K7wNZ3RnxErRFIMP7e7vl6Uqw+/Hf5wT4=;
        b=icDgTVPdsPnNM4lU5U5upjJ2oGM3RMhRg/AokfF3GkiHjh4EUuKUoOYe4lu7B9rj68
         OLKMAuCeJgFYOPFRcZzRhRM48YCpfrfdhrekh2dx+xcjMraEvemLnfrfhqCedim2kPeM
         RHLEgl6jXX9P0gVad0gQUFlo3PZ2ylfyhS8pSyIf7h88zvex5cQI5n5X7dGeFBbPgcW1
         zWNau4Sy0ZZccZeOdOdb1OHVKamx8umUmZZUCyc103Sfjm4k8Xu4uTdJ3qtrDfKjCJlK
         lc30bs4nvKDdskVp1BPz5IMg36cAR0RQueiRYSms4cWrq3Bc504xzacF4M7nwRQ2TX9B
         EIsw==
X-Gm-Message-State: ACgBeo0rbbJdMO0PkNdi8XWw6C6Bw0ATFwUKViy3LIcqyWdZ7c6xWkDf
	dRjbQtvQH+pDWIDVD3mGW3QF4YxND6g=
X-Google-Smtp-Source: AA6agR66wy5IEVI09PlGV+0VjUV0j0T+G/4oeaDLu3c4FsClZeVgI+DJrlAbLvet+bfEH1ZcS/S4GQ==
X-Received: by 2002:a5d:648b:0:b0:222:cc32:c292 with SMTP id o11-20020a5d648b000000b00222cc32c292mr13608790wri.463.1661272599351;
        Tue, 23 Aug 2022 09:36:39 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id g1-20020adff3c1000000b0021e5f32ade7sm14716319wrp.68.2022.08.23.09.36.38
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 09:36:38 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 3/3] autotests: Test ACD failure during connect
Date: Tue, 23 Aug 2022 18:36:16 +0200
Message-Id: <20220823163616.1466543-3-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220823163616.1466543-1-andrew.zaborowski@intel.com>
References: <20220823163616.1466543-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously we had an ACD failure scenario where a new client forces its
IP to create an IP conflict and an already-connected client detects the
conflict and reacts.  Now first test a scenario where a newly connecting
IWD client runs ACD before setting its statically configured IP, detects
a conflict and refuses to continue, then run the second scenario where
the newly connecting DHCP-configured client ignores the conflict and
starts ACD in defend-indefinitely mode and the older client in
defent-once mode gives up its IP.
---
 autotests/testNetconfig/static_test.py | 83 +++++++++++++++++++-------
 1 file changed, 61 insertions(+), 22 deletions(-)

diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconfig/static_test.py
index 4ce279f2..94307a8c 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -13,36 +13,28 @@ import testutil
 from config import ctx
 import os
 import socket
+import gc
 
 class Test(unittest.TestCase):
 
     def test_connection_success(self):
         # Use a non-default storage_dir for one of the instances, the default for the other one
-        wd = IWD(True, iwd_storage_dir='/tmp/storage')
-
-        ns0 = ctx.get_namespace('ns0')
-
-        wd_ns0 = IWD(True, namespace=ns0)
-
-        psk_agent = PSKAgent("secret123")
-        psk_agent_ns0 = PSKAgent("secret123", namespace=ns0)
-        wd.register_psk_agent(psk_agent)
-        wd_ns0.register_psk_agent(psk_agent_ns0)
-
-        dev1 = wd.list_devices(1)[0]
-        dev2 = wd_ns0.list_devices(1)[0]
+        iwd_main = IWD(True, iwd_storage_dir='/tmp/storage-main')
+        psk_agent_main = PSKAgent("secret123")
+        iwd_main.register_psk_agent(psk_agent_main)
+        dev1 = iwd_main.list_devices(1)[0]
 
         ordered_network = dev1.get_ordered_network('ap-main')
 
         self.assertEqual(ordered_network.type, NetworkType.psk)
 
         condition = 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condition)
+        iwd_main.wait_for_object_condition(ordered_network.network_object, condition)
 
         ordered_network.network_object.connect()
 
         condition = 'obj.state == DeviceState.connected'
-        wd.wait_for_object_condition(dev1, condition)
+        iwd_main.wait_for_object_condition(dev1, condition)
 
         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
@@ -80,10 +72,56 @@ class Test(unittest.TestCase):
         # of the log since we care about the end result here.
         self.assertEqual(expected_rclog, entries[-3:])
 
+        # Run our second client in a separate namespace to allow ACD (ARP) to
+        # work, and also be able to set identical IPs on both interfaces for
+        # the next part of this test.
+        ns0 = ctx.get_namespace('ns0')
+
+        iwd_ns0_1 = IWD(True, namespace=ns0, iwd_storage_dir='/tmp/storage-ns0-1')
+        psk_agent_ns0_1 = PSKAgent("secret123", namespace=ns0)
+        iwd_ns0_1.register_psk_agent(psk_agent_ns0_1)
+        dev2 = iwd_ns0_1.list_devices(1)[0]
+
+        ordered_network = dev2.get_ordered_network('ap-main')
+
+        condition = 'not obj.connected'
+        iwd_ns0_1.wait_for_object_condition(ordered_network.network_object, condition)
+
+        # Attempt a connection to the same AP that iwd_main is connected to
+        # using the same static config.  The new client's ACD client should
+        # detect an IP conflict and not allow the device to reach the
+        # "connected" state although the DBus .Connect call will succeed.
+        ordered_network.network_object.connect()
+        self.assertEqual(dev2.state, iwd.DeviceState.connecting)
+        try:
+            # We should either stay in "connecting" indefinitely or move to
+            # "disconnecting"
+            condition = 'obj.state != DeviceState.connecting'
+            iwd_ns0_1.wait_for_object_condition(dev2, condition, max_wait=21)
+            self.assertEqual(dev2.state, iwd.DeviceState.disconnecting)
+        except TimeoutError:
+            dev2.disconnect()
+
+        iwd_ns0_1.unregister_psk_agent(psk_agent_ns0_1)
+        del dev2
+        # Note: if any references to iwd_ns0_1 are left, the "del iwd_ns0_1"
+        # will not kill the IWD process the iwd_ns0_2 initialization will raise
+        # an exception.  The iwd_ns0_1.wait_for_object_condition() above
+        # creates a circular reference (which is not wrong in itself) and
+        # gc.collect() gets rid of it.  The actual solution is to eventually
+        # avoid executing anything important in .__del__ (which is wrong.)
+        gc.collect()
+        del iwd_ns0_1
+
+        iwd_ns0_2 = IWD(True, namespace=ns0, iwd_storage_dir='/tmp/storage-ns0-2')
+        psk_agent_ns0_2 = PSKAgent("secret123", namespace=ns0)
+        iwd_ns0_2.register_psk_agent(psk_agent_ns0_2)
+        dev2 = iwd_ns0_2.list_devices(1)[0]
+
         ordered_network = dev2.get_ordered_network('ap-main')
 
         condition = 'not obj.connected'
-        wd_ns0.wait_for_object_condition(ordered_network.network_object, condition)
+        iwd_ns0_2.wait_for_object_condition(ordered_network.network_object, condition)
 
         # Connect to the same network from a dynamically configured client.  We
         # block ICMP pings so that the DHCP server can't confirm that
@@ -98,9 +136,9 @@ class Test(unittest.TestCase):
         ordered_network.network_object.connect()
 
         condition = 'obj.state == DeviceState.connected'
-        wd_ns0.wait_for_object_condition(dev2, condition)
+        iwd_ns0_2.wait_for_object_condition(dev2, condition)
 
-        wd.wait(1)
+        iwd_main.wait(1)
         # Check dev1 is now disconnected or without its IPv4 address
         if dev1.state == iwd.DeviceState.connected:
             testutil.test_ip_address_match(dev1.name, None)
@@ -109,9 +147,9 @@ class Test(unittest.TestCase):
         dev2.disconnect()
 
         condition = 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condition)
+        iwd_main.wait_for_object_condition(ordered_network.network_object, condition)
 
-        wd.unregister_psk_agent(psk_agent)
+        iwd_main.unregister_psk_agent(psk_agent_main)
 
     @classmethod
     def setUpClass(cls):
@@ -132,7 +170,8 @@ class Test(unittest.TestCase):
         cls.dhcpd_pid = ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/dhcpd.conf',
                                             '-lf', '/tmp/dhcpd.leases',
                                             hapd.ifname], cleanup=remove_lease)
-        IWD.copy_to_storage('static.psk', '/tmp/storage', 'ap-main.psk')
+        IWD.copy_to_storage('static.psk', '/tmp/storage-main', 'ap-main.psk')
+        IWD.copy_to_storage('static.psk', '/tmp/storage-ns0-1', 'ap-main.psk')
 
         cls.orig_path = os.environ['PATH']
         os.environ['PATH'] = '/tmp/test-bin:' + os.environ['PATH']
@@ -141,7 +180,7 @@ class Test(unittest.TestCase):
     @classmethod
     def tearDownClass(cls):
         cls.dhcpd_pid.kill()
-        os.system('rm -rf /tmp/resolvconf.log /tmp/test-bin /tmp/storage')
+        os.system('rm -rf /tmp/resolvconf.log /tmp/test-bin /tmp/storage-*')
         os.environ['PATH'] = cls.orig_path
 
 if __name__ == '__main__':
-- 
2.34.1

