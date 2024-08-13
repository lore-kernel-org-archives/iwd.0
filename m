Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D81A08A6
	for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564618; cv=none; b=RoCjkrNHkZWLiG3RmBS+pjwtd+CfLqNkCuMvatWBSUomtqRog6UfH9L6voZtFP+Z2UGwvmCcrzJ19M4u6siyjz8u7sXHvIDw8savAeX9Yk9BX4ncd4mReuLSD52s4z7fu+gF2+okiNZ5ecCEvPyHdYm3jA+Aem5hgGd8M3iQfMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564618; c=relaxed/simple;
	bh=S7B1UY64GhhBoY5OYyxIuuHzhi17S4KHnBxHinDFk4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vqr+6bpr7BfrFTMoWe1fEiw7vEm9EEoFw3TTdl/gf/oqPaNlAyOSNR6FEDnVpxwcO5/uaQBPtgo6o1jzMFJa2DNdFk7wLH/HGZNS7k0YKb3DgTfpJJ4UPS7trtaJMMsRrox5qMXqpfyqg2ChFSsFMUTNN3Vy5jNSkS4MHOkOjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dm2E60hR; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm2E60hR"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b7a36f26f3so56282436d6.1
        for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723564616; x=1724169416; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEYzwptQH/JXy4XblJrkhba6Q4l40LpTRB3Fi0c6YWE=;
        b=dm2E60hRmjjzU8CHysrU1QqRUPy4HejFWgTsRHS/Ymtn7aUecr7R8ckig0A9wq8GW2
         2iuKr1oivOELZoIcVzqvBZg6Ww7XCdUzb56Emp1riJPYYgYRTjKXFBYQaLMsPTRxbKyU
         Np9c3De6f2Kpj2h/qGR7j8mB21+Pb5QQWvBj/Os/mEdnGj0cWc8Bem7XnbTA0+SMoTO7
         CTKiLdrwt1W6LOfdGHi5gEYLTYtb/bxlHnb7jzrAhoYygFvLKC1dhsYaMD7pep8DqteL
         JyQzzX6b9Nq63ETACt2lbXSukc/EfgzLrjgWY4NU+ahTPLjIphTJkdUSdFRI16gFnJYo
         +d1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564616; x=1724169416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEYzwptQH/JXy4XblJrkhba6Q4l40LpTRB3Fi0c6YWE=;
        b=STVh1FDVOk10qBJjvzuVSRS8mVTZsFfH/EvpzNcfSZ2FVQYGEvbaKYV1MWb9roBsgZ
         d540y1xVYnzTz7+5JKjNZLbz2ICWx8StElSXH29VvAcf52cnkwlPbLmcAHXJ9bB1j9bs
         7MWeGPApsTivGERq1hQ9ZVxeBBcn1oM8H3GAmiPVrRq2SIx0aJcXok5k1n/Rl04soSzz
         MjinDg4a10M+CmjeALVKQApgHCK5qxmi2zYGyevz8H6Qj3RzzZ8ohz0BhL1uoWL2reZP
         pclvXbBjJQagBbgKhqjOBpJFE6LTt7jG+my1dMBiSAifUhurQrpoKvx/P5MfLhQZ2BHB
         k8XA==
X-Gm-Message-State: AOJu0YzGGSp4Wj4ceE/NEoPJoHD6mS/6KPSHpO13cXCrhbbsbwqMSraj
	vj21fI1mc5wPT2uPfiTfdyBl0IpFz2mwmDTWtK9IlNiyab9a2n1AIUMIAw==
X-Google-Smtp-Source: AGHT+IFKJkY5ypN9QC/BqOf6x04AkFpUh5Cot8E+0h+FkETpcmXAc40QnWf3xYCseZY9TFLf/4EAiw==
X-Received: by 2002:a05:6214:5f01:b0:6b4:e21c:d46f with SMTP id 6a1803df08f44-6bf5cc326d9mr1871366d6.27.1723564615859;
        Tue, 13 Aug 2024 08:56:55 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca2024sm35825706d6.72.2024.08.13.08.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:56:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/9] auto-t: add affinities property for station, and extended_service_set
Date: Tue, 13 Aug 2024 08:56:37 -0700
Message-Id: <20240813155638.74987-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813155638.74987-1-prestwoj@gmail.com>
References: <20240813155638.74987-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/util/iwd.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 1d4a5472..83f2d9ef 100755
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
 
@@ -975,6 +993,10 @@ class Network(IWDDBusAbstract):
         '''
         return bool(self._properties['Connected'])
 
+    @property
+    def extended_service_set(self):
+        return self._properties['ExtendedServiceSet']
+
     def connect(self, wait=True):
         '''
             Connect to the network. Request the device implied by the object
-- 
2.34.1

