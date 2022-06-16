Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B98B29A0
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 00:02:47 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id h19so14087557wrc.12
        for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 17:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCYbkT8Y/GcGOjj+CdSKeM1RT2zg8l3iTRDTSvBYA0s=;
        b=Xjd1eLFOSSfq7Hf9ont9USu1TIDjkd66vJE9c3iLfgx/5vap/aX8N/CHE02b2MZ4lF
         x6I0tlBJKOiSega+Ty4g3ElPm9/9OBIA9IJDAbQY0f7QRwCll5Lb/roYgkiyzYTQwSnr
         Sf2C7d+ZQL8ZlkRIExELl0ixMWe9qjFqhQ5NJckYh3SAIse/Eiq4B7F2EfI1dvbaHl0l
         tTwLcbZc+On52BWXLPzehVqKvrwE7m5pFKjuS2guVHH9ZfDnTtqnt/p9KI/D/d/HcjY+
         +dX7KzN9l9KzQSU//xB7Bc2VMp1OthAqsiaphhHPVJ3AMGgWx3xjPkrTgAUQxcy5mVS+
         57lg==
X-Gm-Message-State: AJIora+hxx0tFkex97tbfpjQ9ssQO+LXeG/Em2fSrth1FqRhjrchNyEZ
	9T4k9vnxkERBQMG+37fjViwD8+MSn/I=
X-Google-Smtp-Source: AGRyM1vCzWBsTQ1TefI07SazyBGIZ/X/s6AefsWbL4S8yQMeyr2SOSAbPFpgb7ukLlopXIWKmcs6nA==
X-Received: by 2002:a5d:598e:0:b0:219:ea16:5a2a with SMTP id n14-20020a5d598e000000b00219ea165a2amr2079644wri.343.1655337766539;
        Wed, 15 Jun 2022 17:02:46 -0700 (PDT)
Received: from iss.Home ([82.213.231.20])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm337452wrb.45.2022.06.15.17.02.45
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:02:46 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 08/15] autotests: Validate netmasks in testNetconfig, add utility
Date: Thu, 16 Jun 2022 02:02:24 +0200
Message-Id: <20220616000231.1966008-8-andrew.zaborowski@intel.com>
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

Extend test_ip_address_match to support IPv6 and to test the
netmask/prefix length while it reads the local address since those are
retrieved using the same API.

Modify testNetconfig to validate the prefix lengths, change the prefix
lengths to be less common values (not 24 bits for IPv4 or 64 for IPv6),
minor cleanup.
---
 autotests/testNetconfig/connection_test.py | 12 ++--
 autotests/testNetconfig/dhcpd-v6.conf      |  2 +-
 autotests/testNetconfig/dhcpd.conf         |  8 +--
 autotests/testNetconfig/ssidTKIP.psk       |  1 +
 autotests/testNetconfig/static_test.py     |  6 +-
 autotests/util/testutil.py                 | 75 ++++++++++++++++++----
 6 files changed, 79 insertions(+), 25 deletions(-)

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNetconfig/connection_test.py
index 672efb72..0334267b 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -11,7 +11,7 @@ from iwd import NetworkType
 from hostapd import HostapdCLI
 import testutil
 from config import ctx
-import os, time
+import os
 import subprocess
 
 class Test(unittest.TestCase):
@@ -19,8 +19,9 @@ class Test(unittest.TestCase):
     def test_connection_success(self):
         def check_addr(device):
             try:
-                subprocess.check_output('ip addr show ' + device.name + \
-                            ' | grep \'inet6 3ffe:501:ffff:100::\'', shell=True)
+                # DHCPv6 addresses always have a prefix length of 128 bits, the actual
+                # subnet's prefix length is in the route.
+                testutil.test_ip_address_match(device.name, '3ffe:501:ffff:100::1', 128, 112)
             except:
                 return False
 
@@ -49,6 +50,7 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
 
+        testutil.test_ip_address_match(device.name, '192.168.1.10', 17, 24)
         ctx.non_block_wait(check_addr, 10, device,
                             exception=Exception("IPv6 address was not set"))
 
@@ -78,14 +80,14 @@ class Test(unittest.TestCase):
         # TODO: This could be moved into test-runner itself if other tests ever
         #       require this functionality (p2p, FILS, etc.). Since its simple
         #       enough it can stay here for now.
-        ctx.start_process(['ip', 'addr','add', '192.168.1.1/255.255.255.0',
+        ctx.start_process(['ip', 'addr','add', '192.168.1.1/255.255.128.0',
                             'dev', hapd.ifname,]).wait()
         ctx.start_process(['touch', '/tmp/dhcpd.leases']).wait()
         cls.dhcpd_pid = ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/dhcpd.conf',
                                             '-lf', '/tmp/dhcpd.leases',
                                             hapd.ifname], cleanup=remove_lease4)
 
-        ctx.start_process(['ip', 'addr', 'add', '3ffe:501:ffff:100::1/64',
+        ctx.start_process(['ip', 'addr', 'add', '3ffe:501:ffff:100::1/72',
                             'dev', hapd.ifname]).wait()
         ctx.start_process(['touch', '/tmp/dhcpd6.leases']).wait()
         cls.dhcpd6_pid = ctx.start_process(['dhcpd', '-6', '-f', '-cf', '/tmp/dhcpd-v6.conf',
diff --git a/autotests/testNetconfig/dhcpd-v6.conf b/autotests/testNetconfig/dhcpd-v6.conf
index 7a22cc65..917ee8a3 100644
--- a/autotests/testNetconfig/dhcpd-v6.conf
+++ b/autotests/testNetconfig/dhcpd-v6.conf
@@ -1,4 +1,4 @@
-subnet6 3ffe:501:ffff:100::/64
+subnet6 3ffe:501:ffff:100::/72
  {
   option dhcp6.name-servers 3ffe:501:ffff:100::1;
   range6 3ffe:501:ffff:100::10 3ffe:501:ffff:100::20;
diff --git a/autotests/testNetconfig/dhcpd.conf b/autotests/testNetconfig/dhcpd.conf
index 0c4fe9b9..ea9957a3 100644
--- a/autotests/testNetconfig/dhcpd.conf
+++ b/autotests/testNetconfig/dhcpd.conf
@@ -1,14 +1,14 @@
 default-lease-time 600;         # 10 minutes
 max-lease-time 7200;            # 2  hours
 
-option broadcast-address 192.168.1.255;
+option broadcast-address 192.168.127.255;
 option routers 192.168.1.254;
-option subnet-mask 255.255.255.0;
+option subnet-mask 255.255.128.0;
 
-subnet 192.168.1.0 netmask 255.255.255.0
+subnet 192.168.0.0 netmask 255.255.128.0
  {
   option routers 192.168.1.1;
-  option subnet-mask 255.255.255.0;
+  option subnet-mask 255.255.128.0;
   option domain-name-servers 192.168.1.1;
   range 192.168.1.10 192.168.1.20;
   range 192.168.1.100 192.168.1.200;
diff --git a/autotests/testNetconfig/ssidTKIP.psk b/autotests/testNetconfig/ssidTKIP.psk
index 64e84f12..eea59cda 100644
--- a/autotests/testNetconfig/ssidTKIP.psk
+++ b/autotests/testNetconfig/ssidTKIP.psk
@@ -1,5 +1,6 @@
 [IPv4]
 Address=192.168.1.10
+Netmask=255.255.255.128
 Gateway=192.168.1.1
 
 [Settings]
diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconfig/static_test.py
index bba2c644..e82dbaeb 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -45,7 +45,7 @@ class Test(unittest.TestCase):
         testutil.test_iface_operstate()
         testutil.test_ifaces_connected()
 
-        testutil.test_ip_address_match(dev1.name, '192.168.1.10')
+        testutil.test_ip_address_match(dev1.name, '192.168.1.10', 25)
 
         ordered_network = dev2.get_ordered_network('ssidTKIP')
 
@@ -79,9 +79,9 @@ class Test(unittest.TestCase):
 
         hapd = HostapdCLI()
         # TODO: This could be moved into test-runner itself if other tests ever
-        #       require this functionality (p2p, FILS, etc.). Since its simple
+        #       require this functionality (p2p, FILS, etc.). Since it's simple
         #       enough it can stay here for now.
-        ctx.start_process(['ip', 'addr','add', '192.168.1.1/255.255.255.0',
+        ctx.start_process(['ip', 'addr','add', '192.168.1.1/255.255.128.0',
                             'dev', hapd.ifname]).wait()
         ctx.start_process(['touch', '/tmp/dhcpd.leases']).wait()
         cls.dhcpd_pid = ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/dhcpd.conf',
diff --git a/autotests/util/testutil.py b/autotests/util/testutil.py
index 01c42654..99cd58f0 100644
--- a/autotests/util/testutil.py
+++ b/autotests/util/testutil.py
@@ -4,6 +4,7 @@ import socket
 import fcntl
 import struct
 import select
+import codecs
 
 import iwd
 from config import ctx
@@ -131,6 +132,7 @@ def test_ifaces_connected(if0=None, if1=None, group=True, expect_fail=False):
 
 SIOCGIFFLAGS = 0x8913
 SIOCGIFADDR = 0x8915
+SIOCGIFNETMASK = 0x891b
 IFF_UP = 1 << 0
 IFF_RUNNING = 1 << 6
 
@@ -156,19 +158,68 @@ def test_iface_operstate(intf=None):
     ctx.non_block_wait(_test_operstate, 10, intf,
                         exception=Exception(intf + ' operstate wrong'))
 
-def test_ip_address_match(intf, ip):
-    try:
-        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
-        addr = fcntl.ioctl(s.fileno(), SIOCGIFADDR, struct.pack('256s', intf.encode('utf-8')))
-        addr = socket.inet_ntoa(addr[20:24])
-    except OSError as e:
-        if e.errno != 99 or ip != None:
-            raise Exception('SIOCGIFADDR failed with %d' % e.errno)
-
-        return
+def get_addrs6(ifname):
+    f = open('/proc/net/if_inet6', 'r')
+    lines = f.readlines()
+    f.close()
+    for line in lines:
+        addr_str, _, plen, _, _, addr_ifname = line.split()
+        if ifname is not None and addr_ifname != ifname:
+            continue
+
+        yield (codecs.decode(addr_str, 'hex'), int(plen, 16), addr_ifname)
+
+def test_ip_address_match(intf, expected_addr_str, expected_plen=None, match_plen=None):
+    def mask_addr(addr, plen):
+        if plen is None or len(addr) * 8 <= plen:
+            return addr
+        bytelen = int(plen / 8)
+        return addr[0:bytelen] + bytes([addr[bytelen] & (0xff00 >> (plen & 7))]) + b'\0' * (len(addr) - bytelen - 1)
+    if expected_addr_str is not None:
+        try:
+            expected_addr = socket.inet_pton(socket.AF_INET, expected_addr_str)
+            family = socket.AF_INET
+        except OSError as e:
+            try:
+                expected_addr = socket.inet_pton(socket.AF_INET6, expected_addr_str)
+                family = socket.AF_INET6
+            except OSError as e2:
+                raise e2 from None
+        expected_addr = mask_addr(expected_addr, match_plen)
+    else:
+        expected_addr = None
+        family = socket.AF_INET
 
-    if ip != addr:
-        raise Exception('IP for %s did not match %s (was %s)' % (intf, ip, addr))
+    if family == socket.AF_INET:
+        try:
+            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+            out = fcntl.ioctl(s.fileno(), SIOCGIFADDR, struct.pack('256s', intf.encode('utf-8')))
+            actual_addr = mask_addr(out[20:24], match_plen)
+            out = fcntl.ioctl(s.fileno(), SIOCGIFNETMASK, struct.pack('256s', intf.encode('utf-8')))
+            actual_plen = sum([sum([(byte >> bit) & 1 for bit in range(0, 8)]) for byte in out[20:24]]) # count bits
+        except OSError as e:
+            if e.errno == 99 and expected_addr is None:
+                return
+
+            raise Exception('SIOCGIFADDR/SIOCGIFNETMASK failed with %d' % e.errno)
+    else:
+        # The "get" ioctls don't work for IPv6, netdevice(7) recommends reading /proc/net instead,
+        # which on the other hand works *only* for IPv6
+        actual_addr = None
+        actual_plen = None
+        for addr, plen, _ in get_addrs6(intf):
+            actual_addr = mask_addr(addr, match_plen)
+            actual_plen = plen
+            if actual_addr == expected_addr:
+                break
+
+    if expected_addr != actual_addr:
+        raise Exception('IP for %s did not match %s (was %s)' %
+                        (intf, expected_addr_str, socket.inet_ntop(family, actual_addr)))
+
+    if expected_plen is not None and expected_plen != actual_plen:
+        raise Exception('Prefix Length for %s did not match %i (was %i)' %
+                        (intf, expected_plen, actual_plen))
 
 def test_ip_connected(tup0, tup1):
     ip0, ns0 = tup0
-- 
2.34.1

