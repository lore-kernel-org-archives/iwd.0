Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE179F1
	for <iwd@lists.linux.dev>; Fri,  4 Nov 2022 16:38:10 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id z26so4993682pff.1
        for <iwd@lists.linux.dev>; Fri, 04 Nov 2022 09:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paCJRibZ3ohngBpfrclV9n9vOU5JZSflIIqqHAN/jGs=;
        b=Pn7TuA9FV6Zp6risr87TZUJtgHvP3lly1eFtq8LMqbIEaDRpJRYTx6jkV+NxYXvRKQ
         Aka8rM2JJbDnweysRZ1iQJVwLL8y216OEEMtTawgpvAbS1gErv0DpmRjJ4/GGh4svKG9
         XsCpxtQ6rzGEjuQLfZjNF6zo3EeyjFYP9cq4AFoSOPStHaetJpBXt27v2Qhu6oHa7Rvg
         254jWWOK+ExdrMP9yklufXnRymPLOS1h78aVfEmxgoIsqohPq+HWv5StyfQIG5qmUUja
         eKmBu3a0zNxtyS1YKIuJG2fiNSPkDXkDziX8cvn7cUV33EaQsvIvHylc+kH1WOASvuWU
         vEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paCJRibZ3ohngBpfrclV9n9vOU5JZSflIIqqHAN/jGs=;
        b=MFN2uFR1Me7VZc5Yu6/gQJ6b3FaE/xl980mz5as2Uzy4OSThl44/OTzAPCBKvyG/ro
         4QMM9+zD90i6vjz5Kaa2KeEDMx/uWt8GX8QnaH6gLCW+aQmOCzvkH1gC6hvoKIYbu72L
         XCwqfLl9pPQ2a2tjCSLMvXMQON0K7g8Ux9RPe/tkNknR2l6Wr90L7GLlTHuSm5pJxJVw
         mRA0EP8K/ZM7WsOc7u/DQp87VcN1kuMi+wxsu+Y9r7k4+ECtJM9pg9MLr+42hmkiSjLl
         JQ9XRuQ65R8JhqLlcaT2S+k0OnD7xr/XIXmwHw1opA1CefwiGyBD2jokVco4Xtuk/wD4
         8hFg==
X-Gm-Message-State: ACrzQf1tVgG41w7cuBvQjSYAaoGAfYU4p50Ds9isjC6EI2BdBJ7FooHO
	NeP7hXz/B8xQ8YzZNuMqk1TrcrL++Ng=
X-Google-Smtp-Source: AMsMyM5CknRwnN2TSHqou7BRBZfUAOdzZ48LMm+lsYskFS0UrwP+WQYrm32laICu+37AM8NOXoQBng==
X-Received: by 2002:a62:4c2:0:b0:52e:bd4d:50e1 with SMTP id 185-20020a6204c2000000b0052ebd4d50e1mr37102956pfe.8.1667579890170;
        Fri, 04 Nov 2022 09:38:10 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 65-20020a620544000000b0056e15b7138esm2904741pff.157.2022.11.04.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:38:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/6] auto-t: update test to work with PairwiseCiphers array
Date: Fri,  4 Nov 2022 09:37:59 -0700
Message-Id: <20221104163800.451867-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221104163800.451867-1-prestwoj@gmail.com>
References: <20221104163800.451867-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testAP-no-support/connection_test.py | 2 +-
 autotests/testAP/connection_test.py            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/autotests/testAP-no-support/connection_test.py b/autotests/testAP-no-support/connection_test.py
index d7a13f51..47c06262 100644
--- a/autotests/testAP-no-support/connection_test.py
+++ b/autotests/testAP-no-support/connection_test.py
@@ -27,7 +27,7 @@ class Test(unittest.TestCase):
         dev_ap.start_ap('TestAP2', 'Password2')
 
         self.assertTrue(dev_ap.group_cipher == 'TKIP')
-        self.assertTrue(dev_ap.pairwise_ciphers == 'TKIP')
+        self.assertIn('TKIP', dev_ap.pairwise_ciphers)
 
         ordered_network = dev_sta.get_ordered_network('TestAP2')
 
diff --git a/autotests/testAP/connection_test.py b/autotests/testAP/connection_test.py
index 53dcfaba..a9135c26 100644
--- a/autotests/testAP/connection_test.py
+++ b/autotests/testAP/connection_test.py
@@ -60,7 +60,7 @@ class Test(unittest.TestCase):
                 dev1.start_ap('TestAP2')
 
                 self.assertTrue(dev1.group_cipher == group)
-                self.assertTrue(dev1.pairwise_ciphers == pairwise)
+                self.assertIn(pairwise, dev1.pairwise_ciphers)
 
                 try:
                     validate(wd, dev2, dev1, 'TestAP2', 'Password2', ip_checks=False)
-- 
2.34.3

