Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1A34A32
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 18:25:38 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id w29so5586270pfj.3
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 11:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=w5mFN58RG6SwurvJCh0zv0PIw4A9/dXWwrlmpaGkFBc=;
        b=LbaXh/i/9cCCv7S+z14JYu0AsDp7rLcqeMLNOZJJ//tlUcBNMTWngbPd7Q/oyQxyg/
         +DTNvAnNcqcmmmSKhU0EJ7pRAAxYXWCprHIBiL4nUVo6t1FJAZN2dkiznXJcqh7xaoLC
         BJIuB5qSL+6Ww72skgwv5irsgTQiz+FZMkZKsjjbHMkj/U4j2/a42FbhcbLK5Gnm2bdd
         7eFfWp1OzlFtbWRGFrPnIn9jh2pSlUn/xVa57rbvTkQlPEArcG3rx/ZH8eHBCucu+frW
         bXqTXRks5S0wSroJAjMg+39FIrMq2fRSzgA53Rs0o9qzDhz0BeAr/lEjAPb0VkCIsXHF
         6HsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=w5mFN58RG6SwurvJCh0zv0PIw4A9/dXWwrlmpaGkFBc=;
        b=toKFfEm4dMbfguDAb0rMSEKWL9x76bo3XojcHRxywhFchm2jUZxJigsuI+bctQOdfR
         IXAJdAio632+YAHEJkXgbBYvwMw7xw9dF4ML7AaltHxA25pkYAV0EjBjvlMCdkHj7bwA
         FkYMxapZgRsH/5O+oESK2NiLSUw3GZCcIwC8XrvfxHpAqzeHvC+4aq0tUYHLJZovpT4R
         F0BdA1SspZOy2TjwyjJbqAnlnYpWRefX9gcaZXP0T5SSRbWbyTkPKTLQXWUzMY+7Xdxa
         x3vM+twrxHcFNESpF9zdNQ/+6nU/bCTyeeAzrzaDaqx/u9HPK6dO6+/Agu7bHny32usP
         7vbA==
X-Gm-Message-State: ACgBeo3VHBqt2m4Dbv0D0/06Eefq7I7IjKWn7/75kLv3vwlpmjRMZjNi
	goIET5Xb3t6xeuN4s8po1CGAJ5Elb0M=
X-Google-Smtp-Source: AA6agR4oAM741yTMxlMDoBfdAcuHQyDicpU85Yndl3rKkanXipry9OSU1u/iD5pOtJcEX1OzyZe9pw==
X-Received: by 2002:a63:ff5d:0:b0:42a:e27e:5506 with SMTP id s29-20020a63ff5d000000b0042ae27e5506mr999176pgk.41.1661192737814;
        Mon, 22 Aug 2022 11:25:37 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b00172bd4c12b2sm1612024plk.224.2022.08.22.11.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:25:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 9/9] auto-t: add auth retry test to testPSK-roam
Date: Mon, 22 Aug 2022 11:25:25 -0700
Message-Id: <20220822182525.2078312-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220822182525.2078312-1-prestwoj@gmail.com>
References: <20220822182525.2078312-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tests the new behavior where IWD will try to FT-authenticate
with another BSS if it fails.
---
 autotests/testPSK-roam/connection_test.py     |   2 +-
 autotests/testPSK-roam/ft-psk-ccmp-1.conf     |   2 +
 autotests/testPSK-roam/ft-psk-ccmp-2.conf     |   2 +
 autotests/testPSK-roam/ft-psk-ccmp-3.conf     |  44 ++++++
 autotests/testPSK-roam/hw.conf                |   3 +-
 .../testPSK-roam/try_multiple_ft_test.py      | 134 ++++++++++++++++++
 6 files changed, 185 insertions(+), 2 deletions(-)
 create mode 100644 autotests/testPSK-roam/ft-psk-ccmp-3.conf
 create mode 100644 autotests/testPSK-roam/try_multiple_ft_test.py

diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-roam/connection_test.py
index 2206f120..77a7fd06 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -181,7 +181,7 @@ class Test(unittest.TestCase):
         cls.bss_hostapd = [ HostapdCLI(config='ft-psk-ccmp-1.conf'),
                             HostapdCLI(config='ft-psk-ccmp-2.conf') ]
         rad0 = hwsim.get_radio('rad0')
-        rad2 = hwsim.get_radio('rad2')
+        rad2 = hwsim.get_radio('rad3')
 
         cls.rule0 = hwsim.rules.create()
         cls.rule0.source = rad2.addresses[0]
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-1.conf b/autotests/testPSK-roam/ft-psk-ccmp-1.conf
index c012b4ef..86fb691a 100644
--- a/autotests/testPSK-roam/ft-psk-ccmp-1.conf
+++ b/autotests/testPSK-roam/ft-psk-ccmp-1.conf
@@ -26,8 +26,10 @@ mobility_domain=1234
 reassociation_deadline=60000
 r0kh=12:00:00:00:00:01 dummy1 000102030405060708090a0b0c0d0e0f
 r0kh=12:00:00:00:00:02 dummy2 000102030405060708090a0b0c0d0e0f
+r0kh=12:00:00:00:00:03 dummy3 000102030405060708090a0b0c0d0e0f
 r1kh=12:00:00:00:00:01 00:00:00:00:00:01 000102030405060708090a0b0c0d0e0f
 r1kh=12:00:00:00:00:02 00:00:00:00:00:02 000102030405060708090a0b0c0d0e0f
+r1kh=12:00:00:00:00:03 00:00:00:00:00:03 000102030405060708090a0b0c0d0e0f
 # Push mode only needed for 8021x, not PSK mode since msk already known
 pmk_r1_push=0
 # Allow locally generated FT response so we don't have to configure push/pull
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-2.conf b/autotests/testPSK-roam/ft-psk-ccmp-2.conf
index 84875fdc..c93b425b 100644
--- a/autotests/testPSK-roam/ft-psk-ccmp-2.conf
+++ b/autotests/testPSK-roam/ft-psk-ccmp-2.conf
@@ -26,8 +26,10 @@ mobility_domain=1234
 reassociation_deadline=60000
 r0kh=12:00:00:00:00:01 dummy1 000102030405060708090a0b0c0d0e0f
 r0kh=12:00:00:00:00:02 dummy2 000102030405060708090a0b0c0d0e0f
+r0kh=12:00:00:00:00:03 dummy3 000102030405060708090a0b0c0d0e0f
 r1kh=12:00:00:00:00:01 00:00:00:00:00:01 000102030405060708090a0b0c0d0e0f
 r1kh=12:00:00:00:00:02 00:00:00:00:00:02 000102030405060708090a0b0c0d0e0f
+r1kh=12:00:00:00:00:03 00:00:00:00:00:03 000102030405060708090a0b0c0d0e0f
 # Push mode only needed for 8021x, not PSK mode since msk already known
 pmk_r1_push=0
 # Allow locally generated FT response so we don't have to configure push/pull
diff --git a/autotests/testPSK-roam/ft-psk-ccmp-3.conf b/autotests/testPSK-roam/ft-psk-ccmp-3.conf
new file mode 100644
index 00000000..321e1038
--- /dev/null
+++ b/autotests/testPSK-roam/ft-psk-ccmp-3.conf
@@ -0,0 +1,44 @@
+hw_mode=g
+channel=3
+op_class=81
+ssid=TestFT
+utf8_ssid=1
+ctrl_interface=/var/run/hostapd
+
+r1_key_holder=120000000003
+nas_identifier=dummy3
+
+wpa=2
+# Can support WPA-PSK and FT-PSK (space separated list) and/or EAP at the same
+# time but we want to force FT
+wpa_key_mgmt=FT-PSK
+wpa_pairwise=CCMP
+wpa_passphrase=EasilyGuessedPassword
+wpa_ptk_rekey=30
+wpa_group_rekey=80
+ieee80211w=1
+rsn_preauth=1
+rsn_preauth_interfaces=lo
+disable_pmksa_caching=0
+# Allow PMK cache to be shared opportunistically among configured interfaces
+# and BSSes (i.e., all configurations within a single hostapd process).
+okc=1
+mobility_domain=1234
+reassociation_deadline=60000
+r0kh=12:00:00:00:00:01 dummy1 000102030405060708090a0b0c0d0e0f
+r0kh=12:00:00:00:00:02 dummy2 000102030405060708090a0b0c0d0e0f
+r0kh=12:00:00:00:00:03 dummy3 000102030405060708090a0b0c0d0e0f
+r1kh=12:00:00:00:00:01 00:00:00:00:00:01 000102030405060708090a0b0c0d0e0f
+r1kh=12:00:00:00:00:02 00:00:00:00:00:02 000102030405060708090a0b0c0d0e0f
+r1kh=12:00:00:00:00:03 00:00:00:00:00:03 000102030405060708090a0b0c0d0e0f
+# Push mode only needed for 8021x, not PSK mode since msk already known
+pmk_r1_push=0
+# Allow locally generated FT response so we don't have to configure push/pull
+# between BSSes running as separate hostapd processes as in the test-runner
+# case.  Only works with FT-PSK, otherwise brctl needs to be installed and
+# CONFIG_BRIDGE enabled in the kernel.
+ft_psk_generate_local=1
+ft_over_ds=0
+ap_table_expiration_time=36000
+ap_table_max_size=10
+rrm_neighbor_report=1
diff --git a/autotests/testPSK-roam/hw.conf b/autotests/testPSK-roam/hw.conf
index c2b35d6e..da9e385c 100644
--- a/autotests/testPSK-roam/hw.conf
+++ b/autotests/testPSK-roam/hw.conf
@@ -1,8 +1,9 @@
 [SETUP]
-num_radios=3
+num_radios=4
 start_iwd=0
 hwsim_medium=yes
 
 [HOSTAPD]
 rad0=ft-psk-ccmp-1.conf
 rad1=ft-psk-ccmp-2.conf
+rad2=ft-psk-ccmp-3.conf
diff --git a/autotests/testPSK-roam/try_multiple_ft_test.py b/autotests/testPSK-roam/try_multiple_ft_test.py
new file mode 100644
index 00000000..a0e1312e
--- /dev/null
+++ b/autotests/testPSK-roam/try_multiple_ft_test.py
@@ -0,0 +1,134 @@
+#! /usr/bin/python3
+
+import unittest
+import sys, os
+
+sys.path.append('../util')
+import iwd
+from iwd import IWD
+from iwd import PSKAgent
+from iwd import NetworkType
+from hwsim import Hwsim
+from hostapd import HostapdCLI
+import testutil
+
+class Test(unittest.TestCase):
+    def validate_connection(self, wd):
+        device = wd.list_devices(1)[0]
+
+        ordered_network = device.get_ordered_network('TestFT', full_scan=True)
+
+        self.assertEqual(ordered_network.type, NetworkType.psk)
+
+        condition = 'not obj.connected'
+        wd.wait_for_object_condition(ordered_network.network_object, condition)
+
+        self.assertFalse(self.bss_hostapd[0].list_sta())
+        self.assertFalse(self.bss_hostapd[1].list_sta())
+
+        device.connect_bssid(self.bss_hostapd[0].bssid)
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(device, condition)
+
+        self.bss_hostapd[0].wait_for_event('AP-STA-CONNECTED %s' % device.address)
+
+        testutil.test_iface_operstate(device.name)
+        testutil.test_ifaces_connected(self.bss_hostapd[0].ifname, device.name)
+        self.assertRaises(Exception, testutil.test_ifaces_connected,
+                          (self.bss_hostapd[1].ifname, device.name, True, True))
+
+        condition = 'obj.state == DeviceState.roaming'
+        wd.wait_for_object_condition(device, condition)
+
+        # Check that iwd is on BSS 1 once out of roaming state and doesn't
+        # go through 'disconnected', 'autoconnect', 'connecting' in between
+        from_condition = 'obj.state == DeviceState.roaming'
+        to_condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_change(device, from_condition, to_condition)
+
+        self.bss_hostapd[1].wait_for_event('AP-STA-CONNECTED %s' % device.address)
+
+        testutil.test_iface_operstate(device.name)
+        testutil.test_ifaces_connected(self.bss_hostapd[1].ifname, device.name)
+        self.assertRaises(Exception, testutil.test_ifaces_connected,
+                          (self.bss_hostapd[0].ifname, device.name, True, True))
+
+        self.bss_hostapd[1].deauthenticate(device.address)
+        condition = 'obj.state == DeviceState.disconnected'
+        wd.wait_for_object_condition(device, condition)
+
+    def test_ft_psk(self):
+        wd = IWD(True)
+
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[0].set_value('ft_over_ds', '0')
+        self.bss_hostapd[0].set_value('ocv', '1')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
+
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[1].set_value('ft_over_ds', '0')
+        self.bss_hostapd[1].set_value('ocv', '1')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+
+        self.bss_hostapd[2].set_value('wpa_key_mgmt', 'FT-PSK')
+        self.bss_hostapd[2].set_value('ft_over_ds', '0')
+        self.bss_hostapd[2].set_value('ocv', '1')
+        self.bss_hostapd[2].reload()
+        self.bss_hostapd[2].wait_for_event("AP-ENABLED")
+
+        self.validate_connection(wd)
+
+    @classmethod
+    def setUpClass(cls):
+        hwsim = Hwsim()
+
+        IWD.copy_to_storage('TestFT.psk')
+
+        cls.bss_hostapd = [ HostapdCLI(config='ft-psk-ccmp-1.conf'),
+                            HostapdCLI(config='ft-psk-ccmp-2.conf'),
+                            HostapdCLI(config='ft-psk-ccmp-3.conf') ]
+
+        cls.bss_hostapd[0].set_address('12:00:00:00:00:01')
+        cls.bss_hostapd[1].set_address('12:00:00:00:00:02')
+        cls.bss_hostapd[2].set_address('12:00:00:00:00:03')
+
+        # Connect here first, worst candidate
+        cls.rule0 = hwsim.rules.create()
+        cls.rule0.source = hwsim.get_radio('rad0').addresses[0]
+        cls.rule0.bidirectional = True
+        cls.rule0.signal = -8500
+        cls.rule0.enabled = True
+
+        # Second best candidate, IWD should eventually get here after failing
+        # to connect to bss_hostapd[2]
+        cls.rule1 = hwsim.rules.create()
+        cls.rule1.source = hwsim.get_radio('rad1').addresses[0]
+        cls.rule1.bidirectional = True
+        cls.rule1.signal = -8000
+        cls.rule1.enabled = True
+
+        # Best candidate, IWD should try this first, fail (since auth is
+        # dropped), and move onto another candidate.
+        cls.rule2 = hwsim.rules.create()
+        cls.rule2.source = hwsim.get_radio('rad2').addresses[0]
+        cls.rule2.bidirectional = True
+        cls.rule2.signal = -2000
+        cls.rule2.prefix = 'b0'
+        cls.rule2.drop = True
+        cls.rule2.enabled = True
+
+        HostapdCLI.group_neighbors(*cls.bss_hostapd)
+
+    @classmethod
+    def tearDownClass(cls):
+        IWD.clear_storage()
+        cls.bss_hostapd = None
+        cls.rule0.enabled = False
+        cls.rule1.enabled = False
+        cls.rule2.enabled = False
+
+if __name__ == '__main__':
+    unittest.main(exit=True)
-- 
2.34.3

