Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173573CCE3
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWPHg/Mn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1c9a1762b43so11703555ad.1
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140932; x=1697745732; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALaZJ6XsrsPVtrQi96mwWume01S/yCvLr5bXcq2qj94=;
        b=EWPHg/MnqqaAsmdHwe/zTTlpM1uS5MzCwSvIR06PqdbCYYhSYiecWRVwl9kC0rJK5r
         j1M8eUTiCFjq9034JXYMpQutXp5CsOAvZcV/UAXYyGGK0V2j/8Hm3xjtV6bbkr2RQTaa
         nZ/6vn4GFORMGTb4YnGUUtRT9AGnTghNdJf57HxMsDHHf7wLD/vOwPvDk0CZX5Jx6Ioc
         UX2iFObmutwJ6vHWGukSfCpecJ8/015rtGjmvt+14bVGopqJ7zR8FoUhRwv96YdEvKZc
         yCS71Sy+FZPiiEQH2dLzdEoiHvzNSumKEYNFYONMgZrOshiIVEEGiI++teioNhr7g/Ph
         wVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140932; x=1697745732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALaZJ6XsrsPVtrQi96mwWume01S/yCvLr5bXcq2qj94=;
        b=sB3/KfEPKfTVCKFr393+slVUQjBxJ+9srrB99GFKAlVfm/cH8cpol6Hfv6VUTzgYtX
         NyI6QRS7XQiPNafHXBsLadKYANuLIJIYFyAyLVeKOcLxrspuFhHewAZkzuLLV2b//MxF
         2BvCyXKzjaCd3EBfPYpqwWZdKcveaMBlemUWjT27pyiPEDQ4VSjooK+JkFMFMz3vN9Sh
         x0m7rFFq2rzQDwIbQ3OalCMWm3BQqgM9gzmGfhOQm2E+8ueu9e2ZOwx9GRBxg+oHzH3x
         xmwEPwXIFRYlyT1XPzJ4UGEdRZozJsAieKZaBw5qNAzcjUJxbguE3Cknzax5Za7NHT9u
         ZFjA==
X-Gm-Message-State: AOJu0Yx47hYsmEP1wPZMoQaN3EcQ/ZJZZllC/O+sbkFz2iesCM0y7t5m
	jVZ0WzgfQDxIY7XLiuAoelND9ycX8R8=
X-Google-Smtp-Source: AGHT+IGNosKOkGGHIl94H1GGzUgytQMUucY79fAcOFc4Tu4X8r/n+W/ufE3pL0bm0J27oMKyRuMYcQ==
X-Received: by 2002:a17:902:f543:b0:1c7:2740:cfb3 with SMTP id h3-20020a170902f54300b001c72740cfb3mr31939591plf.35.1697140932351;
        Thu, 12 Oct 2023 13:02:12 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 19/21] auto-t: add utils for wpa_supplicant PKEX
Date: Thu, 12 Oct 2023 13:01:48 -0700
Message-Id: <20231012200150.338401-20-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012200150.338401-1-prestwoj@gmail.com>
References: <20231012200150.338401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/util/wpas.py | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index 442f0dce..eab08b43 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -273,13 +273,17 @@ class Wpas:
 
         return self._dpp_uri
 
-    def dpp_configurator_create(self, uri):
+    def dpp_configurator_create(self, uri=None):
         self._rx_data = []
         self._ctrl_request('DPP_CONFIGURATOR_ADD')
         self._dpp_conf_id = self.wait_for_result()
         while not self._dpp_conf_id.isnumeric():
             self._dpp_conf_id = self.wait_for_result()
 
+        if not uri:
+            print("DPP Configurator ID: %s", self._dpp_conf_id)
+            return
+
         self._rx_data = []
         self._ctrl_request('DPP_QR_CODE ' + uri)
         self._dpp_qr_id = self.wait_for_result()
@@ -302,6 +306,40 @@ class Wpas:
         self.wait_for_event('DPP-AUTH-SUCCESS', timeout=30)
         self.wait_for_event('DPP-CONF-SENT')
 
+    def dpp_bootstrap_gen(self, type='qrcode', curve=None):
+        cmd = f'DPP_BOOTSTRAP_GEN type={type}'
+
+        if curve:
+            cmd += f' curve={curve}'
+
+        self._rx_data = []
+        self._ctrl_request(cmd)
+        self._dpp_id = self.wait_for_result()
+
+    def dpp_pkex_add(self, code, identifier=None, version=None, initiator=False, role=None):
+        cmd = f'DPP_PKEX_ADD own={self._dpp_id}'
+
+        if identifier:
+            cmd += f' identifier={identifier}'
+
+        if initiator:
+            cmd += f' init=1'
+
+        if version:
+            cmd += f' ver={version}'
+
+        if role:
+            cmd += f' role={role}'
+
+        cmd += f' code={code}'
+
+        self._rx_data = []
+        self._ctrl_request(cmd)
+
+    def dpp_listen(self, freq):
+        self._rx_data = []
+        self._ctrl_request(f'DPP_LISTEN {freq}')
+
     def dpp_configurator_remove(self):
         self._ctrl_request('DPP_CONFIGURATOR_REMOVE *')
         self.wait_for_result()
-- 
2.25.1

