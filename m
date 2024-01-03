Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461131C6BB
	for <iwd@lists.linux.dev>; Wed,  3 Jan 2024 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz8i/qvA"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78104f6f692so54493185a.1
        for <iwd@lists.linux.dev>; Wed, 03 Jan 2024 10:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704307626; x=1704912426; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCXbcAh1i9ioyJsqIlaGZCwbC6Zh2xpFqHvGLQWTz9Y=;
        b=Bz8i/qvAsgKNGsDfjOioE4zEyzaUsdei63V/okw0ndYKH2IsNsdQjnsh+ZRgp3l6ql
         +/R3nz96A6DD3TTYHdqLRiWx+tUG5VSe9HUtY4UygLV1KwBith0IMmRjmoOVKMqdT3/G
         Uy6yGua1iQTO/0mv007QriEmoJNJ0YdhYJ6Vzou91qFTit4BlcyKIWXDYLyi6YRtxlrb
         jNsS5teU6sTyOm7Zrle2eQ5F45Kex8xrdkmn5W1c/96XPruRJ1UTL8ng7cS2bJmWIdCI
         HojZJrsgoy098d8yA8L3VnPXYB78NsqSQ/fKSw9JqaDRTaD3hFqJyJnn/ShlaLS2Dln6
         F/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307626; x=1704912426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCXbcAh1i9ioyJsqIlaGZCwbC6Zh2xpFqHvGLQWTz9Y=;
        b=YtdEx4xmp6t76M0em3WuJSMmdRbs7g5NiCDzeohEIqKYxonxeebPy8+IVZut8EUecR
         tALSJE4mY7kMtCyljEDTJoxzag1O6Y20+CFQQZ76CB+kw2sTUeJ54zKinX10ADmThQx7
         u/mvScQ0aYGz6rnlov/zM+QJUo8ULLzQsdLRHKt6iTrOTWk30E/LJRFRb9Okp8k5J3+z
         Y/4hA/soWpq+dvvOJzVnOxv24Vac9B9ozHpuldCgr3gOC11uqXIfVYnItZ9mzXFDQXju
         R5xpi1IIyqr1PVj3YnJoZw0mG319CZXuPmokQLPqmYpWxH/XtNGjsanP53GzeMm+OvZP
         BRrQ==
X-Gm-Message-State: AOJu0YyHt6o/audj8+maAn67Wb7PLzq2PwSKktAZVdMn6Z9lSpgE2Zw+
	Xax217IFcO4dDRAKhmmVOeP4ldmavC5t1Q==
X-Google-Smtp-Source: AGHT+IGNV07FCS0m98L6/RtNzGcKqQMx4OEk0Oy4+c4vj2iHfd7nM5H/cR2EDGCfqr6ks0yyHaIlhw==
X-Received: by 2002:a37:ac13:0:b0:781:5d82:1ec1 with SMTP id e19-20020a37ac13000000b007815d821ec1mr1877279qkm.28.1704307626023;
        Wed, 03 Jan 2024 10:47:06 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a22d500b00781a147e444sm3693370qki.92.2024.01.03.10.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:47:05 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/8] auto-t: fix random testPSK-roam failure
Date: Wed,  3 Jan 2024 10:46:38 -0800
Message-Id: <20240103184638.533221-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103184638.533221-1-prestwoj@gmail.com>
References: <20240103184638.533221-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was caused by the unused hostapd instance running after being
re-enabled by mistake. This cause an additional scan result with the
same rank to be seen which would then be connected to by luck of the
draw.
---
 autotests/testPSK-roam/connection_test.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/autotests/testPSK-roam/connection_test.py b/autotests/testPSK-roam/connection_test.py
index 2dbf1473..8d1658a8 100644
--- a/autotests/testPSK-roam/connection_test.py
+++ b/autotests/testPSK-roam/connection_test.py
@@ -144,9 +144,10 @@ class Test(unittest.TestCase):
         IWD.copy_to_storage('TestFT.psk')
 
         cls.bss_hostapd = [ HostapdCLI(config='ft-psk-ccmp-1.conf'),
-                            HostapdCLI(config='ft-psk-ccmp-2.conf'),
-                            HostapdCLI(config='ft-psk-ccmp-3.conf') ]
-        cls.bss_hostapd[2].disable()
+                            HostapdCLI(config='ft-psk-ccmp-2.conf') ]
+
+        unused = HostapdCLI(config='ft-psk-ccmp-3.conf')
+        unused.disable()
 
         rad0 = hwsim.get_radio('rad0')
         rad3 = hwsim.get_radio('rad3')
-- 
2.34.1

