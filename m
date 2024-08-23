Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A7E190482
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436026; cv=none; b=B7vbLWI1ttKkJTJBJYZVdZNUdqd3lTrXFddoJltjzlJfpn0KvkduRLd2PLKlldhdS9S19cN7S8qlHh0nxprU0wPOvPCPr+yJ1XOByZPO1fbpR+am7eMXBMVd/imSm3c56m7twfuo4KX/9iYHtc143541zaDlItNtVPwFE2YVRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436026; c=relaxed/simple;
	bh=1pYxZdt/cb6QaZROUOt/UXNKrd4LBk55ZWX1Jek2/YY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8/3L5AouJIaou/Ij9GVfRx+VEd6ZKc+yBznHVShz/CkkuvFOCLteiWXjTuFYuj1K3RyppCqmddreY8pbuU1QGHVWkI4QN+vVxJ0CBJWXNu4xHAqY8KNDAFz7tBW8hDk+1zd8tyqbXDSVJSZPlwGzHkd4IKV7OuSE+zJ8E/Wk1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpMyeRBs; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpMyeRBs"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44ff99fcd42so12890141cf.0
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724436023; x=1725040823; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IFPs/YJKFaYy3RoCHH1SN5YV4xFWkPxPc6QvHkhBzc=;
        b=DpMyeRBsb5uvdbjGw6vuCalGJ6uGg9u8/oQASvjDjR6b2FYvopdsHJ73x0b9xjZyNu
         fMh+TPKFJJ7vfFvyxWWiUApjjXKd+1pEuvPHIolzEhg7SN3xoyxkY32MbzLMlHX6cOP+
         32z5AZ+80Z5sm66LA9YVOnmRtT0KMo1+XFQM62ogJY3SQ7w/HEjYe7PGZR0qgcgFJ3Uq
         9UbXN4uFmt+FzWC++qQLAsS+FNYjaHBr9rMoe8+SQ4fRhOnpnScgFZpOfxmSdIN2h07o
         RMMxCNqMtp/UQkfftG9M3V/8if2IqxUQyyzN2sdtPYM51qrX/Td7zr1Y178LpFeSa/4k
         6LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724436023; x=1725040823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IFPs/YJKFaYy3RoCHH1SN5YV4xFWkPxPc6QvHkhBzc=;
        b=pkKJpY9xhK+DGleJ2FJCTOX2keLOM0U4fQMaQC0NCozDH8lAT+RSpL0pu7YmZezthS
         WmnXnU1AzM33/QhRAZmwL73GGCFdLxaHg9juN/KzGQ6bRfoA2yWSln3dhxxMFmEZ5e3F
         jDuvYhVO7Gk9u8Uepnik/ZaoGPNWqqkHihuzS1O4LPslo70Tc1lNPrDMGIeUV+S7BB41
         8mrHDSwWIU/9jnjhxSSyqFGrW8aKWrkPFcqyg5lM9GijOYsvaCt2ExKFuuLJ7W7NjYIw
         WpW045yYFfbiLxUxkFC+OBy/QuOoYYiSgdfnC5wzyHPao09VQ+5lyMJee1jgqSB5Y02p
         e6Xg==
X-Gm-Message-State: AOJu0YySzBk+C62oQ79awASkjuV2a8UvtDQeYWRPH11G2ntdRPk1pEFf
	BtOBBgefiyZEJhaQwk+8hOTSqsj/E2/NQ4vEyCZBTKQd7t8Ltaq2xnjU3Q==
X-Google-Smtp-Source: AGHT+IHUCRRfjwd4/fw6ckPLcS+CdaXTBVhM+TqfYQRtXv27L8ffL+OFfyS1H1mXMQyuVkPXEP5GHA==
X-Received: by 2002:a05:622a:1f96:b0:44f:5e2c:1631 with SMTP id d75a77b69052e-45509616d0emr39094211cf.17.1724436023318;
        Fri, 23 Aug 2024 11:00:23 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0f0507sm19683131cf.47.2024.08.23.11.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:00:22 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 7/8] auto-t: add affinities property for station, and extended_service_set
Date: Fri, 23 Aug 2024 11:00:05 -0700
Message-Id: <20240823180006.317353-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823180006.317353-1-prestwoj@gmail.com>
References: <20240823180006.317353-1-prestwoj@gmail.com>
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

