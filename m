Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0733EC
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 17:01:56 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id z187so10899682pfb.12
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PyaCBV50H/xF9xv3Fm+FcwZnifyGExGBQ/U5FJwtPqg=;
        b=fEKC4mBN4reCa+l/9p21pTRTMcqtgqzIKSGpjTr32030ouF7QaukckHL3W36CAccHQ
         Kr58FvSO1HSUBox73bdsWU3jYm+noWXk4exGsAGtxPOvePuvD0I04Gy1NOLS1VuV4cIs
         jldthDN40rMMQnPoi68XNYkQoUXk64YbXAsNZWXsgvUSDdAomPx7M6FRXXzktk+KQU34
         LcSFc1kHXDahhyE+eRjVyHpg9ZqSdYHoByy/uQ74MFQm8gDdp5/lgW6U+anG4oNTmdGZ
         0TgQTpILz0xaLd/Q7EsZzYDF12+1lIlw9cz6zZlDsR+T+ZJAIe2bth6BAZImSC6K0+7t
         7Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PyaCBV50H/xF9xv3Fm+FcwZnifyGExGBQ/U5FJwtPqg=;
        b=I5SwuNqFXBNHgojrmIYPJPCBTqBBdpuBG8yLsJ10AKRySEFrXSzV/d85ShoHaqvLaJ
         9XRzCio6BOU4T4lYWHnrKwiCCqfVkZsagBxs1G0eO7c4QM/Ijq1MJy1UwF4uoQT08CGo
         19xs2SY/z95dqPHM77rkvvHw0zjChZGIZQXJRLI1iMWrREZnhB4eRTwzh1TGYn2yW1KD
         gufxH2TbSv5vTHWiuKZUFEImS6DfzYR8f6/0YQI/JL4EU4KpMaEb+4zbSQWUSfOSMloO
         foke+YR9AlVqOl7Y6MCno0WlkflPXZnXXp8+PZ5AHbOSj4PWqLugYI16/L3VfRhcBEig
         O9dw==
X-Gm-Message-State: ACgBeo0izpbjNEG5V6axhXLI8TgcSEn1UGcIWuDzF6LZ8wjASj0YO8Hj
	sA5r4FlmZLTK+q9gqI6j19DI+DKBlrM=
X-Google-Smtp-Source: AA6agR4tud7pmYBhnjNLxrpDsnEW2kcYF02Ew0q9zmdErB8nx4ReeKLvNv9esMnQPOZkvQ6rkNeq1A==
X-Received: by 2002:a05:6a00:acc:b0:530:e79e:fc27 with SMTP id c12-20020a056a000acc00b00530e79efc27mr21872709pfl.61.1661187716164;
        Mon, 22 Aug 2022 10:01:56 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id d1-20020a170903230100b0016ef87334aesm8691002plh.162.2022.08.22.10.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 10:01:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 6/6] auto-t: fix testNetconfig static test
Date: Mon, 22 Aug 2022 10:01:50 -0700
Message-Id: <20220822170150.2049490-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220822170150.2049490-1-prestwoj@gmail.com>
References: <20220822170150.2049490-1-prestwoj@gmail.com>
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

