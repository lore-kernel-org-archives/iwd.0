Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E6B21D42
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:18:01 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id f9so14401699pgj.2
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58dB+qVRHEvq+U/Mvya6dUNz1H4AZw05my/Hpz5EGXI=;
        b=WLo0N6w4gnTodw4jab5xlJf+voHzJpn/etj8roc9AN/Wwz18hw1eZEodoQMCV/xL/B
         2M95m6eVqO5BEcDUePCpzfgkw/EpNfTGmcXyfhT7+5AvVlbyGhrugWKZu5m58hp/yovz
         A0S8FrpiOlJ1NcelT2spsYgjfHetZBfdNxYwy/S8cp+9/S+pA337fB45soFMUpO5FI7G
         uWs2zSbNcAHeV+Mp0vlGU25CDnQLM1Y9owLc171TE1Aq/ECBtxWAaHTfIg8prd7rM2GP
         /5d8vzuaygbjQtidn4KBrA1QXrnyuxSoiq+a4KljfzUPoEAjgkQU5R2xB1co/EtfDgMC
         N1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58dB+qVRHEvq+U/Mvya6dUNz1H4AZw05my/Hpz5EGXI=;
        b=JxBRwTZIxS/5i9hpchiZHUZM5mAQxHtOiONdro5u4tawuxDAXvLcn/RloC/lqWEN1u
         gLO7sB8FWaAkkxEmWTQqrvIBTyPO2uw4SjExj5StRuH9Z+i9c+Akfs4zwp+uST+t9iFy
         EriwdK55SZf8pwvdAcIfaV7gk/2w4CvI+2ZF+zspD6/xOmvsJgefoUQiz/W9wswj/gA0
         QlO2shTGn0ACo/anPzofhW3KoHs+lM0TQ5z3y3XBegNEDVacbQFMH9V59u8lNBGbBkfT
         pBXreeIsXaBVCx1NQGXAyiys1cQi9zv3vfsdBzGwg27u10AScdGXZHupziJt90IWgV/y
         jhAw==
X-Gm-Message-State: ACrzQf38fHLX0kHxVLVIPW2OmjfoBs9245hLUhJRzY40cldcvW4n6yue
	vHLDiJGJdchO20N165Q8lKxj7Sr+0K4=
X-Google-Smtp-Source: AMsMyM4ZsUs3f1WXGsnDi8JBwU6/rV7/UXqLEzJkhixxtO2KqF9a22FOBwhC41o9pyS4dhoo2oPHdw==
X-Received: by 2002:a63:1861:0:b0:462:4961:9a8f with SMTP id 33-20020a631861000000b0046249619a8fmr18845334pgy.372.1667333881118;
        Tue, 01 Nov 2022 13:18:01 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:18:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 11/17] auto-t: test AP fails to start with unsupported ciphers
Date: Tue,  1 Nov 2022 13:17:41 -0700
Message-Id: <20221101201747.143379-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
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
 autotests/testAP-no-support/connection_test.py | 12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)
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
index 9e5dccbb..e4cb40b5 100644
--- a/autotests/testAP-no-support/connection_test.py
+++ b/autotests/testAP-no-support/connection_test.py
@@ -41,9 +41,19 @@ class Test(unittest.TestCase):
 
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

