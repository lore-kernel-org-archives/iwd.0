Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BCF2562
	for <iwd@lists.linux.dev>; Tue, 20 Sep 2022 14:05:39 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id a26so6461146ejc.4
        for <iwd@lists.linux.dev>; Tue, 20 Sep 2022 07:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tenBVMltJIKYeeoj2NljPhqY39VFE9yf2cqRCDhzgyc=;
        b=JINIU/kF/DmUslTsoBwstalr8h1XXf8FZYK0FB2a8c4VzOlCIKrQI5RKRrlspL/JTd
         YisppRuxR9qNm7/iVzuq0psXZ43LqLFEPEvwH0XUc4B6q2mAM4B1tTMFk+bzXvFpq2F4
         J/sPp6Ob6K9NqIogU2suIte6NmXEgBp2rtpEHjjUPKCdAGAihqXWm6lzXFvRaFx+qioP
         IqTQbanjcRP2Z7wkB6XrfXNCvDXIq5eU4FK1tOHM/4lHJFr8lZebNmfrY8EB6dlbE6rG
         ByWTjo6nGdjhp1nU0ev2kWPR9C/Go0OT3R5n5eTQFwrWBBtnjiIWVcr+WM2DM2qMbgjy
         5fDA==
X-Gm-Message-State: ACrzQf1S279ggqpsplJEK50jkUmkhpmT8CRqoNRgbSDprnhXWHT37lSd
	IAoa+Fr1ehuSzDdvbj9G8Od2TXapVhNym8PE
X-Google-Smtp-Source: AMsMyM6iJhNFK6IeXTrJJN/Gfmi+hynF/JdFUWEG4eILTiu05+egIOZDI6XKz3wO2DVHQ0+1HDSnDw==
X-Received: by 2002:a17:907:2d09:b0:781:d793:f51e with SMTP id gs9-20020a1709072d0900b00781d793f51emr1622165ejc.628.1663682737484;
        Tue, 20 Sep 2022 07:05:37 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id 8-20020a170906300800b0077d37a5d401sm947561ejz.33.2022.09.20.07.05.28
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:05:29 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 3/3] autotests: Add a SLAAC test
Date: Tue, 20 Sep 2022 16:05:09 +0200
Message-Id: <20220920140509.3304422-3-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220920140509.3304422-1-andrew.zaborowski@intel.com>
References: <20220920140509.3304422-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testNetconfig/slaac_test.py | 154 ++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 autotests/testNetconfig/slaac_test.py

diff --git a/autotests/testNetconfig/slaac_test.py b/autotests/testNetconfig/slaac_test.py
new file mode 100644
index 00000000..26ae0e46
--- /dev/null
+++ b/autotests/testNetconfig/slaac_test.py
@@ -0,0 +1,154 @@
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
+                testutil.test_ip_address_match(device.name, '3ffe:501:ffff:200::', 128, 64)
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
+                'nameserver 3ffe:501:ffff:100::10\n', 'nameserver 3ffe:501:ffff:100::50\n',
+                '-a %s.domain\n' % (ifname,), 'search test1\n', 'search test2\n']
+        # Every resolvconf -a run overwrites the previous settings.  Check the last seven lines
+        # of our log since we care about the end result here.
+        self.assertEqual(expected_rclog, entries[-7:])
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
+        cls.ns1.start_process(['sysctl',
+                                'net.ipv6.conf.' + cls.hapd.ifname + '.forwarding=1']).wait()
+        config = open('/tmp/radvd.conf', 'w')
+        config.write('interface ' + cls.hapd.ifname + ''' {
+            AdvSendAdvert on;
+            # Trick radvd to accept MinDelayBetweenRAs values less than 3 seconds.
+            AdvHomeAgentFlag on;
+            # Don't throttle so we can test solicited RA reception before link-local addr DAD done.
+            # radvd may have sent an unsolicited RA just before our RS and would complain -- the
+            # test should succeed regardless but will take some extra seconds.
+            MinDelayBetweenRAs 0.05;
+            AdvManagedFlag off;
+            # Test that the prefix with longer lifetime is selected.
+            prefix 3ffe:501:ffff:100::/64 { AdvAutonomous on; };
+            prefix 3ffe:501:ffff:200::/64 { AdvAutonomous on; AdvPreferredLifetime infinity; AdvValidLifetime infinity; };
+            RDNSS 3ffe:501:ffff:100::10 3ffe:501:ffff:100::50 { AdvRDNSSLifetime 3600; };
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
+        cls.ns1.stop_process(cls.radvd_pid)
+        cls.radvd_pid = None
+        os.system('rm -rf /tmp/radvd.conf /tmp/test-bin')
+        os.environ['PATH'] = cls.orig_path
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
-- 
2.34.1

