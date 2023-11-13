Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C7421112
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoRid039"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1cc5b6d6228so26200205ad.2
        for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 06:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699885979; x=1700490779; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV0AbZpVBxclK+PGuWIXys3CukqLAC5+K6IbFXVhmYw=;
        b=RoRid039JClaN92DI/uDQyr1dyR6eDzNLwZ8OWjWNcbf9JLxl37TsB+1QHKK5mxKi6
         OUJRV1CHcKX0gca8PpUINdI7PHKaVPjb8oeg4W4OhUUjIt/UyXRoW7eD9eY5SSPqmwdv
         T38Mk2p4geL4iGS3QRrEPMvTrJKhkyiXrzWEuLUuCKR4fQC0tdKUuBHJHKlAGGfMlSRU
         zzq/xekz4j+Rf595VmLocm+5TMbKqfQ6Mkpr5iWvfDMxNnED3sUYHVRYvIKbRDte4smM
         68oyiEPV4WdTc4D3l1YUwXTHTM9imKkghimvow0YMd/Aqmyk55h1HxHofPOPsUy8uid8
         VHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699885979; x=1700490779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mV0AbZpVBxclK+PGuWIXys3CukqLAC5+K6IbFXVhmYw=;
        b=nFmz12nJB5Cvkp+Xr8Kf4hAP9KZEAolsQ1teBoWkT1HcxGeLjyCbmOkS2mRpxrkxT8
         zEwFqVrMNY46brKWgUoRi8oadjHwDhNj2vilX0F8tApl7Ig6DpvenlebeASStLebLIkM
         SPWe82VQYXEiEl7eA9n/J1jLaxT+sIPVqxZwM0Kyzx1KkiACmjR2CYsZ+VfZdbG53Fgm
         Ho7yXpzu1IRosVBY+jDDpjFv86TtWl0En7ijLIsBSt7QXTVoZBX6n+d8JEEU7QGGjyzz
         a18hgyljQpzhrjCGi2ftcny2WfW0N2DyHssA5rUPmM8o9dl+8MMzPEmhne7UMnXy2hzt
         6bTg==
X-Gm-Message-State: AOJu0Yz1IjeQSujJP/6ELtZzzuD1VcI69mowOsZMTc8ThTkyZq0qadEk
	QeI+dX5BUFlG2nGSi85E4QwLh99JjPU=
X-Google-Smtp-Source: AGHT+IG2FO3oZJg4PrdKgEQ9krO8sKIDQ+zv0y8FZmodYi8MSQKVwnTx3IjZ2SaXlBvy7uIiqGFx6g==
X-Received: by 2002:a17:903:188:b0:1cc:474d:bdf9 with SMTP id z8-20020a170903018800b001cc474dbdf9mr5685005plg.36.1699885979457;
        Mon, 13 Nov 2023 06:32:59 -0800 (PST)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b001cc25cfec58sm4071496plg.226.2023.11.13.06.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 06:32:59 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] auto-t: add stop APIs and fix some issues wpas.py
Date: Mon, 13 Nov 2023 06:32:54 -0800
Message-Id: <20231113143255.278191-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231113143255.278191-1-prestwoj@gmail.com>
References: <20231113143255.278191-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - wait_for_event was returning a list in certain cases, not the
   event itself
 - The configurator ID was not being printed (',' instead of '%')
 - The DPP ID was not being properly waited for with PKEX
---
 autotests/util/wpas.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index eab08b43..0b127672 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -76,7 +76,7 @@ class Wpas:
 
         for e in self._rx_data:
             if event in e:
-                return self._rx_data
+                return e
 
         return False
 
@@ -281,7 +281,7 @@ class Wpas:
             self._dpp_conf_id = self.wait_for_result()
 
         if not uri:
-            print("DPP Configurator ID: %s", self._dpp_conf_id)
+            print("DPP Configurator ID: %s" % self._dpp_conf_id)
             return
 
         self._rx_data = []
@@ -315,6 +315,8 @@ class Wpas:
         self._rx_data = []
         self._ctrl_request(cmd)
         self._dpp_id = self.wait_for_result()
+        while not self._dpp_id.isnumeric():
+            self._dpp_id = self.wait_for_result()
 
     def dpp_pkex_add(self, code, identifier=None, version=None, initiator=False, role=None):
         cmd = f'DPP_PKEX_ADD own={self._dpp_id}'
@@ -336,10 +338,18 @@ class Wpas:
         self._rx_data = []
         self._ctrl_request(cmd)
 
+    def dpp_pkex_remove(self):
+        self._rx_data = []
+        self._ctrl_request("DPP_PKEX_REMOVE *")
+
     def dpp_listen(self, freq):
         self._rx_data = []
         self._ctrl_request(f'DPP_LISTEN {freq}')
 
+    def dpp_stop_listen(self):
+        self._rx_data = []
+        self._ctrl_request("DPP_STOP_LISTEN")
+
     def dpp_configurator_remove(self):
         self._ctrl_request('DPP_CONFIGURATOR_REMOVE *')
         self.wait_for_result()
-- 
2.25.1

