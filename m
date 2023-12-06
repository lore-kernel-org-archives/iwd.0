Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B347F5B
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfuxFzTX"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ce32821a53so202448b3a.0
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 12:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893887; x=1702498687; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xwFQUTrHOLX7y/IAk/sto27WOQCKLdXHLGZNIDFn+M=;
        b=AfuxFzTXcPlHSzXbTq+XsWVhF9ot5jWOVFLFv4OEf88LLBmiciRDpVlp+sHY6IZ6Lq
         lwLxD05owrW7jJQ6+fZM0Fe2AxGhd4nqgWclkbUCHSidUe6xtET7G6h59cxZuldY0lmd
         ptsnoy40wVWXx1KJFZEmqNiKB0+q05KNJHFQ8LotKwylYdN0KaX7xrkqcdEVB0YEgcwa
         KDEe9bYPGF74L0YxxoHKLAWb1bidQU5wYnyoe9tzFxMteluRcAqyO7ZVq0cy7gbJ5k82
         kxfayDfLE7jwdCbvbPs5P/DJjXREMfofk5VuCdneEZE8DgMKMIM080pZl6SdfMCnyAIB
         4n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893887; x=1702498687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xwFQUTrHOLX7y/IAk/sto27WOQCKLdXHLGZNIDFn+M=;
        b=Nqi+SKVHeHpdHveiKU9gu7RdZaM0RNheWoPMZzdIJdilCY4yQnTdFw/TYnWVUwJlTT
         PDPXqRSZH8c5XMaCCa+yCLs7vc0deSQNWwc25jI/vAkxLo1Ze9pJq2DcJVRAdxk3GaD0
         9aQ2vRxLKD66rJbryPgV+71vOWaNE94aconMt8m63SQUAY0L3jV8QMQZ7WtZLjtjTm8/
         Xqsr7DoftJsxmhuHmw7/z2SnvbqWGMnzRuAj3Wn3aRsgwBh9luQY9bSjrzuXo2ivQKjG
         xuWNojuvvjTcjfgIMW3qzM8Tqmz4vjRyIpCn1X43Ch3998vvOHGmis87R3qikArr01ZQ
         hWFg==
X-Gm-Message-State: AOJu0YwOtw1NykDKDJfAVPU4Nr0+thACrzJWkXkPgD4niqqOg1+KXNf9
	4umMnwk3iz5gyk0R8p+Lw3joahJmLMKSXg==
X-Google-Smtp-Source: AGHT+IH2YaoJuGaSa1EmoyHRhKc6RxNzYqVwH2HCrWxvY8SvqEDl5zYRHvJAoEwNMwdq1Pi6dc6USg==
X-Received: by 2002:a05:6a20:748d:b0:180:d33d:9256 with SMTP id p13-20020a056a20748d00b00180d33d9256mr1445109pzd.58.1701893887302;
        Wed, 06 Dec 2023 12:18:07 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id by40-20020a056a0205a800b005c2185be2basm243168pgb.54.2023.12.06.12.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:18:07 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 01/13] auto-t: add explicit stop() to IWD class
Date: Wed,  6 Dec 2023 12:17:50 -0800
Message-Id: <20231206201802.2139649-1-prestwoj@gmail.com>
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

