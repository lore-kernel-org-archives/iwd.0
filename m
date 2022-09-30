Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD594A1C
	for <iwd@lists.linux.dev>; Fri, 30 Sep 2022 14:48:17 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id s14so7250172wro.0
        for <iwd@lists.linux.dev>; Fri, 30 Sep 2022 07:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=iMaxavfTLXazWmcQtc9nWq4m+GDKGpdc/N+p7UrbKzg=;
        b=23yxcF83tIDhQMQZvrXds8sjx3xYJQQXy5diB2lfAP1zQOErU9HyYQdPDbnTuGZSSt
         1vKUvi4zmt0PPn6QLbCx+2L14Z+KNb+HBtdX5B69uPdtJhhe23U+Fapqmn7rXagacONQ
         XWp4uYfHd9C1CHM7RtViXuZs0eOJFVlqDfWdLqh5G27uclAOmKyg/Pi+gjPTn/EkB3z9
         FvyMrSihNSl85+gFLaBKb5NHO7xxxDDuJNvI4uGD/nNH7S1kIbCf0aVLM6aUGcq1P9u3
         xobzm6eAnuyMa7W4urqU7DRLss7E+z9wlwlgraqf7XdLbrsT3xtOb+M67qo6Fm3nccDB
         TDJA==
X-Gm-Message-State: ACrzQf2BmIsrCP+5pVcFLH1/viDOkkn/K1y5LEswJ926G3WFDrELpn+O
	DbILwOyvDpxRGZuUwE919AgJGNqBJgo=
X-Google-Smtp-Source: AMsMyM5CJUSPUVFr+OacAuIkwHGW8Mt94ejYCgdELu6EPW13rV72i6C9HcFRcvyCXE8bDnyOhH/qhQ==
X-Received: by 2002:a5d:46d0:0:b0:22c:de2a:23e with SMTP id g16-20020a5d46d0000000b0022cde2a023emr4077238wrs.12.1664549295747;
        Fri, 30 Sep 2022 07:48:15 -0700 (PDT)
Received: from localhost.localdomain ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c214d00b003b505d26776sm6900284wml.5.2022.09.30.07.48.14
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:48:15 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 1/3] autotests: Add a stateless DHCPv6 test case
Date: Fri, 30 Sep 2022 16:47:59 +0200
Message-Id: <20220930144801.548229-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testNetconfig/stateless_test.py | 162 ++++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 autotests/testNetconfig/stateless_test.py

diff --git a/autotests/testNetconfig/stateless_test.py b/autotests/testNetconfig/stateless_test.py
new file mode 100644
index 00000000..7f01a12a
--- /dev/null
+++ b/autotests/testNetconfig/stateless_test.py
@@ -0,0 +1,162 @@
+#!/usr/bin/python3
+
+import unittest
+import sys
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+from hostapd import HostapdCLI
+import testutil
+from config import ctx
+import os
+import socket
+
+class Test(unittest.TestCase):
+
+    def test_connection_success(self):
+        def check_addr(device):
+            try:
+                testutil.test_ip_address_match(device.name, '3ffe:501:ffff:100::', 128, 64)
+            except:
+                return False
+
+            return True
+
+        def get_ll_addrs6(ns, ifname):
+            show_ip = ns.start_process(['ip', 'addr', 'show', ifname])
+            show_ip.wait()
+            for l in show_ip.out.split('\n'):
+                if 'inet6 fe80::' in l:
+                    return socket.inet_pton(socket.AF_INET6, l.split(None, 1)[1].split('/', 1)[0])
+            return None
+
+        IWD.copy_to_storage('auto.psk', name='ap-ns1.psk')
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
+        # Give the AP's interface time to set up addresses so that radvd can
+        # reply to our Router Solicitation immediately.
+        ctx.non_block_wait(lambda: False, 3, exception=False)
+
+        ordered_network.network_object.connect()
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        testutil.test_iface_operstate()
+
+        ctx.non_block_wait(check_addr, 10, device,
+                            exception=Exception("IPv6 address was not set"))
+
+        # Cannot use test_ifaces_connected() across namespaces (implementation details)
+        testutil.test_ip_connected(('192.168.1.10', ctx), ('192.168.1.1', self.ns1))
+
+        ifname = str(device.name)
+        router_ll_addr = get_ll_addrs6(self.ns1, self.hapd.ifname)
+        expected_routes6 = {
+                # Default router
+                testutil.RouteInfo(gw=router_ll_addr, flags=3, ifname=ifname),
+                # On-link prefixes
+                testutil.RouteInfo(dst=socket.inet_pton(socket.AF_INET6, '3ffe:501:ffff:100::'), plen=64,
+                    flags=1, ifname=ifname),
+                testutil.RouteInfo(dst=socket.inet_pton(socket.AF_INET6, '3ffe:501:ffff:200::'), plen=64,
+                    flags=1, ifname=ifname),
+            }
+        self.maxDiff = None
+        self.assertEqual(expected_routes6, set(testutil.get_routes6(ifname)))
+
+        rclog = open('/tmp/resolvconf.log', 'r')
+        entries = rclog.readlines()
+        rclog.close()
+        expected_rclog = ['-a %s.dns\n' % (ifname,), 'nameserver 192.168.1.2\n',
+                'nameserver 3ffe:501:ffff:100::2\n',
+                '-a %s.domain\n' % (ifname,), 'search test1\n', 'search test2\n']
+        # Every resolvconf -a run overwrites the previous settings.  Check the last six lines
+        # of our log since we care about the end result here.
+        self.assertEqual(expected_rclog, entries[-6:])
+
+        device.disconnect()
+        condition = 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condition)
+        wd.unregister_psk_agent(psk_agent)
+
+    @classmethod
+    def setUpClass(cls):
+        def remove_lease4():
+            try:
+                os.remove('/tmp/dhcpd.leases')
+                os.remove('/tmp/dhcpd.leases~')
+            except:
+                pass
+        def remove_lease6():
+            try:
+                os.remove('/tmp/dhcpd6.leases')
+                os.remove('/tmp/dhcpd6.leases~')
+            except:
+                pass
+
+        cls.ns1 = ctx.get_namespace('ns1')
+        cls.hapd = HostapdCLI('ap-ns1.conf')
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
+        config = open('/tmp/radvd.conf', 'w')
+        config.write('interface ' + cls.hapd.ifname + ''' {
+            AdvSendAdvert on;
+            AdvManagedFlag off;
+            AdvOtherConfigFlag on;
+            # Test that the prefix with longer lifetime is selected.
+            prefix 3ffe:501:ffff:100::/64 { AdvAutonomous on; AdvPreferredLifetime 3605; };
+            prefix 3ffe:501:ffff:200::/64 { AdvAutonomous on; AdvPreferredLifetime 3600; };
+            DNSSL test1 test2 { AdvDNSSLLifetime 3600; };
+            };''')
+        config.close()
+        cls.radvd_pid = cls.ns1.start_process(['radvd', '-n', '-d5',
+                                                '-p', '/tmp/radvd.pid', '-C', '/tmp/radvd.conf'])
+
+        cls.orig_path = os.environ['PATH']
+        os.environ['PATH'] = '/tmp/test-bin:' + os.environ['PATH']
+        IWD.copy_to_storage('resolvconf', '/tmp/test-bin')
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+        cls.ns1.stop_process(cls.dhcpd_pid)
+        cls.dhcpd_pid = None
+        cls.ns1.stop_process(cls.dhcpd6_pid)
+        cls.dhcpd6_pid = None
+        cls.ns1.stop_process(cls.radvd_pid)
+        cls.radvd_pid = None
+        os.system('rm -rf /tmp/radvd.conf /tmp/test-bin')
+        os.environ['PATH'] = cls.orig_path
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
-- 
2.34.1

