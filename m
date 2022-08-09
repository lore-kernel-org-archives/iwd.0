Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D4546A6
	for <iwd@lists.linux.dev>; Tue,  9 Aug 2022 23:04:44 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id o3-20020a17090a0a0300b001f7649cd317so443863pjo.0
        for <iwd@lists.linux.dev>; Tue, 09 Aug 2022 16:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RdJ1dDIHJDjz5RHNjANj7VhqJxpB/ypC6aa8Xd9xbtI=;
        b=T6Cas1Vb9Zy2feF+NonqZhqfC6hkq1YPQrlFl/4TbqYkMsAq17e9v5DAAaVe13P0Oy
         HZhWxzffO1eFFvgHE1pvDSvISclhkiaWiBUusrsRSMfdWyePhQjqcBilrXGhJhPHgTgP
         Spq56DiktuAoVIz3zdkZr0Oe4LjqSW/OevxbtcblKKIioXFeZxzry6VpPmrZ3aILpcEt
         s4z26E5Wgtyg2EZNj79b2WS0HNDhWlD4i7MXl2AHKxIBD2RCMWnrmlAJrB8VPdgGZqfR
         8rZYS4Wsp3VqBUGQwVZFTJTbxx7Xf4EeqLGTk73kbJCiBdfgn0X3pL+lWS2Zalz3q6LP
         eF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RdJ1dDIHJDjz5RHNjANj7VhqJxpB/ypC6aa8Xd9xbtI=;
        b=pgUA7Atd0appzyANzCNoxRuWtpleuJwirdgkBtYefcQc9q5t9hyTXOlsfyIYcsJZAs
         abDp4L8ProfGnUM0TstSTCi8mF+8xHcO8CY1LiiUnA+NMzbFPwj+rbKm/KBZ53S7PqSp
         lpP/WfpRPrqAnmWT095bIQyQWVqfXYvGbHbCTs0Nw1UVa7ndQJyLTsvA6+jgTwIejLjQ
         fmP2Aa5XzlhT+V0nYvop2fdGwTtHI+0GdL7slroP0dH4lx71v9iSVfBLJHyVfDXmMIVn
         6kijYYZoDzaaHvUnML5jHcIalVSdE6Ok2AwQldWFOACkXevRCxzgPu0bxgYohWjQ4DgF
         uM1A==
X-Gm-Message-State: ACgBeo1mKLlafMrxxegXtRY1QKq6bp4fz1yU8bgJUg6bG3KjV1zYW51q
	HDcV/yesw80jSQpoxOtYc0SZpppELJk=
X-Google-Smtp-Source: AA6agR5vFZDdNEvCvTghEWzj/+sho9QP3/YFZJR7J/sxnS52rxSvP8bIz7QuCv1OU9CXym3O/OXvbg==
X-Received: by 2002:a17:902:f608:b0:16d:c44:137 with SMTP id n8-20020a170902f60800b0016d0c440137mr25563045plg.173.1660086283494;
        Tue, 09 Aug 2022 16:04:43 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w13-20020a62820d000000b0052d748498edsm459063pfd.13.2022.08.09.16.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 16:04:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>,
	mjohnson459@gmail.com
Subject: [RFC 4/4] auto-t: add packet loss test to testPSK-roam
Date: Tue,  9 Aug 2022 16:04:28 -0700
Message-Id: <20220809230428.215970-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220809230428.215970-1-prestwoj@gmail.com>
References: <20220809230428.215970-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new test which blocks all data frames once connected, then tries
to send 100 packets. This should result in the kernel sending a
packet loss event to userspace, which IWD should react to and roam.
---
 autotests/testPSK-roam/connection_test.py | 46 ++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-roam/connection_test.py
index f1b43130..c926e255 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -13,7 +13,7 @@ from hostapd import HostapdCLI
 import testutil
 
 class Test(unittest.TestCase):
-    def validate_connection(self, wd, over_ds=False):
+    def validate_connection(self, wd, over_ds=False, pkt_loss=False):
         device = wd.list_devices(1)[0]
 
         ordered_network = device.get_ordered_network('TestFT', full_scan=True)
@@ -41,11 +41,24 @@ class Test(unittest.TestCase):
         if over_ds:
             self.rule0.enabled = True
 
-        device.roam(self.bss_hostapd[1].bssid)
+        if pkt_loss:
+            # Drop all data frames
+            self.rule1.enabled = True
+            # Set the current BSS signal lower so we have roam candidates
+            self.rule2.enabled = True
+            # Send 100 packets (to be dropped), should trigger beacon loss
+            testutil.tx_packets(device.name, self.bss_hostapd[0].ifname, 100)
+            device.wait_for_event('packet-loss-roam', timeout=30)
+        else:
+            device.roam(self.bss_hostapd[1].bssid)
 
         condition = 'obj.state == DeviceState.roaming'
         wd.wait_for_object_condition(device, condition)
 
+        if pkt_loss:
+            self.rule1.enabled = False
+            self.rule2.enabled = False
+
         # Check that iwd is on BSS 1 once out of roaming state and doesn't
         # go through 'disconnected', 'autoconnect', 'connecting' in between
         from_condition = 'obj.state == DeviceState.roaming'
@@ -132,6 +145,23 @@ class Test(unittest.TestCase):
 
         self.validate_connection(wd)
 
+    def test_roam_packet_loss(self):
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
+        self.bss_hostapd[0].set_value('ocv', '1')
+        self.bss_hostapd[1].reload()
+        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
+
+        self.validate_connection(wd, pkt_loss=True)
+
     def tearDown(self):
         os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
         os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
@@ -139,6 +169,8 @@ class Test(unittest.TestCase):
         os.system('ip link set "' + self.bss_hostapd[1].ifname + '" up')
 
         self.rule0.enabled = False
+        self.rule1.enabled = False
+        self.rule2.enabled = False
 
     @classmethod
     def setUpClass(cls):
@@ -148,6 +180,7 @@ class Test(unittest.TestCase):
 
         cls.bss_hostapd = [ HostapdCLI(config='ft-psk-ccmp-1.conf'),
                             HostapdCLI(config='ft-psk-ccmp-2.conf') ]
+        rad0 = hwsim.get_radio('rad0')
         rad2 = hwsim.get_radio('rad2')
 
         cls.rule0 = hwsim.rules.create()
@@ -157,6 +190,15 @@ class Test(unittest.TestCase):
         cls.rule0.prefix = 'b0'
         cls.rule0.drop = True
 
+        cls.rule1 = hwsim.rules.create()
+        cls.rule1.source = rad2.addresses[0]
+        cls.rule1.prefix = '08'
+        cls.rule1.drop = True
+
+        cls.rule2 = hwsim.rules.create()
+        cls.rule2.source = rad0.addresses[0]
+        cls.rule2.signal = -4000
+
         # Set interface addresses to those expected by hostapd config files
         os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" down')
         os.system('ip link set dev "' + cls.bss_hostapd[0].ifname + '" addr 12:00:00:00:00:01 up')
-- 
2.34.3

