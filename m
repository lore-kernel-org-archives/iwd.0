Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2072770A
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:53:43 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id z26so4347805pff.1
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 13:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvB1DrUHh/GvKAhUP+CqVLQcsbSC2AW465JKkPFySTc=;
        b=pDvZLUQFVyF/YuituGlId9H6jiNjPFbes82PXr9+xh3iFGAMG9LXvCYmgMHUAwQpBg
         i2OPOBGREfnUsxXULkJDRDwuyw8vr3IiuHnynRq+LpN1jSdQuNtDCGp2UL6jrSjhPcfr
         A2+fWXavje9oP7vEqDm00pRlSTW7RWBDmNbb3lO88lGoNRbnHvXuacc4y9ADdF/m9P7y
         W3N3aWZZYh9b+mCmIRWJWUIniaMcQMTB1T+L2ujkmTFtDG5dbC0r5awUucMDDLNlbmwG
         7NKaCm6Rj4IhVsGR2Ctl4pBZuanpsvORrktuu9umBnDbuSSvo0+U1mhNcAQ93IK4Xa3b
         OC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvB1DrUHh/GvKAhUP+CqVLQcsbSC2AW465JKkPFySTc=;
        b=bCz9zg7pKQh85wLRtP2bEpBIGoO5hbZRmq+Zk8/THrTZgvXawqz+fbHiAE/QR3wDdQ
         KSEK/dNQPjOO4i2T2S7dbC2uHJQB5LDBGRqYJyVUnrb8erY2x7lwb49vEj9W9AtiOOhW
         dXIIpfKN17Mu/IkXw0JgM3tfi7OkneoFR8IM3PM9k97H69U0IpjWA7fMiYJzQiq14dSM
         8lztaiZJUBKlsUWb6c/ajNOo6LlXn/grTQiVm8gadboOoWR0dsfsBwixzfkn4nuE8Rt1
         bpyOhA0mML4r7xGkMpa5/b5z1j6EHFcvth+oxR3QIyxf3pHq7vbn2YYYigCZdvjX7oin
         ZpVA==
X-Gm-Message-State: ACrzQf2qqaq/kbOAjvOJGHE8h5SNSCiwCA8SOiRLB7Ivp/Yyh7vqJEMQ
	kFVwxIGGm0gJrBLZZU9iYtaW6bzZg1U=
X-Google-Smtp-Source: AMsMyM6GCIwBluZLsWeJPZcH1MQa4bE3hASAotE63EoYu43AM06xLLUopimkBzCPipWvDo1VrySnXA==
X-Received: by 2002:a63:591c:0:b0:464:bb3b:d1ad with SMTP id n28-20020a63591c000000b00464bb3bd1admr23234759pgb.146.1667422423014;
        Wed, 02 Nov 2022 13:53:43 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm8730755plb.26.2022.11.02.13.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:53:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 09/10] auto-t: test AP fails to start with unsupported ciphers
Date: Wed,  2 Nov 2022 13:53:26 -0700
Message-Id: <20221102205327.268693-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102205327.268693-1-prestwoj@gmail.com>
References: <20221102205327.268693-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the profile lists unsupported ciphers it should fail to start with
NotSupported.
---
 autotests/testAP-no-support/TestAP2.ap         |  3 +++
 autotests/testAP-no-support/connection_test.py | 15 ++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 autotests/testAP-no-support/TestAP2.ap

diff --git a/autotests/testAP-no-support/TestAP2.ap b/autotests/testAP-no-support/TestAP2.ap
new file mode 100644
index 00000000..32a242ea
--- /dev/null
+++ b/autotests/testAP-no-support/TestAP2.ap
@@ -0,0 +1,3 @@
+[Security]
+Passphrase=secret123
+PairwiseCiphers=CCMP
diff --git a/autotests/testAP-no-support/connection_test.py b/autotests/testAP-no-support/connection_test.py
index 9e5dccbb..d7a13f51 100644
--- a/autotests/testAP-no-support/connection_test.py
+++ b/autotests/testAP-no-support/connection_test.py
@@ -26,6 +26,9 @@ class Test(unittest.TestCase):
 
         dev_ap.start_ap('TestAP2', 'Password2')
 
+        self.assertTrue(dev_ap.group_cipher == 'TKIP')
+        self.assertTrue(dev_ap.pairwise_ciphers == 'TKIP')
+
         ordered_network = dev_sta.get_ordered_network('TestAP2')
 
         if ordered_network.type != NetworkType.psk:
@@ -41,9 +44,19 @@ class Test(unittest.TestCase):
 
         wd.unregister_psk_agent(psk_agent)
 
+    def test_no_ccmp_support(self):
+        wd = IWD(True)
+
+        dev = wd.list_devices(2)[1]
+
+        # Should fail to start since the radio doesn't support CCMP but the
+        # profile only lists CCMP as allowed.
+        with self.assertRaises(iwd.NotSupportedEx):
+            dev.start_ap('TestAP2')
+
     @classmethod
     def setUpClass(cls):
-        pass
+        IWD.copy_to_ap('TestAP2.ap')
 
     @classmethod
     def tearDownClass(cls):
-- 
2.34.3

