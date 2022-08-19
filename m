Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E4748F
	for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 20:26:28 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id x19so2472241pfq.1
        for <iwd@lists.linux.dev>; Fri, 19 Aug 2022 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PyaCBV50H/xF9xv3Fm+FcwZnifyGExGBQ/U5FJwtPqg=;
        b=k7MTyyMy783UyJCVM3FfauS3szDKU/ZZpM5RgjTEjZ3UFwLtTDUNKP1PLK60bEb9gR
         kUhonxrLijYm/K9MzPcoXf5oKUjqJTyyDyu63Sqib5iWR2AQDwHG6KNODMIPqjAK1t2B
         rvlEqjP6AFBVY2K7nVlClGQl6dn0gYiWVoSah0oGsDRu2ylV97zEJYZydJIwxDHwXPxT
         WcH0k2DRPWkZTcz2H+8V0CgELepHefeiHYPu3/7Xcjnr/Br/APX9S6JB+zifAlWArERP
         Vj2yy12JKCcfE5WkRHGqV3+wXX7pIYZ1XrmCFQpn9YmWfC6we5nLubxFz/7mG46irVHz
         GGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PyaCBV50H/xF9xv3Fm+FcwZnifyGExGBQ/U5FJwtPqg=;
        b=sluvmbEc+KsLB94SgnKvg8InTPWlTdCuQKW36rDkjcK3WO0T3x8dFGYqOV8wJhcZr9
         wTSclHXgOSJTOMYqTjeHCr8AHvh99alqb5AcLmESj/ra2soLdDr79Pm8OQNFOHbakuDy
         KfRiBypLCdRPtGCizXd35zvTnvLzyEqjE2IIc2cOuEu1qkf6PCKJDCiZV12BjGPxNFVG
         hZBQgprNUIBQ11VIjunRRlDdJ5C/l62PWWoJlL9jtkSLnTEQ+ureUo3PV+6J3YG8GSGL
         mSd9FUwBZWeuUzIjOQU2z4rIMH/w7YEpcP+/oyYKW4Jy6fE3m+KiHiqjzi5c0ywCBoFs
         IBSA==
X-Gm-Message-State: ACgBeo1hs6klyJ/KeKDYyw0y6a/WZQSxmVx2e0MikPzwy13RIBz/Lz53
	hg+UjXf9RLdFOPpTcTWK0e0m/IVvqZQ=
X-Google-Smtp-Source: AA6agR4izcvtIOvlgA4eKVkwZ+nHFfwMK5sowxx23dVru2U0sA+aHmfp+O40OFfVqpUa7c+lMIleeQ==
X-Received: by 2002:a65:68d0:0:b0:422:ebd2:302 with SMTP id k16-20020a6568d0000000b00422ebd20302mr7404775pgt.340.1660940788230;
        Fri, 19 Aug 2022 13:26:28 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090340cf00b0016dbce87aecsm22206pld.182.2022.08.19.13.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:26:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/5] auto-t: fix testNetconfig static test
Date: Fri, 19 Aug 2022 13:26:24 -0700
Message-Id: <20220819202624.1681246-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220819202624.1681246-1-prestwoj@gmail.com>
References: <20220819202624.1681246-1-prestwoj@gmail.com>
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

