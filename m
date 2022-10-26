Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABD9259C
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 21:53:55 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so4161562pjc.3
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 14:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7st9qW31FDf+ggx8gFdUjDguopM1epMHnV4qlWoruaM=;
        b=QIkJLm2yfOT6YAbcuZ0S+SC+uFc4w2atEmFgfJaFGWgnZsHG9EzsuDJSpZPGSdmEi6
         FSFxtwzsvug969PHVxO83C0DQn7fYmhTjkUEVb6SjxLI2bM+1gIJNGQQtVRmOEVMmFb1
         opFY9ggNdMPDH/LS+oqeDiVLiBt41vsvpvaCE+LRtqkoJRdePeh8M60Pm9Yt5YJtBUOs
         7SAtSnRCE/xL5HDC3jF9h0dfiJPROXQhTi/LfTQpNd9e6LC1Wy3FVUKBdPy9IW+dzIKr
         qaquS0Jxim2qgl/56mMD8lJpvWvsjdEhDXgtqlMU1VTWSkgcaoaC+DyAs1bREsQYn4BH
         Q12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7st9qW31FDf+ggx8gFdUjDguopM1epMHnV4qlWoruaM=;
        b=T/6v4uOnGQOOaildeLv4Lx9fR/k8Oci7MsQjvJUC9KVSoe8pqMXyK51QPnV69Yj9Bt
         a7c0HNGaWMxI7vHZX4g8JEp9YXMIj2eJUgTNIa83wSnVEi1nXI6kSNom3ufd0xeVrQsy
         0kHDbBrunf8d41BW2ekPX6wAP3QCIAQISYu1rkVvnALhLTbjAUgwNARch7H4cnD2VZy5
         WbnkloHZmnT/EcQblQVETxPUHThh6F0QQSVn2WpKjS9w0FgLwxHHYWyoDAaaVkZGc5NF
         U1CxX/C0cc1k6u+DVq1fHYw5q8t72ybirQBLpldEp7UVwW8Ey0zN73VBvmLyXWm8RGah
         7S6g==
X-Gm-Message-State: ACrzQf3AzczQp85BK+fqhrhgPiAaJ1kKBra8K827y17ugiI+vLgEhLYG
	lMJ7Is0Lz6vuoDvNdwPkhhhPBa5E+Y8=
X-Google-Smtp-Source: AMsMyM4JOq/wMM98WZ9vOt3iz0D6DsK87Cayvl9Geb/Drpb+IndieDuwuhAYMttgAWxCZ6/+vxD2uw==
X-Received: by 2002:a17:902:d512:b0:181:f1f4:fcb4 with SMTP id b18-20020a170902d51200b00181f1f4fcb4mr46577018plg.102.1666821234890;
        Wed, 26 Oct 2022 14:53:54 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id d20-20020a170902b71400b0017b264a2d4asm3372471pls.44.2022.10.26.14.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:53:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: test AP mode using TKIP
Date: Wed, 26 Oct 2022 14:53:50 -0700
Message-Id: <20221026215350.506918-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221026215350.506918-1-prestwoj@gmail.com>
References: <20221026215350.506918-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This limits all supported ciphers to TKIP and verifies the AP
starts and can authenticate clients.
---
 .../testAP-no-support/connection_test.py      | 31 +++++++++++++++++--
 autotests/testAP-no-support/hw.conf           |  7 +++--
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/autotests/testAP-no-support/connection_test.py b/autotests/testAP-no-support/connection_test.py
index 1bbc0bde..9e5dccbb 100644
--- a/autotests/testAP-no-support/connection_test.py
+++ b/autotests/testAP-no-support/connection_test.py
@@ -5,17 +5,42 @@ import sys
 
 sys.path.append('../util')
 import iwd
-from iwd import IWD
+from iwd import IWD, NetworkType, PSKAgent
 
 class Test(unittest.TestCase):
-    def test_connection_success(self):
-        wd = IWD()
+    def test_no_ap_mode(self):
+        wd = IWD(True)
 
         dev = wd.list_devices(1)[0]
 
         with self.assertRaises(iwd.NotSupportedEx):
             dev.start_ap('TestAP2', 'Password2')
 
+    def test_only_tkip_support(self):
+        wd = IWD(True)
+
+        devices = wd.list_devices(2)
+
+        dev_sta = devices[0]
+        dev_ap = devices[1]
+
+        dev_ap.start_ap('TestAP2', 'Password2')
+
+        ordered_network = dev_sta.get_ordered_network('TestAP2')
+
+        if ordered_network.type != NetworkType.psk:
+            raise Exception("Network type mismatch")
+
+        psk_agent = PSKAgent('Password2')
+        wd.register_psk_agent(psk_agent)
+
+        ordered_network.network_object.connect()
+
+        condition = 'obj.state == DeviceState.connected'
+        wd.wait_for_object_condition(dev_sta, condition)
+
+        wd.unregister_psk_agent(psk_agent)
+
     @classmethod
     def setUpClass(cls):
         pass
diff --git a/autotests/testAP-no-support/hw.conf b/autotests/testAP-no-support/hw.conf
index 9df3b349..06a9d7c2 100644
--- a/autotests/testAP-no-support/hw.conf
+++ b/autotests/testAP-no-support/hw.conf
@@ -1,6 +1,9 @@
 [SETUP]
-num_radios=1
-radio_confs=rad0
+num_radios=2
+start_iwd=0
 
 [rad0]
 iftype_disable=ap
+
+[rad1]
+cipher_disable=ccmp,bip_cmac,gcmp,gcmp_256,ccmp_256,bip_gmac.bip_gmac_256,bip_cmac_256
-- 
2.34.3

