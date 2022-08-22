Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85FD2594
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 15:58:09 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id q9so705890pgq.6
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PyaCBV50H/xF9xv3Fm+FcwZnifyGExGBQ/U5FJwtPqg=;
        b=p4lyerG0RjyyQbjFzdVdb84pCYpdo2Y1BU0VTuUZ2f55A9LHCYQvo59MAVrCjQ4oM3
         U4XIAs6AVjICMJtOSSL+EYkXzNBeds0o2RxF+hIsR9hUA6460r8P1C2HhmOTCtUHGfbZ
         iMIWr+jvj1Zhra71dDjgkBkmqDyr8PpOTsGsYHCX97AM3lhwe8Xk+6+r1AoGVz7VbMiz
         TAD18qiCq9yWOi9p/mY0uRnv/DAt540UvPfXTmG/zj/UVhKtWrXhk+K7jXA/FznP0+rK
         QdnH44tZMaRoKxvmRq9AieMqMDOhNj9Qy+RTGAVqv6baLhrxnD9SrfmwPKufpANAoMmw
         urMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PyaCBV50H/xF9xv3Fm+FcwZnifyGExGBQ/U5FJwtPqg=;
        b=zFmoFiAsOQGJIjaMO7OHpF5gy6Rb6oXWKyDGQqlkgKjJSyqKZW16fYv6cx8Rj2pcWN
         /6zq0RWW1LcY/auffzlgVvFfeDXYFtIcMvLNTX/UhfJhYSK4ZBVOgPBDMI6FQGslZgrR
         4+MZnbG2k1/JjrTH3KM5PDn7cf74ixuzo0HtwglMAPHP5IdUNbcYGO3kow0+re5jWfyk
         Q2pDDb9J4hR0Ze1cYSoaKXmR35CRcsesVrNkfBGe137TYOgRl2HTJ595vQZ4WP6WRiNI
         CI7jI+AnZ/n2ETvP+MXjKf1nvJyGl7woASBL9DQuPiO6BsAfVH7zIF9dsKPOl4EPzKBB
         X72A==
X-Gm-Message-State: ACgBeo0DxsVMx7Q/epE7/emrVD/dsxM9wqrXzJf2O9HdLRh8Nr1j10/u
	N5GaNvm2zJdXa89yJpUTCkmqujoM9nw=
X-Google-Smtp-Source: AA6agR7s0PJd0JffaR08EBFcysuXckPQuRJwK+mD3E/1a3wJ7KMUm9EJtV5mhhovD6BCAA7NC8cgSg==
X-Received: by 2002:a63:4d4f:0:b0:412:a02e:2896 with SMTP id n15-20020a634d4f000000b00412a02e2896mr17648868pgl.337.1661183888946;
        Mon, 22 Aug 2022 08:58:08 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id x64-20020a628643000000b005368192372fsm3216440pfd.200.2022.08.22.08.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:58:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 5/5] auto-t: fix testNetconfig static test
Date: Mon, 22 Aug 2022 08:58:04 -0700
Message-Id: <20220822155804.2006566-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220822155804.2006566-1-prestwoj@gmail.com>
References: <20220822155804.2006566-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test was updated to add namespaces which actually 'fixed' dhcpd's
address conflict detection since it uses ICMP echo requests. Part of
this test assumed the DHCP server would not detect a conflict which
isn't true for dhcpd (and any decent DHCP server I would guess). This
check now fails since dhcpd detects a conflict (the static address)
and hands out the next available address.

Testing conflict detection like this is really only testing dhcpd
behavior, and however IWD behaves here isn't important since the
network is doomed from the start.
---
 autotests/testNetconfig/static_test.py | 28 --------------------------
 1 file changed, 28 deletions(-)

diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconfig/static_test.py
index 01d694ca..aac2adcc 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -20,17 +20,10 @@ class Test(unittest.TestCase):
         # Use a non-default storage_dir for one of the instances, the default for the other one
         wd = IWD(True, iwd_storage_dir='/tmp/storage')
 
-        ns0 = ctx.get_namespace('ns0')
-
-        wd_ns0 = IWD(True, namespace=ns0)
-
         psk_agent = PSKAgent("secret123")
-        psk_agent_ns0 = PSKAgent("secret123", namespace=ns0)
         wd.register_psk_agent(psk_agent)
-        wd_ns0.register_psk_agent(psk_agent_ns0)
 
         dev1 = wd.list_devices(1)[0]
-        dev2 = wd_ns0.list_devices(1)[0]
 
         ordered_network = dev1.get_ordered_network('ap-main')
 
@@ -80,28 +73,7 @@ class Test(unittest.TestCase):
         # of the log since we care about the end result here.
         self.assertEqual(expected_rclog, entries[-3:])
 
-        ordered_network = dev2.get_ordered_network('ap-main')
-
-        condition = 'not obj.connected'
-        wd_ns0.wait_for_object_condition(ordered_network.network_object, condition)
-
-        # Connect to the same network from a dynamically configured client.  The
-        # DHCP server doesn't know (even though dev1 announced itself) that
-        # 192.168.1.10 is already in use and if it assigns dev2 the lowest
-        # available address, that's going to be 192.168.1.10.  dev1's ACD
-        # implementation should then stop using this address.
-        ordered_network.network_object.connect()
-
-        condition = 'obj.state == DeviceState.connected'
-        wd_ns0.wait_for_object_condition(dev2, condition)
-
-        wd.wait(1)
-        # Check dev1 is now disconnected or without its IPv4 address
-        if dev1.state == iwd.DeviceState.connected:
-            testutil.test_ip_address_match(dev1.name, None)
-
         dev1.disconnect()
-        dev2.disconnect()
 
         condition = 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condition)
-- 
2.34.3

