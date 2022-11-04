Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB49A79F1
	for <iwd@lists.linux.dev>; Fri,  4 Nov 2022 16:38:08 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so8725250pji.1
        for <iwd@lists.linux.dev>; Fri, 04 Nov 2022 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdB7I+XkRlGpC7TkkPgj49Yc/D3ExGTSZAYf7qlfNsE=;
        b=H69ro+fFA4QJ+o/urWmxKUQiWkNgOGhH79fKrstiZ0kDSwqqeYUAj5wauhGkNZUNZi
         i1jrmg2BnPNhjHMzQ+2fgoflgB72kHyv5IBtEuhshZi49PerVTzWz1nyXbWSu9cx7htA
         xrLIpCmlaiVBzA/khRCXyjH0AVNrUsrDfn90HMUg7kWuhGjPBTbTWpC9MEIQ5+GDYdP5
         P4xWFLxciLnYTJ47OkiSAwavD5qViOLkwfWskBrMS36qebLF0GBBnwJZcNbvZXa/U4/0
         oSux7CKsPB0rPTDCtoGatK0D4qmP3wtS8KHggdB9Md1pumTlPhObD7sU+wqvtSCeFMJO
         p6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdB7I+XkRlGpC7TkkPgj49Yc/D3ExGTSZAYf7qlfNsE=;
        b=m0NA68c0z4JNb8fMlTdanR7JEknIQhmXrKfue04adl9as/W2sijz2miEWmpysdiKJr
         9fjXog0TU1CNlKiLikz3a91Lw0fgQt87Lelv5p/I+AukipQMxgG0XFXPqD+1eg22UCfo
         h7R/YQrj61bF2GUbUUThR9HDXTKgGSn5ZEiAG3TqjA9tZ7b/OoOL1txoKrifYwce0oaS
         3QNApKb9BtyB0GDlXGU7EQEm+hNxt/GsOl3DsXmuvxhV2caMPnnirUvcDdQfgXAfVbrH
         CtcJB/TJ5D1SPCWgTWY+cVTjAHNGo/jlx+6bX8+goWqN1BAT67LYYCp1iC/nwgh239gu
         K2nQ==
X-Gm-Message-State: ACrzQf2D9W98VkNChbKulYJB81StyQNBo/Uz/jJZIWgjzBGGhcDiMCtk
	NcB6PVxJh57z+Atgv86PLGa8/Vc6p4Y=
X-Google-Smtp-Source: AMsMyM5QT3CSZ4QgwT70p1TPui1zuiylGbstM6S1jubQNvt//BKu/picTzwXxFlZvSDn78XmgMge1w==
X-Received: by 2002:a17:902:7446:b0:186:a3a1:782d with SMTP id e6-20020a170902744600b00186a3a1782dmr36424272plt.76.1667579888152;
        Fri, 04 Nov 2022 09:38:08 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 65-20020a620544000000b0056e15b7138esm2904741pff.157.2022.11.04.09.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:38:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/6] auto-t: add test for scanning in AP mode
Date: Fri,  4 Nov 2022 09:37:57 -0700
Message-Id: <20221104163800.451867-3-prestwoj@gmail.com>
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

