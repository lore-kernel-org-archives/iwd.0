Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7181AB503
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724873083; cv=none; b=gu3cnDFn+kMPkjr5U82T9VsLctNyHLgcVVWCjc/P7UX8mCrzYiKYI89QUjwidv6aoW0pLB7E/BX2qP08LsnR6HaGLjPumFhnJbMhcbtfUMHR9u8vLUAb5rJtN/9QX9jiVsjXwSjhUyKDbQ+j4ttpeDHoLC+U/+KfgpSS8p09BdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724873083; c=relaxed/simple;
	bh=1pYxZdt/cb6QaZROUOt/UXNKrd4LBk55ZWX1Jek2/YY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PksMZuOQxm9jAoJnD/COVIMNEmOkQVDROxWcw9YM0DefJOB0+zVLU1HYnrKIrtEKClgwJ6MsPERth3oihlt93+EyzbySKQA+43OfbhLkvvWvRqNNUdTvMGOOk0zhgCyDoca+5DVeW63TgxnGBNnSW5xSHkfFjZfrR9CjNxCL4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1t4uJr1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1t4uJr1"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d60f48a2ccso5816295a91.3
        for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 12:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724873081; x=1725477881; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IFPs/YJKFaYy3RoCHH1SN5YV4xFWkPxPc6QvHkhBzc=;
        b=O1t4uJr13M9E5LWt3DntsuwesPpNt7CECTLJHN4Az+pXRoExlIAieaj+BYQehBLMEx
         v8wGSqU2rDpolnochH59GCowQI80AY2Hulja3m4bjvqxFrb7LNTyGa3n13e3h7/knfae
         5kP1zKZntq58KuU/R+FSzxGb8E2dLmePH8py/nA5ykK9BYO9dDiXEpqlln5gOWPL4Rtx
         ij+00FHZEk4pLrTK6ZwmHpQaWSR9co2ZMiAQWf/20PSpX58hCw2oqUfWAY2KC9QkdVmL
         bK7Ad4bqarbm6qzccl0uLJnSrqJKRi29iKvTjQvj5eN4dwC005ojG06iAcm+6hoBUMp/
         4+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724873081; x=1725477881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IFPs/YJKFaYy3RoCHH1SN5YV4xFWkPxPc6QvHkhBzc=;
        b=v+fM/N/q7AMJZ+BUb84o+5YBBSQylWMsy4KcA5XpWzpcfLEilw4NPqwBFk4aNotqLB
         V9q4r85cveZFEoFwwVkgU+OFPhbkJawMKC0H/UICRslOdR35BX9DDKo7DMjOLhJf+keV
         frnJeKP3P3dTJ8ujhb/5GnoJ21bl9TRcdThzdeqY/0mD9TccUCu42Pg1JE98lg7bgS9F
         jm+ch3wjx0X5bQjzbKu/Lmlcyegb69SZt24a6SvxRI10WL5wI6ph5eN0TVuxzX8vXQEQ
         BspTHT3jJsbcPvFrRiJxoXsLxac7+jGdYQp+2f81S7flzQzY+1yaxmvYNeZ+S+45JksG
         1tFg==
X-Gm-Message-State: AOJu0YxQKQZsN7FNzk3g1yeaZ1StNtZ9Rg1S4JIrOs51FYxRVZ7j8n/F
	IwFAGwJHXk7r16dh/WDgf6ZoWhiCrc6Awvwby2T9pqa9HTBtJ/0TUiCrAA==
X-Google-Smtp-Source: AGHT+IE9Y2E/xyiAMdE/RAkt8jy0CkKu1SPtN7bTaO5An6iGkvCunLf+H2U8Uxs++z4xE+iW2kuB0g==
X-Received: by 2002:a05:6a20:9f07:b0:1c4:bde5:174b with SMTP id adf61e73a8af0-1cce10fe079mr302873637.41.1724873080657;
        Wed, 28 Aug 2024 12:24:40 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm11081635a12.16.2024.08.28.12.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 12:24:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 5/6] auto-t: add affinities property for station, and extended_service_set
Date: Wed, 28 Aug 2024 12:24:27 -0700
Message-Id: <20240828192428.902761-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828192428.902761-1-prestwoj@gmail.com>
References: <20240828192428.902761-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/util/iwd.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 74bb25c0..83f2d9ef 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -596,6 +596,11 @@ class Device(IWDDBusAbstract):
         props = self._station_properties()
         return props.get('ConnectedNetwork')
 
+    @property
+    def connected_bss(self):
+        props = self._station_properties()
+        return props.get('ConnectedAccessPoint')
+
     @property
     def powered(self):
         '''
@@ -630,6 +635,19 @@ class Device(IWDDBusAbstract):
         self._station_debug._prop_proxy.Set(IWD_STATION_DEBUG_INTERFACE,
                                             'AutoConnect', value)
 
+    @property
+    def affinities(self):
+        return self._station_properties()['Affinities']
+
+    @affinities.setter
+    def affinities(self, values):
+        self._station_properties()
+        self._station_prop_if.Set(
+            IWD_STATION_INTERFACE, 'Affinities',
+            dbus.Array([dbus.ObjectPath(v) for v in values], signature="o"),
+            reply_handler=self._success, error_handler=self._failure)
+        self._wait_for_async_op()
+
     def scan(self, wait=True):
         '''Schedule a network scan.
 
-- 
2.34.1

