Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C74A14
	for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 19:24:39 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id s4-20020a17090a5d0400b001fabc6bb0baso5188116pji.1
        for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PyaCBV50H/xF9xv3Fm+FcwZnifyGExGBQ/U5FJwtPqg=;
        b=NIY4GN7r/vazkw8qon7caoEfP5LqKXe1esHMTe0k8/Ca84fl0m4i13KeJ5ndLT7YIP
         N/JIR2LXc+lW9Wxwuqm7vHS7b6TsdKddDTOKum6k2KXWAr7OvIO2l/fD2RM7tWGNEiNW
         Ryb/9J7XC+jwpogGvUwOu/kyzghXPej+yqVSfMW9xZT58ENKZCzlAlfXgTaKVKdj4Miv
         zHd4c/yOPDVbNeuC+GWllhvCAfesMVARuhvmULt984VD8l3QKRdDLQ5IrJiOnCBKL3Zy
         HF/Zo/CXtGv7sUziwl7pnk+hZ14oEl8uudIp2nXc2F7EB/eR0XYM4h7Cq6pF5A9BZjyb
         9LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PyaCBV50H/xF9xv3Fm+FcwZnifyGExGBQ/U5FJwtPqg=;
        b=4OIk7NBbKVOinmdhOTsfuYerOtuGTrNEH/wMU0S1M+3CrsNDy9hBERlcRBfdkJufEN
         DyYEduLeMs/FJ3SfP21w3YWSyPLS5mBYmBvPKnCvd7eayAUbQd+CcxwwRfB1ipvHCoQ0
         x9k+aYCgN64EETLxN64YxJP+6sUr2GHzaKHrwnn9DNxUGHjxdZ6g9wEYL0mIdoG7Wc7i
         z8VagbwImtNtKVGt8DB+CnrDpTSddMfOeuh8GhE/dkRaIpHsd0qyV+Xh1TXAXGe3QmDV
         3xGPZ3T2VsipZXvSp2OmttjkysOlMnDYN5LWIHU35L3WUP54hCoYE1/Sn9ggGhQ5rjgG
         dADg==
X-Gm-Message-State: ACgBeo2rXXJ9vd2Tz8C0vWdfQ3hSaLsqlAsOu9CCX7YgdfvidHqe4DEF
	f0U0gAWw05KYzdjeLyFMmCkaCHw0+tY=
X-Google-Smtp-Source: AA6agR7r7KeKalAX6CfDvAX/355zX0uyXQeKZCBrw4UO1Ekalw9+9psWukru+GTVIvyvBnmtn0Ct9g==
X-Received: by 2002:a17:903:2602:b0:172:ba94:1590 with SMTP id jd2-20020a170903260200b00172ba941590mr6843629plb.146.1660937079288;
        Fri, 19 Aug 2022 12:24:39 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902d14200b0016dbe37cebdsm3472982plt.246.2022.08.19.12.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:24:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] auto-t: fix testNetconfig static test
Date: Fri, 19 Aug 2022 12:24:31 -0700
Message-Id: <20220819192431.1605386-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220819192431.1605386-1-prestwoj@gmail.com>
References: <20220819192431.1605386-1-prestwoj@gmail.com>
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

