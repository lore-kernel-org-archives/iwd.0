Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8FB8465
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 17:00:56 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id i3so2162617pfc.11
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdB7I+XkRlGpC7TkkPgj49Yc/D3ExGTSZAYf7qlfNsE=;
        b=lCN6arh4Gv1bNesyRLlCIe4C4VeH8GXnAmccp/SgpJLboEcAsiuCM6fKQNwzgM9UiE
         j+4WktyMowfY13k+RXHOITjJKjNpWhslitdyWCQs9Xfu2SetElLHl8GYJeSqPYvD5o8d
         lKRmNE9zYg0/Thn0FqINi26njPJT50F51Ju0n28yRiWXx6FVdp+zis6tqLypu8eeNRQ6
         O1zMLUcpQsedCg24z3Y++wkH57cdT3aZqU2q4Kvc7aKdfIfhWr7tkL9RpZXP5JiBXxzq
         uNqC7NEVTFZKxZeMI1kc/Dq4dj1Tlbw+qkZHFy8TVrygi10fZVY0H2HYmLYJT3EUVDud
         8AMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdB7I+XkRlGpC7TkkPgj49Yc/D3ExGTSZAYf7qlfNsE=;
        b=vfj115TQ1O9bXJYffj8JdjhQxzYfOCwLW6iAPPaSNLPTHHOVGO1FneVzNwX44mHWiH
         vp+ZJhDkUeqbbrpOyP+K3F7oqDTr+Sa4+3iZQBVLqPz2onRhoIo9lwsbn7uJVcsHRMyQ
         wx5IS8yxsuKUhOAV+q7wylwQT7yVi495voeAiyYwyYP9AMY19F1xw1zeuVFgNvFAo4AE
         ZBTivr330EOv40nkNMhXPMHcGditJlwA8475IZllbDjLB8z47ZtcoHAk+r+gax4ud0cN
         cW7mDvF9Z9oir9r5Cgv2SOe2EDDcvY6h9j2vReoeYBgpENoG65l2nsjBGyA1i21pTnBX
         Gy1w==
X-Gm-Message-State: ACrzQf1OaVkvCmvgAIIuYJ8mGZAfcDz0QDxO5ZJ6yHpVUyy0qex1qfqK
	jxtLw/7GX/maWr7XUZBrHdWrrlZkYes=
X-Google-Smtp-Source: AMsMyM6T/rbnsjgWUCvisyS8MUaGAZS68d51wufjYmtq0ypswr0VRK46UH/YqYv7duCMe1uj5LhD4w==
X-Received: by 2002:a63:f047:0:b0:46e:b1d4:2a68 with SMTP id s7-20020a63f047000000b0046eb1d42a68mr26567991pgj.496.1667494855555;
        Thu, 03 Nov 2022 10:00:55 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z3-20020a623303000000b0056c349f5c70sm995465pfz.79.2022.11.03.10.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:00:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] auto-t: add test for scanning in AP mode
Date: Thu,  3 Nov 2022 10:00:50 -0700
Message-Id: <20221103170050.379587-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221103170050.379587-1-prestwoj@gmail.com>
References: <20221103170050.379587-1-prestwoj@gmail.com>
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

