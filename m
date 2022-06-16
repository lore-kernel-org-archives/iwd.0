Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278B15A0
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 00:02:53 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso9538wmc.4
        for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 17:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkbwY8/c+df1aRVshFiXh8qlXNAD1mDhwJM9TaBejzc=;
        b=6AdSc2W/5l3HywKZZY6dFm/VnEBWg1QNAEdu/zmpg5srghJyzjDeYscLydGlVUjM0D
         UtD/tgXOyd4BszTLOljHkzoFImhOj7cWmnggMu86G1KhFjScyl2J/KNsCGdJvh6o4S3h
         UyRuIEeG0/ce1E28zIydU0U49hGnvwLY9wDD5tXYiI5gELrFdIw0dFYssv1E0jeP58pO
         sIH6wPB51mPevXK9ccKWW3EORYjewvKH+T7/kPBw7DOq1oeBfXIqybUqgFopKvnda/Dl
         /EKO6ofyMBPbWim5rfRm6i4D68vakyykGdSKmMpTp8e8T8LT3XkCoAOCH4H3STUiH31f
         0HBA==
X-Gm-Message-State: AOAM532m1w4oTh99JLtVdUZtzkLBNkm3M/dAp+04Xlz15Y0QvkCQlm9d
	IrOpx5VFYu4LFH9wviH3xUK6Vkwm5TE=
X-Google-Smtp-Source: ABdhPJz7z1RDVCezNOmULzjr5zQG8C6fPSCs++oPdbPpc/9EE/YWQ0Q1cxg55oIa0akMLuSYiZp0Cg==
X-Received: by 2002:a05:600c:19d4:b0:39c:7ec6:c7cc with SMTP id u20-20020a05600c19d400b0039c7ec6c7ccmr12503855wmq.141.1655337771669;
        Wed, 15 Jun 2022 17:02:51 -0700 (PDT)
Received: from iss.Home ([82.213.231.20])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm337452wrb.45.2022.06.15.17.02.50
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:02:51 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 12/15] autotests: Verify DNS entries added from DHCP/static
Date: Thu, 16 Jun 2022 02:02:28 +0200
Message-Id: <20220616000231.1966008-12-andrew.zaborowski@intel.com>
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

Add a fake resolvconf executable to verify that the right nameserver
addresses were actually committed by iwd.  Again use unique nameserver
addresses to reduce the possibility that the test succeeds by pure luck.
---
 autotests/testNetconfig/connection_test.py | 15 ++++++++++++++-
 autotests/testNetconfig/dhcpd-v6.conf      |  2 +-
 autotests/testNetconfig/dhcpd.conf         |  2 +-
 autotests/testNetconfig/main.conf          |  2 +-
 autotests/testNetconfig/resolvconf         |  2 ++
 autotests/testNetconfig/ssidTKIP.psk       |  2 ++
 autotests/testNetconfig/static_test.py     | 15 ++++++++++++++-
 7 files changed, 35 insertions(+), 5 deletions(-)
 create mode 100755 autotests/testNetconfig/resolvconf

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNetconfig/connection_test.py
index db3327ef..4b05c745 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -77,6 +77,14 @@ class Test(unittest.TestCase):
         self.assertEqual(expected_routes4, set(testutil.get_routes4(ifname)))
         self.assertEqual(expected_routes6, set(testutil.get_routes6(ifname)))
 
+        rclog = open('/tmp/resolvconf.log', 'r')
+        entries = rclog.readlines()
+        rclog.close()
+        expected_rclog = ['-a wlan1.dns\n', 'nameserver 192.168.1.2\n', 'nameserver 3ffe:501:ffff:100::2\n']
+        # Every real resolvconf -a run overwrites the previous settings.  Check the last three lines
+        # of our log since we care about the end result here.
+        self.assertEqual(expected_rclog, entries[-3:])
+
         device.disconnect()
 
         condition = 'not obj.connected'
@@ -133,6 +141,10 @@ class Test(unittest.TestCase):
         config.close()
         cls.radvd_pid = ctx.start_process(['radvd', '-n', '-d5', '-p', '/tmp/radvd.pid', '-C', '/tmp/radvd.conf'])
 
+        cls.orig_path = os.environ['PATH']
+        os.environ['PATH'] = '/tmp/test-bin:' + os.environ['PATH']
+        IWD.copy_to_storage('resolvconf', '/tmp/test-bin')
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
@@ -142,7 +154,8 @@ class Test(unittest.TestCase):
         cls.dhcpd6_pid = None
         ctx.stop_process(cls.radvd_pid)
         cls.radvd_pid = None
-        os.remove('/tmp/radvd.conf')
+        os.system('rm -rf /tmp/radvd.conf /tmp/resolvconf.log /tmp/test-bin')
+        os.environ['PATH'] = cls.orig_path
 
 if __name__ == '__main__':
     unittest.main(exit=True)
diff --git a/autotests/testNetconfig/dhcpd-v6.conf b/autotests/testNetconfig/dhcpd-v6.conf
index 917ee8a3..45057ab8 100644
--- a/autotests/testNetconfig/dhcpd-v6.conf
+++ b/autotests/testNetconfig/dhcpd-v6.conf
@@ -1,6 +1,6 @@
 subnet6 3ffe:501:ffff:100::/72
  {
-  option dhcp6.name-servers 3ffe:501:ffff:100::1;
+  option dhcp6.name-servers 3ffe:501:ffff:100::2;
   range6 3ffe:501:ffff:100::10 3ffe:501:ffff:100::20;
   range6 3ffe:501:ffff:100::100 3ffe:501:ffff:100::200;
  }
diff --git a/autotests/testNetconfig/dhcpd.conf b/autotests/testNetconfig/dhcpd.conf
index ea9957a3..d8a9d24c 100644
--- a/autotests/testNetconfig/dhcpd.conf
+++ b/autotests/testNetconfig/dhcpd.conf
@@ -9,7 +9,7 @@ subnet 192.168.0.0 netmask 255.255.128.0
  {
   option routers 192.168.1.1;
   option subnet-mask 255.255.128.0;
-  option domain-name-servers 192.168.1.1;
+  option domain-name-servers 192.168.1.2;
   range 192.168.1.10 192.168.1.20;
   range 192.168.1.100 192.168.1.200;
  }
diff --git a/autotests/testNetconfig/main.conf b/autotests/testNetconfig/main.conf
index 1ffe2be1..8641a390 100644
--- a/autotests/testNetconfig/main.conf
+++ b/autotests/testNetconfig/main.conf
@@ -3,4 +3,4 @@ EnableNetworkConfiguration=true
 
 [Network]
 EnableIPv6=true
-NameResolvingService=none
+NameResolvingService=resolvconf
diff --git a/autotests/testNetconfig/resolvconf b/autotests/testNetconfig/resolvconf
new file mode 100755
index 00000000..7c56c616
--- /dev/null
+++ b/autotests/testNetconfig/resolvconf
@@ -0,0 +1,2 @@
+#! /bin/sh
+(echo "$*" ; [ "$1" = -a ] && cat) >> /tmp/resolvconf.log 2> /dev/null
diff --git a/autotests/testNetconfig/ssidTKIP.psk b/autotests/testNetconfig/ssidTKIP.psk
index e371c97f..032e2185 100644
--- a/autotests/testNetconfig/ssidTKIP.psk
+++ b/autotests/testNetconfig/ssidTKIP.psk
@@ -4,11 +4,13 @@
 Address=192.168.1.10
 Netmask=255.255.255.128
 Gateway=192.168.1.3
+DNS=192.168.1.4
 
 [IPv6]
 # Use a different subnet than DHCP on purpose
 Address=3ffe:501:ffff:200::10/80
 Gateway=3ffe:501:ffff:200::3
+DNS=3ffe:501:ffff:200::4
 
 [Settings]
 AutoConnect=false
diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconfig/static_test.py
index cd147894..ac525b28 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -72,6 +72,14 @@ class Test(unittest.TestCase):
         self.assertEqual(expected_routes4, set(testutil.get_routes4(ifname)))
         self.assertEqual(expected_routes6, set(testutil.get_routes6(ifname)))
 
+        rclog = open('/tmp/resolvconf.log', 'r')
+        entries = rclog.readlines()
+        rclog.close()
+        expected_rclog = ['-a wlan1.dns\n', 'nameserver 192.168.1.4\n', 'nameserver 3ffe:501:ffff:200::4\n']
+        # Every resolvconf -a run overwrites the previous settings.  Check the last three lines
+        # of the log since we care about the end result here.
+        self.assertEqual(expected_rclog, entries[-3:])
+
         ordered_network = dev2.get_ordered_network('ssidTKIP')
 
         condition = 'not obj.connected'
@@ -121,10 +129,15 @@ class Test(unittest.TestCase):
                                             hapd.ifname], cleanup=remove_lease)
         IWD.copy_to_storage('ssidTKIP.psk', '/tmp/storage')
 
+        cls.orig_path = os.environ['PATH']
+        os.environ['PATH'] = '/tmp/test-bin:' + os.environ['PATH']
+        IWD.copy_to_storage('resolvconf', '/tmp/test-bin')
+
     @classmethod
     def tearDownClass(cls):
-        IWD.clear_storage(storage_dir='/tmp/storage')
         cls.dhcpd_pid.kill()
+        os.system('rm -rf /tmp/resolvconf.log /tmp/test-bin /tmp/storage')
+        os.environ['PATH'] = cls.orig_path
 
 if __name__ == '__main__':
     unittest.main(exit=True)
-- 
2.34.1

