Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728CC7E
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 00:02:52 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so1962533wms.5
        for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 17:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6neVS8Y7XadG0t7GyDUY1ZqNEW6EvnmhpKjuIamiTpI=;
        b=ZSFbIVfra+sFrFbmyi7ot2XAqjj0oXJo5omxbg0XT3reNLaTJPWn+tH2qYmGE66oRh
         omHRx69RM4SnF9qh/vhS7Za5aShcYUpW/cOdBdo9NpWmIvY0nfkG05M+u4jqWIgvsjYo
         69G9G1YYMDcS4KoneWBEHJiuoc55KqDkOSYWEC4+8P8QpzYzTSjD81BVMwYi9QD6pkQA
         GTjuusxf18Xr/86g160yb+SS0vOwtwWCUYHx2myNRYuY++cxvHqlHy72KWxZ1eerAqge
         Mkjc+AabVAu8ytcMXorTi1iFeWLGvXmKFezXaIIiMkZ/7B5q0+Ra9XDPQAp0ddVlPBfN
         5YyQ==
X-Gm-Message-State: AJIora9zgkt3Px8D4PWbD3LKP/0wyG/Bq8/3qKDbidLiNDlQ84tpuCiP
	R2lM67gFxgYYDYTAvlkjsgOwmbsOhuA=
X-Google-Smtp-Source: AGRyM1vuqYb37p+X5VSx0NS3GvC2u+ZPcwWEOQ1f9cbQf3T+5XBg+Zn43FilvShUYo4u6pTz55Dlig==
X-Received: by 2002:a05:600c:501f:b0:39d:a3d:e919 with SMTP id n31-20020a05600c501f00b0039d0a3de919mr2018816wmr.132.1655337770166;
        Wed, 15 Jun 2022 17:02:50 -0700 (PDT)
Received: from iss.Home ([82.213.231.20])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm337452wrb.45.2022.06.15.17.02.49
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:02:49 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 11/15] autotests: In testNetconfig verify routes created
Date: Thu, 16 Jun 2022 02:02:27 +0200
Message-Id: <20220616000231.1966008-11-andrew.zaborowski@intel.com>
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

Check that the right set of routes is being added for IPv4 and IPv6.
Chane gateway addresses to differ from the AP or dhcpd addresses.
---
 autotests/testNetconfig/connection_test.py | 39 +++++++++++++--
 autotests/testNetconfig/ssidTKIP.psk       |  4 +-
 autotests/testNetconfig/static_test.py     | 23 +++++++++
 autotests/util/testutil.py                 | 57 ++++++++++++++++++++++
 4 files changed, 118 insertions(+), 5 deletions(-)

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNetconfig/connection_test.py
index 0334267b..db3327ef 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -12,7 +12,7 @@ from hostapd import HostapdCLI
 import testutil
 from config import ctx
 import os
-import subprocess
+import socket
 
 class Test(unittest.TestCase):
 
@@ -54,6 +54,29 @@ class Test(unittest.TestCase):
         ctx.non_block_wait(check_addr, 10, device,
                             exception=Exception("IPv6 address was not set"))
 
+        ifname = str(device.name)
+        router_ll_addr = [addr for addr, _, _ in testutil.get_addrs6(self.hapd.ifname) if addr[0:2] == b'\xfe\x80'][0]
+        # Since we're in an isolated VM with freshly created interfaces we know any routes
+        # will have been created by IWD and don't have to allow for pre-existing routes
+        # in the table.
+        # Flags: 1=RTF_UP, 2=RTF_GATEWAY
+        expected_routes4 = {
+                testutil.RouteInfo(gw=socket.inet_pton(socket.AF_INET, '192.168.1.1'),
+                    flags=3, ifname=ifname),
+                testutil.RouteInfo(dst=socket.inet_pton(socket.AF_INET, '192.168.0.0'), plen=17,
+                    flags=1, ifname=ifname)
+            }
+        expected_routes6 = {
+                # Default router
+                testutil.RouteInfo(gw=router_ll_addr, flags=3, ifname=ifname),
+                # On-link prefix
+                testutil.RouteInfo(dst=socket.inet_pton(socket.AF_INET6, '3ffe:501:ffff:100::'), plen=72,
+                    flags=1, ifname=ifname),
+            }
+        self.maxDiff = None
+        self.assertEqual(expected_routes4, set(testutil.get_routes4(ifname)))
+        self.assertEqual(expected_routes6, set(testutil.get_routes6(ifname)))
+
         device.disconnect()
 
         condition = 'not obj.connected'
@@ -77,6 +100,7 @@ class Test(unittest.TestCase):
                 pass
 
         hapd = HostapdCLI()
+        cls.hapd = hapd
         # TODO: This could be moved into test-runner itself if other tests ever
         #       require this functionality (p2p, FILS, etc.). Since its simple
         #       enough it can stay here for now.
@@ -94,9 +118,18 @@ class Test(unittest.TestCase):
                                             '-lf', '/tmp/dhcpd6.leases',
                                             hapd.ifname], cleanup=remove_lease6)
         ctx.start_process(['sysctl', 'net.ipv6.conf.' + hapd.ifname + '.forwarding=1']).wait()
-        # Tell clients to use DHCPv6
+        # Send out Router Advertisements telling clients to use DHCPv6.
+        # Note trying to send the RAs from the router's global IPv6 address by adding a
+        # "AdvRASrcAddress { 3ffe:501:ffff:100::1; };" line will fail because the client
+        # and the router interfaces are in the same namespace and Linux won't allow routes
+        # with a non-link-local gateway address that is present on another interface in the
+        # same namespace.
         config = open('/tmp/radvd.conf', 'w')
-        config.write('interface ' + hapd.ifname + ' { AdvSendAdvert on; AdvManagedFlag on; };')
+        config.write('interface ' + hapd.ifname + ''' {
+            AdvSendAdvert on;
+            AdvManagedFlag on;
+            prefix 3ffe:501:ffff:100::/72 { AdvAutonomous off; };
+            };''')
         config.close()
         cls.radvd_pid = ctx.start_process(['radvd', '-n', '-d5', '-p', '/tmp/radvd.pid', '-C', '/tmp/radvd.conf'])
 
diff --git a/autotests/testNetconfig/ssidTKIP.psk b/autotests/testNetconfig/ssidTKIP.psk
index 72a71ce9..e371c97f 100644
--- a/autotests/testNetconfig/ssidTKIP.psk
+++ b/autotests/testNetconfig/ssidTKIP.psk
@@ -3,12 +3,12 @@
 # as DHCP would assign us to produce a conflict and test ACD
 Address=192.168.1.10
 Netmask=255.255.255.128
-Gateway=192.168.1.1
+Gateway=192.168.1.3
 
 [IPv6]
 # Use a different subnet than DHCP on purpose
 Address=3ffe:501:ffff:200::10/80
-Gateway=3ffe:501:ffff:200::1
+Gateway=3ffe:501:ffff:200::3
 
 [Settings]
 AutoConnect=false
diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconfig/static_test.py
index a3b294a2..cd147894 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -12,6 +12,7 @@ from hostapd import HostapdCLI
 import testutil
 from config import ctx
 import os
+import socket
 
 class Test(unittest.TestCase):
 
@@ -49,6 +50,28 @@ class Test(unittest.TestCase):
         testutil.test_ip_address_match(dev1.name, '192.168.1.10', 25)
         testutil.test_ip_address_match(dev1.name, '3ffe:501:ffff:200::10', 80)
 
+        ifname = str(dev1.name)
+        # Since we're in an isolated VM with freshly created interfaces we know any routes
+        # will have been created by IWD and don't have to allow for pre-existing routes
+        # in the table.
+        # Flags: 1=RTF_UP, 2=RTF_GATEWAY
+        expected_routes4 = {
+                testutil.RouteInfo(gw=socket.inet_pton(socket.AF_INET, '192.168.1.3'),
+                    flags=3, ifname=ifname),
+                testutil.RouteInfo(dst=socket.inet_pton(socket.AF_INET, '192.168.1.0'), plen=25,
+                    flags=1, ifname=ifname)
+            }
+        expected_routes6 = {
+                testutil.RouteInfo(gw=socket.inet_pton(socket.AF_INET6, '3ffe:501:ffff:200::3'),
+                    flags=3, ifname=ifname),
+                testutil.RouteInfo(dst=socket.inet_pton(socket.AF_INET6, '3ffe:501:ffff:200::'), plen=80,
+                    flags=1, ifname=ifname),
+            }
+
+        self.maxDiff = None
+        self.assertEqual(expected_routes4, set(testutil.get_routes4(ifname)))
+        self.assertEqual(expected_routes6, set(testutil.get_routes6(ifname)))
+
         ordered_network = dev2.get_ordered_network('ssidTKIP')
 
         condition = 'not obj.connected'
diff --git a/autotests/util/testutil.py b/autotests/util/testutil.py
index 99cd58f0..eae4dd89 100644
--- a/autotests/util/testutil.py
+++ b/autotests/util/testutil.py
@@ -5,6 +5,7 @@ import fcntl
 import struct
 import select
 import codecs
+import collections
 
 import iwd
 from config import ctx
@@ -230,3 +231,59 @@ def test_ip_connected(tup0, tup1):
         ns1.start_process(['ping', '-c', '5', '-i', '0.2', ip0], check=True)
     except:
         raise Exception('Could not ping between %s and %s' % (ip0, ip1))
+
+RouteInfo = collections.namedtuple('RouteInfo', 'dst plen gw flags ifname',
+        defaults=(None, None, None, 0, ''))
+
+def get_routes4(ifname=None):
+    f = open('/proc/net/route', 'r')
+    lines = f.readlines()
+    f.close()
+    for line in lines[1:]: # Skip header line
+        route_ifname, dst_str, gw_str, flags, ref_cnt, use_cnt, metric, mask_str, \
+                mtu = line.strip().split(maxsplit=8)
+        if ifname is not None and route_ifname != ifname:
+            continue
+
+        dst = codecs.decode(dst_str, 'hex')[::-1]
+        mask = int(mask_str, 16)
+        plen = sum([(mask >> bit) & 1 for bit in range(0, 32)]) # count bits
+        gw = codecs.decode(gw_str, 'hex')[::-1]
+
+        if dst == b'\0\0\0\0':
+            dst = None
+            plen = None
+        if gw == b'\0\0\0\0':
+            gw = None
+        yield RouteInfo(dst, plen, gw, int(flags, 16), route_ifname)
+
+def get_routes6(ifname=None):
+    f = open('/proc/net/ipv6_route', 'r')
+    lines = f.readlines()
+    f.close()
+    for line in lines:
+        dst_str, dst_plen_str, src_str, src_plen_str, gw_str, metric, ref_cnt, \
+                use_cnt, flags, route_ifname = line.strip().split(maxsplit=9)
+        if ifname is not None and route_ifname != ifname:
+            continue
+
+        dst = codecs.decode(dst_str, 'hex')
+        plen = int(dst_plen_str, 16)
+        gw = codecs.decode(gw_str, 'hex')
+
+        if dst[0] == 0xff or dst[:2] == b'\xfe\x80': # Skip link-local and multicast
+            continue
+
+        # Skip RTN_LOCAL-type routes, we don't need to validate them since they're added by
+        # the kernel and we can't simply add them to the expected list (the list that we
+        # validate against) because they're added a short time after an address (due to DAD?)
+        # and would create race conditions
+        if int(flags, 16) & (1 << 31):
+            continue
+
+        if dst == b'\0' * 16:
+            dst = None
+            plen = None
+        if gw == b'\0' * 16:
+            gw = None
+        yield RouteInfo(dst, plen, gw, int(flags, 16) & 0xf, route_ifname)
-- 
2.34.1

