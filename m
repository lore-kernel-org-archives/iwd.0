Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808376A326
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIfpAphe"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-67abd1879c0so16990456d6.2
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 09:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701798729; x=1702403529; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xwFQUTrHOLX7y/IAk/sto27WOQCKLdXHLGZNIDFn+M=;
        b=IIfpApheOeOwxfV9Y0E2WFSf0xDPlFuxVcPskZIUJXy2qnkLhqExbr2QpqSI0UcvGv
         lsj7wGLSaWJRPRyIf1OEKL3cMA9P14rgD4ESY/9yg/Mh/yhwYztDFOXV9B3BLELy3dnf
         akqIc3Hjv3pgCBGp0OnWWJoaMZPdv8BgKIz+XwIJeRGE+zevNL/P/HoO1piDgb191JPk
         P43wJydxWZJ9fGhNTKtSP/LJl1YPKO4Md2OVR96H72sM9z07ygi8vgtb7otiPQDQKtIU
         oag8lWc3ZAlNWAxM4hiQoDP9YS53z6GIK4Zusy71m5ZVpBYpQnbYvSvJlhrRx7MyDAPm
         /iyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701798729; x=1702403529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xwFQUTrHOLX7y/IAk/sto27WOQCKLdXHLGZNIDFn+M=;
        b=djnXTZa/H/xoEs0VZtE2Wq7LDfaPltAUKvQosMgLFOgA5VE+n70d5cFosjbuZ/BvHv
         CAnMOs8NKi/VCcaJB9/yWKW9mOFgwQG5xqn4jtvg35emTcsURULWj96PJX3sQLZGZYgL
         de2S+RApJpOwpFDzWhblECJPbH4pXRnKGnCCsbBYKv89TYtVtwqZ0Q+aEK98Q1mF3Vw7
         IcDZGln1ZeXP+cAvwULJ5hRUYr2ywyJVwvmu9ETjMIs+SjsWOzBPyDytJT70vNJ9QkiW
         AB8IEAJQlCn/i23ZI6ZMz6d1feRD4vJ1P1/6xV/E4NdcfNKpJc13Iqo6WDHVEknleRrp
         P++w==
X-Gm-Message-State: AOJu0Yy6DQ+oCmxtsaBkDso6teBof58pJFTXh8Wo4Mue/ytq27re1zuS
	gNTv+eQdffxPZe/AqEnq850LOQx4vGg=
X-Google-Smtp-Source: AGHT+IHSwobg0l968GglEi1kWNYGR0BsNZtyxeFXmmdGbz28QRsey52BrCbLx9h2SfBOJ1Ufbh5FOg==
X-Received: by 2002:a0c:f752:0:b0:67a:91cf:8347 with SMTP id e18-20020a0cf752000000b0067a91cf8347mr1793039qvo.47.1701798729190;
        Tue, 05 Dec 2023 09:52:09 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c7-20020a0ce147000000b0067ae01ab283sm192599qvl.36.2023.12.05.09.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 09:52:08 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] auto-t: add explicit stop() to IWD class
Date: Tue,  5 Dec 2023 09:52:01 -0800
Message-Id: <20231205175203.1935692-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If tests end in an unknown state it is sometimes required that IWD
be stopped manually in order for future tests to run. Add a stop()
method so test tearDown() methods can explicitly stop IWD.
---
 autotests/util/iwd.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 3f200beb..b1a57cab 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1363,6 +1363,10 @@ class IWD(AsyncOpAbstract):
 
         self.psk_agents = []
 
+    def stop(self):
+        if self.namespace.is_process_running('iwd'):
+            self._iwd_proc.kill()
+
     def __del__(self):
         for agent in self.psk_agents:
             self.unregister_psk_agent(agent)
-- 
2.34.1

