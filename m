Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD463A0
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 17:31:02 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id k5so2311319pjo.5
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdB7I+XkRlGpC7TkkPgj49Yc/D3ExGTSZAYf7qlfNsE=;
        b=nFYYIwWKja44LgmHh7fYQk35X0xhqqVpTeF3ED3j6hQVQ8Y7/LwUapRPsXftepQSf0
         srFkokKCVA4dFRS/HGYtdwl4G32nNVAf3Aml9S/eWVwAbn1QSwMl0kRqjZNwJv02UAzd
         +WLq/M2SjN7RzUtbTuiU0cdkdi6EVOinlZzZrz2KqUJeWRQ0q5mjVxS3fOYHR72Qz9Qn
         bGGlINo5TNALr2Q78pkGZ/64TFdXEG8FwHSoD7LRvuiLy9Gce41lm2bvBVbJSER0ddWD
         TK2BsjTh5BIjgup1oY1pKSrpvzofeEO/vgIQ0tRkri+g8MY1Nzzfptp+AY+JVeVHYBEi
         82BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdB7I+XkRlGpC7TkkPgj49Yc/D3ExGTSZAYf7qlfNsE=;
        b=l/akad2DvoCnRMf8eFjo/cdH/yoLi+3+p+4tjOqBbt6ls/L/5CDoh+b4Rhh0v6C3TD
         4BiMD8YPCkUcH8DRaR30bSN15PKrVm8/z/eQTl+OkJ7sSK2XTPvNG44SiM8FWeK+EgoH
         seAZ3IZdTEQ2M2bU6Pn81gmiYHbicN54xDYjLqkqrdqSBIdeYTeYlr0cSMU8vf6GGexO
         9w17GE3PNE/xOpXOE7N91IwCEfU7gOL8u0KPA+7EgZdDsvx/iRtCzEbMsRGk+JCC1ypA
         VLke40cXX9isn/cA7AZmD4/iOvJufFKYXw0+jMFBl5fkenBbkYTWRMXUOkbJ80gTKMRu
         ComA==
X-Gm-Message-State: ACrzQf08TkkF9/ZJi02hajbAL6ckTmG8NRyPrqIRg7NmESlQnfgLM/V2
	76X1wwguGJ0ws7Nx+iD9yukRY5GH+B0=
X-Google-Smtp-Source: AMsMyM7c6HF399QHX3rXDnxcf2CHPtck5zjnK2dk9y9hG2YyBiwzotJIuYdKrRgvJ06IkLXntvgvxg==
X-Received: by 2002:a17:90a:24b:b0:213:9da2:5c98 with SMTP id t11-20020a17090a024b00b002139da25c98mr32595292pje.123.1667496661685;
        Thu, 03 Nov 2022 10:31:01 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id k18-20020aa79d12000000b0056afd55722asm979721pfp.153.2022.11.03.10.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:31:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] auto-t: add test for scanning in AP mode
Date: Thu,  3 Nov 2022 10:30:57 -0700
Message-Id: <20221103173057.381232-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221103173057.381232-1-prestwoj@gmail.com>
References: <20221103173057.381232-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testAP/scan_test.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 autotests/testAP/scan_test.py

diff --git a/autotests/testAP/scan_test.py b/autotests/testAP/scan_test.py
new file mode 100644
index 00000000..0935912c
--- /dev/null
+++ b/autotests/testAP/scan_test.py
@@ -0,0 +1,20 @@
+#! /usr/bin/python3
+
+import unittest
+
+from iwd import IWD
+
+class Test(unittest.TestCase):
+    def test_ap_scan(self):
+        wd = IWD(True)
+
+        dev = wd.list_devices(1)[0]
+
+        dev.start_ap('TestAP2', 'Password2')
+
+        dev.scan()
+
+        networks = dev.get_ordered_networks()
+
+        self.assertTrue(len(networks) == 1)
+        self.assertTrue(networks[0]['Name'] == 'TestAP1')
-- 
2.34.3

