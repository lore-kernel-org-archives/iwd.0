Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04F57E
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 00:02:57 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id z17so7114295wmi.1
        for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 17:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bZoN4Uk55zDRkTMTx/ixyAGwGOM3Q/TwB11S0OKmWVA=;
        b=3TzF6YWZsqqRLVtf0MaWv4Wdi1NvP6KOodbHqlKW7SYceCk8jwKTBOh5Y4AG3jGO8g
         7ey6UWfM1r6dyB5m6zYVSQjnb1qsRGtkbJ6gKMwp5BSI7xDDlPFe/qo+asDC5jNUptnP
         rU34e7wvs2pOtWdsPSn1Ur8CRw+C7vfQ6PUizWWLes0AFQXweDPesKl1PQ+9s6uPZgFV
         2I5W6uPLyH0lsIMmZgp9ambYCK9k+I28bdc2XKk0190FuGF6hVngR2Ug+fYoXtLbTBHg
         Qw1Fknr8inAuhXkvmL4048oWlj2HtfeNbz+KhFM8GmJtl5TtRnaPFHZINAzS/d9vpvzt
         6+2A==
X-Gm-Message-State: AJIora9SYS3UUzDjLCPi62yGc3Heb4pRYPKkpnUc97oJ9A/Zmb/CYCrC
	w1GGgRN+cM3jyifo2a7pak2yvJOAoU0=
X-Google-Smtp-Source: AGRyM1uSxEayM2qLJCC7k6MjHB5IttfVY7gcokbbk3GIqyO9QZm2upwPBNC6ZAPQ+WfbQymlooNg/A==
X-Received: by 2002:a05:600c:3553:b0:39c:63a3:f54a with SMTP id i19-20020a05600c355300b0039c63a3f54amr2019977wmq.61.1655337775835;
        Wed, 15 Jun 2022 17:02:55 -0700 (PDT)
Received: from iss.Home ([82.213.231.20])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm337452wrb.45.2022.06.15.17.02.54
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:02:55 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 15/15] autotests: In testNetconfig verify routes from RIOs
Date: Thu, 16 Jun 2022 02:02:31 +0200
Message-Id: <20220616000231.1966008-15-andrew.zaborowski@intel.com>
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

Verify that IWD with NetworkConfigurationEnabled creates the off-link
routes for Route Information Options in the Router Advertisements.
Sending this last because these options are not supported by current
netconfig code and the test should fail without the l_netconfig patch.
---
 autotests/testNetconfig/connection_test.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNetconfig/connection_test.py
index 837b19ec..9c1d2efa 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -72,6 +72,15 @@ class Test(unittest.TestCase):
                 # On-link prefix
                 testutil.RouteInfo(dst=socket.inet_pton(socket.AF_INET6, '3ffe:501:ffff:100::'), plen=72,
                     flags=1, ifname=ifname),
+                # Router for an off-link prefix, medium preference
+                testutil.RouteInfo(dst=socket.inet_pton(socket.AF_INET6, '3ffe:501:ffff:300::'), plen=64,
+                    gw=router_ll_addr, flags=3, ifname=ifname),
+                # Router for an off-link prefix, high preference
+                testutil.RouteInfo(dst=socket.inet_pton(socket.AF_INET6, '3ffe:501:ffff:400::'), plen=65,
+                    gw=router_ll_addr, flags=3, ifname=ifname),
+                # Router for an off-link prefix, low preference
+                testutil.RouteInfo(dst=socket.inet_pton(socket.AF_INET6, '3ffe:501:ffff:500::'), plen=66,
+                    gw=router_ll_addr, flags=3, ifname=ifname)
             }
         self.maxDiff = None
         self.assertEqual(expected_routes4, set(testutil.get_routes4(ifname)))
@@ -166,6 +175,9 @@ class Test(unittest.TestCase):
             AdvSendAdvert on;
             AdvManagedFlag on;
             prefix 3ffe:501:ffff:100::/72 { AdvAutonomous off; };
+            route 3ffe:501:ffff:300::/64 {};
+            route 3ffe:501:ffff:400::/65 { AdvRoutePreference low; };
+            route 3ffe:501:ffff:500::/66 { AdvRoutePreference high; };
             };''')
         config.close()
         cls.radvd_pid = ctx.start_process(['radvd', '-n', '-d5', '-p', '/tmp/radvd.pid', '-C', '/tmp/radvd.conf'])
-- 
2.34.1

