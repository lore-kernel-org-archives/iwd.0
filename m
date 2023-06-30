Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B691174FD
	for <iwd@lists.linux.dev>; Fri, 30 Jun 2023 19:18:32 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-636801fada1so903726d6.3
        for <iwd@lists.linux.dev>; Fri, 30 Jun 2023 12:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688152711; x=1690744711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDei+KWUeQlseIOW1TGzZsQ3J0SjooXdgJ7kGIIZq94=;
        b=YcO+yM5AciJX+1/LXH+gYs95mWzR/5f/CVts4HYdYGtTDPA0GBE1IeKnGzmHMFgCTE
         w1dyXSWUJ3KtKyBfu0bMOMu5hG39mnT6pBqt8K0X9pM2i83pCExtu0EIII6ssZNW8viQ
         o3T0uEUhIq9NienJcfF7ifmrAmM7+qIy9juevTwCUxz8v41z8rY9DtT4FSo9dVnBboGa
         b2X1GauOKydZCnMOjZZmn3u6sdXC7rifCSg+tkWWkFNES01Jx2BtrRmpPKx+MIoWyem3
         /fjLu63HXJDusFjkwe+pkfAZucRyWFqYhGT7uN5L07n6FGbYYhaHDHQ4KocVj7ZqW2MD
         AaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688152711; x=1690744711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDei+KWUeQlseIOW1TGzZsQ3J0SjooXdgJ7kGIIZq94=;
        b=gZgu29ouXwhq8ktt8hlujDAvelmAKIAP0Abc2nNSNQnV0WCj76IOr7JcyzuuMG1Dha
         VTc46+5PPbogelGvyksZNDu5/lr0s0CdoDxro8xQuFAWi1hAGpU6VsxEE+WhPN/HfN+a
         mVzNV+qwtNhHrmCdrzYFeM37Pp6rdgkHiuVriG3SGhXGnHDzu4pgNDhcEiI9Ur1EOl8Z
         x2to1u2g0x1rd6ac0gxDYoxUZbryL9OUrbnxXHfLYj4Amm165VjNvV9/dlMFujfz4h+E
         w7d/yov3ceYUiDnKmt0HaNfsnGzS76O06k79DDe48UDY7cofecFsuUGPyv2d3JNfMXt+
         nzUg==
X-Gm-Message-State: ABy/qLZfcxUm7EWIz1dGesx1iYu9gSbtF7rzmIC1e/yZ3dQoNqpHLnBI
	sGD3Y0SPIRoeizFnd+OMQeJVX06HQcs=
X-Google-Smtp-Source: APBJJlFv4MJphxsVfNTCFiwDR+H61uEzDKYJHhcdicZOjwe+c+Hsd05c9jJsrf10Mvq3s44six5QhA==
X-Received: by 2002:a05:6214:21a3:b0:62f:f894:9136 with SMTP id t3-20020a05621421a300b0062ff8949136mr3391167qvc.63.1688152710924;
        Fri, 30 Jun 2023 12:18:30 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id dr16-20020a05621408f000b00632209f7157sm8056605qvb.143.2023.06.30.12.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 12:18:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 5/5] module: temporary hack to allow for no module dependencies
Date: Fri, 30 Jun 2023 12:18:12 -0700
Message-Id: <20230630191812.2884637-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630191812.2884637-1-prestwoj@gmail.com>
References: <20230630191812.2884637-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module dependencies don't exist unless IWD_MODULE_DEPENDS
is used somewhere. For hwsim there is just a single module
(rules) so it will not compile. This needs a proper solution
but add a dummy dependency for now.
---
 src/module.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/module.c b/src/module.c
index f32190af..aee88bfb 100644
--- a/src/module.c
+++ b/src/module.c
@@ -120,6 +120,10 @@ int iwd_modules_init(void)
 		struct module *src;
 		struct module *dst;
 
+		if (!strcmp(dep->self, "dummy") &&
+				!strcmp(dep->target, "dummy"))
+			continue;
+
 		src = module_find(modules, n_modules, dep->self);
 		dst = module_find(modules, n_modules, dep->target);
 		if (!src || !dst) {
@@ -185,3 +189,5 @@ void iwd_modules_exit(void)
 	l_free(modules_sorted);
 	modules_sorted = NULL;
 }
+
+IWD_MODULE_DEPENDS(dummy, dummy);
-- 
2.25.1

