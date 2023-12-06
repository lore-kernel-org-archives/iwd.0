Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881C53EA88
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpFoQJtl"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-77d6f853ba0so75265985a.0
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 07:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875234; x=1702480034; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xwFQUTrHOLX7y/IAk/sto27WOQCKLdXHLGZNIDFn+M=;
        b=UpFoQJtl1MLZ2AM5jy+eVbTnxi7/atX61r4Qg9tB6YDXj2oVgL9ScdzOWQkZD2LFwa
         89ODQY9aGjddLoU04b+vPxoKNkFxGPnMdtXU6nvAIFKenksIfytD0bj1eT91LMFGPqM4
         kafzflac4ejRok5WqfaoE5SQX1i5cKey6bicKkmC3yxFWW4OOtvnSPFJYnoncrJju3YU
         4Q3i68FQ//CZljXuTjsvUTTWhILPEzANLRBdmDTd6goRla8DX3TFZYtN7iD6Xmftn8No
         HybPScbxVjeIU3WGP+Qucpf+AifFR3BenS/AVtfjRy7w+/UsjC2n9dmf1xrugG/2zIsp
         UvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875234; x=1702480034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xwFQUTrHOLX7y/IAk/sto27WOQCKLdXHLGZNIDFn+M=;
        b=GmY5ADodBzeY2GwHsQC35yznYXkchCQujRqDzjcwybdjcQbd9LYGUggja5NB94jLhk
         nBbK4huCg7bfuNWH2peLrom/OMpevwDNgAzp9ORHoh9uO5ShGQE5eEP4vzLhiKASwFzo
         +Dr+L+gszJw6LcCrJ4TV4c6hRGiEZnFI9aE2iOO/Gyb6NutqIcH1BJw6PrPOrO4BNiO4
         JqBcrIDApIxzjorG1bjU3b3mttfTQFPw/Oyf/T7QbV46jw4JHjCfQYqsGVOmaGyill5T
         ZhFlXasNm1YsILfHpzH5VzCEkNhLyhKqYnAN5NNB1Yy3KFJH3H6x5/twBhq4l85CUg3q
         wIYA==
X-Gm-Message-State: AOJu0YyjVzQY6lgiwrVJzdn+7V50XI2zClAKVNXRFBL7sxRMgee4wn+h
	+0Auwwru0zO1wNt61StpoMx0N8bHB5c=
X-Google-Smtp-Source: AGHT+IEwo4k6J4bKIEe9qx9L/TIGF/qO8dAkSFVeH976a7oxMC6OdlIYnFDILDUexltuXoEIXvoMkA==
X-Received: by 2002:a05:620a:4387:b0:77f:be1:7fe7 with SMTP id a7-20020a05620a438700b0077f0be17fe7mr1516676qkp.45.1701875234183;
        Wed, 06 Dec 2023 07:07:14 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id vy22-20020a05620a491600b0077d66277e9asm11506qkn.116.2023.12.06.07.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:07:13 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/9] auto-t: add explicit stop() to IWD class
Date: Wed,  6 Dec 2023 07:07:00 -0800
Message-Id: <20231206150708.2080336-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206150708.2080336-1-prestwoj@gmail.com>
References: <20231206150708.2080336-1-prestwoj@gmail.com>
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

