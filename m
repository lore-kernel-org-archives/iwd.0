Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A68623
	for <iwd@lists.linux.dev>; Sat,  9 Jul 2022 00:23:49 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id t25so250750lfg.7
        for <iwd@lists.linux.dev>; Fri, 08 Jul 2022 17:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dLeBLlFb2VWCq8mi5cBvb2tZCHs9jRN+Oh5Yaj39gms=;
        b=erdHmZt8WVMlE5dKD/VsVlm6IC6Imi65xeFQ+b8DQn4t+r0BIPDijgCdDKvK35Wv0v
         VK9EPAfo7qfQAe95hH2GqUwHhv5/8RBCF8QW1TDLJhkU78TUNfEnXRVyd2h5F4qzYKnn
         amwBUWvaTGHErCZL/dbwe6E/m+Euo1qi2yPD/sZDd+nsSzKHPYo6aRmnbFiL2b6smTQh
         cQWS+Nh2FZ10J3nYiY1V6sAa5wrjyKgBw78fDzZT5VdGTV63nknz29JQcqtQ/xWWBgjp
         5nqjOd2onNcYjDIxMmJjVbDDC8ddTR9FRsed6sdoibmgvTKf9CqEVinlZBZh1AvBVP9W
         85rg==
X-Gm-Message-State: AJIora8zVJdjt7zCvzlx21Ewm7dMvEVFyYm7AXU9PNsLY2BOnreomGyJ
	eRuF9Xcyp+cpzcGypu/V/yJnhb85OWTVP1bs
X-Google-Smtp-Source: AGRyM1uXozJGDrLvG3dW5WZnH6iWHgy9/sw6PiXE5/NZ74p16QfBPtD3ezvLR6LmyAtMxtr2p7656A==
X-Received: by 2002:a05:6512:12c7:b0:481:51ff:d027 with SMTP id p7-20020a05651212c700b0048151ffd027mr3937814lfg.577.1657326226999;
        Fri, 08 Jul 2022 17:23:46 -0700 (PDT)
Received: from localhost.localdomain (public-gprs650242.centertel.pl. [5.184.83.67])
        by smtp.gmail.com with ESMTPSA id f19-20020ac25333000000b00478fe690207sm75603lfh.286.2022.07.08.17.23.45
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 17:23:46 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH v3 2/4] autotests: DHCPv4 renewal/resend test in testNetconfig
Date: Sat,  9 Jul 2022 02:23:32 +0200
Message-Id: <20220709002334.3329502-2-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220709002334.3329502-1-andrew.zaborowski@intel.com>
References: <20220709002334.3329502-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that the DHCPv4 lease got renewed after the T1 timer runs out.
Then also simulate the DHCPREQUEST during renew being lost and
retransmitted and the lease eventually getting renewed T1 + 60s later.

The main downside is that this test will inevitably take a while if
running in Qemu without the time travel ability.

Update the test and some utility code to run hostapd in an isolated net
namespace for connection_test.py.  We now need a second hostapd
instance though because in static_test.py we test ACD and we need to
produce an IP conflict.  Moving the hostapd instance unexpectedly fixes
dhcpd's internal mechanism to avoid IP conflicts and it would no longer
assign 192.168.1.10 to the second client, it'd notice that address was
already in use and assign the next free address, or fail if there was
none.  So add a second hostapd instance that runs in the main namespace
together with the statically-configured client, it turns out the test
relies on the kernel being unable to deliver IP traffic to interfaces on
the same system.
---
 .../{ssidTKIP.conf => ap-main.conf}           |   2 +-
 autotests/testNetconfig/ap-ns1.conf           |   7 +
 autotests/testNetconfig/connection_test.py    | 195 +++++++++++++++---
 autotests/testNetconfig/dhcpd.conf            |  14 +-
 autotests/testNetconfig/hw.conf               |   8 +-
 .../{ssidTKIP.psk => static.psk}              |   0
 autotests/testNetconfig/static_test.py        |   8 +-
 autotests/util/hostapd.py                     |   6 +-
 8 files changed, 202 insertions(+), 38 deletions(-)
 rename autotests/testNetconfig/{ssidTKIP.conf => ap-main.conf} (83%)
 create mode 100644 autotests/testNetconfig/ap-ns1.conf
 rename autotests/testNetconfig/{ssidTKIP.psk => static.psk} (100%)

diff --git a/autotests/testNetconfig/ssidTKIP.conf b/autotests/testNetconfig/ap-main.conf
similarity index 83%
rename from autotests/testNetconfig/ssidTKIP.conf
rename to autotests/testNetconfig/ap-main.conf
index 11ef15f0..0ec7fdfa 100644
--- a/autotests/testNetconfig/ssidTKIP.conf
+++ b/autotests/testNetconfig/ap-main.conf
@@ -1,6 +1,6 @@
 hw_mode=g
 channel=1
-ssid=ssidTKIP
+ssid=ap-main
 
 wpa=1
 wpa_pairwise=TKIP
diff --git a/autotests/testNetconfig/ap-ns1.conf b/autotests/testNetconfig/ap-ns1.conf
new file mode 100644
index 00000000..5459173f
--- /dev/null
+++ b/autotests/testNetconfig/ap-ns1.conf
@@ -0,0 +1,7 @@
+hw_mode=g
+channel=1
+ssid=ap-ns1
+
+wpa=1
+wpa_pairwise=TKIP
+wpa_passphrase=secret123
diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNetconfig/connection_test.py
index 5481e624..aebb0a2e 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -13,6 +13,7 @@ import testutil
 from config import ctx
 import os
 import socket
+import datetime, time
 
 class Test(unittest.TestCase):
 
@@ -27,6 +28,14 @@ class Test(unittest.TestCase):
 
             return True
 
+        def get_ll_addrs6(ns, ifname):
+            show_ip = ns.start_process(['ip', 'addr', 'show', ifname])
+            show_ip.wait()
+            for l in show_ip.out.split('\n'):
+                if 'inet6 fe80::' in l:
+                    return socket.inet_pton(socket.AF_INET6, l.split(None, 1)[1].split('/', 1)[0])
+            return None
+
         wd = IWD(True)
 
         psk_agent = PSKAgent("secret123")
@@ -35,7 +44,7 @@ class Test(unittest.TestCase):
         devices = wd.list_devices(1)
         device = devices[0]
 
-        ordered_network = device.get_ordered_network('ssidTKIP')
+        ordered_network = device.get_ordered_network('ap-ns1')
 
         self.assertEqual(ordered_network.type, NetworkType.psk)
 
@@ -46,18 +55,21 @@ class Test(unittest.TestCase):
 
         condition = 'obj.state == DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
+        connect_time = time.time()
 
         testutil.test_iface_operstate()
-        testutil.test_ifaces_connected()
 
         testutil.test_ip_address_match(device.name, '192.168.1.10', 17, 24)
         ctx.non_block_wait(check_addr, 10, device,
                             exception=Exception("IPv6 address was not set"))
 
+        # Cannot use test_ifaces_connected() across namespaces (implementation details)
+        testutil.test_ip_connected(('192.168.1.10', ctx), ('192.168.1.1', self.ns1))
+
         ifname = str(device.name)
-        router_ll_addr = [addr for addr, _, _ in testutil.get_addrs6(self.hapd.ifname) if addr[0:2] == b'\xfe\x80'][0]
+        router_ll_addr = get_ll_addrs6(self.ns1, self.hapd.ifname)
         # Since we're in an isolated VM with freshly created interfaces we know any routes
-        # will have been created by IWD and don't have to allow for pre-existing routes
+        # will have been created by IWD and we don't have to allow for pre-existing routes
         # in the table.
         # Flags: 1=RTF_UP, 2=RTF_GATEWAY
         expected_routes4 = {
@@ -94,6 +106,67 @@ class Test(unittest.TestCase):
         # of our log since we care about the end result here.
         self.assertEqual(expected_rclog, entries[-3:])
 
+        leases_file = self.parse_lease_file('/tmp/dhcpd.leases', socket.AF_INET)
+        lease = leases_file['leases'][socket.inet_pton(socket.AF_INET, '192.168.1.10')]
+        self.assertEqual(lease['state'], 'active')
+        self.assertTrue(lease['starts'] < connect_time)
+        self.assertTrue(lease['ends'] > connect_time)
+        # The T1 is 15 seconds per dhcpd.conf.  This is the approximate interval between lease
+        # renewals we should see from the client (+/- 1 second + some jitter).  Wait a little
+        # less than twice that time (25s) so that we can expect the lease was renewed strictly
+        # once (not 0 or 2 times) by that time, check that the lease timestamps have changed by
+        # at least 10s so as to leave a lot of margin.
+        renew_time = lease['starts'] + 15
+        now = time.time()
+        ctx.non_block_wait(lambda: False, renew_time + 10 - now, exception=False)
+
+        leases_file = self.parse_lease_file('/tmp/dhcpd.leases', socket.AF_INET)
+        new_lease = leases_file['leases'][socket.inet_pton(socket.AF_INET, '192.168.1.10')]
+        self.assertEqual(new_lease['state'], 'active')
+        self.assertTrue(new_lease['starts'] > lease['starts'] + 10)
+        self.assertTrue(new_lease['starts'] < lease['starts'] + 25)
+        self.assertTrue(new_lease['ends'] > lease['ends'] + 10)
+        self.assertTrue(new_lease['ends'] < lease['ends'] + 25)
+
+        # Now wait another T1 seconds but don't let our DHCP client get its REQUEST out this
+        # time so as to test renew timeouts and resends.  The retry interval is 60 seconds
+        # since (T2 - T1) / 2 is shorter than 60s.  It is now about 10s since the last
+        # renewal or 5s before the next DHCPREQUEST frame that is going to be lost.  We'll
+        # wait T1 seconds, so until about 10s after the failed attempt, we'll check that
+        # there was no renewal by that time, just in case, and we'll reenable frame delivery.
+        # We'll then wait another 60s and we should see the lease has been successfully
+        # renewed some 10 seconds earlier on the 1st DHCPREQUEST retransmission.
+        #
+        # We can't use hswim to block the frames from reaching the AP because we'd lose
+        # beacons and get disconnected.  We also can't drop our subnet route or IP address
+        # because IWD's sendto() call would synchronously error out and the DHCP client
+        # would just give up.  Add a false route to break routing to 192.168.1.1 and delete
+        # it afterwards.
+        os.system('ip route add 192.168.1.1/32 dev ' + ifname  + ' via 192.168.1.100 preference 0')
+
+        lease = new_lease
+        renew_time = lease['starts'] + 15
+        now = time.time()
+        ctx.non_block_wait(lambda: False, renew_time + 10 - now, exception=False)
+
+        leases_file = self.parse_lease_file('/tmp/dhcpd.leases', socket.AF_INET)
+        new_lease = leases_file['leases'][socket.inet_pton(socket.AF_INET, '192.168.1.10')]
+        self.assertEqual(new_lease['starts'], lease['starts'])
+
+        os.system('ip route del 192.168.1.1/32 dev ' + ifname  + ' via 192.168.1.100 preference 0')
+
+        retry_time = lease['starts'] + 75
+        now = time.time()
+        ctx.non_block_wait(lambda: False, retry_time + 10 - now, exception=False)
+
+        leases_file = self.parse_lease_file('/tmp/dhcpd.leases', socket.AF_INET)
+        new_lease = leases_file['leases'][socket.inet_pton(socket.AF_INET, '192.168.1.10')]
+        self.assertEqual(new_lease['state'], 'active')
+        self.assertTrue(new_lease['starts'] > lease['starts'] + 70)
+        self.assertTrue(new_lease['starts'] < lease['starts'] + 85)
+        self.assertTrue(new_lease['ends'] > lease['ends'] + 70)
+        self.assertTrue(new_lease['ends'] < lease['ends'] + 85)
+
         device.disconnect()
 
         condition = 'not obj.connected'
@@ -116,25 +189,27 @@ class Test(unittest.TestCase):
             except:
                 pass
 
-        hapd = HostapdCLI()
-        cls.hapd = hapd
+        cls.ns1 = ctx.get_namespace('ns1')
+        cls.hapd = HostapdCLI('ap-ns1.conf')
         # TODO: This could be moved into test-runner itself if other tests ever
         #       require this functionality (p2p, FILS, etc.). Since its simple
         #       enough it can stay here for now.
-        ctx.start_process(['ip', 'addr','add', '192.168.1.1/255.255.128.0',
-                            'dev', hapd.ifname,]).wait()
-        ctx.start_process(['touch', '/tmp/dhcpd.leases']).wait()
-        cls.dhcpd_pid = ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/dhcpd.conf',
-                                            '-lf', '/tmp/dhcpd.leases',
-                                            hapd.ifname], cleanup=remove_lease4)
-
-        ctx.start_process(['ip', 'addr', 'add', '3ffe:501:ffff:100::1/72',
-                            'dev', hapd.ifname]).wait()
-        ctx.start_process(['touch', '/tmp/dhcpd6.leases']).wait()
-        cls.dhcpd6_pid = ctx.start_process(['dhcpd', '-6', '-f', '-cf', '/tmp/dhcpd-v6.conf',
-                                            '-lf', '/tmp/dhcpd6.leases',
-                                            hapd.ifname], cleanup=remove_lease6)
-        ctx.start_process(['sysctl', 'net.ipv6.conf.' + hapd.ifname + '.forwarding=1']).wait()
+        cls.ns1.start_process(['ip', 'addr','add', '192.168.1.1/17',
+                            'dev', cls.hapd.ifname]).wait()
+        cls.ns1.start_process(['touch', '/tmp/dhcpd.leases']).wait()
+        cls.dhcpd_pid = cls.ns1.start_process(['dhcpd', '-f', '-d', '-cf', '/tmp/dhcpd.conf',
+                                                '-lf', '/tmp/dhcpd.leases',
+                                                cls.hapd.ifname], cleanup=remove_lease4)
+
+        cls.ns1.start_process(['ip', 'addr', 'add', '3ffe:501:ffff:100::1/72',
+                            'dev', cls.hapd.ifname]).wait()
+        cls.ns1.start_process(['touch', '/tmp/dhcpd6.leases']).wait()
+        cls.dhcpd6_pid = cls.ns1.start_process(['dhcpd', '-6', '-f', '-d',
+                                                '-cf', '/tmp/dhcpd-v6.conf',
+                                                '-lf', '/tmp/dhcpd6.leases',
+                                                cls.hapd.ifname], cleanup=remove_lease6)
+        cls.ns1.start_process(['sysctl',
+                                'net.ipv6.conf.' + cls.hapd.ifname + '.forwarding=1']).wait()
         # Send out Router Advertisements telling clients to use DHCPv6.
         # Note trying to send the RAs from the router's global IPv6 address by adding a
         # "AdvRASrcAddress { 3ffe:501:ffff:100::1; };" line will fail because the client
@@ -142,7 +217,7 @@ class Test(unittest.TestCase):
         # with a non-link-local gateway address that is present on another interface in the
         # same namespace.
         config = open('/tmp/radvd.conf', 'w')
-        config.write('interface ' + hapd.ifname + ''' {
+        config.write('interface ' + cls.hapd.ifname + ''' {
             AdvSendAdvert on;
             AdvManagedFlag on;
             prefix 3ffe:501:ffff:100::/72 { AdvAutonomous off; };
@@ -151,7 +226,8 @@ class Test(unittest.TestCase):
             route 3ffe:501:ffff:500::/66 { AdvRoutePreference high; };
             };''')
         config.close()
-        cls.radvd_pid = ctx.start_process(['radvd', '-n', '-d5', '-p', '/tmp/radvd.pid', '-C', '/tmp/radvd.conf'])
+        cls.radvd_pid = cls.ns1.start_process(['radvd', '-n', '-d5',
+                                                '-p', '/tmp/radvd.pid', '-C', '/tmp/radvd.conf'])
 
         cls.orig_path = os.environ['PATH']
         os.environ['PATH'] = '/tmp/test-bin:' + os.environ['PATH']
@@ -160,14 +236,83 @@ class Test(unittest.TestCase):
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
-        ctx.stop_process(cls.dhcpd_pid)
+        cls.ns1.stop_process(cls.dhcpd_pid)
         cls.dhcpd_pid = None
-        ctx.stop_process(cls.dhcpd6_pid)
+        cls.ns1.stop_process(cls.dhcpd6_pid)
         cls.dhcpd6_pid = None
-        ctx.stop_process(cls.radvd_pid)
+        cls.ns1.stop_process(cls.radvd_pid)
         cls.radvd_pid = None
         os.system('rm -rf /tmp/radvd.conf /tmp/resolvconf.log /tmp/test-bin')
         os.environ['PATH'] = cls.orig_path
 
+    @staticmethod
+    def parse_lease_file(path, family):
+        file = open(path, 'r')
+        lines = file.readlines()
+        file.close()
+
+        stack = [[]]
+        statement = []
+        token = ''
+        for line in lines:
+            whitespace = False
+            quote = False
+            for ch in line:
+                if not quote and ch in ' \t\r\n;{}=#':
+                    if len(token):
+                        statement.append(token)
+                        token = ''
+                if not quote and ch in ';{}':
+                    if len(statement):
+                        stack[-1].append(statement)
+                        statement = []
+                if ch == '"':
+                    quote = not quote
+                elif quote or ch not in ' \t\r\n;{}#':
+                    token += ch
+                if ch == '#':
+                    break
+                elif ch == '{':
+                    stack.append([])
+                elif ch == '}':
+                    statements = stack.pop()
+                    stack[-1][-1].append(statements)
+            if len(token):
+                statement.append(token)
+                token = ''
+        if len(statement):
+            stack[-1].append(statement)
+        statements = stack.pop(0)
+        if len(stack):
+            raise Exception('Unclosed block(s)')
+
+        contents = {'leases':{}}
+        for s in statements:
+            if s[0] == 'lease':
+                ip = socket.inet_pton(family, s[1])
+                lease = {}
+                for param in s[2]:
+                    if param[0] in ('starts', 'ends', 'tstp', 'tsfp', 'atsfp', 'cltt'):
+                        weekday = param[1]
+                        year, month, day = param[2].split('/')
+                        hour, minute, second = param[3].split(':')
+                        dt = datetime.datetime(
+                                int(year), int(month), int(day),
+                                int(hour), int(minute), int(second),
+                                tzinfo=datetime.timezone.utc)
+                        lease[param[0]] = dt.timestamp()
+                    elif param[0:2] == ['binding', 'state']:
+                        lease['state'] = param[2]
+                    elif param[0:2] == ['hardware', 'ethernet']:
+                        lease['hwaddr'] = bytes([int(v, 16) for v in param[2].split(':')])
+                    elif param[0] in ('preferred-life', 'max-life'):
+                        lease[param[0]] = int(param[1])
+                    elif param[0] in ('client-hostname'):
+                        lease[param[0]] = param[1]
+                contents['leases'][ip] = lease # New entries overwrite older ones
+            elif s[0] == 'server-duid':
+                contents[s[0]] = s[1]
+        return contents
+
 if __name__ == '__main__':
     unittest.main(exit=True)
diff --git a/autotests/testNetconfig/dhcpd.conf b/autotests/testNetconfig/dhcpd.conf
index d8a9d24c..0a154637 100644
--- a/autotests/testNetconfig/dhcpd.conf
+++ b/autotests/testNetconfig/dhcpd.conf
@@ -1,5 +1,15 @@
-default-lease-time 600;         # 10 minutes
-max-lease-time 7200;            # 2  hours
+default-lease-time 120;         # 2 minutes
+min-lease-time 120;             # 2 minutes
+max-lease-time 120;             # 2 minutes
+option dhcp-renewal-time 15;    # 15 secs for T1
+# We set a relatively low lease lifetime of 2 minutes but our renewal interval
+# (T1) is still unproportionally low to speed the test up -- 12% instead of the
+# default 50% lifetime value.  We need a lifetime in the order of minutes
+# because minimum lease renewal retry interval is 60s per spec.  However by
+# default dhcpd will not renew leases that are newer than 25% their lifetime.
+# Set that threshold to 1% so that we can verify that the lease is renewed
+# without waiting too long.
+dhcp-cache-threshold 1;
 
 option broadcast-address 192.168.127.255;
 option routers 192.168.1.254;
diff --git a/autotests/testNetconfig/hw.conf b/autotests/testNetconfig/hw.conf
index d5adc9ad..edf656d6 100644
--- a/autotests/testNetconfig/hw.conf
+++ b/autotests/testNetconfig/hw.conf
@@ -1,9 +1,11 @@
 [SETUP]
-num_radios=3
+num_radios=4
 start_iwd=0
 
 [HOSTAPD]
-rad0=ssidTKIP.conf
+rad2=ap-main.conf
+rad3=ap-ns1.conf
 
 [NameSpaces]
-ns0=rad2
+ns0=rad0
+ns1=rad3
diff --git a/autotests/testNetconfig/ssidTKIP.psk b/autotests/testNetconfig/static.psk
similarity index 100%
rename from autotests/testNetconfig/ssidTKIP.psk
rename to autotests/testNetconfig/static.psk
diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconfig/static_test.py
index d9f0b9cb..01d694ca 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -32,7 +32,7 @@ class Test(unittest.TestCase):
         dev1 = wd.list_devices(1)[0]
         dev2 = wd_ns0.list_devices(1)[0]
 
-        ordered_network = dev1.get_ordered_network('ssidTKIP')
+        ordered_network = dev1.get_ordered_network('ap-main')
 
         self.assertEqual(ordered_network.type, NetworkType.psk)
 
@@ -80,7 +80,7 @@ class Test(unittest.TestCase):
         # of the log since we care about the end result here.
         self.assertEqual(expected_rclog, entries[-3:])
 
-        ordered_network = dev2.get_ordered_network('ssidTKIP')
+        ordered_network = dev2.get_ordered_network('ap-main')
 
         condition = 'not obj.connected'
         wd_ns0.wait_for_object_condition(ordered_network.network_object, condition)
@@ -117,7 +117,7 @@ class Test(unittest.TestCase):
             except:
                 pass
 
-        hapd = HostapdCLI()
+        hapd = HostapdCLI('ap-main.conf')
         # TODO: This could be moved into test-runner itself if other tests ever
         #       require this functionality (p2p, FILS, etc.). Since it's simple
         #       enough it can stay here for now.
@@ -127,7 +127,7 @@ class Test(unittest.TestCase):
         cls.dhcpd_pid = ctx.start_process(['dhcpd', '-f', '-cf', '/tmp/dhcpd.conf',
                                             '-lf', '/tmp/dhcpd.leases',
                                             hapd.ifname], cleanup=remove_lease)
-        IWD.copy_to_storage('ssidTKIP.psk', '/tmp/storage')
+        IWD.copy_to_storage('static.psk', '/tmp/storage', 'ap-main.psk')
 
         cls.orig_path = os.environ['PATH']
         os.environ['PATH'] = '/tmp/test-bin:' + os.environ['PATH']
diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 758427fe..3ae8ff89 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -33,7 +33,7 @@ class HostapdCLI(object):
     _instances = WeakValueDictionary()
 
     def __new__(cls, config=None, *args, **kwargs):
-        hapd = ctx.hostapd[config]
+        hapd = ctx.get_hapd_instance(config)
 
         if not config:
             config = hapd.config
@@ -58,10 +58,10 @@ class HostapdCLI(object):
         if not ctx.hostapd:
             raise Exception("No hostapd instances are configured")
 
-        if not config and len(ctx.hostapd.instances) > 1:
+        if not config and sum([len(hapd.instances) for hapd in ctx.hostapd]) > 1:
             raise Exception('config must be provided if more than one hostapd instance exists')
 
-        hapd = ctx.hostapd[config]
+        hapd = ctx.get_hapd_instance(config)
 
         self.interface = hapd.intf
         self.config = hapd.config
-- 
2.34.1

