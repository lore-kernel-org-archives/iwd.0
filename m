Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBF031A98
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfttIBnG"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-66d09b6d007so48734716d6.1
        for <iwd@lists.linux.dev>; Wed, 08 Nov 2023 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699464128; x=1700068928; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALaZJ6XsrsPVtrQi96mwWume01S/yCvLr5bXcq2qj94=;
        b=SfttIBnGDbSieqUiKE0YQjcMt1zkGlfh6NbFNe/fy189GV4P7MY20c3UYCpv7cjphC
         bIUPXDjyzfrwWM8vBEBu6Q5aSkYL2yQD31v2lyHVYp3OQdXCIHy6uIltI35ZnmBs/P43
         s6IzWvCOZ5/fu7onumteDfOmhzgoLHpyxUseKvtZvR9NI9LA2FmZGSREHlgdci0U7ynK
         aamL5eCVEN/pJ7E+wEGHVBfnSpEn/dSy6hpvNUa0G1HvE1kaMFtUmdu8CMsYIwGXzDSC
         Ni9Y+7ABZkKVStzvyjywlMwfNCcdlH1bUL1gArB3vhuNLE93x+KNy9gycJbr56pLscMC
         /jqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464128; x=1700068928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALaZJ6XsrsPVtrQi96mwWume01S/yCvLr5bXcq2qj94=;
        b=V8KX7WP26VAuv9cSz0vY10PG/NAF3h7Hf4WR1i8u90DFrjhcp2yXfZ6jrBFaBxz39v
         kP0skls2tA0U/g5wTl1Do62a7sz+4rLdFGZctolPiG8al1H4gHlCELdCr8nK3QaKdd6l
         YN41jqHm9B43Lzf26NURsrV6t8zejzJA0fKR/CS7xsGoHd0sRbqp9lNUPDCjV7ikxK5b
         4o0AiXcXwj0PSyiKQhLqOe5tl+DK02fVYYrhyYD8QYMkFpuDs6E9sGy+rDMHJ6T3JcS+
         D2j4/OmKeitDMkPfJHS8uEPBjbeLzDCX6lw/oZWJ/DexufruqBF7mKEccqvuTVXfrRMe
         Ju/A==
X-Gm-Message-State: AOJu0Yzu7xmdCUE3wCgpioK4Q70OC/mvVybSwX+xPEv0vRrxjU/OaU/i
	5t7mm+2hYRlKtf5Gjlzc+I/aDvW452c=
X-Google-Smtp-Source: AGHT+IGmetNbzDXFZuaE0gtthCrha1bNkyquZOVoUlewKMMwtpEzAl8+MnHrpgufQVkG7wDQZLqJ/g==
X-Received: by 2002:a05:6214:1c8d:b0:65b:ed3:9a02 with SMTP id ib13-20020a0562141c8d00b0065b0ed39a02mr2560267qvb.17.1699464128031;
        Wed, 08 Nov 2023 09:22:08 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id qb1-20020ad44701000000b0065d03eae7a0sm1277003qvb.82.2023.11.08.09.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:22:07 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 08/10] auto-t: add utils for wpa_supplicant PKEX
Date: Wed,  8 Nov 2023 09:21:53 -0800
Message-Id: <20231108172155.2129509-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108172155.2129509-1-prestwoj@gmail.com>
References: <20231108172155.2129509-1-prestwoj@gmail.com>
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

