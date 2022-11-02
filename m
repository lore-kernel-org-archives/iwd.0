Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822B927734
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 22:51:47 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id k7so242120pll.6
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 15:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvB1DrUHh/GvKAhUP+CqVLQcsbSC2AW465JKkPFySTc=;
        b=E82Fc+/29F+UvRrDeVVcnp004Co3wNnJ0hTAlXvG3arNNt2UE8KwpRGIxz2XF6oCiJ
         3zSaHxIgNIkGOk6xvv4RVCKmWO22HYCBbJ1ellf8xS+NjU5fV9sYbTOJT6td/Yiw5Pi0
         mjjugaQbyxrDhauo52htk2jOYDSzK2mTW+Zsd9qwL0HRusRj5qlRhYUMG9VcWtd5RXQV
         5N8dcYWs2FsGP2yOTcreuTTQjkWrZ6fdinCpjOSg+nMHcQncY0B/5bLCE+FY+wYb/UtV
         yXf3hrsirMIR0dmi0trKVasEwACI7Q9oerhKcR92PQ4U85xoAPtbkYPldMnqposf03cf
         VZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvB1DrUHh/GvKAhUP+CqVLQcsbSC2AW465JKkPFySTc=;
        b=fLrY/xp8nx9kqfFMpwe1AMLy/+C7Qmo6JXFeOfAvSSkzbTP9qn2MnjiI0w3xYuRy5x
         OnWbVXNKKumjyfPGOP+7bxcVvAu8I8QMz2kjtveO9tQH63KFfNKU69igy4cEYD28aRvD
         +TdG0qr1eimmhTYyNHBprpMmUDjkpphk+Og6WSIxXPCwcBC5si1JIisvPH+iUN2Ib0q2
         8k3P8IrjddEUMVfwk90nuduiHEg3BlsLryIvvkQLNRT1dAN927hA1y9Ss84MbSMX+t79
         ImzHKpDIc1kpjVDkJg+7GcZ6AurC51MbwVTnz3wWYn2E1DR7NkWtws0cIM7R4fkTj38o
         kjwA==
X-Gm-Message-State: ACrzQf21losMSW0lTLFlhC/1hguI3XQFuSzFApTDijkeqOnGiOa188Eq
	LIcP0HYGixXBdH2/jzmQlqxUT05LsVQ=
X-Google-Smtp-Source: AMsMyM5mDn2g7oDxtmdVP3Q0nRpwsC1aEvq4GKfeMRAEzDYJozGNbfU1fkGCGra+z4Ra4JegktlnHw==
X-Received: by 2002:a17:90a:73ca:b0:213:c06c:7004 with SMTP id n10-20020a17090a73ca00b00213c06c7004mr23745888pjk.111.1667429506341;
        Wed, 02 Nov 2022 15:51:46 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b00186b945c0d1sm8920377plh.2.2022.11.02.15.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:51:45 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 10/11] auto-t: test AP fails to start with unsupported ciphers
Date: Wed,  2 Nov 2022 15:51:15 -0700
Message-Id: <20221102225116.297129-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102225116.297129-1-prestwoj@gmail.com>
References: <20221102225116.297129-1-prestwoj@gmail.com>
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

