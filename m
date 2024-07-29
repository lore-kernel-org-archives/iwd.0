Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B21487C4
	for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257066; cv=none; b=UgsdBHuyraoPCbr1wNfpdmE4o8d+p53Bb7BlmN4mOFbck8EXSt1FH/LfozFkufhhoOpi7SpOdi8IyjFCzz3svSaOgBzwfstFND8U3bmqcJBk3XzXVc9bUIhA6orzp2GVh5BLKYXP58L8jGJ0CPfxgqSj/apRHeX2mucqYQ6vShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257066; c=relaxed/simple;
	bh=9iGtdPtr4BaFIewmCRJ7Ffo6AV1x17P38NTxmT/5bVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ab0lgOx4BwfGqmd42CZD+zwbE3+Sy9VMkRyIaFXixqzfFQnqJWIqUnvc5u8R0VkQBJPTT3sqnz4kjn+DFm3qnoGZ2HkVlph16JCPvnOicFBsjxwwJFynrtWXH9uFbAjoQmmxBg6fzuzjF4MO+lMxqGx3SCB/domSqvW3kEv2mGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXmHN9Yk; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXmHN9Yk"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-651da7c1531so20143327b3.0
        for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 05:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722257063; x=1722861863; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YClqp2SLUvQWTsmINjHIaLn29oO+N0ThIyfHcw5AvNs=;
        b=DXmHN9YkXDJJcYzsT1Cwj2ONOC6h2l6e8Z/Px65XO2HcR49jiHFeXt6AI6gFC1My/R
         56aoWALeVqmIamoecq5aUVNk60AyAvylmD0w9srJ6XkgIrVKTdeXoQehQuWw4zpmqrsm
         77FcjpZxrxe6BsNUOmfZfSjQmCWVdJY9EBsmzXISljEkrblUGlJckh7T/byUq60ii7vm
         0UTwkmXk6bB9gvACW/3gHPjZty0zQsMZos7kQvVLqdAqmr+XUkKIVuASn0hP2xAmwj1R
         JIzU+g7uz4BpRp63M//1pt2P6ha9MRpdXxGONohJsHeA/7tDbpArHGS2SD4TFF+LAcYV
         z4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257063; x=1722861863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YClqp2SLUvQWTsmINjHIaLn29oO+N0ThIyfHcw5AvNs=;
        b=vejgUglnH4V+Rtm60o7B20JY8xyrK/pmVWGTWj3GBdsmM7N9g5USB1cvJx2lk8Cy0t
         pABKbjXp6hLOrPdj5OOu5y0X5N6o2cRNfs4iSp1hcAoVBn6ywXfvRKGNwYjTuj+e2qoW
         ED4SrSvtGrrXd1pxebRABH3YzladDAN+m1NN9Mj5zYAXy1NWF5q+g05GSqOSVROjkasg
         GqbAsqEGGMaWGbf1EhfzDr4pkjCWyIF73DbQ53UJEDqR3EceR6A8ert8FR/r1L+E286r
         mBQFQw2dX8KsEWzETMaj6t8CzOjorWkEb23jjsOTwuDT+RmKUHs1j9TFIdAj3OWj8BFa
         dBeg==
X-Gm-Message-State: AOJu0YyoWDY2RYpyjAT05nU9z+BuaxUrwALNmy2XuR5dVIbh/tpJXOTk
	p1ZOSazdvHYBAnTjs1vrL1G2xWtoV9dW5JZ08UHxNPzeJgLTvPhjpwuT8g==
X-Google-Smtp-Source: AGHT+IEFRzN7QsCMaZ9Wi3cgiYVFzkLzt3JRawJ6GbLaIFzYSg6mqMJXkF3G3xt5HphUJym28oHuVw==
X-Received: by 2002:a0d:d004:0:b0:62f:e5a7:5f05 with SMTP id 00721157ae682-67a06441dfbmr73789857b3.17.1722257063156;
        Mon, 29 Jul 2024 05:44:23 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d84edsm51171266d6.14.2024.07.29.05.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:44:22 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] auto-t: add set/unset affinity python methods
Date: Mon, 29 Jul 2024 05:44:09 -0700
Message-Id: <20240729124410.1763549-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729124410.1763549-1-prestwoj@gmail.com>
References: <20240729124410.1763549-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/util/iwd.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 1d4a5472..211f3777 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -940,6 +940,16 @@ class Device(IWDDBusAbstract):
 
         return ret
 
+    def set_connected_bss_affinity(self):
+        self._station.SetConnectedBssAffinity(reply_handler=self._success,
+                                        error_handler=self._failure)
+        self._wait_for_async_op()
+
+    def unset_connected_bss_affinity(self):
+        self._station.UnsetConnectedBssAffinity(reply_handler=self._success,
+                                        error_handler=self._failure)
+        self._wait_for_async_op()
+
     def __str__(self, prefix = ''):
         s = prefix + 'Device: ' + self.device_path + '\n'\
                + prefix + '\tName:\t\t' + self.name + '\n'\
-- 
2.34.1

