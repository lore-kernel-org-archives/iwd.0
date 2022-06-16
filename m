Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008D161
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 00:02:51 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id o8so17334263wro.3
        for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 17:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0sR9/tzsW65TSQaduxKmzndHRSeunmPPlcf5mdr3AI=;
        b=KfEDs+PJfIex2UM9DyaPM9iXAc6LZQCxiIpBEOVBkeYyqAP+k4z49a0N0w5SkFknuD
         bjemgIFjWBDZnC/C9RYbdJXKXEXJL8w/nqJ5wH6xXu4Lc9f8SWk2Dne5yF3coqA54enS
         OxpK8NVYMEyFlf9lg5DdGWunkhKJLa12RIcEkks0+RJS+h4DUfi62Eqe+SGwIygbouMM
         Pl8MvmLknfChwre+13bNNDbCAOyY91Da83H2y+VlNOL6t0uRkNGSV2rejctgRCXPBpvB
         Wv8bEB+UL4YrQm43/j4IIeTfS6I9nwDMIirBfjOhJSI3veXjYffVIpoQdNevhVTQFLNU
         dwuw==
X-Gm-Message-State: AJIora8pHfm0O3h6/3MhjX5zBYdmReaJYdZRoWMO7Cjujn1QgiLEuf6G
	sXHxccrle5XZNCr6hlri+s7DUx9XrFo=
X-Google-Smtp-Source: AGRyM1v8QXc6s0ZV3058xI1061gzYW1Get+zUEdklN5kJGM9xBvAzniK1ZrBmnB4doBd6aGUoreD7A==
X-Received: by 2002:a05:6000:1789:b0:219:2aa8:7159 with SMTP id e9-20020a056000178900b002192aa87159mr2050202wrg.474.1655337769101;
        Wed, 15 Jun 2022 17:02:49 -0700 (PDT)
Received: from iss.Home ([82.213.231.20])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm337452wrb.45.2022.06.15.17.02.47
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:02:48 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 10/15] autotests: In testNetconfig add static IPv6, add comments
Date: Thu, 16 Jun 2022 02:02:26 +0200
Message-Id: <20220616000231.1966008-10-andrew.zaborowski@intel.com>
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

In static_test.py add IPv6.  Add comments on what we're actually testing
since it wasn't very clear.  After the expected ACD conflict detection,
succeed if either the lost address was removed or the client disconnected
from the AP since this seems like a correct action for netconfig to
implement.
---
 autotests/testNetconfig/ssidTKIP.psk   |  7 +++++++
 autotests/testNetconfig/static_test.py | 11 ++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/autotests/testNetconfig/ssidTKIP.psk b/autotests/testNetconfig/ssidTKIP.psk
index eea59cda..72a71ce9 100644
--- a/autotests/testNetconfig/ssidTKIP.psk
+++ b/autotests/testNetconfig/ssidTKIP.psk
@@ -1,7 +1,14 @@
 [IPv4]
+# Use a different netmask than DHCP on purpose, but use the same address
+# as DHCP would assign us to produce a conflict and test ACD
 Address=192.168.1.10
 Netmask=255.255.255.128
 Gateway=192.168.1.1
 
+[IPv6]
+# Use a different subnet than DHCP on purpose
+Address=3ffe:501:ffff:200::10/80
+Gateway=3ffe:501:ffff:200::1
+
 [Settings]
 AutoConnect=false
diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconfig/static_test.py
index 8d5710c1..a3b294a2 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -16,6 +16,7 @@ import os
 class Test(unittest.TestCase):
 
     def test_connection_success(self):
+        # Use a non-default storage_dir for one of the instances, the default for the other one
         wd = IWD(True, iwd_storage_dir='/tmp/storage')
 
         ns0 = ctx.get_namespace('ns0')
@@ -46,19 +47,27 @@ class Test(unittest.TestCase):
         testutil.test_ifaces_connected()
 
         testutil.test_ip_address_match(dev1.name, '192.168.1.10', 25)
+        testutil.test_ip_address_match(dev1.name, '3ffe:501:ffff:200::10', 80)
 
         ordered_network = dev2.get_ordered_network('ssidTKIP')
 
         condition = 'not obj.connected'
         wd_ns0.wait_for_object_condition(ordered_network.network_object, condition)
 
+        # Connect to the same network from a dynamically configured client.  The
+        # DHCP server doesn't know (even though dev1 announced itself) that
+        # 192.168.1.10 is already in use and if it assigns dev2 the lowest
+        # available address, that's going to be 192.168.1.10.  dev1's ACD
+        # implementation should then stop using this address.
         ordered_network.network_object.connect()
 
         condition = 'obj.state == DeviceState.connected'
         wd_ns0.wait_for_object_condition(dev2, condition)
 
         wd.wait(1)
-        testutil.test_ip_address_match(dev1.name, None)
+        # Check dev1 is now disconnected or without its IPv4 address
+        if dev1.state == iwd.DeviceState.connected:
+            testutil.test_ip_address_match(dev1.name, None)
 
         dev1.disconnect()
         dev2.disconnect()
-- 
2.34.1

