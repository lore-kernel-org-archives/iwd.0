Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66017B
	for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 18:06:01 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id jh14so89793plb.1
        for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+o1nLAtiA1ovow+LoyeteKJX/MfOtqjxXhBG/kg4zjk=;
        b=AQVwDY5WxEfM9KFDmOQTOQgSEMyqEw4dQ0T7/XYvhh5/KZyBnsBtCcFPWLEQyaZUJe
         kMWs/1IDtUwlM7Mmlg4nahIqwAQE0eqaVO0BQ8ihK4opceEP3tcTnYH+Ty/JEF+Uz5/+
         0mHeiLEq0UosFtMbLL4uOxaNS97luz5xrD6C0flto+m9/WehzNd7pB9b7Ax0BY4f/jet
         QvfvUo5U96HNLIbPsfBcbTX6hQ1Fbnnkn5kPJKOIbKMVHQOLrFcg/0osC+blSaUKnKby
         BOcii9qD1G0wTILARYLQkK4gEnOgnrHxdlRUv1W16vQ+iSFaEkqV8kSN1rwnMTKjfCnh
         2PHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+o1nLAtiA1ovow+LoyeteKJX/MfOtqjxXhBG/kg4zjk=;
        b=we0WWpZIvkJjzfTze5pyEztaGLIEICAjg6t1RyWNDM5vS208v1wreZFzB2Y9kLBtT3
         sQV//SaRJOOz9pVdKXeA0p6rxcuDMw53UWEi7S+8Ib9OHr4HzB31iA8Iy+AJKTo1FXpi
         AHiQvO5hY2UINxIlcUS8abAaiNWQG32/ChG9vqePaL1pVz0LLq8lRFdvLbpyWZruPkGt
         6GKBGws72c7uN+4sexZfxx9uIzv81iKuGCMVlwPGn3Sh+bGaxByxjmCAqvNMrzgask4Y
         fhU2aN8APQOInrhrjzY86ITCD2JjyzALr4ShePt3UFgQuvAkyiiipfZdNG2Y0iTJS6Tj
         Zh5w==
X-Gm-Message-State: AJIora+qNy+seQDTlwTMlN39AYJgn1nZsBr7PO1/4uXPq/Rb6Fzd+6S8
	UYLwIvG2lwYXacXb/8jo37ZVC5PJncA=
X-Google-Smtp-Source: AGRyM1ts2nRIQF/q/A3muVWe9X/+b3ognBuq59kOHBKTbZnNqY/U/HNYfB8PowNAqDeY9Zczw6Jveg==
X-Received: by 2002:a17:90b:1a8c:b0:1ed:1afb:7a73 with SMTP id ng12-20020a17090b1a8c00b001ed1afb7a73mr11811602pjb.144.1656612360655;
        Thu, 30 Jun 2022 11:06:00 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b00163ffe73300sm13777187plk.137.2022.06.30.11.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:06:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/7] auto-t: add client test to testKnownNetworks
Date: Thu, 30 Jun 2022 11:03:26 -0700
Message-Id: <20220630180331.206419-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630180331.206419-1-prestwoj@gmail.com>
References: <20220630180331.206419-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests iwctl functionality with known-networks command
---
 .../testKnownNetworks/known_network_test.py   | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/autotests/testKnownNetworks/known_network_test.py b/autotests/testKnownNetworks/known_network_test.py
index 2bdcc955..a383e5ff 100644
--- a/autotests/testKnownNetworks/known_network_test.py
+++ b/autotests/testKnownNetworks/known_network_test.py
@@ -2,10 +2,11 @@
 
 import unittest
 import sys
+import subprocess
 
 sys.path.append('../util')
-import iwd
 from iwd import IWD
+from config import ctx
 
 class Test(unittest.TestCase):
 
@@ -70,8 +71,26 @@ class Test(unittest.TestCase):
 
         self.list_removal_and_addition(wd)
 
+    def test_client_known_networks(self):
+        networks = ['Hotspot Network', 'ssidOpen', 'ssidTKIP', 'ssidEAP-TLS']
+        wd = IWD(True)
+
+        iwctl = ctx.start_process(['iwctl', 'known-networks', 'list'], check=True)
+
+        for n in networks:
+            self.assertIn(n, iwctl.out)
+
+        for n in networks:
+            ctx.start_process(['iwctl', 'known-networks', n, 'show'], check=True)
+
+        networks.remove('ssidOpen')
+        ctx.start_process(['iwctl', 'known-networks', 'ssidOpen', 'forget'], check=True)
+
+        with self.assertRaises(subprocess.CalledProcessError):
+            ctx.start_process(['iwctl', 'known-networks', 'ssidOpen', 'show'], check=True)
+
     @classmethod
-    def setUpClass(cls):
+    def setUp(self):
         IWD.copy_to_storage('known_networks/ssidOpen.open')
         IWD.copy_to_storage('known_networks/ssidTKIP.psk')
         IWD.copy_to_storage('known_networks/ssidEAP-TLS.8021x')
-- 
2.34.1

